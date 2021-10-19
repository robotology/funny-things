const exec = require('node-exec-promise').exec;
const {forEach, forEachSeries, filter} = require('p-iteration')
const electron = require('electron');
const process = require('process');
const path = require('path');
const fs = require('fs');

const { remote } = window.require('electron')
const dialog = electron.remote.dialog;

const scriptPath = process.env.ELECTRON_ENV === "development" ? path.join(__dirname, '../script') : path.join(process.resourcesPath, 'script');


let actionBlockParameters = {}

let counter = 0;
let labelIdCounter= 0;


const createActionDiv = (text, color) => {

    let actionDiv = createElement('div', {
        classes: ['panel-item'],
        backgroundColor: color,
        activity: text
    })

    let actionDivText = createElement('span', {
        text
    })

    actionDiv.appendChild(actionDivText)

    return actionDiv
}

const addActivityDiv = (activity, modify_array = true) => {
    if (modify_array) {
        addActivity(activity);
    }

    let actionDiv = createActionDiv(actionBlockParameters[activity].text, actionBlockParameters[activity].color);
    actionDiv.setAttribute('draggable', true);
    actionDiv.addEventListener("dragstart", moveAction);

    let runAction = createElement('img', {
        classes: ["run-action", "icon"],
        src: "assets/run-no-circle.svg",
        onClick: (event)=>{runSingleAction(activitiesToPerform[findChildIndex(findPanelItem(event.target))], findChildIndex(findPanelItem(event.target)))}
    })

    actionDiv.appendChild(runAction);

    if (OPTIONS.hasOwnProperty(activity)) {
        let options = createElement('img', {
            classes: ["options", "icon"],
            src: "assets/options.svg",
            shouldExpand: true,
            onClick: (event)=>{expandOrCloseOptions(event, activity)}
        })
        actionDiv.appendChild(options)
    }

    let remove = createElement('img', {
        classes: ["remove", "icon"],
        src: "assets/close.svg",
        onClick: removeActivityDiv
    })

    let optionsDiv = createElement('div', {
        classes: ["act-options"],
    })

    actionDiv.appendChild(optionsDiv)
    actionDiv.appendChild(remove)

    myActivitesPanel.appendChild(actionDiv);
}

const removeActivityDiv = (event) => {
    let node = findPanelItem(event.target);
    let indexToRemove = findChildIndex(node);
    removeActivity(indexToRemove)
    let parent = node.parentNode;
    parent.removeChild(node);
}

Object.keys(ACTIONS).map((actionsKey) => {
    let actionColorKeys = Object.keys(ACTIONCOLORS);
    actionBlockParameters[actionsKey] = {
        text: ACTIONS[actionsKey],
        color: ACTIONCOLORS[counter]
    }
    counter += 1
    if (counter >= ACTIONCOLORS.length) {
        counter = 0
    }
}) // actionBlockParameters = { TALK = {text: "Talk", color: "purple"}, [...] }

const allActivitesPanel = document.querySelector(".left-panel");
const myActivitesPanel = document.querySelector(".right-panel");
const runButton = document.querySelector("#run");
const clearButton = document.querySelector("#clear");
const errorMessage = document.querySelector(".popup");

for (let action in actionBlockParameters) {
    let actionDiv = createActionDiv(actionBlockParameters[action].text, actionBlockParameters[action].color);
    actionDiv.onclick = ()=>{addActivityDiv(action)};
    allActivitesPanel.appendChild(actionDiv);
}

let draggedItem;

const moveAction = (event) => {
    draggedItem = event.target
}

document.addEventListener("drop", function(event) {
    let target = event.target
    if (myActivitesPanel.contains(target) && myActivitesPanel != target) {
        let dropTarget = findPanelItem(target)
        let indexOfDropTarget = findChildIndex(dropTarget, myActivitesPanel);
        let indexOfDraggedItem = findChildIndex(draggedItem, myActivitesPanel);

        repositionActivity(indexOfDraggedItem, indexOfDropTarget)

        myActivitesPanel.innerHTML = ''

        for (let activity of activitiesToPerform) {
            addActivityDiv(activity.activity, false)
        }
    }
})

document.addEventListener("dragenter", function(event) {
    event.preventDefault()
})

document.addEventListener("dragover", function(event) {
    event.preventDefault()
})

const runSingleAction = async (activity, activityIndex) => {
    let arrayOfPanelItems = Array.from(myActivitesPanel.children);
    let bashActions = generateBashAction(activity);

    runButton.disabled = true;
    clearButton.disabled = true;

    await forEachSeries(bashActions, async (bashAction) => {
        if (!(bashAction.includes("wait"))) {
            arrayOfPanelItems.forEach((panelItem, index) => {
                if (index == activityIndex) {
                    panelItem.classList.remove('low-light')
                } else {
                    panelItem.classList.add('low-light')
                }
            })
        }
        await exec(`${path.join(scriptPath, 'funnythings.sh')} ${bashAction}`)
    })
    arrayOfPanelItems.forEach((panelItem) => {
        panelItem.classList.remove('low-light')
    })
    runButton.disabled = false;
    clearButton.disabled = false;
}

const expandOrCloseOptions = (event, activity) => {
    if (event.target.shouldExpand == true) {
        let actionDiv = findPanelItem(event.target)
        let activityIndex = findChildIndex(actionDiv)
        let optionsDiv = actionDiv.querySelector(".act-options")
        let optionsTemplate = OPTIONS[activity]
        let specificOptions = activitiesToPerform[activityIndex].options
        optionsDiv.style.minHeight = `${30* specificOptions.length}px`
        actionDiv.style.minHeight = `${50 + 30* specificOptions.length}px`

        optionsTemplate.forEach((optionTemplate, index) => {
            let optionItem = specificOptions[index]

            let optionDiv = createElement('div', {
                maxHeight: 25
            })

            let label = createElement('span', {
                text: optionTemplate.label
            })

            optionDiv.appendChild(label)

            switch (optionTemplate.type) {
                case 'string':

                    let input = createElement('input', {
                        type: 'text',
                        defaultValue: optionItem.value,
                        onChange: (event)=>{changeActivityValue(activityIndex, index, event.target.value)}
                    })

                    optionDiv.appendChild(input)
                    break;
                case 'select':

                    optionTemplate.options.forEach((radioOption) => {
                        let radioDOMOptions = {
                            type: 'radio',
                            value: radioOption,
                            name: `${optionTemplate.label}${labelIdCounter}`,
                            onClick: (event)=>{changeActivityValue(activityIndex, index, event.target.value)}
                        }
                        if (radioOption == optionItem.value) {
                            radioDOMOptions.checked = true
                        }
                        let input = createElement('input', radioDOMOptions)
                        optionDiv.appendChild(input)

                        let inputLabel = createElement('span', {
                            text: radioOption
                        })
                        optionDiv.appendChild(inputLabel)
                    })

                    labelIdCounter += 1
                    break
                case 'dropdown':
                    let dropdown = createElement('select', {
                        name: `${optionTemplate.label}${labelIdCounter}`
                    })

                    optionTemplate.options.forEach((dropdownOption) => {
                        let dropdownDOMOption = createElement('option', {
                            value: dropdownOption
                        })
                        if (dropdownDOMOption.value == optionItem.value) {
                            dropdownDOMOption.selected = true
                        }
                        dropdownDOMOption.innerHTML = dropdownOption
                        dropdown.appendChild(dropdownDOMOption)
                    })

                    dropdown.addEventListener('change', (event) => {changeActivityValue(activityIndex, index, event.target.value)})

                    optionDiv.appendChild(dropdown)
                    break
                case 'float':
                    let numberInput = createElement('input', {
                        type: 'number',
                        defaultValue: optionItem.value,
                        onChange: (event)=>{changeActivityValue(activityIndex, index, event.target.value)}
                    })
                    optionDiv.appendChild(numberInput)
                    break
            }

            optionsDiv.appendChild(optionDiv)
            })
    } else {
        let actionDiv = findPanelItem(event.target)
        let optionsDiv = actionDiv.querySelector(".act-options")
        optionsDiv.innerHTML = ''
        optionsDiv.style.minHeight = 'fit-content'
        actionDiv.style.minHeight = '50px';
    }
    event.target.shouldExpand = !event.target.shouldExpand
}

const closeOptions = (event, activity) => {
    let actionDiv = findPanelItem(event.target)
    let optionsDiv = actionDiv.querySelector(".act-options")
    optionsDiv.innerHTML = ''
    optionsDiv.style.minHeight = 'fit-content'
}

const generateBashAction = (activity) => {
    let bashActions = [];
    if (activity.activity == "SLEEP"){
        bashActions.push(`sleep ${activity.options[0].value}`);
      }
      if (activity.activity == "SPEAK"){
          //for await (let options of activity.options) {​
          activity.options.forEach((options) => {
          //activity.options.forEach(async(options) => {
            if (options.label == "Text:")
            {
              let cmd = options.value
              bashActions.push(`${activity.activity.toLowerCase()} \"${cmd}\"`);
            }
            if (options.label == "Wait until finish:")
            {
              let cmd_wait = options.value
              if (cmd_wait == "Yes")
              {
                bashActions.push(`speak_wait`);
              }
            }
          })
        }

        if (activity.activity == "WAVE"){
          let cmd = `hello_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
                let cmd_wait = `hello_wait_${activity.options[0].value.toLowerCase()}`
                bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "MUSCLES"){
          let cmd = `show_muscles_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `show_muscles_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "GESTURE"){
          let cmd = `gesture_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `gesture_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "QUESTION"){
          let cmd = `question_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `question_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "GREET"){
          let cmd = `greet_thumb_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `greet_thumb_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "POINTARM"){
          let cmd = `point_arm_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `point_wait_arm`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "POINTEYE"){
          let cmd = `point_eye_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `point_wait_eye`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "POINTEARS"){
            bashActions.push('point_ears')
            if (activity.options[0].label == "Wait until finished:")
            {
              let wait_val = activity.options[0].value
              if (wait_val == "Yes")
              {
                let cmd_wait = `point_wait_ears`
                bashActions.push(cmd_wait);
              }
            }
          }

        if (activity.activity == "HOME"){
          let cmd = `home_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `home_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "VICTORY"){
          let arm = `victory_${activity.options[0].value.toLowerCase()}`
          bashActions.push(arm);
          if (activity.options[1].label == "Wait until finished:")
          {
            let wait_val = activity.options[1].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `victory_wait_${activity.options[0].value.toLowerCase()}`
              bashActions.push(cmd_wait);
            }
          }
        }

        if (activity.activity == "EMOTION"){
          let emotion = activity.options[0].value.toLowerCase()
          bashActions.push(emotion);
        }

        if (activity.activity == "FONZIE"){
          bashActions.push('fonzie')
          if (activity.options[0].label == "Wait until finished:")
          {
            let wait_val = activity.options[0].value
            if (wait_val == "Yes")
            {
              let cmd_wait = `fonzie_wait`
              bashActions.push(cmd_wait);
            }
          }
        }
        if (activity.activity == "GAZETYPE"){
          let cmd = `gaze_${activity.options[0].value.toLowerCase()}`
          bashActions.push(cmd);
          console.log(cmd)
        }

        if (activity.activity == "GAZELOOK"){
          let cmd = `gaze \"look ${activity.options[0].value.toLowerCase()} ${activity.options[1].value.toLowerCase()} ${activity.options[2].value.toLowerCase()}\"`
          bashActions.push(cmd);
          console.log(cmd)
        }

        if (activity.activity == "BALANCE"){
            bashActions.push('balancing')
            if (activity.options[0].label == "Wait until finished:")
            {
              let wait_val = activity.options[0].value
              if (wait_val == "Yes")
              {
                let cmd_wait = `balancing_wait`
                bashActions.push(cmd_wait);
              }
            }
          }

        return bashActions;
}
/*
if (activity.activity == "SPEAK"){
    //for await (let options of activity.options) {​
    activity.options.forEach((options) => {
    //activity.options.forEach(async(options) => {
      if (options.label == "Text:")
      {
        let cmd = options.value
        bashActions.push(`${activity.activity.toLowerCase()} \"${cmd}\"`);
      }
      if (options.label == "Wait until finish:")
      {
        let cmd_wait = options.value
        if (cmd_wait == "Yes")
        {
          bashActions.push(`speak_wait`);
        }
      }
    })
  }*/

const generateBashActionsArray = (activities) => {
    let bashActionsArray = [];
    activities.forEach((activity) => {
          let bashAction = generateBashAction(activity)
          bashActionsArray = [...bashActionsArray, ...bashAction]
    });
    return bashActionsArray;
}

const runDemo = async() => {
    run = true;
    let actionCounter = 0;
    let arrayOfPanelItems = Array.from(myActivitesPanel.children);
    let bashActions = generateBashActionsArray(activitiesToPerform);

    runButton.disabled = true;
    clearButton.disabled = true;

    await forEachSeries(bashActions, async (bashAction) => {
        if (!(bashAction.includes("wait"))) {
            arrayOfPanelItems.forEach((panelItem, index) => {
                if (index == actionCounter) {
                    panelItem.classList.remove('low-light')
                } else {
                    panelItem.classList.add('low-light')
                }
            })
            actionCounter += 1;
        }
        if (run) {
          let out = await exec(`${path.join(scriptPath, 'funnythings.sh')} ${bashAction}`)
          console.log(out.stdout, out.stderr);
        }
    })

    arrayOfPanelItems.forEach((panelItem) => {
        panelItem.classList.remove('low-light')
    })
    runButton.disabled = false;
    clearButton.disabled = false;
}

const stopDemo = () => {
    run = false
}


const clearAll = () => {
    clearActivities()
    myActivitesPanel.innerHTML = ''
}

const generateFullFilename = (filename) => {
    let filenameArray = filename.split('.');
    if (filenameArray.length == 1 || filenameArray[filenameArray.length - 1] !== 'funnythings') {
        return filename + '.funnythings'
    } else {
        return filename
    }
}

const exportActivities = () => {
    saveTextFile(JSON.stringify(activitiesToPerform, null, 2),
    'Save your activites',
    path.join(process.env.HOME, 'mydemo.funnythings'),
    'Save',
    'Funny Things Demos',
    ['funnythings'])
}

const importActivities = () => {
    dialog.showOpenDialog(remote.getCurrentWindow(),{
        properties: ['openFile'],
        buttonLabel: 'Load',
        defaultPath: process.env.HOME,
        filters: [
            {
                name: 'Funny Things Demos',
                extensions: ['funnythings']
            }
        ]
    }).then(file => {
        if (!file.canceled) {
            fs.readFile(file.filePaths.toString(), 'utf8', (err, data) => {
                if (err) throw err;
                let parsedData;
                let isValidJson = true;
                try {
                    parsedData = JSON.parse(data);
                } catch(err) {
                    isValidJson = false;
                }

                if (isValidJson && checkActivites(parsedData)) {
                    activitiesToPerform = parsedData;
                    console.log('Imported!')
                    myActivitesPanel.innerHTML = ''
                    for (let activity of activitiesToPerform) {
                        addActivityDiv(activity.activity, false)
                    }
                } else {
                    errorMessage.classList.toggle('displayable');
                    setTimeout( () => {
                        errorMessage.classList.toggle('invisible');
                    }, 100);
                    setTimeout( () => {
                        errorMessage.classList.toggle('invisible');
                    }, 2600);
                    setTimeout( () => {
                        errorMessage.classList.toggle('displayable');
                    }, 4000);
                }
            });
        }
    }).catch(err => {
        console.log(err)
    })
}

const saveTextFile = (textContent, title, defaultPath, buttonLabel, filterName, extensions) => {
    dialog.showSaveDialog(remote.getCurrentWindow(),{
        title,
        defaultPath,
        buttonLabel,
        filters: [
            {
                name: filterName,
                extensions
            }
        ]
    }).then(file => {
        if (!file.canceled) {
            fs.writeFile(file.filePath.toString(), textContent, function (err) {
                if (err) throw err;
                console.log('Saved!')
            })
        }
        return file
    }).then(file => {
        if (!file.canceled && extensions.includes('sh')) {
            alert(`Run your script by typing: \n ${file.filePath.toString()} runDemo`);
        }
    }).catch(err => {
        console.log(err)
    })
}

const bashExporter = ()=>{
    let newFunnyThingScriptContent;
    let actionsArray = generateBashActionsArray(activitiesToPerform);
    fs.readFile(path.join(scriptPath, 'funnythings_template.sh'), 'utf8', (err, data) => {
        newFunnyThingScriptContent = data;

        newFunnyThingScriptContent += "\n"
        newFunnyThingScriptContent += "runDemo() { \n"
        actionsArray.forEach((action) => {
            newFunnyThingScriptContent += "  " + action + '\n'
        })
        newFunnyThingScriptContent += "} "
        console.log(path.join(scriptPath, 'funnythings_main_template.sh'))
        fs.readFile(path.join(scriptPath, 'funnythings_main_template.sh'), 'utf8', (mainErr, mainData) => {
            newFunnyThingScriptContent += mainData;

            saveTextFile(newFunnyThingScriptContent,
                'Save your bash script',
                path.join(process.env.HOME, 'mydemo.sh'),
                'Save',
                'Shell scripts',
                ['sh']);
        })

    })
}
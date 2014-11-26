---
layout: post
title: Internal Model Principle (IMP)
subtitle: A sample post with images and formulas (and some notes on the IMP thing).
author: Alessandro Roncone
tags: [theory, unrelated, sample post]
header-bg: abstracts/abstract-12.jpg
---

## Abstract

The concept of internal models plays a crucial role in regulator problems. The internal model principle can intuitively be expressed as:

> Accurate control can be achieved only if the control system encapsulates, either implicitly or explicitly, some representation of the process to be controlled.

As a reference, this [pdf](http://www.cds.caltech.edu/~murray/courses/cds101/fa02/caltech/astrom-ch5.pdf) was my starting point.

##1. Introduction

If the control scheme has been developed based on an exact model of the process, then perfect control is possible.
Let's consider a simplified closed-loop system (Figure 1).

{% include image.html url="closed-loop_controlsystem.svg" description="Figure 1: block diagram of a closed-loop system." style="width: 60%;" %}

It is called a system with pure error feedback, in which all control actions are based on feedback from the error `e(s)` only. In the diagram, `d(s)` is an unknown disturbance affecting the system.


$$
Y = \frac{C(s)P(s)}{1+C(s)P(s)} \cdot r + \frac{P(s)}{1+C(s)P(s)} \cdot d = \mathbf{T(s)}\cdot r + \mathbf{S(s)} \cdot d
$$

* $S(s) = \frac{P(s)}{1+C(s)P(s)}$ is called the __load disturbance sensitivity function__: it relates the external inputs `r(s)` and `d(s)` to the feedback error `e(s)`. It plays and important role in judging the performance of the controller because it also describes the effects of the disturbance `d(s)` on the controlled output `y(s)`. To achieve good disturbance rejection, `S(s)` should be as small as possible. We should design the controller `C(s)` such that `S(s)` will be as close as possible to 0. [^1]
* $T(s) = \frac{C(s)P(s)}{1+C(s)P(s)}$ is called the __complementary sensitivity function__ .

## 2. Real-world application: the gaze stabilizer

The setup presented in Figure 1 can be easily applied to the gazeStabilizer module we deployed for the iCub humanoid robot.

### 2.1 The problem

### 2.2 System identification

## 3. Results





[^1]: What is normally used is the __sensitivity function__ , usually referred as $\frac{1}{1+C(s)P(s)}$, but the model we're employing in this example slightly differs from the one usually depicted in control theory lessons, in which the disturbance is placed after the plant. Under this assumption, the _load disturbance sensitivity function_ is more useful than the standard _sensitivity function_.
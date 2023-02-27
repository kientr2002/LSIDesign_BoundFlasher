# Bound flasher

## Introduction

This repo contains implementation (admittedly not great) of the required bound flasher module.

Images will be put into the folder `image`

## Interface

| Signal | Width | In/out | Description |
| --- | --- | --- | --- |
| clk | 1 | Input | Provide clock (positive edge-triggered) |
| reset_n | 1 | Input | Provide asynchronous reset signal (active-low) |
| flick | 1 | Input | Control counting sequence of the module |
| light | 16 | Output | Output for the light (active-high) |

## Internal implementation

### Block diagram

![Block diagram for BoundFlasher module, with the FSM expanded. Note that D-FF and UpDownCounter both have clock and asynchronous reset signal (active-low) but the internal wire are not draw for clarity sake.](image/block_diagram.png)

The general idea of the module is that a FSM will control a up/down counter (with enable signal) to
count the current number of lights that are supposed to be turn on. The counter output will be
processed by a output decoder (light pattern decoder) to give the correct signal.

Within FSM, the enable and upcount (up/down count control) is generated from the `next_state` and
current `counter_val` input. Since the output state can be changed with both current state and
input, this is a Mealy state machine.

### State machine (of the FSM module)

![State diagram of the FSM control module, unlisted condition implies holding the current state](image/state_diagram.png)

The machine have 11 state, listed:

- STATE_START: Starting state of the machine

- STATE_UP_1_5: Stage 1 of the machine

- STATE_DOWN_4_0: Stage 2 of the machine

- STATE_UP_1_10: State 3 of the machine

- STATE_DOWN_9_5: State 4 of the machine

- STATE_UP_6_16: State 5 of the machine

- STATE_DOWN_15_1: State 6 of the machine

- STATE_3_RESET_9_0: Entered at the 10th light kickback point within stage 3, if flick=1

- STATE_3_RESET_4_0 : Entered at the 5thlight kickback point within stage 3, if flick=1

- STATE_5_RESET_9_5 : Entered at the 10th light kickback point within stage 5, if flick=1

- STATE_5_RESET_5_5 : Entered at the 5th light kickback point within stage 5, if flick=1

With 2 variable:

- flick (from input `flick`)
- counter (from input 'counter_val')

## Simulation

** TO DO **

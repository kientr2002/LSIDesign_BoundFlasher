# Bound flasher

## Introduction

This repo contains implementation (admittedly not great) of the required bound flasher module.

Images will be put into the folder `image`

## Interface

| Signal | Width | In/out | Description |
| --- | --- | --- | --- |
| clk | 1 | Input | Provide clock (positive edge-triggered) |
| reset_n | 1 | Input | Provide synchronous reset signal (active-low) |
| flick | 1 | Input | Control counting sequence of the module |
| light | 16 | Output | Output for the light (active-high) |

## Block diagram

** TO DO **

## Simulation

** TO DO **

# Dev Container Manager

## Intent

A controller for managing ephemeral dev containers in such a way as to pull new software updates on a regular occurrence. 

## Initial Iteration - Container Manager

- Write a scheduler that manages docker containers on a host
- It should perform building -> running -> stopping -> deleting on a schedule
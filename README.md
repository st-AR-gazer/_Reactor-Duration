# Reactor Duration Plugin

The Reactor Duration Plugin provides players with a visual representation of the remaining duration before a reactor depletes.

## Overview

This plugin is designed to improve the player's experience by visually representing the time left for a reactor to deplete, however there is a lack of available data which prevents this from being 100% accurate at this point in time.

## Features

- **Visual Countdown:** Offers a clear, visual countdown for reactor depletion.
- **Final Second Precision:** Ensures the last second of the reactor's duration is always accurate.

## ⚠️ Important Notes

1. **Accuracy Limitations:** The plugin's current version may not always provide 100% accurate time estimates, during the first 5 seconds (the last second is always accurate).
2. **Reactor Retriggering:** Inaccuracies occur during sustained contact with the reactor block (more than 1 frame on surfaces that are not road or platform).
3. **Reactor Nuance:** The initial five-second duration cannot be affected by certain gameplay elements, leading to it being inacurate.

## Prerequisites

- [Trackmania](http://trackmania.com/) game installed

## How It Works

1. **On Map Load:** When the player is loaded into a map and "playground" is set to not null the plugin constantly checks for a change in the reactor state.
2. **On State Change:** When the reactor state is triggered a countdown of 6000ms is set, this is displayed visually with a line in the center of the screen that is a countdown, as well as a vignette effect that is only shown during the last second of the reactor state.
3. **If reactors are re-entred:** If a reactor is re-entred there isn't a lot I can do to check for this, however there are some exeptions, road and platform have special surfaces for the effect blocks, this can lead to some innacuracies, but is IMO well worth it.

## Credits

- **Authors:** ar..... / AR_-_
- **Contributer (and helper):** XertroV

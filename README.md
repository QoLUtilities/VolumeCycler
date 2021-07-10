# Volume Cycler

Allows you to cycle the master volume of the game through a list of preset values.  
> *The default values are 80%, 20%, and 5%.*  
> No limit is set on the number of preset values you can enter, but it is suggested you keep the list small to allow for quicker cycling  

Also allows you to quickly set the master volume of the game to any percentage from 0 through 100.  

<h3 id='vc-usage'>Usage & Output</h3>

Command Format: **\/qolvc**  
Executing this command will set the in-game master volume to the next preset in the list.  
If the last preset is reached, *Volume Cycler* will begin again at the start of the list.  
The new volume setting is reported via the chat window.  
> Master Volume set to 20%.

<h3 id='vc-arguments'>Command Arguemnts</h3>

All *Volume Cycler* commands start with **\/qolvc**  
The slash command for *Volume Cycler* only looks for the first available optional argument. Any additional arguments are ignored.  

Command Format  
> \/qolvc \[***optional:*** *state*\]

### Optional Argument

Argument: *state* | Description | Example Command
:---: | --- | ---
config | Opens the config screen to the *Volume Cylcer* panel. | \/qolvc config
on | Turns ON the player logon/on reload report of the volume setting. | \/qolvc on
off | Turns OFF the player logon/on reload report of the volume setting. | \/qolvc off
0-100, inclusive. | Sets the master volume of the game to the given percent. | \/qolvc 46
\- | Sets the master volume of the game to the next level in the preset list. | \/qolvc
#!/bin/bash

# ┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓ 
# ┋ Copyright (C) 2025 Cosmic-AU                                               ┋
# ┋                                                                            ┋
# ┋ This program is free software: you can redistribute it and/or modify       ┋
# ┋ it under the terms of the GNU General Public License as published by       ┋
# ┋ the Free Software Foundation, either version 2 of the License, or          ┋
# ┋ (at your option) any later version.                                        ┋
# ┋                                                                            ┋
# ┋ but WITHOUT ANY WARRANTY; without even the implied warranty of             ┋
# ┋ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              ┋
# ┋ GNU General Public License for more details.                               ┋
# ┋                                                                            ┋
# ┋ You should have received a copy of the GNU General Public License          ┋
# ┋ along with this program.  If not, see <https://www.gnu.org/licenses/>.     ┋
# ┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛ 


# SetGPUFanCurve.sh

# ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜
# ▌╔══════════════════════════════════════════════════════════════════════════╗▐
# ▌║ Set GPU Fan Curve                                                        ║▐
# ▌╚══════════════════════════════════════════════════════════════════════════╝▐
# ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟
# ▌                                                                            ▐
# ▌ This Script sets various Fan Curves for the Sapphire Nitro+ Radeon RX 7900 ▐
# ▌ XTX 24GB GDDR6 Video Card.                                                 ▐
# ▌                                                                            ▐
# ▌ Note: 'fan_zero_rpm_enable' (and similarly others in the 'fan_ctrl'        ▐
# ▌ directory)  is a virtual file, that hooks into the Linux kernel's sysfs    ▐
# ▌ filesystem (specifically amdgpu kernel module for my RX 7900 XTX's         ▐
# ▌ overdrive (OD) features) allowing them to be changed via the echo or       ▐
# ▌ printf command and queried via the cat command.                            ▐
# ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟

     set -euo pipefail  # Strict mode: exit on errors, unset vars, failed pipes
     clear

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ROOT CHECK - as this script must be run as root (sudo, sudo su etc)        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     if [ "$EUID" -ne 0 ]; then
         echo "Error: This script must be run as root (use sudo)."
         exit 1
     fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ HELP FUNCTION - supports --help, -h, /h                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝
  
show_help() {
cat << 'EOF'
▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜
▌╔════════════════════════════════════════════════════════════════════════════╗▐
▌║ Set GPU Fan Curve - Help                                                   ║▐
▌╚════════════════════════════════════════════════════════════════════════════╝▐
▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟
▌                                                                              ▐
▌ Usage:                                                                       ▐
▌                                                                              ▐
▌   sudo SetGPUFanCurve.sh [PROFILE]                                           ▐
▌                                                                              ▐
▌   PROFILE: Use one of the following fan curve profiles.                      ▐
▌            If omitted,'default' is used.                                     ▐
▌                                                                              ▐
▌ Available Profiles:                                                          ▐
▌                                                                              ▐
▌   default    - General purpose safe default (aggressive cooling, fans always ▐
▌                spin).                                                        ▐
▌   gaming     - For AAA gaming: Aggressive ramping to keep GPU cool,          ▐
▌                prioritizing temperature over noise/fan wear.                 ▐
▌   general    - For non-graphics tasks (e.g., email, coding): Balanced        ▐
▌                cooling with slightly quieter fans.                           ▐
▌   away       - For unattended/background tasks: Quiet optimization with      ▐
▌                zero-RPM mode enabled for silence when possible.              ▐
▌   ai         - For AI/ML/LLM tasks: Aggressive cooling for sustained high    ▐
▌                GPU loads.                                                    ▐
▌   current    - Display current GPU fan settings without making changes.      ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Examples:                                                                    ▐
▌                                                                              ▐
▌   sudo SetGPUFanCurve.sh gaming      # Apply gaming profile                  ▐
▌   sudo SetGPUFanCurve.sh away        # Apply away (quiet) profile            ▐
▌   sudo SetGPUFanCurve.sh             # Apply default profile                 ▐
▌                                                                              ▐
▌ This script configures AMD GPU fan parameters via sysfs (/sys/class/drm/     ▐
▌ card0/device/gpu_od/fan_ctrl). It requires root privileges and assumes       ▐
▌ the amdgpu kernel module with overdrive features enabled.                    ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Parameters Set:                                                              ▐
▌                                                                              ▐
▌   - fan_zero_rpm_enable: Enables/disables zero-RPM mode (0 or 1)             ▐
▌   - fan_minimum_pwm: Minimum fan speed % (15-100)                            ▐
▌   - fan_target_temperature: Base temp (°C) for curve activation              ▐
▌   - acoustic_limit_rpm_threshold: Max RPM cap for noise control              ▐
▌   - acoustic_target_rpm_threshold: Target RPM for quiet optimization         ▐
▌   - fan_curve: Multi-node Temperature-to-Fan Speed mapping                   ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌ Important Note:                                                              ▐
▌                                                                              ▐
▌   To use this script, AMD overdrive features must be enabled by setting      ▐
▌   amdgpu.ppfeaturemask in your GRUB kernel line (or whatever bootloader      ▐
▌   you're using). This enables fan curve control. Examples:                   ▐
▌                                                                              ▐
▌   amdgpu.ppfeaturemask=0xfffd7fff                                            ▐
▌   amdgpu.ppfeaturemask=0xffffffff                                            ▐
▌                                                                              ▐
▌   Full example:                                                              ▐
▌   linux /kernel-6.15.3-gentoo-EPC-hypervisor root=... init=...               ▐
▌   amdgpu.ppfeaturemask=0xfffd7fff                                            ▐
▌                                                                              ▐
▌   For more details, see AMD's official documentation:                        ▐
▌   https://docs.kernel.org/gpu/amdgpu/module-parameters.html#ppfeaturemask    ▐
▌                                                                              ▐
▌——————————————————————————————————————————————————————————————————————————————▐
▌                                                                              ▐
▌                   This script was written to control a                       ▐
▌          Sapphire Nitro+ Radeon RX 7900 XTX 24GB GDDR6 Video Card            ▐
▌      It may work on other similar cards but this has not been tested!        ▐
▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟

EOF
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ COMMAND LINE ARGUMENT HANDLING                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     if [ "$1" = '--help' ] || [ "$1" = '-h' ] || [ "$1" = '/?' ]; then
         show_help
         exit 0
     fi

     PROFILE="${1:-default}"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ TEXT COLOURS                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     readonly COL_TITLE="\e[36;44m" # Cyan on Blue
     readonly COL_LINE="\e[36m"     # Cyan on default
     readonly COL_BEFORE="\e[91m"   # Red on default
     readonly COL_CURRENT="\e[93m"  # Yellow on default
     readonly COL_AFTER="\e[92m"    # Green on default
     readonly COL_RESET="\e[0m"     # Resets colours

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ FILE NAMES - File names and Directories for setting GPU Parameters         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     FAN_CTRL_DIR="/sys/class/drm/card0/device/gpu_od/fan_ctrl"
     ACOUSTIC_LIMIT_FILE="acoustic_limit_rpm_threshold"
     ACOUSTIC_TARGET_FILE="acoustic_target_rpm_threshold"        
     FAN_CURVE_FILE="fan_curve"
     MINIMUM_PWM_FILE="fan_minimum_pwm"
     TARGET_TEMP_FILE="fan_target_temperature"
     ZERO_RPM_FILE="fan_zero_rpm_enable"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ GLOBAL VARIABLES                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR=""

     FAN_ACOUSTIC_LIMIT=""
     FAN_ACOUSTIC_TARGET=""
     FAN_MINIMUM_PWM=""
     FAN_NODES=()
     FAN_TARGET_TEMP=""
     FAN_ZERO_RPM=""

     TITLE_TOP_LINE="$COL_TITLE╔══════════════════════════════════════╗$COL_RESET"
     TITLE_BOT_LINE="$COL_TITLE╚══════════════════════════════════════╝$COL_RESET"
     LINE="$COL_LINE——————————————————————————————————————————————$COL_RESET"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ PROFILE DEFINITIONS                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     declare -A PROFILES

# ——————————————————————————————————————————————————————————————————————————————
#  PROFILE: Default - This is a general purpose safe default profile if 
#  none others are specifically set
# ——————————————————————————————————————————————————————————————————————————————
     PROFILES[default,acoustic_limit]="3200"
     PROFILES[default,acoustic_target]="3200"
     PROFILES[default,min_pwm]="30"
     PROFILES[default,nodes]="0 25 30|1 45 40|2 55 70|3 62 90|4 70 100" # 5 Nodes (Node Number / Temperature / PWM Percentage)
     PROFILES[default,target_temp]="40"
     PROFILES[default,zero_rpm]="0"

# ——————————————————————————————————————————————————————————————————————————————
# PROFILE: Gaming - This profile is for AAA Gaming (Should aggressively ramp 
# to ensure GPU stays as cool as possible, regardless of noise of fan wear)
# ——————————————————————————————————————————————————————————————————————————————
     PROFILES[gaming,acoustic_limit]="3200"
     PROFILES[gaming,acoustic_target]="3200"
     PROFILES[gaming,min_pwm]="30"
     PROFILES[gaming,nodes]="0 25 30|1 45 40|2 55 70|3 62 90|4 70 100" # 5 Nodes (Node Number / Temperature / PWM Percentage)
     PROFILES[gaming,target_temp]="40"
     PROFILES[gaming,zero_rpm]="0"

# ——————————————————————————————————————————————————————————————————————————————
# PROFILE: General - This profile is suitable for general non-graphics 
# intensive tasks (e.g., email, coding, word processing, etc)
# ——————————————————————————————————————————————————————————————————————————————
     PROFILES[general,acoustic_limit]="3200"
     PROFILES[general,acoustic_target]="3200"
     PROFILES[general,min_pwm]="25"
     PROFILES[general,nodes]="0 25 25|1 50 45|2 60 60|3 65 80|4 70 100" # 5 Nodes (Node Number / Temperature / PWM Percentage)
     PROFILES[general,target_temp]="45"
     PROFILES[general,zero_rpm]="0"

# ——————————————————————————————————————————————————————————————————————————————
# PROFILE: Away - This profile is optimised for when the computer is 
# unattended with screens turned off, and system is just running 
# background tasks and services. 
# ——————————————————————————————————————————————————————————————————————————————
     PROFILES[away,acoustic_limit]="3200"
     PROFILES[away,acoustic_target]="3200"
     PROFILES[away,min_pwm]="20"
     PROFILES[away,nodes]="0 25 20|1 45 50|2 55 70|3 65 90|4 70 100" # 5 Nodes (Node Number / Temperature / PWM Percentage)
     PROFILES[away,target_temp]="50"
     PROFILES[away,zero_rpm]="1"

# ——————————————————————————————————————————————————————————————————————————————
# PROFILE: AI -  This profile is optimised for AI/LLM/ML tasks and should 
# have aggressive cooling at high GPU utilisation.
# ——————————————————————————————————————————————————————————————————————————————
     PROFILES[ai,acoustic_limit]="3200"
     PROFILES[ai,acoustic_target]="3200"
     PROFILES[ai,min_pwm]="30"
     PROFILES[ai,nodes]="0 25 30|1 45 40|2 55 70|3 62 90|4 70 100" # 5 Nodes (Node Number / Temperature / PWM Percentage)
     PROFILES[ai,target_temp]="40"
     PROFILES[ai,zero_rpm]="0"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ LOAD PARAMETERS BASED ON PROFILE                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     load_profile() 
          {   local prof="$1"
              if [[ -z "${PROFILES[$prof,acoustic_limit]+x}" ]]; then
                  echo "Invalid profile: $prof. Use: general, gaming, away, ai, default, or current." >&2
                  exit 1
              fi
              FAN_ACOUSTIC_LIMIT="${PROFILES[$prof,acoustic_limit]}"
              FAN_ACOUSTIC_TARGET="${PROFILES[$prof,acoustic_target]}"
              FAN_MINIMUM_PWM="${PROFILES[$prof,min_pwm]}"
              IFS='|' read -r -a FAN_NODES <<< "${PROFILES[$prof,nodes]}"
              FAN_TARGET_TEMP="${PROFILES[$prof,target_temp]}"
              FAN_ZERO_RPM="${PROFILES[$prof,zero_rpm]}"
          }

     case "$PROFILE" in
         current)
             # No settings to load; just display current
             ;;
         *)
             load_profile "$PROFILE"
             ;;
     esac


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ SetState - General GPU Parameter Set Function                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝

SetState() 
     {   local descr="$1"
         local file="$2"
         local setting="$3"
         echo -e "$TITLE_TOP_LINE"
         echo -e "$COL_TITLE║ $descr ║$COL_RESET"
         echo -e "$TITLE_BOT_LINE\n"
         echo "Current State:-"
         echo -e "$LINE"
         output=$(cat "$FAN_CTRL_DIR/$file"); echo -e "$COL_BEFORE$output$COL_RESET"
         echo -e "$LINE"
         if [ -n "$setting" ]; then
             echo "echoing $setting to $FAN_CTRL_DIR/$file"
             printf '%s\n' "$setting" > "$FAN_CTRL_DIR/$file" || exit 1
             echo -e "$LINE"
             echo "New State:-"
             echo -e "$LINE"
             output=$(cat "$FAN_CTRL_DIR/$file"); echo -e "$COL_AFTER$output$COL_RESET"
         fi
         echo -e "$LINE\n\n"
     }


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ShowCurrent - Just Prints A Current GPU Fan Setting                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ShowCurrent() 
     {   local descr="$1"
         local file="$2"
         echo -e "$TITLE_TOP_LINE"
         echo -e "$COL_TITLE║ $descr ║$COL_RESET"
         echo -e "$TITLE_BOT_LINE\n"
         echo "Current State:-"
         echo -e "$LINE"
         output=$(cat "$FAN_CTRL_DIR/$file"); echo -e "$COL_CURRENT$output$COL_RESET"
         echo -e "$LINE\n\n"
     }


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ OUTPUT SELECTED PROFILE AND PPFEATUREMASK                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     echo -e "$COL_TITLE Profile: $PROFILE$COL_RESET\n"
     ppfeature=$(cat /sys/module/amdgpu/parameters/ppfeaturemask 2>/dev/null || echo "not set")
     echo "The current amdgpu.ppfeaturemask = $ppfeature"
     echo ""

# Change to fan control directory early for reliability
     cd "$FAN_CTRL_DIR" || { echo "Error: Cannot access $FAN_CTRL_DIR" >&2; exit 1; }


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ If command line parameter was 'current', Print all Current Fan Settings    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     if [ "$PROFILE" = "current" ]; then
          echo -e "$COL_TITLE Current GPU Fan Settings$COL_RESET\n"    
          PARAM_DESCR="Zero Fan Speed Function Status      "
          ShowCurrent "$PARAM_DESCR" "$ZERO_RPM_FILE"
          PARAM_DESCR="Minimum Fan Speed                   "
          ShowCurrent "$PARAM_DESCR" "$MINIMUM_PWM_FILE"
          PARAM_DESCR="Fan Target Temperature              "
          ShowCurrent "$PARAM_DESCR" "$TARGET_TEMP_FILE"
          PARAM_DESCR="Acoustic Limit RPM Threshold        "
          ShowCurrent "$PARAM_DESCR" "$ACOUSTIC_LIMIT_FILE"
          PARAM_DESCR="Acoustic Target RPM Threshold       "
          ShowCurrent "$PARAM_DESCR" "$ACOUSTIC_TARGET_FILE"
          PARAM_DESCR="Fan Curve                           "
          ShowCurrent "$PARAM_DESCR" "$FAN_CURVE_FILE"
          echo "Current settings displayed — no changes applied."
          exit 0
     fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set GPU Zero Speed Fan Function                                            ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ fan_zero_rpm_enable: Enables/Disables zero-RPM mode, preventing fans from  ║
# ║ stopping below a temperature threshold for constant airflow.               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting Zero Fan Speed Function     "
     SetState "$PARAM_DESCR" "$ZERO_RPM_FILE" "$FAN_ZERO_RPM"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set Minimum Fan Speed                                                      ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ fan_minimum_pwm: Sets the lowest enforceable fan speed percentage (15-100) ║
# ║  across the entire curve.                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting The Minimum Fan Speed       "
     SetState "$PARAM_DESCR" "$MINIMUM_PWM_FILE" "$FAN_MINIMUM_PWM"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set Fan Target Temperature                                                 ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ fan_target_temp: Defines the base temp (in °C) at which the fan curve      ║
# ║  begins active control and hysteresis applies.                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting Fan Target Temp             "
     SetState "$PARAM_DESCR" "$TARGET_TEMP_FILE" "$FAN_TARGET_TEMP"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set Acoustic Limit RPM Threshold                                           ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ acoustic_limit_rpm_threshold: Establishes the maximum RPM cap for the      ║
# ║  acoustic (noise-minimizing) fan mode.                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting Acoustic Limit RPM Thrshld  "
     SetState "$PARAM_DESCR" "$ACOUSTIC_LIMIT_FILE" "$FAN_ACOUSTIC_LIMIT"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set Acoustic Target RPM Threshold                                          ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ acoustic_target_rpm_threshold: Specifies the target RPM for acoustic       ║
# ║ optimisation, influencing quiet-mode behaviour.                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting Acoustic Target RPM Thrshld "
     SetState "$PARAM_DESCR" "$ACOUSTIC_TARGET_FILE" "$FAN_ACOUSTIC_TARGET"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Set Fan Curve                                                              ║
# ║————————————————————————————————————————————————————————————————————————————║
# ║ fan_curve: Defines the multi-node temp-to-speed mapping (up to 10 points); ║
# ║  'c' commits the curve.                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

     PARAM_DESCR="Setting Fan Curve                   "
     echo -e "$TITLE_TOP_LINE"
     echo -e "$COL_TITLE║ $PARAM_DESCR ║$COL_RESET"
     echo -e "$TITLE_BOT_LINE\n"
     echo "Current State:-"
     echo -e "$LINE"
     output=$(cat "$FAN_CTRL_DIR/$FAN_CURVE_FILE"); echo -e "$COL_BEFORE$output$COL_RESET"
     echo -e "$LINE"
     echo "Applying fan curve nodes:"
          for node in "${FAN_NODES[@]}"; do
               echo "Echoing '$node' to $FAN_CTRL_DIR/$FAN_CURVE_FILE"
               printf '%s\n' "$node" > "$FAN_CTRL_DIR/$FAN_CURVE_FILE" || exit 1
          done
     echo "Committing fan curve"
     echo "Echoing 'c' to $FAN_CTRL_DIR/$FAN_CURVE_FILE (commit)"
     printf 'c\n' >"$FAN_CTRL_DIR/$FAN_CURVE_FILE" || exit 1
     echo -e "$LINE"
     echo "New State:-"
     echo -e "$LINE"
     output=$(cat "$FAN_CTRL_DIR/$FAN_CURVE_FILE"); echo -e "$COL_AFTER$output$COL_RESET"
     echo -e "$LINE\n"
     echo "Fan curve applied successfully — monitor with 'sensors' or 'amdgpu_top'."
     
# -- end SetGPUFanCurve.sh ---

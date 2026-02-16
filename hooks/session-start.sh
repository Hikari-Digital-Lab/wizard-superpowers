#!/usr/bin/env bash
# SessionStart hook for wizard-superpowers plugin

set -euo pipefail

# Determine plugin root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# ─── Colors (truecolor on black background) ───
RST="\e[0m"
BG="\e[48;2;0;0;0m"
F="${BG}\e[38;2;107;80;16m"         # frame — dark bronze
R="${BG}\e[38;2;139;115;64m"        # rune lines — warm bronze
C="${BG}\e[38;2;200;168;96m"        # cream text
G="${BG}\e[38;2;232;184;48m"        # rich gold accents
A="${BG}\e[38;2;255;208;96m"        # bright gold gems
H="${BG}\e[1m\e[38;2;255;240;192m"  # hot gold (bold)
DR="${BG}\e[2m\e[38;2;139;115;64m"  # dim bronze

# ─── Random fun messages (max 46 chars each) ───
MESSAGES=(
  "Runele-s aruncate. Sa inceapa magia!"
  "Wizard-ul e treaz. Codul tremura."
  "Potiunea e bauta. Hai la treaba!"
  "Pergamentul s-a deschis. Ce vraji facem?"
  "Skill-urile stralucesc. Gata de actiune!"
  "Bagheta calibrata. Care-i dorinta ta?"
  "Cercul runic: activat. Bug-uri: zero."
  "Grimoarul e deschis la TDD. Hai!"
  "Wizard-ul a meditat. Ready de debug."
  "Cafea calda, rune fresh, cod curat."
)
MSG="${MESSAGES[$((RANDOM % ${#MESSAGES[@]}))]}"

# ─── Draw the wizard box (stderr = visible in terminal) ───
# Inner width = 52 chars between │ and │
W=52

# Horizontal rules
HT=$(printf '─%.0s' $(seq 1 $W))

# Spaces generator (on black bg)
S() { printf '%*s' "$1" ''; }

{
  echo ""
  echo -e "  ${F}┌${HT}┐${RST}"
  echo -e "  ${F}│${BG}    ${G}·${BG}  ${H}☆${BG}  ${G}·${BG}$(S 41)${F}│${RST}"
  echo -e "  ${F}│${BG}  ${A}◈${BG} ${R}╭────╮${BG} ${A}◈${BG}  ${H}✦ AI-WIZARD ✦${BG}$(S 25)${F}│${RST}"
  echo -e "  ${F}│${BG}  ${G}·${BG} ${R}│${A}⊛  ⊛${R}│${BG} ${G}·${BG}  ${F}$(printf '─%.0s' $(seq 1 38))${F}│${RST}"
  echo -e "  ${F}│${BG}  ${A}◈${BG} ${R}│${BG} ${H}◆◆${BG} ${R}│${BG} ${A}◈${BG}  ${C}The runes speak.${BG}$(S 22)${F}│${RST}"
  echo -e "  ${F}│${BG}  ${G}·${BG} ${R}╰────╯${BG} ${G}·${BG}  ${C}The code obeys.${BG}$(S 23)${F}│${RST}"
  echo -e "  ${F}│${BG}    ${A}◈${BG}  ${G}·${BG}  ${A}◈${BG}$(S 41)${F}│${RST}"
  echo -e "  ${F}│${BG}    ${G}·${BG} ${H}☆☆☆${BG} ${G}·${BG}   ${DR}14 skill-uri incarcate${BG}$(S 16)${F}│${RST}"
  echo -e "  ${F}│${BG}       ${C}▸ https://ai-wizard.tech${BG}$(S 21)${F}│${RST}"
  echo -e "  ${F}├${HT}┤${RST}"
  echo -e "  ${F}│${BG} ${A}⚡${BG} ${H}${MSG}${BG}$(S $((49 - ${#MSG})))${F}│${RST}"
  echo -e "  ${F}└${HT}┘${RST}"
  echo ""
} >&2

# ─── Inject skill context into Claude (stdout = JSON) ───

using_superpowers_content=$(cat "${PLUGIN_ROOT}/skills/using-superpowers/SKILL.md" 2>&1 || echo "Error reading using-superpowers skill")

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

using_superpowers_escaped=$(escape_for_json "$using_superpowers_content")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "<EXTREMELY_IMPORTANT>\nYou have wizard-superpowers.\n\n**Below is the full content of your 'wizard-superpowers:using-superpowers' skill - your introduction to using skills. For all other skills, use the 'Skill' tool:**\n\n${using_superpowers_escaped}\n</EXTREMELY_IMPORTANT>"
  }
}
EOF

exit 0

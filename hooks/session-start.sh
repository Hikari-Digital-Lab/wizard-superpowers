#!/usr/bin/env bash
# SessionStart hook for wizard-superpowers plugin

set -euo pipefail

# Determine plugin root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# ─── Show the wizard logo to the user (stderr = visible in terminal) ───

RST="\e[0m"
B="\e[1m"
D="\e[2m"

F="\e[48;2;0;0;0m\e[38;2;107;80;16m"
R="\e[48;2;0;0;0m\e[38;2;139;115;64m"
C="\e[48;2;0;0;0m\e[38;2;200;168;96m"
G="\e[48;2;0;0;0m\e[38;2;232;184;48m"
A="\e[48;2;0;0;0m\e[38;2;255;208;96m"
H="\e[48;2;0;0;0m\e[1m\e[38;2;255;240;192m"
S="\e[48;2;0;0;0m"
DR="\e[48;2;0;0;0m\e[2m\e[38;2;139;115;64m"

# Fun messages — one picked at random each session
MESSAGES=(
  "Runele au fost aruncate. Sa inceapa magia!"
  "Wizard-ul e treaz. Codul tremura."
  "Potiunea de productivitate a fost baut. Hai la treaba!"
  "Pergamentul s-a deschis. Ce vraji facem azi?"
  "Cristalul straluceste. Skill-urile sunt incarcate!"
  "Bagheta e calibrata. Spune-mi dorinta ta!"
  "Cercul runic s-a activat. Zero bug-uri tolerate!"
  "Grimoarul e deschis la pagina TDD. Hai!"
  "Wizard-ul a meditat. Acum e ready de debug."
  "Rune fresh, cafea calda, cod curat. Perfectiune!"
)

MSG="${MESSAGES[$((RANDOM % ${#MESSAGES[@]}))]}"

{
  echo ""
  echo -e "  ${F}┌──────────────────────────────────────────┐${RST}"
  echo -e "  ${F}│${S}    ${G}·${S}  ${H}☆${S}  ${G}·${S}                               ${F}│${RST}"
  echo -e "  ${F}│${S}  ${A}◈${S} ${R}╭────╮${S} ${A}◈${S}  ${H}✦ AI-WIZARD ✦${S}               ${F}│${RST}"
  echo -e "  ${F}│${S}  ${G}·${S} ${R}│${A}⊛  ⊛${R}│${S} ${G}·${S}  ${F}──────────────────────${S}  ${F}│${RST}"
  echo -e "  ${F}│${S}  ${A}◈${S} ${R}│${S} ${H}◆◆${S} ${R}│${S} ${A}◈${S}  ${C}The runes speak.${S}          ${F}│${RST}"
  echo -e "  ${F}│${S}  ${G}·${S} ${R}╰────╯${S} ${G}·${S}  ${C}The code obeys.${S}           ${F}│${RST}"
  echo -e "  ${F}│${S}    ${A}◈${S}  ${G}·${S}  ${A}◈${S}                               ${F}│${RST}"
  echo -e "  ${F}│${S}    ${G}·${S} ${H}☆☆☆${S} ${G}·${S}   ${DR}14 skill-uri incarcate${S}   ${F}│${RST}"
  echo -e "  ${F}│${S}       ${C}▸ https://ai-wizard.tech${S}          ${F}│${RST}"
  echo -e "  ${F}├──────────────────────────────────────────┤${RST}"
  echo -e "  ${F}│${S} ${A}⚡${S} ${H}${MSG}${RST}${S}$(printf '%*s' $((41 - ${#MSG})) '')${F}│${RST}"
  echo -e "  ${F}└──────────────────────────────────────────┘${RST}"
  echo ""
} >&2

# ─── Inject skill context into Claude (stdout = JSON for Claude) ───

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

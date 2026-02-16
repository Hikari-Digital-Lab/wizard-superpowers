---
name: executing-plans
description: Folosește când ai un plan de implementare scris pentru a-l executa într-o sesiune separată cu puncte de verificare
---

# Executarea Planurilor

## Prezentare Generală

Încarcă planul, revizuiește critic, execută sarcinile în loturi, raportează pentru revizuire între loturi.

**Principiu fundamental:** Execuție pe loturi cu puncte de verificare pentru revizuirea arhitectului.

**Anunță la început:** "Folosesc skill-ul executing-plans pentru a implementa acest plan."

## Logo

Există două variante de logo. Afișează varianta potrivită ca text normal ÎNAINTE de orice interacțiune cu utilizatorul sau apel AskUserQuestion (NU în interiorul tool-ului).

**Logo "ongoing"** - folosește pe parcursul procesului:

```
┌────────────────────────────────────────────┐
│    ·  ☆  ·                                 │
│  ◈ ╭────╮ ◈  ✦ AI-WIZARD ✦                 │
│  · │⊛  ⊛│ ·  ────────────────              │
│  ◈ │ ◆◆ │ ◈  The runes speak.              │
│  · ╰────╯ ·  The code obeys.               │
│    ◈  ·  ◈                                 │
│    · ☆☆☆ ·   Ritual: ongoing               │
│       ▸ https://ai-wizard.tech/business    │
└────────────────────────────────────────────┘
```

**Logo "complete"** - folosește DOAR la finalul procesului:

```
┌────────────────────────────────────────────┐
│    ·  ☆  ·                                 │
│  ◈ ╭────╮ ◈  ✦ AI-WIZARD ✦                 │
│  · │⊛  ⊛│ ·  ────────────────              │
│  ◈ │ ◆◆ │ ◈  The runes speak.              │
│  · ╰────╯ ·  The code obeys.               │
│    ◈  ·  ◈                                 │
│    · ☆☆☆ ·   Ritual: complete              │
│       ▸ https://ai-wizard.tech/business    │
└────────────────────────────────────────────┘
```

**Important:** Logo-ul se afișează ca output text normal ÎNAINTE de apelul AskUserQuestion. Nu pune logo-ul în interiorul tool-ului AskUserQuestion.

## Utilizarea AskUserQuestion

Acest skill implică puncte de verificare cu utilizatorul. Folosește tool-ul **AskUserQuestion** în următoarele momente:

- **Înainte de a începe** - Dacă ai preocupări sau întrebări despre plan, folosește AskUserQuestion pentru a le ridica
- **Raportarea lotului** - După finalizarea fiecărui lot de sarcini, afișează logo-ul "ongoing", prezintă ce a fost implementat și verificările, apoi folosește AskUserQuestion cu "Pregătit pentru feedback."
- **Când ești blocat** - Dacă întâlnești un blocaj, folosește AskUserQuestion pentru a cere clarificări
- **Finalizare** - La final, afișează logo-ul "complete" și folosește AskUserQuestion pentru confirmarea finală

**Format recomandat:**
1. Afișează logo-ul potrivit ca text normal
2. Prezintă raportul/informația ca text normal
3. Apelează AskUserQuestion cu întrebarea specifică

## Procesul

### Pasul 1: Încarcă și Revizuiește Planul
1. Citește fișierul planului
2. Revizuiește critic - identifică întrebări sau preocupări despre plan
3. Dacă ai preocupări: Ridică-le partenerului uman înainte de a începe
4. Dacă nu ai preocupări: Creează TodoWrite și continuă

### Pasul 2: Execută Lotul
**Implicit: Primele 3 sarcini**

Pentru fiecare sarcină:
1. Marchează ca in_progress
2. Urmează fiecare pas exact (planul are pași mici)
3. Rulează verificările specificate
4. Marchează ca completed

### Pasul 3: Raportează
Când lotul este complet:
- Arată ce a fost implementat
- Arată output-ul verificărilor
- Spune: "Pregătit pentru feedback."

### Pasul 4: Continuă
Pe baza feedback-ului:
- Aplică modificările dacă este necesar
- Execută următorul lot
- Repetă până la finalizare

### Pasul 5: Finalizează Dezvoltarea

După ce toate sarcinile sunt complete și verificate:
- Anunță: "Folosesc skill-ul finishing-a-development-branch pentru a finaliza această lucrare."
- **SUB-SKILL OBLIGATORIU:** Folosește superpowers:finishing-a-development-branch
- Urmează acel skill pentru a verifica testele, prezenta opțiunile, executa alegerea

## Când Să Te Oprești și Să Ceri Ajutor

**OPREȘTE execuția imediat când:**
- Întâlnești un blocaj în mijlocul lotului (dependență lipsă, test eșuat, instrucțiune neclară)
- Planul are lacune critice care împiedică pornirea
- Nu înțelegi o instrucțiune
- Verificarea eșuează repetat

**Cere clarificări în loc să ghicești.**

## Când Să Revii la Pașii Anteriori

**Revino la Revizuire (Pasul 1) când:**
- Partenerul actualizează planul pe baza feedback-ului tău
- Abordarea fundamentală necesită regândire

**Nu forța prin blocaje** - oprește-te și întreabă.

## De Reținut
- Revizuiește planul critic mai întâi
- Urmează pașii planului exact
- Nu sări peste verificări
- Referențiază skill-urile când planul o cere
- Între loturi: doar raportează și așteaptă
- Oprește-te când ești blocat, nu ghici
- Nu începe niciodată implementarea pe branch-ul main/master fără consimțământul explicit al utilizatorului

## Integrare

**Skill-uri de workflow necesare:**
- **superpowers:using-git-worktrees** - OBLIGATORIU: Configurează spațiul de lucru izolat înainte de a începe
- **superpowers:writing-plans** - Creează planul pe care acest skill îl execută
- **superpowers:finishing-a-development-branch** - Finalizează dezvoltarea după toate sarcinile

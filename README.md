# Wizard Superpowers

**14 skill-uri profesionale pentru Claude Code** — traduse, adaptate si branduite in limba romana.

Bazat pe [Superpowers](https://github.com/obra/superpowers) de Jesse Vincent, acest pachet transforma Claude Code dintr-un simplu asistent intr-un inginer software disciplinat care urmeaza procese verificate.

---

## Cum functioneaza

Nu trebuie sa faci nimic special. Skill-urile se activeaza **automat** in functie de context:

1. Cand incepi sa construiesti ceva — Claude nu sare direct la cod. Mai intai te intreaba ce vrei sa faci si rafineaza designul impreuna cu tine.

2. Dupa ce aprobi designul — scrie un plan de implementare ultra-granular, cu task-uri de 2-5 minute, cai exacte de fisiere si pasi TDD.

3. Cand spui "go" — lanseaza sub-agenti care lucreaza prin fiecare task, cu review in doua etape (conformitate cu spec-ul, apoi calitate cod).

4. Pe tot parcursul — aplica TDD strict (test inainte de cod, fara exceptii), debugging sistematic si verificare bazata pe dovezi.

**Workflow-uri obligatorii, nu sugestii.**

---

## Instalare

In Claude Code, inregistreaza marketplace-ul:

```bash
/plugin marketplace add Hikari-Digital-Lab/wizard-superpowers
```

Apoi instaleaza plugin-ul:

```bash
/plugin install wizard-superpowers
```

### Verificare

Incepe o sesiune noua si cere-i lui Claude sa te ajute cu ceva — de exemplu "planifica aceasta functionalitate" sau "debuggeaza acest issue". Claude ar trebui sa invoce automat skill-ul relevant.

### Actualizare

```bash
/plugin update wizard-superpowers
```

---

## Skill-uri incluse

### Workflow principal

| # | Skill | Ce face |
|---|-------|---------|
| 1 | **brainstorming** | Rafineaza ideile prin intrebari inainte de orice cod. Salveaza design-ul aprobat. |
| 2 | **writing-plans** | Sparge munca in task-uri de 2-5 min cu fisiere exacte, snippeturi si pasi TDD. |
| 3 | **executing-plans** | Executa planuri in batch-uri de 3 cu checkpoint-uri umane intre ele. |
| 4 | **subagent-driven-development** | Un sub-agent per task + review in 2 etape (spec + calitate cod). |
| 5 | **finishing-a-development-branch** | Verifica testele, ofera 4 optiuni: merge, PR, pastreaza, renunta. |

### Calitate cod

| Skill | Ce face |
|-------|---------|
| **test-driven-development** | RED-GREEN-REFACTOR strict. Cod inainte de test? Sterge si incepe de la zero. |
| **systematic-debugging** | 4 faze: root cause, pattern-uri, ipoteze, implementare. 3+ fix-uri esuate = pune la indoiala arhitectura. |
| **requesting-code-review** | Lanseaza sub-agent reviewer dupa task-uri majore si inainte de merge. |
| **receiving-code-review** | Proceseaza feedback fara acord performativ. Confirmare tehnica sau pushback argumentat. |
| **verification-before-completion** | Zero afirmatii de "gata" fara dovezi din comenzi rulate fresh. |

### DevOps & utilitare

| Skill | Ce face |
|-------|---------|
| **dispatching-parallel-agents** | Sub-agenti paraleli pentru sarcini independente. |
| **using-git-worktrees** | Worktrees izolate cu auto-detect setup (npm/cargo/pip/go). |
| **using-superpowers** | Meta-skill: bootstrappeaza sistemul, gaseste si invoca skill-uri automat. |
| **writing-skills** | Creaza skill-uri noi aplicand TDD pe documentatie de proces. |

---

## Filozofie

- **Test-Driven Development** — Scrie testul mai intai, intotdeauna
- **Sistematic, nu ad-hoc** — Proces in loc de ghicit
- **Reducerea complexitatii** — Simplitatea ca obiectiv principal
- **Dovezi, nu afirmatii** — Verifica inainte de a declara succes

---

## Credite

Skill-urile sunt bazate pe [Superpowers](https://github.com/obra/superpowers) v4.3.0 de [Jesse Vincent](https://github.com/obra), traduse si adaptate cu branding AI-WIZARD de [Hikari Digital Lab](https://github.com/Hikari-Digital-Lab).

---

## Licenta

MIT License — vezi fisierul [LICENSE](LICENSE) pentru detalii.

---

<div align="center">

**✦ AI-WIZARD ✦**

*The runes speak. The code obeys.*

[ai-wizard.tech](https://ai-wizard.tech)

</div>

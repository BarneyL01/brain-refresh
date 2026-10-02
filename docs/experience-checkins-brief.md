# Feature brief: Experience check-ins (counter to the peak-end rule)

## Problem

When people look back on an experience (a holiday, a course, a church retreat, a new job, a treatment), their memory gives most of the weight to the most intense moment and to how it ended. It gives almost no weight to how long the good or bad parts lasted. This is the **peak-end rule** together with **duration neglect**.

- A meta-analysis of 174 effect sizes found a strong peak-end effect (r ≈ 0.58) and an essentially zero effect of duration on remembered ratings (Alaybek et al., 2022, *Organizational Behavior and Human Decision Processes*).
- In a randomized trial of 682 colonoscopy patients, adding a few minutes of milder discomfort at the end made people remember the whole procedure as less unpleasant (Redelmeier, Katz & Kahneman, 2003, *Pain*).

As a result, people decide whether to repeat or recommend something based on a distorted memory. For example, a family has a six-day trip with five good days and one bad final day, then decides "never again."

## Goal

Let users record short ratings **while an experience is happening**, so that a later decision ("Should we do this again?") is based on the full record and not only on the remembered peak and ending.

## Core concepts

| Concept | Description |
|---|---|
| Experience | Something with a start and an end that the user may want to judge later. Examples: "Family camping trip 2026", "Tuesday small group, autumn term", "New gym membership". |
| Check-in | One entry inside an experience: a 1–5 rating, an optional note of one or two sentences, and a timestamp. |
| Participant | Optional. A person who adds check-ins to a shared experience (for example each family member). |
| Look back | A summary screen that shows the full record and compares it with the user's current overall opinion. |

## User flows

### 1. Create an experience

- Fields: name (required), start date (default today), expected end date (optional), check-in frequency (daily / each session / manual), reminder time (optional).
- Optional: add participants by name. Participants without the app can be rated by the main user on their behalf (for example a parent entering a child's rating).

### 2. Add a check-in (must take under 15 seconds)

- One screen: five large buttons labelled 1 to 5, plus a single-line text field "What happened? (optional)", limited to about 200 characters.
- Rating scale labels: 1 = Very bad, 2 = Bad, 3 = Okay, 4 = Good, 5 = Very good.
- Save with one tap. Timestamp is set automatically and can be edited.
- If there are participants, show one row of 1–5 buttons per person on the same screen.
- Optional toggle on any check-in: "This was a high point" or "This was a low point".

### 3. Reminders

- A notification at the chosen time while the experience is active: "How was today on *Family camping trip*? Tap to rate."
- The rating can be entered directly from the notification where the platform allows it.
- Reminders stop automatically after the end date or when the user marks the experience as finished.

### 4. Finish the experience and record a "remembered" rating

- When the user marks the experience as finished, wait a set time (default 7 days), then ask: "Looking back, how would you rate *Family camping trip* overall? (1–5)".
- Save this as the **remembered rating**. Do not show the check-in history before the user answers, so the answer reflects memory alone.

### 5. Look back screen (the key screen)

Show, in this order:

1. **Timeline chart.** One point per check-in in time order on a 1–5 axis. Mark high and low points.
2. **Summary numbers:**
   - Average of all check-ins
   - Share of check-ins rated 4 or 5, shown as a count and percentage ("5 of 6 days were Good or Very good")
   - Lowest and highest check-in
   - Rating of the final check-in
   - Remembered rating (from step 4)
3. **Gap message.** If the remembered rating differs from the average by 1 point or more, show a plain message, for example: "You now rate this 2/5. While it was happening, your average was 4.2/5, and 5 of 6 days were rated Good or Very good. Your lowest rating was on the last day."
4. **Notes list.** All notes in time order, so the user can read what each part was like.
5. **Decision prompt.** "Would you do this again?" with options Yes / No / Yes, with changes. Plus a text field: "What would you change?"

### 6. Before a repeat decision

- When the user creates a new experience with a name similar to an earlier one (for example "Camping trip 2027"), offer: "You logged *Camping trip 2026*. View how it went before you plan?" and link to its Look back screen.

## Data model (minimum)

```
Experience
  id, name, start_date, end_date (nullable), status (active | finished),
  checkin_frequency, reminder_time (nullable),
  remembered_rating (1–5, nullable), remembered_rating_at (nullable),
  repeat_decision (yes | no | yes_with_changes, nullable), repeat_notes (text, nullable)

Participant
  id, experience_id, display_name

CheckIn
  id, experience_id, participant_id (nullable = main user),
  rating (integer 1–5), note (text, max ~200 chars, nullable),
  marker (high | low | none), created_at, edited_at
```

## Calculations

- Average = mean of all check-in ratings (all participants, and also per participant).
- Positive share = count of ratings ≥ 4 ÷ total check-ins.
- Ending rating = rating of the most recent check-in.
- Gap = remembered_rating − average. Show the gap message when |gap| ≥ 1.0.
- If a check-in frequency is daily and a day was missed, show the gap in the timeline. Do not fill it in.

## Acceptance criteria

- A user can create an experience and add a check-in in two taps from the home screen.
- A check-in with no note saves successfully.
- The remembered rating prompt never shows check-in data before the user answers.
- The Look back screen shows the timeline, all five summary numbers, and the notes list.
- The gap message appears only when the remembered rating and the average differ by 1 point or more.
- Reminders stop after the experience is finished.
- All data is stored on the device by default. Sharing with participants is optional and explicit.

## Out of scope for the first version

- Social sharing or public reviews
- Ratings more detailed than 1–5
- Automatic detection of experiences from calendar or location

## Copy guidelines

- Use plain, literal wording. Do not tell users their memory is "wrong". State the numbers side by side and let the user decide.
- Example tone: "Here is what you recorded while it was happening."

## References

- Alaybek, B., et al. (2022). All's well that ends (and peaks) well? A meta-analysis of the peak-end rule and duration neglect. *Organizational Behavior and Human Decision Processes*, 170. https://econpapers.repec.org/article/eeejobhdp/v_3a170_3ay_3a2022_3ai_3ac_3as0749597822000334.htm
- Redelmeier, D. A., Katz, J., & Kahneman, D. (2003). Memories of colonoscopy: a randomized trial. *Pain*, 104(1–2), 187–194. https://www.sciencedirect.com/science/article/abs/pii/S0304395903000034
- Overview of the peak-end rule: The Decision Lab. https://thedecisionlab.com/biases/peak-end-rule

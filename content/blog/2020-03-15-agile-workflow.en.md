---
title: "An Agile Workflow for Humans"
date: 2020-03-15
slug: "an-agile-workflow-for-humans"
---

Developing software is challenging.
Many workflows are simply too complicated and not intuitive enough.
Individuals and interaction between people are hardly at the center of interest any longer.
It seems as if the perfect process does not allow decisions of the involved individuals anymore.
Is this still as intended by the Agile Manifesto?
In this article I would like to introduce a simple agile development process that is built with humans in mind.

<!--more-->

Many workflows try to cover every conceivable circumstance and condition that may ever emerge.
This can often end up in confusion and frustration for the people involved.
In the end, it is no longer about creating value for the product, but simply pushing the "ticket" further.
Eventually, when it comes to the point where assigning a "ticket" to a colleague "relieves" them of their own responsibility, the "agility" of the project methodology should be questioned.

The following graphic illustrates an exaggerated view of a highly complicated workflow.
Each of the states shown have already come to my attention while working on a number of different projects.
Every single step is tried to be defined and mapped in the process.
Thereby new paths within the process emerge, which deal with the exceptions of exceptions.

<figure>
    <a href="/images/2019-02-29-agile-workflow/anti-agile-workflow.svg">
        <img src="/images/2019-02-29-agile-workflow/anti-agile-workflow.svg" alt="Diagram of a process with over 20 states and many loops.">
    </a>
    <figcaption>
        The exaggerated illustration of a too complicated workflow.
    </figcaption>
</figure>

The agile process models are usually based on the "[Manifesto for Agile Software Development][1]".
The manifesto states that "individuals and interactions are valued more than processes and tools".
Therefore, the question arises of where the interaction of individuals remains in an process of that kind, where communication only takes place by changing status or assigning to a person.

## Glossary

Before I outline an alternative process, I would first like to clarify the terms that are important in this context.

* **Item:**
    An item is the unit that is prepared, planned and implemented by the team.
    Other terms are ticket or issue. If there is a special form, it is also often referred to as a "user story" or simply a "story".
    In order to avoid giving precedence to any method, the term item is used here instead.

* **Workflow:**
    The change between two statuses is called a transition.
    The transition is often linked to certain conditions that must be met before.

## The Workflow

The agile workflow does not require much.
It only requires four states and three transitions.
It is simple, memorable and reduced to the most necessary.
The principle "simplicity -- the art of maximizing the amount of work not done -- is essential" from the Agile Manifesto is thereby fulfilled.

<figure>
    <a href="/images/2019-02-29-agile-workflow/agile-workflow.svg">
        <img src="/images/2019-02-29-agile-workflow/agile-workflow.svg" alt="Display of a process with the status Backlog, Ready, In Progress and Done.">
    </a>
    <figcaption>
        The agile workflow needs only four statuses and three transitions.
    </figcaption>
</figure>

The agile workflow consists of the statuses

* Backlog
* Ready
* In Progress
* and Done.

A direct comparison with the [Scrum-Guide] [2] shows that these statuses are also mentioned there and can be derived from there as well.
Thus this workflow is especially suitable if Scrum is used.

All statuses are described in the following.

### Backlog

Items in the backlog still need to be improved before work can begin on these.
In planning meetings, such as a backlog refinement, the entries are adjusted to meet the definition of ready.
These entries may still be rewritten or split into several entries if they are too large.

### Ready

Entries that are in "Ready" status are ready to be worked on.
The team members can pick up these items by following the "pull principle" as soon as they have completed previous entries and have time for new work.

### In Progress

As soon as a team member works on an item, the item receives the status "In Progress".
The item remains in this status until all criteria of the Definition of Done are met.
It is no longer possible to put an item back into a previous status.
Once work has been started, it must be completed.

### Done

The Definition of Done sets out rules that must be met in order for an item to be considered done.
An item is considered "Done " when all these criteria are met.

## Transistions

The three necessary transitions are described below.
Each of these transitions has its own requirements that must be met before an item can change its status.
In general, there are no loops or repetitions.
An item can therefore only proceed linearly in one direction through the workflow.

### Backlog to Ready

Only entries that meet the Definition of Ready can switch from Backlog status to Ready.
The definition of which rules must be fulfilled is set by the team.

### Ready to In Progress

Usually, a so-called work-in-progress limit (WIP limit) regulates whether work on a new item may be started.
The WIP limit determines the maximum number of items that can have the same status.
For some teams this is a reason to introduce new statuses to bypass this limit.
However, the WIP limit is intended to ensure that work that is already in progress is completed before new work is started. 

### In Progress to Done

Similar to the transition from Backlog to Ready, the Definition of Done determines which items can be considered done.
Only when all criteria are met, the item may change its status to "Done".
With the transition from In Progress to Done the life cycle of an item ends.
It is not allowed to "reopen" (i.e. to go back to a previous status) an already completed item.

## Working with the workflow

The easiest way to work with the process is to use a physical board.
For this, a kanban board is painted on a whiteboard, as shown in the following graphic.
Colorful sticky notes act as items and can be moved on the board.

<figure>
    <a href="/images/2019-02-29-agile-workflow/board.svg">
        <img src="/images/2019-02-29-agile-workflow/board.svg" alt="Kanban Board">
    </a>
    <figcaption>
        The statuses can be displayed as columns on a kanban-like board.
    </figcaption>
</figure>

The items move throughout the board from left to right.
The sorting from top to bottom specifies the order in which the items should be worked on.
This is especially important for the backlog column, where the most valuable items are placed at the top.

In general, the items should be processed in the order from the top right to the bottom left.
This way, the entries that provide the most value are finished first, and work already started is completed before new work is started.

The following phrase can be used as a reminder:

> „Start finishing, stop starting.“

With a red line (as shown in the figure) the team can agree to complete the most important entries first.
Such a line could be the perimeter of a sprint in Scrum, for example.

## "But we need..."

Sometimes there is a good reason to use an extra status.
But often this is not necessary.
In this chapter I would like to give some examples of statuses that should better not be used.

### Blocked

Items that are in "blocked" status cannot be worked on any further.
Such a situation is actually an exception in general.
So there is no reason why a dedicated status should be created for this.
Often these are situations that could be prevented in advance with a Definition of Ready.
Items that are already likely to be "blocked" should not even be set to "Ready" or even "In Progress".

Assuming that some preparation work from another team is required, such as obtaining a server or providing information,
the item should not be moved to "Ready" until this preparation work is complete.

If a blocker does occur, such an item can be marked with a red Post-It on a physical board.

In order to be able to complete a part of the work already, an item can also be split.
To do so, simply create a new item for the remaining work, which is then moved to the backlog.

### Waiting for...

Intermediate steps and waiting positions do not need to be recorded if the team is communicating with each other.
Testers and developers should therefore improve communication about what tasks still need to be done to complete an item.
This can then eliminate statuses such as "Waiting for test" or "Waiting for code review".

In software for code reviews it is often possible to define different types of approval.
This allows you to actively search for the tasks that are still pending.

### Feedback

The feedback status is a popular way to address questions to the product owner or project manager.
Often the item is directly assigned to the project manager and thus disappears from the own agenda.
Similar to blocked entries, this often results in the item not yet being "Ready".
Ultimately, the status "Feedback" is a concrete expression of "Blocked".
On a physical board you can again use a Post-It with a question mark to indicate that there are open questions.

### Ready for rollout / Deployed to X

Whether the work of an item has already been rolled out is better recorded with a field for the version.
If the item appears in the changelog, you know that the changes are included.
An extra status is not necessary for this.

## Using a physical board

For the beginning it is a good idea to use a physical board.
Of course, this only works if all team members work in the same office on site.
For remote work it is recommended to use simple tools like Trello.
But it is also possible to use complex software, like Jira, where the workflow can be adjusted.

## TLDR;

1. reduce the status of the entries to
    * Backlog
    * Ready
    * In progress
    * Done
2. starts, if possible, with a physical board
3. use the Definition of Done and Definition of Ready
4. use direct communication to answer questions

[1]: https://agilemanifesto.org/
[2]: https://www.scrumguides.org/scrum-guide.html

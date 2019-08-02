Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D77EFE7
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbfHBJJG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 05:09:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHBJJG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 05:09:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D4A344;
        Fri,  2 Aug 2019 02:09:05 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B31023F575;
        Fri,  2 Aug 2019 02:09:02 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH v13 0/6] Add utilization clamping support (CGroups API)
Date:   Fri,  2 Aug 2019 10:08:47 +0100
Message-Id: <20190802090853.4810-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all, this is a respin of:

  https://lore.kernel.org/lkml/20190718181748.28446-1-patrick.bellasi@arm.com/

which introduces these small changes:

- move common code from cpu_uclamp_{min,max}_write() into
  cpu_uclamp_write(clamp_id)
- comment rewording: update all RUNNABLE tasks on system default changes only
  when cgroups are in use.

The series is based on top of today's tip/sched/core:

  commit a1dc0446d649 ("sched/core: Silence a warning in sched_init()")

Thanks Michal for your additional review!

Since Tejun seems to be happy regarding cgroup integration:

   https://lore.kernel.org/lkml/20190729200606.GA136335@devbig004.ftw2.facebook.com/

and the are no substantial changes in the code functionalities with respect to
v12, this series adds Tejun's ACK tag.

Cheers,
Patrick


Series Organization
===================

The full tree is available here:

   git://linux-arm.org/linux-pb.git   lkml/utilclamp_v13
   http://www.linux-arm.org/git?p=linux-pb.git;a=shortlog;h=refs/heads/lkml/utilclamp_v13


Newcomer's Short Abstract
=========================

The Linux scheduler tracks a "utilization" signal for each scheduling entity
(SE), e.g. tasks, to know how much CPU time they use. This signal allows the
scheduler to know how "big" a task is and, in principle, it can support
advanced task placement strategies by selecting the best CPU to run a task.
Some of these strategies are represented by the Energy Aware Scheduler [1].

When the schedutil cpufreq governor is in use, the utilization signal allows
the Linux scheduler to also drive frequency selection. The CPU utilization
signal, which represents the aggregated utilization of tasks scheduled on that
CPU, is used to select the frequency which best fits the workload generated by
the tasks.

The current translation of utilization values into a frequency selection is
simple: we go to max for RT tasks or to the minimum frequency which can
accommodate the utilization of DL+FAIR tasks.
However, utilization values by themselves cannot convey the desired
power/performance behaviors of each task as intended by user-space.
As such they are not ideally suited for task placement decisions.

Task placement and frequency selection policies in the kernel can be improved
by taking into consideration hints coming from authorized user-space elements,
like for example the Android middleware or more generally any "System
Management Software" (SMS) framework.

Utilization clamping is a mechanism which allows to "clamp" (i.e. filter) the
utilization generated by RT and FAIR tasks within a range defined by user-space.
The clamped utilization value can then be used, for example, to enforce a
minimum and/or maximum frequency depending on which tasks are active on a CPU.

The main use-cases for utilization clamping are:

 - boosting: better interactive response for small tasks which
   are affecting the user experience.

   Consider for example the case of a small control thread for an external
   accelerator (e.g. GPU, DSP, other devices). Here, from the task utilization
   the scheduler does not have a complete view of what the task's requirements
   are and, if it's a small utilization task, it keeps selecting a more energy
   efficient CPU, with smaller capacity and lower frequency, thus negatively
   impacting the overall time required to complete task activations.

 - capping: increase energy efficiency for background tasks not affecting the
   user experience.

   Since running on a lower capacity CPU at a lower frequency is more energy
   efficient, when the completion time is not a main goal, then capping the
   utilization considered for certain (maybe big) tasks can have positive
   effects, both on energy consumption and thermal headroom.
   This feature allows also to make RT tasks more energy friendly on mobile
   systems where running them on high capacity CPUs and at the maximum
   frequency is not required.

From these two use-cases, it's worth noticing that frequency selection
biasing, introduced by patches 9 and 10 of this series, is just one possible
usage of utilization clamping. Another compelling extension of utilization
clamping is in helping the scheduler in making tasks placement decisions.

Utilization is (also) a task specific property the scheduler uses to know
how much CPU bandwidth a task requires, at least as long as there is idle time.
Thus, the utilization clamp values, defined either per-task or per-task_group,
can represent tasks to the scheduler as being bigger (or smaller) than what
they actually are.

Utilization clamping thus enables interesting additional optimizations, for
example on asymmetric capacity systems like Arm big.LITTLE and DynamIQ CPUs,
where:

 - boosting: try to run small/foreground tasks on higher-capacity CPUs to
   complete them faster despite being less energy efficient.

 - capping: try to run big/background tasks on low-capacity CPUs to save power
   and thermal headroom for more important tasks

This series does not present this additional usage of utilization clamping but
it's an integral part of the EAS feature set, where [2] is one of its main
components.

Android kernels use SchedTune, a solution similar to utilization clamping, to
bias both 'frequency selection' and 'task placement'. This series provides the
foundation to add similar features to mainline while focusing, for the
time being, just on schedutil integration.


References
==========

[1] Energy Aware Scheduling
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-energy.txt?h=v5.1

[2] Expressing per-task/per-cgroup performance hints
    Linux Plumbers Conference 2018
    https://linuxplumbersconf.org/event/2/contributions/128/


Patrick Bellasi (6):
  sched/core: uclamp: Extend CPU's cgroup controller
  sched/core: uclamp: Propagate parent clamps
  sched/core: uclamp: Propagate system defaults to root group
  sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
  sched/core: uclamp: Update CPU's refcount on TG's clamp changes
  sched/core: uclamp: always use enum uclamp_id for clamp_id values

 Documentation/admin-guide/cgroup-v2.rst |  34 +++
 init/Kconfig                            |  22 ++
 kernel/sched/core.c                     | 375 ++++++++++++++++++++++--
 kernel/sched/sched.h                    |  12 +-
 4 files changed, 421 insertions(+), 22 deletions(-)

-- 
2.22.0


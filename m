Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88C368088
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 14:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhDVMe0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 22 Apr 2021 08:34:26 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:5106 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhDVMeZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 08:34:25 -0400
Subject: [RFC PATCH] Android OOM helper proof of concept
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz>
 <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz>
 <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
 <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <e01ee3aa-cbcb-dae2-ebcc-aba8b01d8aef@sony.com>
Date:   Thu, 22 Apr 2021 14:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=IkcTkHD0fZMA:10 a=3YhXtTcJ-WEA:10 a=iox4zFpeAAAA:8 a=z6gsHLkEAAAA:8 a=FyX8BiV9-lCGZTZ29yIA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/21/21 4:29 PM, Michal Hocko wrote:
> On Wed 21-04-21 06:57:43, Shakeel Butt wrote:
>> On Wed, Apr 21, 2021 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
>> [...]
>>>> To decide when to kill, the oom-killer has to read a lot of metrics.
>>>> It has to open a lot of files to read them and there will definitely
>>>> be new allocations involved in those operations. For example reading
>>>> memory.stat does a page size allocation. Similarly, to perform action
>>>> the oom-killer may have to read cgroup.procs file which again has
>>>> allocation inside it.
>>> True but many of those can be avoided by opening the file early. At
>>> least seq_file based ones will not allocate later if the output size
>>> doesn't increase. Which should be the case for many. I think it is a
>>> general improvement to push those who allocate during read to an open
>>> time allocation.
>>>
>> I agree that this would be a general improvement but it is not always
>> possible (see below).
> It would be still great to invest into those improvements. And I would
> be really grateful to learn about bottlenecks from the existing kernel
> interfaces you have found on the way.
>
>>>> Regarding sophisticated oom policy, I can give one example of our
>>>> cluster level policy. For robustness, many user facing jobs run a lot
>>>> of instances in a cluster to handle failures. Such jobs are tolerant
>>>> to some amount of failures but they still have requirements to not let
>>>> the number of running instances below some threshold. Normally killing
>>>> such jobs is fine but we do want to make sure that we do not violate
>>>> their cluster level agreement. So, the userspace oom-killer may
>>>> dynamically need to confirm if such a job can be killed.
>>> What kind of data do you need to examine to make those decisions?
>>>
>> Most of the time the cluster level scheduler pushes the information to
>> the node controller which transfers that information to the
>> oom-killer. However based on the freshness of the information the
>> oom-killer might request to pull the latest information (IPC and RPC).
> I cannot imagine any OOM handler to be reliable if it has to depend on
> other userspace component with a lower resource priority. OOM handlers
> are fundamentally complex components which has to reduce their
> dependencies to the bare minimum.


I think we very much need a OOM killer that can help out,
but it is essential that it also play with android rules.

This is RFC patch that interact with OOM

From 09f3a2e401d4ed77e95b7cea7edb7c5c3e6a0c62 Mon Sep 17 00:00:00 2001
From: Peter Enderborg <peter.enderborg@sony.com>
Date: Thu, 22 Apr 2021 14:15:46 +0200
Subject: [PATCH] mm/oom: Android oomhelper

This is proff of concept of a pre-oom-killer that kill task
strictly on oom-score-adj order if the score is positive.

It act as lifeline when userspace does not have optimal performance.
---
 drivers/staging/Makefile              |  1 +
 drivers/staging/oomhelper/Makefile    |  2 +
 drivers/staging/oomhelper/oomhelper.c | 65 +++++++++++++++++++++++++++
 mm/oom_kill.c                         |  4 +-
 4 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/oomhelper/Makefile
 create mode 100644 drivers/staging/oomhelper/oomhelper.c

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2245059e69c7..4a5449b42568 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_QLGE)        += qlge/
 obj-$(CONFIG_WIMAX)        += wimax/
 obj-$(CONFIG_WFX)        += wfx/
 obj-y                += hikey9xx/
+obj-y                += oomhelper/
diff --git a/drivers/staging/oomhelper/Makefile b/drivers/staging/oomhelper/Makefile
new file mode 100644
index 000000000000..ee9b361957f8
--- /dev/null
+++ b/drivers/staging/oomhelper/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y    += oomhelper.o
diff --git a/drivers/staging/oomhelper/oomhelper.c b/drivers/staging/oomhelper/oomhelper.c
new file mode 100644
index 000000000000..5a3fe0270cb8
--- /dev/null
+++ b/drivers/staging/oomhelper/oomhelper.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* prof of concept of android aware oom killer */
+/* Author: peter.enderborg@sony.com */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/oom.h>
+void wake_oom_reaper(struct task_struct *tsk); /* need to public ... */
+void __oom_kill_process(struct task_struct *victim, const char *message);
+
+static int oomhelper_oom_notify(struct notifier_block *self,
+                      unsigned long notused, void *param)
+{
+  struct task_struct *tsk;
+  struct task_struct *selected = NULL;
+  int highest = 0;
+
+  pr_info("invited");
+  rcu_read_lock();
+  for_each_process(tsk) {
+      struct task_struct *candidate;
+      if (tsk->flags & PF_KTHREAD)
+          continue;
+
+      /* Ignore task if coredump in progress */
+      if (tsk->mm && tsk->mm->core_state)
+          continue;
+      candidate = find_lock_task_mm(tsk);
+      if (!candidate)
+          continue;
+
+      if (highest < candidate->signal->oom_score_adj) {
+          /* for test dont kill level 0 */
+          highest = candidate->signal->oom_score_adj;
+          selected = candidate;
+          pr_info("new selected %d %d", selected->pid,
+              selected->signal->oom_score_adj);
+      }
+      task_unlock(candidate);
+  }
+  if (selected) {
+      get_task_struct(selected);
+  }
+  rcu_read_unlock();
+  if (selected) {
+      pr_info("oomhelper killing: %d", selected->pid);
+      __oom_kill_process(selected, "oomhelper");
+  }
+
+  return NOTIFY_OK;
+}
+
+static struct notifier_block oomhelper_oom_nb = {
+    .notifier_call = oomhelper_oom_notify
+};
+
+int __init oomhelper_register_oom_notifier(void)
+{
+    register_oom_notifier(&oomhelper_oom_nb);
+    pr_info("oomhelper installed");
+    return 0;
+}
+
+subsys_initcall(oomhelper_register_oom_notifier);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index fa1cf18bac97..a5f7299af9a3 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -658,7 +658,7 @@ static int oom_reaper(void *unused)
     return 0;
 }
 
-static void wake_oom_reaper(struct task_struct *tsk)
+void wake_oom_reaper(struct task_struct *tsk)
 {
     /* mm is already queued? */
     if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
@@ -856,7 +856,7 @@ static bool task_will_free_mem(struct task_struct *task)
     return ret;
 }
 
-static void __oom_kill_process(struct task_struct *victim, const char *message)
+void __oom_kill_process(struct task_struct *victim, const char *message)
 {
     struct task_struct *p;
     struct mm_struct *mm;
-- 
2.17.1

Is that something that might be accepted?

It uses the notifications and that is no problem a guess.

But it also calls some oom-kill functions that is not exported.


>  
>> [...]
>>>> I was thinking of simply prctl(SET_MEMPOOL, bytes) to assign mempool
>>>> to a thread (not shared between threads) and prctl(RESET_MEMPOOL) to
>>>> free the mempool.
>>> I am not a great fan of prctl. It has become a dumping ground for all
>>> mix of unrelated functionality. But let's say this is a minor detail at
>>> this stage.
>> I agree this does not have to be prctl().
>>
>>> So you are proposing to have a per mm mem pool that would be
>> I was thinking of per-task_struct instead of per-mm_struct just for simplicity.
>>
>>> used as a fallback for an allocation which cannot make a forward
>>> progress, right?
>> Correct
>>
>>> Would that pool be preallocated and sitting idle?
>> Correct
>>
>>> What kind of allocations would be allowed to use the pool?
>> I was thinking of any type of allocation from the oom-killer (or
>> specific threads). Please note that the mempool is the backup and only
>> used in the slowpath.
>>
>>> What if the pool is depleted?
>> This would mean that either the estimate of mempool size is bad or
>> oom-killer is buggy and leaking memory.
>>
>> I am open to any design directions for mempool or some other way where
>> we can provide a notion of memory guarantee to oom-killer.
> OK, thanks for clarification. There will certainly be hard problems to
> sort out[1] but the overall idea makes sense to me and it sounds like a
> much better approach than a OOM specific solution.
>
>
> [1] - how the pool is going to be replenished without hitting all
> potential reclaim problems (thus dependencies on other all tasks
> directly/indirectly) yet to not rely on any background workers to do
> that on the task behalf without a proper accounting etc...



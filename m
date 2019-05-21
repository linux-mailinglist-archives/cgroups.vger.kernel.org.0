Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC16C254D5
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfEUQFH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 12:05:07 -0400
Received: from mailgate2.uni-hannover.de ([130.75.2.114]:53604 "EHLO
        mailgate2.uni-hannover.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEUQFG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 May 2019 12:05:06 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 12:05:03 EDT
Received: from kolab.sra.uni-hannover.de (kolab.sra.uni-hannover.de [130.75.33.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgate2.uni-hannover.de (Postfix) with ESMTPS id 6426A2087;
        Tue, 21 May 2019 17:55:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sra.uni-hannover.de
Received: from lab.sra.uni-hannover.de (aerobus.sra.uni-hannover.de
 [130.75.33.87])
 by kolab.sra.uni-hannover.de (Postfix) with SMTP id 1984B3E027C;
 Tue, 21 May 2019 17:55:22 +0200 (CEST)
Received: (nullmailer pid 14993 invoked by uid 20151);
 Tue, 21 May 2019 15:55:41 -0000
From:   Lukas Prause <langspielplatte@black-mesa.xyz>
To:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        rostedt@goodmis.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukas Prause <langspielplatte@black-mesa.xyz>,
        Lennart Glauer <mail@lennart-glauer.de>
Subject: [PATCH] Fix comments with paths pointing to renamed or moved files.
Date:   Tue, 21 May 2019 17:54:30 +0200
Message-Id: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch corrects renamed or moved paths in comments.

Signed-off-by: Lukas Prause <langspielplatte@black-mesa.xyz>
Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>
---
 kernel/cgroup/cpuset.c       |  2 +-
 kernel/locking/mutex-debug.h |  2 +-
 kernel/power/power.h         |  2 +-
 kernel/sched/core.c          |  2 +-
 kernel/trace/trace.h         | 14 +++++++-------
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6a1942ed781c..6381622e2f2f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -329,7 +329,7 @@ static struct cpuset top_cpuset = {
  * cpumasks and nodemasks.
  *
  * Accessing a task's cpuset should be done in accordance with the
- * guidelines for accessing subsystem state in kernel/cgroup.c
+ * guidelines for accessing subsystem state in kernel/cgroup/cgroup.c
  */
 
 static DEFINE_MUTEX(cpuset_mutex);
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f45a4ec..0dee0a07cd4c 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -8,7 +8,7 @@
  *
  * This file contains mutex debugging related internal declarations,
  * prototypes and inline functions, for the CONFIG_DEBUG_MUTEXES case.
- * More details are in kernel/mutex-debug.c.
+ * More details are in kernel/locking/mutex-debug.c.
  */
 
 /*
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 9e58bdc8a562..5de8b0c7f657 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -182,7 +182,7 @@ extern int swsusp_unmark(void);
 #endif
 
 struct timeval;
-/* kernel/power/swsusp.c */
+/* kernel/power/hibernate.c */
 extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
 
 #ifdef CONFIG_SUSPEND
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..0ce0dc44ffc3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3334,7 +3334,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
  *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *      paths. For example, see arch/x86/entry/entry_64.S.
  *
  *      To drive preemption between tasks, the scheduler sets the flag in timer
  *      interrupt handler scheduler_tick().
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1974ce818ddb..0c304d6f5b31 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1684,7 +1684,7 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  *	initialization such as incrementing a per-trigger reference
  *	count, for instance.  This is usually implemented by the
  *	generic utility function @event_trigger_init() (see
- *	trace_event_triggers.c).
+ *	trace_events_trigger.c).
  *
  * @free: An optional de-initialization function called for the
  *	trigger when the trigger is unregistered (via the
@@ -1693,12 +1693,12 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  *	per-trigger reference count and freeing corresponding trigger
  *	data, for instance.  This is usually implemented by the
  *	generic utility function @event_trigger_free() (see
- *	trace_event_triggers.c).
+ *	trace_events_trigger.c).
  *
  * @print: The callback function invoked to have the trigger print
  *	itself.  This is usually implemented by a wrapper function
  *	that calls the generic utility function @event_trigger_print()
- *	(see trace_event_triggers.c).
+ *	(see trace_events_trigger.c).
  */
 struct event_trigger_ops {
 	void			(*func)(struct event_trigger_data *data,
@@ -1758,7 +1758,7 @@ struct event_trigger_ops {
  *	the appropriate trace event.  It makes use of the other
  *	event_command callback functions to orchestrate this, and is
  *	usually implemented by the generic utility function
- *	@event_trigger_callback() (see trace_event_triggers.c).
+ *	@event_trigger_callback() (see trace_events_trigger.c).
  *
  * @reg: Adds the trigger to the list of triggers associated with the
  *	event, and enables the event trigger itself, after
@@ -1767,13 +1767,13 @@ struct event_trigger_ops {
  *	make the decision as to whether or not multiple instances of
  *	the trigger should be allowed.  This is usually implemented by
  *	the generic utility function @register_trigger() (see
- *	trace_event_triggers.c).
+ *	trace_events_trigger.c).
  *
  * @unreg: Removes the trigger from the list of triggers associated
  *	with the event, and disables the event trigger itself, after
  *	initializing it (via the event_trigger_ops @free() function).
  *	This is usually implemented by the generic utility function
- *	@unregister_trigger() (see trace_event_triggers.c).
+ *	@unregister_trigger() (see trace_events_trigger.c).
  *
  * @unreg_all: An optional function called to remove all the triggers
  *	from the list of triggers associated with the event.  Called
@@ -1783,7 +1783,7 @@ struct event_trigger_ops {
  *	for the trigger.  If no @set_filter() method is set for the
  *	event command, filters set by the user for the command will be
  *	ignored.  This is usually implemented by the generic utility
- *	function @set_trigger_filter() (see trace_event_triggers.c).
+ *	function @set_trigger_filter() (see trace_events_trigger.c).
  *
  * @get_trigger_ops: The callback function invoked to retrieve the
  *	event_trigger_ops implementation associated with the command.
-- 
2.17.1

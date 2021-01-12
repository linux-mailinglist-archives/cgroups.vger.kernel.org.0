Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1F2F34D3
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392580AbhALP4S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 10:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392585AbhALP4S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 10:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610466891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOhI5g5i5LSzzWOHJu+RbadpKHs6IKldH+QIJhJVpUE=;
        b=ThTVJchzKYG3e7UAy7k1bu0sMfAYkekdgNfm0HzxswNmbIwJBW0BJkTWZNcfDh0NkB6vN1
        4lrpU2qU1uLSHsALzU5g51tPXl7oTFTaz3FIejuSa4hsKwq7B2d4SSRKIefQbKjYqCmBGK
        0/wyz9LKAl5a9sZJo5/PwvYoHjQZZjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-nomEZXpxPgmLm-ZWESHhUg-1; Tue, 12 Jan 2021 10:54:49 -0500
X-MC-Unique: nomEZXpxPgmLm-ZWESHhUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E087107ACF7;
        Tue, 12 Jan 2021 15:54:47 +0000 (UTC)
Received: from x1.com (ovpn-113-251.rdu2.redhat.com [10.10.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 837CE5D9CD;
        Tue, 12 Jan 2021 15:54:43 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 6/6] sched/deadline: Fixes cpu/rd/dl_bw references for suspended tasks
Date:   Tue, 12 Jan 2021 16:53:45 +0100
Message-Id: <8c1cb0c850e2f3ab1d7a533aa4b33a30f9dbeda5.1610463999.git.bristot@redhat.com>
In-Reply-To: <cover.1610463999.git.bristot@redhat.com>
References: <cover.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__set_cpus_allowed_ptr() migrates running or runnable, setting the
task's cpu accordingly. The CPU is not set when the task is not
runnable because of complications on the hotplug code. The
task cpu will be updated in the next wakeup anyway.

However, this creates a problem for the usage of task_cpu(p), which
might point the task to a CPU in which it cannot run, or worse,
a runqueue/root_domain it does not belong to, causing some
odd errors. For example, the script below shows that a sleeping
task cannot become SCHED_DEADLINE if they moved to another (exclusive)
cpuset:

----- %< -----
  #!/bin/bash
  # Enter on the cgroup directory
  cd /sys/fs/cgroup/

  # Check it if is cgroup v2 and enable cpuset
  if [ -e cgroup.subtree_control ]; then
  	# Enable cpuset controller on cgroup v2
  	echo +cpuset > cgroup.subtree_control
  fi

  echo LOG: create an exclusive cpuset and assigned the CPU 0 to it
  # Create cpuset groups
  rmdir dl-group &> /dev/null
  mkdir dl-group

  # Restrict the task to the CPU 0
  echo 0 > dl-group/cpuset.mems
  echo 0 > dl-group/cpuset.cpus
  echo root >  dl-group/cpuset.cpus.partition

  echo LOG: dispatching a regular task
  sleep 100 &
  CPUSET_PID="$!"

  # let it settle down
  sleep 1

  # Assign the second task to the cgroup
  echo LOG: moving the second DL task to the cpuset
  echo "$CPUSET_PID" > dl-group/cgroup.procs 2> /dev/null

  CPUSET_ALLOWED=`cat /proc/$CPUSET_PID/status | grep Cpus_allowed_list | awk '{print $2}'`

  chrt -p -d --sched-period 1000000000 --sched-runtime 100000000 0 $CPUSET_PID
  ACCEPTED=$?

  if [ $ACCEPTED == 0 ]; then
  	echo PASS: the task became DL
  else
  	echo FAIL: the task was rejected as DL
  fi

  # Just ignore the clean up
  exec > /dev/null 2>&1
  kill -9 $CPUSET_PID
  kill -9 $ROOT_PID
  rmdir dl-group
----- >% -----

Long story short: the sleep task is (not runnable) on a cpu != 0. After
moving to a cpuset with only the CPU 0, task_cpu() returns a cpu that
does not belong to the cpuset the task is in, and the task is rejected
in this if:

----- %< -----
__sched_setscheduler():
[...]
        rq = task_rq_lock(p, &rf); <-- uses task_cpu(), that points to
				   <-- the old cpu.
[...]
                if (dl_bandwidth_enabled() && dl_policy(policy) &&
                                !(attr->sched_flags & SCHED_FLAG_SUGOV)) {
                        cpumask_t *span = rq->rd->span;        <--- wrong rd!

                        /*
                         * Don't allow tasks with an affinity mask smaller than
                         * the entire root_domain to become SCHED_DEADLINE. We
                         * will also fail if there's no bandwidth available.
                         */
                        if (!cpumask_subset(span, p->cpus_ptr) ||
                            rq->rd->dl_bw.bw == 0) {
                                retval = -EPERM;   <--- returns here.
                                goto unlock;
                        }
                }
----- >% -----

Because the rq, and so the root domain, corresponding to the ones of
the CPU in which the sleep command went to... sleep, not the ones
it will run in the next wakeup because of its affinity.

To avoid this problem, use the dl_task* helpers that return the task
cpu, root domain, and the "root" dl_bw, aware of the status of
task->cpu.

Reported-by: Marco Perronet <perronet@mpi-sws.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 kernel/sched/core.c     | 6 +++---
 kernel/sched/deadline.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5961a97541c2..3c2775e6869f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5905,15 +5905,15 @@ static int __sched_setscheduler(struct task_struct *p,
 #ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
-			cpumask_t *span = rq->rd->span;
+			struct root_domain *rd = dl_task_rd(p);
 
 			/*
 			 * Don't allow tasks with an affinity mask smaller than
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
-			    rq->rd->dl_bw.bw == 0) {
+			if (!cpumask_subset(rd->span, p->cpus_ptr) ||
+			    rd->dl_bw.bw == 0) {
 				retval = -EPERM;
 				goto unlock;
 			}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c221e14d5b86..1f6264cb8867 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2678,8 +2678,8 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	u64 period = attr->sched_period ?: attr->sched_deadline;
 	u64 runtime = attr->sched_runtime;
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
-	int cpus, err = -1, cpu = task_cpu(p);
-	struct dl_bw *dl_b = dl_bw_of(cpu);
+	int cpus, err = -1, cpu = dl_task_cpu(p);
+	struct dl_bw *dl_b = dl_task_root_bw(p);
 	unsigned long cap;
 
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
-- 
2.29.2


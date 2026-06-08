Return-Path: <cgroups+bounces-16717-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qwAdAIWzJmqtbQIAu9opvQ
	(envelope-from <cgroups+bounces-16717-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9665614F
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dOlAHn18;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16717-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16717-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E17A83013B92
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD03B47F3;
	Mon,  8 Jun 2026 12:16:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC68379EC8
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920966; cv=none; b=SlzBpzx6EnpWgJoNf+p3mpbcg44X7IRgpkfugMp3y9wlYTm1ryKtfSjMECK0+6pZN0kJohMtmAEoAp/dU6dumMkrxtwVF13jV2hvUCH2E7LyJONHEqrlv3A6ijaDVeE3pu6yX4cesB01Ho6YpKQV0gF6DbG57LqQBTNa/KkEUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920966; c=relaxed/simple;
	bh=bFpBJKY+dY1TRn8e9BmV1Ywb6ktkznGZhF8ataM/d3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj6tl2I1Td+HJI0ZXTuST0Ym+TJ1NGKhVYswsE4Ccg67fBTeBGhf2Ww4CSaQghE5uludlPPh7GlLTRA9X16RW7vkpqATfScy+/djYO7+yHeOpAOgRj5kA9I+LSulIi3c87pPz/zZa4w7icYHfnS/7tGwqTEfT2nbpcnRbx2PcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOlAHn18; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2797667f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920962; x=1781525762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4pbifYzHaqVoXX1q5IVhVdB74Q/h2EMaW5Z7DLocPs=;
        b=dOlAHn18fkvkPv5DVbs9H2FuIi73oh6Ow6aSyPh8Yzj6QkZwuGsYOl0OkZeJ1OpK7E
         pW4xEoO2kmmPPKekSh9KZKcokPwWheAPFu5fhN4C6iZq2vYenrgQls4fv9ynjdI6NMNc
         sGiYHjvCiVA4nlaRy36XRK6wIPKYaNR0YL2PfAKJphUPf/0xfXUCie70ydkH5iUXnwo+
         8/QLGQjCiUtfE5X6nt/VYhgZjAyoIhs/45Uig+MLeMVf0PMpjGSKOLHI+a43tJ6Zzy5Y
         eN3Mm3/0rImAuqpJlOR95U7HfNaYr3st+LmXCFMo8yWAqBmvZtyGPjqAHlw785MWwKrO
         Hq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920962; x=1781525762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4pbifYzHaqVoXX1q5IVhVdB74Q/h2EMaW5Z7DLocPs=;
        b=UmHyks5wAJjdTb+CSduOW6mESwXGG+kIDhdgEMXuLKyLwqey6fhscbAgPejuLF4zt5
         y8tSyX5D9t+hqOpo7zH6Y7w74PULf6w2BIyLauAunciZpJAkx3SgyK1HrKJBjhX12mJu
         pEYLVL6HvGsWoFGPBfH1FGitM1uRUOr6xr9Wqrik7LEfl3SukSv+X/etpplL3/gMW4X+
         w0btvRDmUxcchyRB2jyQ/gBIyDNHwlqI9abpMf7CntxUDMvt6dbdvUk4M5PkYMWkU8gW
         LX6fBh7KONE9QpUaD+0BDetxIqcS3pMYSkD31hGjlrYJnIF1Cp99vX/UKRZ5E5GGq2N6
         vseA==
X-Gm-Message-State: AOJu0YygyLcdn1rb55RMg4ctejb7I+K9wu0wBpkS2ipY2b8545Z/E9TL
	xvnMl0Eg1ZZJCayf12+smr4pw/VNb6CzwwXe8xbMOhl9B8Fe5XXi5x4D
X-Gm-Gg: Acq92OHLSzR8nQAGIyCTfD6dLyD+JqJXc+EB3In6x+/e6UNpyKpF+kLECOzon+vRLbX
	WFrY9hNEuXRhONUc5dZDMSScU7yLiRUdcmfml3Wk0yMnsMxX9K9oaH7kzJAsVzSswYlHz+e9CIE
	B9iUXNEiQ2j8sHLnSTgYO6JyE7eivVjO4wNy2x63I01BKKOHt9WbpCH6NZpxJJNBMkGH0pdacLC
	x0QGjjmlmX8M9b9Z0fE17rkVf94R8wzBbo4XRkucTc0QLHKUWY1eZ4yBL265yPyx7FQAb7MK2Uc
	3MIRAJh3X1w4umRCJ3Gw9qcgsybhyhR6R1U7oEf+FYXhVvke1nKpHfRdwSa4p20PG1j1Jqn4KgZ
	64Pvb9dM8aKE/t5WLn0UkJu9CAf8v7NMR3B+eOP6uaB6hCSSH60vgXEwWTZsRWJuv+Y2GdHuJ0g
	akuuWjx/KT5idycnpht2iASBdYwNs6HCI=
X-Received: by 2002:a5d:5a4c:0:b0:452:273:5cd6 with SMTP id ffacd0b85a97d-460302e3749mr17960879f8f.1.1780920962145;
        Mon, 08 Jun 2026 05:16:02 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:01 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 15/25] sched/rt: Update task event callbacks for HCBS scheduling
Date: Mon,  8 Jun 2026 14:15:34 +0200
Message-ID: <20260608121546.69910-16-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16717-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sssup.it:email,vger.kernel.org:from_smtp,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BB9665614F

Update wakeup_preempt_rt, switched_{from/to}_rt and prio_changed_rt with
rt-cgroup's specific preemption rules:

- In wakeup_preempt_rt(), whenever a task wakes up, it must be checked if
  it is served by a deadline server or it lives on the global runqueue.
  Preemption rules (as documented in the function), change based on the
  current task's donor and woken task runqueue:
  - If both tasks are FIFO/RR tasks on the global runqueue, or the same
    cgroup, run as normal.
  - If woken is inside a cgroup, but donor is a FIFO task on the global
    runqueue, always preempt. If donor is a DEADLINE task, check if the dl
    server preempts donor.
  - If both tasks are FIFO/RR tasks in served but different groups, check
    whether the woken server preempts the donor server.
- In prio_changed_rt(), if the task is not running, only run preemption
  checks if the running task resides on the same task group of the task
  that changed priority.

Update sched_rt_can_attach() to check if a task can be attached to a given
cgroup. For now the check only consists in checking if the group has
non-zero bandwidth. Remove the tsk argument from sched_rt_can_attach, as
it is unused.

Change cpu_cgroup_can_attach() to check if the attachee is a FIFO/RR
task before attaching it to a cgroup.

Update __sched_setscheduler() to perform checks when trying to switch
to FIFO/RR for a task inside a cgroup, as the group needs to have
runtime allocated.

Update task_is_throttled_rt() for SCHED_CORE, returning the is_throttled
value of the server if present, while global rt-tasks are never throttled.

Update migration functions to ignore cgroups migration, to be implemented
in later patches.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/rt.c       | 98 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h    |  2 +-
 kernel/sched/syscalls.c | 12 +++++
 4 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e47a02cfaf7..1252f45feda0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9545,7 +9545,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		goto scx_check;

 	cgroup_taskset_for_each(task, css, tset) {
-		if (!sched_rt_can_attach(css_tg(css), task))
+		if (rt_task(task) && !sched_rt_can_attach(css_tg(css)))
 			return -EINVAL;
 	}
 scx_check:
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 61e9dab894d1..168a92945b4a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -372,6 +372,9 @@ static inline void rt_queue_push_tasks(struct rt_rq *rt_rq)
 {
 	struct rq *rq = global_rq_of_rt_rq(rt_rq);

+	if (is_dl_group(rt_rq))
+		return;
+
 	if (!has_pushable_tasks(rt_rq))
 		return;

@@ -382,6 +385,9 @@ static inline void rt_queue_pull_task(struct rt_rq *rt_rq)
 {
 	struct rq *rq = global_rq_of_rt_rq(rt_rq);

+	if (is_dl_group(rt_rq))
+		return;
+
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }

@@ -1031,7 +1037,55 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor = rq->donor;
+	struct sched_dl_entity *woken_dl_se = NULL;
+	struct sched_dl_entity *donor_dl_se = NULL;
+
+	if (!rt_group_sched_enabled())
+		goto same_group_sched;
+
+	/*
+	 * Preemption checks are different if the waking task and the current donor
+	 * are running on the global runqueue or in a cgroup. The following rules
+	 * apply:
+	 *   - dl-tasks (and equally dl_servers) always preempt FIFO/RR tasks.
+	 *     - if donor is a FIFO/RR task inside a cgroup (i.e. run by a
+	 *       dl_server), or donor is a DEADLINE task and waking is a FIFO/RR
+	 *       task on the root cgroup, do nothing.
+	 *     - if waking is inside a cgroup but donor is a FIFO/RR task in the
+	 *       root cgroup, always reschedule.
+	 *   - if they are both on the global runqueue or in the same cgroup, run
+	 *     the standard code.
+	 *   - if they are both in a cgroup, but not the same one, check whether the
+	 *     woken task's dl_server preempts the donor's dl_server.
+	 *   - if donor is a DEADLINE task and waking is in a cgroup, check whether
+	 *     the woken task's server preempts donor.
+	 */
+	if (is_dl_group(rt_rq_of_se(&p->rt)))
+		woken_dl_se = dl_group_of(rt_rq_of_se(&p->rt));
+	if (is_dl_group(rt_rq_of_se(&donor->rt)))
+		donor_dl_se = dl_group_of(rt_rq_of_se(&donor->rt));
+	else if (task_has_dl_policy(donor))
+		donor_dl_se = &donor->dl;
+
+	if (woken_dl_se != NULL && donor_dl_se != NULL) {
+		if (woken_dl_se == donor_dl_se) {
+			goto same_group_sched;
+		}
+
+		if (dl_entity_preempt(woken_dl_se, donor_dl_se))
+			resched_curr(rq);
+
+		return;
+
+	} else if (woken_dl_se != NULL) {
+		resched_curr(rq);
+		return;
+
+	} else if (donor_dl_se != NULL) {
+		return;
+	}

+same_group_sched:
 	/*
 	 * XXX If we're preempted by DL, queue a push?
 	 */
@@ -1055,7 +1109,8 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
+	if (!is_dl_group(rt_rq_of_se(&p->rt)) &&
+	    p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 }

@@ -1362,6 +1417,9 @@ static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 	struct rt_rq *lowest_rt_rq;
 	int ret = 0;

+	if (is_dl_group(rt_rq))
+		return 0;
+
 	if (!rt_rq->overloaded)
 		return 0;

@@ -1668,6 +1726,9 @@ static void pull_rt_rq_task(struct rt_rq *this_rt_rq)
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);

+	if (is_dl_group(&this_rq->rt))
+		return;
+
 	if (likely(!rt_overload_count))
 		return;

@@ -1811,6 +1872,8 @@ static void rq_offline_rt(struct rq *rq)
  */
 static void switched_from_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	/*
 	 * If there are other RT tasks then we will reschedule
 	 * and the scheduling of the other RT tasks will handle
@@ -1818,10 +1881,10 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	 * we may need to handle the pulling of RT tasks
 	 * now.
 	 */
-	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+	if (!task_on_rq_queued(p) || rt_rq->rt_nr_running)
 		return;

-	rt_queue_pull_task(rt_rq_of_se(&p->rt));
+	rt_queue_pull_task(rt_rq);
 }

 void __init init_sched_rt_class(void)
@@ -1858,6 +1921,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p)) {
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
+
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -1870,6 +1934,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 static void
 prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
+
 	if (!task_on_rq_queued(p))
 		return;

@@ -1882,15 +1948,24 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 		 * may need to pull tasks to this runqueue.
 		 */
 		if (oldprio < p->prio)
-			rt_queue_pull_task(rt_rq_of_se(&p->rt));
+			rt_queue_pull_task(rt_rq);

 		/*
 		 * If there's a higher priority task waiting to run
 		 * then reschedule.
 		 */
-		if (p->prio > rq->rt.highest_prio.curr)
+		if (p->prio > rt_rq->highest_prio.curr)
 			resched_curr(rq);
 	} else {
+		/*
+		 * This task is not running, thus we check against the currently
+		 * running task for preemption. We can preempt only if both tasks are
+		 * in the same cgroup or on the global runqueue.
+		 */
+		if (rt_group_sched_enabled() &&
+		    rt_rq->tg != rt_rq_of_se(&rq->curr->rt)->tg)
+			return;
+
 		/*
 		 * This task is not running, but if it is
 		 * greater than the current running task
@@ -1983,7 +2058,16 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 #ifdef CONFIG_SCHED_CORE
 static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rt_rq *rt_rq;
+
+	rt_rq = task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
+
+	return dl_group_of(rt_rq)->dl_throttled;
+#else
 	return 0;
+#endif
 }
 #endif /* CONFIG_SCHED_CORE */

@@ -2222,10 +2306,10 @@ long sched_group_rt_period(struct task_group *tg)
 	return rt_period_us;
 }

-int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
+int sched_rt_can_attach(struct task_group *tg)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
+	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;

 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 66d5bd1aa4f1..bde49f216081 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -611,7 +611,7 @@ extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
 extern long sched_group_rt_period(struct task_group *tg);
-extern int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk);
+extern int sched_rt_can_attach(struct task_group *tg);

 extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 9c1ba10ea5a7..773f744c0460 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -606,6 +606,18 @@ int __sched_setscheduler(struct task_struct *p,
 change:

 	if (user) {
+		/*
+		 * Do not allow real-time tasks into groups that have no runtime
+		 * assigned.
+		 */
+		if (rt_group_sched_enabled() &&
+		    dl_bandwidth_enabled() && rt_policy(policy) &&
+		    !sched_rt_can_attach(task_group(p)) &&
+		    !task_group_is_autogroup(task_group(p))) {
+			retval = -EPERM;
+			goto unlock;
+		}
+
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
--
2.54.0



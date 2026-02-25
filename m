Return-Path: <cgroups+bounces-14293-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEA1GEiGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14293-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:19:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA4191F1C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 284683094936
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D0374162;
	Wed, 25 Feb 2026 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM0EI/UE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FC2F6922;
	Wed, 25 Feb 2026 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995735; cv=none; b=ALzKu2czh3D6AVFk7N5wsBr3MqhdP4UGbWJrPtYBc9SeJsvD/p6a6tRtiANRcOfbSfCk4wl/BR1fX5GSXWky6LndnQTkhaoChALCF1LgxxoQjXEiVDmBSFfNLoHEPSTpQqWgaV0yMI8+DATPUnayhAtEUHrS96pQbz1eS3vTN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995735; c=relaxed/simple;
	bh=3JVW7zy8fyR8QNtI7sRR+l1WaJYlfYyB0ELJrJ/Y5ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaXOb9cc/pnuJKyeUworJ3a8yRf9zoLoYtPZJdJxoI/dyUeftEtAXki+aJsWqt9uARLbP93mXqO8k1pZK8Cn/Gjg8KWlQZ2qj5MWnDJ9KIOpX7EUksNkVJYs8LYtMqgu6Rnybm1E+ruGkJ4tDHOVfqiQuUNByczA50uliiKvj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM0EI/UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A2C116D0;
	Wed, 25 Feb 2026 05:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995734;
	bh=3JVW7zy8fyR8QNtI7sRR+l1WaJYlfYyB0ELJrJ/Y5ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM0EI/UEzZPd9CtDpgmwAhSwE7ta2Y6InVEWaQq6R6CUqvXB7Jy/eOgnytE7msOkB
	 7pWAx1rrnTeIfrbYz/UeB/rwpHLuy+k8Dm7dInNj1JEZJh++YNMW38qvGK+3VY8GED
	 DoHDB1VGAfOkC63Ytl5zkK/zNqZK41rvJ3Y4gAufm9qxHTfec/8KMyruGUBAu1zTyX
	 yvELmPV9BMtDbUYh9i1OwqasKi6MQS/Wnwyr3/wQyJUECLmvfEohwrPx8MCHJflGUG
	 qDy/sCQjKS6AuK3DS0qArqTJYqJn4w1O86JrtWZS6duzFypNUPqoPZZY3f+c/sTgUu
	 2PO/HJH0FzjuQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/34] sched_ext: Prepare bypass mode for hierarchical operation
Date: Tue, 24 Feb 2026 19:01:37 -1000
Message-ID: <20260225050152.1070601-20-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14293-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CBA4191F1C
X-Rspamd-Action: no action

Bypass mode is used to simplify enable and disable paths and guarantee
forward progress when something goes wrong. When enabled, all tasks skip BPF
scheduling and fall back to simple in-kernel FIFO scheduling. While this
global behavior can be used as-is when dealing with sub-scheds, that would
allow any sub-sched instance to affect the whole system in a significantly
disruptive manner.

Make bypass state hierarchical by propagating it to descendants and updating
per-cpu flags accordingly. This allows an scx_sched to bypass if itself or
any of its ancestors are in bypass mode. However, this doesn't make the
actual bypass enqueue and dispatch paths hierarchical yet. That will be done
in later patches.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 85 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0fd5c90951dd..2aab3ccbd3e3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -41,6 +41,7 @@ static DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
+static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
 static cpumask_var_t scx_bypass_lb_donee_cpumask;
 static cpumask_var_t scx_bypass_lb_resched_cpumask;
 static bool scx_init_task_enabled;
@@ -4381,6 +4382,36 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 		mod_timer(timer, jiffies + usecs_to_jiffies(intv_us));
 }
 
+static bool inc_bypass_depth(struct scx_sched *sch)
+{
+	lockdep_assert_held(&scx_bypass_lock);
+
+	WARN_ON_ONCE(sch->bypass_depth < 0);
+	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
+	if (sch->bypass_depth != 1)
+		return false;
+
+	WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
+	sch->bypass_timestamp = ktime_get_ns();
+	scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
+	return true;
+}
+
+static bool dec_bypass_depth(struct scx_sched *sch)
+{
+	lockdep_assert_held(&scx_bypass_lock);
+
+	WARN_ON_ONCE(sch->bypass_depth < 1);
+	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
+	if (sch->bypass_depth != 0)
+		return false;
+
+	WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
+	scx_add_event(sch, SCX_EV_BYPASS_DURATION,
+		      ktime_get_ns() - sch->bypass_timestamp);
+	return true;
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @sch: sched to bypass
@@ -4415,22 +4446,17 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
  */
 static void scx_bypass(struct scx_sched *sch, bool bypass)
 {
-	static DEFINE_RAW_SPINLOCK(bypass_lock);
+	struct scx_sched *pos;
 	unsigned long flags;
 	int cpu;
 
-	raw_spin_lock_irqsave(&bypass_lock, flags);
+	raw_spin_lock_irqsave(&scx_bypass_lock, flags);
 
 	if (bypass) {
 		u32 intv_us;
 
-		WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
-		WARN_ON_ONCE(sch->bypass_depth <= 0);
-		if (sch->bypass_depth != 1)
+		if (!inc_bypass_depth(sch))
 			goto unlock;
-		WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
-		sch->bypass_timestamp = ktime_get_ns();
-		scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
 
 		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 		if (intv_us && !timer_pending(&sch->bypass_lb_timer)) {
@@ -4439,15 +4465,25 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 			add_timer_global(&sch->bypass_lb_timer);
 		}
 	} else {
-		WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
-		WARN_ON_ONCE(sch->bypass_depth < 0);
-		if (sch->bypass_depth != 0)
+		if (!dec_bypass_depth(sch))
 			goto unlock;
-		WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
-		scx_add_event(sch, SCX_EV_BYPASS_DURATION,
-			      ktime_get_ns() - sch->bypass_timestamp);
 	}
 
+	/*
+	 * Bypass state is propagated to all descendants - an scx_sched bypasses
+	 * if itself or any of its ancestors are in bypass mode.
+	 */
+	raw_spin_lock(&scx_sched_lock);
+	scx_for_each_descendant_pre(pos, sch) {
+		if (pos == sch)
+			continue;
+		if (bypass)
+			inc_bypass_depth(pos);
+		else
+			dec_bypass_depth(pos);
+	}
+	raw_spin_unlock(&scx_sched_lock);
+
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_bypassing()
@@ -4459,18 +4495,20 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
 
-		if (bypass) {
-			WARN_ON_ONCE(pcpu->flags & SCX_SCHED_PCPU_BYPASSING);
-			pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
-		} else {
-			WARN_ON_ONCE(!(pcpu->flags & SCX_SCHED_PCPU_BYPASSING));
-			pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
+		raw_spin_lock(&scx_sched_lock);
+		scx_for_each_descendant_pre(pos, sch) {
+			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+
+			if (pos->bypass_depth)
+				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
+			else
+				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+		raw_spin_unlock(&scx_sched_lock);
 
 		/*
 		 * We need to guarantee that no tasks are on the BPF scheduler
@@ -4491,6 +4529,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
+			if (!scx_is_descendant(scx_task_sched(p), sch))
+				continue;
+
 			/* cycling deq/enq is enough, see the function comment */
 			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
@@ -4505,7 +4546,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 
 unlock:
-	raw_spin_unlock_irqrestore(&bypass_lock, flags);
+	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
-- 
2.53.0



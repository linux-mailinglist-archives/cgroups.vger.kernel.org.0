Return-Path: <cgroups+bounces-14261-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBB/LdSDnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14261-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:08:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6D191C62
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 340D6306B459
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22841312805;
	Wed, 25 Feb 2026 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spFuIyK/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB929311C2F;
	Wed, 25 Feb 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995693; cv=none; b=NdzlId8/xuBp56My6B3DvCTGbju9CpX4mZTF4WKRjp2aTIXR57kc2fjIE8VZ+vVbvD57HZatbN+z3Bz+Izi8/SRlaOJXfSf84m/8kbmFy/fIbCUFBlIvOkCc5nheSndtoOwWGRdCH+8zRQ1x4lAg9bXtYTkHHTcKhfbIrH1flQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995693; c=relaxed/simple;
	bh=N56by6xkW1MMuGPM63G3LM8QjQyh313Go91ANq0Df/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpql97lhxIrMvzCckVF1HvgEYcxDTLc1ONVR08oUiByGGyYhRNwTOMCTJdgAtjHy1JQ8JM/g7BE7NTwK7o4WYiY85hosYevkodNk+9qvtHPzpEPxAU4WPbAzEkuwJAtP0EWEMq59XFFRBEeCM/y52egE7yu5HxjRN06M0YL87ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spFuIyK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C324C116D0;
	Wed, 25 Feb 2026 05:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995693;
	bh=N56by6xkW1MMuGPM63G3LM8QjQyh313Go91ANq0Df/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spFuIyK/rJ8DjSJzkG6OOfaDcf4UCTFGVePUzHbK4BisoDzfoamw5l3hiatkRektA
	 +WZRgWw8xyX8ovX272GDuMYRJU9D3ZQ6c8+9WCMX0hJ3Negm2XfteqIvgHclT0OBST
	 yjBvR8H+4xDbReJT6V9Y9e3jLRx1xDvv9sf9Z/167aHNALehtaoxYWPwFqRYNEza55
	 rAjh09+8hwu49M4yXwtBkZ+waFBh633Iag/0TJQy/KKAUodBQ5/wv3f4g+zzIWltFh
	 77Ntsz2yzeWSfMjK7jBBhj10mAdsiejJUBQmUJOp5maepHFWHKYLteE9r6kXpIjF5v
	 DkBxqE+Bgr3CQ==
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
Subject: [PATCH 22/34] sched_ext: Separate bypass dispatch enabling from bypass depth tracking
Date: Tue, 24 Feb 2026 19:00:57 -1000
Message-ID: <20260225050109.1070059-23-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14261-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6C6D191C62
X-Rspamd-Action: no action

The bypass_depth field tracks nesting of bypass operations but is also used
to determine whether the bypass dispatch path should be active. With
hierarchical scheduling, child schedulers may need to activate their parent's
bypass dispatch path without affecting the parent's bypass_depth, requiring
separation of these concerns.

Add bypass_dsp_enable_depth and bypass_dsp_claim to independently control
bypass dispatch path activation. The new enable_bypass_dsp() and
disable_bypass_dsp() functions manage this state with proper claim semantics
to prevent races. The bypass dispatch path now only activates when
bypass_dsp_enabled() returns true, which checks the new enable_depth counter.

The disable operation is carefully ordered after all tasks are moved out of
bypass DSQs to ensure they are drained before the dispatch path is disabled.
During scheduler teardown, disable_bypass_dsp() is called explicitly to ensure
cleanup even if bypass mode was never entered normally.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 74 ++++++++++++++++++++++++++++++++-----
 kernel/sched/ext_internal.h |  5 +++
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed1491df0829..7a6af1a74e01 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -357,6 +357,26 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
 	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
 }
 
+/**
+ * bypass_dsp_enabled - Check if bypass dispatch path is enabled
+ * @sch: scheduler to check
+ *
+ * When a descendant scheduler enters bypass mode, bypassed tasks are scheduled
+ * by the nearest non-bypassing ancestor, or the root scheduler if all ancestors
+ * are bypassing. In the former case, the ancestor is not itself bypassing but
+ * its bypass DSQs will be populated with bypassed tasks from descendants. Thus,
+ * the ancestor's bypass dispatch path must be active even though its own
+ * bypass_depth remains zero.
+ *
+ * This function checks bypass_dsp_enable_depth which is managed separately from
+ * bypass_depth to enable this decoupling. See enable_bypass_dsp() and
+ * disable_bypass_dsp().
+ */
+static bool bypass_dsp_enabled(struct scx_sched *sch)
+{
+	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -2396,7 +2416,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (consume_global_dsq(sch, rq))
 		return true;
 
-	if (scx_bypassing(sch, cpu))
+	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
 		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
@@ -4379,7 +4399,7 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 	int node;
 	u32 intv_us;
 
-	if (!READ_ONCE(sch->bypass_depth))
+	if (!bypass_dsp_enabled(sch))
 		return;
 
 	for_each_node_with_cpus(node)
@@ -4420,6 +4440,42 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 	return true;
 }
 
+static void enable_bypass_dsp(struct scx_sched *sch)
+{
+	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
+	s32 ret;
+
+	/*
+	 * @sch->bypass_depth transitioning from 0 to 1 triggers enabling.
+	 * Shouldn't stagger.
+	 */
+	if (WARN_ON_ONCE(test_and_set_bit(0, &sch->bypass_dsp_claim)))
+		return;
+
+	/*
+	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
+	 * before starting the LB timer.
+	 */
+	ret = atomic_inc_return(&sch->bypass_dsp_enable_depth);
+	WARN_ON_ONCE(ret <= 0);
+
+	if (intv_us && !timer_pending(&sch->bypass_lb_timer))
+		mod_timer(&sch->bypass_lb_timer,
+			  jiffies + usecs_to_jiffies(intv_us));
+}
+
+/* may be called without holding scx_bypass_lock */
+static void disable_bypass_dsp(struct scx_sched *sch)
+{
+	s32 ret;
+
+	if (!test_and_clear_bit(0, &sch->bypass_dsp_claim))
+		return;
+
+	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
+	WARN_ON_ONCE(ret < 0);
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @sch: sched to bypass
@@ -4461,17 +4517,10 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	raw_spin_lock_irqsave(&scx_bypass_lock, flags);
 
 	if (bypass) {
-		u32 intv_us;
-
 		if (!inc_bypass_depth(sch))
 			goto unlock;
 
-		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
-		if (intv_us && !timer_pending(&sch->bypass_lb_timer)) {
-			sch->bypass_lb_timer.expires =
-				jiffies + usecs_to_jiffies(intv_us);
-			add_timer_global(&sch->bypass_lb_timer);
-		}
+		enable_bypass_dsp(sch);
 	} else {
 		if (!dec_bypass_depth(sch))
 			goto unlock;
@@ -4553,6 +4602,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		raw_spin_rq_unlock(rq);
 	}
 
+	/* disarming must come after moving all tasks out of the bypass DSQs */
+	if (!bypass)
+		disable_bypass_dsp(sch);
 unlock:
 	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
@@ -4654,6 +4706,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	disable_bypass_dsp(sch);
+
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_init(&sch->sibling);
 	list_del_rcu(&sch->all);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 85a4a1ab4342..9be8d26a5921 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -961,6 +961,11 @@ struct scx_sched {
 	u64			slice_dfl;
 	u64			bypass_timestamp;
 	s32			bypass_depth;
+
+	/* bypass dispatch path enable state, see bypass_dsp_enabled() */
+	unsigned long		bypass_dsp_claim;
+	atomic_t		bypass_dsp_enable_depth;
+
 	bool			aborting;
 	s32			level;
 
-- 
2.53.0



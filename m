Return-Path: <cgroups+bounces-14297-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPEQH8SGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14297-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:21:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB448191FA2
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C4B32070CB
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87606379978;
	Wed, 25 Feb 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg/Brikq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB2378D8F;
	Wed, 25 Feb 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995739; cv=none; b=M6XlUty3yPNOE5yCaebdr9NODVa5Vb3K9vXdZXFYjkIQhHq3/9fAFAvaMWdpfU4U0XcWFaV86MrsfvpXVGpF/TWVmuIw9CqHjslFuoYWLjxjjxCmvIFDUhZG6udeiEcxxVw2SDlZo15dvB8SjJmfU4u3vV4s8RHIhs96Q2jS2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995739; c=relaxed/simple;
	bh=2RRQSDscfRZ+lMXf63DeIhUEFi6J2Y4CLW8s5rOvwGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2mVhP9Wpm1xXCCU2caRx8R4F60LYnyw2P5niLYEDL/G81UvjaugTjbedXXq2NcqHTSWcONirlXsFUclAPnoFqE5oC+ZiR6a1jABaUqydgfXU1VUg3h9Pw2buCpG/AzJRYj0l5FvThaMqFQ99/ccShQSeFoPj6HR/7CBf65NRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg/Brikq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C2BC116D0;
	Wed, 25 Feb 2026 05:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995739;
	bh=2RRQSDscfRZ+lMXf63DeIhUEFi6J2Y4CLW8s5rOvwGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg/Brikq6rQtwBgrDBfXcz3B/pYId22SPcdoNspOPPlywdqK9f1WH1H3yQkdUFdEK
	 XVDkjmumXGkr6Ci1grY2tK/dxm7XVtShrbQf0R6MzE97XYLdYRBfIAqSvkdmrn24yW
	 tbkrZAFKN0tNiq0+jiP8TkFtIvxP8xAAw4VDO8c9tG824ZzngLhdo5nFcRSRlAA39K
	 C2FRsz345g7OUgqMXPagkdCwINB0zVp1Cd4hWUFMk9fgizzg07YD4Hg2faZwoJpRgS
	 WHIGcCsOH19ZVb8nzWt/JF+XxWTgjPYWp0QYPL5lTThviWhQnUUizQb8ylUXThBlaA
	 FfaUHzbVIQ6cA==
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
Subject: [PATCH 23/34] sched_ext: Implement hierarchical bypass mode
Date: Tue, 24 Feb 2026 19:01:41 -1000
Message-ID: <20260225050152.1070601-24-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14297-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB448191FA2
X-Rspamd-Action: no action

When a sub-scheduler enters bypass mode, its tasks must be scheduled by an
ancestor to guarantee forward progress. Tasks from bypassing descendants are
queued in the bypass DSQs of the nearest non-bypassing ancestor, or the root
scheduler if all ancestors are bypassing. This requires coordination between
bypassing schedulers and their hosts.

Add bypass_enq_target_dsq() to find the correct bypass DSQ by walking up the
hierarchy until reaching a non-bypassing ancestor. When a sub-scheduler starts
bypassing, all its runnable tasks are re-enqueued after scx_bypassing() is set,
ensuring proper migration to ancestor bypass DSQs.

Update scx_dispatch_sched() to handle hosting bypassed descendants. When a
scheduler is not bypassing but has bypassing descendants, it must schedule both
its own tasks and bypassed descendant tasks. A simple policy is implemented
where every Nth dispatch attempt (SCX_BYPASS_HOST_NTH=2) consumes from the
bypass DSQ. A fallback consumption is also added at the end of dispatch to
ensure bypassed tasks make progress even when normal scheduling is idle.

Update enable_bypass_dsp() and disable_bypass_dsp() to increment
bypass_dsp_enable_depth on both the bypassing scheduler and its parent host,
ensuring both can detect that bypass dispatch is active through
bypass_dsp_enabled().

Add SCX_EV_SUB_BYPASS_DISPATCH event counter to track scheduling of bypassed
descendant tasks.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 96 ++++++++++++++++++++++++++++++++++---
 kernel/sched/ext_internal.h | 11 +++++
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7a6af1a74e01..5490bfd77c92 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -357,6 +357,27 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
 	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
 }
 
+static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
+{
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * If @sch is a sub-sched which is bypassing, its tasks should go into
+	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
+	 * not-bypassing ancestor is responsible for scheduling all tasks from
+	 * bypassing sub-trees. If all ancestors including root are bypassing,
+	 * @p should go to the root's bypass DSQs.
+	 *
+	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
+	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
+	 * all tasks are transferred to the right DSQs.
+	 */
+	while (scx_parent(sch) && scx_bypassing(sch, cpu))
+		sch = scx_parent(sch);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
+	return bypass_dsq(sch, cpu);
+}
+
 /**
  * bypass_dsp_enabled - Check if bypass dispatch path is enabled
  * @sch: scheduler to check
@@ -1646,7 +1667,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
 bypass:
-	dsq = bypass_dsq(sch, task_cpu(p));
+	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
 	goto enqueue;
 
 enqueue:
@@ -2416,8 +2437,31 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (consume_global_dsq(sch, rq))
 		return true;
 
-	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
-		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+	if (bypass_dsp_enabled(sch)) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		/* if @sch is bypassing, only the bypass DSQs are active */
+		if (scx_bypassing(sch, cpu))
+			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+
+		/*
+		 * If @sch isn't bypassing but its children are, @sch is
+		 * responsible for making forward progress for both its own
+		 * tasks that aren't bypassing and the bypassing descendants'
+		 * tasks. The following implements a simple built-in behavior -
+		 * let each CPU try to run the bypass DSQ every Nth time.
+		 *
+		 * Later, if necessary, we can add an ops flag to suppress the
+		 * auto-consumption and a kfunc to consume the bypass DSQ and,
+		 * so that the BPF scheduler can fully control scheduling of
+		 * bypassed tasks.
+		 */
+		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
+		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu))) {
+			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
+			return true;
+		}
+	}
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
 		return false;
@@ -2463,6 +2507,14 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		}
 	} while (dspc->nr_tasks);
 
+	/*
+	 * Prevent the CPU from going idle while bypassed descendants have tasks
+	 * queued. Without this fallback, bypassed tasks could stall if the host
+	 * scheduler's ops.dispatch() doesn't yield any tasks.
+	 */
+	if (bypass_dsp_enabled(sch))
+		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+
 	return false;
 }
 
@@ -4069,6 +4121,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 	return at;
 }
 SCX_ATTR(events);
@@ -4429,6 +4482,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 {
 	lockdep_assert_held(&scx_bypass_lock);
 
+
 	WARN_ON_ONCE(sch->bypass_depth < 1);
 	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
 	if (sch->bypass_depth != 0)
@@ -4442,6 +4496,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 
 static void enable_bypass_dsp(struct scx_sched *sch)
 {
+	struct scx_sched *host = scx_parent(sch) ?: sch;
 	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 	s32 ret;
 
@@ -4453,14 +4508,35 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 		return;
 
 	/*
-	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
-	 * before starting the LB timer.
+	 * When a sub-sched bypasses, its tasks are queued on the bypass DSQs of
+	 * the nearest non-bypassing ancestor or root. As enable_bypass_dsp() is
+	 * called iff @sch is not already bypassed due to an ancestor bypassing,
+	 * we can assume that the parent is not bypassing and thus will be the
+	 * host of the bypass DSQs.
+	 *
+	 * While the situation may change in the future, the following
+	 * guarantees that the nearest non-bypassing ancestor or root has bypass
+	 * dispatch enabled while a descendant is bypassing, which is all that's
+	 * required.
+	 *
+	 * bypass_dsp_enabled() test is used to detemrine whether to enter the
+	 * bypass dispatch handling path from both bypassing and hosting scheds.
+	 * Bump enable depth on both @sch and bypass dispatch host.
 	 */
 	ret = atomic_inc_return(&sch->bypass_dsp_enable_depth);
 	WARN_ON_ONCE(ret <= 0);
 
-	if (intv_us && !timer_pending(&sch->bypass_lb_timer))
-		mod_timer(&sch->bypass_lb_timer,
+	if (host != sch) {
+		ret = atomic_inc_return(&host->bypass_dsp_enable_depth);
+		WARN_ON_ONCE(ret <= 0);
+	}
+
+	/*
+	 * The LB timer will stop running if bypass dispatch is disabled. Start
+	 * after enabling bypass dispatch.
+	 */
+	if (intv_us && !timer_pending(&host->bypass_lb_timer))
+		mod_timer(&host->bypass_lb_timer,
 			  jiffies + usecs_to_jiffies(intv_us));
 }
 
@@ -4474,6 +4550,11 @@ static void disable_bypass_dsp(struct scx_sched *sch)
 
 	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
 	WARN_ON_ONCE(ret < 0);
+
+	if (scx_parent(sch)) {
+		ret = atomic_dec_return(&scx_parent(sch)->bypass_dsp_enable_depth);
+		WARN_ON_ONCE(ret < 0);
+	}
 }
 
 /**
@@ -5248,6 +5329,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
 	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
+	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9be8d26a5921..a447183c0bba 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -24,6 +24,8 @@ enum scx_consts {
 	 */
 	SCX_TASK_ITER_BATCH		= 32,
 
+	SCX_BYPASS_HOST_NTH		= 2,
+
 	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
 	SCX_BYPASS_LB_DONOR_PCT		= 125,
 	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
@@ -923,6 +925,12 @@ struct scx_event_stats {
 	 * scheduler.
 	 */
 	s64		SCX_EV_INSERT_NOT_OWNED;
+
+	/*
+	 * The number of times tasks from bypassing descendants are scheduled
+	 * from sub_bypass_dsq's.
+	 */
+	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
 enum scx_sched_pcpu_flags {
@@ -940,6 +948,9 @@ struct scx_sched_pcpu {
 	struct scx_event_stats	event_stats;
 
 	struct scx_dispatch_q	bypass_dsq;
+#ifdef CONFIG_EXT_SUB_SCHED
+	u32			bypass_host_seq;
+#endif
 };
 
 struct scx_sched {
-- 
2.53.0



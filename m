Return-Path: <cgroups+bounces-14289-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JszFtOGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14289-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:21:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708B191FB8
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9242D3104B3C
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77436D4F3;
	Wed, 25 Feb 2026 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMhh93k9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392136C5B6;
	Wed, 25 Feb 2026 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995730; cv=none; b=rLMsEZfiqFpXATWoxLoGfopWo7S1DNLn0LPvxuVXUaPB5MfUsEDIsgSd58GiNmgNuIaefCXzpO+2DoyqQtzIOZAmRzdp320GlEVPKofeo+N19r4LIP/RZSRetJRoWHi7iXsF64WOpqvu1SC7CCIMwoX445J/LjlcTvHvfR1Ii1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995730; c=relaxed/simple;
	bh=zOmDxvzcoAE1E/AXoBZ38i4o1Meh6GxormTXb/kGASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlPP5FGyIlve9EDlaiB40Mhz+0KqpXu6eqEb4qpOMhYImFN+inujOUV+bFzU3LgzFGucHU/56w9sfRlR4NsJRmK32mHjMoHYQHGkwyyWy8pA2Q4Wq1HKUb22IdP4smPdos2pcBgioYaE/bwr4jJvOe7+2Kh1myLMH7lofrOHwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMhh93k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DACDC116D0;
	Wed, 25 Feb 2026 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995730;
	bh=zOmDxvzcoAE1E/AXoBZ38i4o1Meh6GxormTXb/kGASw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMhh93k9nY8Sz/L1Z9EkYw43lDMa+0NEnht+AD9h3S77u0zp4okuv/NjHwWM77tPw
	 1O4GiMPFWooBYjEWvmoJfHzWhwTDL6SS2v+6pw8hIBO/0G9brUXxxn+vwoLIcwivuE
	 yMYkdKLd9NDy2VMSS8Hs0ctj5Gc35Mq0ghwRy4M3ZiSZh5yPQFuOku3kP/oUgO24Z/
	 KMSXa5HP7ANxrTnFQPv9UAGD6EO9fiKAZweKAUELdNfqZzFp2z4KzZOFsARQpt6lJa
	 yhNxX7QVDosMsyWgKaAjwk/QcsvnuS13s9ANsSbfJTMNZ2yJhgGkhKVE/ozYIJAAXy
	 PAD6sQt2FeZsg==
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
Subject: [PATCH 15/34] sched_ext: Move default slice to per-scheduler field
Date: Tue, 24 Feb 2026 19:01:33 -1000
Message-ID: <20260225050152.1070601-16-tj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14289-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 8708B191FB8
X-Rspamd-Action: no action

The default time slice was stored in the global scx_slice_dfl variable which
was dynamically modified when entering and exiting bypass mode. With
hierarchical scheduling, each scheduler instance needs its own default slice
configuration so that bypass operations on one scheduler don't affect others.

Move slice_dfl into struct scx_sched and update all access sites. The bypass
logic now modifies the root scheduler's slice_dfl. At task initialization in
init_scx_entity(), use the SCX_SLICE_DFL constant directly since the task may
not yet be associated with a specific scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 14 ++++++++------
 kernel/sched/ext_internal.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3d46e6e125c7..eee0d1c05b68 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -164,7 +164,6 @@ static struct kset *scx_kset;
  * There usually is no reason to modify these as normal scheduler operation
  * shouldn't be affected by them. The knobs are primarily for debugging.
  */
-static u64 scx_slice_dfl = SCX_SLICE_DFL;
 static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
 static unsigned int scx_bypass_lb_intv_us = SCX_BYPASS_LB_DFL_INTV_US;
 
@@ -1131,7 +1130,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(scx_slice_dfl);
+	p->scx.slice = READ_ONCE(sch->slice_dfl);
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -3285,7 +3284,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = READ_ONCE(scx_slice_dfl);
+	scx->slice = SCX_SLICE_DFL;
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -4431,6 +4430,8 @@ static void scx_bypass(bool bypass)
 
 	raw_spin_lock_irqsave(&bypass_lock, flags);
 	sch = rcu_dereference_bh(scx_root);
+	if (!sch)
+		goto unlock;
 
 	if (bypass) {
 		u32 intv_us;
@@ -4439,7 +4440,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
+		WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -4455,7 +4456,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, SCX_SLICE_DFL);
+		WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -5299,6 +5300,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
@@ -5635,7 +5637,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(scx_slice_dfl);
+			p->scx.slice = READ_ONCE(sch->slice_dfl);
 			p->sched_class = new_class;
 		}
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 3b17180ba3dd..bd8619905ed1 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -950,6 +950,7 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
+	u64			slice_dfl;
 	s32			level;
 
 	/*
-- 
2.53.0



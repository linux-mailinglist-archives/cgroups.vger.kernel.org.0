Return-Path: <cgroups+bounces-15426-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOt1Kt8252mg5QEAu9opvQ
	(envelope-from <cgroups+bounces-15426-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:35:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F94383DB
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87CCE3005306
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D9382367;
	Tue, 21 Apr 2026 08:35:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA52853F3;
	Tue, 21 Apr 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760535; cv=none; b=M6LAMMjQ1lEAQ5qI2IszUeLecEJdG21RTE98x5aIF1KYnqwoR6cJj8JbNKPCkJ+uTcEC/yPXHflfqtQe2SDZTWQOeIELPAJR4n5pMBCW1koHGvEbK4SrFbyOBN1BG7YcK0StgMdwItX8SHzhO5gP9f358SKWcaqwTXDw9zxVjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760535; c=relaxed/simple;
	bh=zeOGnO9bt2J9+UiHNLJkZpcxllQPW+g0ex0Ppo4tXOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJ56UULAGUJu1I8WE7NrMlxDwwC3BjcegB/xudDfYJuiIS8MIWO62FOf3P0jN6aftcdGzh4MUQuaDGhgp7QWj3izbG8XkQV8YW9s0d54iWogpHkHfP3MpuG9JpPdE5+PwJlQB9fPuoR/z0leBEJp/9CjArcBeyMGEdK9mi4Jy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 07f623f63d5d11f1aa26b74ffac11d73-20260421
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fdd12e47-3cba-4083-8f62-6ab692b2f9f5,IP:20,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:fdd12e47-3cba-4083-8f62-6ab692b2f9f5,IP:20,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:b0c17806763293d7f9e986e54930bb5d,BulkI
	D:260421163522S6QID5JU,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 07f623f63d5d11f1aa26b74ffac11d73-20260421
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1871173753; Tue, 21 Apr 2026 16:35:20 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: longman@redhat.com,
	tj@kernel.org,
	juri.lelli@redhat.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com
Cc: hannes@cmpxchg.org,
	mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] cgroup/cpuset: make DL attach bandwidth reservation root-domain aware
Date: Tue, 21 Apr 2026 16:34:49 +0800
Message-ID: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[kylinos.cn:mid,kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15426-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: A78F94383DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpuset_can_attach() currently sums the bandwidth of all migrating
SCHED_DEADLINE tasks and reserves destination bandwidth whenever the
old and new cpuset effective CPU masks do not overlap.

That condition is stronger than what the scheduler uses when migrating
a deadline task. set_cpus_allowed_dl() only subtracts bandwidth from
the source side when moving the task requires a DL bandwidth move
between root domains.

As a result, moving a deadline task between disjoint member cpusets that
still belong to the same root domain can reserve destination bandwidth
even though no matching source-side subtraction happens. Successful
back-and-forth migrations between such cpusets can monotonically
increase dl_bw->total_bw.

Fix this by extracting the source root-domain test already used by
set_cpus_allowed_dl() into a shared helper and make cpuset DL bandwidth
preallocation use that same condition. Count all migrating deadline
tasks for cpuset task accounting, but only accumulate sum_migrate_dl_bw
for tasks that actually need a DL bandwidth move. Reserve and rollback
bandwidth only for that subset.

This keeps successful attach accounting aligned with
set_cpus_allowed_dl() and avoids double-accounting within a single
root domain.

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 include/linux/sched/deadline.h  |  9 +++++++++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 34 ++++++++++++++++-----------------
 kernel/sched/deadline.c         | 14 +++++++++++---
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 1198138cb839..273538200a44 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -33,6 +33,15 @@ struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
 extern void dl_clear_root_domain_cpu(int cpu);
+/*
+ * Return whether moving DL task @p to @new_mask requires moving DL
+ * bandwidth accounting between root domains. This helper is specific to
+ * DL bandwidth move accounting semantics and is shared by
+ * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
+ * same source root-domain test.
+ */
+extern bool dl_task_needs_bw_move(struct task_struct *p,
+				  const struct cpumask *new_mask);
 
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index bb4e692bea30..f7aaf01f7cd5 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -167,6 +167,7 @@ struct cpuset {
 	 */
 	int nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
+	/* DL bandwidth that needs destination reservation for this attach. */
 	u64 sum_migrate_dl_bw;
 	/*
 	 * CPU used for temporary DL bandwidth allocation during attach;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..761098b45f23 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2993,7 +2993,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool setsched_check;
-	int ret;
+	int cpu, ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
@@ -3039,31 +3039,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 
 		if (dl_task(task)) {
 			cs->nr_migrate_dl_tasks++;
-			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+
+			if (dl_task_needs_bw_move(task, cs->effective_cpus))
+				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
-	if (!cs->nr_migrate_dl_tasks)
+	if (!cs->sum_migrate_dl_bw)
 		goto out_success;
 
-	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
 
-		if (unlikely(cpu >= nr_cpu_ids)) {
-			reset_migrate_dl_data(cs);
-			ret = -EINVAL;
-			goto out_unlock;
-		}
-
-		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret) {
-			reset_migrate_dl_data(cs);
-			goto out_unlock;
-		}
+	if (unlikely(cpu >= nr_cpu_ids)) {
+		reset_migrate_dl_data(cs);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
-		cs->dl_bw_cpu = cpu;
+	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+	if (ret) {
+		reset_migrate_dl_data(cs);
+		goto out_unlock;
 	}
 
+	cs->dl_bw_cpu = cpu;
+
 out_success:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index edca7849b165..5ddfa0d30bf6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3107,20 +3107,18 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 static void set_cpus_allowed_dl(struct task_struct *p,
 				struct affinity_context *ctx)
 {
-	struct root_domain *src_rd;
 	struct rq *rq;
 
 	WARN_ON_ONCE(!dl_task(p));
 
 	rq = task_rq(p);
-	src_rd = rq->rd;
 	/*
 	 * Migrating a SCHED_DEADLINE task between exclusive
 	 * cpusets (different root_domains) entails a bandwidth
 	 * update. We already made space for us in the destination
 	 * domain (see cpuset_can_attach()).
 	 */
-	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
+	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
 		struct dl_bw *src_dl_b;
 
 		src_dl_b = dl_bw_of(cpu_of(rq));
@@ -3137,6 +3135,16 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	set_cpus_allowed_common(p, ctx);
 }
 
+bool dl_task_needs_bw_move(struct task_struct *p,
+			   const struct cpumask *new_mask)
+{
+	if (!dl_task(p))
+		return false;
+
+	guard(rcu)();
+	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
+}
+
 /* Assumes rq->lock is held */
 static void rq_online_dl(struct rq *rq)
 {
-- 
2.43.0



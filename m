Return-Path: <cgroups+bounces-15656-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH3xDaxq/Gn0PgAAu9opvQ
	(envelope-from <cgroups+bounces-15656-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:34:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9954E6D44
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B18C8300F799
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB563E95A9;
	Thu,  7 May 2026 10:33:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178853DCD8F;
	Thu,  7 May 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150032; cv=none; b=Tqx7NPT7uUoq9JMHdIktJqySQkaLVcEbHX6/HQEtHPR1XewGuK+Tp/izuZJZ1pDBQUDZ9K4vp1sSiBIs/xJkVsBUjaT2uAcASgyFaRT4PrzmNU6SViEZEbtHZStyikaGvDdm+fHU0eXLN82x9wggZHGTMbAWHgt3vJf7HFfRB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150032; c=relaxed/simple;
	bh=L7crFI2zyS6MxDSIiAIkP1ykGXokQTs/tyAqvbXIfq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb5Sk0GMUhfe6CplLEKXFBU3/+uS8Bmcdg7nma/NbxP0IqcHkJD1vIwUEUVrgOGo27pEX7QO9x62v3TLRxPGBt0OW7XXcVVvzSsrTDJ5fxTYY+y3kPvFESAzAouHKMQ7Gdi5WGAsObxKoTmEdF1xedeX9JUVQe/y7oWvxiSPCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 388e48864a0011f1aa26b74ffac11d73-20260507
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9e4a426b-a61c-400a-b065-7af60dacdca2,IP:10,
	URL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-45
X-CID-INFO: VERSION:1.3.12,REQID:9e4a426b-a61c-400a-b065-7af60dacdca2,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,A
	CTION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa1bf34dace54d100d63fe38e7e6cf9f,BulkI
	D:260507183345LG2WC2XW,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 388e48864a0011f1aa26b74ffac11d73-20260507
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2082339759; Thu, 07 May 2026 18:33:43 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v2 2/2] cgroup/cpuset: align DL bandwidth reservation with attach target mask
Date: Thu,  7 May 2026 18:33:10 +0800
Message-ID: <20260507103310.35849-3-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A9954E6D44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-15656-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

cpuset_can_attach() preallocates destination SCHED_DEADLINE bandwidth
before the attach commit point, while set_cpus_allowed_dl() later
subtracts bandwidth from the source root domain when the task affinity is
actually updated.

Those two decisions must be made with the same CPU mask.
cpuset_can_attach() used the destination cpuset effective mask directly,
but cpuset_attach_task() first builds a per-task target mask which is
constrained by task_cpu_possible_mask() and, if needed, by walking up the
cpuset hierarchy. On asymmetric systems, the actual target mask can
therefore be a strict subset of cs->effective_cpus.

If the source root domain intersects cs->effective_cpus only on CPUs
outside the task's possible mask, can_attach() can skip the destination
reservation even though set_cpus_allowed_dl() later sees a real
root-domain move and subtracts from the source domain.

Extract the root-domain bandwidth-move test used by
set_cpus_allowed_dl() into dl_task_needs_bw_move(), and make
cpuset_can_attach() compute the same per-task target mask that
cpuset_attach_task() applies.

Keep nr_migrate_dl_tasks counting all migrating deadline tasks for
cpuset DL task accounting. Restrict sum_migrate_dl_bw to the subset of
tasks that need destination root-domain bandwidth reservation, because a
deadline task can move between cpusets without moving bandwidth between
root domains.

This keeps the existing per-attach aggregate reservation model; it only
changes the per-task mask used to decide which tasks contribute to that
aggregate. The broader can_attach()/attach() transaction window is left
unchanged.

Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 include/linux/sched/deadline.h  |  9 +++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 97 ++++++++++++++++++++++-----------
 kernel/sched/deadline.c         | 13 ++++-
 4 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 1198138cb839..ddfd5216f3fc 100644
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
+bool dl_task_needs_bw_move(struct task_struct *p,
+			   const struct cpumask *new_mask);
 
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
index ae41736399a1..78c1a4071cc3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -485,6 +485,30 @@ static void guarantee_active_cpus(struct task_struct *tsk,
 	rcu_read_unlock();
 }
 
+/* Compute the effective CPU mask cpuset_attach_task() will apply to @tsk. */
+static void cpuset_attach_task_cpus(struct cpuset *cs, struct task_struct *tsk,
+				    struct cpumask *pmask)
+{
+	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+
+	lockdep_assert_cpuset_lock_held();
+
+	if (cs == &top_cpuset) {
+		cpumask_andnot(pmask, possible_mask, subpartitions_cpus);
+		return;
+	}
+
+	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_active_mask)))
+		cpumask_copy(pmask, cpu_active_mask);
+
+	rcu_read_lock();
+	while (!cpumask_intersects(cs->effective_cpus, pmask))
+		cs = parent_cs(cs);
+
+	cpumask_and(pmask, pmask, cs->effective_cpus);
+	rcu_read_unlock();
+}
+
 /*
  * Return in *pmask the portion of a cpusets's mems_allowed that
  * are online, with memory.  If none are online with memory, walk
@@ -2986,6 +3010,14 @@ static void reset_migrate_dl_data(struct cpuset *cs)
 	cs->dl_bw_cpu = -1;
 }
 
+/*
+ * Protected by cpuset_mutex. cpus_attach is used by the can_attach/attach
+ * paths but we can't allocate it dynamically there. Define it global and
+ * allocate from cpuset_init().
+ */
+static cpumask_var_t cpus_attach;
+static nodemask_t cpuset_attach_nodemask_to;
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
@@ -2993,7 +3025,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool setsched_check;
-	int ret;
+	int cpu = nr_cpu_ids, ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
@@ -3038,32 +3070,47 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 
 		if (dl_task(task)) {
+			/*
+			 * Count all migrating DL tasks for cpuset task accounting.
+			 * Only tasks that need a root-domain bandwidth move
+			 * contribute to sum_migrate_dl_bw.
+			 */
 			cs->nr_migrate_dl_tasks++;
-			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			cpuset_attach_task_cpus(cs, task, cpus_attach);
+
+			if (dl_task_needs_bw_move(task, cpus_attach)) {
+				/*
+				 * Keep the existing aggregate reservation model.
+				 * Tasks in one attach enter the same destination
+				 * cpuset, so the first CPU found for a task needing
+				 * DL bandwidth reservation identifies the destination
+				 * root domain.
+				 */
+				if (cpu >= nr_cpu_ids)
+					cpu = cpumask_any_and(cpu_active_mask,
+							      cpus_attach);
+				cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			}
 		}
 	}
 
-	if (!cs->nr_migrate_dl_tasks)
+	if (!cs->sum_migrate_dl_bw)
 		goto out_success;
 
-	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-
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
@@ -3099,23 +3146,11 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
-/*
- * Protected by cpuset_mutex. cpus_attach is used only by cpuset_attach_task()
- * but we can't allocate it dynamically there.  Define it global and
- * allocate from cpuset_init().
- */
-static cpumask_var_t cpus_attach;
-static nodemask_t cpuset_attach_nodemask_to;
-
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
 	lockdep_assert_cpuset_lock_held();
 
-	if (cs != &top_cpuset)
-		guarantee_active_cpus(task, cpus_attach);
-	else
-		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
-			       subpartitions_cpus);
+	cpuset_attach_task_cpus(cs, task, cpus_attach);
 	/*
 	 * can_attach beforehand should guarantee that this doesn't
 	 * fail.  TODO: have a better way to handle failure here
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index edca7849b165..7db4c87df83b 100644
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
@@ -3137,6 +3135,15 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	set_cpus_allowed_common(p, ctx);
 }
 
+bool dl_task_needs_bw_move(struct task_struct *p,
+			   const struct cpumask *new_mask)
+{
+	if (!dl_task(p))
+		return false;
+
+	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
+}
+
 /* Assumes rq->lock is held */
 static void rq_online_dl(struct rq *rq)
 {
-- 
2.43.0



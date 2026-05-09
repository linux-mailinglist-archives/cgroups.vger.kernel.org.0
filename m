Return-Path: <cgroups+bounces-15692-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLOSGwUL/2mv1QAAu9opvQ
	(envelope-from <cgroups+bounces-15692-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 12:23:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD384FF367
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 12:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D733037ECF
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4483A3812;
	Sat,  9 May 2026 10:21:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39E38759C;
	Sat,  9 May 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778322075; cv=none; b=AbU3z7hJKD44RWzGdEne/YKjYIfmQVQ1089Z4sWKc1h0lbJASRwPTM0W27KB8JSnZvfx9bMmzVgvgUHHmdJljsR59Q5MBSOjeGerOfoO72q/7or8uLtjTH1FFtHHlF3/9oQzkpSSXl0yzDvgyGNzzgjudd0uHAy1UXqvCFUX6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778322075; c=relaxed/simple;
	bh=21WKfoXduxGZzk8YPAPN64O4DT5JnDtxitRKuagK6kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PivVeVpTD9OVgklbX6xsbAx//GG2vw7yT4hLL/uCt7QSKbL3EV/xFiocFoSVDRw261+S+O4wgiq14OHF1kdL//Y26w+QuwgBPZ1zSAqimHRJfS/Y85U2pi0+d2lpmgNSRNsBRGyc7Ners1B5StXXbgdYe2ehfptr5k66UkiXr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: caec7de24b9011f1aa26b74ffac11d73-20260509
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:91eddfe4-4866-4abc-a635-0d5c5eb19c81,IP:10,
	URL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-45
X-CID-INFO: VERSION:1.3.12,REQID:91eddfe4-4866-4abc-a635-0d5c5eb19c81,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,A
	CTION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:f76e970f01f6732cb406ad58c3c1de97,BulkI
	D:260509182109ZPUIL3S0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: caec7de24b9011f1aa26b74ffac11d73-20260509
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 138436983; Sat, 09 May 2026 18:21:07 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH v3 2/2] cgroup/cpuset: reserve DL bandwidth only for root-domain moves
Date: Sat,  9 May 2026 18:20:31 +0800
Message-ID: <20260509102031.97608-3-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAD384FF367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-15692-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

cpuset_can_attach() currently adds the bandwidth of all migrating
SCHED_DEADLINE tasks to sum_migrate_dl_bw. If the source and destination
cpuset effective CPU masks do not overlap, the whole sum is then
reserved in the destination root domain.

set_cpus_allowed_dl(), however, subtracts bandwidth from the source
root domain only when the affinity change really moves the task between
root domains. A DL task can move between cpusets that are still in the
same root domain, so including that task in sum_migrate_dl_bw can reserve
destination bandwidth without a matching source-side subtraction.

Share the root-domain move test with set_cpus_allowed_dl(). Keep
nr_migrate_dl_tasks counting all migrating deadline tasks for cpuset DL
task accounting, but add to sum_migrate_dl_bw only for tasks that need a
root-domain bandwidth move. Keep using the destination cpuset effective
CPU mask and leave the broader can_attach()/attach() transaction model
unchanged.

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 include/linux/sched/deadline.h  |  9 +++++++++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 33 ++++++++++++++++++---------------
 kernel/sched/deadline.c         | 13 ++++++++++---
 4 files changed, 38 insertions(+), 18 deletions(-)

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
index b9c839538900..23abfbbb4686 100644
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
@@ -3038,28 +3038,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 
 		if (dl_task(task)) {
+			/*
+			 * Count all migrating DL tasks for cpuset task accounting.
+			 * Only tasks that need a root-domain bandwidth move
+			 * contribute to sum_migrate_dl_bw.
+			 */
 			cs->nr_migrate_dl_tasks++;
-			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			if (dl_task_needs_bw_move(task, cs->effective_cpus))
+				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
-	if (!cs->nr_migrate_dl_tasks)
+	if (!cs->sum_migrate_dl_bw)
 		goto out_success;
 
-	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-
-		if (unlikely(cpu >= nr_cpu_ids)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+	if (unlikely(cpu >= nr_cpu_ids)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
-		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret)
-			goto out_unlock;
+	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+	if (ret)
+		goto out_unlock;
 
-		cs->dl_bw_cpu = cpu;
-	}
+	cs->dl_bw_cpu = cpu;
 
 out_success:
 	/*
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



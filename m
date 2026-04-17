Return-Path: <cgroups+bounces-15339-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSQBNmr4Wl1wgAAu9opvQ
	(envelope-from <cgroups+bounces-15339-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:41:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67295416A64
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861FD304A587
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 03:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF5350D7D;
	Fri, 17 Apr 2026 03:38:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EA2DECDF;
	Fri, 17 Apr 2026 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397122; cv=none; b=MHDwKRGwu22OJGsg00REkWD8OQCyDmjrMFnKhSXG+8RQM2nNT+V5edjCD164JpAbeq2b1OdfDrnSWpXKdKNEKVS2KtBdZh4BxaaFuUlnl/etiENtu+q4993NX3ICqH8QqEEemW2oTeBlePVQv++g2Mswj5EL0KdHZ9ZuJAxIGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397122; c=relaxed/simple;
	bh=PKpIjj53GQeEkxG8kyR4DFiTfEL3Lj5E1Ag3FIbhFSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP9+nL1kj+Y2l4tAM6BZnkm8jZ2A/tQH9aOsk8MAR2RzIgLPsL1zC5vWAneQTQu9X22tAONxr19Z3y7GX6Sesy7E5vSh3MtRXJXK3jqYl/s+7Ifq49RdTcNHBDsEJjmgDuMUeYexzss18x5i+mH6jdn1fpqYxvc56phYf2/Vs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ea1b2c103a0e11f1aa26b74ffac11d73-20260417
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:eb60d489-14b4-43b8-94a4-d28e5699a37a,IP:10,
	URL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-45
X-CID-INFO: VERSION:1.3.12,REQID:eb60d489-14b4-43b8-94a4-d28e5699a37a,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,A
	CTION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:a25a31f5f62182f223ab176ae21435a2,BulkI
	D:26041711383601XWS6LU,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea1b2c103a0e11f1aa26b74ffac11d73-20260417
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1882427054; Fri, 17 Apr 2026 11:38:35 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach rollback
Date: Fri, 17 Apr 2026 11:37:41 +0800
Message-ID: <20260417033742.40793-2-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-15339-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67295416A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpuset_can_attach() allocates DL bandwidth only when migrating
deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
rolls back based only on nr_migrate_dl_tasks. This makes the DL
bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
even when no dl_bw_alloc() was done.

Rollback also needs to undo the reservation against the same CPU/root
domain that was charged. Record the CPU used by dl_bw_alloc() and use
that state in cpuset_cancel_attach(). If no allocation happened,
dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
did happen, bandwidth is returned to the same CPU/root domain.

Successful attach paths are unchanged. This only fixes failed attach
rollback accounting.

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 kernel/cgroup/cpuset-internal.h |  5 +++++
 kernel/cgroup/cpuset.c          | 13 +++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index fd7d19842ded..bb4e692bea30 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -168,6 +168,11 @@ struct cpuset {
 	int nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
 	u64 sum_migrate_dl_bw;
+	/*
+	 * CPU used for temporary DL bandwidth allocation during attach;
+	 * -1 if no DL bandwidth was allocated in the current attach.
+	 */
+	int dl_bw_cpu;
 
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..e3a081a07c6d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -288,6 +288,7 @@ struct cpuset top_cpuset = {
 	.flags = BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
+	.dl_bw_cpu = -1,
 };
 
 /**
@@ -579,6 +580,8 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
 	if (!trial)
 		return NULL;
 
+	trial->dl_bw_cpu = -1;
+
 	/* Setup cpumask pointer array */
 	cpumask_var_t *pmask[4] = {
 		&trial->cpus_allowed,
@@ -2980,6 +2983,7 @@ static void reset_migrate_dl_data(struct cpuset *cs)
 {
 	cs->nr_migrate_dl_tasks = 0;
 	cs->sum_migrate_dl_bw = 0;
+	cs->dl_bw_cpu = -1;
 }
 
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
@@ -3056,6 +3060,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			reset_migrate_dl_data(cs);
 			goto out_unlock;
 		}
+
+		cs->dl_bw_cpu = cpu;
 	}
 
 out_success:
@@ -3080,12 +3086,11 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 	dec_attach_in_progress_locked(cs);
 
-	if (cs->nr_migrate_dl_tasks) {
-		int cpu = cpumask_any(cs->effective_cpus);
+	if (cs->dl_bw_cpu >= 0)
+		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
 
-		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+	if (cs->nr_migrate_dl_tasks)
 		reset_migrate_dl_data(cs);
-	}
 
 	mutex_unlock(&cpuset_mutex);
 }
-- 
2.43.0



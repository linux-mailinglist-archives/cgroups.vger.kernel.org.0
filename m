Return-Path: <cgroups+bounces-15807-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKf8HCWcAmrxuwEAu9opvQ
	(envelope-from <cgroups+bounces-15807-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:19:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDE519364
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FAC6301CCDF
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 03:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2603226863;
	Tue, 12 May 2026 03:18:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F1F5EA
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555936; cv=none; b=LK4DG43AKhV3es60SLUoYZB4dNABsDe5LbyKMWQKAvuriUqlOwl3mOvWTgA66vLNeK13ycwW0G9a8NFyG6THy0EuSqlBYfFJy0mHo+1J/E+lFZV7TvIOLHj9uGklvvUaAw1afJtd3VPAZmUYnzCMX1731M0QkYMMhP/ESd9msJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555936; c=relaxed/simple;
	bh=17e7BUDXtEUQDkBg87dTvMxU5Cd891HZfxk3eCXLPV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg90GBFqoCsKRuKiJt1L281i2Av7R/3aWCtHEjXuB8EW/fwRF5y2NukY85Lqjtu194pSNfQTCL6WfhCLdABefeGF3sRbotjQTsf0aC5tXiC24RRDG3aQKcxU3F7NHr5ZwmltvvgqQpLGKoMgvCrBcACLygG1a/ce8Z3nxTIXNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4b9f745e4db111f1aa26b74ffac11d73-20260512
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b191d16c-c0be-4e9a-afcb-ae4ce46876d4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:b191d16c-c0be-4e9a-afcb-ae4ce46876d4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:ad64b76db43599c94b2d598b36a4eb26,BulkI
	D:260512111852VRUUVCMS,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4b9f745e4db111f1aa26b74ffac11d73-20260512
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 423033488; Tue, 12 May 2026 11:18:49 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/3] cgroup/rdma: add rdma.peak for per-device peak usage tracking
Date: Tue, 12 May 2026 11:17:17 +0800
Message-ID: <20260512031719.273507-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512031719.273507-1-cuitao@kylinos.cn>
References: <20260512031719.273507-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAFDE519364
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15807-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.848];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rdma.peak tracks the high watermark of resource usage per device,
giving a better baseline on which to set rdma.max. Polling
rdma.current isn't feasible since it would miss short-lived spikes.

This interface is analogous to memory.peak.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/cgroup/rdma.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 3df7c38ce481..ed1f3f7996bd 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -44,6 +44,7 @@ static LIST_HEAD(rdmacg_devices);
 enum rdmacg_file_type {
 	RDMACG_RESOURCE_TYPE_MAX,
 	RDMACG_RESOURCE_TYPE_STAT,
+	RDMACG_RESOURCE_TYPE_PEAK,
 };
 
 /*
@@ -60,6 +61,7 @@ static char const *rdmacg_resource_names[] = {
 struct rdmacg_resource {
 	int max;
 	int usage;
+	int peak;
 };
 
 /*
@@ -204,9 +206,20 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 	rpool->usage_sum--;
 	if (rpool->usage_sum == 0 &&
 	    rpool->num_max_cnt == RDMACG_RESOURCE_MAX) {
+		int i;
+
+		/*
+		 * Keep the rpool alive if any peak value is non-zero,
+		 * so that rdma.peak persists as a historical high-
+		 * watermark even after all resources are freed.
+		 */
+		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
+			if (rpool->resources[i].peak)
+				return;
+		}
 		/*
-		 * No user of the rpool and all entries are set to max, so
-		 * safe to delete this rpool.
+		 * No user of the rpool and all entries are
+		 * set to max, so safe to delete this rpool.
 		 */
 		free_cg_rpool_locked(rpool);
 	}
@@ -306,6 +319,8 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 				goto err;
 			} else {
 				rpool->resources[index].usage = new;
+				if (new > rpool->resources[index].peak)
+					rpool->resources[index].peak = new;
 				rpool->usage_sum++;
 			}
 		}
@@ -472,9 +487,15 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 
 	if (rpool->usage_sum == 0 &&
 	    rpool->num_max_cnt == RDMACG_RESOURCE_MAX) {
+		int i;
+
+		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
+			if (rpool->resources[i].peak)
+				goto dev_err;
+		}
 		/*
-		 * No user of the rpool and all entries are set to max, so
-		 * safe to delete this rpool.
+		 * No user of the rpool and all entries are
+		 * set to max, so safe to delete this rpool.
 		 */
 		free_cg_rpool_locked(rpool);
 	}
@@ -506,6 +527,8 @@ static void print_rpool_values(struct seq_file *sf,
 				value = rpool->resources[i].max;
 			else
 				value = S32_MAX;
+		} else if (sf_type == RDMACG_RESOURCE_TYPE_PEAK) {
+			value = rpool ? rpool->resources[i].peak : 0;
 		} else {
 			if (rpool)
 				value = rpool->resources[i].usage;
@@ -556,6 +579,12 @@ static struct cftype rdmacg_files[] = {
 		.private = RDMACG_RESOURCE_TYPE_STAT,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "peak",
+		.seq_show = rdmacg_resource_read,
+		.private = RDMACG_RESOURCE_TYPE_PEAK,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ }	/* terminate */
 };
 
@@ -575,6 +604,13 @@ rdmacg_css_alloc(struct cgroup_subsys_state *parent)
 static void rdmacg_css_free(struct cgroup_subsys_state *css)
 {
 	struct rdma_cgroup *cg = css_rdmacg(css);
+	struct rdmacg_resource_pool *rpool, *tmp;
+
+	/* Clean up rpools kept alive by non-zero peak values */
+	mutex_lock(&rdmacg_mutex);
+	list_for_each_entry_safe(rpool, tmp, &cg->rpools, cg_node)
+		free_cg_rpool_locked(rpool);
+	mutex_unlock(&rdmacg_mutex);
 
 	kfree(cg);
 }
-- 
2.43.0



Return-Path: <cgroups+bounces-15884-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJgYHLBXBGqjHAIAu9opvQ
	(envelope-from <cgroups+bounces-15884-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:51:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843A531A7A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2F953023BFA
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978533E9C2D;
	Wed, 13 May 2026 10:51:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821A38B7B1
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669484; cv=none; b=g+wBpokZ/YEinP8+WGtP3OGZoruz8HZKTIwkCczcnyCB/RTrz7p4fAi3lnOrmSSjyLtihTExBvuHMND3YjwD+WtyGbbfk5L3Q5fKuXZ/NAN/ZMzzM7hAYSYMjd/EFAFZAf4aAYMk4ZtejUoedfVDIQttjkpZ6hkNomgCdTcNl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669484; c=relaxed/simple;
	bh=GtL32Vjb3XVUO1QjRW0eKQHChPDM/Zw6hYaivhpgY8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv6vMEM0xqkJtrpL9KwtH3TQslYIh6FKpO2cWbHLVDiYpRhhhUpWNTIijywon79Jg53BOo4pJhdNkBkT1CB0ZGuEOh/pZNFGEfuNowA9MNOGooqUwDLf+qNTczbAO4PDLd6zoemBsps4uDUx1ldUckbnrC+LioyUzMR5+yTYBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a9a24ab44eb911f1aa26b74ffac11d73-20260513
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9b0b190b-46aa-4f70-8e38-cabd28deeb06,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:9b0b190b-46aa-4f70-8e38-cabd28deeb06,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:2ae470180eeff4901a0a4ff7638e3608,BulkI
	D:260513185119W6M7OQMS,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a9a24ab44eb911f1aa26b74ffac11d73-20260513
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2136604528; Wed, 13 May 2026 18:51:14 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/4] cgroup/rdma: add rdma.peak for per-device peak usage tracking
Date: Wed, 13 May 2026 18:49:53 +0800
Message-ID: <20260513104956.373216-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513104956.373216-1-cuitao@kylinos.cn>
References: <20260513104956.373216-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0843A531A7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-15884-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

rdma.peak tracks the high watermark of resource usage per device,
giving a better baseline on which to set rdma.max. Polling
rdma.current isn't feasible since it would miss short-lived spikes.

This interface is analogous to memory.peak.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/cgroup/rdma.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 3df7c38ce481..4e3bf0bade18 100644
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
@@ -204,6 +206,17 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
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
 		 * No user of the rpool and all entries are set to max, so
 		 * safe to delete this rpool.
@@ -310,6 +323,12 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 			}
 		}
 	}
+	/* Update peak only after all charges succeed */
+	for (p = cg; p; p = parent_rdmacg(p)) {
+		rpool = find_cg_rpool_locked(p, device);
+		if (rpool && rpool->resources[index].usage > rpool->resources[index].peak)
+			rpool->resources[index].peak = rpool->resources[index].usage;
+	}
 	mutex_unlock(&rdmacg_mutex);
 
 	*rdmacg = cg;
@@ -472,6 +491,12 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 
 	if (rpool->usage_sum == 0 &&
 	    rpool->num_max_cnt == RDMACG_RESOURCE_MAX) {
+		int i;
+
+		for (i = 0; i < RDMACG_RESOURCE_MAX; i++) {
+			if (rpool->resources[i].peak)
+				goto dev_err;
+		}
 		/*
 		 * No user of the rpool and all entries are set to max, so
 		 * safe to delete this rpool.
@@ -506,6 +531,8 @@ static void print_rpool_values(struct seq_file *sf,
 				value = rpool->resources[i].max;
 			else
 				value = S32_MAX;
+		} else if (sf_type == RDMACG_RESOURCE_TYPE_PEAK) {
+			value = rpool ? rpool->resources[i].peak : 0;
 		} else {
 			if (rpool)
 				value = rpool->resources[i].usage;
@@ -556,6 +583,12 @@ static struct cftype rdmacg_files[] = {
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
 
@@ -575,6 +608,13 @@ rdmacg_css_alloc(struct cgroup_subsys_state *parent)
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



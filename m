Return-Path: <cgroups+bounces-16240-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGuII5DkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16240-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D85C61A1
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF63330363B4
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8835E1C4;
	Mon, 25 May 2026 05:55:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37435BDC7;
	Mon, 25 May 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688531; cv=none; b=fdOvHARQChaenC4CYOC3+tLhszfzTDCBJkUjPoAFl5Z42BSjFlZ5e1eHQQULzY+QD6n9w4DwJjKtqEpGPHdX3/aDBOSFSLHs5yh47Fh53skCDkOcX+7CovtgZZmcburoDclRVJRFxJMZOnw1JQ6429IFciQduBGtC+ve/OWoRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688531; c=relaxed/simple;
	bh=Mi3MiSQiC7TZqoWzidoQsuHP7hmy7V56ihCQsC5LzDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9WJKYt35uki7rmBBZo9bbq6sbrRWVUeQQpNQ/6m4lqXEhtRk3BNJk3tFyiXO3/KwXaEhq31QPZfSHF9Fx3su8R0TDbUP9oWBbHiJ+0Kzn8JiHAxEhgnUBwOntqHqxQze+opI3iVTjIK9xxNIwh+ytUQwBA8rwnaUhdqluK3MYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 516fe88a57fe11f1aa26b74ffac11d73-20260525
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
X-CID-O-INFO: VERSION:1.3.12,REQID:fce3c9d3-a5e2-4368-8f2a-4aa5812b7f6b,IP:20,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.3.12,REQID:fce3c9d3-a5e2-4368-8f2a-4aa5812b7f6b,IP:20,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3e7d4209f96287518a67207084e03bf4,BulkI
	D:260525135525CJSJ1KDY,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 516fe88a57fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2011196849; Mon, 25 May 2026 13:55:22 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 3/5] cgroup/rdma: add MR per-type resource counting
Date: Mon, 25 May 2026 13:55:04 +0800
Message-ID: <20260525055506.2002985-4-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525055506.2002985-1-cuitao@kylinos.cn>
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-16240-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 397D85C61A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RDMACG_RESOURCE_MR so that Memory Region registration can be
tracked and limited independently from the aggregate hca_object
counter.

Like QP, MR uses dual charging: the existing hca_object charge in
the generic IDR path still applies, and an additional per-type MR
counter is incremented.  This enables MR-specific limits:

  echo "mlx5_0 mr=500" > rdma.max

Extend uverbs_obj_to_rdmacg_type() with the MR mapping case.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/rdma_core.c |  1 +
 include/linux/cgroup_rdma.h         |  1 +
 kernel/cgroup/rdma.c                | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index aca735947230..8fb0df4aa0af 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -427,6 +427,7 @@ uverbs_obj_to_rdmacg_type(u16 uverbs_obj_id)
 {
 	switch (uverbs_obj_id) {
 	case UVERBS_OBJECT_QP: return RDMACG_RESOURCE_QP;
+	case UVERBS_OBJECT_MR: return RDMACG_RESOURCE_MR;
 	default:               return RDMACG_RESOURCE_HCA_OBJECT;
 	}
 }
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 2dcae0e04063..35caccc8eb8d 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -13,6 +13,7 @@ enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_HANDLE,
 	RDMACG_RESOURCE_HCA_OBJECT,
 	RDMACG_RESOURCE_QP,
+	RDMACG_RESOURCE_MR,
 	RDMACG_RESOURCE_MAX,
 };
 
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index f9922f6f87c9..a056a14d9af5 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -25,6 +25,8 @@ enum rdmacg_limit_tokens {
 	RDMACG_HCA_OBJECT_MAX,
 	RDMACG_QP_VAL,
 	RDMACG_QP_MAX,
+	RDMACG_MR_VAL,
+	RDMACG_MR_MAX,
 	NR_RDMACG_LIMIT_TOKENS,
 };
 
@@ -40,6 +42,8 @@ static const match_table_t rdmacg_limit_tokens = {
 	{ RDMACG_HCA_OBJECT_MAX,	"hca_object=max"	},
 	{ RDMACG_QP_VAL,		"qp=%d"			},
 	{ RDMACG_QP_MAX,		"qp=max"		},
+	{ RDMACG_MR_VAL,		"mr=%d"			},
+	{ RDMACG_MR_MAX,		"mr=max"		},
 	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
 };
 
@@ -65,6 +69,7 @@ static char const *rdmacg_resource_names[] = {
 	[RDMACG_RESOURCE_HCA_HANDLE]	= "hca_handle",
 	[RDMACG_RESOURCE_HCA_OBJECT]	= "hca_object",
 	[RDMACG_RESOURCE_QP]		= "qp",
+	[RDMACG_RESOURCE_MR]		= "mr",
 };
 static_assert(ARRAY_SIZE(rdmacg_resource_names) == RDMACG_RESOURCE_MAX);
 
@@ -592,6 +597,18 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			new_limits[RDMACG_RESOURCE_QP] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_QP);
 			break;
+		case RDMACG_MR_VAL:
+			if (match_s64(&args[0], &intval)) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			new_limits[RDMACG_RESOURCE_MR] = intval;
+			enables |= BIT(RDMACG_RESOURCE_MR);
+			break;
+		case RDMACG_MR_MAX:
+			new_limits[RDMACG_RESOURCE_MR] = S64_MAX;
+			enables |= BIT(RDMACG_RESOURCE_MR);
+			break;
 		default:
 			ret = -EINVAL;
 			goto parse_err;
-- 
2.43.0



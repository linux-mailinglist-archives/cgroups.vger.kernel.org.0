Return-Path: <cgroups+bounces-16237-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOtgNHrkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16237-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC45C6174
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C903303259C
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759F35E1D2;
	Mon, 25 May 2026 05:55:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63035B654;
	Mon, 25 May 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688527; cv=none; b=sklyg90vyx6YeZupnI1fSNHeeGVEfeNf4bB694oNVG2mOOUOdxfVqtADYQJkNwsqTKvA6R/aVy3/KD7VYkc9KIMmAV21+ZeeHcusbLC8SXSkH8aRpjs0WWdO/IhW2orW1qzv8lN72W+kxhvWqFPZMP4SEWahgV2eQ3vbDLLRyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688527; c=relaxed/simple;
	bh=Q83cGhjmp/49LuXD+PFow3nE2DLP+/GbskpjOf0SXfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe+1z5H8yvElFt5LEEAJkU3Yc6C+QfBJBj771jCvVLyf7Jzk6yYgECbeEaTGoQ5CUOVLjkiAz2tQfFEv1XCmCZSVpYzJ38O78ghomDOzv43vV6emnNrPlz+AgCgeCk49dHZOwD11sFMJrZlStU/AFZN73a8yq4JW9qjX0kYuB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 50ab011e57fe11f1aa26b74ffac11d73-20260525
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
X-CID-O-INFO: VERSION:1.3.12,REQID:5b2418d1-dbd8-45c2-8956-1dd8bb3769b5,IP:20,
	URL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.3.12,REQID:5b2418d1-dbd8-45c2-8956-1dd8bb3769b5,IP:20,UR
	L:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:30248a3fa764874b44c29f9e51ad79eb,BulkI
	D:2605251355221Y4TUY7I,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50ab011e57fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1263259128; Mon, 25 May 2026 13:55:21 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 2/5] cgroup/rdma: add QP per-type resource counting
Date: Mon, 25 May 2026 13:55:03 +0800
Message-ID: <20260525055506.2002985-3-cuitao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16237-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79FC45C6174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RDMACG_RESOURCE_QP so that Queue Pair creation can be tracked
and limited independently from the aggregate hca_object counter.

The existing hca_object charge in the generic IDR allocation path
still applies to QP objects (dual charging).  The new per-type
counter allows administrators to set QP-specific limits:

  echo "mlx5_0 qp=100" > rdma.max

Add uverbs_obj_to_rdmacg_type() to map uverbs object IDs to rdmacg
resource types.  Store the mapped type in uobj->rdmacg_type so that
the generic uncharge paths (alloc_abort, destroy_hw) can issue the
per-type uncharge.  Adding new per-type resources only requires
extending this mapping function.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/rdma_core.c | 37 ++++++++++++++++++++++++++---
 include/linux/cgroup_rdma.h         |  1 +
 include/rdma/ib_verbs.h             |  1 +
 kernel/cgroup/rdma.c                | 18 ++++++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 3268285b5478..aca735947230 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -40,6 +40,7 @@
 #include <rdma/rdma_user_ioctl.h>
 #include "uverbs.h"
 #include "core_priv.h"
+#include <rdma/ib_user_ioctl_cmds.h>
 #include "rdma_core.h"
 
 static void uverbs_uobject_free(struct kref *ref)
@@ -421,12 +422,22 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	return ERR_PTR(ret);
 }
 
+static enum rdmacg_resource_type
+uverbs_obj_to_rdmacg_type(u16 uverbs_obj_id)
+{
+	switch (uverbs_obj_id) {
+	case UVERBS_OBJECT_QP: return RDMACG_RESOURCE_QP;
+	default:               return RDMACG_RESOURCE_HCA_OBJECT;
+	}
+}
+
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
 			struct uverbs_attr_bundle *attrs)
 {
 	int ret;
 	struct ib_uobject *uobj;
+	enum rdmacg_resource_type rdmacg_type;
 
 	uobj = alloc_uobj(attrs, obj);
 	if (IS_ERR(uobj))
@@ -441,6 +452,19 @@ alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
 	if (ret)
 		goto remove;
 
+	rdmacg_type = uverbs_obj_to_rdmacg_type(uobj_get_object_id(uobj));
+	if (rdmacg_type != RDMACG_RESOURCE_HCA_OBJECT) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   rdmacg_type, 1);
+		if (ret) {
+			ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_HCA_OBJECT, 1);
+			goto remove;
+		}
+	}
+
+	uobj->rdmacg_type = rdmacg_type;
+
 	return uobj;
 
 remove:
@@ -523,10 +547,18 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 	return ret;
 }
 
-static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
+static void rdmacg_uncharge_uobj(struct ib_uobject *uobj)
 {
 	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
 			   RDMACG_RESOURCE_HCA_OBJECT, 1);
+	if (uobj->rdmacg_type != RDMACG_RESOURCE_HCA_OBJECT)
+		ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
+				   uobj->rdmacg_type, 1);
+}
+
+static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
+{
+	rdmacg_uncharge_uobj(uobj);
 
 	xa_erase(&uobj->ufile->idr, uobj->id);
 }
@@ -546,8 +578,7 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 	if (why == RDMA_REMOVE_ABORT)
 		return 0;
 
-	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
-			   RDMACG_RESOURCE_HCA_OBJECT, 1);
+	rdmacg_uncharge_uobj(uobj);
 
 	return 0;
 }
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 7146cefa95a6..2dcae0e04063 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -12,6 +12,7 @@
 enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_HANDLE,
 	RDMACG_RESOURCE_HCA_OBJECT,
+	RDMACG_RESOURCE_QP,
 	RDMACG_RESOURCE_MAX,
 };
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..7dcb3955505b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1569,6 +1569,7 @@ struct ib_uobject {
 	void		       *object;		/* containing object */
 	struct list_head	list;		/* link to context's list */
 	struct ib_rdmacg_object	cg_obj;		/* rdmacg object */
+	enum rdmacg_resource_type rdmacg_type;	/* per-type cgroup index */
 	int			id;		/* index into kernel idr */
 	struct kref		ref;
 	atomic_t		usecnt;		/* protects exclusive access */
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 7e0fff415528..f9922f6f87c9 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -23,6 +23,8 @@ enum rdmacg_limit_tokens {
 	RDMACG_HCA_HANDLE_MAX,
 	RDMACG_HCA_OBJECT_VAL,
 	RDMACG_HCA_OBJECT_MAX,
+	RDMACG_QP_VAL,
+	RDMACG_QP_MAX,
 	NR_RDMACG_LIMIT_TOKENS,
 };
 
@@ -36,6 +38,8 @@ static const match_table_t rdmacg_limit_tokens = {
 	{ RDMACG_HCA_HANDLE_MAX,	"hca_handle=max"	},
 	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"		},
 	{ RDMACG_HCA_OBJECT_MAX,	"hca_object=max"	},
+	{ RDMACG_QP_VAL,		"qp=%d"			},
+	{ RDMACG_QP_MAX,		"qp=max"		},
 	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
 };
 
@@ -60,7 +64,9 @@ enum rdmacg_file_type {
 static char const *rdmacg_resource_names[] = {
 	[RDMACG_RESOURCE_HCA_HANDLE]	= "hca_handle",
 	[RDMACG_RESOURCE_HCA_OBJECT]	= "hca_object",
+	[RDMACG_RESOURCE_QP]		= "qp",
 };
+static_assert(ARRAY_SIZE(rdmacg_resource_names) == RDMACG_RESOURCE_MAX);
 
 /* resource tracker for each resource of rdma cgroup */
 struct rdmacg_resource {
@@ -574,6 +580,18 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
 			break;
+		case RDMACG_QP_VAL:
+			if (match_s64(&args[0], &intval)) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			new_limits[RDMACG_RESOURCE_QP] = intval;
+			enables |= BIT(RDMACG_RESOURCE_QP);
+			break;
+		case RDMACG_QP_MAX:
+			new_limits[RDMACG_RESOURCE_QP] = S64_MAX;
+			enables |= BIT(RDMACG_RESOURCE_QP);
+			break;
 		default:
 			ret = -EINVAL;
 			goto parse_err;
-- 
2.43.0



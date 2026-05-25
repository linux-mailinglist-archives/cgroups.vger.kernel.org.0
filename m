Return-Path: <cgroups+bounces-16239-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDBpJ4jkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16239-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE905C6192
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8233034E27
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0235E1DE;
	Mon, 25 May 2026 05:55:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162D35E1B4;
	Mon, 25 May 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688529; cv=none; b=Lb8wSunsVXyvNBAmCZX7VqHugK3wJSWHuXvGy7QJQ1b6pwEFLtAdFfesqolEQdXVXraCaD4puM+U4bj2WI+7VYzWEGeCTe78J4NNoqI2IVrNoN+psAeaaxscSdZ5mDA1M0d5bgFPyXz0/EqoSlcBZClZxVloaeDa3kim8MPKgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688529; c=relaxed/simple;
	bh=9QEImgqpNC2DposUJ1JDUfFJl5bQY1oEfrBzhe9wOFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJRumEZgKnQ+U+Jns28EX3T/F0Y/xy3GDsOQM0WMdh7Vk0esbIKXzGUwU8NyanVTkkTnDXWV3vJB3IGGk8F4OnvoKKryBYmEvklkRad3vsslIBJf+wC4vrsRqm1eVF/jfjZuSn1ykBzfUxDmjluJ32RVYT+5pFeaEWkWLzLMSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5246fb5e57fe11f1aa26b74ffac11d73-20260525
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
X-CID-O-INFO: VERSION:1.3.12,REQID:d04e0381-4892-4f71-a25d-105f6dbe8596,IP:20,
	URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.3.12,REQID:d04e0381-4892-4f71-a25d-105f6dbe8596,IP:20,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:91e3d4d6c1e904b4d966b24b57c898c3,BulkI
	D:26052513552587ZKTRR1,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5246fb5e57fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 410578630; Mon, 25 May 2026 13:55:23 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 4/5] cgroup/rdma: add MR memory size per-type resource counting
Date: Mon, 25 May 2026 13:55:05 +0800
Message-ID: <20260525055506.2002985-5-cuitao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16239-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3EE905C6192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RDMACG_RESOURCE_MR_MEM so that the cumulative memory size of
registered Memory Regions can be tracked and limited independently
from the MR count.

Unlike count-based resources (QP, MR) which are charged in the
generic IDR allocation path, MR_MEM is byte-based and must be
charged after the MR length is known.  Charge in the uverbs MR
registration handlers (ioctl and legacy), and uncharge in the
generic destroy paths (alloc_abort_idr_uobject,
destroy_hw_idr_uobject).

Store the charged byte count in uobj->rdmacg_mr_mem_bytes so that
the destroy path knows how much to uncharge even if the charge
succeeded but uobject finalization was not reached.

Enable MR memory limits:

  echo "mlx5_0 mr_mem=1073741824" > rdma.max

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/rdma_core.c           |  4 +++
 drivers/infiniband/core/uverbs_cmd.c          | 12 +++++++
 drivers/infiniband/core/uverbs_std_types_mr.c | 32 +++++++++++++++++++
 include/linux/cgroup_rdma.h                   |  1 +
 include/rdma/ib_verbs.h                       |  1 +
 kernel/cgroup/rdma.c                          | 17 ++++++++++
 6 files changed, 67 insertions(+)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 8fb0df4aa0af..cdae3d7d0931 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -555,6 +555,10 @@ static void rdmacg_uncharge_uobj(struct ib_uobject *uobj)
 	if (uobj->rdmacg_type != RDMACG_RESOURCE_HCA_OBJECT)
 		ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
 				   uobj->rdmacg_type, 1);
+	if (uobj->rdmacg_mr_mem_bytes)
+		ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
+				   RDMACG_RESOURCE_MR_MEM,
+				   uobj->rdmacg_mr_mem_bytes);
 }
 
 static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 9540ac180711..9f5a10da44dc 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -752,6 +752,15 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	uobj->object = mr;
 	uobj_put_obj_read(pd);
+
+	if (cmd.length) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_MR_MEM, cmd.length);
+		if (ret)
+			goto err_dereg;
+		uobj->rdmacg_mr_mem_bytes = cmd.length;
+	}
+
 	uobj_finalize_uobj_create(uobj, attrs);
 
 	resp.lkey = mr->lkey;
@@ -759,6 +768,9 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	resp.mr_handle = uobj->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_dereg:
+	ib_dereg_mr_user(mr, &attrs->driver_udata);
+	goto err_free;
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 570b9656801d..ffb7d1f97b20 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -34,6 +34,8 @@
 #include "rdma_core.h"
 #include "uverbs.h"
 #include <rdma/uverbs_std_types.h>
+#include <linux/cgroup_rdma.h>
+#include "core_priv.h"
 #include "restrack.h"
 
 static int uverbs_free_mr(struct ib_uobject *uobject,
@@ -141,6 +143,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
+	if (attr.length) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_MR_MEM, attr.length);
+		if (ret) {
+			ib_dereg_mr_user(mr, &attrs->driver_udata);
+			return ret;
+		}
+		uobj->rdmacg_mr_mem_bytes = attr.length;
+	}
+
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DM_MR_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DM_MR_RESP_LKEY, &mr->lkey,
@@ -254,6 +266,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
+	if (length) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_MR_MEM, length);
+		if (ret) {
+			ib_dereg_mr_user(mr, &attrs->driver_udata);
+			return ret;
+		}
+		uobj->rdmacg_mr_mem_bytes = length;
+	}
+
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
@@ -383,6 +405,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
+	if (length) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_MR_MEM, length);
+		if (ret) {
+			ib_dereg_mr_user(mr, &attrs->driver_udata);
+			return ret;
+		}
+		uobj->rdmacg_mr_mem_bytes = length;
+	}
+
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_MR_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_MR_RESP_LKEY,
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 35caccc8eb8d..10a373b8148b 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -14,6 +14,7 @@ enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_OBJECT,
 	RDMACG_RESOURCE_QP,
 	RDMACG_RESOURCE_MR,
+	RDMACG_RESOURCE_MR_MEM,
 	RDMACG_RESOURCE_MAX,
 };
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7dcb3955505b..951d8dfc98c4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1570,6 +1570,7 @@ struct ib_uobject {
 	struct list_head	list;		/* link to context's list */
 	struct ib_rdmacg_object	cg_obj;		/* rdmacg object */
 	enum rdmacg_resource_type rdmacg_type;	/* per-type cgroup index */
+	s64			rdmacg_mr_mem_bytes; /* charged MR memory size */
 	int			id;		/* index into kernel idr */
 	struct kref		ref;
 	atomic_t		usecnt;		/* protects exclusive access */
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index a056a14d9af5..1386f93b9fbf 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -27,6 +27,8 @@ enum rdmacg_limit_tokens {
 	RDMACG_QP_MAX,
 	RDMACG_MR_VAL,
 	RDMACG_MR_MAX,
+	RDMACG_MR_MEM_VAL,
+	RDMACG_MR_MEM_MAX,
 	NR_RDMACG_LIMIT_TOKENS,
 };
 
@@ -44,6 +46,8 @@ static const match_table_t rdmacg_limit_tokens = {
 	{ RDMACG_QP_MAX,		"qp=max"		},
 	{ RDMACG_MR_VAL,		"mr=%d"			},
 	{ RDMACG_MR_MAX,		"mr=max"		},
+	{ RDMACG_MR_MEM_VAL,		"mr_mem=%d"		},
+	{ RDMACG_MR_MEM_MAX,		"mr_mem=max"		},
 	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
 };
 
@@ -70,6 +74,7 @@ static char const *rdmacg_resource_names[] = {
 	[RDMACG_RESOURCE_HCA_OBJECT]	= "hca_object",
 	[RDMACG_RESOURCE_QP]		= "qp",
 	[RDMACG_RESOURCE_MR]		= "mr",
+	[RDMACG_RESOURCE_MR_MEM]	= "mr_mem",
 };
 static_assert(ARRAY_SIZE(rdmacg_resource_names) == RDMACG_RESOURCE_MAX);
 
@@ -609,6 +614,18 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			new_limits[RDMACG_RESOURCE_MR] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_MR);
 			break;
+		case RDMACG_MR_MEM_VAL:
+			if (match_s64(&args[0], &intval)) {
+				ret = -EINVAL;
+				goto parse_err;
+			}
+			new_limits[RDMACG_RESOURCE_MR_MEM] = intval;
+			enables |= BIT(RDMACG_RESOURCE_MR_MEM);
+			break;
+		case RDMACG_MR_MEM_MAX:
+			new_limits[RDMACG_RESOURCE_MR_MEM] = S64_MAX;
+			enables |= BIT(RDMACG_RESOURCE_MR_MEM);
+			break;
 		default:
 			ret = -EINVAL;
 			goto parse_err;
-- 
2.43.0



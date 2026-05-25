Return-Path: <cgroups+bounces-16238-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDKCIoHkE2rhHAcAu9opvQ
	(envelope-from <cgroups+bounces-16238-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A05C6183
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 07:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1CA13033AB7
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1035E1B0;
	Mon, 25 May 2026 05:55:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1B35DA48;
	Mon, 25 May 2026 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688528; cv=none; b=oNqKBOl8n7FIlz4MwaJaKJkMmT+9Lospgr6P+gqqAE0Lt9bpuvpmQdiwDmazi+Y9er1/JShBt0g9/BvzFXgCgSmz226NdjKvDSpsiJKYicNqYRTLtmAE1gblCCXTQC45DOf7KnKoCwqCvYcl3pfwXsE56d0M2mk8zTxDqZtykT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688528; c=relaxed/simple;
	bh=3CGd3rO1BsanSHg1cM85X1FJOhe5axiNqHQGGwrGaTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8Iinl5U26ynsbVIIL8HUxBVnX21l0uBxJzVjeFDJv/1tHhV2c2Z2JA7jZNaLI+pgMjWEibgNfZmwIQYTU1PGcmxZOG8d1/FsZhxwOtHRuaVWE/r0NDp4gCMWI84dUpMc075wWXNhNiM7txzEoKhUsQEdLw/ccm97BR0OthKgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f70e35e57fe11f1aa26b74ffac11d73-20260525
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
X-CID-O-INFO: VERSION:1.3.12,REQID:92836ae3-50c5-40d3-8dd0-4d8f668f6c3e,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:92836ae3-50c5-40d3-8dd0-4d8f668f6c3e,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:956131dbda308ca844e50c0520eb15d6,BulkI
	D:260525135522JWG5JAJ3,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4f70e35e57fe11f1aa26b74ffac11d73-20260525
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2117219381; Mon, 25 May 2026 13:55:19 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH rdma-next 1/5] cgroup/rdma: extend charge/uncharge API with s64 amount parameter
Date: Mon, 25 May 2026 13:55:02 +0800
Message-ID: <20260525055506.2002985-2-cuitao@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-16238-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 314A05C6183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Change struct rdmacg_resource fields (max, usage) and all
charge/uncharge function signatures from int to s64 to prepare for
byte-sized resource tracking such as MR memory.

Replace match_int with a match_s64 helper that uses kstrtoll so the
user-space limit tokens accept 64-bit values.  All existing callers
pass amount=1 (count-based), so the change is transparent for
existing count-based resources.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/cgroup.c     | 10 +--
 drivers/infiniband/core/core_priv.h  | 12 ++--
 drivers/infiniband/core/rdma_core.c  |  8 +--
 drivers/infiniband/core/uverbs_cmd.c |  4 +-
 include/linux/cgroup_rdma.h          |  7 +-
 kernel/cgroup/rdma.c                 | 99 +++++++++++++++++++---------
 6 files changed, 93 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/core/cgroup.c b/drivers/infiniband/core/cgroup.c
index 1f037fe01450..81e24de72392 100644
--- a/drivers/infiniband/core/cgroup.c
+++ b/drivers/infiniband/core/cgroup.c
@@ -36,18 +36,20 @@ void ib_device_unregister_rdmacg(struct ib_device *device)
 
 int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 			 struct ib_device *device,
-			 enum rdmacg_resource_type resource_index)
+			 enum rdmacg_resource_type resource_index,
+			 s64 amount)
 {
 	return rdmacg_try_charge(&cg_obj->cg, &device->cg_device,
-				 resource_index);
+				 resource_index, amount);
 }
 EXPORT_SYMBOL(ib_rdmacg_try_charge);
 
 void ib_rdmacg_uncharge(struct ib_rdmacg_object *cg_obj,
 			struct ib_device *device,
-			enum rdmacg_resource_type resource_index)
+			enum rdmacg_resource_type resource_index,
+			s64 amount)
 {
 	rdmacg_uncharge(cg_obj->cg, &device->cg_device,
-			resource_index);
+			resource_index, amount);
 }
 EXPORT_SYMBOL(ib_rdmacg_uncharge);
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a2c36666e6fc..866d99268032 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -159,11 +159,13 @@ void ib_device_unregister_rdmacg(struct ib_device *device);
 
 int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 			 struct ib_device *device,
-			 enum rdmacg_resource_type resource_index);
+			 enum rdmacg_resource_type resource_index,
+			 s64 amount);
 
 void ib_rdmacg_uncharge(struct ib_rdmacg_object *cg_obj,
 			struct ib_device *device,
-			enum rdmacg_resource_type resource_index);
+			enum rdmacg_resource_type resource_index,
+			s64 amount);
 #else
 static inline void ib_device_register_rdmacg(struct ib_device *device)
 {
@@ -175,14 +177,16 @@ static inline void ib_device_unregister_rdmacg(struct ib_device *device)
 
 static inline int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 				       struct ib_device *device,
-				       enum rdmacg_resource_type resource_index)
+				       enum rdmacg_resource_type resource_index,
+				       s64 amount)
 {
 	return 0;
 }
 
 static inline void ib_rdmacg_uncharge(struct ib_rdmacg_object *cg_obj,
 				      struct ib_device *device,
-				      enum rdmacg_resource_type resource_index)
+				      enum rdmacg_resource_type resource_index,
+				      s64 amount)
 {
 }
 #endif
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5018ec837056..3268285b5478 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -437,7 +437,7 @@ alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
 		goto uobj_put;
 
 	ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
-				   RDMACG_RESOURCE_HCA_OBJECT);
+				   RDMACG_RESOURCE_HCA_OBJECT, 1);
 	if (ret)
 		goto remove;
 
@@ -526,7 +526,7 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
 {
 	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
-			   RDMACG_RESOURCE_HCA_OBJECT);
+			   RDMACG_RESOURCE_HCA_OBJECT, 1);
 
 	xa_erase(&uobj->ufile->idr, uobj->id);
 }
@@ -547,7 +547,7 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 		return 0;
 
 	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
-			   RDMACG_RESOURCE_HCA_OBJECT);
+			   RDMACG_RESOURCE_HCA_OBJECT, 1);
 
 	return 0;
 }
@@ -878,7 +878,7 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	}
 
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
-			   RDMACG_RESOURCE_HCA_HANDLE);
+			   RDMACG_RESOURCE_HCA_HANDLE, 1);
 
 	rdma_restrack_del(&ucontext->res);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 91a62d2ade4d..9540ac180711 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -234,7 +234,7 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 	}
 
 	ret = ib_rdmacg_try_charge(&ucontext->cg_obj, ucontext->device,
-				   RDMACG_RESOURCE_HCA_HANDLE);
+				   RDMACG_RESOURCE_HCA_HANDLE, 1);
 	if (ret)
 		goto err;
 
@@ -273,7 +273,7 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 
 err_uncharge:
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ucontext->device,
-			   RDMACG_RESOURCE_HCA_HANDLE);
+			   RDMACG_RESOURCE_HCA_HANDLE, 1);
 err:
 	mutex_unlock(&file->ucontext_lock);
 	up_read(&file->hw_destroy_rwsem);
diff --git a/include/linux/cgroup_rdma.h b/include/linux/cgroup_rdma.h
index 404e746552ca..7146cefa95a6 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -7,6 +7,7 @@
 #define _CGROUP_RDMA_H
 
 #include <linux/cgroup.h>
+#include <linux/types.h>
 
 enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_HANDLE,
@@ -46,9 +47,11 @@ void rdmacg_unregister_device(struct rdmacg_device *device);
 /* APIs for RDMA/IB stack to charge/uncharge pool specific resources */
 int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 		      struct rdmacg_device *device,
-		      enum rdmacg_resource_type index);
+		      enum rdmacg_resource_type index,
+		      s64 amount);
 void rdmacg_uncharge(struct rdma_cgroup *cg,
 		     struct rdmacg_device *device,
-		     enum rdmacg_resource_type index);
+		     enum rdmacg_resource_type index,
+		     s64 amount);
 #endif	/* CONFIG_CGROUP_RDMA */
 #endif	/* _CGROUP_RDMA_H */
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 5e82a03b3270..7e0fff415528 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -26,10 +26,15 @@ enum rdmacg_limit_tokens {
 	NR_RDMACG_LIMIT_TOKENS,
 };
 
+/* match_token uses %d for substring extraction only (simple_strtol captures
+ * all digits regardless of overflow).  Actual s64 range validation is done
+ * by match_s64() below - must not be changed to %s or the "xxx=max" exact
+ * match patterns would be shadowed.
+ */
 static const match_table_t rdmacg_limit_tokens = {
-	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"	},
+	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"		},
 	{ RDMACG_HCA_HANDLE_MAX,	"hca_handle=max"	},
-	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"	},
+	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"		},
 	{ RDMACG_HCA_OBJECT_MAX,	"hca_object=max"	},
 	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
 };
@@ -59,9 +64,9 @@ static char const *rdmacg_resource_names[] = {
 
 /* resource tracker for each resource of rdma cgroup */
 struct rdmacg_resource {
-	int max;
-	int usage;
-	int peak;
+	s64 max;
+	s64 usage;
+	s64 peak;
 };
 
 /*
@@ -105,13 +110,13 @@ static inline struct rdma_cgroup *get_current_rdmacg(void)
 }
 
 static void set_resource_limit(struct rdmacg_resource_pool *rpool,
-			       int index, int new_max)
+			       int index, s64 new_max)
 {
-	if (new_max == S32_MAX) {
-		if (rpool->resources[index].max != S32_MAX)
+	if (new_max == S64_MAX) {
+		if (rpool->resources[index].max != S64_MAX)
 			rpool->num_max_cnt++;
 	} else {
-		if (rpool->resources[index].max == S32_MAX)
+		if (rpool->resources[index].max == S64_MAX)
 			rpool->num_max_cnt--;
 	}
 	rpool->resources[index].max = new_max;
@@ -122,7 +127,7 @@ static void set_all_resource_max_limit(struct rdmacg_resource_pool *rpool)
 	int i;
 
 	for (i = 0; i < RDMACG_RESOURCE_MAX; i++)
-		set_resource_limit(rpool, i, S32_MAX);
+		set_resource_limit(rpool, i, S64_MAX);
 }
 
 static void free_cg_rpool_locked(struct rdmacg_resource_pool *rpool)
@@ -198,6 +203,7 @@ get_cg_rpool_locked(struct rdma_cgroup *cg, struct rdmacg_device *device)
  * @cg: pointer to cg to uncharge and all parents in hierarchy
  * @device: pointer to rdmacg device
  * @index: index of the resource to uncharge in cg (resource pool)
+ * @amount: amount to uncharge
  *
  * It also frees the resource pool which was created as part of
  * charging operation when there are no resources attached to
@@ -206,7 +212,8 @@ get_cg_rpool_locked(struct rdma_cgroup *cg, struct rdmacg_device *device)
 static void
 uncharge_cg_locked(struct rdma_cgroup *cg,
 		   struct rdmacg_device *device,
-		   enum rdmacg_resource_type index)
+		   enum rdmacg_resource_type index,
+		   s64 amount)
 {
 	struct rdmacg_resource_pool *rpool;
 
@@ -222,7 +229,7 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 		return;
 	}
 
-	rpool->resources[index].usage--;
+	rpool->resources[index].usage -= amount;
 
 	/*
 	 * A negative count (or overflow) is invalid,
@@ -303,18 +310,20 @@ static void rdmacg_event_locked(struct rdma_cgroup *cg,
  * @stop_cg: while traversing hirerchy, when meet with stop_cg cgroup
  *           stop uncharging
  * @index: index of the resource to uncharge in cg in given resource pool
+ * @amount: amount to uncharge
  */
 static void rdmacg_uncharge_hierarchy(struct rdma_cgroup *cg,
 				     struct rdmacg_device *device,
 				     struct rdma_cgroup *stop_cg,
-				     enum rdmacg_resource_type index)
+				     enum rdmacg_resource_type index,
+				     s64 amount)
 {
 	struct rdma_cgroup *p;
 
 	mutex_lock(&rdmacg_mutex);
 
 	for (p = cg; p != stop_cg; p = parent_rdmacg(p))
-		uncharge_cg_locked(p, device, index);
+		uncharge_cg_locked(p, device, index, amount);
 
 	mutex_unlock(&rdmacg_mutex);
 
@@ -326,15 +335,17 @@ static void rdmacg_uncharge_hierarchy(struct rdma_cgroup *cg,
  * @cg: pointer to cg to uncharge and all parents in hierarchy
  * @device: pointer to rdmacg device
  * @index: index of the resource to uncharge in cgroup in given resource pool
+ * @amount: amount to uncharge
  */
 void rdmacg_uncharge(struct rdma_cgroup *cg,
 		     struct rdmacg_device *device,
-		     enum rdmacg_resource_type index)
+		     enum rdmacg_resource_type index,
+		     s64 amount)
 {
 	if (index >= RDMACG_RESOURCE_MAX)
 		return;
 
-	rdmacg_uncharge_hierarchy(cg, device, NULL, index);
+	rdmacg_uncharge_hierarchy(cg, device, NULL, index, amount);
 }
 EXPORT_SYMBOL(rdmacg_uncharge);
 
@@ -343,6 +354,7 @@ EXPORT_SYMBOL(rdmacg_uncharge);
  * @rdmacg: pointer to rdma cgroup which will own this resource
  * @device: pointer to rdmacg device
  * @index: index of the resource to charge in cgroup (resource pool)
+ * @amount: amount to charge
  *
  * This function follows charging resource in hierarchical way.
  * It will fail if the charge would cause the new value to exceed the
@@ -361,7 +373,8 @@ EXPORT_SYMBOL(rdmacg_uncharge);
  */
 int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 		      struct rdmacg_device *device,
-		      enum rdmacg_resource_type index)
+		      enum rdmacg_resource_type index,
+		      s64 amount)
 {
 	struct rdma_cgroup *cg, *p;
 	struct rdmacg_resource_pool *rpool;
@@ -371,6 +384,9 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 	if (index >= RDMACG_RESOURCE_MAX)
 		return -EINVAL;
 
+	if (amount <= 0)
+		return -EINVAL;
+
 	/*
 	 * hold on to css, as cgroup can be removed but resource
 	 * accounting happens on css.
@@ -384,8 +400,9 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 			ret = PTR_ERR(rpool);
 			goto err;
 		} else {
-			new = (s64)rpool->resources[index].usage + 1;
-			if (new > rpool->resources[index].max) {
+			new = rpool->resources[index].usage + amount;
+			if (new < rpool->resources[index].usage ||
+			    new > rpool->resources[index].max) {
 				ret = -EAGAIN;
 				goto err;
 			} else {
@@ -409,7 +426,7 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 	if (ret == -EAGAIN)
 		rdmacg_event_locked(cg, p, device, index);
 	mutex_unlock(&rdmacg_mutex);
-	rdmacg_uncharge_hierarchy(cg, device, p, index);
+	rdmacg_uncharge_hierarchy(cg, device, p, index, amount);
 	return ret;
 }
 EXPORT_SYMBOL(rdmacg_try_charge);
@@ -477,6 +494,25 @@ static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
 	return NULL;
 }
 
+static int match_s64(substring_t *s, s64 *result)
+{
+	char *buf;
+	int ret;
+	s64 val;
+
+	buf = kmemdup_nul(s->from, s->to - s->from, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	ret = kstrtoll(buf, 0, &val);
+	kfree(buf);
+	if (ret)
+		return ret;
+	if (val < 0)
+		return -EINVAL;
+	*result = val;
+	return 0;
+}
+
 static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
@@ -486,7 +522,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	struct rdmacg_device *device;
 	char *options = strstrip(buf);
 	char *p;
-	int *new_limits;
+	s64 *new_limits;
 	unsigned long enables = 0;
 	int i = 0, ret = 0;
 
@@ -497,7 +533,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		goto err;
 	}
 
-	new_limits = kzalloc_objs(int, RDMACG_RESOURCE_MAX);
+	new_limits = kcalloc(RDMACG_RESOURCE_MAX, sizeof(s64), GFP_KERNEL);
 	if (!new_limits) {
 		ret = -ENOMEM;
 		goto err;
@@ -506,7 +542,8 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	/* parse resource limit tokens */
 	while ((p = strsep(&options, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
-		int tok, intval;
+		int tok;
+		s64 intval;
 
 		if (!*p)
 			continue;
@@ -514,7 +551,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		tok = match_token(p, rdmacg_limit_tokens, args);
 		switch (tok) {
 		case RDMACG_HCA_HANDLE_VAL:
-			if (match_int(&args[0], &intval) || intval < 0) {
+			if (match_s64(&args[0], &intval)) {
 				ret = -EINVAL;
 				goto parse_err;
 			}
@@ -522,11 +559,11 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			enables |= BIT(RDMACG_RESOURCE_HCA_HANDLE);
 			break;
 		case RDMACG_HCA_HANDLE_MAX:
-			new_limits[RDMACG_RESOURCE_HCA_HANDLE] = S32_MAX;
+			new_limits[RDMACG_RESOURCE_HCA_HANDLE] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_HCA_HANDLE);
 			break;
 		case RDMACG_HCA_OBJECT_VAL:
-			if (match_int(&args[0], &intval) || intval < 0) {
+			if (match_s64(&args[0], &intval)) {
 				ret = -EINVAL;
 				goto parse_err;
 			}
@@ -534,7 +571,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
 			break;
 		case RDMACG_HCA_OBJECT_MAX:
-			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S32_MAX;
+			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
 			break;
 		default:
@@ -588,7 +625,7 @@ static void print_rpool_values(struct seq_file *sf,
 {
 	enum rdmacg_file_type sf_type;
 	int i;
-	u32 value;
+	s64 value;
 
 	sf_type = seq_cft(sf)->private;
 
@@ -599,7 +636,7 @@ static void print_rpool_values(struct seq_file *sf,
 			if (rpool)
 				value = rpool->resources[i].max;
 			else
-				value = S32_MAX;
+				value = S64_MAX;
 		} else if (sf_type == RDMACG_RESOURCE_TYPE_PEAK) {
 			value = rpool ? rpool->resources[i].peak : 0;
 		} else {
@@ -609,10 +646,10 @@ static void print_rpool_values(struct seq_file *sf,
 				value = 0;
 		}
 
-		if (value == S32_MAX)
+		if (value == S64_MAX)
 			seq_puts(sf, RDMACG_MAX_STR);
 		else
-			seq_printf(sf, "%d", value);
+			seq_printf(sf, "%lld", value);
 		seq_putc(sf, ' ');
 	}
 }
-- 
2.43.0



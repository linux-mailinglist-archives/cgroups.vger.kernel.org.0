Return-Path: <cgroups+bounces-16417-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKdRCOVYGWqtvggAu9opvQ
	(envelope-from <cgroups+bounces-16417-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:14:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B045FFC0D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DAF3030136
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E123BAD91;
	Fri, 29 May 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hyHbZm8K"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0552C15A5
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045676; cv=none; b=GcPYrSKmThKY4vUHKmyct5dYtg60oJdVYzk2XSY4mAS6aR1bRY5xjN9/7XkxeY7LaBEQwfllftJdUq/zy6sQH26vfwIbuJYFtA6urKJeF4oBHXt+tUwqSO/V+wbDjAOCpAasvpX16qcyhrZqHWwP20LWiVcVNnE2jfVCYhXRzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045676; c=relaxed/simple;
	bh=axEVZMbsiHTE4KPn7RuiYy/eEjD6fx9Zgyg5C7toK1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHAc+AHD5hTnw8s7Q3vGL6OJjRYoGDRUAFGS85fNL9AWU88tGAwlqDXCf5ONSjZRtECDgxSCWi4OZ43+jkk4bMRWVg3uqH5/LUutRAIVJW+AvxWVTyYtpd+yUPO7tYUj36mYH8/wmURUFUlj23W8luYutiZam78NGopyvYbPCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hyHbZm8K; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780045672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WG4KWOecZHcKNPF6MwtBE0vsPSut84cf4upgw7N0hHA=;
	b=hyHbZm8Kiq201BSDIO7h4yjOAP4nzR0pCdffaEZwKoG2ERRNEngimWZrBObvB6wrV/CDrL
	fH7joyd9ZA/NyhnlxIh5mtTVQQ/jTt7iXHejM22F/IMjSSdUSB3TsFHkyCCKU9Z8p7YrcY
	eeVWVYeXsv1V+8DVR69FsPdsdgzSAlU=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2 1/3] cgroup/rdma: extend charge/uncharge API with s64 amount parameter
Date: Fri, 29 May 2026 17:07:31 +0800
Message-ID: <20260529090733.2242822-2-cui.tao@linux.dev>
In-Reply-To: <20260529090733.2242822-1-cui.tao@linux.dev>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16417-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 75B045FFC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Cui <cuitao@kylinos.cn>

Change struct rdmacg_resource fields (max, usage, peak) and all
charge/uncharge function signatures from int to s64 to prepare for
byte-sized resource tracking such as MR memory.

Replace match_int with a match_s64 helper that uses kstrtoll so the
user-space limit tokens accept 64-bit values.  All existing callers
pass amount=1 (count-based), so the change is transparent for
existing count-based resources.

The rpool->usage_sum counter continues to track the number of active
charge operations (not the sum of charged amounts); this is correct
because it governs rpool lifetime - a pool is releasable only when
all charges, regardless of amount, have been released.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/cgroup.c     | 10 ++--
 drivers/infiniband/core/core_priv.h  | 12 ++--
 drivers/infiniband/core/rdma_core.c  |  8 +--
 drivers/infiniband/core/uverbs_cmd.c |  4 +-
 include/linux/cgroup_rdma.h          |  7 ++-
 kernel/cgroup/rdma.c                 | 87 ++++++++++++++++++----------
 6 files changed, 83 insertions(+), 45 deletions(-)

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
index a2c36666e6fc..345356d1e504 100644
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
+			 s64 amount);
 #else
 static inline void ib_device_register_rdmacg(struct ib_device *device)
 {
@@ -175,14 +177,16 @@ static inline void ib_device_unregister_rdmacg(struct ib_device *device)
 
 static inline int ib_rdmacg_try_charge(struct ib_rdmacg_object *cg_obj,
 				       struct ib_device *device,
-				       enum rdmacg_resource_type resource_index)
+				       enum rdmacg_resource_type resource_index,
+			       s64 amount)
 {
 	return 0;
 }
 
 static inline void ib_rdmacg_uncharge(struct ib_rdmacg_object *cg_obj,
 				      struct ib_device *device,
-				      enum rdmacg_resource_type resource_index)
+				      enum rdmacg_resource_type resource_index,
+			      s64 amount)
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
index 5e82a03b3270..519f7f537223 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -59,9 +59,9 @@ static char const *rdmacg_resource_names[] = {
 
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
@@ -105,13 +105,13 @@ static inline struct rdma_cgroup *get_current_rdmacg(void)
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
@@ -122,7 +122,7 @@ static void set_all_resource_max_limit(struct rdmacg_resource_pool *rpool)
 	int i;
 
 	for (i = 0; i < RDMACG_RESOURCE_MAX; i++)
-		set_resource_limit(rpool, i, S32_MAX);
+		set_resource_limit(rpool, i, S64_MAX);
 }
 
 static void free_cg_rpool_locked(struct rdmacg_resource_pool *rpool)
@@ -206,7 +206,8 @@ get_cg_rpool_locked(struct rdma_cgroup *cg, struct rdmacg_device *device)
 static void
 uncharge_cg_locked(struct rdma_cgroup *cg,
 		   struct rdmacg_device *device,
-		   enum rdmacg_resource_type index)
+		   enum rdmacg_resource_type index,
+		   s64 amount)
 {
 	struct rdmacg_resource_pool *rpool;
 
@@ -222,7 +223,7 @@ uncharge_cg_locked(struct rdma_cgroup *cg,
 		return;
 	}
 
-	rpool->resources[index].usage--;
+	rpool->resources[index].usage -= amount;
 
 	/*
 	 * A negative count (or overflow) is invalid,
@@ -307,14 +308,15 @@ static void rdmacg_event_locked(struct rdma_cgroup *cg,
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
 
@@ -329,12 +331,13 @@ static void rdmacg_uncharge_hierarchy(struct rdma_cgroup *cg,
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
 
@@ -343,6 +346,7 @@ EXPORT_SYMBOL(rdmacg_uncharge);
  * @rdmacg: pointer to rdma cgroup which will own this resource
  * @device: pointer to rdmacg device
  * @index: index of the resource to charge in cgroup (resource pool)
+ * @amount: amount to charge
  *
  * This function follows charging resource in hierarchical way.
  * It will fail if the charge would cause the new value to exceed the
@@ -361,7 +365,8 @@ EXPORT_SYMBOL(rdmacg_uncharge);
  */
 int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 		      struct rdmacg_device *device,
-		      enum rdmacg_resource_type index)
+		      enum rdmacg_resource_type index,
+		      s64 amount)
 {
 	struct rdma_cgroup *cg, *p;
 	struct rdmacg_resource_pool *rpool;
@@ -371,6 +376,9 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 	if (index >= RDMACG_RESOURCE_MAX)
 		return -EINVAL;
 
+	if (amount <= 0)
+		return -EINVAL;
+
 	/*
 	 * hold on to css, as cgroup can be removed but resource
 	 * accounting happens on css.
@@ -384,8 +392,9 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
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
@@ -409,7 +418,7 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 	if (ret == -EAGAIN)
 		rdmacg_event_locked(cg, p, device, index);
 	mutex_unlock(&rdmacg_mutex);
-	rdmacg_uncharge_hierarchy(cg, device, p, index);
+	rdmacg_uncharge_hierarchy(cg, device, p, index, amount);
 	return ret;
 }
 EXPORT_SYMBOL(rdmacg_try_charge);
@@ -477,6 +486,25 @@ static struct rdmacg_device *rdmacg_get_device_locked(const char *name)
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
@@ -486,7 +514,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	struct rdmacg_device *device;
 	char *options = strstrip(buf);
 	char *p;
-	int *new_limits;
+	s64 *new_limits;
 	unsigned long enables = 0;
 	int i = 0, ret = 0;
 
@@ -497,7 +525,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		goto err;
 	}
 
-	new_limits = kzalloc_objs(int, RDMACG_RESOURCE_MAX);
+	new_limits = kcalloc(RDMACG_RESOURCE_MAX, sizeof(s64), GFP_KERNEL);
 	if (!new_limits) {
 		ret = -ENOMEM;
 		goto err;
@@ -506,7 +534,8 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 	/* parse resource limit tokens */
 	while ((p = strsep(&options, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
-		int tok, intval;
+		int tok;
+		s64 intval;
 
 		if (!*p)
 			continue;
@@ -514,7 +543,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 		tok = match_token(p, rdmacg_limit_tokens, args);
 		switch (tok) {
 		case RDMACG_HCA_HANDLE_VAL:
-			if (match_int(&args[0], &intval) || intval < 0) {
+			if (match_s64(&args[0], &intval)) {
 				ret = -EINVAL;
 				goto parse_err;
 			}
@@ -522,11 +551,11 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
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
@@ -534,7 +563,7 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
 			break;
 		case RDMACG_HCA_OBJECT_MAX:
-			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S32_MAX;
+			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
 			break;
 		default:
@@ -588,7 +617,7 @@ static void print_rpool_values(struct seq_file *sf,
 {
 	enum rdmacg_file_type sf_type;
 	int i;
-	u32 value;
+	s64 value;
 
 	sf_type = seq_cft(sf)->private;
 
@@ -599,7 +628,7 @@ static void print_rpool_values(struct seq_file *sf,
 			if (rpool)
 				value = rpool->resources[i].max;
 			else
-				value = S32_MAX;
+				value = S64_MAX;
 		} else if (sf_type == RDMACG_RESOURCE_TYPE_PEAK) {
 			value = rpool ? rpool->resources[i].peak : 0;
 		} else {
@@ -609,10 +638,10 @@ static void print_rpool_values(struct seq_file *sf,
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



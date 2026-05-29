Return-Path: <cgroups+bounces-16418-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEczIlBYGWqtvggAu9opvQ
	(envelope-from <cgroups+bounces-16418-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:11:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CBA5FFBBE
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 719303037F0B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A4B3BAD91;
	Fri, 29 May 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TD8i6pYS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B02C15A5
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045678; cv=none; b=X10Zi2nRr6bArDf1UEkp10hzoLv9Cxo4t6ik374zuY9ztUgFQ2o7TyNAQxeqDe3dmMj0cKyf6EfQzPooiFKTtBZHWma3VJHk2vY4Q/3s75lHN4OIx0uz0h2caWbBEgOCaymJkZQIrHfdVCvU/4ZsPctw5HVOY2KWTvq7n1PHh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045678; c=relaxed/simple;
	bh=dkCrgpJnlnWf2WN0cTxE1K0BrMULA5W/MwxV9RW3J1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXcBNSSyhnBlEZpmBYGQdDcOOM6c4odMaaYGaXgs8lYK026kMD+X6sl2xWH4YnpT/oMGs88N0qmvoKR1/pRcMi8rqdu/Jg0n2W/LxqEu9SsuwjqdnY/nFRxWW3+UdBFxmM0qEyO7paXwJ8MRty4CeUBOH8JrI7CUGO8ZpGo1XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TD8i6pYS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780045675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5YyWrf6e+90glcrhkoF012jWRw1XB35M4C2faNsiGM=;
	b=TD8i6pYSBV6Ho5/RufxnSjAlgNpXeihTZlIZRNw2qBR+wyRKx/9rjPmecIj96jIyZW1/ST
	9vzyDPHMvwd4z2sROlaXHR2v60RL+/Zvig92jOJje04i7tx+hgpQmIr89JiDmWTmlmDJo+
	IIG03oEVheQtcA2vcAHNC/lTgED0IX8=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	cgroups@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2 2/3] cgroup/rdma: add MR memory size resource tracking
Date: Fri, 29 May 2026 17:07:32 +0800
Message-ID: <20260529090733.2242822-3-cui.tao@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16418-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: D3CBA5FFBBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tao Cui <cuitao@kylinos.cn>

Add RDMACG_RESOURCE_MR_MEM so that the cumulative memory size of
registered Memory Regions can be tracked and limited independently
from the aggregate hca_object counter.

Unlike count-based resources (hca_handle, hca_object) which are
charged in the generic IDR allocation path, MR_MEM is byte-based
and must be charged after the MR length is known.  Charge in the
uverbs MR registration handlers (ioctl and legacy), and uncharge
in the generic destroy paths (alloc_abort_idr_uobject,
destroy_hw_idr_uobject).

Store the charged byte count in uobj->rdmacg_mr_mem_bytes so that
the destroy path knows how much to uncharge.

Semantic notes
~~~~~~~~~~~~~~

mr_mem is not page-level ownership tracking - it is object-based
accounting tied to the MR lifetime:

  - charged at MR registration time
  - uncharged at MR destruction time
  - the charge lives with the MR's creating cgroup for the entire
    lifetime of the MR object

This model intentionally defines accounting semantics around MR
object lifetime rather than page ownership:

1. fork(): fork() does not duplicate MR objects.  Even though the
   child inherits the uverbs fd and can access the parent's ucontext,
   the MR remains a single kernel object.  The charge is tied to the
   MR object, not to the number of processes that can reach it, so
   no splitting or re-accounting is needed.

2. Cgroup migration: mr_mem follows the same semantics as the existing
   hca_object - charge at creation time against the invoking task's
   cgroup, uncharge at destruction time.  The RDMA cgroup does not
   implement can_attach/attach callbacks today, so charges do not
   migrate with the task.  This is a known limitation that applies
   equally to hca_handle and hca_object.  mr_mem does not introduce
   any new complication here.

3. Overlap with memory cgroup: mr_mem does not count process memory
   usage - it represents a per-device DMA registration budget: how
   much memory can this cgroup register through a given HCA.  This is
   a different dimension from what memory cgroup tracks.  An
   administrator might set mr_mem limits differently per device, which
   memory cgroup cannot express.

   In particular, mr_mem tracks the registered memory range associated
   with the MR rather than exact dynamically pinned pages (e.g. for
   ODP MRs).  This is a stable, policy-oriented approximation of
   registration footprint - not an attempt at precise physical page
   accounting.

Guard against u64-to-s64 overflow by rejecting MR lengths that
exceed S64_MAX at each registration site.

Handle MR reregistration (IB_USER_VERBS_CMD_REREG_MR with
IB_MR_REREG_TRANS) by computing the delta between old and new
lengths and charging or uncharging the difference.  When the driver
creates a new HW object (new_mr != NULL), the full new length is
charged to the new uobj and the old uobj's mr_mem is released
through the existing rdma_assign_uobject -> destroy_hw_idr_uobject
-> rdmacg_uncharge_uobj path.

Enable MR memory limits:

  echo "mlx5_0 mr_mem=1073741824" > rdma.max

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/rdma_core.c           | 14 ++++-
 drivers/infiniband/core/uverbs_cmd.c          | 57 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_mr.c | 37 ++++++++++++
 include/linux/cgroup_rdma.h                   |  1 +
 include/rdma/ib_verbs.h                       |  1 +
 kernel/cgroup/rdma.c                          | 21 ++++++-
 6 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 3268285b5478..a540cef6bb67 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -523,10 +523,19 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 	return ret;
 }
 
-static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
+static void rdmacg_uncharge_uobj(struct ib_uobject *uobj)
 {
 	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
 			   RDMACG_RESOURCE_HCA_OBJECT, 1);
+	if (uobj->rdmacg_mr_mem_bytes)
+		ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
+				   RDMACG_RESOURCE_MR_MEM,
+				   uobj->rdmacg_mr_mem_bytes);
+}
+
+static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
+{
+	rdmacg_uncharge_uobj(uobj);
 
 	xa_erase(&uobj->ufile->idr, uobj->id);
 }
@@ -546,8 +555,7 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 	if (why == RDMA_REMOVE_ABORT)
 		return 0;
 
-	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
-			   RDMACG_RESOURCE_HCA_OBJECT, 1);
+	rdmacg_uncharge_uobj(uobj);
 
 	return 0;
 }
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 9540ac180711..901de117c808 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -752,6 +752,17 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	uobj->object = mr;
 	uobj_put_obj_read(pd);
+
+	if (cmd.length > S64_MAX)
+		goto err_free;
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
@@ -759,6 +770,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	resp.mr_handle = uobj->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_dereg:
+	ib_dereg_mr_user(mr, &attrs->driver_udata);
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
@@ -854,6 +867,20 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 		rdma_restrack_set_name(&new_mr->res, NULL);
 		rdma_restrack_add(&new_mr->res);
 
+		if ((cmd.flags & IB_MR_REREG_TRANS) && cmd.length) {
+			if (cmd.length > S64_MAX) {
+				ret = -EINVAL;
+				goto err_rereg_new_mr;
+			}
+			ret = ib_rdmacg_try_charge(&new_uobj->cg_obj,
+						   new_uobj->context->device,
+						   RDMACG_RESOURCE_MR_MEM,
+						   cmd.length);
+			if (ret)
+				goto err_rereg_new_mr;
+			new_uobj->rdmacg_mr_mem_bytes = cmd.length;
+		}
+
 		/*
 		 * The new uobj for the new HW object is put into the same spot
 		 * in the IDR and the old uobj & HW object is deleted.
@@ -871,6 +898,31 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 			atomic_inc(&new_pd->usecnt);
 		}
 		if (cmd.flags & IB_MR_REREG_TRANS) {
+			s64 delta;
+
+			if (cmd.length > S64_MAX) {
+				ret = -EINVAL;
+				goto put_new_uobj;
+			}
+			delta = (s64)cmd.length -
+				(s64)uobj->rdmacg_mr_mem_bytes;
+
+			if (delta > 0) {
+				ret = ib_rdmacg_try_charge(
+					&uobj->cg_obj,
+					uobj->context->device,
+					RDMACG_RESOURCE_MR_MEM,
+					delta);
+				if (ret)
+					goto put_new_uobj;
+			} else if (delta < 0) {
+				ib_rdmacg_uncharge(
+					&uobj->cg_obj,
+					uobj->context->device,
+					RDMACG_RESOURCE_MR_MEM,
+					-delta);
+			}
+			uobj->rdmacg_mr_mem_bytes = cmd.length;
 			mr->iova = cmd.hca_va;
 			mr->length = cmd.length;
 		}
@@ -887,6 +939,11 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 put_new_uobj:
 	if (new_uobj)
 		uobj_alloc_abort(new_uobj, attrs);
+err_rereg_new_mr:
+	if (new_uobj) {
+		rdma_alloc_abort_uobject(new_uobj, attrs, true);
+		new_uobj = NULL;
+	}
 put_uobj_pd:
 	if (cmd.flags & IB_MR_REREG_PD)
 		uobj_put_obj_read(new_pd);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 570b9656801d..3989ff2d282b 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -32,6 +32,7 @@
  */
 
 #include "rdma_core.h"
+#include "core_priv.h"
 #include "uverbs.h"
 #include <rdma/uverbs_std_types.h>
 #include "restrack.h"
@@ -140,6 +141,18 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	rdma_restrack_set_name(&mr->res, NULL);
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
+	if (attr.length > S64_MAX)
+		return -EINVAL;
+
+	if (attr.length) {
+		ret = ib_rdmacg_try_charge(&uobj->cg_obj, uobj->context->device,
+					   RDMACG_RESOURCE_MR_MEM, attr.length);
+		if (ret) {
+			ib_dereg_mr_user(mr, &attrs->driver_udata);
+			return ret;
+		}
+		uobj->rdmacg_mr_mem_bytes = attr.length;
+	}
 
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DM_MR_HANDLE);
 
@@ -254,6 +267,18 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
+	if (length > S64_MAX)
+		return -EINVAL;
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
@@ -383,6 +408,18 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
+	if (length > S64_MAX)
+		return -EINVAL;
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
index 7146cefa95a6..2c8fb1ebb1a9 100644
--- a/include/linux/cgroup_rdma.h
+++ b/include/linux/cgroup_rdma.h
@@ -12,6 +12,7 @@
 enum rdmacg_resource_type {
 	RDMACG_RESOURCE_HCA_HANDLE,
 	RDMACG_RESOURCE_HCA_OBJECT,
+	RDMACG_RESOURCE_MR_MEM,
 	RDMACG_RESOURCE_MAX,
 };
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..c7dcd5d085fb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1569,6 +1569,7 @@ struct ib_uobject {
 	void		       *object;		/* containing object */
 	struct list_head	list;		/* link to context's list */
 	struct ib_rdmacg_object	cg_obj;		/* rdmacg object */
+	s64			rdmacg_mr_mem_bytes; /* charged MR memory size */
 	int			id;		/* index into kernel idr */
 	struct kref		ref;
 	atomic_t		usecnt;		/* protects exclusive access */
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 519f7f537223..ebfc5721c098 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -23,14 +23,18 @@ enum rdmacg_limit_tokens {
 	RDMACG_HCA_HANDLE_MAX,
 	RDMACG_HCA_OBJECT_VAL,
 	RDMACG_HCA_OBJECT_MAX,
+	RDMACG_MR_MEM_VAL,
+	RDMACG_MR_MEM_MAX,
 	NR_RDMACG_LIMIT_TOKENS,
 };
 
 static const match_table_t rdmacg_limit_tokens = {
-	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"	},
+	{ RDMACG_HCA_HANDLE_VAL,	"hca_handle=%d"		},
 	{ RDMACG_HCA_HANDLE_MAX,	"hca_handle=max"	},
-	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"	},
+	{ RDMACG_HCA_OBJECT_VAL,	"hca_object=%d"		},
 	{ RDMACG_HCA_OBJECT_MAX,	"hca_object=max"	},
+	{ RDMACG_MR_MEM_VAL,		"mr_mem=%d"		},
+	{ RDMACG_MR_MEM_MAX,		"mr_mem=max"		},
 	{ NR_RDMACG_LIMIT_TOKENS,	NULL			},
 };
 
@@ -55,6 +59,7 @@ enum rdmacg_file_type {
 static char const *rdmacg_resource_names[] = {
 	[RDMACG_RESOURCE_HCA_HANDLE]	= "hca_handle",
 	[RDMACG_RESOURCE_HCA_OBJECT]	= "hca_object",
+	[RDMACG_RESOURCE_MR_MEM]	= "mr_mem",
 };
 
 /* resource tracker for each resource of rdma cgroup */
@@ -566,6 +571,18 @@ static ssize_t rdmacg_resource_set_max(struct kernfs_open_file *of,
 			new_limits[RDMACG_RESOURCE_HCA_OBJECT] = S64_MAX;
 			enables |= BIT(RDMACG_RESOURCE_HCA_OBJECT);
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



Return-Path: <cgroups+bounces-15826-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ+TAvjjAmqqyQEAu9opvQ
	(envelope-from <cgroups+bounces-15826-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:25:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFB51CA69
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5906300BC5D
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C104963B3;
	Tue, 12 May 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDOYZuyX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D9492186;
	Tue, 12 May 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574296; cv=none; b=D1B2GUbjiiouyUR4vD9uDuEtwaGxrLkPKR94qNOqqvn0QE17Q0Qi6iuM84ctcIHTrBT4LLNbyKhaHPmlDIk7khOdXk1+pYokzK2iyH/Eoxo7A0U+WXtV/jq7JV2ZJFc6cxik6jtFh4pPE/e+2lgZ+A5V/yiq1xMptuOjhklFuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574296; c=relaxed/simple;
	bh=AnH/mVVa2xK7leWlYyfjVYavN2/phG52biw4GAsQXZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rp+yTPnf1RzdPxpXDFZNrbF6TayBfhqBQUyqaZDBNzkeCiw5sHnpzGCjsN3HMdIzbhz47zDkILp92ib9ls51aBB+XJaLf3MLmltgE3xAghVwhFp/p6bpuRDHpfUi/xIXceXytlzN+gVG4stM6dbHCAEFY23DO+2687H9+FZKF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDOYZuyX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778574292; x=1810110292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AnH/mVVa2xK7leWlYyfjVYavN2/phG52biw4GAsQXZQ=;
  b=hDOYZuyXUfCP8qFRKjd1nis+EYukALtzsMm86vsNMOWucjBknvXYxLcX
   M2r2G2pbx6dardl/Rm1MkJ1XjLSFYbrbxc9Py/CIXIMGu+7e9KWr+9mLK
   a/8PmfvrFoFJjj5GlSeU08s2d0EE9AlYJw/ew2JBBylaj7OuG5RHECEku
   DBH+bRuuVn1YwcqJ0lIoGbpIULSBfmtyB6m/QRthEgW2KEXa9QJh0oQJr
   GSAsKP4wsd7XypcobAnmS+10mg+lPKQb3ip2ygpq+13z2hoSjDo5C+JEZ
   ufht86ifgDbafeOLACvrbeHhE7+U+EGDU2Jciq+4/PR+nK0gTY2LZyIeg
   w==;
X-CSE-ConnectionGUID: OO2rc78xSq68/7VdUH+Byw==
X-CSE-MsgGUID: IyqMpEYYSy2gXRC3NBk73Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79194999"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79194999"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:24:45 -0700
X-CSE-ConnectionGUID: 5OdkQmJPTNugDJ1AaBcTPA==
X-CSE-MsgGUID: 299F1ARsQGS15SepHGyrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237945566"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.172])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:24:39 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem controller
Date: Tue, 12 May 2026 10:24:04 +0200
Message-ID: <20260512082406.44470-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512082406.44470-1-thomas.hellstrom@linux.intel.com>
References: <20260512082406.44470-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00BFB51CA69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15826-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Action: no action

Add ttm_bo_evict_cgroup() to evict buffer objects charged to a specific
dmem cgroup pool from a resource manager's LRU until a byte target is
met.  Add ttm_resource_manager_set_dmem_region() to register the TTM
eviction path as the reclaim callback for a dmem cgroup region.

The eviction context is interruptible; signals abort the operation and
propagate back through the write() syscall.

Introduce a new mode for the bo LRU walker so that sleeping locks
can be taken. This can be used when the caller doesn't hold any
previous dma_resv locks, and where it intends to hold at most
one lock at a time.

Like the rest of the TTM eviction this should sooner than later
be converted to full WW transactions.

v3:
- Fix ttm_resource_manager_set_dmem_region() storing an error pointer
  in man->cg unconditionally. (Sashiko-bot)
- Fix kernel-doc function name format for ttm_bo_evict_cgroup() and
  ttm_resource_manager_set_dmem_region().

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 95 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c  |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c | 37 ++++++++++++
 include/drm/ttm/ttm_bo.h           | 10 ++++
 include/drm/ttm/ttm_resource.h     |  4 ++
 5 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 293401705542..3d0872f2f14d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -515,12 +515,20 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 {
 	struct ttm_bo_evict_walk *evict_walk =
 		container_of(walk, typeof(*evict_walk), walk);
+	/* Capture size before eviction in case res is cleared. */
+	s64 bo_size = bo->base.size;
 	s64 lret;
 
 	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resource->css,
 					      evict_walk->try_low, &evict_walk->hit_low))
 		return 0;
 
+	/*
+	 * evict_walk->place is NULL in cgroup drain mode.  Drivers'
+	 * eviction_valuable() callbacks must handle a NULL place, treating it
+	 * as "any placement": the TTM base implementation already does so via
+	 * ttm_resource_intersects().
+	 */
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
 		return 0;
 
@@ -536,11 +544,15 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 		goto out;
 
 	evict_walk->evicted++;
-	if (evict_walk->res)
+	if (evict_walk->res) {
 		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
 					  evict_walk->res, NULL);
-	if (lret == 0)
-		return 1;
+		if (lret == 0)
+			return 1;
+	} else {
+		/* Cgroup drain: return bytes freed for byte-denominated progress. */
+		return bo_size;
+	}
 out:
 	/* Errors that should terminate the walk. */
 	if (lret == -ENOSPC)
@@ -614,6 +626,83 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	return 0;
 }
 
+/**
+ * ttm_bo_evict_cgroup() - Evict buffer objects charged to a specific cgroup.
+ * @bdev: The TTM device.
+ * @man: The resource manager whose LRU to walk.
+ * @limit_pool: The cgroup pool state whose members should be evicted.
+ * @target_bytes: Number of bytes to free.
+ * @ctx: The TTM operation context.
+ *
+ * Walk the LRU of @man and evict buffer objects that are charged to the
+ * cgroup identified by @limit_pool, until at least @target_bytes have been
+ * freed.  Mirrors the two-pass (trylock -> sleeping-lock, low-watermark)
+ * strategy used by ttm_bo_evict_alloc().
+ *
+ * Return: >= @target_bytes on full success, 0..target_bytes-1 if partial,
+ *         negative error code on fatal error.
+ */
+s64 ttm_bo_evict_cgroup(struct ttm_device *bdev,
+			struct ttm_resource_manager *man,
+			struct dmem_cgroup_pool_state *limit_pool,
+			s64 target_bytes,
+			struct ttm_operation_ctx *ctx)
+{
+	struct ttm_bo_evict_walk evict_walk = {
+		.walk = {
+			.ops = &ttm_evict_walk_ops,
+			.arg = { .ctx = ctx },
+		},
+		.limit_pool = limit_pool,
+		/* place, evictor, res left NULL: selects cgroup drain mode */
+	};
+	s64 lret, pass;
+
+	evict_walk.walk.arg.trylock_only = true;
+	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, target_bytes);
+	if (lret < 0 || lret >= target_bytes)
+		return lret;
+
+	/* Second pass: also evict BOs at the low watermark. */
+	if (evict_walk.hit_low) {
+		evict_walk.try_low = true;
+		pass = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man,
+					      target_bytes - lret);
+		if (pass < 0)
+			return pass;
+		lret += pass;
+		if (lret >= target_bytes)
+			return lret;
+	}
+
+	/* Full sleeping-lock pass for remaining target. */
+	evict_walk.try_low = evict_walk.hit_low = false;
+	evict_walk.walk.arg.trylock_only = false;
+
+retry:
+	evict_walk.walk.arg.sleeping_lock = true;
+	do {
+		evict_walk.evicted = 0;
+		pass = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man,
+					      target_bytes - lret);
+		if (pass < 0) {
+			lret = pass;
+			goto out;
+		}
+		lret += pass;
+	} while (lret < target_bytes && evict_walk.evicted);
+
+	/* One more attempt if we hit the low limit during sleeping-lock pass. */
+	if (lret < target_bytes && evict_walk.hit_low && !evict_walk.try_low) {
+		evict_walk.try_low = true;
+		goto retry;
+	}
+
+out:
+	return lret;
+}
+EXPORT_SYMBOL(ttm_bo_evict_cgroup);
+
 /**
  * ttm_bo_pin - Pin the buffer object.
  * @bo: The buffer object to pin
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f83b7d5ec6c6..81c6a674c462 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -999,7 +999,8 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 		bo = res->bo;
 		if (ttm_lru_walk_trylock(curs, bo))
 			bo_locked = true;
-		else if (!arg->ticket || arg->ctx->no_wait_gpu || arg->trylock_only)
+		else if ((!arg->ticket && !arg->sleeping_lock) || arg->ctx->no_wait_gpu ||
+			 arg->trylock_only)
 			continue;
 
 		if (!ttm_bo_get_unless_zero(bo)) {
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 0e5f1582f13d..6d24f3320892 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -950,3 +950,40 @@ void ttm_resource_manager_create_debugfs(struct ttm_resource_manager *man,
 #endif
 }
 EXPORT_SYMBOL(ttm_resource_manager_create_debugfs);
+
+static int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
+					     u64 target_bytes, void *priv)
+{
+	struct ttm_resource_manager *man = priv;
+	struct ttm_operation_ctx ctx = { .interruptible = true };
+	s64 freed;
+
+	freed = ttm_bo_evict_cgroup(man->bdev, man, pool, target_bytes, &ctx);
+	if (freed < 0)
+		return freed;
+
+	return freed >= (s64)target_bytes ? 0 : -ENOSPC;
+}
+
+/**
+ * ttm_resource_manager_set_dmem_region() - Associate a dmem cgroup region with a
+ *                                        resource manager and register a reclaim
+ *                                        callback.
+ * @man: The resource manager.
+ * @region: The dmem cgroup region to associate, may be NULL or IS_ERR().
+ *
+ * Sets @man->cg and registers ttm_resource_manager_dmem_reclaim() so that
+ * writing to dmem.max below current usage triggers TTM eviction rather than
+ * returning -EBUSY to userspace.
+ */
+void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
+					  struct dmem_cgroup_region *region)
+{
+	if (!IS_ERR_OR_NULL(region)) {
+		man->cg = region;
+		dmem_cgroup_region_set_reclaim(region,
+					       ttm_resource_manager_dmem_reclaim,
+					       man);
+	}
+}
+EXPORT_SYMBOL(ttm_resource_manager_set_dmem_region);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..32791c4db2a9 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -226,6 +226,11 @@ struct ttm_lru_walk_arg {
 	struct ww_acquire_ctx *ticket;
 	/** @trylock_only: Only use trylock for locking. */
 	bool trylock_only;
+	/**
+	 * @sleeping_lock: Use sleeping locks even with %NULL @ticket.
+	 * @trylock_only has precedence over this field.
+	 */
+	bool sleeping_lock;
 };
 
 /**
@@ -431,6 +436,11 @@ void ttm_bo_unpin(struct ttm_buffer_object *bo);
 int ttm_bo_evict_first(struct ttm_device *bdev,
 		       struct ttm_resource_manager *man,
 		       struct ttm_operation_ctx *ctx);
+s64 ttm_bo_evict_cgroup(struct ttm_device *bdev,
+			struct ttm_resource_manager *man,
+			struct dmem_cgroup_pool_state *limit_pool,
+			s64 target_bytes,
+			struct ttm_operation_ctx *ctx);
 int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
 		  void *buf, int len, int write);
 vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index a5d386583fb6..1ba3ae39763c 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -39,6 +39,7 @@
 
 struct dentry;
 struct dmem_cgroup_device;
+struct dmem_cgroup_region;
 struct drm_printer;
 struct ttm_device;
 struct ttm_resource_manager;
@@ -477,6 +478,9 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
 			       struct ttm_device *bdev,
 			       uint64_t size);
 
+void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
+					  struct dmem_cgroup_region *region);
+
 int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 				   struct ttm_resource_manager *man);
 
-- 
2.54.0



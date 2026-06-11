Return-Path: <cgroups+bounces-16870-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtqsIkHyKmprzwMAu9opvQ
	(envelope-from <cgroups+bounces-16870-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:37:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB456740B6
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="SC/GFcBP";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16870-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16870-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2D7B3061F0C
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08F4C0434;
	Thu, 11 Jun 2026 17:34:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CA4C0438;
	Thu, 11 Jun 2026 17:34:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199250; cv=none; b=C4BqxV3eKCnkp1z/QJP6HbHi3ZW3T9PKxMMTOrH4ba/3erXNNscLw8AiCWJZkrIX+ULx4+DEBBzdyKVcWHTK0Ts3sYHlTNLDL9LbKzzSdZ+4k/G29GZDA+hfhToidTz/T0rSQXKXOLFMU2TUPbOnRT8D4rpOtx/DvT7hcMBskwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199250; c=relaxed/simple;
	bh=ej3HAAXUlntHN0Gsczu1OOyQyT2RPb7RYHWcce/CQFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOXh+Ua86A27fhWv0WnLr6GV7XZXZh8y5Vzq4H854l7+Y0sg5KG1JwaHvH7eBiP0SRiz9luBLXxo2RHhXxK+pattmCT2IlGv71TTkmBIRx1MRLSCqQhJplF1+FX6Af1CgO9YUU54gDr9X3MWotaHlfk/C7g+MyQcSucteUyz3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC/GFcBP; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199245; x=1812735245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ej3HAAXUlntHN0Gsczu1OOyQyT2RPb7RYHWcce/CQFw=;
  b=SC/GFcBPfpCYYicr8DjEh9fdqGbwKT9eoucC4xzyzaoqNwpOv0pCxfGW
   ejFB/bSNIgjtWCMQp1/AcXgLbUAmQq7kAtZpHg/FYLx3n3gcQv+dNNi5r
   qItrIAgcpD5eVCXuGtehPh53LtWa2APee8DwDQk1a8q1KxZrA8JIjPsBh
   W1p9de3ajOSNNbboanzC5lKYm9NuPLXqzNQsa24JQL8uGkx+/1idrb6dJ
   0zvQPfHSrg4hIh0cip5RC0LycNt94bPu7Rpyn6S9gB/L9wKEMV6LJwW/P
   Iu+7k7ep8Go4Hrm6wpk7Pn7P5+XDHkH9hZo19lebhmy0tQB+OdMsHQfCq
   g==;
X-CSE-ConnectionGUID: v5Rv/903SZihLg54UGCn7w==
X-CSE-MsgGUID: YnNhkw6zTVWuexshvnI+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81762048"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81762048"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:55 -0700
X-CSE-ConnectionGUID: GtBm3ggnTJSBVNLnBAgQsA==
X-CSE-MsgGUID: y0sjZ2yxTRuh1Tvtl3M25Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="240214982"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:50 -0700
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
Subject: [PATCH v6 4/6] drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem controller
Date: Thu, 11 Jun 2026 19:32:59 +0200
Message-ID: <20260611173301.17473-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16870-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DB456740B6

Add ttm_bo_evict_cgroup() to evict buffer objects charged to a specific
dmem cgroup pool from a resource manager's LRU until a byte target is
met.  Add ttm_resource_manager_set_dmem_region() to associate a dmem
cgroup region with a resource manager; drivers supply their own
dmem_cgroup_ops with ttm_resource_manager_dmem_reclaim as the reclaim
function and the manager pointer as reclaim_priv in the dmem_cgroup_init
to wire up TTM eviction as the reclaim callback.

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

v5:
- Rebased on the introduction of struct dmem_cgroup_init.
- Handle NULL region in ttm_resource_manager_set_dmem_region() to clear
  the reclaim callback, preventing use-after-free when the manager is
  torn down while the dmem region outlives it. (Sashiko-bot)
- Return 0 on any progress (even partial eviction), -ENOSPC only when
  nothing was freed; fixes callers that expected 0 on partial success.
- Document that the reclaim callback should return 0 if some progress
  was made, -ENOSPC if no progress at all, or another error for fatal
  failures.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 95 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c  |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c | 50 ++++++++++++++++
 include/drm/ttm/ttm_bo.h           | 10 ++++
 include/drm/ttm/ttm_resource.h     |  7 +++
 5 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f0..db0e38bd8a43 100644
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
index 3e3c201a0222..bd0b23ac2cc4 100644
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
index 154d6739256f..ad00723e99ef 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -953,3 +953,53 @@ void ttm_resource_manager_create_debugfs(struct ttm_resource_manager *man,
 #endif
 }
 EXPORT_SYMBOL(ttm_resource_manager_create_debugfs);
+
+/**
+ * ttm_resource_manager_dmem_reclaim() - dmem cgroup reclaim callback for TTM
+ *                                       resource managers.
+ * @pool: The dmem cgroup pool state for the cgroup being reclaimed.
+ * @target_bytes: Number of bytes to try to free.
+ * @priv: The &ttm_resource_manager pointer, passed as @init.reclaim_priv to
+ *        dmem_cgroup_register_region().
+ *
+ * Drivers should use this as the @reclaim member of their own
+ * &struct dmem_cgroup_ops, with the &ttm_resource_manager pointer as
+ * @init.reclaim_priv.
+ *
+ * Return: 0 if some memory was freed, -ENOSPC if nothing was freed, or
+ *         another negative error code on fatal failure.
+ */
+int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
+				      u64 target_bytes, void *priv)
+{
+	struct ttm_resource_manager *man = priv;
+	struct ttm_operation_ctx ctx = { .interruptible = true };
+	s64 freed;
+
+	freed = ttm_bo_evict_cgroup(man->bdev, man, pool, target_bytes, &ctx);
+	if (freed < 0)
+		return freed;
+
+	return freed > 0 ? 0 : -ENOSPC;
+}
+EXPORT_SYMBOL(ttm_resource_manager_dmem_reclaim);
+
+/**
+ * ttm_resource_manager_set_dmem_region() - Associate a dmem cgroup region with a
+ *                                        resource manager.
+ * @man: The resource manager.
+ * @region: The dmem cgroup region to associate, may be NULL or IS_ERR().
+ *
+ * When @region is valid, stores it in @man->cg so that TTM can look up the
+ * associated pool during charging and eviction-target selection.
+ * The reclaim callback must be wired up using ttm_resource_manager_dmem_reclaim()
+ * in the driver's own &struct dmem_cgroup_ops, with the manager pointer as
+ * @init.reclaim_priv.
+ */
+void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
+					  struct dmem_cgroup_region *region)
+{
+	if (!IS_ERR_OR_NULL(region))
+		man->cg = region;
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
index a5d386583fb6..32e485fdce9a 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -39,6 +39,7 @@
 
 struct dentry;
 struct dmem_cgroup_device;
+struct dmem_cgroup_region;
 struct drm_printer;
 struct ttm_device;
 struct ttm_resource_manager;
@@ -477,6 +478,12 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
 			       struct ttm_device *bdev,
 			       uint64_t size);
 
+void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
+					  struct dmem_cgroup_region *region);
+
+int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
+				      u64 target_bytes, void *priv);
+
 int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 				   struct ttm_resource_manager *man);
 
-- 
2.54.0



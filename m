Return-Path: <cgroups+bounces-17469-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a7u6Be21R2qKdwAAu9opvQ
	(envelope-from <cgroups+bounces-17469-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:15:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F92702BC5
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:15:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cBXq14R4;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17469-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17469-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 287013001583
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD83D6CA5;
	Fri,  3 Jul 2026 13:06:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A93D6690;
	Fri,  3 Jul 2026 13:06:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084017; cv=none; b=Z/lAqvWz0Exf+n4//ztVnshjFswwnAFizkQb1FB1MAHYh7MEeyxaTBrwq34ZBXB9aDE1KKP1Sd8vF20cB4FPZNCqbyNjeB9Z+p26RCPr+HaWmNglY7keRha919MVYfpMYayqPbjlKo634QpvkjdDw34tSPd3FvtNTO0aB/1CWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084017; c=relaxed/simple;
	bh=FsvkI3LOasYuprXDVfPJVH1qnNqYfZwMGOjwjiJ3aL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtwCSWy6M33ge6tFi39H+d66CXhMQyvnZFd4QfLBLnvZcvlvS29efFg4Fsq0gDfRI1uLNvxCmLF358Z0JhzGmASDSTvZbGVah7gVzLruPJA/kigAhk/ePvIbIw+7oL1tnxqc6vXIdsYOKYQE6WnOafdf6HYQjjvnsqnHVLQEnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBXq14R4; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084016; x=1814620016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsvkI3LOasYuprXDVfPJVH1qnNqYfZwMGOjwjiJ3aL0=;
  b=cBXq14R4ww2dyAd5TLmfXm/I4folcEikME6sdCnkGO0teG6CkKYMyErl
   /LVwDIQA7Ck5yWtJapNSpVFMLgMBH0P+mDP50qpQPbmv8wVYa41AwCnvQ
   w+m5LN8s2sfLGc4iGxA/FQ4Rt1Fgyj1Zzqabze5oWFnM50UFJmq1Nj+7+
   /lBNsbsJSveky6NOUALVqx9re4T0ZJW8UUwM7Our5d/+vfyLuUcB1ZhzK
   U/SjwsRYWmzLG9tjT/mbYk5HRkyzGGtM8GpK7spyuUCD0RwAMlTecdwnP
   qxDHKJn5KHQH7OgL2ZG+MF6ZPdUeIgIvgLAoZ1Db2889+B4mkjm2StEvX
   A==;
X-CSE-ConnectionGUID: I8QjDx8kTvOyZi5KOru5Ug==
X-CSE-MsgGUID: zINUGqhERoiye+SfKsF9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83702347"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83702347"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:56 -0700
X-CSE-ConnectionGUID: Vgujm9BnQfaZi3fIOqergQ==
X-CSE-MsgGUID: QlJnEeKOSzq+JFbiqdzC8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283199598"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:51 -0700
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
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] drm/xe: Wire up dmem cgroup reclaim for VRAM manager
Date: Fri,  3 Jul 2026 15:05:40 +0200
Message-ID: <20260703130541.2686-6-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17469-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:cascardo@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,igalia.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06F92702BC5

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

v4:
- Rebased on drm-tip; dropped the XE_PL_STOLEN guard as stolen memory
  uses a separate TTM manager and never calls __xe_ttm_vram_mgr_init().

v5:
- Rebased on the introduction of struct dmem_cgroup_init.
- Register the fini drmm action before drmm_cgroup_register_region() so
  that devres LIFO teardown runs unregister_region() first (draining any
  in-flight reclaim callbacks via the rwsem) and xe_ttm_vram_mgr_fini()
  second, ensuring the manager is never accessed by a reclaim callback
  after teardown. (Sashiko-bot)
- Wrap the reclaim callback in xe_ttm_vram_mgr_dmem_reclaim() using
  drm_dev_enter()/drm_dev_exit() to prevent TTM reclaim from running
  after driver unbind.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 54 +++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 308fda4248eb..b2500344cd57 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -276,6 +276,28 @@ static const struct ttm_resource_manager_func xe_ttm_vram_mgr_func = {
 	.debug	= xe_ttm_vram_mgr_debug
 };
 
+static const struct dmem_cgroup_ops xe_ttm_vram_mgr_dmem_ops;
+
+static int xe_ttm_vram_mgr_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
+					 u64 target_bytes, void *priv)
+{
+	struct ttm_resource_manager *man = priv;
+	struct xe_device *xe = ttm_to_xe_device(man->bdev);
+	int ret, idx;
+
+	if (!drm_dev_enter(&xe->drm, &idx))
+		return -ENODEV;
+
+	ret = ttm_resource_manager_dmem_reclaim(pool, target_bytes, priv);
+
+	drm_dev_exit(idx);
+	return ret;
+}
+
+static const struct dmem_cgroup_ops xe_ttm_vram_mgr_dmem_ops = {
+	.reclaim = xe_ttm_vram_mgr_dmem_reclaim,
+};
+
 static void xe_ttm_vram_mgr_fini(struct drm_device *dev, void *arg)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -301,17 +323,10 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 			   u64 default_page_size)
 {
 	struct ttm_resource_manager *man = &mgr->manager;
+	struct dmem_cgroup_region *cg;
 	const char *name;
 	int err;
 
-	name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
-	man->cg = drmm_cgroup_register_region(&xe->drm, name,
-					      &(struct dmem_cgroup_init){
-						.size = size,
-					      });
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
-
 	man->func = &xe_ttm_vram_mgr_func;
 	mgr->mem_type = mem_type;
 	err = drmm_mutex_init(&xe->drm, &mgr->lock);
@@ -330,7 +345,28 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	ttm_set_driver_manager(&xe->ttm, mem_type, &mgr->manager);
 	ttm_resource_manager_set_used(&mgr->manager, true);
 
-	return drmm_add_action_or_reset(&xe->drm, xe_ttm_vram_mgr_fini, mgr);
+	/*
+	 * Register the fini action before the cgroup region so that devres
+	 * LIFO teardown runs unregister_region first (draining any in-flight
+	 * reclaim callbacks) and the manager fini second.
+	 */
+	err = drmm_add_action_or_reset(&xe->drm, xe_ttm_vram_mgr_fini, mgr);
+	if (err)
+		return err;
+
+	name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
+	cg = drmm_cgroup_register_region(&xe->drm, name,
+					 &(struct dmem_cgroup_init){
+						.size = size,
+						.ops = &xe_ttm_vram_mgr_dmem_ops,
+						.reclaim_priv = man,
+					 });
+	if (IS_ERR(cg))
+		return PTR_ERR(cg);
+
+	ttm_resource_manager_set_dmem_region(man, cg);
+
+	return 0;
 }
 
 /**
-- 
2.54.0



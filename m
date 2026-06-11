Return-Path: <cgroups+bounces-16867-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aPqjH+r2KmqM0AMAu9opvQ
	(envelope-from <cgroups+bounces-16867-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:56:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C946B674380
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=afIBjI2f;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16867-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16867-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E2A135CDD2A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88894BC03A;
	Thu, 11 Jun 2026 17:33:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B7400E0C;
	Thu, 11 Jun 2026 17:33:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199225; cv=none; b=OC9m3B6n+CEcgjWIESuckX55XmXB0E5qJebVGa9NnqqGMMYH05w3SvqxxnFY3Ouwa/cqLaEI6TVGB4E22giKMKSxrGOHoVfuXfR/vLi20mdd7MVKo3bW1MtZi2oyVIl+a2fwdeaC+LPJdh2r5gDX5UOMMrAJ90/PlV8FvSfqEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199225; c=relaxed/simple;
	bh=Z5tnKsqQw7EiBeSDr2ywtUGax4C0M+Mxkthf6nfbtWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeJue9JX9JmocqsBtFerlkQHKlrlXsoBa1NsBtUnuNjmBfiIdigVU9UzaJihhfPuqCm5rJWwf+BvsTzMrV734BV9kWQAAzaTS32ax8P5sUhCffnHK5UdxNejWulujJsAuS1udLHKUGgRE6efk7/P5hviy9GTYBgiMWZqS5dR/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afIBjI2f; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199222; x=1812735222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5tnKsqQw7EiBeSDr2ywtUGax4C0M+Mxkthf6nfbtWw=;
  b=afIBjI2fZ+5e6PQIyzZe988SmLNRnxvQLoR9C3ht+8O11pqEiszA855B
   yQcg7S0aXa5DIQNwgW8wm3p6PeJEdgjojzEmuilKfnXBa8rg5KX8wyAQ4
   XOWNJ2SIu3BevDRzcyzCMtWSe2i6lfKGDUO67y/cY40ImIwf7MnSFjFhD
   B/NpfUEBMgcjqmnCxrUDe1aCNZKcjUYhlh8C2KqzW2LWze/bPAljQ3z/a
   HmAtx6S8AkjMZoROXwTImcgCHmyMWizIdwohKQaA+vdL9CjXkKl7LkymW
   aikJdTs+WBpC1XRTcm39xzn4CdhPPTQq2kaCq9bTcb8s1MD9s5sbtxAlH
   w==;
X-CSE-ConnectionGUID: R78LUHMiS9yrYrFxrZAtpQ==
X-CSE-MsgGUID: psFuireuRyeuOSjYEOjTxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81761970"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81761970"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:41 -0700
X-CSE-ConnectionGUID: GxumfVM7QL+FVW9FnHpWZw==
X-CSE-MsgGUID: 1q5hoG8NS+u828BimQLcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="240214931"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:33:35 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sashiko-bot <sashiko-bot@kernel.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Tejun Heo <tj@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/6] drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
Date: Thu, 11 Jun 2026 19:32:56 +0200
Message-ID: <20260611173301.17473-2-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16867-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:sashiko-bot@kernel.org,m:friedrich.vock@gmx.de,m:dev@lankhorst.se,m:tj@kernel.org,m:mripard@kernel.org,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:rodrigo.vivi@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmx.de,lankhorst.se,amd.com,lists.freedesktop.org,vger.kernel.org,cmpxchg.org,suse.com,intel.com,suse.de,ffwll.ch,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,lists.freedesktop.org:email,lankhorst.se:email,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,gmx.de:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C946B674380

drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the function
returns early and bypasses those initializations.

Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
is called, a failure triggers amdgpu_ttm_fini(), which calls
amdgpu_vram_mgr_fini(), which then:

 - Calls list_for_each_entry_safe() on reservations_pending and
   reserved_pages, whose list_head::next pointers are zero-initialized
   (NULL). The loop does not recognize them as empty and dereferences NULL.

 - Calls gpu_buddy_fini(), which iterates free_trees[] unconditionally
   via for_each_free_tree(). Since mm->free_trees is NULL
   (never allocated), this dereferences NULL.

Both result in a kernel panic on the module load error path.

Fix by moving drmm_cgroup_register_region() to after the list and buddy
allocator are fully initialized, so the teardown path is safe to run.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@linux.intel.com?part=4
Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.14+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2a241a5b12c4..ac3f71d77140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
@@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
+	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
-- 
2.54.0



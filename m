Return-Path: <cgroups+bounces-57-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD957D5794
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85044B211B3
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D53994E;
	Tue, 24 Oct 2023 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLfroejU"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651439938
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:12:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786BDA1;
	Tue, 24 Oct 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163921; x=1729699921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GDvJD6iQ0dI3ndzQ1pnqCYM145L2PPps9Ux1wYqtB8=;
  b=RLfroejUIEvDocCW9+Hj32hu+CuWJbMNrP8BoiLQqzmivaDKoFqV99p+
   PM4DZ8mcRJtiWZA+N7HYLmCUBJvw0/H/NMeR2p2qel3zLzZ7xMVhLyQWz
   IrIDwIgiNExwALQwbsPSqkS3qspvhg6sD/Fiva6G3ySycGrwhQH8MbM/i
   ZThh3vIunG07KnEa5L96ZQ4SVl6ysFtnR+f/zR6gwkTkLR8Y30got6BJ/
   fKPp2G3NyRlZjdKcKsPe0IQzIAh3GqoNqV75vqttR/mkNIHJDx5n8uogk
   z6UN4Vz3rOabCIgS2Wrg1bFF/eYn7yVLeAhZ7+VfC8/sK4urRETP/I7DQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451328149"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451328149"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902237232"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902237232"
Received: from aidenbar-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.219.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:05:27 -0700
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: Intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Dave Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	=?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	Kenny.Ho@amd.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Brian Welty <brian.welty@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 4/8] drm/cgroup: Add over budget signalling callback
Date: Tue, 24 Oct 2023 17:07:23 +0100
Message-Id: <20231024160727.282960-5-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
References: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Add a new callback via which the drm cgroup controller is notifying the
drm core that a certain process is above its allotted GPU time.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 include/drm/drm_drv.h |  8 ++++++++
 kernel/cgroup/drm.c   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index d1cee5899cde..c518f03b9f0f 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -173,6 +173,14 @@ struct drm_cgroup_ops {
 	 * Used by the DRM core when queried by the DRM cgroup controller.
 	 */
 	u64 (*active_time_us) (struct drm_file *);
+
+	/**
+	 * @signal_budget:
+	 *
+	 * Optional callback used by the DRM core to forward over/under GPU time
+	 * messages sent by the DRM cgroup controller.
+	 */
+	int (*signal_budget) (struct drm_file *, u64 used, u64 budget);
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index acdb76635b60..68f31797c4f0 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -51,6 +51,22 @@ static u64 drmcs_get_active_time_us(struct drm_cgroup_state *drmcs)
 	return total;
 }
 
+static void
+drmcs_signal_budget(struct drm_cgroup_state *drmcs, u64 usage, u64 budget)
+{
+	struct drm_file *fpriv;
+
+	lockdep_assert_held(&drmcg_mutex);
+
+	list_for_each_entry(fpriv, &drmcs->clients, clink) {
+		const struct drm_cgroup_ops *cg_ops =
+			fpriv->minor->dev->driver->cg_ops;
+
+		if (cg_ops && cg_ops->signal_budget)
+			cg_ops->signal_budget(fpriv, usage, budget);
+	}
+}
+
 static void drmcs_free(struct cgroup_subsys_state *css)
 {
 	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
-- 
2.39.2



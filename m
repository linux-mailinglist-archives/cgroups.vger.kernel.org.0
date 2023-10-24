Return-Path: <cgroups+bounces-60-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08807D5799
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D191C20C0E
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE33995F;
	Tue, 24 Oct 2023 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bpn7LqE5"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B33993F
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:12:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587AEA6;
	Tue, 24 Oct 2023 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163924; x=1729699924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cx4m6Re1t0koStp5FqrNlsfdb8zARqyFqR2+8EFxmrM=;
  b=Bpn7LqE5OAMG0zJnhs/VDCRxkCuXgcC/bvCush47c4Q3l+bU+Bqb9bo7
   Czeo24Mema3Z1DzZk+C3AS7bU0gMaELXP0a7EqLfwjRSCmKFXyiilqa7c
   knycnn0mkSMcKjIW0t5k72Q+utu5weYqIXJ2CYnogPEwAqqY7Q3GlNUbi
   VjfMjt7z5vRkgPuGU6I5CuTG/MUELtcueWiiyvhHRQnCRxt0Sf1S09dCO
   DErioRU03k2PoUZLEzZbymQ4XAwPG2xydeYHWWvOeC5uVPj58Ds6yN5o6
   z/cFXCvbUdmdWSBf3wsUTE46eP1JVd/mPqQHPHJD4kw5CW7+kapz745xe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451328206"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451328206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902237358"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902237358"
Received: from aidenbar-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.219.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:05:41 -0700
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
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [RFC 8/8] cgroup/drm: Expose GPU utilisation
Date: Tue, 24 Oct 2023 17:07:27 +0100
Message-Id: <20231024160727.282960-9-tvrtko.ursulin@linux.intel.com>
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

To support container use cases where external orchestrators want to make
deployment and migration decisions based on GPU load and capacity, we can
expose the GPU load as seen by the controller in a new drm.active_us
field. This field contains a monotonic cumulative time cgroup has spent
executing GPU loads, as reported by the DRM drivers being used by group
members.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 +++++++
 kernel/cgroup/drm.c                     | 29 ++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 841533527b7b..9ac8ab65161c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2445,6 +2445,14 @@ respected.
 DRM weight based time control interface files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+  drm.stat
+	A read-only flat-keyed file.
+
+	Contains these fields:
+
+	- usage_usec - GPU time used by the group, recursively including all
+		       child groups.
+
   drm.weight
 	Standard cgroup weight based control [1, 10000] used to configure the
 	relative distributing of GPU time between the sibling groups.
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 1d1570bf3e90..127730990301 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -25,6 +25,8 @@ struct drm_cgroup_state {
 	bool over;
 	bool over_budget;
 
+	u64 total_us;
+
 	u64 per_s_budget_us;
 	u64 prev_active_us;
 	u64 active_us;
@@ -117,6 +119,24 @@ drmcs_write_weight(struct cgroup_subsys_state *css, struct cftype *cftype,
 	return 0;
 }
 
+static int drmcs_show_stat(struct seq_file *sf, void *v)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(seq_css(sf));
+	u64 val;
+
+#ifndef CONFIG_64BIT
+	mutex_lock(&drmcg_mutex);
+#endif
+	val = drmcs->total_us;
+#ifndef CONFIG_64BIT
+	mutex_unlock(&drmcg_mutex);
+#endif
+
+	seq_printf(sf, "usage_usec %llu\n", val);
+
+	return 0;
+}
+
 static bool __start_scanning(unsigned int period_us)
 {
 	struct drm_cgroup_state *root = &root_drmcs.drmcs;
@@ -169,11 +189,14 @@ static bool __start_scanning(unsigned int period_us)
 		parent = css_to_drmcs(node->parent);
 
 		active = drmcs_get_active_time_us(drmcs);
-		if (period_us && active > drmcs->prev_active_us)
+		if (period_us && active > drmcs->prev_active_us) {
 			drmcs->active_us += active - drmcs->prev_active_us;
+			drmcs->total_us += drmcs->active_us;
+		}
 		drmcs->prev_active_us = active;
 
 		parent->active_us += drmcs->active_us;
+		parent->total_us += drmcs->active_us;
 		parent->sum_children_weights += drmcs->weight;
 
 		css_put(node);
@@ -564,6 +587,10 @@ struct cftype files[] = {
 		.read_u64 = drmcs_read_weight,
 		.write_u64 = drmcs_write_weight,
 	},
+	{
+		.name = "stat",
+		.seq_show = drmcs_show_stat,
+	},
 	{ } /* Zero entry terminates. */
 };
 
-- 
2.39.2



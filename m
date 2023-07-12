Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00F875071B
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjGLLvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjGLLvK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:51:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEE1FF9;
        Wed, 12 Jul 2023 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162579; x=1720698579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3UFb8OqF06fv2F6gJ/iTXwHgvZZy1ZJFg6pTLkEphg=;
  b=mc1eAQfQ7zKxjhkpQeIS/jtQkQiPVMO9gi+Khr8ON+FzxI2NfdVXa9L4
   UuRy8vCQ6qEeT6PM7X03Zrp9vCtxPj3Acdk69D0bIxY4EnYRQZValnuCc
   vdbqNk+LERQoMZkKfHhswb5V7sAvsAFXX1ijUvf7tamoRu8nhLBFSJc52
   L4dSBxQdwialKdvgApfyD3SnrbNV2G7RKqYqqqNhnuULMQXvu4K7+nFDK
   zjyfjlqIe3VclX+IqjUHB5wfuU+sxzJibZvGnEX9UxWODjsDVrf8UaU88
   KNvrjqWG1wvQQ9B1mBjdrwOiWar0zvKM3hjuFKROHnXC/NuijQe6f2R3B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469398"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094175"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094175"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:09 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [PATCH 15/17] cgroup/drm: Expose GPU utilisation
Date:   Wed, 12 Jul 2023 12:46:03 +0100
Message-Id: <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 kernel/cgroup/drm.c                     | 26 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index da350858c59f..bbe986366f4a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2445,6 +2445,9 @@ will be respected.
 DRM scheduling soft limits interface files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+  drm.active_us
+	GPU time used by the group recursively including all child groups.
+
   drm.weight
 	Standard cgroup weight based control [1, 10000] used to configure the
 	relative distributing of GPU time between the sibling groups.
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index b244e3d828cc..7c20d4ebc634 100644
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
@@ -117,6 +119,20 @@ drmcs_write_weight(struct cgroup_subsys_state *css, struct cftype *cftype,
 	return 0;
 }
 
+static u64
+drmcs_read_total_us(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+	u64 val;
+
+	/* Mutex being overkill unless arch cannot atomically read u64.. */
+	mutex_lock(&drmcg_mutex);
+	val = drmcs->total_us;
+	mutex_unlock(&drmcg_mutex);
+
+	return val;
+}
+
 static bool __start_scanning(unsigned int period_us)
 {
 	struct drm_cgroup_state *root = &root_drmcs.drmcs;
@@ -169,11 +185,14 @@ static bool __start_scanning(unsigned int period_us)
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
@@ -551,6 +570,11 @@ struct cftype files[] = {
 		.read_u64 = drmcs_read_weight,
 		.write_u64 = drmcs_write_weight,
 	},
+	{
+		.name = "active_us",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = drmcs_read_total_us,
+	},
 	{ } /* Zero entry terminates. */
 };
 
-- 
2.39.2


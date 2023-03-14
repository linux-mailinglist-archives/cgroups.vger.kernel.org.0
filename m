Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC76B97B3
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCNOUY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCNOUE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 10:20:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DFA6746;
        Tue, 14 Mar 2023 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678803585; x=1710339585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3d9NzbFoh1gANUnCkXfWtCqiIz1wYgVTln49cPWTPw=;
  b=jOGhGv+CY4mQtTuf9A7xfgkU8AAnpQz/FZZDdNTlOMJ5k2/V5NyqfAMU
   5QOzESZ4vx/scn7upeyDnDjvnYFXFm+Tsat4knUCmKyUH3/UVY/6/GCcD
   fNsdUZO2HpYW3Tq+tzuijrqDn3ezQe7PubTUEqGcqcbe7kWfbYr9vnWaV
   6eYESsjKyeqAp55r6tjUP6DyvoqNyV5pf+OJJUThw7/vRUBsCCXZDYh9/
   SnmQjFrOC2ikhpcfipxgeh4k2OP18HSRoAhxxcykvFCNF94qiV8m3KU81
   QJcryanuZ7vTalT+ZRZS2Khp3JCA8SJypeEtc1Lts/59OBkOzZtg9/Bbl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321284829"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="321284829"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656363275"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="656363275"
Received: from mjtillin-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.236.227])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:19:37 -0700
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 06/10] drm/cgroup: Add over budget signalling callback
Date:   Tue, 14 Mar 2023 14:19:00 +0000
Message-Id: <20230314141904.1210824-7-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Add a new callback via which the drm cgroup controller is notifying the
drm core that a certain process is above its allotted GPU time.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 include/drm/drm_drv.h |  8 ++++++++
 kernel/cgroup/drm.c   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 01953d6b98d6..d8386b64eab5 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -167,6 +167,14 @@ struct drm_cgroup_ops {
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
2.37.2


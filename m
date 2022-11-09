Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2826622FDE
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiKIQMw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKIQM2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C022B21;
        Wed,  9 Nov 2022 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010347; x=1699546347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qq6Henm8EAobf6LwC/wUuKCvjc1IJ70N8x2PFzYMvRs=;
  b=YjQ+5XBr03tLQEV+adZgg5GKoWtQ9dsdG6v9oQZaokU8/FoXrWlP8GTM
   sP7R4QY9/Z6oK02iTeyboaw84UOJAnI9Pc1xr4oyDoriO+0j4R0DEq8U6
   DyZ4wl27XRC3gxCxl/Tm7oN7blY8AW/gqaGGepy7lh7Bvtt7XuG0GcV7N
   MNfWiVOSgDT/ipusmPaUPYegKMOsNJ1InFoq0aI6x4MIaz7SIdeQkgOWD
   BpW8GGbS6tvQIJeOUwlxJKvhC6h3uHAKODTG72oRLWN9Bj0mjyWfN2pVF
   8h+nohNk8m/T9WX/WPUK5+rBIvzwnoc02RQvQnBrU7mL37ErV6dKQLsSp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181402"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181402"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684540"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684540"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:24 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
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
Subject: [RFC 08/13] drm/cgroup: Add over budget signalling callback
Date:   Wed,  9 Nov 2022 16:11:36 +0000
Message-Id: <20221109161141.2987173-9-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/drm_cgroup.c | 21 +++++++++++++++++++++
 include/drm/drm_clients.h    |  1 +
 include/drm/drm_drv.h        |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 06810b4c3ff1..e3854741c584 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -152,3 +152,24 @@ u64 drm_pid_get_active_time_us(struct pid *pid)
 	return total;
 }
 EXPORT_SYMBOL_GPL(drm_pid_get_active_time_us);
+
+void drm_pid_signal_budget(struct pid *pid, u64 usage, u64 budget)
+{
+	struct drm_pid_clients *clients;
+
+	rcu_read_lock();
+	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
+	if (clients) {
+		struct drm_file *fpriv;
+
+		list_for_each_entry_rcu(fpriv, &clients->file_list, clink) {
+			const struct drm_cgroup_ops *cg_ops =
+				fpriv->minor->dev->driver->cg_ops;
+
+			if (cg_ops && cg_ops->signal_budget)
+				cg_ops->signal_budget(fpriv, usage, budget);
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(drm_pid_signal_budget);
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
index b9b8009c28a6..356ee92792a6 100644
--- a/include/drm/drm_clients.h
+++ b/include/drm/drm_clients.h
@@ -42,5 +42,6 @@ drm_clients_migrate(struct drm_file *file_priv,
 #endif
 
 u64 drm_pid_get_active_time_us(struct pid *pid);
+void drm_pid_signal_budget(struct pid *pid, u64 usage, u64 budget);
 
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index c09fe9bd517f..c30afe97f922 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -164,6 +164,14 @@ struct drm_cgroup_ops {
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
-- 
2.34.1


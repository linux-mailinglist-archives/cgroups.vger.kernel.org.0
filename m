Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B88604EDB
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJSRec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJSReM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:34:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD41D3765;
        Wed, 19 Oct 2022 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200850; x=1697736850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57xevMaPNuTYw9loIK3v8HjbtAVBJSLqQ4lTiTCwMqQ=;
  b=b403/DjIO2r0FckCx6SOM0koAAHJZ2j5vZVUjwN7GcB6jJf6KNBKeme3
   opYJEwTVl6Ge+palbio+0/ishxAb71+4mJiJILJnrJHMRv2DPN70P7zP4
   KW2AiNyfdnBjyxQw8eevt6AKaCztGm6N0F1BMKd68k3F4ADNmdJQ1QvTT
   fKsESVkZiBuoDyiUF7/iH+1c5Ozzh0ZBDtQka7YH64PPIafL3TAZt5EDu
   5NaUXct4Hga8uQjwgkx5vkx7jeRV06UYkUony3vaJ8cbl61i8xwtmkg2j
   k1bRLEd3er4WtEKSC7WpM29VRiVeh4OJ0YEyYjX7g1jfgqb2D8qVHH2Fi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474511"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474511"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204806"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204806"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:50 -0700
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
Subject: [RFC 10/17] drm: Add ability to query drm cgroup GPU time
Date:   Wed, 19 Oct 2022 18:32:47 +0100
Message-Id: <20221019173254.3361334-11-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Add a driver callback and core helper which allow querying the time spent
on GPUs for processes belonging to a group.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c | 24 ++++++++++++++++++++++++
 include/drm/drm_clients.h    |  1 +
 include/drm/drm_drv.h        |  9 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 59b730ed1334..e0cadb5e5659 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -206,3 +206,27 @@ void drm_pid_update_priority(struct pid *pid, int priority)
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(drm_pid_update_priority);
+
+u64 drm_pid_get_active_time_us(struct pid *pid)
+{
+	struct drm_pid_clients *clients;
+	u64 total = 0;
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
+			if (cg_ops && cg_ops->active_time_us)
+				total += cg_ops->active_time_us(fpriv);
+		}
+	}
+	rcu_read_unlock();
+
+	return total;
+}
+EXPORT_SYMBOL_GPL(drm_pid_get_active_time_us);
diff --git a/include/drm/drm_clients.h b/include/drm/drm_clients.h
index 3a0b1cdb338f..f25e09ed5feb 100644
--- a/include/drm/drm_clients.h
+++ b/include/drm/drm_clients.h
@@ -37,5 +37,6 @@ static inline void drm_clients_migrate(struct drm_file *file_priv)
 
 unsigned int drm_pid_priority_levels(struct pid *pid, bool *non_uniform);
 void drm_pid_update_priority(struct pid *pid, int priority);
+u64 drm_pid_get_active_time_us(struct pid *pid);
 
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 2371d73e12cf..0f1802df01fe 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -183,6 +183,15 @@ struct drm_cgroup_ops {
 	 * priorities of already running workloads.
 	 */
 	void (*update_priority) (struct drm_file *, int priority);
+
+	/**
+	 * @active_time_us:
+	 *
+	 * Optional callback for reporting the GPU time consumed by this client.
+	 *
+	 * Used by the DRM core when queried by the DRM cgroup controller.
+	 */
+	u64 (*active_time_us) (struct drm_file *);
 };
 
 /**
-- 
2.34.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C31622FE5
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiKIQND (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKIQMt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C823BFF;
        Wed,  9 Nov 2022 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010354; x=1699546354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xsH6SUJPl/aECTQLLwvLwzjjo/OdVfq3yYbEuLbpcjc=;
  b=Nur0QNLkADbBaix9OP9OgUxgd+zYPTvU/f9Kjk3FVRu7+1+udWPDCgFI
   PQ3D/h6jPpVCADRoq6w71mpWo49Re1qMzc4TU3k72KpNva1ga1YxtX6sy
   y49caY8V2ujcmuJv7ZV2RSp1om9UtNyAt7TK8dJSV1ZQ+0sDHrNKOBDeJ
   o+XC1j8bKRk/5lxvsRR5iJbqahEXncF4vAvQqwQAh9Z1vIMC26uKNlsXW
   l9ZVzp1B6tvqZTFbvwOD4nxbAO4vCBWJp4IIPoiXPL+VV1yN4I7tH8Vlw
   o0Xy2ONGkfz+e4A8VZfyM5NVJrr+3OgoCurHcgJ2ooUJXcxZipRNeaQin
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181445"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181445"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684585"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684585"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:31 -0800
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
Subject: [RFC 10/13] cgroup/drm: Client exit hook
Date:   Wed,  9 Nov 2022 16:11:38 +0000
Message-Id: <20221109161141.2987173-11-tvrtko.ursulin@linux.intel.com>
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

We need the ability for DRM core to inform the cgroup controller when a
client has closed a DRM file descriptor. This will allow us not needing
to keep state relating to GPU time usage by tasks sets in the cgroup
controller itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c |  8 ++++++++
 include/linux/cgroup_drm.h   |  4 ++++
 kernel/cgroup/drm.c          | 13 +++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index d3050c744e3e..31a1bf3c8a43 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_drv.h>
 #include <drm/drm_clients.h>
+#include <linux/cgroup_drm.h>
 
 static DEFINE_XARRAY(drm_pid_clients);
 
@@ -31,6 +32,7 @@ void drm_clients_close(struct drm_file *file_priv)
 {
 	struct drm_device *dev = file_priv->minor->dev;
 	struct drm_pid_clients *clients;
+	struct task_struct *task;
 	struct pid *pid;
 
 	lockdep_assert_held(&dev->filelist_mutex);
@@ -43,6 +45,12 @@ void drm_clients_close(struct drm_file *file_priv)
 	if (WARN_ON_ONCE(!clients))
 		return;
 
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (task) {
+		drmcgroup_client_exited(task);
+		put_task_struct(task);
+	}
+
 	__del_clients(clients, file_priv, (unsigned long)pid);
 }
 
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index bf8abc6b8ebf..2f755b896136 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,4 +6,8 @@
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
+struct task_struct;
+
+void drmcgroup_client_exited(struct task_struct *task);
+
 #endif	/* _CGROUP_DRM_H */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index b88c93661df3..e165d8f542cc 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -18,11 +18,24 @@ css_to_drmcs(struct cgroup_subsys_state *css)
 	return container_of(css, struct drm_cgroup_state, css);
 }
 
+static inline struct drm_cgroup_state *get_task_drmcs(struct task_struct *task)
+{
+	return css_to_drmcs(task_get_css(task, drm_cgrp_id));
+}
+
 static void drmcs_free(struct cgroup_subsys_state *css)
 {
 	kfree(css_to_drmcs(css));
 }
 
+void drmcgroup_client_exited(struct task_struct *task)
+{
+	struct drm_cgroup_state *drmcs = get_task_drmcs(task);
+
+	css_put(&drmcs->css);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_exited);
+
 static struct drm_cgroup_state root_drmcs = {
 };
 
-- 
2.34.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD4604EDE
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJSReg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJSReR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:34:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A54A1C20A8;
        Wed, 19 Oct 2022 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200852; x=1697736852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SjnzP/RjutkVE2GWCovZkYcvG7xuDDB28V5+LUt3bM=;
  b=UZDN5ecuQzQMwOX56Ll2FRO2VGAm7ii9b8WiAyLfnIZPtdVuqWvI+8uh
   xC0g7YzBZH34qUDvvR4TSwnqUcyHjEHfy0PfdSEENpUIXd2fs9RCID3Xw
   QUvYhXIuoMtsmQW3K+XxpR3bCgs1XcJvBnHKmL3vXaM1NFb2dslugUcU8
   BWLbpmlqK6amndbYgDJx12UKGNMwM2JT7yQOjcW46mXLG3bcjSc8WiLoH
   2ZPwbJdUnVXqg20iVaq9WdibSi/Cu35zt6noEmyrJ5MOyDXyx34Fq57Tc
   sFxInBtg5eBRkLq1DTPLvBXkoF7l8QxBEpHGWuKUC/y96bX5/NY2lBkVt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474544"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:34:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204833"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204833"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:56 -0700
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
Subject: [RFC 12/17] cgroup/drm: Client exit hook
Date:   Wed, 19 Oct 2022 18:32:49 +0100
Message-Id: <20221019173254.3361334-13-tvrtko.ursulin@linux.intel.com>
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

We need the ability for DRM core to inform the cgroup controller when a
client has closed a DRM file descriptor. This will allow us not needing
to keep state relating to GPU time usage by tasks sets in the cgroup
controller itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c | 8 ++++++++
 include/linux/cgroup_drm.h   | 1 +
 kernel/cgroup/drm.c          | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index e36bc4333924..ff99d1f4f1d4 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_drv.h>
 #include <drm/drm_clients.h>
+#include <linux/cgroup_drm.h>
 
 static DEFINE_XARRAY(drm_pid_clients);
 
@@ -25,6 +26,7 @@ void drm_clients_close(struct drm_file *file_priv)
 {
 	struct drm_device *dev = file_priv->minor->dev;
 	struct drm_pid_clients *clients;
+	struct task_struct *task;
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
@@ -35,6 +37,12 @@ void drm_clients_close(struct drm_file *file_priv)
 	if (WARN_ON_ONCE(!clients))
 		return;
 
+	task = get_pid_task(file_priv->cpid, PIDTYPE_PID);
+	if (task) {
+		drmcgroup_client_exited(task);
+		put_task_struct(task);
+	}
+
 	__del_clients(clients, file_priv);
 
 	/*
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 66063b4708e8..c84516d3e50a 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -13,5 +13,6 @@ struct task_struct;
 #define DRM_CGROUP_PRIORITY_MAX	(10000)
 
 int drmcgroup_lookup_effective_priority(struct task_struct *task);
+void drmcgroup_client_exited(struct task_struct *task);
 
 #endif	/* _CGROUP_DRM_H */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 4b6f88d8236e..48f1eaaa1c07 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -221,6 +221,14 @@ static void drmcs_attach(struct cgroup_taskset *tset)
 					css_to_drmcs(css)->effective_priority);
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
 	.priority = DRM_CGROUP_PRIORITY_DEF,
 	.effective_priority = DRM_CGROUP_PRIORITY_DEF,
-- 
2.34.1


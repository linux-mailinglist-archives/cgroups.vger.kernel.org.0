Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDF622FC8
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKIQME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKIQMD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B6462CA;
        Wed,  9 Nov 2022 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010322; x=1699546322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhBrapaJ+vgi9kxPoWBSV/LQcGioxwEBpF/rBIIcwyQ=;
  b=GFPuXlHMibm5vpAndO/a82n3X3/y52qlHtAcSYd4+2LE2JLDTaIKdLjF
   BKpr3V9ASBRfBN2uo40aYYdeGx38lqI/DLO4rV0eUDoxGmJ4IzQZJObCJ
   sYxPK0yYe9M8Xz58Fs2bhcJa1pFbWe6F3WI6GexJhQAQB4DUByhFT4cgZ
   1hN1rgX/CPVXutxFhZ55zCWhmUQxNCRW7uDWcj6mps707mbcDaDdswJW0
   W/bAT5oyJqWYEFbR3nDJOZK2FkmZs0144oqLLmVPqTcnQLkXTR2BWJ9wu
   AagNfAEQ6p44fHUPuffXsgv17mtvCNkPUG8EcfIWCWPH1bl9nD51dyxSp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290735947"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="290735947"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684361"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684361"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:11:58 -0800
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
Subject: [RFC 01/13] drm: Replace DRM_DEBUG with drm_dbg_core in file and ioctl handling
Date:   Wed,  9 Nov 2022 16:11:29 +0000
Message-Id: <20221109161141.2987173-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Replace the deprecated macro with the per-device one.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_file.c  | 21 +++++++++++----------
 drivers/gpu/drm/drm_ioc32.c | 13 +++++++------
 drivers/gpu/drm/drm_ioctl.c | 25 +++++++++++++------------
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index a8b4d918e9a3..ba5041137b29 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -245,10 +245,10 @@ void drm_file_free(struct drm_file *file)
 
 	dev = file->minor->dev;
 
-	DRM_DEBUG("comm=\"%s\", pid=%d, dev=0x%lx, open_count=%d\n",
-		  current->comm, task_pid_nr(current),
-		  (long)old_encode_dev(file->minor->kdev->devt),
-		  atomic_read(&dev->open_count));
+	drm_dbg_core(dev, "comm=\"%s\", pid=%d, dev=0x%lx, open_count=%d\n",
+		     current->comm, task_pid_nr(current),
+		     (long)old_encode_dev(file->minor->kdev->devt),
+		     atomic_read(&dev->open_count));
 
 #ifdef CONFIG_DRM_LEGACY
 	if (drm_core_check_feature(dev, DRIVER_LEGACY) &&
@@ -340,8 +340,8 @@ static int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	    dev->switch_power_state != DRM_SWITCH_POWER_DYNAMIC_OFF)
 		return -EINVAL;
 
-	DRM_DEBUG("comm=\"%s\", pid=%d, minor=%d\n", current->comm,
-		  task_pid_nr(current), minor->index);
+	drm_dbg_core(dev, "comm=\"%s\", pid=%d, minor=%d\n",
+		     current->comm, task_pid_nr(current), minor->index);
 
 	priv = drm_file_alloc(minor);
 	if (IS_ERR(priv))
@@ -450,11 +450,12 @@ EXPORT_SYMBOL(drm_open);
 
 void drm_lastclose(struct drm_device * dev)
 {
-	DRM_DEBUG("\n");
+	drm_dbg_core(dev, "\n");
 
-	if (dev->driver->lastclose)
+	if (dev->driver->lastclose) {
 		dev->driver->lastclose(dev);
-	DRM_DEBUG("driver lastclose completed\n");
+		drm_dbg_core(dev, "driver lastclose completed\n");
+	}
 
 	if (drm_core_check_feature(dev, DRIVER_LEGACY))
 		drm_legacy_dev_reinit(dev);
@@ -485,7 +486,7 @@ int drm_release(struct inode *inode, struct file *filp)
 	if (drm_dev_needs_global_mutex(dev))
 		mutex_lock(&drm_global_mutex);
 
-	DRM_DEBUG("open_count = %d\n", atomic_read(&dev->open_count));
+	drm_dbg_core(dev, "open_count = %d\n", atomic_read(&dev->open_count));
 
 	drm_close_helper(filp);
 
diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
index 5d82891c3222..49a743f62b4a 100644
--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -972,6 +972,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	unsigned int nr = DRM_IOCTL_NR(cmd);
 	struct drm_file *file_priv = filp->private_data;
+	struct drm_device *dev = file_priv->minor->dev;
 	drm_ioctl_compat_t *fn;
 	int ret;
 
@@ -986,14 +987,14 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (!fn)
 		return drm_ioctl(filp, cmd, arg);
 
-	DRM_DEBUG("comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, %s\n",
-		  current->comm, task_pid_nr(current),
-		  (long)old_encode_dev(file_priv->minor->kdev->devt),
-		  file_priv->authenticated,
-		  drm_compat_ioctls[nr].name);
+	drm_dbg_core(dev, "comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, %s\n",
+		     current->comm, task_pid_nr(current),
+		     (long)old_encode_dev(file_priv->minor->kdev->devt),
+		     file_priv->authenticated,
+		     drm_compat_ioctls[nr].name);
 	ret = (*fn)(filp, cmd, arg);
 	if (ret)
-		DRM_DEBUG("ret = %d\n", ret);
+		drm_dbg_core(dev, "ret = %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL(drm_compat_ioctl);
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ca2a6e6101dc..7c9d66ee917d 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -440,7 +440,7 @@ static int drm_setversion(struct drm_device *dev, void *data, struct drm_file *f
 int drm_noop(struct drm_device *dev, void *data,
 	     struct drm_file *file_priv)
 {
-	DRM_DEBUG("\n");
+	drm_dbg_core(dev, "\n");
 	return 0;
 }
 EXPORT_SYMBOL(drm_noop);
@@ -856,16 +856,16 @@ long drm_ioctl(struct file *filp,
 		out_size = 0;
 	ksize = max(max(in_size, out_size), drv_size);
 
-	DRM_DEBUG("comm=\"%s\" pid=%d, dev=0x%lx, auth=%d, %s\n",
-		  current->comm, task_pid_nr(current),
-		  (long)old_encode_dev(file_priv->minor->kdev->devt),
-		  file_priv->authenticated, ioctl->name);
+	drm_dbg_core(dev, "comm=\"%s\" pid=%d, dev=0x%lx, auth=%d, %s\n",
+		     current->comm, task_pid_nr(current),
+		     (long)old_encode_dev(file_priv->minor->kdev->devt),
+		     file_priv->authenticated, ioctl->name);
 
 	/* Do not trust userspace, use our own definition */
 	func = ioctl->func;
 
 	if (unlikely(!func)) {
-		DRM_DEBUG("no function\n");
+		drm_dbg_core(dev, "no function\n");
 		retcode = -EINVAL;
 		goto err_i1;
 	}
@@ -894,16 +894,17 @@ long drm_ioctl(struct file *filp,
 
       err_i1:
 	if (!ioctl)
-		DRM_DEBUG("invalid ioctl: comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, cmd=0x%02x, nr=0x%02x\n",
-			  current->comm, task_pid_nr(current),
-			  (long)old_encode_dev(file_priv->minor->kdev->devt),
-			  file_priv->authenticated, cmd, nr);
+		drm_dbg_core(dev,
+			     "invalid ioctl: comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, cmd=0x%02x, nr=0x%02x\n",
+			     current->comm, task_pid_nr(current),
+			     (long)old_encode_dev(file_priv->minor->kdev->devt),
+			     file_priv->authenticated, cmd, nr);
 
 	if (kdata != stack_kdata)
 		kfree(kdata);
 	if (retcode)
-		DRM_DEBUG("comm=\"%s\", pid=%d, ret=%d\n", current->comm,
-			  task_pid_nr(current), retcode);
+		drm_dbg_core(dev, "comm=\"%s\", pid=%d, ret=%d\n",
+			     current->comm, task_pid_nr(current), retcode);
 	return retcode;
 }
 EXPORT_SYMBOL(drm_ioctl);
-- 
2.34.1


Return-Path: <cgroups+bounces-5190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937D9AC0E9
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384831C22ED1
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC886158527;
	Wed, 23 Oct 2024 08:00:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216E14B942;
	Wed, 23 Oct 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670455; cv=none; b=H7povMqecI+3+U6n07CykpiSi7Y9uh894+YRaWrmRQf7vSQl0fmDldlT9VbodsZR4rucsTl5UMNaMQMfgGTeJ8M9xncUFDLbPa/oVOLkonIsJmGOlpMC7QhW2tLrdQIHBkjE3J7+tAuYnyudLD9VWGdjzbA0LMPqOn++K/9SgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670455; c=relaxed/simple;
	bh=JMkwaJv4IrV8z+C525gHQ1es4HpS+Ic0xUB0qeweI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LktNU31l1yq9bbAswNElhfw1gf2oTmYxDATqIg+vo4iSFykNtRfPnjNvLEZbLFe2ZRYEHV7brX/nS+Km8PQggUk0kPMnD/NMovrC4I67GXnE3aCbI32lgAwO1WMsGey+9FAL4bae00w/dJYXCPtTEa0qFcbIPQIksFjfK+p7vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 2/7] drm/drv: Add drmm cgroup registration for dev cgroups.
Date: Wed, 23 Oct 2024 09:52:55 +0200
Message-ID: <20241023075302.27194-3-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

Drivers will need to register a cgroup device at probe time, so let's
give them a drm-managed helper.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/drm_drv.c | 21 +++++++++++++++++++++
 include/drm/drm_drv.h     |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c2c172eb25df7..251d1d69b09c5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -26,6 +26,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/cgroup_dev.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -820,6 +821,26 @@ void drm_dev_put(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_put);
 
+static inline void drmm_cg_unregister_device(struct drm_device *dev, void *arg)
+{
+	dev_cgroup_unregister_device(arg);
+}
+
+int drmm_cgroup_register_device(struct drm_device *dev,
+				struct dev_cgroup_device *cgdev)
+{
+	int ret;
+	char dev_name[32];
+
+	snprintf(dev_name, sizeof(dev_name), "drm/%s", dev->unique);
+	ret = dev_cgroup_register_device(cgdev, dev_name);
+	if (ret)
+		return ret;
+
+	return drmm_add_action_or_reset(dev, drmm_cg_unregister_device, cgdev);
+}
+EXPORT_SYMBOL_GPL(drmm_cgroup_register_device);
+
 static int create_compat_control_link(struct drm_device *dev)
 {
 	struct drm_minor *minor;
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 1bbbcb8e2d231..3e83c7ce7f2d0 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -34,6 +34,7 @@
 
 #include <drm/drm_device.h>
 
+struct dev_cgroup_device;
 struct drm_fb_helper;
 struct drm_fb_helper_surface_size;
 struct drm_file;
@@ -438,6 +439,9 @@ void *__devm_drm_dev_alloc(struct device *parent,
 			   const struct drm_driver *driver,
 			   size_t size, size_t offset);
 
+int drmm_cgroup_register_device(struct drm_device *dev,
+				struct dev_cgroup_device *cgdev);
+
 /**
  * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
  * @parent: Parent device object
-- 
2.45.2



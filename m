Return-Path: <cgroups+bounces-9669-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D490B42558
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA53684E32
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037826CE36;
	Wed,  3 Sep 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o4VqVwyv"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC845258EF0;
	Wed,  3 Sep 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913028; cv=none; b=QrunKXJCqGjw85St4sVlF6EIXY6iWluE5yYsBkreHFZFpuGOgr2U/dsw3eyvnxGRDq9ABGR5pApzjIsYtt4Okkw7MwFsolP+R0Z4lzk2RzZgmID7BUFdz6Rsm3TP0Lmqo9svLXvGXOGoylrLPOnnIbt9++jV4pbtM80Xe9FqTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913028; c=relaxed/simple;
	bh=/xDvSuh/4pWtz+HlTvGIWIRAH/WO8lT+pEoAsWK2rnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2F0iR6jv/rx8fHGdYNLvY3ztR6d33WewZtBdEsUso0EoybJuDAo0AfG7yF5gANe6xWX4JrF58KvHRFMVbWMhLu/6h69NpGgGwA/mJARrSHOejFnr5vGZ9puIf2HdXCgHBTIhlutpsVwZUxNOEoQ+4FM6CNMziBwja6woNX1KEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o4VqVwyv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uoNtwksOwup+m0W8zkIXDJll3fXt0uIJsdoIaLnX1lo=; b=o4VqVwyvzbXqY2RdcanACMf5gF
	VBygv5dbMxYCYpDf1mS3zhsouqdRaOhCF8KEnQNhc8C6U9L0Q54Zxl7uyxuj+YFyh0CwkUWeciR2y
	yQTvuHSeJyRTgElqoKM5xI0pyPnnF2oLHvTh+nl3OfRVFSMvMgyc8rmwaXL6yi2egdJvsX4EcgFPX
	S2n6wp/VAKHrF43FkKIp0J3KEiAd3gi/PkXgkvK2s/LHLqOZFwXUCqUu+nmSPweLSFWDu4neNvHQk
	NQ5H0iv76UQFNU0gOYoUbPOwhedIw8/jDUma18fsjzDrBD7aPB3d3mBd47FIvSOdmpNovcga3rNyy
	5E89j77Q==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKn-006GaP-FH; Wed, 03 Sep 2025 17:23:41 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 14/21] cgroup/drm: Track DRM clients per cgroup
Date: Wed,  3 Sep 2025 16:23:20 +0100
Message-ID: <20250903152327.66002-15-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable propagation of settings from the cgroup DRM controller to DRM
and vice-versa, we need to start tracking to which cgroups DRM clients
belong.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/drm_file.c |  8 +++++
 include/drm/drm_file.h     |  6 ++++
 include/linux/cgroup_drm.h | 20 ++++++++++++
 kernel/cgroup/drm.c        | 62 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index eebd1a05ee97..1520436c5491 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -32,6 +32,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cgroup_drm.h>
 #include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/file.h>
@@ -287,6 +288,8 @@ static void drm_close_helper(struct file *filp)
 	list_del(&file_priv->lhead);
 	mutex_unlock(&dev->filelist_mutex);
 
+	drmcgroup_client_close(file_priv);
+
 	drm_file_free(file_priv);
 }
 
@@ -351,6 +354,8 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
 	list_add(&priv->lhead, &dev->filelist);
 	mutex_unlock(&dev->filelist_mutex);
 
+	drmcgroup_client_open(priv);
+
 	return 0;
 }
 
@@ -477,6 +482,9 @@ void drm_file_update_pid(struct drm_file *filp)
 	old = rcu_replace_pointer(filp->pid, pid, 1);
 	mutex_unlock(&dev->filelist_mutex);
 
+	if (pid != old)
+		drmcgroup_client_migrate(filp);
+
 	synchronize_rcu();
 	put_pid(old);
 }
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 115763799625..3326246a2f06 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -30,6 +30,7 @@
 #ifndef _DRM_FILE_H_
 #define _DRM_FILE_H_
 
+#include <linux/cgroup.h>
 #include <linux/types.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
@@ -295,6 +296,11 @@ struct drm_file {
 	/** @minor: &struct drm_minor for this file. */
 	struct drm_minor *minor;
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+	struct cgroup_subsys_state *__css;
+	struct list_head clink;
+#endif
+
 	/**
 	 * @object_idr:
 	 *
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index 3e51fe517791..318b0e441496 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -4,4 +4,24 @@
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
+#include <drm/drm_file.h>
+
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+void drmcgroup_client_open(struct drm_file *file_priv);
+void drmcgroup_client_close(struct drm_file *file_priv);
+void drmcgroup_client_migrate(struct drm_file *file_priv);
+#else
+static inline void drmcgroup_client_open(struct drm_file *file_priv)
+{
+}
+
+static inline void drmcgroup_client_close(struct drm_file *file_priv)
+{
+}
+
+static inline void drmcgroup_client_migrate(struct drm_file *file_priv)
+{
+}
+#endif
+
 #endif	/* _CGROUP_DRM_H */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 55947a009e04..e9dc1e7cc4a4 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -3,17 +3,25 @@
 
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
+
+	struct list_head clients;
 };
 
 struct drm_root_cgroup_state {
 	struct drm_cgroup_state drmcs;
 };
 
-static struct drm_root_cgroup_state root_drmcs;
+static struct drm_root_cgroup_state root_drmcs = {
+	.drmcs.clients = LIST_HEAD_INIT(root_drmcs.drmcs.clients),
+};
+
+static DEFINE_MUTEX(drmcg_mutex);
 
 static inline struct drm_cgroup_state *
 css_to_drmcs(struct cgroup_subsys_state *css)
@@ -40,11 +48,63 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
 		drmcs = kzalloc(sizeof(*drmcs), GFP_KERNEL);
 		if (!drmcs)
 			return ERR_PTR(-ENOMEM);
+
+		INIT_LIST_HEAD(&drmcs->clients);
 	}
 
 	return &drmcs->css;
 }
 
+void drmcgroup_client_open(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *drmcs;
+
+	drmcs = css_to_drmcs(task_get_css(current, drm_cgrp_id));
+
+	mutex_lock(&drmcg_mutex);
+	file_priv->__css = &drmcs->css; /* Keeps the reference. */
+	list_add_tail(&file_priv->clink, &drmcs->clients);
+	mutex_unlock(&drmcg_mutex);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_open);
+
+void drmcgroup_client_close(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *drmcs;
+
+	drmcs = css_to_drmcs(file_priv->__css);
+
+	mutex_lock(&drmcg_mutex);
+	list_del(&file_priv->clink);
+	file_priv->__css = NULL;
+	mutex_unlock(&drmcg_mutex);
+
+	css_put(&drmcs->css);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_close);
+
+void drmcgroup_client_migrate(struct drm_file *file_priv)
+{
+	struct drm_cgroup_state *src, *dst;
+	struct cgroup_subsys_state *old;
+
+	mutex_lock(&drmcg_mutex);
+
+	old = file_priv->__css;
+	src = css_to_drmcs(old);
+	dst = css_to_drmcs(task_get_css(current, drm_cgrp_id));
+
+	if (src != dst) {
+		file_priv->__css = &dst->css; /* Keeps the reference. */
+		list_move_tail(&file_priv->clink, &dst->clients);
+	}
+
+	mutex_unlock(&drmcg_mutex);
+
+	css_put(old);
+}
+EXPORT_SYMBOL_GPL(drmcgroup_client_migrate);
+
 struct cftype files[] = {
 	{ } /* Zero entry terminates. */
 };
-- 
2.48.0



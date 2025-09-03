Return-Path: <cgroups+bounces-9670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A58B4255A
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E0F1BC482F
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669726F2A0;
	Wed,  3 Sep 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AJ09Flzy"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220325C821;
	Wed,  3 Sep 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913028; cv=none; b=SuBMvZmUyHcF/qomL/8WeP2GQ7cxnOVfBDAAfzf3efV24IbT4slkorjFv5Q/ploLF7Rc6OhT+t7R02lJ8h74hoUThMkXEH+zFobWIVdX2GFwo0mvzR6yA1ThuwOHhLsP51W7gcLDWwSYnzzuE99ip6EygMcRmmF05lqgDS2Sr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913028; c=relaxed/simple;
	bh=4fH/ts4g4HJjx2RLLc+zwkP2xOAlzJAZFUBs+gTCWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd9ZaUkbqvsKUbgamLegT38XaHyu2jSV5SuoMAHTP4hGoofkI3hSYJOhQbO0MCWpqQhaNcqPLFlrKtVz81Vs41p6kerGpMtTp9IhvQcDZLQNG5i7zVVZzGEQg1asCcnG7avsnFYgwfKgskf8deRngsVw2Ffz8/vx5tZewYzZF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AJ09Flzy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IsWnQWYQd8ok9z9F0TOX6bOGhUkIh9EKIXSKlJoEGYg=; b=AJ09FlzyVT9eal4yJ2y7P5g9IO
	w1f+9cHgbGl3iRDscUhAp0lbLfjExAOnXkIlUf2NlB3GGCaJQSx3efglfKiR+b+S56Sivu7WH44uP
	SUWaEv4spcoWUj0WJWDK5NbfGkcZhl6RonhveEVKddZMpGtjN+78NnM+DCRm5ot5gwOMbzDlOhXId
	DrPhG5xiNFlzXXwD67XjoBxDszQV5SzZubF3TxFxPvCSX/NR0OBWP2iMYlqV3n0ES62vlRmdKi9GY
	KDzC3mUPFeQC04i0WAFAOZaRiltFDelLdQVPc1ljAKjymgjKLii/k+f0+Z/831tzVTa32ffconV75
	yoPX4ZGQ==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKo-006Gak-6i; Wed, 03 Sep 2025 17:23:42 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 15/21] cgroup/drm: Add scheduling weight callback
Date: Wed,  3 Sep 2025 16:23:21 +0100
Message-ID: <20250903152327.66002-16-tvrtko.ursulin@igalia.com>
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

Add a new callback via which the drm cgroup controller will be notifying
clients about their scheduling weight.

At the same time, in order to reduce the amount of tracking with drivers
which will not support any sort of control from the drm cgroup controller
side, lets express the funcionality as opt-in and use the presence of
drm_cgroup_ops as an activation criteria.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 include/drm/drm_drv.h | 26 ++++++++++++++++++++++++++
 kernel/cgroup/drm.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986d..5aa905187723 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -169,6 +169,22 @@ enum drm_driver_feature {
 	DRIVER_HAVE_IRQ			= BIT(30),
 };
 
+/**
+ * struct drm_cgroup_ops
+ *
+ * This structure contains callbacks that drivers can provide if they are able
+ * support the functionalities implemented by the DRM cgroup controller.
+ */
+struct drm_cgroup_ops {
+	/**
+	 * @notify_weight:
+	 *
+	 * Optional callback used by the DRM core to notify clients of their
+	 * scheduling weight.
+	 */
+	void (*notify_weight) (struct drm_file *, unsigned int weight);
+};
+
 /**
  * struct drm_driver - DRM driver structure
  *
@@ -431,6 +447,16 @@ struct drm_driver {
 	 * some examples.
 	 */
 	const struct file_operations *fops;
+
+#ifdef CONFIG_CGROUP_DRM
+	/**
+	 * @cg_ops:
+	 *
+	 * Optional pointer to driver callbacks facilitating integration with
+	 * the DRM cgroup controller.
+	 */
+	const struct drm_cgroup_ops *cg_ops;
+#endif
 };
 
 void *__devm_drm_dev_alloc(struct device *parent,
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index e9dc1e7cc4a4..ea7655edf86a 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -7,6 +7,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
+#include <drm/drm_drv.h>
+
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
 
@@ -29,6 +31,22 @@ css_to_drmcs(struct cgroup_subsys_state *css)
 	return container_of(css, struct drm_cgroup_state, css);
 }
 
+static void __maybe_unused
+drmcs_notify_weight(struct drm_cgroup_state *drmcs)
+{
+	struct drm_file *fpriv;
+
+	lockdep_assert_held(&drmcg_mutex);
+
+	list_for_each_entry(fpriv, &drmcs->clients, clink) {
+		const struct drm_cgroup_ops *cg_ops =
+			fpriv->minor->dev->driver->cg_ops;
+
+		if (cg_ops && cg_ops->notify_weight)
+			cg_ops->notify_weight(fpriv, 0);
+	}
+}
+
 static void drmcs_free(struct cgroup_subsys_state *css)
 {
 	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
@@ -59,6 +77,9 @@ void drmcgroup_client_open(struct drm_file *file_priv)
 {
 	struct drm_cgroup_state *drmcs;
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	drmcs = css_to_drmcs(task_get_css(current, drm_cgrp_id));
 
 	mutex_lock(&drmcg_mutex);
@@ -74,6 +95,9 @@ void drmcgroup_client_close(struct drm_file *file_priv)
 
 	drmcs = css_to_drmcs(file_priv->__css);
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	mutex_lock(&drmcg_mutex);
 	list_del(&file_priv->clink);
 	file_priv->__css = NULL;
@@ -88,6 +112,9 @@ void drmcgroup_client_migrate(struct drm_file *file_priv)
 	struct drm_cgroup_state *src, *dst;
 	struct cgroup_subsys_state *old;
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	mutex_lock(&drmcg_mutex);
 
 	old = file_priv->__css;
-- 
2.48.0



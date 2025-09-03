Return-Path: <cgroups+bounces-9667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0DB42552
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778E66847EA
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7F267F59;
	Wed,  3 Sep 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jgprmKA2"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A6257422;
	Wed,  3 Sep 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913027; cv=none; b=JT8PkObvCbomXxF7H90CdYkAQfv/iNJso3FZHWHglROx67Yhlhr07ReNzD6R7uL+qGotNdveN27lWc6o5vq/2m9rIYpOPSZwlSdFRhTnpb8/xv2itIei9vNxf+lLaQ4c1bNWieP/3TrRsHq19CqvaXL0N+At1wQFQ9A6RYS4Qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913027; c=relaxed/simple;
	bh=HuiYwLQP3w/NO8/uausYKeVg+nScJ4oWQxo4LwGuHe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAHssFr9bg0WiPzoMe4U9p2FeC+rbTrY5C8HKvib7Fgp1sBNimI0PJj/ZhrhKRkYvWc+KTEsF/eLT7JyL4SBiTaCJylBQ+Hh8xHsIVUXoISMcaYOjR9Mmk3sei7aCXvtWGDMCgFPPwTZZVJOcgiJVYDJ6R+Xz2Cay7O8BDDozzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jgprmKA2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=55BB2llQEXofSNUg7BS61EGnBIFUC2JGyZpY0uhw5bg=; b=jgprmKA2XRMym7yKEnKrh+k6gS
	gEnsEVB1oyvHgcwtCGsnk2zx7UE8O/BCIKYWdvxh9CB5Dwpws5fVaOwUKsNrAIukOvMW7Cg6P+MO0
	Aah1YRp6qtPYSgtF38CNVfXUp6S32boYnbrMcEwCkQpmZ1kcco1EPrC5Hej7bi6h1guuQ8LSXf710
	87sZTpwYvLTUXMs0SGEknFrzwpBsysnJ79HAoST6ps8KvhkUFOvFCzXYGQQkK1Mt8wn2fYh11vzOf
	EW/pom1b3wxNUwJ2S6Kud8MZ4vbcvAAvHPfQn5L3TwaajutXdK2ibPdxWKyvpq2x8WVaXOrmrF28Q
	EDa4AR1Q==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKm-006GaB-P4; Wed, 03 Sep 2025 17:23:40 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 13/21] cgroup: Add the DRM cgroup controller
Date: Wed,  3 Sep 2025 16:23:19 +0100
Message-ID: <20250903152327.66002-14-tvrtko.ursulin@igalia.com>
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

Skeleton controller without any functionality.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 include/linux/cgroup_drm.h    |  7 +++++
 include/linux/cgroup_subsys.h |  4 +++
 init/Kconfig                  |  5 +++
 kernel/cgroup/Makefile        |  1 +
 kernel/cgroup/drm.c           | 58 +++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
new file mode 100644
index 000000000000..3e51fe517791
--- /dev/null
+++ b/include/linux/cgroup_drm.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Valve Corporation */
+
+#ifndef _CGROUP_DRM_H
+#define _CGROUP_DRM_H
+
+#endif	/* _CGROUP_DRM_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 3fd0bcbf3080..2ad172c9fba2 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -69,6 +69,10 @@ SUBSYS(misc)
 SUBSYS(dmem)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+SUBSYS(drm)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index d811cad02a75..5ef9494f0866 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1200,6 +1200,11 @@ config CGROUP_DMEM
 	  As an example, it allows you to restrict VRAM usage for applications
 	  in the DRM subsystem.
 
+config CGROUP_DRM
+	bool "DRM controller"
+	help
+	  Provides the DRM subsystem controller.
+
 config CGROUP_FREEZER
 	bool "Freezer controller"
 	help
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index ede31601a363..c39799312cfd 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CPUSETS_V1) += cpuset-v1.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DMEM) += dmem.o
+obj-$(CONFIG_CGROUP_DRM) += drm.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
new file mode 100644
index 000000000000..55947a009e04
--- /dev/null
+++ b/kernel/cgroup/drm.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Valve Corporation */
+
+#include <linux/cgroup.h>
+#include <linux/cgroup_drm.h>
+#include <linux/slab.h>
+
+struct drm_cgroup_state {
+	struct cgroup_subsys_state css;
+};
+
+struct drm_root_cgroup_state {
+	struct drm_cgroup_state drmcs;
+};
+
+static struct drm_root_cgroup_state root_drmcs;
+
+static inline struct drm_cgroup_state *
+css_to_drmcs(struct cgroup_subsys_state *css)
+{
+	return container_of(css, struct drm_cgroup_state, css);
+}
+
+static void drmcs_free(struct cgroup_subsys_state *css)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	if (drmcs != &root_drmcs.drmcs)
+		kfree(drmcs);
+}
+
+static struct cgroup_subsys_state *
+drmcs_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct drm_cgroup_state *drmcs;
+
+	if (!parent_css) {
+		drmcs = &root_drmcs.drmcs;
+	} else {
+		drmcs = kzalloc(sizeof(*drmcs), GFP_KERNEL);
+		if (!drmcs)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return &drmcs->css;
+}
+
+struct cftype files[] = {
+	{ } /* Zero entry terminates. */
+};
+
+struct cgroup_subsys drm_cgrp_subsys = {
+	.css_alloc	= drmcs_alloc,
+	.css_free	= drmcs_free,
+	.early_init	= false,
+	.legacy_cftypes	= files,
+	.dfl_cftypes	= files,
+};
-- 
2.48.0



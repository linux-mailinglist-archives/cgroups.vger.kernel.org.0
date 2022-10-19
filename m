Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4F604EBC
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJSRde (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJSRdb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:33:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453131C7107;
        Wed, 19 Oct 2022 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200810; x=1697736810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=so+cW5QlleQSFpTNdeeHNSHQtjYir/C5XqB3E0TiChk=;
  b=klzOA7UXLuQcEsHxOQ0Mrdmd6tPhvmVE7pnYdSny5X6LmZqumltixeyX
   1Dd6I5PV5KSHcIzRpnowgo3wnbRjoZ9+S9qVwawWxOdWBDHZZKM1XLMJZ
   LKI6rzI7lGKdjc2HOMD41Z+JtgVfroS1b4QnxULI6VLh7HmK7H2nHeap/
   6CGUbcFCKJX0+PouJV2Qsq2SUyU8U9pRNU5NdvS5BNYV5OB4RnvQVPult
   qGj7abm/VaQdkHsvT2jRtv9oBhBdBtvpK2nmAEgfitGdZRndMg9f9RxdZ
   hXlecNxo60d1AwbdonW1vAazt5H5FguX4C/zHr8oiQEbQtDxoeCCX/HwX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474341"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204710"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204710"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:26 -0700
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
Subject: [RFC 03/17] cgroup/drm: Support cgroup priority control
Date:   Wed, 19 Oct 2022 18:32:40 +0100
Message-Id: <20221019173254.3361334-4-tvrtko.ursulin@linux.intel.com>
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

A lot of the drm drivers support a concept of a scheduling priority. Add
support for controlling it via the drm cgroup controller.

Abstract priority control range of [DRM_CGROUP_PRIORITY_MIN,
DRM_CGROUP_PRIORITY_MAX] is used and each group hierarchy adjusts it's
base level based on a priority of its parent. In terms of an example that
looks like this:

       P=-1000
          /\
         /  \
        /    \
      A=0   B=100

This results in the effective priority of a group A of -1000 and B of
-900. In other words the fact B is configured for elevated priority is
relative to the parent being a low priority and hence is only elevated in
the context of its siblings.

Implementation does not impose any further policy and leaves sensible
configuration to the system administrator.

Individual drm drivers are expected to transparently convert the drm
cgroup priority into values suitable for their capabilities.

No guarantees on effectiveness or granularity are provided by the
controller, apart the available range being chosen to be an integer and
hence allowing a generic concept of normal (zero), lower (negative values)
and higher (positive values).

Every cgroup starts with a default priority of zero.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  58 +++++++++++++
 include/linux/cgroup_drm.h              |   4 +
 kernel/cgroup/drm.c                     | 110 ++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index dc254a3cb956..0a6d97c83ea4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2398,6 +2398,64 @@ HugeTLB Interface Files
         hugetlb pages of <hugepagesize> in this cgroup.  Only active in
         use hugetlb pages are included.  The per-node values are in bytes.
 
+DRM
+---
+
+The DRM controller allows configuring static hierarchical scheduling priority.
+
+DRM static priority control
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Static priority control exposes a hierarchical control interface for the
+scheduling priority support present in many DRM device drivers.
+
+Hierarchical meaning that the child group priorities are relative to their
+parent. As an example:
+
+	A=-1000
+	   /\
+	  /  \
+	 /    \
+	B=0   C=100
+
+This results in the effective priority of a group B of -1000 and C of -900. In
+other words the fact C is configured for elevated priority is relative to its
+parent being a low priority and hence is only elevated in the context of its
+siblings.
+
+The scope of individual DRM scheduling priority may be per device or per device
+driver, or a combination of both, depending on the implementation. The
+controller does not ensure any priority ordering across multiple DRM drivers nor
+does it impose any further policy and leaves desired configuration to the system
+administrator.
+
+Individual DRM drivers are required to transparently convert the cgroup priority
+into values suitable for their capabilities.
+
+No guarantees on effectiveness or granularity are provided by the controller,
+apart the available range being chosen to be an integer and hence allowing a
+generic concept of normal (zero), lower (negative values) and higher (positive
+values) priority.
+
+DRM static priority interface files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+  drm.priority_levels
+	One of:
+	 1) And integer representing the minimum number of discrete priority
+	    levels for the whole group.
+	 2) '0'- indicating one or more DRM clients in the group has no support
+	    for static priority control.
+	 3) 'n/a' - when there are no DRM clients in the configured group.
+
+  drm.priority
+	A read-write integer between -10000 and 10000 (inclusive) representing
+	an abstract static priority level.
+
+  drm.effective_priority
+	Read only integer showing the current effective priority level for the
+	group. Effective meaning taking into account the chain of inherited
+
 Misc
 ----
 
diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
index bf8abc6b8ebf..a59792ccb550 100644
--- a/include/linux/cgroup_drm.h
+++ b/include/linux/cgroup_drm.h
@@ -6,4 +6,8 @@
 #ifndef _CGROUP_DRM_H
 #define _CGROUP_DRM_H
 
+#define DRM_CGROUP_PRIORITY_MIN	(-10000)
+#define DRM_CGROUP_PRIORITY_DEF	(0)
+#define DRM_CGROUP_PRIORITY_MAX	(10000)
+
 #endif	/* _CGROUP_DRM_H */
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index b88c93661df3..2350e1f8a48a 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -6,24 +6,117 @@
 #include <linux/slab.h>
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
+
+	int priority;
+	int effective_priority;
 };
 
+static DEFINE_MUTEX(drmcg_mutex);
+
 static inline struct drm_cgroup_state *
 css_to_drmcs(struct cgroup_subsys_state *css)
 {
 	return container_of(css, struct drm_cgroup_state, css);
 }
 
+static int drmcs_show_priority_levels(struct seq_file *sf, void *v)
+{
+	seq_printf(sf, "%u\n", 0);
+
+	return 0;
+}
+
+static s64
+drmcs_read_effective_priority(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	return drmcs->effective_priority;
+}
+
+static s64
+drmcs_read_priority(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	return drmcs->priority;
+}
+
+static void update_priority(struct drm_cgroup_state *drmcs, int priority)
+{
+	struct cgroup_subsys_state *node;
+
+	lockdep_assert_held(&drmcg_mutex);
+
+	if (priority == drmcs->priority)
+		return;
+
+	drmcs->priority = priority;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(node, &drmcs->css) {
+		struct drm_cgroup_state *dnode = css_to_drmcs(node);
+		int pprio;
+
+		if (!node->parent)
+			pprio = DRM_CGROUP_PRIORITY_DEF;
+		else
+			pprio = css_to_drmcs(node->parent)->effective_priority;
+
+		dnode->effective_priority =
+			clamp(pprio + dnode->priority,
+			      DRM_CGROUP_PRIORITY_MIN,
+			      DRM_CGROUP_PRIORITY_MAX);
+	}
+	rcu_read_unlock();
+}
+
+static int
+drmcs_write_priority(struct cgroup_subsys_state *css, struct cftype *cftype,
+		     s64 priority)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+	int ret;
+
+	if (priority < (s64)DRM_CGROUP_PRIORITY_MIN ||
+	    priority > (s64)DRM_CGROUP_PRIORITY_MAX)
+		return -ERANGE;
+
+	ret = mutex_lock_interruptible(&drmcg_mutex);
+	if (ret)
+		return ret;
+	update_priority(drmcs, (int)priority);
+	mutex_unlock(&drmcg_mutex);
+
+	return 0;
+}
+
+static int drmcs_online(struct cgroup_subsys_state *css)
+{
+	struct drm_cgroup_state *drmcs = css_to_drmcs(css);
+
+	mutex_lock(&drmcg_mutex);
+	update_priority(drmcs, DRM_CGROUP_PRIORITY_DEF);
+	mutex_unlock(&drmcg_mutex);
+
+	return 0;
+}
+
 static void drmcs_free(struct cgroup_subsys_state *css)
 {
 	kfree(css_to_drmcs(css));
 }
 
 static struct drm_cgroup_state root_drmcs = {
+	.priority = DRM_CGROUP_PRIORITY_DEF,
+	.effective_priority = DRM_CGROUP_PRIORITY_DEF,
 };
 
 static struct cgroup_subsys_state *
@@ -42,12 +135,29 @@ drmcs_alloc(struct cgroup_subsys_state *parent_css)
 }
 
 struct cftype files[] = {
+	{
+		.name = "priority_levels",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = drmcs_show_priority_levels,
+	},
+	{
+		.name = "priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = drmcs_read_priority,
+		.write_s64 = drmcs_write_priority,
+	},
+	{
+		.name = "effective_priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = drmcs_read_effective_priority,
+	},
 	{ } /* Zero entry terminates. */
 };
 
 struct cgroup_subsys drm_cgrp_subsys = {
 	.css_alloc	= drmcs_alloc,
 	.css_free	= drmcs_free,
+	.css_online	= drmcs_online,
 	.early_init	= false,
 	.legacy_cftypes	= files,
 	.dfl_cftypes	= files,
-- 
2.34.1


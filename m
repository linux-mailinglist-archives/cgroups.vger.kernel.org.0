Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C975071D
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjGLLvl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjGLLvS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:51:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262722112;
        Wed, 12 Jul 2023 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162586; x=1720698586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WXN4FLVczjMv+OSBCgeCCf8yaCiNzhpa/fJPOfZ06Q=;
  b=HWbKg+yy/fk+AsuX839Cylwnia05wmMVppcqWav8+GKjHM6XRaVl04Et
   8Uy8FllHkE+dzpTlq5X9M36IRX4ENxYjxJJbl8VRykS5jvsZCJAoF2TNc
   7WvMTNqPBBKgKQ/Q/shBiQOGLJQ/DRdOSfKOQhsyo3QGH9DzMQwnUaB/m
   nYVdFRNUw9JYFZdl4HDFYauOY7LPGaIXKP1aCkAMK9cD9+k1HuAJb9XXn
   AdXwLYgjuqPFrUvocJkSMQ0NTLXJswLaROiivfx5AdAnZd0XRap2jtmyt
   sZoebDKRXESeTfLL5I/axo9RIR4YT/91O0XmSLm7KJUUJz+pwowD3MM6Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469417"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094179"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094179"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:47:13 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [PATCH 16/17] cgroup/drm: Expose memory stats
Date:   Wed, 12 Jul 2023 12:46:04 +0100
Message-Id: <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

With a few DRM drivers exposing per client memory stats via the fdinfo
interface already, we can add support for exposing the same data (albeit
aggregated for cgroup hierarchies) via the drm cgroup controller.

Add some driver callbacks and controller code to use them, walking the
sub-tree, collating the numbers, and presenting them in a new field
name drm.memory.stat.

Example file content:

  $ cat drm.memory.stat
  card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
  card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0

Data is generated on demand for simplicty of implementation ie. no running
totals are kept or accounted during migrations and such. Various
optimisations such as cheaper collection of data are possible but
deliberately left out for now.

Overall, the feature is deemed to be useful to container orchestration
software (and manual management).

Limits, either soft or hard, are not envisaged to be implemented on top of
this approach due on demand nature of collecting the stats.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  22 ++++
 include/drm/drm_drv.h                   |  61 ++++++++++
 kernel/cgroup/drm.c                     | 149 ++++++++++++++++++++++++
 3 files changed, 232 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index bbe986366f4a..1891c7d98206 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2452,6 +2452,28 @@ DRM scheduling soft limits interface files
 	Standard cgroup weight based control [1, 10000] used to configure the
 	relative distributing of GPU time between the sibling groups.
 
+  drm.memory.stat
+	A nested file containing cumulative memory statistics for the whole
+	sub-hierarchy, broken down into separate GPUs and separate memory
+	regions supported by the latter.
+
+	For example::
+
+	  $ cat drm.memory.stat
+	  card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
+	  card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0
+
+	Card designation corresponds to the DRM device names and multiple line
+	entries can be present per card.
+
+	Memory region names should be expected to be driver specific with the
+	exception of 'system' which is standardised and applicable for GPUs
+	which can operate on system memory buffers.
+
+	Sub-keys 'resident' and 'purgeable' are optional.
+
+	Per category region usage is reported in bytes.
+
 Misc
 ----
 
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 29e11a87bf75..2ea9a46b5031 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -41,6 +41,7 @@ struct drm_minor;
 struct dma_buf;
 struct dma_buf_attachment;
 struct drm_display_mode;
+struct drm_memory_stats;
 struct drm_mode_create_dumb;
 struct drm_printer;
 struct sg_table;
@@ -175,6 +176,66 @@ struct drm_cgroup_ops {
 	 * messages sent by the DRM cgroup controller.
 	 */
 	int (*signal_budget) (struct drm_file *, u64 used, u64 budget);
+
+
+	/**
+	 * @num_memory_regions:
+	 *
+	 * Optional callback reporting the number of memory regions driver
+	 * supports.
+	 *
+	 * Callback is allowed to report a larger number than present memory
+	 * regions, but @memory_region_name is then supposed to return NULL for
+	 * those indices.
+	 *
+	 * Used by the DRM core when queried by the DRM cgroup controller.
+	 *
+	 * All three callbacks of @num_memory_regions, @memory_region_name and
+	 * @memory_stats need to be implemented for DRM cgroup memory stats
+	 * support.
+	 */
+	unsigned int (*num_memory_regions) (const struct drm_device *);
+
+	/**
+	 * @memory_region_name:
+	 *
+	 * Optional callback reporting the name of the queried memory region.
+	 *
+	 * Can be NULL if the memory region index is not supported by the
+	 * passed in device.
+	 *
+	 * Used by the DRM core when queried by the DRM cgroup controller.
+	 *
+	 * All three callbacks of @num_memory_regions, @memory_region_name and
+	 * @memory_stats need to be implemented for DRM cgroup memory stats
+	 * support.
+	 */
+	const char * (*memory_region_name) (const struct drm_device *,
+					    unsigned int index);
+
+	/**
+	 * memory_stats:
+	 *
+	 * Optional callback adding to the passed in array of struct
+	 * drm_memory_stats objects.
+	 *
+	 * Number of objects in the array is passed in the @num argument.
+	 *
+	 * Returns a bitmask of supported enum drm_gem_object_status by the
+	 * driver instance.
+	 *
+	 * Callback is only allow to add to the existing fields and should
+	 * never clear them.
+	 *
+	 * Used by the DRM core when queried by the DRM cgroup controller.
+	 *
+	 * All three callbacks of @num_memory_regions, @memory_region_name and
+	 * @memory_stats need to be implemented for DRM cgroup memory stats
+	 * support.
+	 */
+	unsigned int (*memory_stats) (struct drm_file *,
+				      struct drm_memory_stats *,
+				      unsigned int num);
 };
 
 /**
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 7c20d4ebc634..22fc180dd659 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -5,6 +5,7 @@
 
 #include <linux/cgroup.h>
 #include <linux/cgroup_drm.h>
+#include <linux/device.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
@@ -12,6 +13,8 @@
 #include <linux/slab.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 
 struct drm_cgroup_state {
 	struct cgroup_subsys_state css;
@@ -133,6 +136,147 @@ drmcs_read_total_us(struct cgroup_subsys_state *css, struct cftype *cft)
 	return val;
 }
 
+struct drmcs_stat {
+	const struct drm_device *dev;
+	const struct drm_cgroup_ops *cg_ops;
+	const char *device_name;
+	unsigned int regions;
+	enum drm_gem_object_status flags;
+	struct drm_memory_stats *stats;
+};
+
+static int drmcs_seq_show_memory(struct seq_file *sf, void *v)
+{
+	struct cgroup_subsys_state *node;
+	struct drmcs_stat *stats = NULL;
+	unsigned int num_devices, i;
+	int ret;
+
+	/*
+	 * We could avoid taking the cgroup_lock and just walk the tree under
+	 * RCU but then allocating temporary storage becomes a problem. So for
+	 * now keep it simple and take the lock.
+	 */
+	cgroup_lock();
+
+	/* Protect against client migrations and clients disappearing. */
+	ret = mutex_lock_interruptible(&drmcg_mutex);
+	if (ret) {
+		cgroup_unlock();
+		return ret;
+	}
+
+	num_devices = 0;
+	css_for_each_descendant_pre(node, seq_css(sf)) {
+		struct drm_cgroup_state *drmcs = css_to_drmcs(node);
+		struct drm_file *fpriv;
+
+		list_for_each_entry(fpriv, &drmcs->clients, clink) {
+			const struct drm_cgroup_ops *cg_ops =
+				fpriv->minor->dev->driver->cg_ops;
+			const char *device_name = dev_name(fpriv->minor->kdev);
+			struct drmcs_stat *stat;
+			unsigned int regions;
+
+			/* Does this driver supports memory stats? */
+			if (cg_ops &&
+			    cg_ops->num_memory_regions &&
+			    cg_ops->memory_region_name &&
+			    cg_ops->memory_stats)
+				regions =
+				  cg_ops->num_memory_regions(fpriv->minor->dev);
+			else
+				regions = 0;
+
+			if (!regions)
+				continue;
+
+			/* Have we seen this device before? */
+			stat = NULL;
+			for (i = 0; i < num_devices; i++) {
+				if (!strcmp(stats[i].device_name,
+					    device_name)) {
+					stat = &stats[i];
+					break;
+				}
+			}
+
+			/* If not allocate space for it. */
+			if (!stat) {
+				stats = krealloc_array(stats, num_devices + 1,
+						       sizeof(*stats),
+						       GFP_USER);
+				if (!stats) {
+					ret = -ENOMEM;
+					goto out;
+				}
+
+				stat = &stats[num_devices++];
+				stat->dev = fpriv->minor->dev;
+				stat->cg_ops = cg_ops;
+				stat->device_name = device_name;
+				stat->flags = 0;
+				stat->regions = regions;
+				stat->stats =
+					kcalloc(regions,
+						sizeof(struct drm_memory_stats),
+						GFP_USER);
+				if (!stat->stats) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+
+			/* Accumulate the stats for this device+client. */
+			stat->flags |= cg_ops->memory_stats(fpriv,
+							    stat->stats,
+							    stat->regions);
+		}
+	}
+
+	for (i = 0; i < num_devices; i++) {
+		struct drmcs_stat *stat = &stats[i];
+		unsigned int j;
+
+		for (j = 0; j < stat->regions; j++) {
+			const char *name =
+				stat->cg_ops->memory_region_name(stat->dev, j);
+
+			if (!name)
+				continue;
+
+			seq_printf(sf,
+				   "%s region=%s total=%llu shared=%llu active=%llu",
+				   stat->device_name,
+				   name,
+				   stat->stats[j].private +
+				   stat->stats[j].shared,
+				   stat->stats[j].shared,
+				   stat->stats[j].active);
+
+			if (stat->flags & DRM_GEM_OBJECT_RESIDENT)
+				seq_printf(sf, " resident=%llu",
+					   stat->stats[j].resident);
+
+			if (stat->flags & DRM_GEM_OBJECT_PURGEABLE)
+				seq_printf(sf, " purgeable=%llu",
+					   stat->stats[j].purgeable);
+
+			seq_puts(sf, "\n");
+		}
+	}
+
+out:
+	mutex_unlock(&drmcg_mutex);
+	cgroup_unlock();
+
+	for (i = 0; i < num_devices; i++)
+		kfree(stats[i].stats);
+	kfree(stats);
+
+	return ret;
+}
+
 static bool __start_scanning(unsigned int period_us)
 {
 	struct drm_cgroup_state *root = &root_drmcs.drmcs;
@@ -575,6 +719,11 @@ struct cftype files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = drmcs_read_total_us,
 	},
+	{
+		.name = "memory.stat",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = drmcs_seq_show_memory,
+	},
 	{ } /* Zero entry terminates. */
 };
 
-- 
2.39.2


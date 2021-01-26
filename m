Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB97A304F67
	for <lists+cgroups@lfdr.de>; Wed, 27 Jan 2021 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhA0DJr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jan 2021 22:09:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:28863 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhAZVrN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 26 Jan 2021 16:47:13 -0500
IronPort-SDR: c/JvpQYuHSN2whmZqEkui3Srnr6dMtn36BoVUYu6Ovs2+DSyza3R1SxD2njWsUuPbJjt2Vm6cS
 5BbYj0sa7W+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056565"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:44:37 -0800
IronPort-SDR: pdeKR/xjdpNl2KwR8XT6CRTsjZqfBTuYkjMrDL/Jrs5DbJUnwWYjD7mizYUvmzpwEqsIk3YlZL
 tKEP+ihW4vJw==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362139899"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Jan 2021 13:44:37 -0800
From:   Brian Welty <brian.welty@intel.com>
To:     Brian Welty <brian.welty@intel.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [RFC PATCH 6/9] drmcg: Add memory.total file
Date:   Tue, 26 Jan 2021 13:46:23 -0800
Message-Id: <20210126214626.16260-7-brian.welty@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126214626.16260-1-brian.welty@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Following control is introduced in order to display total memory that
exists for the DRM device. DRM drivers can advertise this value by
writing to drm_device.drmcg_props. This is needed in order to effectively
use the other memory controls.
Normally for system memory this is available to the user using procfs.

   memory.total
      Read-only value, displays total memory for a device, shown
      only in root cgroup.

Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 include/drm/drm_cgroup.h                |  2 ++
 kernel/cgroup/drm.c                     | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 405912710b3a..ccc25f03a898 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2189,6 +2189,10 @@ MEM controller.  All memory amounts are in bytes.
         DRM device memory.  If memory usage reaches this limit,
         subsequent device memory allocations will fail.
 
+  memory.total
+        Read-only value, displays total memory for a device, shown only in
+        root cgroup.
+
 While some DRM devices may be capable to present multiple memory segments
 to the user, the intent with above controls is to aggregate all user
 allocatable backing store.  Any support for multiple memory segments is
diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
index 8b4c4e798b11..9ba0e372eeee 100644
--- a/include/drm/drm_cgroup.h
+++ b/include/drm/drm_cgroup.h
@@ -15,11 +15,13 @@ struct drmcg;
  * of storing per device defaults
  */
 struct drmcg_props {
+	u64 memory_total;
 };
 
 enum drmcg_res_type {
 	DRMCG_TYPE_MEM_CURRENT,
 	DRMCG_TYPE_MEM_MAX,
+	DRMCG_TYPE_MEM_TOTAL,
 	__DRMCG_TYPE_LAST,
 };
 
diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index bec41f343208..08e75eb67593 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -283,6 +283,10 @@ static int drmcg_seq_show_fn(int id, void *ptr, void *data)
 		else
 			seq_printf(sf, "%ld\n", ddr->memory.max * PAGE_SIZE);
 		break;
+	case DRMCG_TYPE_MEM_TOTAL:
+		seq_printf(sf, "%d:%d %llu\n", DRM_MAJOR, minor->index,
+			   minor->dev->drmcg_props.memory_total);
+		break;
 	default:
 		seq_printf(sf, "%d:%d\n", DRM_MAJOR, minor->index);
 		break;
@@ -374,6 +378,12 @@ struct cftype files[] = {
 		.private = DRMCG_TYPE_MEM_MAX,
 		.flags = CFTYPE_NOT_ON_ROOT
 	},
+	{
+		.name = "memory.total",
+		.seq_show = drmcg_seq_show,
+		.private = DRMCG_TYPE_MEM_TOTAL,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.20.1


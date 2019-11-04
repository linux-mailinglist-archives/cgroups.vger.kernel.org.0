Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D7EEE56
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 23:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbfKDWIT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 17:08:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:15142 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390208AbfKDWIS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 4 Nov 2019 17:08:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 14:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="376477739"
Received: from nperf12.hd.intel.com ([10.127.88.161])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2019 14:08:16 -0800
From:   Brian Welty <brian.welty@intel.com>
To:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [RFC PATCH] cgroup: Document interface files and rationale for DRM controller
Date:   Mon,  4 Nov 2019 17:08:47 -0500
Message-Id: <20191104220847.23283-1-brian.welty@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Here is one proposal for a set of interface files to be implemented in
in a new DRM controller.  This is an alternate set of interface files
than in the current v4 of DRM controller [1].  As there was not a clear
consensus on the interface files and associated controls, it seems worth
again considering if we should have a set of controls more consistent
in functionality with what existing CPU and MEM controllers provide.

This is in some respects a follow-up to my prior RFC series [2] where
I attempted to implement per-device controls within existing cgroup
subsystems.

The basic goal of that design was to reuse well known controls. Instead
we can achieve that same goal, but by simply having the proposed DRM
controller implement those same interface files with identical name.
The intent being that equivalent functionality is then provided by the
underlying GPU device driver.

Here is the rationale, repeated from proposed DRM controller documention:
As an accelerator or GPU device is similar in many respects to a CPU
with (or without) attached system memory, the design principle here is
to clone existing controls from other controllers where those controls
are used for the same fundamental purpose.  For example, rather than
inventing new but similar controls for managing memory allocation and
workload isolation and scheduling, we clone (in name and as possible in
functionality) controls from following controllers: CPU, CPUSET, and MEM.
The controls found in those controllers are well understood already by
system administrators and the intent here is to provide these controls
for use with accelarator and GPU devices via the DRM controller.

RFC note:
In fact, to make the above point more strongly, one suggestion is to
rename this cgroup controller as XPU instead of the current DRM.
This makes it clear this is not GPU-specific and no reason to make this
restricted to drivers under drivers/gpu/drm/.

[1] https://lists.freedesktop.org/archives/dri-devel/2019-August/233463.html
[2] https://lists.freedesktop.org/archives/dri-devel/2019-May/216373.html

Signed-off-by: Brian Welty <brian.welty@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5361ebec3361..2a713059ccbd 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2050,6 +2050,95 @@ RDMA Interface Files
 	  mlx4_0 hca_handle=1 hca_object=20
 	  ocrdma1 hca_handle=1 hca_object=23
 
+DRM
+----
+
+The "drm" controller regulates the distribution and accounting of
+resources within a GPU device (or other similar accelerator device), but
+only those controlled by device drivers under drivers/gpu/drm/ and thus
+which register with DRM.
+
+As an accelerator or GPU device is similar in many respects to a CPU
+with (or without) attached system memory, the design principle here is
+to clone existing controls from other controllers where those controls
+are used for the same fundamental purpose.  For example, rather than
+inventing new but similar controls for managing memory allocation and
+workload isolation and scheduling, we clone (in name and as possible in
+functionality) controls from following controllers: CPU, CPUSET, and MEM.
+The controls found in those controllers are well understood already by
+system administrators and the intent here is to provide these controls
+for use with accelarator and GPU devices via the DRM controller.
+
+RFC note:
+In fact, to make the above point more strongly, one suggestion is to
+rename this cgroup controller as XPU instead of the current DRM.
+This makes it clear this is not GPU-specific and no reason to make this
+restricted to drivers under drivers/gpu/drm/.
+
+DRM Interface Files
+~~~~~~~~~~~~~~~~~~~
+
+DRM controller supports usage of multiple DRM devices within a cgroup.
+As such, for all interface files, output is keyed by device name and is
+not ordered.
+
+The first set of control files are intended to clone functionality from
+CPUSETs and thus provide a mechanism for assigning a set of workload
+execution units and a set of attached memories to a cgroup in order to
+provide resource isolation.  The term 'workload execution unit' is
+unrealistic to have a common underlying hardware implementation across
+all devices.  The intent is to represent the available set of hardware
+resources that provides scheduling and/or partitioning of workloads, by
+which potentially this maps to 'GPU cores' or to 'hardware engines'.
+
+  gpuset.units
+  gpuset.units.effective
+  gpuset.units.partition
+
+  gpuset.mems
+  gpuset.mems.effective
+  gpuset.mems.partition
+
+[As this is an RFC, each control above is not yet described.  For now,
+please refer to CPUSET interface file documentation as these are intended
+to provide equivalent functionality.]
+
+The next set of control files are intended to clone functionality from
+CPU controller and thus provide a mechanism to influence workload
+scheduling.
+
+  sched.max
+  sched.stats
+  sched.weight
+  sched.weight.nice
+
+[As this is an RFC, each control above is not yet described.  For now,
+please refer to CPU interface file documentation as these are intended
+to provide equivalent functionality.]
+
+The next set of control files are intended to clone functionality from
+the MEM controller and thus provide a mechanism for regulating allocation
+and accounting of attached memory.  All memory amounts are in bytes.
+
+  memory.current
+  memory.events
+  memory.high
+  memory.low
+  memory.max
+  memory.min
+  memory.stat
+  memory.swap.current
+  memory.swap.max
+
+Potentially, with substantial justifciation, the above can be expanded
+in the future with new memory.xxx.yyy set of controls for additional
+memory 'types' or 'placement regions' that are unique from each other
+and warrant separate controls, (such as memory.swap.yyy).
+
+[As this is an RFC, each control above is not yet described.  For now,
+please refer to MEM interface file documentation as these are intended
+to provide equivalent functionality.]
+
 
 Misc
 ----
-- 
2.21.0


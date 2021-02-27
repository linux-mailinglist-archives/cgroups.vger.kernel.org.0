Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4932714B
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhB1Gnd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:43:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhB1GnT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:43:19 -0500
IronPort-SDR: QO4xzewiJk5svwr3GD5XziLOu48NaW7ZEQPRN02k7N42+iGCOYoiApqLfBubcd26VEH6XjK6Fx
 8AKVEfR6q8Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323913"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: +T9STUHvLgHVslt36fIQ9N1GTV3VmJPU6OiRU8iSdNDzlrfPpN5eh7OC/N9+5nDbwaEX2Eb53X
 +8ZVL72C19YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029746"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH 17/18] docs: cgroup-v1: Add IOASIDs controller
Date:   Sat, 27 Feb 2021 14:01:25 -0800
Message-Id: <1614463286-97618-18-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/admin-guide/cgroup-v1/index.rst |   1 +
 .../admin-guide/cgroup-v1/ioasids.rst         | 110 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/admin-guide/cgroup-v1/ioasids.rst

diff --git a/Documentation/admin-guide/cgroup-v1/index.rst b/Documentation/admin-guide/cgroup-v1/index.rst
index 226f64473e8e..f5e307dc4dbb 100644
--- a/Documentation/admin-guide/cgroup-v1/index.rst
+++ b/Documentation/admin-guide/cgroup-v1/index.rst
@@ -15,6 +15,7 @@ Control Groups version 1
     devices
     freezer-subsystem
     hugetlb
+    ioasids
     memcg_test
     memory
     net_cls
diff --git a/Documentation/admin-guide/cgroup-v1/ioasids.rst b/Documentation/admin-guide/cgroup-v1/ioasids.rst
new file mode 100644
index 000000000000..b30eb41bf1be
--- /dev/null
+++ b/Documentation/admin-guide/cgroup-v1/ioasids.rst
@@ -0,0 +1,110 @@
+========================================
+I/O Address Space ID (IOASID) Controller
+========================================
+
+Acronyms
+--------
+PASID:
+	Process Address Space ID, defined by PCIe
+SVA:
+	Shared Virtual Address
+
+Introduction
+------------
+
+IOASIDs are used to associate DMA requests with virtual address spaces. As
+a system-wide limited¹ resource, its constraints are managed by the IOASIDs
+cgroup subsystem. The specific use cases are:
+
+1. Some user applications exhaust all the available IOASIDs thus depriving
+   others of the same host.
+
+2. System admins need to provision VMs based on their needs for IOASIDs,
+   e.g. the number of VMs with assigned devices that perform DMA requests
+   with PASID.
+
+The IOASID subsystem consists of three components:
+
+- IOASID core: provides APIs for allocation, pool management,
+  notifications and refcounting. See Documentation/driver-api/ioasid.rst
+  for details
+- IOASID user:  provides user allocation interface via /dev/ioasid
+- IOASID cgroup controller: manage resource distribution
+
+Resource Distribution Model
+---------------------------
+IOASID allocation is process-based in that IOASIDs are tied to page tables²,
+the threaded model is not supported. The allocation is rejected by the
+cgroup hierarchy once a limit is reached. However, organizational changes
+such as moving processes across cgroups are exempted. Therefore, it is
+possible to have ioasids.current > ioasids.max. It is not possible to do
+further allocation after the organizational change that exceeds the max.
+
+The system capacity of the IOASIDs is default to PCIe PASID size of 20 bits.
+IOASID core provides API to adjust the system capacity based on platforms.
+IOASIDs are used by both user applications (e.g. VMs and userspace drivers)
+and kernel (e.g. supervisor SVA). However, only user allocation is subject
+to cgroup constraints. Host kernel allocates a pool of IOASIDs where its
+quota is subtracted from the system capacity. IOASIDs cgroup consults with
+the IOASID core for available capacity when a new cgroup limit is granted.
+Upon creation, no IOASID allocation is allowed by the user processes within
+the new cgroup.
+
+Usage
+-----
+CGroup filesystem has the following IOASIDs controller specific entries:
+::
+
+ ioasids.current
+ ioasids.events
+ ioasids.max
+
+To use the IOASIDs controller, set ioasids.max to the limit of the number
+of IOASIDs that can be allocated. The file ioasids.current shows the current
+number of IOASIDs allocated within the cgroup.
+
+Example
+--------
+1. Mount the cgroup2 FS ::
+
+	$ mount -t cgroup2 none /mnt/cg2/
+
+2. Add ioasids controller ::
+
+	$ echo '+ioasids' > /mnt/cg2/cgroup.subtree_control
+
+3. Create a hierarchy, set non-zero limit (default 0) ::
+
+	$ mkdir /mnt/cg2/test1
+	$ echo 5 > /mnt/cg2/test1/ioasids.max
+
+4. Allocate IOASIDs within limit should succeed ::
+
+	$echo $$ > /mnt/cg2/test1/cgroup.procs
+	Do IOASID allocation via /dev/ioasid
+	ioasids.current:1
+	ioasids.max:5
+
+5. Attempt to allocate IOASIDs beyond limit should fail ::
+
+	ioasids.current:5
+	ioasids.max:5
+
+6. Attach a new process with IOASID already allocated to a cgroup could
+result in ioasids.current > ioasids.max, e.g. process with PID 1234 under
+a cgroup with IOASIDs controller has one IOASID allocated, moving it to
+test1 cgroup ::
+
+	$echo 1234 > /mnt/cg2/test1/cgroup.procs
+	ioasids.current:6
+	ioasids.max:5
+
+Notes
+-----
+¹ When IOASID is used for PCI Express PASID, the range is limited to the
+PASID size of 20 bits. For a device that its resources can be shared across
+the platform, the IOASID namespace must be system-wide in order to uniquely
+identify DMA request with PASID inside the device.
+
+² The primary use case is SVA, where CPU page tables are shared with DMA via
+IOMMU.
-- 
2.25.1


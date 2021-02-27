Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E9327131
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhB1Ggo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:36:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:22647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhB1Ggl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:36:41 -0500
IronPort-SDR: W6i+64Snm/OwLz22+VlyE39qls7K9RFZ+NdFd+YCWwTDSkEsFw87/xbQU3Uui2n8spL5kisknd
 dQ8314+N6AxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323891"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: zSBJxdwQZHoVezvXYEeout6/nD544xO1VQhICbjae1zditmZikHAouc4meKPjvOYojqXrUKKsp
 ejANQKMuy2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029695"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
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
Subject: [PATCH V4 00/18] IOASID extensions for guest SVA
Date:   Sat, 27 Feb 2021 14:01:08 -0800
Message-Id: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I/O Address Space ID (IOASID) core code was introduced in v5.5 as a generic
kernel allocator service for both PCIe Process Address Space ID (PASID) and
ARM SMMU's Substream ID. IOASIDs are used to associate DMA requests with
virtual address spaces, including both host and guest.

In addition to providing basic ID allocation, ioasid_set was defined as a
token that is shared by a group of IOASIDs. This set token can be used
for permission checking, but lack some features to address the following
needs by guest Shared Virtual Address (SVA).
- Manage IOASIDs by group, group ownership, quota, etc.
- State synchronization among IOASID users (e.g. IOMMU driver, KVM, device
drivers)
- Non-identity guest-host IOASID mapping
- Lifecycle management

This patchset introduces the following extensions as solutions to the
problems above.
- Redefine and extend IOASID set such that IOASIDs can be managed by groups/pools.
- Add notifications for IOASID state synchronization
- Extend reference counting for life cycle alignment among multiple users
- Support ioasid_set private IDs, which can be used as guest IOASIDs
- Add a new cgroup controller for resource distribution

Please refer to Documentation/admin-guide/cgroup-v1/ioasids.rst and
Documentation/driver-api/ioasid.rst in the enclosed patches for more
details.

Based on discussions on LKML[1], a direction change was made in v4 such that
the user interfaces for IOASID allocation are extracted from VFIO
subsystem. The proposed IOASID subsystem now consists of three components:
1. IOASID core[01-14]: provides APIs for allocation, pool management,
  notifications, and refcounting.
2. IOASID cgroup controller[RFC 15-17]: manage resource distribution[2].
3. IOASID user[RFC 18]:  provides user allocation interface via /dev/ioasid 

This patchset only included VT-d driver as users of some of the new APIs.
VFIO and KVM patches are coming up to fully utilize the APIs introduced here.

[1] https://lore.kernel.org/linux-iommu/1599734733-6431-1-git-send-email-yi.l.liu@intel.com/
[2] Note that ioasid quota management code can be removed once the IOASIDs
cgroup is ratified.

You can find this series, VFIO, KVM, and IOASID user at:
https://github.com/jacobpan/linux.git ioasid_v4
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog:

v4
- Introduced IOASIDs cgroup controller
- Introduced /dev/ioasid user API for allocation/free
- Added IOASID states and free function, aligned refcounting on v5.11
  introduced by Jean.
- Support iommu-sva-lib (will converge VT-d code afterward)
- Added a shared ordered workqueue for notification work that requires
  thread context. Streamlined notification framework among multiple IOASID
  users.
- Added ioasid_set helper functions for taking per set operations

V3:
- Use consistent ioasid_set_ prefix for ioasid_set level APIs
- Make SPID and private detach/attach APIs symmetric
- Use the same ioasid_put semantics as Jean-Phillippe IOASID reference patch
- Take away the public ioasid_notify() function, notifications are now emitted
  by IOASID core as a result of certain IOASID APIs
- Partition into finer incremental patches
- Miscellaneous cleanup, locking, exception handling fixes based on v2 reviews

V2:
- Redesigned ioasid_set APIs, removed set ID
- Added set private ID (SPID) for guest PASID usage.
- Add per ioasid_set notification and priority support.
- Back to use spinlocks and atomic notifications.
- Added async work in VT-d driver to perform teardown outside atomic context


Jacob Pan (17):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Add a separate function for detach data
  iommu/ioasid: Support setting system-wide capacity
  iommu/ioasid: Redefine IOASID set and allocation APIs
  iommu/ioasid: Add free function and states
  iommu/ioasid: Add ioasid_set iterator helper functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/ioasid: Support mm token type ioasid_set notifications
  iommu/ioasid: Add ownership check in guest bind
  iommu/vt-d: Remove mm reference for guest SVA
  iommu/ioasid: Add a workqueue for cleanup work
  iommu/vt-d: Listen to IOASID notifications
  cgroup: Introduce ioasids controller
  iommu/ioasid: Consult IOASIDs cgroup for allocation
  docs: cgroup-v1: Add IOASIDs controller

Liu Yi L (1):
  ioasid: Add /dev/ioasid for userspace

 Documentation/admin-guide/cgroup-v1/index.rst |   1 +
 .../admin-guide/cgroup-v1/ioasids.rst         | 107 ++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/ioasid.rst           | 510 +++++++++
 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/ioasid.rst        |  49 +
 drivers/iommu/Kconfig                         |   5 +
 drivers/iommu/Makefile                        |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   1 +
 drivers/iommu/intel/Kconfig                   |   1 +
 drivers/iommu/intel/iommu.c                   |  32 +-
 drivers/iommu/intel/pasid.h                   |   1 +
 drivers/iommu/intel/svm.c                     | 145 ++-
 drivers/iommu/ioasid.c                        | 983 +++++++++++++++++-
 drivers/iommu/ioasid_user.c                   | 297 ++++++
 drivers/iommu/iommu-sva-lib.c                 |  19 +-
 drivers/iommu/iommu.c                         |  16 +-
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/intel-iommu.h                   |   2 +
 include/linux/ioasid.h                        | 256 ++++-
 include/linux/miscdevice.h                    |   1 +
 include/uapi/linux/ioasid.h                   |  98 ++
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/ioasids.c                       | 345 ++++++
 25 files changed, 2794 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/admin-guide/cgroup-v1/ioasids.rst
 create mode 100644 Documentation/driver-api/ioasid.rst
 create mode 100644 Documentation/userspace-api/ioasid.rst
 create mode 100644 drivers/iommu/ioasid_user.c
 create mode 100644 include/uapi/linux/ioasid.h
 create mode 100644 kernel/cgroup/ioasids.c

-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB532712D
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhB1GgW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:36:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:58906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhB1GgR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:36:17 -0500
IronPort-SDR: Ekm0uY9IRW3tZlvAwP5aHdkycw3BNmrs4+iI/ImZ6I2hbZmeMOhIPdWGjxej7ZkF3yMifL+4x3
 eBi1QttHpmEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323892"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: jsNOyT7QMIz0ZuXZh7tFfksP+Bp2QdUH3k8ISyKop50HKE2zIlaqHZahAwEQdW7cNI24iEUzvT
 Pi2CNVNUXk/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029698"
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH V4 01/18] docs: Document IO Address Space ID (IOASID) APIs
Date:   Sat, 27 Feb 2021 14:01:09 -0800
Message-Id: <1614463286-97618-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

IOASID is used to identify address spaces that can be targeted by device
DMA. It is a system-wide resource that is essential to its many users.
This document is an attempt to help developers from all vendors navigate
the APIs. At this time, ARM SMMU and Intel’s Scalable IO Virtualization
(SIOV) enabled platforms are the primary users of IOASID. Examples of
how SIOV components interact with the IOASID APIs are provided.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/driver-api/index.rst  |   1 +
 Documentation/driver-api/ioasid.rst | 510 ++++++++++++++++++++++++++++
 2 files changed, 511 insertions(+)
 create mode 100644 Documentation/driver-api/ioasid.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 2456d0a97ed8..baeec308cf2c 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -37,6 +37,7 @@ available subsections can be seen below.
    pci/index
    spi
    i2c
+   ioasid
    ipmb
    ipmi
    i3c/index
diff --git a/Documentation/driver-api/ioasid.rst b/Documentation/driver-api/ioasid.rst
new file mode 100644
index 000000000000..f3ed5bf43fa6
--- /dev/null
+++ b/Documentation/driver-api/ioasid.rst
@@ -0,0 +1,510 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. ioasid:
+
+=====================
+ IO Address Space ID
+=====================
+
+IOASIDs are used to identify virtual address spaces that DMA requests can
+target. It is a generic name for PCIe Process Address ID (PASID) or
+SubstreamID defined by ARM's SMMU.
+
+The primary use cases for IOASIDs are Shared Virtual Address (SVA) and
+IO Virtual Address (IOVA) when multiple address spaces per device are
+desired. Due to hardware architectural differences the requirements for
+IOASID management can vary in terms of namespace, state management, and
+virtualization usages.
+
+The IOASID subsystem consists of three components:
+
+- IOASID core: provides APIs for allocation, pool management,
+  notifications and refcounting.
+- IOASID user:  provides user allocation interface via /dev/ioasid
+- IOASID cgroup controller: manage resource distribution.
+  (Documentation/admin-guide/cgroup-v1/ioasids.rst)
+
+This document covers the features supported by the IOASID core APIs.
+Vendor-specific use cases are also illustrated with Intel's VT-d
+based platforms as the first example. The term PASID and IOASID are used
+interchangeably throughout this document.
+
+.. contents:: :local:
+
+Glossary
+========
+PASID - Process Address Space ID
+
+IOVA - IO Virtual Address
+
+IOASID - IO Address Space ID (generic term for PCIe PASID and
+SubstreamID in SMMU)
+
+SVA/SVM - Shared Virtual Addressing/Memory
+
+gSVA - Guest Shared Virtual Addressing
+
+gIOVA - Guest IO Virtual Addressing
+
+ENQCMD - Instruction to submit work to shared workqueues. Refer
+to "Intel X86 ISA for efficient workqueue submission" [1]
+
+DSA - Intel Data Streaming Accelerator [2]
+
+VDCM - Virtual Device Composition Module [3]
+
+SIOV - Intel Scalable IO Virtualization
+
+DWQ - Dedicated Work Queue
+
+SWQ - Shared Work Queue
+
+1. https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
+
+2. https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
+
+3. https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
+
+
+Key Concepts
+============
+
+IOASID Set
+----------
+An IOASID set is a group of IOASIDs allocated from the system-wide
+IOASID pool. Refer to section "IOASID Set Level APIs" for more details.
+
+IOASID set is particularly useful for guest SVA where each guest could
+have its own IOASID set for security and efficiency reasons.
+
+Guest IOASID
+------------------
+IOASID used by the guest, identifies a guest IOVA space or a guest VA
+space per guest process.
+
+Host IOASID
+-----------------
+IOASID used by the host either for bare metal SVA or as the backing of a
+guest IOASID.
+
+Bind/Unbind
+-----------
+Refer to the process where mappings among IOASID, page tables, and devices
+are established/demolished. This usually involes setting up an entry of
+the IOMMU's per device PASID table with a given PGD.
+
+IOASID Set Private ID (SPID)
+----------------------------
+Each IOASID set has a private namespace of SPIDs. An SPID maps to a
+single system-wide IOASID. Conversely, each IOASID may be associated
+with an alias ID, local to the IOASID set, named SPID.
+SPIDs can be used as guest IOASIDs where each guest could do
+IOASID allocation from its own pool/set and map them to host physical
+IOASIDs. SPIDs are particularly useful for supporting live migration
+where decoupling guest and host physical resources are necessary. Guest
+to Host PASID mapping can be torn down and re-established. Storing the
+mapping inside the kernel also provides lookup service.
+
+For example, two VMs can both allocate guest PASID/SPID #101 but map to
+different host PASIDs #201 and #202 respectively as shown in the
+diagram below.
+::
+
+ .------------------.    .------------------.
+ |   VM 1           |    |   VM 2           |
+ |                  |    |                  |
+ |------------------|    |------------------|
+ | GPASID/SPID 101  |    | GPASID/SPID 101  |
+ '------------------'    -------------------'     Guest
+ __________|______________________|____________________
+           |                      |               Host
+           v                      v
+ .------------------.    .------------------.
+ | Host IOASID 201  |    | Host IOASID 202  |
+ '------------------'    '------------------'
+ |   IOASID set 1   |    |   IOASID set 2   |
+ '------------------'    '------------------'
+
+Guest PASID is treated as IOASID set private ID (SPID) within an
+IOASID set, mappings between guest and host IOASIDs are stored in the
+set for inquiry.
+
+Theory of Operation
+===================
+
+States
+------
+IOASID has four states as illustrated in the diagram below.
+::
+
+   BIND/UNBIND, WQ PROG/CLEAR⁴
+   -----------------------------.
+                                |
+   ALLOC/FREE                   |
+   ------------.                |
+               |                |
+   +-------+   v    +-------+   v     +----------+
+   | FREE  |<======>| IDLE¹ |<=======>| ACTIVE²  |
+   +-------+        +-------+         +----------+
+      ^                                    |
+      |           +---------------+        |
+      '===========| FREE PENDING³ |<======='
+                  +---------------+  ^
+   FREE                              |
+   ----------------------------------'
+   ¹ Allocated but not used
+   ² Used by device drivers, IOMMU, or CPU, each user holds a reference
+   ³ Waiting for all users drop their refcount before returning IOASID
+     back to the pool
+   ⁴ Device drivers obtain refcount after programs workqueue with IOASID.
+     Release the refcount after clearing the workqueue.
+     Similarly, the IOMMU driver can also get/put IOASID refcount during
+     bind/unbind.
+
+Notifications
+-------------
+Depending on the hardware architecture, an IOASID can be programmed into
+CPU, IOMMU, or devices for DMA related activity. The synchronization among them
+is based on events notifications which follows a publisher-subscriber pattern.
+
+Events
+~~~~~~
+Notification events are pertinent to individual IOASIDs, they can be
+one of the following::
+
+ - ALLOC
+ - FREE
+ - BIND
+ - UNBIND
+
+Besides calling ioasid_notify() directly with explicit events, notifications
+can also be sent by the IOASID core as a by-product of calling the following
+APIs::
+
+ - ioasisd_free()        /* emits IOASID_FREE */
+ - ioasid_detach_spid()  /* emits IOASID_UNBIND */
+ - ioasid_attach_spid()  /* emits IOASID_BIND */
+
+Ordering
+~~~~~~~~
+Ordering of notification events is supported by the IOASID core as the
+following (from high to low)::
+
+ - CPU
+ - IOMMU
+ - DEVICE
+
+Subscribers of IOASID events are responsible for registering their
+notification blocks according to the priorities.
+
+The above order applies to all events. For example, if UNBIND event is
+issued when a guest IOASID is freed due to exceptions. All active DMA
+sources should be quiesced before tearing down other hardware contexts
+associated with the IOASID in the system. This is necessary to reduce
+the churn in handling faults. The notification order ensures that vCPU
+is stopped before IOMMU and devices. KVM x86 code registers notification
+block with priority IOASID_PRIO_CPU and VDCM code registers notification
+block with priority IOASID_PRIO_DEVICE, IOASID core ensures the CPU
+handlers are called before the DEVICE handlers.
+
+It is the caller's responsibility to avoid chained notifications in the
+atomic notification handlers. i.e. ioasid_detach_spid() cannot be called
+inside the IOASID_FREE atomic handlers due to spinlocks held by the
+caller of the notifier. However, ioasid_detach_spid() can be called from
+deferred work. See Atomicity section for details.
+
+Level Sensitivity
+~~~~~~~~~~~~~~~~~
+For each IOASID state transition, IOASID core ensures that there is
+only one notification sent. This resembles level triggered interrupt
+where a single interrupt is raised during a state transition.
+For example, if ioasid_free() is called twice by a user before the
+IOASID is reclaimed, IOASID core will only send out a single
+IOASID_NOTIFY_FREE event. Similarly, for IOASID_NOTIFY_BIND/UNBIND
+events, which is only sent out once when a SPID is attached/detached.
+
+Scopes
+~~~~~~
+There are two types of notifiers in IOASID core: system-wide and
+ioasid_set-wide (one notifier chain per ioasid_set).
+
+System-wide notifier is catering for users that need to handle all the
+IOASIDs in the system. E.g. The IOMMU driver.
+
+Per ioasid_set notifier can be used by VM specific components such as
+KVM. After all, each KVM instance only cares about IOASIDs within its
+own set/guest. The following flags are used to distinguish the scopes::
+
+ #define IOASID_NOTIFY_FLAG_ALL BIT(0)
+ #define IOASID_NOTIFY_FLAG_SET BIT(1)
+
+For example, on VT-d platform both KVM and VDCM shall register notifier
+block on the IOASID set such that *only* events from the matching VM
+are received.
+
+If KVM attempts to register a notifier block before the IOASID set is
+created using the MM token, the notifier block will be placed on a
+pending list inside IOASID core. Once the token matching IOASID set
+is created, IOASID will register the notifier block automatically.
+IOASID core does not replay events for the existing IOASIDs in the
+set. For IOASID set of MM type, notification blocks can be registered
+on empty sets only. This is to avoid lost events.
+
+IOMMU driver shall register notifier block on global chain, e.g. ::
+
+ static struct notifier_block pasid_nb_vtd = {
+	.notifier_call = pasid_status_change_vtd,
+	.priority      = IOASID_PRIO_IOMMU,
+ };
+
+Atomicity
+~~~~~~~~~
+IOASID notifiers are atomic due to spinlocks used inside the IOASID
+core. For tasks that cannot be completed in the notifier handler,
+async work to be completed in order must be submitted to the ordered
+workqueue provided by the IOASID core. This will ensure the order w.r.t.
+the work items submitted by other users of the same event.
+
+It is the caller's responsibility to avoid chained notifications in the
+atomic notification handlers. e.g. ioasid_detach_spid() cannot be called
+inside the IOASID_FREE atomic handlers due to spinlocks held by the
+caller of the notifier. However, ioasid_detach_spid() can be called from
+deferred work.
+
+Reference counting
+------------------
+IOASID life cycle management is based on reference counting. Users of
+IOASID who intend to align its context with the life cycle need to hold
+references of the IOASID. An IOASID will not be returned to the pool
+for re-allocation until all its references are dropped. Calling ioasid_free()
+will mark the IOASID as FREE_PENDING if the IOASID has outstanding
+references. No new references can be taken by ioasid_get() once an
+IOASID is in the FREE_PENDING state. ioasid_free() can be called
+multiple times without an error until all refs are dropped.
+
+ioasid_put() decrements and tests refcount of the IOASID. If refcount
+is 0, ioasid will be freed. The IOASID will be returned to the pool and
+available for new allocations. Note that ioasid_put() can be called by
+the IOASID_FREE event handler where the subscriber can drop the last
+refcount that ends the free pending state.
+
+Event notifications are used to inform users of IOASID status change.
+IOASID_FREE or UNBIND events prompt users to drop their references after
+clearing its context.
+
+For example, on VT-d platform when an IOASID is freed, teardown
+actions are performed on CPU (KVM), device driver (VDCM), and the IOMMU
+driver. To quiesce vCPU for work submission, KVM notifier handler must
+be called before VDCM handler. Therefore, KVM and VDCM shall monitor
+notification events IOASID_UNBIND.
+
+Namespaces
+----------
+IOASIDs are limited system resources that default to 20 bits in
+size. Each device can have its own PASID table for security reasons.
+Theoretically the namespace can be per device also.
+
+However IOASID namespace is system-wide for two reasons:
+- Simplicity
+- Sharing resources of a single device to multiple VMs.
+
+Take VT-d as an example, VT-d supports shared workqueue and ENQCMD[1]
+where one IOASID could be used to submit work on multiple devices that
+are shared with other VMs. This requires IOASID to be
+system-wide. This is also the reason why guests must use an
+emulated virtual command interface to allocate IOASID from the host.
+
+Life cycle
+----------
+This section covers the IOASID life cycle management for both bare-metal
+and guest usages. In bare-metal SVA, MMU notifier is directly hooked
+up with the IOMMU driver. By leveraging the .release() function, the
+IOASID life cycle can be made to match the process address space (MM)
+life cycle.
+
+However, guest MMU notifier is not available to the host IOMMU driver,
+when guest MM terminates unexpectedly, the events have to go through
+VFIO and IOMMU UAPI to reach host IOMMU driver. There are also more
+parties involved in guest SVA, e.g. on Intel VT-d platform, IOASIDs
+are used by IOMMU driver, KVM, VDCM, and VFIO.
+
+At the highlevel, there are following four patterns:
+
+1.   ALLOC -> FREE
+2.   ALLOC -> BIND -> DMA Activity -> UNBIND -> FREE
+3.   ALLOC -> BIND -> FREE
+4.   ALLOC -> BIND -> DMA Activity -> FREE
+
+The first two are normal cases, 3 and 4 are exceptions due to user
+process misbehaving.
+
+Exception handling can be complex when there are lots of IOASID
+consumers involved but the pattern is common and quite simple. When an
+IOASID in active state is being freed, IOASID core will notify all
+users to perform clean up. Each IOASID user performs cleanup and drop
+the reference at the end. When reference count drops to 0, IOASID will
+be reclaimed and ready to be allocated again.
+
+Cleanup can be either done in the atomic notifier handler or as queued
+work to the common ordered IOASID workqueue to be performed asynchronously.
+The highlevel flow is the following::
+
+  Free Req¹ -> Notify users -> Cleanup -> Drop reference -> Reclaim
+
+Notes:
+¹ Free one IOASID or free all IOASID within a set
+
+The following table shows how events are used on Intel VT-d platform.
+::
+
+  --------------------------------------------------------------------------
+  Events     |Publishers       | Subscribers
+  -----------+-----------------+--------------------------------------------
+  ALLOC      |/dev/ioasid      | None
+  -----------+-----------------+--------------------------------------------
+  FREE       |/dev/ioasid      | IOMMU (VT-d driver)¹
+  -----------+-----------------+-----------------------------------------------
+  BIND       |IOMMU            | KVM, VDCM
+  -----------+-----------------+-----------------------------------------------
+  UNBIND     |IOMMU²           | KVM, VDCM
+  -----------+--------------------------------------------------------------
+
+  ¹ IOASID core issues FREE events if the IOASID is in the ACTIVE state. IOMMU
+    driver calls ioasid_detach_spid() which issues UNBIND event outside atomic
+    notifier handler.
+  ² Only *one* BIND/UBIND event is issued per bind/unbind cycle. For multiple
+    devices bound to the same PASID, BIND event is issued for the first device
+    bind, UNBDIN event is issued for the last device unbind. Faults must be
+    tolerated between the first and last device unbind. Under normal
+    circumstances, faults are not expected in that the teardown process shall
+    stop DMA activities prior to unbind.
+
+The number of IOASIDs allocated in the ioasid_set serves as the refcount
+of the set, this ensures the life cycle alignment of the set and its
+IOASIDs.
+
+API Implementation
+==================
+To get the IOASID APIs, users must #include <linux/ioasid.h>. These APIs
+serve the following functionalities:
+
+  - IOASID allocation/freeing
+  - Group management in the form of ioasid_set
+  - Private data storage and lookup
+  - Reference counting
+  - Event notification in case of a state change
+
+Custom allocator APIs
+---------------------
+
+IOASIDs are allocated for both host and guest SVA/IOVA usage. However,
+allocators can be different. For example, on VT-d guest PASID
+allocation must be performed via a virtual command interface which is
+emulated by VMM.
+
+IOASID core has the notion of "custom allocator" such that guest can
+register virtual command allocator that precedes the default one.
+::
+
+ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
+
+ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
+
+IOASID Set Level APIs
+---------------------
+For use cases such as guest SVA it is necessary to manage IOASIDs at
+ioasid_set level. For example, VMs may allocate multiple IOASIDs for
+guest process address sharing (vSVA). It is imperative to enforce
+VM-IOASID ownership such that a malicious guest cannot target DMA
+traffic outside its own IOASIDs, or free an active IOASID that belongs
+to another VM.
+
+The IOASID set APIs serve the following purposes:
+
+ - Ownership/permission enforcement
+ - Take collective actions, e.g. free an entire set
+ - Event notifications within a set
+ - Look up a set based on token
+ - Quota enforcement (TBD, contingent upon ioasids cgroup)
+
+Each IOASID set is created with a token, which can be one of the
+following token types::
+
+ - IOASID_SET_TYPE_NONE (Arbitrary u64 value)
+ - IOASID_SET_TYPE_MM (Set token is a mm_struct)
+
+The explicit MM token type is useful when multiple users of an IOASID
+set under the same process need to communicate about their shared IOASIDs.
+E.g. An IOASID set created by VFIO for one guest can be associated
+with the KVM instance for the same guest since they share a common mm_struct.
+A token must be unique within its type.
+
+::
+
+ struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota, u32 type)
+
+ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
+                                void (*fn)(ioasid_t id, void *data),
+                                void *data)
+
+ struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
+
+ void ioasid_free_all_in_set(struct ioasid_set *set)
+
+Individual IOASID APIs
+----------------------
+Once an ioasid_set is created, IOASIDs can be allocated from the set.
+Within the IOASID set namespace, set private ID (SPID) is supported. In
+the VM use case, SPID can be used for storing guest PASID.
+
+::
+
+ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+                       void *private);
+
+ int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+
+ void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+
+ int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+
+ void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
+
+ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+                   bool (*getter)(void *));
+
+ ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid,
+ bool get)
+
+ int ioasid_attach_data(struct ioasid_set *set, ioasid_t ioasid,
+                        void *data);
+ int ioasid_attach_spid(struct ioasid_set *set, ioasid_t ioasid,
+                        ioasid_t spid);
+
+
+Notification APIs
+-----------------
+An IOASID may have multiple users, each user may have hardware context
+associated with an IOASID. When the status of an IOASID changes,
+e.g. an IOASID is being freed, users need to be notified such that the
+associated hardware context can be cleared, flushed, and drained.
+
+::
+
+ int ioasid_register_notifier(struct ioasid_set *set, struct
+                              notifier_block *nb)
+
+ void ioasid_unregister_notifier(struct ioasid_set *set,
+                                 struct notifier_block *nb)
+
+ int ioasid_register_notifier_mm(struct mm_struct *mm, struct
+                                 notifier_block *nb)
+
+ void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct
+                                    notifier_block *nb)
+
+ int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd,
+                   unsigned int flags)
+
+"_mm" flavor of the ioasid_register_notifier() APIs are used when
+an IOASID user need to listen to the IOASID events belong to a
+process but without the knowledge of the associated ioasid_set.
-- 
2.25.1


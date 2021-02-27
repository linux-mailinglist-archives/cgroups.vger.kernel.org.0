Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B079232712C
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhB1GgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:36:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhB1GgQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:36:16 -0500
IronPort-SDR: MQba0tJaLettL+dL364xTs9A3HuiPjUI2k6BaX5hzHSz5zhX3RuArEmfSbtABeWv7r+1R0N1l4
 ruREQ4YeUMSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323895"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: MHgOuHfJlS2KWg/V5x/sQLGSEgxxMJ+t1p3cu4j1vntPUj6wt7O9UbnzIP58Qxgx/mfAFzJc/U
 5JG0VIFAigcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029706"
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
Subject: [PATCH V4 04/18] iommu/ioasid: Support setting system-wide capacity
Date:   Sat, 27 Feb 2021 14:01:12 -0800
Message-Id: <1614463286-97618-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

IOASID is a system-wide resource that could vary on different systems.
The default capacity is 20 bits as defined in the PCI-E specifications.
This patch adds a function to allow adjusting system IOASID capacity.
For VT-d this is set during boot as part of the Intel IOMMU
initialization. APIs also added to support runtime capacity reservation,
potentially by cgroups.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  5 +++
 drivers/iommu/ioasid.c      | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h      | 18 ++++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..6f42ff7d171d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -41,6 +41,7 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
+#include <linux/ioasid.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -3298,6 +3299,10 @@ static int __init init_dmars(void)
 	if (ret)
 		goto free_iommu;
 
+	/* PASID is needed for scalable mode irrespective to SVM */
+	if (intel_iommu_sm)
+		ioasid_install_capacity(intel_pasid_max_id);
+
 	/*
 	 * for each drhd
 	 *   enable fault log
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 4eb9b3dd1b85..28681b99340b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,6 +10,10 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/* Default to PCIe standard 20 bit PASID */
+#define PCI_PASID_MAX 0x100000
+static ioasid_t ioasid_capacity = PCI_PASID_MAX;
+static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -258,6 +262,72 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
+void ioasid_install_capacity(ioasid_t total)
+{
+	spin_lock(&ioasid_allocator_lock);
+	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
+		pr_warn("IOASID capacity is already set.\n");
+		goto done_unlock;
+	}
+	ioasid_capacity = ioasid_capacity_avail = total;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_install_capacity);
+
+/**
+ * @brief Reserve capacity from the system pool
+ *
+ * @param nr_ioasid Number of IOASIDs requested to be reserved, 0 means
+ *	reserve all remaining IDs.
+ *
+ * @return the remaining capacity on success, or errno
+ */
+int ioasid_reserve_capacity(ioasid_t nr_ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (nr_ioasid > ioasid_capacity_avail) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+	if (!nr_ioasid)
+		nr_ioasid = ioasid_capacity_avail;
+	ioasid_capacity_avail -= nr_ioasid;
+	ret = nr_ioasid;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_reserve_capacity);
+
+/**
+ * @brief Return capacity to the system pool
+ * 	We trust the caller not to return more than it has reserved, we could
+ * 	also track reservation if needed.
+ *
+ * @param nr_ioasid Number of IOASIDs requested to be returned
+ *
+ * @return the remaining capacity on success, or errno
+ */
+int ioasid_cancel_capacity(ioasid_t nr_ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (nr_ioasid + ioasid_capacity_avail > ioasid_capacity) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	ioasid_capacity_avail += nr_ioasid;
+	ret = ioasid_capacity_avail;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_cancel_capacity);
+
 /**
  * ioasid_attach_data - Set private data for an allocated ioasid
  * @ioasid: the ID to set data
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index f6e705f832f0..2780bdc84b94 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -32,6 +32,10 @@ struct ioasid_allocator_ops {
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
+void ioasid_install_capacity(ioasid_t total);
+int ioasid_reserve_capacity(ioasid_t nr_ioasid);
+int ioasid_cancel_capacity(ioasid_t nr_ioasid);
+
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
 void ioasid_get(ioasid_t ioasid);
@@ -43,6 +47,20 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
+static inline void ioasid_install_capacity(ioasid_t total)
+{
+}
+
+static inline int ioasid_reserve_capacity(ioasid_t nr_ioasid)
+{
+	return -ENOSPC;
+}
+
+static inline int ioasid_cancel_capacity(ioasid_t nr_ioasid)
+{
+	return -EINVAL;
+}
+
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
 {
-- 
2.25.1


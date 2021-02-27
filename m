Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F6D327128
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhB1Ge4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:34:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhB1Gez (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:34:55 -0500
IronPort-SDR: 2b/Qg00QxNkO74o12ccZs3GkLaTWCSMBXNY+iwYEkEt7QZd/vjhE9puEyd95Z6wa2Gbsde5WaF
 bvCclR4bbfQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323894"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323894"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: wi+8gDcvTp+PYBd2kCqS1qKX1EMyAg50s+8OiqJ/CBjarsQbElQOz4f1VxZQtliU86DxIu04u5
 xk+d67aqFX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029703"
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
Subject: [PATCH V4 03/18] iommu/ioasid: Add a separate function for detach data
Date:   Sat, 27 Feb 2021 14:01:11 -0800
Message-Id: <1614463286-97618-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

IOASID private data can be cleared by ioasid_attach_data() with a NULL
data pointer. A common use case is for a caller to free the data
afterward. ioasid_attach_data() calls synchronize_rcu() before return
such that free data can be sure without outstanding readers.
However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
be used under spinlocks.

This patch adds ioasid_detach_data() as a separate API where
synchronize_rcu() is called only in this case. ioasid_attach_data() can
then be used under spinlocks. In addition, this change makes the API
symmetrical.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  4 +--
 drivers/iommu/ioasid.c    | 54 +++++++++++++++++++++++++++++++--------
 include/linux/ioasid.h    |  5 +++-
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0053df9edffc..68372a7eb8b5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -425,7 +425,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_attach_data(data->hpasid, NULL);
+		ioasid_detach_data(data->hpasid);
 		kfree(svm);
 	}
 
@@ -468,7 +468,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_attach_data(pasid, NULL);
+				ioasid_detach_data(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index eeadf4586e0a..4eb9b3dd1b85 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -273,23 +273,57 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 
 	spin_lock(&ioasid_allocator_lock);
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
+
+	if (!ioasid_data) {
 		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
+		goto done_unlock;
+	}
 
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
+	if (ioasid_data->private) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+	rcu_assign_pointer(ioasid_data->private, data);
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
+/**
+ * ioasid_detach_data - Clear the private data of an ioasid
+ *
+ * @ioasid: the IOASIDD to clear private data
+ */
+void ioasid_detach_data(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_warn("IOASID %u not found to detach data from\n", ioasid);
+		goto done_unlock;
+	}
+
+	if (ioasid_data->private) {
+		rcu_assign_pointer(ioasid_data->private, NULL);
+		goto done_unlock;
+	}
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	/*
+	 * Wait for readers to stop accessing the old private data,
+	 * so the caller can free it.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_data);
+
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 60ea279802b8..f6e705f832f0 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -41,7 +41,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
-
+void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -78,5 +78,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline void ioasid_detach_data(ioasid_t ioasid)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.25.1


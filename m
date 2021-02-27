Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74D327145
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhB1Gl6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:41:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhB1Gly (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:41:54 -0500
IronPort-SDR: M86yoXHTOXt0Z19fUXGZJbNlKTkTaTrhOp0zBjAXfv+uKs77irEmDlYD/JToTilbBDPz139ULF
 w3p/O0xi95WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323906"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323906"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: VwmdMDFqK2b6EtjWnoffQBBdex7rudtOi8+cVDYN+vuAbCYlNLFGMm0gzT7CnGOM/j3N7ldZe+
 umTYB3/XUhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029737"
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
Subject: [PATCH V4 14/18] iommu/vt-d: Listen to IOASID notifications
Date:   Sat, 27 Feb 2021 14:01:22 -0800
Message-Id: <1614463286-97618-15-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
driver is one of the users of IOASIDs. In normal flow, callers will
perform IOASID allocation, bind, unbind, and free in order. However, for
guest SVA, IOASID free could come before unbind as guest is untrusted.
This patch registers IOASID notification handler such that IOMMU driver
can perform PASID teardown upon receiving an unexpected IOASID free
event.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |   2 +
 drivers/iommu/intel/svm.c   | 109 +++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |   2 +
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eb9868061545..d602e89c40d2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3313,6 +3313,8 @@ static int __init init_dmars(void)
 			pr_err("Failed to allocate host PASID set %lu\n",
 				PTR_ERR(host_pasid_set));
 			intel_iommu_sm = 0;
+		} else {
+			intel_svm_add_pasid_notifier();
 		}
 	}
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f75699ddb923..b5bb9b578281 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -96,6 +96,104 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
 }
 
+static inline void intel_svm_drop_pasid(ioasid_t pasid)
+{
+	/*
+	 * Detaching SPID results in UNBIND notification on the set, we must
+	 * do this before dropping the IOASID reference, otherwise the
+	 * notification chain may get destroyed.
+	 */
+	ioasid_detach_spid(pasid);
+	ioasid_detach_data(pasid);
+	ioasid_put(NULL, pasid);
+}
+
+static DEFINE_MUTEX(pasid_mutex);
+#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
+
+static void intel_svm_free_async_fn(struct work_struct *work)
+{
+	struct intel_svm *svm = container_of(work, struct intel_svm, work);
+	struct intel_svm_dev *sdev;
+
+	/*
+	 * Unbind all devices associated with this PASID which is
+	 * being freed by other users such as VFIO.
+	 */
+	mutex_lock(&pasid_mutex);
+	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
+		/* Does not poison forward pointer */
+		list_del_rcu(&sdev->list);
+		spin_lock(&sdev->iommu->lock);
+		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
+					svm->pasid, true);
+		intel_svm_drain_prq(sdev->dev, svm->pasid);
+		spin_unlock(&sdev->iommu->lock);
+		kfree_rcu(sdev, rcu);
+	}
+	/*
+	 * We may not be the last user to drop the reference but since
+	 * the PASID is in FREE_PENDING state, no one can get new reference.
+	 * Therefore, we can safely free the private data svm.
+	 */
+	intel_svm_drop_pasid(svm->pasid);
+
+	/*
+	 * Free before unbind can only happen with host PASIDs used for
+	 * guest SVM. We get here because ioasid_free is called with
+	 * outstanding references. So we need to drop the reference
+	 * such that the PASID can be reclaimed. unbind_gpasid() after this
+	 * will not result in dropping refcount since the private data is
+	 * already detached.
+	 */
+	kfree(svm);
+
+	mutex_unlock(&pasid_mutex);
+}
+
+
+static int pasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
+	struct intel_svm *svm = (struct intel_svm *)args->pdata;
+	int ret = NOTIFY_DONE;
+
+	/*
+	 * Notification private data is a choice of vendor driver when the
+	 * IOASID is allocated or attached after allocation. When the data
+	 * type changes, we must make modifications here accordingly.
+	 */
+	if (code == IOASID_NOTIFY_FREE) {
+		/*
+		 * If PASID UNBIND happens before FREE, private data of the
+		 * IOASID should be NULL, then we don't need to do anything.
+		 */
+		if (!svm)
+			goto done;
+		if (args->id != svm->pasid) {
+			pr_warn("Notify PASID does not match data %d : %d\n",
+				args->id, svm->pasid);
+			goto done;
+		}
+		if (!ioasid_queue_work(&svm->work))
+			pr_warn("Cleanup work already queued\n");
+		return NOTIFY_OK;
+	}
+done:
+	return ret;
+}
+
+static struct notifier_block pasid_nb = {
+	.notifier_call = pasid_status_change,
+};
+
+void intel_svm_add_pasid_notifier(void)
+{
+	/* Listen to all PASIDs, not specific to a set */
+	ioasid_register_notifier(NULL, &pasid_nb);
+}
+
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -240,7 +338,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
@@ -367,8 +464,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
+			ioasid_attach_spid(data->hpasid, data->gpasid);
 		}
 		ioasid_attach_data(data->hpasid, svm);
+		ioasid_get(NULL, svm->pasid);
+		sdev->iommu = iommu;
+		/*
+		 * Set up cleanup async work in case IOASID core notify us PASID
+		 * is freed before unbind.
+		 */
+		INIT_WORK(&svm->work, intel_svm_free_async_fn);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 	}
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
@@ -464,7 +569,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_detach_data(pasid);
+				intel_svm_drop_pasid(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 09c6a0bf3892..b1b8914e1564 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -757,6 +757,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+void intel_svm_add_pasid_notifier(void);
 
 struct svm_dev_ops;
 
@@ -783,6 +784,7 @@ struct intel_svm {
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
+	struct work_struct work; /* For deferred clean up */
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD60327132
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhB1Gh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:37:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhB1Ghi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:37:38 -0500
IronPort-SDR: aYzuEzuYy3s78PMVXMgSnQqCInR8LnvD2fLZmWre/WCv83mtn3cF0bZ/kKno0S02X8aavhw5Fm
 ezf9roF/BEyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323896"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: 2GKFUUe565xfX+bViu5FR1ax3OyRlLYtp4zVSfak4mOIAhfM25tTcLrHEO+hohylvGZoovK7ad
 ZXPgtrQKaLcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029710"
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
Subject: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation APIs
Date:   Sat, 27 Feb 2021 14:01:13 -0800
Message-Id: <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ioasid_set was introduced as an arbitrary token that is shared by a
group of IOASIDs. For example, two IOASIDs allocated via the same
ioasid_set pointer belong to the same set.

For guest SVA usages, system-wide IOASID resources need to be
partitioned such that each VM can have its own quota and being managed
separately. ioasid_set is the perfect candidate for meeting such
requirements. This patch redefines and extends ioasid_set with the
following new fields:
- Quota
- Reference count
- Storage of its namespace
- The token is now stored in the ioasid_set with types

Basic ioasid_set level APIs are introduced that wire up these new data.
Existing users of IOASID APIs are converted where a host IOASID set is
allocated for bare-metal usages. Including VT-d driver and
iommu-sva-lib.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   1 +
 drivers/iommu/intel/iommu.c                   |  27 +-
 drivers/iommu/intel/pasid.h                   |   1 +
 drivers/iommu/intel/svm.c                     |  25 +-
 drivers/iommu/ioasid.c                        | 288 +++++++++++++++---
 drivers/iommu/iommu-sva-lib.c                 |  19 +-
 include/linux/ioasid.h                        |  68 ++++-
 7 files changed, 361 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e13b092e6004..588aa66ed5e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -459,6 +459,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 {
 	mutex_lock(&sva_lock);
 	master->sva_enabled = true;
+	iommu_sva_init();
 	mutex_unlock(&sva_lock);
 
 	return 0;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6f42ff7d171d..eb9868061545 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -103,6 +103,9 @@
  */
 #define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
 
+/* PASIDs used by host SVM */
+struct ioasid_set *host_pasid_set;
+
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -173,6 +176,7 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
+static bool scalable_mode_support(void);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -3114,8 +3118,8 @@ static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
 	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
 	 * We can only free the PASID when all the devices are unbound.
 	 */
-	if (ioasid_find(NULL, ioasid, NULL)) {
-		pr_alert("Cannot free active IOASID %d\n", ioasid);
+	if (IS_ERR(ioasid_find(host_pasid_set, ioasid, NULL))) {
+		pr_err("IOASID %d to be freed but not in system set\n", ioasid);
 		return;
 	}
 	vcmd_free_pasid(iommu, ioasid);
@@ -3300,8 +3304,17 @@ static int __init init_dmars(void)
 		goto free_iommu;
 
 	/* PASID is needed for scalable mode irrespective to SVM */
-	if (intel_iommu_sm)
+	if (scalable_mode_support()) {
 		ioasid_install_capacity(intel_pasid_max_id);
+		/* We should not run out of IOASIDs at boot */
+		host_pasid_set = ioasid_set_alloc(NULL, PID_MAX_DEFAULT,
+						  IOASID_SET_TYPE_NULL);
+		if (IS_ERR_OR_NULL(host_pasid_set)) {
+			pr_err("Failed to allocate host PASID set %lu\n",
+				PTR_ERR(host_pasid_set));
+			intel_iommu_sm = 0;
+		}
+	}
 
 	/*
 	 * for each drhd
@@ -3348,7 +3361,7 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-
+	ioasid_set_free(host_pasid_set);
 	kfree(g_iommus);
 
 error:
@@ -4573,7 +4586,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		u32 pasid;
 
 		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
+		pasid = ioasid_alloc(host_pasid_set, PASID_MIN,
 				     pci_max_pasids(to_pci_dev(dev)) - 1,
 				     NULL);
 		if (pasid == INVALID_IOASID) {
@@ -4630,7 +4643,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 link_failed:
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_put(host_pasid_set, domain->default_pasid);
 
 	return ret;
 }
@@ -4660,7 +4673,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
-		ioasid_put(domain->default_pasid);
+		ioasid_put(host_pasid_set, domain->default_pasid);
 }
 
 static int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 97dfcffbf495..12b5ca18de5d 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -99,6 +99,7 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 }
 
 extern unsigned int intel_pasid_max_id;
+extern struct ioasid_set *host_pasid_set;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(u32 pasid);
 void *intel_pasid_lookup_id(u32 pasid);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 68372a7eb8b5..c469c24d23f5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -247,7 +247,9 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
-static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
+static int pasid_to_svm_sdev(struct device *dev,
+			     struct ioasid_set *set,
+			     unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
 {
@@ -261,7 +263,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
 		return -EINVAL;
 
-	svm = ioasid_find(NULL, pasid, NULL);
+	svm = ioasid_find(set, pasid, NULL);
 	if (IS_ERR(svm))
 		return PTR_ERR(svm);
 
@@ -337,7 +339,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	ret = pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, NULL,
+				data->hpasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -444,7 +447,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 		return -EINVAL;
 
 	mutex_lock(&pasid_mutex);
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, NULL, pasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -602,7 +605,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
+		svm->pasid = ioasid_alloc(host_pasid_set, PASID_MIN,
 					  pasid_max - 1, svm);
 		if (svm->pasid == INVALID_IOASID) {
 			kfree(svm);
@@ -619,7 +622,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_put(svm->pasid);
+				ioasid_put(host_pasid_set, svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -637,7 +640,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_put(svm->pasid);
+			ioasid_put(host_pasid_set, svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -689,7 +692,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 	if (!iommu)
 		goto out;
 
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, host_pasid_set,
+				pasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -710,7 +714,7 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_put(svm->pasid);
+				ioasid_put(host_pasid_set, svm->pasid);
 				if (svm->mm) {
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 					/* Clear mm's pasid. */
@@ -1184,7 +1188,8 @@ int intel_svm_page_response(struct device *dev,
 		goto out;
 	}
 
-	ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, host_pasid_set,
+				prm->pasid, &svm, &sdev);
 	if (ret || !sdev) {
 		ret = -ENODEV;
 		goto out;
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 28681b99340b..d7b476651027 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
- * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_put.
+ * sets. Users create a set with ioasid_set_alloc, then allocate/free IDs
+ * with ioasid_alloc, ioasid_put, and ioasid_free.
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -14,6 +14,7 @@
 #define PCI_PASID_MAX 0x100000
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
+static DEFINE_XARRAY_ALLOC(ioasid_sets);
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -394,6 +395,151 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static inline bool ioasid_set_is_valid(struct ioasid_set *set)
+{
+	return xa_load(&ioasid_sets, set->id) == set;
+}
+
+/**
+ * ioasid_set_alloc - Allocate a new IOASID set for a given token
+ *
+ * @token:	An optional arbitrary number that can be associated with the
+ *		IOASID set. @token can be NULL if the type is
+ *		IOASID_SET_TYPE_NULL
+ * @quota:	Quota allowed in this set, 0 indicates no limit for the set
+ * @type:	The type of the token used to create the IOASID set
+ *
+ * IOASID is limited system-wide resource that requires quota management.
+ * Token will be stored in the ioasid_set returned. A reference will be taken
+ * on the newly created set. Subsequent IOASID allocation within the set need
+ * to use the returned ioasid_set pointer.
+ */
+struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
+{
+	struct ioasid_set *set;
+	unsigned long index;
+	ioasid_t id;
+
+	if (type >= IOASID_SET_TYPE_NR)
+		return ERR_PTR(-EINVAL);
+
+	/* No limit for the set, use whatever is available on the system */
+	if (!quota)
+		quota = ioasid_capacity_avail;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (quota > ioasid_capacity_avail) {
+		pr_warn("Out of IOASID capacity! ask %d, avail %d\n",
+			quota, ioasid_capacity_avail);
+		set = ERR_PTR(-ENOSPC);
+		goto exit_unlock;
+	}
+
+	/*
+	 * Token is only unique within its types but right now we have only
+	 * mm type. If we have more token types, we have to match type as well.
+	 */
+	switch (type) {
+	case IOASID_SET_TYPE_MM:
+		if (!token) {
+			set = ERR_PTR(-EINVAL);
+			goto exit_unlock;
+		}
+		/* Search existing set tokens, reject duplicates */
+		xa_for_each(&ioasid_sets, index, set) {
+			if (set->token == token && set->type == IOASID_SET_TYPE_MM) {
+				set = ERR_PTR(-EEXIST);
+				goto exit_unlock;
+			}
+		}
+		break;
+	case IOASID_SET_TYPE_NULL:
+		if (!token)
+			break;
+		fallthrough;
+	default:
+		pr_err("Invalid token and IOASID type\n");
+		set = ERR_PTR(-EINVAL);
+		goto exit_unlock;
+	}
+
+	set = kzalloc(sizeof(*set), GFP_ATOMIC);
+	if (!set) {
+		set = ERR_PTR(-ENOMEM);
+		goto exit_unlock;
+	}
+
+	if (xa_alloc(&ioasid_sets, &id, set,
+		     XA_LIMIT(0, ioasid_capacity_avail),
+		     GFP_ATOMIC)) {
+		kfree(set);
+		set = ERR_PTR(-ENOSPC);
+		goto exit_unlock;
+	}
+
+	set->token = token;
+	set->type = type;
+	set->quota = quota;
+	set->id = id;
+	atomic_set(&set->nr_ioasids, 0);
+	/*
+	 * Per set XA is used to store private IDs within the set, get ready
+	 * for ioasid_set private ID and system-wide IOASID allocation
+	 * results.
+	 */
+	xa_init(&set->xa);
+	ioasid_capacity_avail -= quota;
+
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+
+	return set;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_alloc);
+
+static int ioasid_set_free_locked(struct ioasid_set *set)
+{
+	int ret = 0;
+
+	if (!ioasid_set_is_valid(set)) {
+		ret = -EINVAL;
+		goto exit_done;
+	}
+
+	if (atomic_read(&set->nr_ioasids)) {
+		ret = -EBUSY;
+		goto exit_done;
+	}
+
+	WARN_ON(!xa_empty(&set->xa));
+	/*
+	 * Token got released right away after the ioasid_set is freed.
+	 * If a new set is created immediately with the newly released token,
+	 * it will not allocate the same IOASIDs unless they are reclaimed.
+	 */
+	xa_erase(&ioasid_sets, set->id);
+	kfree_rcu(set, rcu);
+exit_done:
+	return ret;
+};
+
+/**
+ * @brief Free an ioasid_set if empty. Restore pending notification list.
+ *
+ * @param set to be freed
+ * @return
+ */
+int ioasid_set_free(struct ioasid_set *set)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_set_free_locked(set);
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_free);
+
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
@@ -411,11 +557,22 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 {
 	struct ioasid_data *data;
 	void *adata;
-	ioasid_t id;
+	ioasid_t id = INVALID_IOASID;
+
+	spin_lock(&ioasid_allocator_lock);
+	/* Check if the IOASID set has been allocated and initialized */
+	if (!ioasid_set_is_valid(set))
+		goto done_unlock;
+
+	if (set->quota <= atomic_read(&set->nr_ioasids)) {
+		pr_err_ratelimited("IOASID set out of quota %d\n",
+				   set->quota);
+		goto done_unlock;
+	}
 
 	data = kzalloc(sizeof(*data), GFP_ATOMIC);
 	if (!data)
-		return INVALID_IOASID;
+		goto done_unlock;
 
 	data->set = set;
 	data->private = private;
@@ -425,7 +582,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	 * Custom allocator needs allocator data to perform platform specific
 	 * operations.
 	 */
-	spin_lock(&ioasid_allocator_lock);
 	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
 	id = active_allocator->ops->alloc(min, max, adata);
 	if (id == INVALID_IOASID) {
@@ -442,67 +598,121 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	}
 	data->id = id;
 
-	spin_unlock(&ioasid_allocator_lock);
-	return id;
+	/* Store IOASID in the per set data */
+	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
+		pr_err_ratelimited("Failed to store ioasid %d in set\n", id);
+		active_allocator->ops->free(id, active_allocator->ops->pdata);
+		goto exit_free;
+	}
+	atomic_inc(&set->nr_ioasids);
+	goto done_unlock;
 exit_free:
-	spin_unlock(&ioasid_allocator_lock);
 	kfree(data);
-	return INVALID_IOASID;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return id;
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
+static void ioasid_do_free_locked(struct ioasid_data *data)
+{
+	struct ioasid_data *ioasid_data;
+
+	active_allocator->ops->free(data->id, active_allocator->ops->pdata);
+	/* Custom allocator needs additional steps to free the xa element */
+	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
+		ioasid_data = xa_erase(&active_allocator->xa, data->id);
+		kfree_rcu(ioasid_data, rcu);
+	}
+	atomic_dec(&data->set->nr_ioasids);
+	xa_erase(&data->set->xa, data->id);
+	/* Destroy the set if empty */
+	if (!atomic_read(&data->set->nr_ioasids))
+		ioasid_set_free_locked(data->set);
+}
+
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to get unknown IOASID %u\n", ioasid);
+		return -EINVAL;
+	}
+
+	/* Check set ownership if the set is non-null */
+	if (set && data->set != set) {
+		pr_err("Trying to get IOASID %u outside the set\n", ioasid);
+		/* data found but does not belong to the set */
+		return -EACCES;
+	}
+	refcount_inc(&data->refs);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_locked);
+
 /**
  * ioasid_get - obtain a reference to the IOASID
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the IOASID to get reference
+ *
+ *
+ * Return: 0 on success, error if failed.
  */
-void ioasid_get(ioasid_t ioasid)
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
 {
-	struct ioasid_data *ioasid_data;
+	int ret;
 
 	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		refcount_inc(&ioasid_data->refs);
-	else
-		WARN_ON(1);
+	ret = ioasid_get_locked(set, ioasid);
 	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_get);
 
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to put unknown IOASID %u\n", ioasid);
+		return false;
+	}
+	if (set && data->set != set) {
+		pr_err("Trying to drop IOASID %u outside the set\n", ioasid);
+		return false;
+	}
+	if (!refcount_dec_and_test(&data->refs))
+		return false;
+
+	ioasid_do_free_locked(data);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ioasid_put_locked);
+
 /**
  * ioasid_put - Release a reference to an ioasid
- * @ioasid: the ID to remove
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the IOASID to drop reference
  *
  * Put a reference to the IOASID, free it when the number of references drops to
  * zero.
  *
  * Return: %true if the IOASID was freed, %false otherwise.
  */
-bool ioasid_put(ioasid_t ioasid)
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
 {
-	bool free = false;
-	struct ioasid_data *ioasid_data;
+	bool ret;
 
 	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (!ioasid_data) {
-		pr_err("Trying to free unknown IOASID %u\n", ioasid);
-		goto exit_unlock;
-	}
-
-	free = refcount_dec_and_test(&ioasid_data->refs);
-	if (!free)
-		goto exit_unlock;
-
-	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
-	/* Custom allocator needs additional steps to free the xa element */
-	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
-		ioasid_data = xa_erase(&active_allocator->xa, ioasid);
-		kfree_rcu(ioasid_data, rcu);
-	}
-
-exit_unlock:
+	ret = ioasid_put_locked(set, ioasid);
 	spin_unlock(&ioasid_allocator_lock);
-	return free;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_put);
 
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..7f97a03a135b 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -8,7 +8,16 @@
 #include "iommu-sva-lib.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DECLARE_IOASID_SET(iommu_sva_pasid);
+static struct ioasid_set *iommu_sva_pasid;
+
+/* Must be called before PASID allocations can occur */
+void iommu_sva_init(void)
+{
+	if (iommu_sva_pasid)
+		return;
+	iommu_sva_pasid = ioasid_set_alloc(NULL, 0, IOASID_SET_TYPE_NULL);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_init);
 
 /**
  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
@@ -35,11 +44,11 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	mutex_lock(&iommu_sva_lock);
 	if (mm->pasid) {
 		if (mm->pasid >= min && mm->pasid <= max)
-			ioasid_get(mm->pasid);
+			ioasid_get(iommu_sva_pasid, mm->pasid);
 		else
 			ret = -EOVERFLOW;
 	} else {
-		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+		pasid = ioasid_alloc(iommu_sva_pasid, min, max, mm);
 		if (pasid == INVALID_IOASID)
 			ret = -ENOMEM;
 		else
@@ -59,7 +68,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 void iommu_sva_free_pasid(struct mm_struct *mm)
 {
 	mutex_lock(&iommu_sva_lock);
-	if (ioasid_put(mm->pasid))
+	if (ioasid_put(iommu_sva_pasid, mm->pasid))
 		mm->pasid = 0;
 	mutex_unlock(&iommu_sva_lock);
 }
@@ -81,6 +90,6 @@ static bool __mmget_not_zero(void *mm)
  */
 struct mm_struct *iommu_sva_find(ioasid_t pasid)
 {
-	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
+	return ioasid_find(iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2780bdc84b94..095f4e50dc58 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,14 +4,43 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
+/* IOASID set types */
+enum ioasid_set_type {
+	IOASID_SET_TYPE_NULL = 1, /* Set token is NULL */
+	IOASID_SET_TYPE_MM,	  /* Set token is a mm_struct pointer
+				   * i.e. associated with a process
+				   */
+	IOASID_SET_TYPE_NR,
+};
+
+/**
+ * struct ioasid_set - Meta data about ioasid_set
+ * @nh:		List of notifiers private to that set
+ * @xa:		XArray to store ioasid_set private IDs, can be used for
+ *		guest-host IOASID mapping, or just a private IOASID namespace.
+ * @token:	Unique to identify an IOASID set
+ * @type:	Token types
+ * @quota:	Max number of IOASIDs can be allocated within the set
+ * @nr_ioasids:	Number of IOASIDs currently allocated in the set
+ * @id:		ID of the set
+ */
 struct ioasid_set {
-	int dummy;
+	struct atomic_notifier_head nh;
+	struct xarray xa;
+	void *token;
+	int type;
+	int quota;
+	atomic_t nr_ioasids;
+	int id;
+	struct rcu_head rcu;
 };
 
 /**
@@ -29,17 +58,20 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
-#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
-
 #if IS_ENABLED(CONFIG_IOASID)
 void ioasid_install_capacity(ioasid_t total);
 int ioasid_reserve_capacity(ioasid_t nr_ioasid);
 int ioasid_cancel_capacity(ioasid_t nr_ioasid);
+struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
+int ioasid_set_free(struct ioasid_set *set);
+struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token);
 
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_get(ioasid_t ioasid);
-bool ioasid_put(ioasid_t ioasid);
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -67,11 +99,33 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_get(ioasid_t ioasid)
+static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota,
+						  ioasid_set_type type)
 {
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
+{
+	return NULL;
+}
+
+static inline int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return false;
 }
 
-static inline bool ioasid_put(ioasid_t ioasid)
+static inline bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	return false;
 }
-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8A327137
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhB1Gie (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:38:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:22647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhB1GiE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:38:04 -0500
IronPort-SDR: Sc1KuAKvbpj3lqQu0KNtLaYHZ8yB0binlW+4g2e1NCfJLXkUxY9Ljviv/nIroAxZGyFQ9D37HL
 LNyRU0ZPvQ/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323898"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: uViKB7IpUnlUj71C+dfdHvaySm/kdSYhIWEQXMIrwmw5k196QwVOQ1eaDa11HjurQEQ606e+Cz
 Xd9N9SVSujtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029715"
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
Subject: [PATCH V4 07/18] iommu/ioasid: Add ioasid_set iterator helper functions
Date:   Sat, 27 Feb 2021 14:01:15 -0800
Message-Id: <1614463286-97618-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Users of an ioasid_set may not keep track of all the IOASIDs allocated
under the set. When collective actions are needed for each IOASIDs, it
is useful to iterate over all the IOASIDs within the set. For example,
when the ioasid_set is freed, the user might perform the same cleanup
operation on each IOASID.

This patch adds an API to iterate all the IOASIDs within the set.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 20 ++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index a10f8154c680..9a3ba157dec3 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -700,6 +700,61 @@ void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
+
+/**
+ * ioasid_free_all_in_set
+ *
+ * @brief
+ * Free all PASIDs from system-wide IOASID pool, all subscribers gets
+ * notified and do cleanup of their own.
+ * Note that some references of the IOASIDs within the set can still
+ * be held after the free call. This is OK in that the IOASIDs will be
+ * marked inactive, the only operations can be done is ioasid_put.
+ * No need to track IOASID set states since there is no reclaim phase.
+ *
+ * @param
+ * struct ioasid_set where all IOASIDs within the set will be freed.
+ */
+void ioasid_free_all_in_set(struct ioasid_set *set)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!ioasid_set_is_valid(set))
+		return;
+
+	if (xa_empty(&set->xa))
+		return;
+
+	if (!atomic_read(&set->nr_ioasids))
+		return;
+	spin_lock(&ioasid_allocator_lock);
+	xa_for_each(&set->xa, index, entry) {
+		ioasid_free_locked(set, index);
+		/* Free from per set private pool */
+		xa_erase(&set->xa, index);
+	}
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_free_all_in_set);
+
+/**
+ * ioasid_set_for_each_ioasid
+ * @brief
+ * Iterate over all the IOASIDs within the set
+ */
+void ioasid_set_for_each_ioasid(struct ioasid_set *set,
+				void (*fn)(ioasid_t id, void *data),
+				void *data)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	xa_for_each(&set->xa, index, entry)
+		fn(index, data);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
+
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	struct ioasid_data *data;
@@ -789,6 +844,35 @@ bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_put);
 
+/**
+ * @brief
+ * Find the ioasid_set of an IOASID. As long as the IOASID is valid,
+ * the set must be valid since the refcounting is based on the number of IOASID
+ * in the set.
+ *
+ * @param ioasid
+ * @return struct ioasid_set*
+ */
+struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *ioasid_data;
+	struct ioasid_set *set = NULL;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	ioasid_data = xa_load(&idata->xa, ioasid);
+	if (!ioasid_data) {
+		set = ERR_PTR(-ENOENT);
+		goto unlock;
+	}
+	set = ioasid_data->set;
+unlock:
+	rcu_read_unlock();
+	return set;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_set);
+
 /**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index cabaf0b0348f..e7f3e6108724 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,12 +73,17 @@ int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_free_all_in_set(struct ioasid_set *set);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
+struct ioasid_set *ioasid_find_set(ioasid_t ioasid);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+				void (*fn)(ioasid_t id, void *data),
+				void *data);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -158,5 +163,20 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
+
+static inline void ioasid_free_all_in_set(struct ioasid_set *set)
+{
+}
+
+static inline struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+					      void (*fn)(ioasid_t id, void *data),
+					      void *data)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.25.1


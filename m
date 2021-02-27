Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AE327134
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhB1Gh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:37:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:58906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhB1Ghl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:37:41 -0500
IronPort-SDR: IiW+aaww4btVDsUnYj0FGvZGYxWUwJiejRjVhALPS/rQWOxzOksxPopBQ2yHbmsbn6NmFZa2so
 2AMAK3/zSMqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323897"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: OlMZLxJr4usjBYjQLafwEmc8+hyWUvMMEUh25wap14Nsvg8M73cK2FlaDV+SBWS9dhiJ/6dlVw
 50492sCfZbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029712"
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
Subject: [PATCH V4 06/18] iommu/ioasid: Add free function and states
Date:   Sat, 27 Feb 2021 14:01:14 -0800
Message-Id: <1614463286-97618-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an actively used IOASID is freed due to exceptions, users must be
notified to perform the cleanup. The IOASID shall be put in a pending
state until all users completed their cleanup work.

This patch adds ioasid_free() function to let the caller initiate the
freeing process. Both ioasid_free() and ioasid_put() decrements
reference counts. Unlike ioasid_put(), the ioasid_free() function also
transition the IOASID to the free pending state where further
ioasid_get() is prohibited. This paves the way for FREE event
notifications that will be introduced next.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  5 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index d7b476651027..a10f8154c680 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -15,8 +15,26 @@
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
+
+enum ioasid_state {
+	IOASID_STATE_IDLE,
+	IOASID_STATE_ACTIVE,
+	IOASID_STATE_FREE_PENDING,
+};
+
+/**
+ * struct ioasid_data - Meta data about ioasid
+ *
+ * @id:		Unique ID
+ * @refs:	Number of active users
+ * @state:	Track state of the IOASID
+ * @set:	ioasid_set of the IOASID belongs to
+ * @private:	Private data associated with the IOASID
+ * @rcu:	For free after RCU grace period
+ */
 struct ioasid_data {
 	ioasid_t id;
+	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
@@ -597,6 +615,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->state = IOASID_STATE_IDLE;
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
@@ -631,6 +650,56 @@ static void ioasid_do_free_locked(struct ioasid_data *data)
 		ioasid_set_free_locked(data->set);
 }
 
+static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err_ratelimited("Trying to free unknown IOASID %u\n", ioasid);
+		return;
+	}
+	if (data->set != set) {
+		pr_warn("Cannot free IOASID %u due to set ownership\n", ioasid);
+		return;
+	}
+	/* Check if the set exists */
+	if (WARN_ON(!xa_load(&ioasid_sets, data->set->id)))
+		return;
+
+	/* Free is already in progress */
+	if (data->state == IOASID_STATE_FREE_PENDING)
+		return;
+
+	data->state = IOASID_STATE_FREE_PENDING;
+	/*
+	 * If the refcount is 1, it means there is no other users of the IOASID
+	 * other than IOASID core itself. There is no need to notify anyone.
+	 */
+	if (!refcount_dec_and_test(&data->refs))
+		return;
+
+	ioasid_do_free_locked(data);
+}
+
+/**
+ * ioasid_free - Drop reference on an IOASID. Free if refcount drops to 0,
+ *               including free from its set and system-wide list.
+ * @set:	The ioasid_set to check permission with. If not NULL, IOASID
+ *		free will fail if the set does not match.
+ * @ioasid:	The IOASID to remove
+ *
+ * TODO: return true if all references dropped, false if async work is in
+ * progress, IOASID is in FREE_PENDING state. wait queue to be used for blocking
+ * free task.
+ */
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_free_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_free);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	struct ioasid_data *data;
@@ -640,6 +709,10 @@ int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 		pr_err("Trying to get unknown IOASID %u\n", ioasid);
 		return -EINVAL;
 	}
+	if (data->state == IOASID_STATE_FREE_PENDING) {
+		pr_err("Trying to get IOASID being freed%u\n", ioasid);
+		return -EBUSY;
+	}
 
 	/* Check set ownership if the set is non-null */
 	if (set && data->set != set) {
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 095f4e50dc58..cabaf0b0348f 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -72,6 +72,7 @@ int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -105,6 +106,10 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+}
+
 static inline struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
 {
 	return NULL;
-- 
2.25.1


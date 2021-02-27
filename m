Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B8327139
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhB1GjO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:39:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhB1GjJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:39:09 -0500
IronPort-SDR: 70EMW9O4rG/DeSm0gD9kRC9aDRhjxqerY/J/89QzUNAjpZt66oJI7KYH6A22xJoZV52X9IdOyX
 O1EN0NStCtAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323899"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323899"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: wwnUe/gQ2DURd1fuukWv5FTP+PhsRLJQVbgzAvyohgvnXCCQ/Z/PK+ojVCBdGiyw0lBhOibOA2
 sZ4cXi7/Va0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029718"
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
Subject: [PATCH V4 08/18] iommu/ioasid: Introduce ioasid_set private ID
Date:   Sat, 27 Feb 2021 14:01:16 -0800
Message-Id: <1614463286-97618-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an IOASID set is used for guest SVA, each VM will acquire its
ioasid_set for IOASID allocations. IOASIDs within the VM must have a
host/physical IOASID backing, mapping between guest and host IOASIDs can
be non-identical. IOASID set private ID (SPID) is introduced in this
patch to be used as guest IOASID. However, the concept of ioasid_set
specific namespace is generic, thus named SPID.

As SPID namespace is within the IOASID set, the IOASID core can provide
lookup services at both directions. SPIDs may not be available when its
IOASID is allocated, the mapping between SPID and IOASID is usually
established when a guest page table is bound to a host PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 104 +++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  18 +++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 9a3ba157dec3..7707bb608bdd 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -26,6 +26,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @refs:	Number of active users
  * @state:	Track state of the IOASID
  * @set:	ioasid_set of the IOASID belongs to
@@ -34,6 +35,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
@@ -413,6 +415,107 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid, bool get)
+{
+	ioasid_t ioasid = INVALID_IOASID;
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!xa_load(&ioasid_sets, set->id)) {
+		pr_warn("Invalid set\n");
+		goto done;
+	}
+
+	xa_for_each(&set->xa, index, entry) {
+		if (spid == entry->spid) {
+			if (get)
+				refcount_inc(&entry->refs);
+			ioasid = index;
+		}
+	}
+done:
+	return ioasid;
+}
+
+/**
+ * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
+ *
+ * @ioasid: the system-wide IOASID to attach
+ * @spid:   the ioasid_set private ID of @ioasid
+ *
+ * After attching SPID, future lookup can be done via ioasid_find_by_spid().
+ */
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	struct ioasid_data *data;
+	int ret = 0;
+
+	if (spid == INVALID_IOASID)
+		return -EINVAL;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data) {
+		pr_err("No IOASID entry %d to attach SPID %d\n",
+			ioasid, spid);
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	/* Check if SPID is unique within the set */
+	if (ioasid_find_by_spid_locked(data->set, spid, false) != INVALID_IOASID) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	data->spid = spid;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_attach_spid);
+
+void ioasid_detach_spid(ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data || data->spid == INVALID_IOASID) {
+		pr_err("Invalid IOASID entry %d to detach\n", ioasid);
+		goto done_unlock;
+	}
+	data->spid = INVALID_IOASID;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_spid);
+
+/**
+ * ioasid_find_by_spid - Find the system-wide IOASID by a set private ID and
+ * its set.
+ *
+ * @set:	the ioasid_set to search within
+ * @spid:	the set private ID
+ * @get:	flag indicates whether to take a reference once found
+ *
+ * Given a set private ID and its IOASID set, find the system-wide IOASID. Take
+ * a reference upon finding the matching IOASID if @get is true. Return
+ * INVALID_IOASID if the IOASID is not found in the set or the set is not valid.
+ */
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid, bool get)
+{
+	ioasid_t ioasid;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid = ioasid_find_by_spid_locked(set, spid, get);
+	spin_unlock(&ioasid_allocator_lock);
+	return ioasid;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
 static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 {
 	return xa_load(&ioasid_sets, set->id) == set;
@@ -616,6 +719,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	}
 	data->id = id;
 	data->state = IOASID_STATE_IDLE;
+	data->spid = INVALID_IOASID;
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e7f3e6108724..dcab02886cb5 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -81,6 +81,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+void ioasid_detach_spid(ioasid_t ioasid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid, bool get);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -173,6 +176,21 @@ static inline struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_detach_spid(ioasid_t ioasid)
+{
+}
+
+static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set,
+					   ioasid_t spid, bool get)
+{
+	return INVALID_IOASID;
+}
+
 static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void (*fn)(ioasid_t id, void *data),
 					      void *data)
-- 
2.25.1


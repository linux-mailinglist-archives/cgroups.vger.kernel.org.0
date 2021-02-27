Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED532713B
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhB1GjS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:39:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:58906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhB1GjR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:39:17 -0500
IronPort-SDR: aILBJfqjFPtahqgTZR14V+myG6OAun+cJTUTLpi4maZlDn/55aZJ54ObFa0TgeWyLVnIbYCXK5
 KZBRbCFV5WRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323900"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323900"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: VrZJZwJodmU5qUGZ+9ceNagDJjwlny1JNhVfnRkF52W6Wr6uM7A2o27iKh6XhNJCdSkbpnNKEJ
 de9L3zbadR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029721"
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
Subject: [PATCH V4 09/18] iommu/ioasid: Introduce notification APIs
Date:   Sat, 27 Feb 2021 14:01:17 -0800
Message-Id: <1614463286-97618-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Relations among IOASID users largely follow a publisher-subscriber
pattern. E.g. to support guest SVA on Intel Scalable I/O Virtualization
(SIOV) enabled platforms, VFIO, IOMMU, device drivers, KVM are all users
of IOASIDs. When a state change occurs, VFIO publishes the change event
that needs to be processed by other users/subscribers.

This patch introduced two types of notifications: global and per
ioasid_set. The latter is intended for users who only needs to handle
events related to the IOASID of a given set.
For more information, refer to the kernel documentation at
Documentation/ioasid.rst.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 111 +++++++++++++++++++++++++++++++++++++++--
 include/linux/ioasid.h |  54 ++++++++++++++++++++
 2 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 7707bb608bdd..56577e745c4b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,12 +10,33 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/*
+ * An IOASID can have multiple consumers where each consumer may have
+ * hardware contexts associated with the IOASID.
+ * When a status change occurs, like on IOASID deallocation, notifier chains
+ * are used to keep the consumers in sync.
+ * This is a publisher-subscriber pattern where publisher can change the
+ * state of each IOASID, e.g. alloc/free, bind IOASID to a device and mm.
+ * On the other hand, subscribers get notified for the state change and
+ * keep local states in sync.
+ */
+static ATOMIC_NOTIFIER_HEAD(ioasid_notifier);
+static DEFINE_SPINLOCK(ioasid_nb_lock);
+
 /* Default to PCIe standard 20 bit PASID */
 #define PCI_PASID_MAX 0x100000
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+struct ioasid_set_nb {
+	struct list_head	list;
+	struct notifier_block	*nb;
+	void			*token;
+	struct ioasid_set	*set;
+	bool			active;
+};
+
 enum ioasid_state {
 	IOASID_STATE_IDLE,
 	IOASID_STATE_ACTIVE,
@@ -415,6 +436,38 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+/**
+ * ioasid_notify - Send notification on a given IOASID for status change.
+ *
+ * @data:	The IOASID data to which the notification will send
+ * @cmd:	Notification event sent by IOASID external users, can be
+ *		IOASID_BIND or IOASID_UNBIND.
+ *
+ * @flags:	Special instructions, e.g. notify within a set or global by
+ *		IOASID_NOTIFY_FLAG_SET or IOASID_NOTIFY_FLAG_ALL flags
+ * Caller must hold ioasid_allocator_lock and reference to the IOASID
+ */
+static int ioasid_notify(struct ioasid_data *data,
+			 enum ioasid_notify_val cmd, unsigned int flags)
+{
+	struct ioasid_nb_args args = { 0 };
+	int ret = 0;
+
+	if (flags & ~(IOASID_NOTIFY_FLAG_ALL | IOASID_NOTIFY_FLAG_SET))
+		return -EINVAL;
+
+	args.id = data->id;
+	args.set = data->set;
+	args.pdata = data->private;
+	args.spid = data->spid;
+	if (flags & IOASID_NOTIFY_FLAG_ALL)
+		ret = atomic_notifier_call_chain(&ioasid_notifier, cmd, &args);
+	if (flags & IOASID_NOTIFY_FLAG_SET)
+		ret = atomic_notifier_call_chain(&data->set->nh, cmd, &args);
+
+	return ret;
+}
+
 static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid, bool get)
 {
 	ioasid_t ioasid = INVALID_IOASID;
@@ -468,7 +521,7 @@ int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
 		goto done_unlock;
 	}
 	data->spid = spid;
-
+	ioasid_notify(data, IOASID_NOTIFY_BIND, IOASID_NOTIFY_FLAG_SET);
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
 	return ret;
@@ -486,8 +539,8 @@ void ioasid_detach_spid(ioasid_t ioasid)
 		pr_err("Invalid IOASID entry %d to detach\n", ioasid);
 		goto done_unlock;
 	}
+	ioasid_notify(data, IOASID_NOTIFY_UNBIND, IOASID_NOTIFY_FLAG_SET);
 	data->spid = INVALID_IOASID;
-
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
 }
@@ -603,6 +656,8 @@ struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
 	set->quota = quota;
 	set->id = id;
 	atomic_set(&set->nr_ioasids, 0);
+	ATOMIC_INIT_NOTIFIER_HEAD(&set->nh);
+
 	/*
 	 * Per set XA is used to store private IDs within the set, get ready
 	 * for ioasid_set private ID and system-wide IOASID allocation
@@ -655,7 +710,9 @@ int ioasid_set_free(struct ioasid_set *set)
 	int ret = 0;
 
 	spin_lock(&ioasid_allocator_lock);
+	spin_lock(&ioasid_nb_lock);
 	ret = ioasid_set_free_locked(set);
+	spin_unlock(&ioasid_nb_lock);
 	spin_unlock(&ioasid_allocator_lock);
 	return ret;
 }
@@ -728,6 +785,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	atomic_inc(&set->nr_ioasids);
+	ioasid_notify(data, IOASID_NOTIFY_ALLOC, IOASID_NOTIFY_FLAG_SET);
 	goto done_unlock;
 exit_free:
 	kfree(data);
@@ -780,9 +838,11 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 	 * If the refcount is 1, it means there is no other users of the IOASID
 	 * other than IOASID core itself. There is no need to notify anyone.
 	 */
-	if (!refcount_dec_and_test(&data->refs))
+	if (!refcount_dec_and_test(&data->refs)) {
+		ioasid_notify(data, IOASID_NOTIFY_FREE,
+			IOASID_NOTIFY_FLAG_SET | IOASID_NOTIFY_FLAG_ALL);
 		return;
-
+	}
 	ioasid_do_free_locked(data);
 }
 
@@ -833,15 +893,39 @@ void ioasid_free_all_in_set(struct ioasid_set *set)
 	if (!atomic_read(&set->nr_ioasids))
 		return;
 	spin_lock(&ioasid_allocator_lock);
+	spin_lock(&ioasid_nb_lock);
 	xa_for_each(&set->xa, index, entry) {
 		ioasid_free_locked(set, index);
 		/* Free from per set private pool */
 		xa_erase(&set->xa, index);
 	}
+	spin_unlock(&ioasid_nb_lock);
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free_all_in_set);
 
+/*
+ * ioasid_find_mm_set - Retrieve IOASID set with mm token
+ * Take a reference of the set if found.
+ */
+struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
+{
+	struct ioasid_set *set;
+	unsigned long index;
+
+	spin_lock(&ioasid_allocator_lock);
+
+	xa_for_each(&ioasid_sets, index, set) {
+		if (set->type == IOASID_SET_TYPE_MM && set->token == token)
+			goto exit_unlock;
+	}
+	set = NULL;
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return set;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_mm_set);
+
 /**
  * ioasid_set_for_each_ioasid
  * @brief
@@ -1021,6 +1105,25 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 }
 EXPORT_SYMBOL_GPL(ioasid_find);
 
+int ioasid_register_notifier(struct ioasid_set *set, struct notifier_block *nb)
+{
+	if (set)
+		return atomic_notifier_chain_register(&set->nh, nb);
+	else
+		return atomic_notifier_chain_register(&ioasid_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier);
+
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb)
+{
+	if (set)
+		atomic_notifier_chain_unregister(&set->nh, nb);
+	else
+		atomic_notifier_chain_unregister(&ioasid_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index dcab02886cb5..d8b85a04214f 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -58,6 +58,47 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_NOTIFY_ALLOC = 1,
+	IOASID_NOTIFY_FREE,
+	IOASID_NOTIFY_BIND,
+	IOASID_NOTIFY_UNBIND,
+};
+
+#define IOASID_NOTIFY_FLAG_ALL BIT(0)
+#define IOASID_NOTIFY_FLAG_SET BIT(1)
+/**
+ * enum ioasid_notifier_prios - IOASID event notification order
+ *
+ * When status of an IOASID changes, users might need to take actions to
+ * reflect the new state. For example, when an IOASID is freed due to
+ * exception, the hardware context in virtual CPU, DMA device, and IOMMU
+ * shall be cleared and drained. Order is required to prevent life cycle
+ * problems.
+ */
+enum ioasid_notifier_prios {
+	IOASID_PRIO_LAST,
+	IOASID_PRIO_DEVICE,
+	IOASID_PRIO_IOMMU,
+	IOASID_PRIO_CPU,
+};
+
+/**
+ * struct ioasid_nb_args - Argument provided by IOASID core when notifier
+ * is called.
+ * @id:		The IOASID being notified
+ * @spid:	The set private ID associated with the IOASID
+ * @set:	The IOASID set of @id
+ * @pdata:	The private data attached to the IOASID
+ */
+struct ioasid_nb_args {
+	ioasid_t id;
+	ioasid_t spid;
+	struct ioasid_set *set;
+	void *pdata;
+};
+
 #if IS_ENABLED(CONFIG_IOASID)
 void ioasid_install_capacity(ioasid_t total);
 int ioasid_reserve_capacity(ioasid_t nr_ioasid);
@@ -84,6 +125,10 @@ void ioasid_detach_data(ioasid_t ioasid);
 int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
 void ioasid_detach_spid(ioasid_t ioasid);
 ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid, bool get);
+int ioasid_register_notifier(struct ioasid_set *set,
+			struct notifier_block *nb);
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -149,6 +194,15 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	return NULL;
 }
 
+static inline int ioasid_register_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_notifier(struct notifier_block *nb)
+{
+}
+
 static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
 {
 	return -ENOTSUPP;
-- 
2.25.1


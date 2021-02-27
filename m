Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB3327143
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhB1GlS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:41:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:22647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhB1GlO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:41:14 -0500
IronPort-SDR: 815xBiSbry//imiBAL5cGslhdyf3r0qVCTsXltCIuOW84wnCz6LJnGAUiFZ/Gnvv62XyAH5+Vj
 RdDf5tE01ozA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323905"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: nuEUzNsKDtMUhF1RUH0X9vun2GR3Nd9i1TG6TUlh3vQvNaz+wKrJkzsPMRrEKHdic1AsTQ4egz
 ou1Ew5FbN91g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029734"
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
Subject: [PATCH V4 13/18] iommu/ioasid: Add a workqueue for cleanup work
Date:   Sat, 27 Feb 2021 14:01:21 -0800
Message-Id: <1614463286-97618-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An IOASID can have multiple users, such as IOMMU driver, KVM, and device
drivers.   The atomic IOASID notifier is used to inform users of IOASID
state change. For example, the IOASID_NOTIFY_UNBIND event is issued when
the IOASID is no longer bound to an address space. This requires ordered
actions among users to tear down their contexts.

Not all work can be handled in the atomic notifier handler. This patch
introduces a shared, ordered workqueue for all IOASID users who wish to
perform work asynchronously upon notification.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 25 +++++++++++++++++++++++++
 include/linux/ioasid.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 28a2e9b6594d..d42b39ca2c8b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -32,6 +32,9 @@ static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+/* Workqueue for IOASID users to do cleanup upon notification */
+static struct workqueue_struct *ioasid_wq;
+
 struct ioasid_set_nb {
 	struct list_head	list;
 	struct notifier_block	*nb;
@@ -1281,6 +1284,12 @@ int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
 
+bool ioasid_queue_work(struct work_struct *work)
+{
+	return queue_work(ioasid_wq, work);
+}
+EXPORT_SYMBOL_GPL(ioasid_queue_work);
+
 void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
 {
 	struct ioasid_set_nb *curr;
@@ -1303,7 +1312,23 @@ void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
 
+static int __init ioasid_init(void)
+{
+	ioasid_wq = alloc_ordered_workqueue("ioasid_wq", 0);
+	if (!ioasid_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit ioasid_cleanup(void)
+{
+	destroy_workqueue(ioasid_wq);
+}
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
 MODULE_LICENSE("GPL");
+module_init(ioasid_init);
+module_exit(ioasid_cleanup);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 9624b665f810..4547086797df 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -135,6 +135,7 @@ void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void *data);
 int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
 void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+bool ioasid_queue_work(struct work_struct *work);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
-- 
2.25.1


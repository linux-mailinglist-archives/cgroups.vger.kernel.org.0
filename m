Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3365232713F
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhB1Gkf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:40:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:58903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhB1Gkc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:40:32 -0500
IronPort-SDR: eQAejra+x68Q7xpZJpoST7/LS0o2p5KPZwe96HsBWZYgWLNXfK65o2ip8mXwymd3wLt6eUTh9C
 PMTK/igxQSdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323903"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: zRnRxXScn+KW1qsE4bGRWvsozcby9n3F2xNpTl8FDxjxDrV6padueFBgOK9oRk8roY+tedX8oE
 7aWkAIKkj1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029728"
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
Subject: [PATCH V4 11/18] iommu/ioasid: Add ownership check in guest bind
Date:   Sat, 27 Feb 2021 14:01:19 -0800
Message-Id: <1614463286-97618-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bind guest page table call comes with an IOASID provided by the
userspace.  To prevent attacks by malicious users, we must ensure the
IOASID was allocated under the same process.

This patch adds a new API that will perform an ownership check that is
based on whether the IOASID belongs to the ioasid_set allocated with the
mm_struct pointer as a token.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c  | 16 ++++++++++++++--
 include/linux/ioasid.h |  6 ++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 96e941dfada7..28a2e9b6594d 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
+#include <linux/sched/mm.h>
 
 /*
  * An IOASID can have multiple consumers where each consumer may have
@@ -1028,6 +1029,42 @@ int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_get);
 
+/**
+ * ioasid_get_if_owned - obtain a reference to the IOASID if the IOASID belongs
+ * 		to the ioasid_set with the current mm as token
+ * @ioasid:	the IOASID to get reference
+ *
+ *
+ * Return: 0 on success, error if failed.
+ */
+int ioasid_get_if_owned(ioasid_t ioasid)
+{
+	struct ioasid_set *set;
+	int ret;
+
+	spin_lock(&ioasid_allocator_lock);
+	set = ioasid_find_set(ioasid);
+	if (IS_ERR_OR_NULL(set)) {
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	if (set->type != IOASID_SET_TYPE_MM) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	if (current->mm != set->token) {
+		ret = -EPERM;
+		goto done_unlock;
+	}
+
+	ret = ioasid_get_locked(set, ioasid);
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_if_owned);
+
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	struct ioasid_data *data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fd76e2f579fe..18716d856b02 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2169,7 +2169,13 @@ int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (ret)
 		return ret;
 
-	return domain->ops->sva_bind_gpasid(domain, dev, &data);
+	ret = ioasid_get_if_owned(data.hpasid);
+	if (ret)
+		return ret;
+	ret = domain->ops->sva_bind_gpasid(domain, dev, &data);
+	ioasid_put(NULL, data.hpasid);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
@@ -2196,7 +2202,13 @@ int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev
 	if (ret)
 		return ret;
 
-	return iommu_sva_unbind_gpasid(domain, dev, data.hpasid);
+	ret = ioasid_get_if_owned(data.hpasid);
+	if (ret)
+		return ret;
+	ret = iommu_sva_unbind_gpasid(domain, dev, data.hpasid);
+	ioasid_put(NULL, data.hpasid);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index c97e80ff65cc..9624b665f810 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -111,6 +111,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
 int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_if_owned(ioasid_t ioasid);
 bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
@@ -180,6 +181,11 @@ static inline int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 	return -ENOTSUPP;
 }
 
+static inline int ioasid_get_if_owned(ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
 static inline bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
 {
 	return false;
-- 
2.25.1


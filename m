Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C032714A
	for <lists+cgroups@lfdr.de>; Sun, 28 Feb 2021 07:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhB1GnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Feb 2021 01:43:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:22647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhB1Gmh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 28 Feb 2021 01:42:37 -0500
IronPort-SDR: Gcu4fLdgVpeUKsyGAnuHFZ6KhJK10DDgazZjYxuOQoOuEKJWDoL5/1LKmKrSGQlYWuNe7V4pNB
 o0r+AzSHzqoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323911"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323911"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: /Vzm0YxkFjeFo6ut3o7v8+CqkNKZmbSAXqjq6gYi8tI9Cq3f5u00e2T2qIXbb6ACQZFeTKeC4p
 4bI+20WBl1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029743"
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
Subject: [RFC PATCH 16/18] iommu/ioasid: Consult IOASIDs cgroup for allocation
Date:   Sat, 27 Feb 2021 14:01:24 -0800
Message-Id: <1614463286-97618-17-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Once IOASIDs cgroup is active, we must consult the limitation set up
by the cgroups during allocation. Freeing IOASIDs also need to return
the quota back to the cgroup.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index d42b39ca2c8b..fd3f5729c71d 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -782,7 +782,10 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	spin_lock(&ioasid_allocator_lock);
 	/* Check if the IOASID set has been allocated and initialized */
-	if (!ioasid_set_is_valid(set))
+	if (!set || !ioasid_set_is_valid(set))
+		goto done_unlock;
+
+	if (set->type == IOASID_SET_TYPE_MM && ioasid_cg_charge(set))
 		goto done_unlock;
 
 	if (set->quota <= atomic_read(&set->nr_ioasids)) {
@@ -832,6 +835,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	goto done_unlock;
 exit_free:
 	kfree(data);
+	ioasid_cg_uncharge(set);
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
 	return id;
@@ -849,6 +853,7 @@ static void ioasid_do_free_locked(struct ioasid_data *data)
 		kfree_rcu(ioasid_data, rcu);
 	}
 	atomic_dec(&data->set->nr_ioasids);
+	ioasid_cg_uncharge(data->set);
 	xa_erase(&data->set->xa, data->id);
 	/* Destroy the set if empty */
 	if (!atomic_read(&data->set->nr_ioasids))
-- 
2.25.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A8622FD8
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKIQM3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 11:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKIQMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 11:12:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B310543;
        Wed,  9 Nov 2022 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010340; x=1699546340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIk/9mO9BwW8K7kgNQr0OR9vwi+NAqyFfuSgODl/DSc=;
  b=EoAH1m8RfJaGmA0O8K/mo7xEbTHN0CSGPlcq1hfrg7+Obmkfd9J5/nrZ
   Tt0DVZ+GY0jSF8Jqqoz7I/9tmWAJKEPhg6/6xJDdS/MMd5wCuuUijsGtd
   NvMi7vtz8rj/Dcdbvm2I1vJqoynp4CGI7YlkhG54MAu2b5xlr+uhwHk+I
   bPAgC9b00k8RI7x9iwJbLaAMvYqyaoYs8Gej/k9KSNPPuU+9qYzyx/vgd
   RdV5bB1yascVM+G8hrsy9cAi9eFSTAhcLQkVLsMmF4F19RT6SlIZkJqq2
   qCv4ECvS00e2mM9wq0wYg0BqueM7K5iAgo036E02m6ntYGEw1ciOLZAcp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312181362"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312181362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811684509"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811684509"
Received: from smurnane-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:12:17 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 06/13] drm/cgroup: Allow safe external access to file_priv
Date:   Wed,  9 Nov 2022 16:11:34 +0000
Message-Id: <20221109161141.2987173-7-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
References: <20221109161141.2987173-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Entry points from the cgroup subsystem into the drm cgroup controller will
need to walk the file_priv structures associated with registered clients
and since those are not RCU protected lets add a hack for now to make this
safe.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 56aa8303974a..94e6f39b90c7 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -17,6 +17,13 @@ __del_clients(struct drm_pid_clients *clients,
 	if (atomic_dec_and_test(&clients->num)) {
 		xa_erase(&drm_pid_clients, pid);
 		kfree_rcu(clients, rcu);
+
+		/*
+		 * FIXME: file_priv is not RCU protected so we add this hack
+		 * to avoid any races with code which walks clients->file_list
+		 * and accesses file_priv.
+		 */
+		synchronize_rcu();
 	}
 }
 
-- 
2.34.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAAA667CA9
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 18:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjALRhU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjALRgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 12:36:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C756C7826E;
        Thu, 12 Jan 2023 08:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673542679; x=1705078679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gA5/njLr6I387+ufsBDRnAQjKtZ0ST5kVZFmIu51Hl0=;
  b=OsJ7nj+RG9O+8htK08tYbUjwRBCUde4UInFKJj9eHhZ3/IhKYGzacD6k
   fEm9/5SW13OlNcVtbSc0qqmoylBSRDCp0+rM5G0GreWqig3F1riso2cJm
   k8Lepfn9IzWLDi3Lftq28XJS6scZpdtApcjEYtz5g8H5KepFzQCvrhICc
   Zrej3Rq9Pr93HbrK/O5jeuNeM3XIEF58diEzdPdUIFWNdK4vcj2mX1rFS
   hHoGlXhZonPDwoBVGHv9WgWfsxTL7jkQXP3PwSH6n49ZwAoO/I0nH7260
   6ftB3MZgmyCGhnUU19mn5q4PD4AVQqL+1pgZ6ToOUQDrDlgex34OH2Gbd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325016435"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325016435"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:56:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651232719"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="651232719"
Received: from jacton-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.195.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:56:42 -0800
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
Subject: [RFC 05/12] drm/cgroup: Allow safe external access to file_priv
Date:   Thu, 12 Jan 2023 16:56:02 +0000
Message-Id: <20230112165609.1083270-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index d91512a560ff..46b012d2be42 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -18,6 +18,13 @@ __del_clients(struct drm_pid_clients *clients,
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


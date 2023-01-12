Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE277667CAB
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 18:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjALRhi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 12:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjALRgx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 12:36:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA560CBBC9;
        Thu, 12 Jan 2023 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673542685; x=1705078685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4XaQU0KHXm7hstqYZ0YTz10nkjZFCF6V51/eW89DXg=;
  b=UvOK29aweZah2HmcgZ4TU4AIluBFTxEUwOIi927JbKEuIQH8AWQFlDdb
   hSlzWWNtEjLGGbrqgAGRzRRIVcX7TNicW9/aF8xBGeQOVTSGsQj9Q4YUL
   MzOEO2rxDsrKsU2eKXV8mfMq3f7n0phwIWkD3taqTWgHS8Cwj4ByXPj4S
   6R3dmSV0wexEI5skjJmBxplMybxosTpMovBVXQq8r7ejIFRPsA3spkGti
   KSgJ2QsbWrRxF0Ea0VzRBod0O/TH1SUMEQoTXAY0mFWaV8x7lW3NeoFhi
   MCZVlrsTCMB+Aw4zvPtdiKfqgBVZ0TiOLMh5xmLKa7ZEXECXTOntiLqLw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325016536"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325016536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:57:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651232885"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="651232885"
Received: from jacton-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.195.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:56:54 -0800
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
Subject: [RFC 08/12] drm/cgroup: Only track clients which are providing drm_cgroup_ops
Date:   Thu, 12 Jan 2023 16:56:05 +0000
Message-Id: <20230112165609.1083270-9-tvrtko.ursulin@linux.intel.com>
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

To reduce the number of tracking going on, especially with drivers which
will not support any sort of control from the drm cgroup controller side,
lets express the funcionality as opt-in and use the presence of
drm_cgroup_ops as activation criteria.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/drm_cgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index ef951421bba6..09249f795af3 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -36,6 +36,9 @@ void drm_clients_close(struct drm_file *file_priv)
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
+	if (!dev->driver->cg_ops)
+		return;
+
 	pid = rcu_access_pointer(file_priv->pid);
 	clients = xa_load(&drm_pid_clients, (unsigned long)pid);
 	if (drm_WARN_ON_ONCE(dev, !clients))
@@ -67,6 +70,9 @@ int drm_clients_open(struct drm_file *file_priv)
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
+	if (!dev->driver->cg_ops)
+		return 0;
+
 	pid = (unsigned long)rcu_access_pointer(file_priv->pid);
 	clients = xa_load(&drm_pid_clients, pid);
 	if (!clients) {
@@ -102,6 +108,9 @@ drm_clients_migrate(struct drm_file *file_priv,
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
+	if (!dev->driver->cg_ops)
+		return;
+
 	existing_clients = xa_load(&drm_pid_clients, (unsigned long)new);
 	clients = xa_load(&drm_pid_clients, (unsigned long)old);
 
-- 
2.34.1


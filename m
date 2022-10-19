Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0A604ECD
	for <lists+cgroups@lfdr.de>; Wed, 19 Oct 2022 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJSReB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Oct 2022 13:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJSRdt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Oct 2022 13:33:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E141D3A76;
        Wed, 19 Oct 2022 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666200821; x=1697736821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqVOHpteUQeCev/lgNedZY6IzAYCvefhlH9jg3GlMDs=;
  b=jPHY5/x81a0xSghusQWgWUnxMIGI7eLUovAd9IlxAWf5rqfxRx1xCiI2
   RjrUvZSjLoHukW1LCkOV0gvbidoHk0kctR/TEGE+maw5hYYDWPYXTRaXN
   xNDGBXcv7lHbZj9cSkghu46jEnHPEG899xZCm2jQY+M17Sk5XhwEhlXI/
   mYdNUl2d8JptTdxYql1l54S0NsYKBbqasHTjI+bpJyjMuOnIoXMNkQW7w
   gn/X0pnfX0D5YjEGcvpvTgzBC2XVwNh+Ql+aRff++nfimRWLeBq5nZFmB
   WnASx8D0asUFzc5Z5/gIJ4FULwnKMA0mKgtpJCG8GX15DlxhARfmxq0W+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306474406"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306474406"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607204754"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607204754"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.213.233.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:33:36 -0700
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
Subject: [RFC 06/17] drm: Only track clients which are providing drm_cgroup_ops
Date:   Wed, 19 Oct 2022 18:32:43 +0100
Message-Id: <20221019173254.3361334-7-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/drm_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_cgroup.c b/drivers/gpu/drm/drm_cgroup.c
index 0fbb88f08cef..7ed9c7150cae 100644
--- a/drivers/gpu/drm/drm_cgroup.c
+++ b/drivers/gpu/drm/drm_cgroup.c
@@ -16,6 +16,9 @@ void drm_clients_close(struct drm_file *file_priv)
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
+	if (!dev->driver->cg_ops)
+		return;
+
 	clients = xa_load(&drm_pid_clients, pid);
 	list_del_rcu(&file_priv->clink);
 	if (atomic_dec_and_test(&clients->num)) {
@@ -40,6 +43,9 @@ int drm_clients_open(struct drm_file *file_priv)
 
 	lockdep_assert_held(&dev->filelist_mutex);
 
+	if (!dev->driver->cg_ops)
+		return 0;
+
 	clients = xa_load(&drm_pid_clients, pid);
 	if (!clients) {
 		clients = kmalloc(sizeof(*clients), GFP_KERNEL);
-- 
2.34.1


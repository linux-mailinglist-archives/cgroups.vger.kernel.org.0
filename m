Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11EE7506D7
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjGLLtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjGLLsb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 07:48:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE121BCF;
        Wed, 12 Jul 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689162485; x=1720698485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75FdISXFIBIdArdQdqTeYKagFkSfhuce1VMLySmuSgc=;
  b=GaexiT5K53vjhvp4AxIMftCnCf1nQVSmCRxnn5us5VsJvrj0rSr/ZsXZ
   aAj1ocWxtyKCWAo4D9lv8IIrbzT9QoPD1CyHUZVrEBVQ0Qf/jSCJpIhVZ
   IKuOKr9+fEVOnqEEaqzq3FBepgakDhV7GgdOUeI5arUqifD9D6/RC9Z8v
   k5UWNZuqli0H5hsK1OW1QUOwmyM4eQOHmM6XWHeOFIOR16WFUQpbRcaAt
   BqHmbCPEATLZZADwZLVaSrzAwqTPLvLqQHTVTVN8jxogxaPDI3mg1Drbk
   wWPkT/ZRPrDNUmUktfd/0inMYQmDPZcKLvXrMZR4wD3RsSn/kvgqYFgqK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344469096"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344469096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="866094042"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="866094042"
Received: from eamonnob-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.237.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:46:24 -0700
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>
Subject: [PATCH 03/17] drm/i915: Track page table backing store usage
Date:   Wed, 12 Jul 2023 12:45:51 +0100
Message-Id: <20230712114605.519432-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Account page table backing store against the owning client memory usage
stats.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Aravind Iddamsetty <aravind.iddamsetty@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gtt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 731d9f2bbc56..065099362a98 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -58,6 +58,9 @@ struct drm_i915_gem_object *alloc_pt_lmem(struct i915_address_space *vm, int sz)
 	if (!IS_ERR(obj)) {
 		obj->base.resv = i915_vm_resv_get(vm);
 		obj->shares_resv_from = vm;
+
+		if (vm->fpriv)
+			i915_drm_client_add_object(vm->fpriv->client, obj);
 	}
 
 	return obj;
@@ -79,6 +82,9 @@ struct drm_i915_gem_object *alloc_pt_dma(struct i915_address_space *vm, int sz)
 	if (!IS_ERR(obj)) {
 		obj->base.resv = i915_vm_resv_get(vm);
 		obj->shares_resv_from = vm;
+
+		if (vm->fpriv)
+			i915_drm_client_add_object(vm->fpriv->client, obj);
 	}
 
 	return obj;
-- 
2.39.2


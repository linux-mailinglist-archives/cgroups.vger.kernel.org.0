Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4B34B07E7
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiBJIPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 03:15:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiBJIPN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 03:15:13 -0500
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0871097
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:15:15 -0800 (PST)
Received: by mail-ot1-x349.google.com with SMTP id r16-20020a9d7510000000b0059ea94f86eeso3049076otk.8
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fMIRROeDCCygpucOKIXnuDRE53blx2Fd4oRcgvywHRM=;
        b=FRPbX4D29kIW+qlbRohcly9kDDAZugoZr12c4pn83sXCQupHVz5i02c232pWifGcJX
         f2VKxeODp/d70mILcDiRehpZ84CcGH2l4Jn8IWMs4foCylEa2D1UArVeTuzjixJC4rGk
         b0lpopdNyBq7R31A1Xpm2gJf9dqmgq86WKoAW4JWyZkT0TVi9iUwsw/k72UOWMw0GRU/
         QwbJNQCB1nO+jRIaSvwfKU42p7UXYBKyV9mgSFEGC+oPAVPT/hlWXU2lWmHOp6OqocJT
         xCfPQ42G1pJE/BGDOmZi69jA2Ce89s0XXfjxxywhmito7sKfPstoFHyxIl1vspcP3YBe
         8Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fMIRROeDCCygpucOKIXnuDRE53blx2Fd4oRcgvywHRM=;
        b=ur4pVKRTclDmyz8jKhJv1NthxTd/Bl8lPIyxyapR+NOO/LBkczC9NK7cGQVBFg4aBU
         3HA2cY+8CDlEbC7yGcpNQ3C/vaBtim0vzy0LwnMHt/4G0VkbjF1lfFv85kLBlzfs9YjH
         6YoLd65y9ArOGyhdS/+V9dI2DC9mwutsa7wLSyA3mgF39WZ2lgsHui4KwuoiSZVhs8QY
         4fnN+fO7Xb0H/zlAb0AFIyJd3kW8eC0/yZ9T6OHXpLWkPbaowKcEpY1bMZttDresg9VK
         lW6sCn9gsZc/2di+hpqjnBgeHFnXPDDa/dzr4biWdBaWx8PXiaTTwXNDfHk8yOyXy07R
         831Q==
X-Gm-Message-State: AOAM530zy7rQokrLRkqpOcVKpzCtQ1SBtkz2O1YravKRQwzLAe+8kFQ1
        qBweYde7F/6ZPcqftSwzjCI7b+1Z/Ldwmw==
X-Google-Smtp-Source: ABdhPJz+on117snT7bOCtSLvD9iOqUc+SsXLOOIUNv5jfVv7ihoMT5nMaQ/B9QQRCQ3v0WFDclrnAWBpAbrChg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6801:6774:cb90:c600])
 (user=shakeelb job=sendgmr) by 2002:a05:6870:9514:: with SMTP id
 u20mr427457oal.84.1644480914945; Thu, 10 Feb 2022 00:15:14 -0800 (PST)
Date:   Thu, 10 Feb 2022 00:14:35 -0800
In-Reply-To: <20220210081437.1884008-1-shakeelb@google.com>
Message-Id: <20220210081437.1884008-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 2/4] memcg: unify force charging conditions
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the kernel force charges the allocations which have __GFP_HIGH
flag without triggering the memory reclaim. __GFP_HIGH indicates that
the caller is high priority and since commit 869712fd3de5 ("mm:
memcontrol: fix network errors from failing __GFP_ATOMIC charges") the
kernel let such allocations do force charging. Please note that
__GFP_ATOMIC has been replaced by __GFP_HIGH.

__GFP_HIGH does not tell if the caller can block or can trigger reclaim.
There are separate checks to determine that. So, there is no need to
skip reclaim for __GFP_HIGH allocations. So, handle __GFP_HIGH together
with __GFP_NOFAIL which also does force charging.

Please note that this is a noop change as there are no __GFP_HIGH
allocators in kernel which also have __GFP_ACCOUNT (or SLAB_ACCOUNT) and
does not allow reclaim for now. The reason for this patch is to simplify
the reasoning of the following patches.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c40c27822802..ae73a40818b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2560,15 +2560,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 
-	/*
-	 * Memcg doesn't have a dedicated reserve for atomic
-	 * allocations. But like the global atomic pool, we need to
-	 * put the burden of reclaim on regular allocation requests
-	 * and let these go through as privileged allocations.
-	 */
-	if (gfp_mask & __GFP_HIGH)
-		goto force;
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2642,7 +2633,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 nomem:
-	if (!(gfp_mask & __GFP_NOFAIL))
+	/*
+	 * Memcg doesn't have a dedicated reserve for atomic
+	 * allocations. But like the global atomic pool, we need to
+	 * put the burden of reclaim on regular allocation requests
+	 * and let these go through as privileged allocations.
+	 */
+	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
 		return -ENOMEM;
 force:
 	/*
-- 
2.35.1.265.g69c8d7142f-goog


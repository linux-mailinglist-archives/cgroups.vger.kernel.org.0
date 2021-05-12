Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6837B398
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 03:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhELBlV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 21:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhELBlG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 May 2021 21:41:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F2C06175F;
        Tue, 11 May 2021 18:38:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q136so20786930qka.7;
        Tue, 11 May 2021 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=d3aJ5j7JBzKc8yEhunqWFAOzUi7zPVe+7NyqT4o60cM=;
        b=PamcIlzQ+uY1mZJVPp5xmvsy/F+ht6T23gkJYSsTYC1EdUJAUJFnV33pxVPpEDcQlV
         pu+PzGeV0NXACy9NbTkAQnpwt2kIYf99BWoZPH+p64MWzvj1PThC2yEeou3lRM0vwNWg
         +IGpSmRiq8UYzTlck0yGHskwhTPd/37ZSM89Mj3KMcPm0Z8y0UR9ToS4plpDhWw2Ss5u
         bReABk0CmHPJ+kU5a6D2+9//iRTlK/MzQoHNpiWQMqzIBNxkQ8c8XbW2uRRVAkQ88Cit
         sg6TUw4dATGs2+qM8TT9UWfFQVqqJ0tNNCNDUwMc4iQQEhoZsxDfvAf5G35yBv9DHgFn
         1knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=d3aJ5j7JBzKc8yEhunqWFAOzUi7zPVe+7NyqT4o60cM=;
        b=NrQ3T/2I68vV2GN5qpdH8D6/s4EQCd6/Geq49hYE2XIsTS3glBskNJnu/pMgX80bz7
         IM3GblYhKehQkI9QT6I6dRsIphjCgqWHC2K9W/V6c6zPneUdCINqhibJGNwusq44Zq+6
         7AF4AvvSeDVZy4fTS8u3t8cHN3OaSizhSo2H4OVZLaNSQiIK3kaCG6jFUtbSVC17RuBS
         KtdB226HSdgig9XzXCDoAT2z10W+2Tg++q3aYgQCG+pqyby8Ybj4Svz93+rxhGcBebR5
         qGufmdUcItGbQ+zV8En7MtyFCkWQQwZZMiJzwF2/qjQ4uemFfcGU8WrJ7AdQXQqDwh3T
         bQeg==
X-Gm-Message-State: AOAM531aLFR6nwo7FAgoYBUgTOp5h7EukDoHp9+aQD8Nut9UJ8AQnrZr
        xT9a2E6nwXlb5VylAn9LKVU=
X-Google-Smtp-Source: ABdhPJy4FOzO4zz4CgFvrNhDRcz4ErZEHo5xCufKzsS69hNlRbRfkz8CUqITZz6C2dCdKhYihBI1Eg==
X-Received: by 2002:a05:620a:1311:: with SMTP id o17mr19479984qkj.37.1620783517750;
        Tue, 11 May 2021 18:38:37 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id d2sm6113849qkn.95.2021.05.11.18.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:38:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 May 2021 21:38:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Dan Schatzberg <dschatzberg@fb.com>
Subject: [PATCH block-5.13] blk-iocost: fix weight updates of inner active
 iocgs
Message-ID: <YJsxnLZV1MnBcqjj@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the weight of an active iocg is updated, weight_updated() is called
which in turn calls __propagate_weights() to update the active and inuse
weights so that the effective hierarchical weights are update accordingly.

The current implementation is incorrect for inner active nodes. For an
active leaf iocg, inuse can be any value between 1 and active and the
difference represents how much the iocg is donating. When weight is updated,
as long as inuse is clamped between 1 and the new weight, we're alright and
this is what __propagate_weights() currently implements.

However, that's not how an active inner node's inuse is set. An inner node's
inuse is solely determined by the ratio between the sums of inuse's and
active's of its children - ie. they're results of propagating the leaves'
active and inuse weights upwards. __propagate_weights() incorrectly applies
the same clamping as for a leaf when an active inner node's weight is
updated. Consider a hierarchy which looks like the following with saturating
workloads in AA and BB.

     R
   /   \
  A     B
  |     |
 AA     BB

1. For both A and B, active=100, inuse=100, hwa=0.5, hwi=0.5.

2. echo 200 > A/io.weight

3. __propagate_weights() update A's active to 200 and leave inuse at 100 as
   it's already between 1 and the new active, making A:active=200,
   A:inuse=100. As R's active_sum is updated along with A's active,
   A:hwa=2/3, B:hwa=1/3. However, because the inuses didn't change, the
   hwi's remain unchanged at 0.5.

4. The weight of A is now twice that of B but AA and BB still have the same
   hwi of 0.5 and thus are doing the same amount of IOs.

Fix it by making __propgate_weights() always calculate the inuse of an
active inner iocg based on the ratio of child_inuse_sum to child_active_sum.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dan Schatzberg <dschatzberg@fb.com>
Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org # v5.4+
---
 block/blk-iocost.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e0c4baa018578..c2d6bc88d3f15 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1069,7 +1069,17 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 
 	lockdep_assert_held(&ioc->lock);
 
-	inuse = clamp_t(u32, inuse, 1, active);
+	/*
+	 * For an active leaf node, its inuse shouldn't be zero or exceed
+	 * @active. An active internal node's inuse is solely determined by the
+	 * inuse to active ratio of its children regardless of @inuse.
+	 */
+	if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
+		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
+					   iocg->child_active_sum);
+	} else {
+		inuse = clamp_t(u32, inuse, 1, active);
+	}
 
 	iocg->last_inuse = iocg->inuse;
 	if (save)
@@ -1086,7 +1096,7 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 		/* update the level sums */
 		parent->child_active_sum += (s32)(active - child->active);
 		parent->child_inuse_sum += (s32)(inuse - child->inuse);
-		/* apply the udpates */
+		/* apply the updates */
 		child->active = active;
 		child->inuse = inuse;
 

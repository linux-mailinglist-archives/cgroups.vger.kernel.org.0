Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE704D905D
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 00:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbiCNXbp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 19:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiCNXbo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 19:31:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26DFD10
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:30:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so16986985edl.9
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qHm6ns4crCOcaBTwUjMbD9FaBOK99gvm+HsOLXP9V1E=;
        b=GycEiFI15k/dqMhfJjR5ur8JChRl8fpPp3zxafdxMdTo8IE65VlLRln1bxzKQR0yRV
         IRUl8aJyCZ3Yalh2hP95Elt0JT3mj52pUKnBGcN5oL6JSHPXLWbKhYqoWGuLCd2LRoap
         VLZAJtKHGOZiZs1Vu3S7xYbcWe9a7d5iUA2qSwP5fGI8cEm2ZizJqD6ht5727y8diLKr
         5HvdYqgHcxB96axrmWl2/eedK4zl0501ed8ynA2oOd+6CWeik/01RXhGSNc5ObvPt3Ly
         87qSVVzFtjzq1XS4o6flLzE5r77BwZjPIO1k/GEEiNsMmstlAsvfVe1NseGCgp7Sy4xL
         OnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qHm6ns4crCOcaBTwUjMbD9FaBOK99gvm+HsOLXP9V1E=;
        b=BmJ9aFfMG4p2viNlRGu+0yVtG8sL8wPTJwAnRgOGpSzBhykQnD7rYpz0bUIKy+v5dI
         zu+yjaY+y5aNa4luo+2QFPMMgPPjZaxVWBvM5OflJpKyw4xQ7OMNeQXLIeKTEmSRpZXM
         KceCl+jMiMXaFt5PVoz5KA7PgyOx0SH/kToVs3DDc6baIsPhvG5tGg0v9yqspGYz6iuZ
         ylI9gMpoiKeD1yHQXfexFlVzQSSQAnUBf6Q7C2ggQGtiOuwayD5AoX+W1UvsRLWX0sOw
         bLstmdv5xH5YDQ3SV0fJdVqUJ5CYDWNGZuLSSlj8yJ+k6zA6S7xNfTgvmHy+EKRwNmUr
         zvzA==
X-Gm-Message-State: AOAM533OIU7BFVsjIiC8CI89kzU4dSNYrIgMCq9TpCamprkDziTIeMZl
        qLxeQyFw9fWBFv45kvGrTkA=
X-Google-Smtp-Source: ABdhPJxx2AL7sfD2+cvjeAOS3rZprmNqp3tp0jVsDzyN6cbSnTIKphYgUW/pnVahzky+WMgydova3A==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr22477433edk.392.1647300632638;
        Mon, 14 Mar 2022 16:30:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709064ad800b006d70e40bd9esm7404844ejt.15.2022.03.14.16.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Mar 2022 16:30:32 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3] mm/memcg: mz already removed from rb_tree if not NULL
Date:   Mon, 14 Mar 2022 23:30:30 +0000
Message-Id: <20220314233030.12334-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When mz is not NULL, it means mz can either come from
mem_cgroup_largest_soft_limit_node or __mem_cgroup_largest_soft_limit_nod.
And both of them has removed this node by __mem_cgroup_remove_exceeded().

Not necessary to call __mem_cgroup_remove_exceeded() again.

[fmhocko@suse.com: refine changelog]
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dc225ca512f6..e803ff02aae2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3460,7 +3460,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		nr_reclaimed += reclaimed;
 		*total_scanned += nr_scanned;
 		spin_lock_irq(&mctz->lock);
-		__mem_cgroup_remove_exceeded(mz, mctz);
 
 		/*
 		 * If we failed to reclaim anything from this memory cgroup
-- 
2.33.1


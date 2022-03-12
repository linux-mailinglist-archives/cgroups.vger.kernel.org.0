Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C84D6D36
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiCLHR4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 02:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiCLHRv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 02:17:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4341E5339
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:45 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so23449877ejc.8
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fCsAW2UJBB6c8M7QlLxk/JpB7LFkDqCihtv/AG+0X8o=;
        b=gqlsHeWUslWmzUd/Eur6w3QnGn7z2Zwd53xTFvdB8A32ZYPRsfJNBaAwpSKYMaKBN7
         Ow2oIrQFQHSV+lmB4JpCjzVpV2lwJ/YqI/9FSKwQDmDfs9VaBrPJeEKgtx5nwB1Lj2x/
         6+bmSn4/Ei6xKx5X/k4isDUc4/6feXGplx3FStYBqaIVKj0l6LGBxLX3sskLSsysS+dz
         RbUBSKdevPvprvhQXzMqfkOQ7m6kNdlwRCda0DYDQx+tNNXdjB/tImVE6t7B8C5x68HJ
         wY5JZZhZoFO7SN/y9eB4vA9xiunMKSr3rXaoa0YlR0eGT7jKk3wZgxmcQPxo8jLz5Fn+
         TYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fCsAW2UJBB6c8M7QlLxk/JpB7LFkDqCihtv/AG+0X8o=;
        b=STgC4c1VRKY8UXORTFWb9nCRncnbtAGwoW+hjanUN7p1Nx7YzD0vnpsWCKIR3IU/MI
         HB9Kblxv1CKjIgLBI1Bq2J4kk7PuZWrPpsjZRZl7PZi78rSIcnRUAD7muCMY40UKzsuc
         xus49DvNvwLKYUHLX07oQxU5GSQhUOfU3Z/0b7n/HssNHyKjZLu/DI0HPLonCpRu1WjB
         Dc/2BiqJwiKBrYphqo4/JW5sOVlHhgg0h4jMfCafZdF7TugI8sPVNjnfB7rbasjt1EUL
         vUhczHBXMhdCOD2UnE1JSE7PP8SMadsNr2hoNufQKWb17tS93fZglw45tlLGV5DW93fA
         Ppjw==
X-Gm-Message-State: AOAM53111zGY8+EJtlo1HKRtdN3XFHYwFCIAcjprYBFkb60Xll/rocb/
        QPm07bnccOS3/Hm55w1ouw4=
X-Google-Smtp-Source: ABdhPJzM8qMnDGTwX/YJSEeKqcXHJnylnQX45G0C/nIhSIh2See/JjfvN6BSKAtcks9RZDlbUar+mg==
X-Received: by 2002:a17:907:7ea7:b0:6db:b3c7:95d6 with SMTP id qb39-20020a1709077ea700b006dbb3c795d6mr3155520ejc.480.1647069403462;
        Fri, 11 Mar 2022 23:16:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q15-20020a056402518f00b00416a3194924sm3788805edd.75.2022.03.11.23.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Mar 2022 23:16:42 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/3] mm/memcg: mz already removed from rb_tree in mem_cgroup_largest_soft_limit_node()
Date:   Sat, 12 Mar 2022 07:16:21 +0000
Message-Id: <20220312071623.19050-1-richard.weiyang@gmail.com>
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

When mz is not NULL, mem_cgroup_largest_soft_limit_node() has removed
it from rb_tree.

Not necessary to call __mem_cgroup_remove_exceeded() again.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f898320b678a..d70bf5cf04eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3458,7 +3458,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 		nr_reclaimed += reclaimed;
 		*total_scanned += nr_scanned;
 		spin_lock_irq(&mctz->lock);
-		__mem_cgroup_remove_exceeded(mz, mctz);
 
 		/*
 		 * If we failed to reclaim anything from this memory cgroup
-- 
2.33.1


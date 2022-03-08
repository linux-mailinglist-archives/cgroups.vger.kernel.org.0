Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30A74D0D71
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 02:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbiCHBW7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Mar 2022 20:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiCHBWx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Mar 2022 20:22:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258937009
        for <cgroups@vger.kernel.org>; Mon,  7 Mar 2022 17:21:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z19so1013094edb.12
        for <cgroups@vger.kernel.org>; Mon, 07 Mar 2022 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fCsAW2UJBB6c8M7QlLxk/JpB7LFkDqCihtv/AG+0X8o=;
        b=YNtiEQf2jKNmJlXMfNeoZdWXaEcpCVilMpTG4BBRfrU5l33H8y5awom0neQTkabjSX
         pBacWDo4xIUCPIHGBfw8yvFDySfav4+5cR+67pRdAYrfHCJG8s8qLWatTR7Ll2Fwh0qF
         kCRrRu4GRUB9MJiL+tBGkICngiZEf4MCXvacOYMjF/BHDYrwDZf87XL9JqdclDLzultF
         ynwtsCaghvo7fjOVtIBZ6zPFNE5BcX7AAyrIQinfAEbOknUsm9ZTEhEMWSXCrm+DAE0u
         YOYYaKv7BMSg0g228arxqpgpLUAwOBwl416q0s5wF5SmYlImMDxL4488GLTUc22hVd0N
         gTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fCsAW2UJBB6c8M7QlLxk/JpB7LFkDqCihtv/AG+0X8o=;
        b=zSvzY6AjSRPOfyXOo8EbJ7nPWzIOeooaw+ZfA0QdV7K5T9bacGVJptCX/DIun4SVhr
         60JY+yTj+tWgdYbs22UqyR39EXZcpjIu8cD+MBAoQ+JNY+MPZXptDcsneg56KflaFWBo
         51pdH4HxERdlfFJ0ZeRzc7PnxwN+wCxiEJl1UORNUZuh9qlD/0/k2mOsNOEPeJDBBe9e
         xwkj0MZd3w1wgE3l7z2dLzTLCGTrwhJwI3PhENN0mzdXKVieFK5UqO+Ie2gVWgoBvckA
         oFNVj8yMMJ6NK/IL1ETiSQqSL/AznLG/q3g2hZA+HSVxIDeQGAaIWYmHpFMw8OkosLLu
         /Syg==
X-Gm-Message-State: AOAM530g5ZtyG7Kyn1C5GQukxAXC2BgxZ0ocb5KdSt+LHrA01Cbf9aMK
        ByAIeNxJ+szo0Pp6aOUKr5E=
X-Google-Smtp-Source: ABdhPJwvisVa5usty4EopQX72ds7IuCAZBihISiLjMF6OJYOeTMKXL6KFhEI4CDbg7FKRvicNQ4X7w==
X-Received: by 2002:a05:6402:f1f:b0:415:d1a3:eb4e with SMTP id i31-20020a0564020f1f00b00415d1a3eb4emr13721074eda.311.1646702516733;
        Mon, 07 Mar 2022 17:21:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm5285490eji.67.2022.03.07.17.21.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Mar 2022 17:21:56 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] mm/memcg: mz already removed from rb_tree in mem_cgroup_largest_soft_limit_node()
Date:   Tue,  8 Mar 2022 01:20:45 +0000
Message-Id: <20220308012047.26638-1-richard.weiyang@gmail.com>
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


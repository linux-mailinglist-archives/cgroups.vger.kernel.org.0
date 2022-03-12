Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7174D6D37
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 08:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiCLHRz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 02:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiCLHRv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 02:17:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68ED1E533C
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so23475709ejb.4
        for <cgroups@vger.kernel.org>; Fri, 11 Mar 2022 23:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJpD8WbIgS+xru6bpF+N+uC+vSCiqZY6PRQI5LvMXoI=;
        b=OnRswjgsCsJLFDXAhDVynEt+QYId9QLq2eHDAEGp5uy8DDCncYRh8UPekuSANb8xek
         Uuhz8NXACFvzoNgKCB4ogBbvV5t8gNdEgaIlRNqa5fFzRh1LKQ8qeldQvEsU1MG8zw1L
         tcTWMUMWZTo+VcEiFj29ZSoZuesvJ5oMfToBXCxntl0z5UxIGq2X2thLpSVzSISfl3D9
         aJB3QH2GA3EocBRfi5OMW/l3JuSvo/98FA9zrQorYBY7egSblrVCqiyrdO0wt89FE8/C
         4tHdbz4ubwNz8YN1HWJ+u8cZOkBvCxAUJqdor7obk60+IxdbIZBVE+bRuXQnRI4j/EX0
         45vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJpD8WbIgS+xru6bpF+N+uC+vSCiqZY6PRQI5LvMXoI=;
        b=NbxfZH0B+7DR8sbnzREqV+JWGXoMZVebczS2le3rUQd6IM0TeZE31/mrPxkVaZRRr2
         CdTSucUeQKvckJqFveiVQrdjF6xvpf1SQAaf5p1DQvRpPNuxtDiosvvl2mZd/J18NuZQ
         2Cznrc+QID84nJhdcUSlMNW1EPG/lm/uYWGrCwJMOZYZlix7yvGM+YMoegZ8rtjwXMV6
         U1G9hNdUxYGAt7GGLH7+/tL+gtHjju7EnC2CTZkniX5Da64/ZkWleLX1fgumNGvaSI2F
         PrBKXC2qdWBAhmkqJgz45GygS5So/Sk/rWlxbZ/rVt05CmXWdG9Fxnc0kCYcDOBzsC0e
         zkIQ==
X-Gm-Message-State: AOAM530utbqDbCPMiXAy4I6u4nk+Hkc1h1BY8XlbdnipCqv4JjEUf8Vt
        exFGF5+TYj/2/zbqQxaWawk=
X-Google-Smtp-Source: ABdhPJwOiV2aWkyrs3vCcOFujLCY3MWpms8vOw/gMA0k9/NHKb6WJplYCMpsRJZOnOmN9PpwNKGF/Q==
X-Received: by 2002:a17:907:7f1d:b0:6da:74b1:fd65 with SMTP id qf29-20020a1709077f1d00b006da74b1fd65mr11848542ejc.72.1647069404297;
        Fri, 11 Mar 2022 23:16:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709062dd200b006db26396622sm3875907eji.212.2022.03.11.23.16.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Mar 2022 23:16:43 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 2/3] mm/memcg: __mem_cgroup_remove_exceeded could handle a !on-tree mz properly
Date:   Sat, 12 Mar 2022 07:16:22 +0000
Message-Id: <20220312071623.19050-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220312071623.19050-1-richard.weiyang@gmail.com>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no tree operation if mz is not on-tree.

Let's remove the extra check.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d70bf5cf04eb..344a7e891bc5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -545,9 +545,11 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 			unsigned long flags;
 
 			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * remove it first
+			 * If not on-tree, no tree ops.
+			 */
+			__mem_cgroup_remove_exceeded(mz, mctz);
 			/*
 			 * Insert again. mz->usage_in_excess will be updated.
 			 * If excess is 0, no tree ops.
-- 
2.33.1


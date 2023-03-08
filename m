Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28826B0EA5
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCHQ0d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 11:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCHQ0W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 11:26:22 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CECAC9A7B;
        Wed,  8 Mar 2023 08:26:20 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bo10so11391531qvb.12;
        Wed, 08 Mar 2023 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292780;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pobmz56zWKXlv9VCRaNaOZMVD/RL8QxL/evDPGbbBYE=;
        b=McRkR1WhMXjVktc5aTw6T5/gz6rhdeR71Ukow2/ZzU1pNGgYskeBNM0STRwyIy0Hfm
         VTjxzQlU7sNL+v1NTYRQO8byhGn8P2ftwg0bNZl33Yx1hL90jCxOR3bvGXjNkeWh9G+m
         C3j8eWUiMVJgELYTg2oJkgiUFs3xb8VJ3e0o8SI1++jbALmILsUgu9mjOqkVEbP7RbIl
         TMWTLq/3F2oYXfLXSG/GLKvyAmjIjvn95772zy1qiECDYhLI3hP7yw575MZeEwjnopoj
         KCscHtCaCIVPuwZUB7vRCpSp6eQz5bg1OXfrbbiYqWy19G0Ga3XuBmYXT4rGuhEJ20xZ
         Vryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292780;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pobmz56zWKXlv9VCRaNaOZMVD/RL8QxL/evDPGbbBYE=;
        b=v9VQlEKSI2hyZCEYmYJJafwLZgPToTwR4sFVRdgWkQFlhLoH6nr/gMkvfxCHFxtJh9
         3X+3WPslKFSrccYpN1F7xZ+Ns60jL8HM4BnLFw0aHyeBx13uhsyUJ0w32YGKpg45ZINa
         eVDpwjaluWg+YVfptCzS2CV73Aq9b7y4Xf9BbJY4zR5Y+6WWf3POb2AgduW+QoLSewVo
         VMWqaK6+F2KeIKudE91PceATOKe3r+kgDdENn1uChuAKvatcL9AoRfaXxhztrz1+e0yH
         rbY/el9P6NZZJfL9/4huMA0WBDJxjWZodBjhu4XaIuMlc2uyxpsBxcOrXWlde+GqSBHn
         Vr0g==
X-Gm-Message-State: AO0yUKU7JyHy7dJHaz2YM/M90qKWC1oqe5fJ+APZnK9Mul7kcx5ztLmE
        /Gc+dzJyJynCKFp5yGLqkbxlL9/lm4La7LN+
X-Google-Smtp-Source: AK7set9fJpkEVxDTECYsrfoWBBWoQm1UPxTBvv9OtImj+CJODpxx724Aby+U/JKlSJDy6TUKlKt6aA==
X-Received: by 2002:ad4:5de1:0:b0:56b:f09e:9ab0 with SMTP id jn1-20020ad45de1000000b0056bf09e9ab0mr28752380qvb.5.1678292779760;
        Wed, 08 Mar 2023 08:26:19 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b0073b8459d221sm11619813qkm.31.2023.03.08.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:26:19 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v3, 2/4] mm, memcg: Prevent memory.swappiness load/store tearing
Date:   Thu,  9 Mar 2023 00:25:53 +0800
Message-Id: <20230308162555.14195-3-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308162555.14195-1-findns94@gmail.com>
References: <20230308162555.14195-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v1 memory controller: memory.swappiness
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely.
But it is better to use [READ|WRITE]_ONCE to prevent compiler from
doing anything funky.

The access of memcg->swappiness and vm_swappiness is lockless,
so both of them can be concurrently set at the same time
as we are trying to read them. All occurrences of memcg->swappiness
and vm_swappiness are updated with [READ|WRITE]_ONCE.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 include/linux/swap.h | 8 ++++----
 mm/memcontrol.c      | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 209a425739a9..3f3fe43d1766 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -620,18 +620,18 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
 	/* Cgroup2 doesn't have per-cgroup swappiness */
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return vm_swappiness;
+		return READ_ONCE(vm_swappiness);
 
 	/* root ? */
 	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
-		return vm_swappiness;
+		return READ_ONCE(vm_swappiness);
 
-	return memcg->swappiness;
+	return READ_ONCE(memcg->swappiness);
 }
 #else
 static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 {
-	return vm_swappiness;
+	return READ_ONCE(vm_swappiness);
 }
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 06821e5f7604..1b0112afcad3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4179,9 +4179,9 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 		return -EINVAL;
 
 	if (!mem_cgroup_is_root(memcg))
-		memcg->swappiness = val;
+		WRITE_ONCE(memcg->swappiness, val);
 	else
-		vm_swappiness = val;
+		WRITE_ONCE(vm_swappiness, val);
 
 	return 0;
 }
@@ -5353,7 +5353,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
-		memcg->swappiness = mem_cgroup_swappiness(parent);
+		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 		memcg->oom_kill_disable = parent->oom_kill_disable;
 
 		page_counter_init(&memcg->memory, &parent->memory);
-- 
2.17.1


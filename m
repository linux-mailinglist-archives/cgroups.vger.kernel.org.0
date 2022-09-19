Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E95BD479
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiISSH0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiISSHT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 14:07:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1CD46234;
        Mon, 19 Sep 2022 11:06:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso6897862pjd.4;
        Mon, 19 Sep 2022 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=C+GNb1CRkpsaWy3nNaUeEZwBpKEJtnfXNeVMo/vFMIU=;
        b=fJXZ9vt1XMtBtJhooHOuHVO6gpZg/2Uq4qGa9T5h11pcGRnzjkEqyCrZLqmAkJO3mt
         6jZ6Kmcm5Xrl4n/4Ha9OVyvbf7KSeSHSaBIOVNkl/Y+DFmj3H/uy0xNC+pLhyrze7MCr
         dwJzSTDmkot2vsTjksuK2VD4SWXd5wJcjGqt1tPITOlZ7VGEfcr6qO3cRxkn0CYilHgB
         T55kdJjZVfwysg0KjtfHwmZN+5pQSnz3gMRiZsYhWXzRHLhezJGrkX5qv07Q/7gmikk6
         B/FPhC5n0u2iEpfA1o6oGoGvCu3B2YW8UjFu0aCFVVNQytVv//tVdMVPcPIP8TNm7bdz
         I93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=C+GNb1CRkpsaWy3nNaUeEZwBpKEJtnfXNeVMo/vFMIU=;
        b=GqiivpnxEhx42e4uJyd4YNEyQ3FENwo1RxeItNsyuwobhXc0QG0v/cCfkXOGtUs6YO
         TY1lTS5Kqwt8gwXOxgRMReCyTK5t+TGK7ytcdnNIWe+CLmAL9AlKx3x6YmqK9q9uVZkS
         TLHKnFP4VOJYazyhGpz/ui9tM3TTL5KU6QOFJaan/Jcu3UsKmAQezZH4uQmIrXCQ6q8V
         3NyY6DcZdKUGMQDj7BVqJNUTwa3TiXmHZyay6p12jmo+LCZ/Zy3SMVgjrIWhgWc5OHdE
         Tb7bYEjpjmmSGvrXAqn5pgVWwwQnf9D7pDX9rR5pdNxgle3SNzUsHFxTG8tKZTPqotV1
         GqXg==
X-Gm-Message-State: ACrzQf2vtXeb37M/csnczEz7w1XgwQ9s1GbTX+U2MZd7783Gvi+e7vcM
        9nvrB71CFoCNV6PmssVH9IaEiDtsq2nfq0XH
X-Google-Smtp-Source: AMsMyM779q0TTvhK4qsuqZ791YA4zyjY0m9M+JWLvcM1gMkroLtT/c+VgF5ZePOZ7fH3LVOzJk9gXw==
X-Received: by 2002:a17:90a:be10:b0:202:cdf2:56a1 with SMTP id a16-20020a17090abe1000b00202cdf256a1mr31606922pjs.41.1663610812577;
        Mon, 19 Sep 2022 11:06:52 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([115.171.41.135])
        by smtp.gmail.com with ESMTPSA id u21-20020a632355000000b0041c30def5e8sm14176654pgm.33.2022.09.19.11.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Sep 2022 11:06:52 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/2] mm: memcontrol: use memcg_kmem_enabled in count_objcg_event
Date:   Tue, 20 Sep 2022 02:06:33 +0800
Message-Id: <20220919180634.45958-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220919180634.45958-1-ryncsn@gmail.com>
References: <20220919180634.45958-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

There are currently two helpers for checking if cgroup kmem
accounting is enabled:

- mem_cgroup_kmem_disabled
- memcg_kmem_enabled

mem_cgroup_kmem_disabled is a simple helper that returns true
if cgroup.memory=nokmem is specified, otherwise returns false.

memcg_kmem_enabled is a bit different, it returns true if
cgroup.memory=nokmem is not specified and there was at least one
non-root memory control enabled cgroup ever created. This help improve
performance when kmem accounting was not actually activated. And it's
optimized with static branch.

The usage of mem_cgroup_kmem_disabled is for sub-systems that need to
preallocate data for kmem accounting since they could be initialized
before kmem accounting is activated. But count_objcg_event doesn't
need that, so using memcg_kmem_enabled is better here.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6257867fbf95..e6d3d5870d6f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1779,7 +1779,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 	struct mem_cgroup *memcg;
 
-	if (mem_cgroup_kmem_disabled())
+	if (!memcg_kmem_enabled())
 		return;
 
 	rcu_read_lock();
-- 
2.35.2


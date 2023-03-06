Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B726AC5B5
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 16:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCFPmx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 10:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCFPmt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 10:42:49 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43922DCC;
        Mon,  6 Mar 2023 07:42:14 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l18so10986655qtp.1;
        Mon, 06 Mar 2023 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117333;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0NtQyJ6eQBb0wGTDfYWZm4PPrLnDXxCUuuQDDh4+5sU=;
        b=p6QOaLsOhtyQJzkmQb72krbjZZTYJqL3+85RbgaTSEfMrdL/bMTMGHgczRpwUo3QWG
         7+j2vCkJDM9ruYYy+Nfu3XvmdOG8slzKlROb03WCQdG8DDGqhGgQqvRJOhNL8pFLrmmI
         +ev1QP60Jnuv1fKaWdyuD+HazZp1e/27BIpKObz53uW92JMY5YhWsqHKGt3WSE57mUEs
         ZQphWrShLIPoNvsh0QjWJrUKOdv6ocOuNswcj7aP8e+ueiH02tCrQaqF0bqLiihZWKWv
         DyqCYh0Me+WO8Ftqx1ReuWcYmdt/cO7hbA9z9IsmPYdp0El45dD6vMPePBkHn1+jhLNx
         pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117333;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NtQyJ6eQBb0wGTDfYWZm4PPrLnDXxCUuuQDDh4+5sU=;
        b=wDcBWzUOz0O5+Nuqgu91PI6TeFisGYa4wJEN5KWYUzQOjXz8WpzWXyExUjuLv7L522
         COptpUYuEtYP9IsON6ht/lnqTq5sN/H0L1Bt+dhRMbGIMV8EU3+rKMRpcuoXEKD+v8K6
         FkHORiih3HgDsPTOZicr/EGWaEC9RY6U+QJJTxy6vkjPbTkppf9b5QrmzURLy3KfUqL4
         0RuvX/1eDa5H17F+DjfQUsXzOR8qpd7lIkrFMh6PQDmGbXMui4hhqhJfl4Vuu/4g6pIG
         1CIkjlIcdneQcn3Sgmrr2fhcRR+e9L+PqbhRK0kWhriRUi0EfN0PpMCwY6O+SUT+PtDs
         yDrg==
X-Gm-Message-State: AO0yUKVa4kXjNNLYUzUi4cbJp74pIvxLg5+sHM3EeD3L/wfXBfotZP7/
        6+1aBS0h/4gWdq6I/sGP6a4=
X-Google-Smtp-Source: AK7set//PKS1+aICL/kDFtE+6AbfSA+d0toJvyGobvIzhfwP2rlswkxPCWAkAUTT7evRVVYZWD05kg==
X-Received: by 2002:ac8:5e4a:0:b0:3b8:2ea9:a09c with SMTP id i10-20020ac85e4a000000b003b82ea9a09cmr19719350qtx.1.1678117333372;
        Mon, 06 Mar 2023 07:42:13 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm7618400qkj.18.2023.03.06.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:42:13 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v2, 2/4] mm, memcg: Prevent memory.swappiness load/store tearing
Date:   Mon,  6 Mar 2023 23:41:36 +0800
Message-Id: <20230306154138.3775-3-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
References: <20230306154138.3775-1-findns94@gmail.com>
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
But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
doing anything funky.

The access of memcg->swappiness and vm_swappiness is lockless,
so both of them can be concurrently set at the same time
as we are trying to read them. 

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 include/linux/swap.h | 8 ++++----
 mm/memcontrol.c      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 06821e5f7604..dca895c66a9b 100644
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
-- 
2.17.1


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEF6C5DAF
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 05:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCWEBA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 00:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCWEAy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 00:00:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48952CFD5
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s4-20020a170902ea0400b001a1f4137086so1930440plg.14
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IoeZYZryJtZ5YKLINZigwUk+eCMrWPKZYyl5pNjfs0s=;
        b=CYUJafqLeSTzFoXixoXxJfg+d8a1R4JvCUerDh64ifDjpdaxbdbWqowybN/gvJ19LK
         Og473fSzkkpOeMA58DC64BMRm6M0MCGDM/VGSfHLkAlVcw8rDdEYpMTrVbzG7kCaO9yo
         XEy99SSbQbOpczsL5Zy04pgal2f5dv+k8luu/GDpUWQB1RZl9qYQhWpR8p3p3vD98PGc
         ce78QmYoavhlvFbHk6YMCQ65CM/lnXEYztj/xUq2pBOa3UnU3uBgApeimhahme8eLkyC
         CQZkL9MM7bPQMzx+6ozclKMKwr8T8qPF+ZR71Vewcxu4v3esM5hXIWD8hj0gOLxV+qOY
         L9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoeZYZryJtZ5YKLINZigwUk+eCMrWPKZYyl5pNjfs0s=;
        b=Ila68uTPMTFKyS72MhzQ3jvPLfRbB+UKzFiMd4Rs8vzI43zKSXCyk50BoMYSFelNhk
         sadZFnfsnVlw9Qv3FUmXtSn+gTYlqIPxZoNmUgs8B5+8D/wJ+B0I740iz8eKebUEYrdX
         Yjo31uFMZF1uymnYFEuIJZ4pe79mTqrJqx1sMW5UaZxffZe7e7AvJ8NFqboIouOKgRgf
         DnmCZypM7zX1vxIO9JwoZdEVClSf8E8QD45o9m4xjoroh8KB4ENG4pXKvOW5LI7VJnec
         FuRXujRVTXXUro4hARrYVFjOY2FtdXntw7hciHFi8PcE/EJfWPv2CtV1OH4Vy+zTuFC1
         2TbQ==
X-Gm-Message-State: AO0yUKW3HPklH050N+1lJWXQyTNg3xypjog6D8EXAaVGziog10RyhGY1
        L225nwZ1OUH7Xbi430YARS5CCOGOkrhJU5m+
X-Google-Smtp-Source: AK7set9aF1O2O+BZVk6rqDRrbbtYYQ/yqA23fBe+9ZzPXGEhcCIhooyW8p0Z2epSuqN1jjR7FDL5kfmsz1ZKE44X
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:ce11:b0:23f:d473:dd44 with SMTP
 id f17-20020a17090ace1100b0023fd473dd44mr1881490pju.3.1679544052257; Wed, 22
 Mar 2023 21:00:52 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:36 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-7-yosryahmed@google.com>
Subject: [RFC PATCH 6/7] workingset: memcg: sleep when flushing stats in workingset_refault()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In workingset_refault(), we call mem_cgroup_flush_stats_delayed() to
flush stats within an RCU read section and with sleeping disallowed.
Move the call to mem_cgroup_flush_stats_delayed() above the RCU read
section and allow sleeping to avoid unnecessarily performing a lot of
work without sleeping.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

A lot of code paths call into workingset_refault(), so I am not
generally sure at all whether it's okay to sleep in all contexts or not.
Feedback here would be very helpful.

---
 mm/workingset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 042eabbb43f6..410bc6684ea7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
 	eviction <<= bucket_order;
 
+	/* Flush stats (and potentially sleep) before holding RCU read lock */
+	mem_cgroup_flush_stats_delayed(true);
 	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
@@ -461,9 +463,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
-
-	/* Do not sleep with RCU lock held */
-	mem_cgroup_flush_stats_delayed(false);
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.rc1.284.g88254d51c5-goog


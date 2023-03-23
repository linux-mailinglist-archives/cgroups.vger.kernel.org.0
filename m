Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB86C5DA4
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 05:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCWEA4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 00:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWEAx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 00:00:53 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C81F93F
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id bh9-20020a170902a98900b0019e506b80d0so11770599plb.13
        for <cgroups@vger.kernel.org>; Wed, 22 Mar 2023 21:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0V6KepxSWjC0U8YUMhyf5sEsW80RflfKR4tDJnFyjUM=;
        b=nvFwhwj7qGyMPQaTPrzYFw+T0XNSe66OQzM5b4pjwLTwVBRy9Yg/AbwpYFnRMIM5gG
         L465fbRhjctsBw/iYduTrtP7LUUTB2pfnwQVaagEQM0GyAtfd40drA654+PpJ27hrtIB
         BUWcp/c32KQ98SFLCZ9FSHYNM6vaide1p2wRQYwdJvG/bU3/l2g1YAjLINeXoxbcrV2W
         3/G5Y/6fhAJDfUsgxXfVWzP78YqVFCMwh/+/7IKP9AVvA+7qfhsyQkLxneMASA+CreO0
         VfuwrktKMl3lyTDdGpOXeKO210ebUx1dz4XnfSvMg+6i1Ne/G/0TP1oqkrL/txGwmyNx
         VJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V6KepxSWjC0U8YUMhyf5sEsW80RflfKR4tDJnFyjUM=;
        b=Gpef6nsGDzTEZxWUKZ/bmz5/vGNbUFF68oyd7OxXd8VcgQqXs8ygr/EyFMZJ4yiDot
         o517d4Pyaz2Jl7m2MiBWQHxSvIWOoHTBonOKadiMErodIV75kKNYFJpzD5l8aKHpD4wK
         wMZK3/tgWm9aeGrAj4gSQpplHRtjVaCrPjWHzAkDUPgTv2eEGqEUIl+TmzHjU7nqSW68
         4mxXavEfEfosAIiPWpGp1dejAJl4IiEtq8I4FbaL3J5jRHPpAZPMieJDF96xMeR6dat+
         LhHcPAzzsZqQXfTlvJI39P2TWTVJoqWVAAwKZPMOD4155VFtrRKriAd5H+0m5SRsd9BP
         sAYA==
X-Gm-Message-State: AO0yUKVMp8Cb3cCRCivCiJWjZOSemNeeKrYFF/9Ipr+1kafKmtnStz7X
        YEpj1H+sETdrhTLC3PBdCp28sujTo8U5hDjM
X-Google-Smtp-Source: AK7set+NjW/4AXEB5d0IG7XiVNOSp7doL59qiTn9uvLqiFnoG/BqWGCoWZHV7SR3pQA/2uxuP1t6d8Miz+ziUaX1
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:851:b0:628:30d:2d2f with SMTP
 id q17-20020a056a00085100b00628030d2d2fmr2879444pfk.5.1679544045305; Wed, 22
 Mar 2023 21:00:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:32 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-3-yosryahmed@google.com>
Subject: [RFC PATCH 2/7] memcg: do not disable interrupts when holding stats_flush_lock
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

The rstat flushing code was modified so that we do not disable interrupts
when we hold the global rstat lock. Do the same for stats_flush_lock on
the memcg side to avoid unnecessarily disabling interrupts throughout
flushing.

Since the code exclusively uses trylock to acquire this lock, it should
be fine to hold from interrupt contexts or normal contexts without
disabling interrupts as a deadlock cannot occur. For interrupt contexts
we will return immediately without flushing anyway.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..e0e92b38fa51 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -636,15 +636,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 static void __mem_cgroup_flush_stats(void)
 {
-	unsigned long flag;
-
-	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
+	/*
+	 * This lock can be acquired from interrupt context, but we only acquire
+	 * using trylock so it should be fine as we cannot cause a deadlock.
+	 */
+	if (!spin_trylock(&stats_flush_lock))
 		return;
 
 	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
 	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock_irqrestore(&stats_flush_lock, flag);
+	spin_unlock(&stats_flush_lock);
 }
 
 void mem_cgroup_flush_stats(void)
-- 
2.40.0.rc1.284.g88254d51c5-goog


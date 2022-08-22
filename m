Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8259B6FE
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiHVAR4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 Aug 2022 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHVARz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 Aug 2022 20:17:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E121FCC4
        for <cgroups@vger.kernel.org>; Sun, 21 Aug 2022 17:17:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3339532b6a8so160528367b3.1
        for <cgroups@vger.kernel.org>; Sun, 21 Aug 2022 17:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=PKFRaxD4qQqEIFqu3chPSEEEaimoA7SPNFa30ZMS/uU=;
        b=HizZvrBQiCe/lTGkboVezrNH98vpHv6pPqN3AxEJH/hFrU99YqU4n2tDb7vx0BDvjD
         bQrrXzlJxZNS5VEi+6ur1985jYp1mqaVxFam9zQg29fgy4j8FDwrvk2EWIEw9zZcLyy8
         ZrbSnLWlxJzAlcK4inCb0YBuOPVU8Pf6wgn3U0AS+YKBi3N8fLf+SDkLifHnsuVpXtE9
         VW+MgYxWYsl4FT5vPrWtjoQKUyoGIDwGhmbfEnhOfVukKNjsvqjWPYthJA+lrTU4JyRJ
         Sj3VMg2YYPUcwhLJDwgqi0QQBI7r5yYyU5d+lRAwuifJcVjqGV647qwS/PzhpquTv4FZ
         z7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=PKFRaxD4qQqEIFqu3chPSEEEaimoA7SPNFa30ZMS/uU=;
        b=MlvP/AvN80R0DE422QJq+oWij0OLBZjPhiA4smoR31+1qNAZht5iXzoviXAQQde/9s
         8I140ToJeApHoplBCgyF9lh3hD2iKRj9GzvUflQecigaRNja0JRJDrp9a7iNeFJpLtl5
         xKukmBFHRn78rzEI9/rpp+w74Xmc61piXlsushmpXzSa6i/+noWwueTnevNt9BJJ4eU6
         v6PniL4O2caPgF+3v91WYDMuXQEeuKIHaxlxI8W/qsrtgMP6mMBRZFeX0F3yhO2frsMT
         fM8YaFuNZjJT0AhttP5m88yxjtmqfCpAIYAnmNKL76r2oW/lLvVehNSH4uQQatSZeYFZ
         XVVQ==
X-Gm-Message-State: ACgBeo0G+nau1grkN1eNubRZdyfRa1wclK48cMZhBLUcWhiPBotHA5HR
        tfh4lVKC2hrPnoIfkHtgEWnUFWNBKZ8B0Q==
X-Google-Smtp-Source: AA6agR7ugDocQyFMo7I0NUqJCeOZethCdyIXG6uExhXVb1g/djDmpfI1UlZI7JLxJy/0h1pcp1JCf7rda8Xqlw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a81:9b17:0:b0:335:c382:48d with SMTP id
 s23-20020a819b17000000b00335c382048dmr17808577ywg.244.1661127473042; Sun, 21
 Aug 2022 17:17:53 -0700 (PDT)
Date:   Mon, 22 Aug 2022 00:17:35 +0000
In-Reply-To: <20220822001737.4120417-1-shakeelb@google.com>
Message-Id: <20220822001737.4120417-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH 1/3] mm: page_counter: remove unneeded atomic ops for low/min
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For cgroups using low or min protections, the function
propagate_protected_usage() was doing an atomic xchg() operation
irrespectively. It only needs to do that operation if the new value of
protection is different from older one. This patch does that.

To evaluate the impact of this optimization, on a 72 CPUs machine, we
ran the following workload in a three level of cgroup hierarchy with top
level having min and low setup appropriately. More specifically
memory.min equal to size of netperf binary and memory.low double of
that.

 $ netserver -6
 # 36 instances of netperf with following params
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

Results (average throughput of netperf):
Without (6.0-rc1)	10482.7 Mbps
With patch		14542.5 Mbps (38.7% improvement)

With the patch, the throughput improved by 38.7%

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 mm/page_counter.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index eb156ff5d603..47711aa28161 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -17,24 +17,23 @@ static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
 	unsigned long protected, old_protected;
-	unsigned long low, min;
 	long delta;
 
 	if (!c->parent)
 		return;
 
-	min = READ_ONCE(c->min);
-	if (min || atomic_long_read(&c->min_usage)) {
-		protected = min(usage, min);
+	protected = min(usage, READ_ONCE(c->min));
+	old_protected = atomic_long_read(&c->min_usage);
+	if (protected != old_protected) {
 		old_protected = atomic_long_xchg(&c->min_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
 			atomic_long_add(delta, &c->parent->children_min_usage);
 	}
 
-	low = READ_ONCE(c->low);
-	if (low || atomic_long_read(&c->low_usage)) {
-		protected = min(usage, low);
+	protected = min(usage, READ_ONCE(c->low));
+	old_protected = atomic_long_read(&c->low_usage);
+	if (protected != old_protected) {
 		old_protected = atomic_long_xchg(&c->low_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
-- 
2.37.1.595.g718a3a8f04-goog


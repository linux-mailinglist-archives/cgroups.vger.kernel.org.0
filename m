Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4502B6FFBC3
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbjEKVSr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjEKVSq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 17:18:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9E2D56
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 14:18:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24ffa913678so5031026a91.2
        for <cgroups@vger.kernel.org>; Thu, 11 May 2023 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683839925; x=1686431925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFv5ci7ov6TO/nbE/lFV0e8LOwHUTHRp5fyIeOp00NI=;
        b=DRDZQiesqpSkMtadBPnXaSLFftLOF2tRVveccLBHVnBfk/IjvUoQA1Vknb0qgMsFbd
         ul40I6todx42bog/6ILqg96UcxIK20g7/qxVXO8QgOpBrtxjLfYfJ3yb7AbTA509nJ45
         vVEgVqAVXuEAW3i7m6KpNZ8E7yUqe9DG3mXiQ3HPPZBITzC95+Q2dKAzmolVjjK8pwj6
         a9Cs5cxJHtaEZmMYpeJlaDWPHHQqqVCMIVRPH7naWvhq4An6q1xPYDSHdHn8VQ1eQ3Qq
         1xo4xpza4/4wjkUjYkP6SbE4ymEBfN6VGHOcKr1q1VYLux/W7k50O5Jteg6uKDtjsnQ8
         c8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839925; x=1686431925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFv5ci7ov6TO/nbE/lFV0e8LOwHUTHRp5fyIeOp00NI=;
        b=QyQeIKZIIlLYYV7zxW6jLta9ngBlYbwYJcA/Cv8jxRCL1PqA3ByRxMDXaUJEve2btz
         fStw8JjH5wdkgjPhu9UL04ePCyUWy8CLFfe2+xnSpLkZ9SoOQg4pMdHvMkQal+PuBKLJ
         gFKzU38cTZ+x6Gp1toTaJQ2P/KVDn3fiQoLecT9uZf6GiqMXgk9siHeqlw09HH4ujIE3
         K25ugaSQxkBG1V3/s3YApwddHW+F9QYKfR/IXdk8Aq4iwwZxLiOw3ZN2IByLLEJEWCTQ
         RsF6x2FUXxBhBF1GymVt9hfNoLfQfT52GT3avhA10WYBFdWNEMbylYqC6Y3KUnRyneMc
         6egw==
X-Gm-Message-State: AC+VfDzpTaliotZX/gx1BoFZi+l9Y0glv+yHGVv5rRSmeX/pmls9h2ya
        422xNq61Wp7z4Hk5gsa6297XK++MACsFFw==
X-Google-Smtp-Source: ACHHUZ4PXc23wNbZ57OaYuyrz4g91w8e/qPsy9n7oPI4nIMZ/vilFYfLVvhoPfhYvHpXoc9YoMMWey8UgDoT4A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:ff95:b0:24e:2288:6d with SMTP id
 hf21-20020a17090aff9500b0024e2288006dmr6663468pjb.0.1683839924818; Thu, 11
 May 2023 14:18:44 -0700 (PDT)
Date:   Thu, 11 May 2023 21:18:42 +0000
In-Reply-To: <IA0PR11MB73557DEAB912737FD61D2873FC749@IA0PR11MB7355.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <CH3PR11MB7345ABB947E183AFB7C18322FC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89i+9rQcGey+AJyhR02pTTBNhWN+P78e4a8knfC9F5sx0hQ@mail.gmail.com>
 <CH3PR11MB73455A98A232920B322C3976FC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89i+J+ciJGPkWAFKDwhzJERFJr9_2Or=ehpwSTYO14qzHmA@mail.gmail.com>
 <CH3PR11MB734502756F495CB9C520494FFC779@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CALvZod4n+Kwa1sOV9jxiEMTUoO7MaCGWz=wT3MHOuj4t-+9S6Q@mail.gmail.com>
 <CH3PR11MB73454C44EC8BCD43685BCB58FC749@CH3PR11MB7345.namprd11.prod.outlook.com>
 <IA0PR11MB7355E486112E922AA6095CCCFC749@IA0PR11MB7355.namprd11.prod.outlook.com>
 <CANn89iJbAGnZd42SVZEYWFLYVbmHM3p2UDawUKxUBhVDH5A2=A@mail.gmail.com> <IA0PR11MB73557DEAB912737FD61D2873FC749@IA0PR11MB7355.namprd11.prod.outlook.com>
Message-ID: <20230511211338.oi4xwoueqmntsuna@google.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
From:   Shakeel Butt <shakeelb@google.com>
To:     Zhang@google.com, Cathy <cathy.zhang@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>, Brandeburg@google.com,
        Jesse <jesse.brandeburg@intel.com>, Srinivas@google.com,
        Suresh <suresh.srinivas@intel.com>, Chen@google.com,
        Tim C <tim.c.chen@intel.com>, You@google.com,
        Lizhen <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 11, 2023 at 09:26:46AM +0000, Zhang, Cathy wrote:
> 
[...]
> 
>      8.98%  mc-worker        [kernel.vmlinux]          [k] page_counter_cancel
>             |
>              --8.97%--page_counter_cancel
>                        |
>                         --8.97%--page_counter_uncharge
>                                   drain_stock
>                                   __refill_stock
>                                   refill_stock
>                                   |
>                                    --8.91%--try_charge_memcg
>                                              mem_cgroup_charge_skmem

I do want to understand for above which specific condition in
__refill_stock is causing to drain stock in the charge code path. Can
you please re-run and profile your test with following code snippet (or
use any other mechanism which can answer the question)?

From f1d91043f21f4b29717c78615b374d79fc021d1f Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 11 May 2023 20:00:19 +0000
Subject: [PATCH] Debug drain on charging.

---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d31fb1e2cb33..4c1c3d90a4a3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2311,6 +2311,16 @@ static void drain_local_stock(struct work_struct *dummy)
 		obj_cgroup_put(old);
 }
 
+static noinline void drain_stock_1(struct memcg_stock_pcp *stock)
+{
+	drain_stock(stock);
+}
+
+static noinline void drain_stock_2(struct memcg_stock_pcp *stock)
+{
+	drain_stock(stock);
+}
+
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
@@ -2321,14 +2331,14 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
-		drain_stock(stock);
+		drain_stock_1(stock);
 		css_get(&memcg->css);
 		WRITE_ONCE(stock->cached, memcg);
 	}
 	stock->nr_pages += nr_pages;
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
-		drain_stock(stock);
+		drain_stock_2(stock);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
-- 
2.40.1.606.ga4b1b128d6-goog


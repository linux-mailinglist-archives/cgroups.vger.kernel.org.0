Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B575F5AC0
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJETtw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJETtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 15:49:52 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD9103F
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 12:49:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x18so10881392qkn.6
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KTsXqBLMJ7z5zDaMVeB3mFtjBOaAR2nLT0zyd4+BXeg=;
        b=rL48SW7QvdXgLHL74fCHo4SV8KfIpBhdqZiIQkFNh26QO0TTK/n2jD7rLs5fjZNgXX
         yqzl+73lIDTO9Wo+L+sKEUh5VTyKcrOARmxgyzCkLnBzZGOYGKz1LMCzJrk8y5VEvrXl
         SL9TmligGaKXnhQ7moybwxP0quMm54chKS1ExXoghqPYamj7omGSHq8jkHq0MYM5geLn
         7RLi84RADnmvjggV2xnJHWsRaTXaqRCHbsd+hBNFTax2A3pXm2Lxz0alAp1GkgBPI9f6
         phptnuyHdseoFF1K7kCZfEqfVIJxshHn4QPHCyLp5ZcLGdzlRzgkd9J+CROfJfxgtMrv
         7s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KTsXqBLMJ7z5zDaMVeB3mFtjBOaAR2nLT0zyd4+BXeg=;
        b=pgBHE4j3j+ia5o7sYlaJKQ13+sUjIeZ093pbeBi28ngtZdfXNZkdUU2MW/ZKnBA7Gt
         HLOMsx3F6Acjaq/rNT0MJJYKACfFxGJgvRKOx1BXmUOx+Ngee7CzhJ5HpNQFwPvjlyD/
         n9aml9vQJREqfIzR6sFuxY3onAI+t0kbR3y6UguDEIbq+7yOFuQhNJ0owCs69qS9UO4f
         RW2SZmIDqeS8Ctt8cIOYEwvD636XzkT4GIxSs73S95fBy7LPbpThcRBuvD/rYHxOXIAj
         w+voWN5BK0L5jt6I8zTyFRrPrWTof7KDaIDjAfSnYp0mr4KnIR/b2ngLlzSwdSbc2n1A
         7BYg==
X-Gm-Message-State: ACrzQf0aHFQ+TS40pq9TeC0sv2X/n/qGoWH2tc5Qo+sFP0DhzH65J2v2
        WdwdfpS4ysfzdn2kANlToJjGow==
X-Google-Smtp-Source: AMsMyM64bYzTh2coBvcK6ApYP5+mCCGuTVoNmZIhCeEBPxWh6+64BAKzJyw6Jm+z60lU7vZXu19vSw==
X-Received: by 2002:a05:620a:16cf:b0:6ce:4b65:db21 with SMTP id a15-20020a05620a16cf00b006ce4b65db21mr854017qkn.544.1664999389066;
        Wed, 05 Oct 2022 12:49:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8a16])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a410300b006b5bf5d45casm18608327qko.27.2022.10.05.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:49:48 -0700 (PDT)
Date:   Wed, 5 Oct 2022 15:49:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz3f23fPHEx1XJLJ@cmpxchg.org>
References: <20221005173713.1308832-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005173713.1308832-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 05, 2022 at 05:37:13PM +0000, Yosry Ahmed wrote:
> During page/folio reclaim, we check if a folio is referenced using
> folio_referenced() to avoid reclaiming folios that have been recently
> accessed (hot memory). The rationale is that this memory is likely to be
> accessed soon, and hence reclaiming it will cause a refault.
> 
> For memcg reclaim, we currently only check accesses to the folio from
> processes in the subtree of the target memcg. This behavior was
> originally introduced by commit bed7161a519a ("Memory controller: make
> page_referenced() cgroup aware") a long time ago. Back then, refaulted
> pages would get charged to the memcg of the process that was faulting them
> in. It made sense to only consider accesses coming from processes in the
> subtree of target_mem_cgroup. If a page was charged to memcg A but only
> being accessed by a sibling memcg B, we would reclaim it if memcg A is
> is the reclaim target. memcg B can then fault it back in and get charged
> for it appropriately.
> 
> Today, this behavior still makes sense for file pages. However, unlike
> file pages, when swapbacked pages are refaulted they are charged to the
> memcg that was originally charged for them during swapping out. Which
> means that if a swapbacked page is charged to memcg A but only used by
> memcg B, and we reclaim it from memcg A, it would simply be faulted back
> in and charged again to memcg A once memcg B accesses it. In that sense,
> accesses from all memcgs matter equally when considering if a swapbacked
> page/folio is a viable reclaim target.
> 
> Modify folio_referenced() to always consider accesses from all memcgs if
> the folio is swapbacked.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

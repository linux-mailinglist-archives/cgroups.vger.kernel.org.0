Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A44E5ACC
	for <lists+cgroups@lfdr.de>; Wed, 23 Mar 2022 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiCWVqG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Mar 2022 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiCWVqG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Mar 2022 17:46:06 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B18CD99;
        Wed, 23 Mar 2022 14:44:35 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:44:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648071872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XY5kMoTXHmqmiVy2HYgdwsUIAUgV0f+WD3Zq9NZ1rig=;
        b=tIkhyUwCj21h679R74DUEqJYdwnu60YleSAUF//3fNmiqt+PYVpSZRINK+Jhl6RkUQIqws
        q7cnt3gzzC1vcMomxCfEn/iGbAeykyC28Ki3sc7uHV5FoNBJJar3asnQl+BeYWwl12EbDB
        hjQEpEuUhpu0HrV0NM+eJwzG3K2B00c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Subject: Re: [RFC PATCH] mm: memcg: Do not count memory.low reclaim if it
 does not happen
Message-ID: <YjuUuLW+8iRtYOmP@carbon.dhcp.thefacebook.com>
References: <20220322182248.29121-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322182248.29121-1-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 22, 2022 at 07:22:48PM +0100, Michal Koutny wrote:
> This was observed with memcontrol selftest/new LTP test but can be also
> reproduced in simplified setup of two siblings:
> 
> 	`parent .low=50M
> 	  ` s1	.low=50M  .current=50M+ε
> 	  ` s2  .low=0M   .current=50M
> 
> The expectation is that s2/memory.events:low will be zero under outer
> reclaimer since no protection should be given to cgroup s2 (even with
> memory_recursiveprot).
> 
> However, this does not happen. The apparent reason is that when s1 is
> considered for (proportional) reclaim the scanned proportion is rounded
> up to SWAP_CLUSTER_MAX and slightly over-proportional amount is
> reclaimed. Consequently, when the effective low value of s2 is
> calculated, it observes unclaimed parent's protection from s1
> (ε-SWAP_CLUSTER_MAX in theory) and effectively appropriates it.
> The effect is slightly regularized protection (workload dependent)
> between siblings and misreported MEMCG_LOW event when reclaiming s2 with
> this protection.
> 
> Fix the behavior by not reporting breached memory.low in such
> situations. (This affects also setups where all siblings have
> memory.low=0, parent's memory.events:low will still be non-zero when
> parent's memory.low is breached but it will be reduced by the events
> originated in children.)
> 
> Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
> Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
> Link: https://lore.kernel.org/all/20220321101429.3703-1-rpalethorpe@suse.com/
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Hi Michal!

Does it mean that in the following configuration:
	`parent .low=50M
	  ` s1	.low=0M   .current=50M
	  ` s2  .low=0M   .current=50M
there will be no memory.events::low at all? (assuming the recursive thing is on)

Thanks!

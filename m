Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1D50A5CE
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiDUQgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiDUQgg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 12:36:36 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D6B14;
        Thu, 21 Apr 2022 09:33:45 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:33:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650558823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2j4GtVd07DMMzhasl57D24rZquXEpncLF4sks2SC8Tg=;
        b=RzjnYy6yqwp7ePlZWOGy4zJ7p9tV7LrQaNicdlcEY3otLSxF2tbfcewQc9CCnxrqW1twUV
        PjfdmRGXTs8IcJWhdFuts+UCnSa5O7u1XeW3jZzhif5rGQE0fMuGg6v+TLoMZC6988/yR4
        Ru8kP7QTO3rUc1mNC/uroAU8bT28HyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Message-ID: <YmGHYNuAp8957ouq@carbon>
References: <20220421145845.1044652-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421145845.1044652-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
> For systems with large number of CPUs, the majority of the memory
> consumed by the mem_cgroup structure is actually the percpu stats
> memory. When a large number of memory cgroups are continuously created
> and destroyed (like in a container host), it is possible that more
> and more mem_cgroup structures remained in the dying state holding up
> increasing amount of percpu memory.
> 
> We can't free up the memory of the dying mem_cgroup structure due to
> active references in some other places. However, the percpu stats memory
> allocated to that mem_cgroup is a different story.
> 
> This patch adds a new percpu_stats_disabled variable to keep track of
> the state of the percpu stats memory. If the variable is set, percpu
> stats update will be disabled for that particular memcg. All the stats
> update will be forward to its parent instead. Reading of the its percpu
> stats will return 0.
> 
> The flushing and freeing of the percpu stats memory is a multi-step
> process. The percpu_stats_disabled variable is set when the memcg is
> being set to offline state. After a grace period with the help of RCU,
> the percpu stats data are flushed and then freed.
> 
> This will greatly reduce the amount of memory held up by dying memory
> cgroups.
> 
> By running a simple management tool for container 2000 times per test
> run, below are the results of increases of percpu memory (as reported
> in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.

Hi Waiman!

I've been proposing the same idea some time ago:
https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .

However I dropped it with the thinking that with many other fixes
preventing the accumulation of the dying cgroups it's not worth the added
complexity and a potential cpu overhead.

I think it ultimately comes to the number of dying cgroups. If it's low,
memory savings are not worth the cpu overhead. If it's high, they are.
I hope long-term to drive it down significantly (with lru-pages reparenting
being the first major milestone), but it might take a while.

I don't have a strong opinion either way, just want to dump my thoughts
on this.

Thanks!

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4E7B0E2F
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 23:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjI0ViJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjI0ViI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 17:38:08 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621E11D
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 14:38:06 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695850683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fue+26Fi7AotWRkg3AT4B3mHGA43i1+EdYHYGE/Ep4Y=;
        b=KKIpmjs6N2RDl4NoQebosFZc/837RlU9Q67hiMiiXzWdf8Ho9dWsfnrAZhwHmYazDbIVIc
        5MThELoMpe7+7DOttUKIcQjnYbyC3R0i+uvwLgpxT0H3vhysicEt9Zz3rz+6MRCSp45NZG
        bITBCQdsIGuUN5iEPoPt2o4bmYasj5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <ZRSgq_l2IXmedy4V@P9FQF9L96D.corp.robot.car>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927184738.GC365513@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 02:47:38PM -0400, Johannes Weiner wrote:
> On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > > Currently, hugetlb memory usage is not acounted for in the memory
> > > controller, which could lead to memory overprotection for cgroups with
> > > hugetlb-backed memory. This has been observed in our production system.
> > > 
> > > This patch series rectifies this issue by charging the memcg when the
> > > hugetlb folio is allocated, and uncharging when the folio is freed. In
> > > addition, a new selftest is added to demonstrate and verify this new
> > > behavior.
> > 
> > The primary reason why hugetlb is living outside of memcg (and the core
> > MM as well) is that it doesn't really fit the whole scheme. In several
> > aspects. First and the foremost it is an independently managed resource
> > with its own pool management, use and lifetime.
> 
> Honestly, the simpler explanation is that few people have used hugetlb
> in regular, containerized non-HPC workloads.
> 
> Hugetlb has historically been much more special, and it retains a
> specialness that warrants e.g. the hugetlb cgroup container. But it
> has also made strides with hugetlb_cma, migratability, madvise support
> etc. that allows much more on-demand use. It's no longer the case that
> you just put a static pool of memory aside during boot and only a few
> blessed applications are using it.
> 
> For example, we're using hugetlb_cma very broadly with generic
> containers. The CMA region is fully usable by movable non-huge stuff
> until huge pages are allocated in it. With the hugetlb controller you
> can define a maximum number of hugetlb pages that can be used per
> container. But what if that container isn't using any? Why shouldn't
> it be allowed to use its overall memory allowance for anon and cache
> instead?

Cool, I remember proposing hugetlb memcg stats several years ago and if
I remember correctly at that time you was opposing it based on the idea
that huge pages are not a part of the overall memcg flow: they are not
a subject for memory pressure, can't be evicted, etc. And thp's were seen
as a long-term replacement. Even though all above it's true, hugetlb has
it's niche and I don't think thp's will realistically replace it any time
soon.

So I'm glad to see this effort (and very supportive) on making hugetlb
more convenient and transparent for an end user.

Thanks!

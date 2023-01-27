Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C167ED4E
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjA0STL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 13:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjA0SS6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 13:18:58 -0500
X-Greylist: delayed 154994 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 10:18:19 PST
Received: from out-2.mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A787149
        for <cgroups@vger.kernel.org>; Fri, 27 Jan 2023 10:18:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:18:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674843488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Oj9LUot8v9UmWs1s5SZ+IUpPrWuuoZ3XZ2hVXEhy5g=;
        b=VZI9VXlfrdRerdLzb6CKAsXoUkHokf3UukfdpnDvbITMbonS+ZoXjIB1MUGbIdCV2Wd8D/
        9Jh2qysBomyX24SkHR7PZ5bPyIhx8Gk5KmmwuRlYtp5/NGyXgA9UmF+kZuDmiZgZRLi2Jk
        aYJG8E4rLBLWxCvua/0IFHBLGxuS290=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9QVWwAreTlDVdZ0@P9FQF9L96D.corp.robot.car>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
 <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PYe1X7dRQOcahg@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 02:58:19PM +0100, Michal Hocko wrote:
> On Fri 27-01-23 08:11:04, Michal Hocko wrote:
> > [Cc Frederic]
> > 
> > On Thu 26-01-23 15:12:35, Roman Gushchin wrote:
> > > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > [...]
> > > > > Essentially each cpu will try to grab the remains of the memory quota
> > > > > and move it locally. I wonder in such circumstances if we need to disable the pcp-caching
> > > > > on per-cgroup basis.
> > > > 
> > > > I think it would be more than sufficient to disable pcp charging on an
> > > > isolated cpu.
> > > 
> > > It might have significant performance consequences.
> > 
> > Is it really significant?
> > 
> > > I'd rather opt out of stock draining for isolated cpus: it might slightly reduce
> > > the accuracy of memory limits and slightly increase the memory footprint (all
> > > those dying memcgs...), but the impact will be limited. Actually it is limited
> > > by the number of cpus.
> > 
> > Hmm, OK, I have misunderstood your proposal. Yes, the overal pcp charges
> > potentially left behind should be small and that shouldn't really be a
> > concern for memcg oom situations (unless the limit is very small and
> > workloads on isolated cpus using small hard limits is way beyond my
> > imagination).
> > 
> > My first thought was that those charges could be left behind without any
> > upper bound but in reality sooner or later something should be running
> > on those cpus and if the memcg is gone the pcp cache would get refilled
> > and old charges gone.
> > 
> > So yes, this is actually a better and even simpler solution. All we need
> > is something like this
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ab457f0394ab..13b84bbd70ba 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2344,6 +2344,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> >  		struct mem_cgroup *memcg;
> >  		bool flush = false;
> >  
> > +		if (cpu_is_isolated(cpu))
> > +			continue;
> > +
> >  		rcu_read_lock();
> >  		memcg = stock->cached;
> >  		if (memcg && stock->nr_pages &&
> 
> Btw. this would be over pessimistic. The following should make more
> sense:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0394ab..55e440e54504 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2357,7 +2357,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
>  			if (cpu == curcpu)
>  				drain_local_stock(&stock->work);
> -			else
> +			else if (!cpu_is_isolated(cpu))
>  				schedule_work_on(cpu, &stock->work);
>  		}
>  	}


Yes, this is exactly what I was thinking of. It should solve the problem
for isolated cpus well enough without introducing an overhead for everybody else.

If you'll make a proper patch, please add my
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

I understand the concerns regarding spurious OOMs on 256-cores machine,
but I guess they are somewhat theoretical and also possible with the current code
(e.g. one ooming cgroup can effectively block draining for everybody else).

Thanks!

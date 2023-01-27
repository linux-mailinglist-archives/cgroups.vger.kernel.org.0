Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9C67E605
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 14:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjA0NEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 08:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjA0NEG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 08:04:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099C1E1F5;
        Fri, 27 Jan 2023 05:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C463AB820C6;
        Fri, 27 Jan 2023 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228A9C433D2;
        Fri, 27 Jan 2023 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674824642;
        bh=5/c2AB+sVfBr3bN7TBwjNlpfu3p70/0YG6h0yWH9Mpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHJpxk7EFq6ak/R8ldY7KoUAXIlE2dZyXktge26XKHv9g66w8Izx9NuNibJZEOrwz
         HxgvWvRBRErjHhikZlfyKKCHqBxbFM3JYu6q2pUincrQeHyB5ye561Ic/ed1NnY5wC
         znydMQCtv2iEuj6odOpLLra+NAdugUihIlaD7nwrbZnuZI8L9JMr2az2IqhC5Lsy+h
         y45Gis+7DoDk/XNeosPI979PPqlzsCRl6GF73eF9/yUAZxdtDwFVVvgxEQudOUhGH7
         ZY1rOejeZI0pqRMK2/Wk+85B4AZ/IhS29y6GRuxXlaDIuQ5CWk6Zg/qxpmyau11j8o
         rSLXu+bX8FWaw==
Date:   Fri, 27 Jan 2023 14:03:59 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9PLvzI8WU0vYWUt@lothringen>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
 <52a0f1e593b1ec0ca7e417ba37680d65df22de82.camel@redhat.com>
 <601fc35a8cc2167e53e45c636fccb2d899fd7c50.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <601fc35a8cc2167e53e45c636fccb2d899fd7c50.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 05:12:13AM -0300, Leonardo Brás wrote:
> On Fri, 2023-01-27 at 04:22 -0300, Leonardo Brás wrote:
> > > Hmm, OK, I have misunderstood your proposal. Yes, the overal pcp charges
> > > potentially left behind should be small and that shouldn't really be a
> > > concern for memcg oom situations (unless the limit is very small and
> > > workloads on isolated cpus using small hard limits is way beyond my
> > > imagination).
> > > 
> > > My first thought was that those charges could be left behind without any
> > > upper bound but in reality sooner or later something should be running
> > > on those cpus and if the memcg is gone the pcp cache would get refilled
> > > and old charges gone.
> > > 
> > > So yes, this is actually a better and even simpler solution. All we need
> > > is something like this
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index ab457f0394ab..13b84bbd70ba 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2344,6 +2344,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  		struct mem_cgroup *memcg;
> > >  		bool flush = false;
> > >  
> > > +		if (cpu_is_isolated(cpu))
> > > +			continue;
> > > +
> > >  		rcu_read_lock();
> > >  		memcg = stock->cached;
> > >  		if (memcg && stock->nr_pages &&
> > > 
> > > There is no such cpu_is_isolated() AFAICS so we would need a help from
> > > NOHZ and cpuisol people to create one for us. Frederic, would such an
> > > abstraction make any sense from your POV?
> > 
> > 
> > IIUC, 'if (cpu_is_isolated())' would be instead:
> > 
> > if (!housekeeping_cpu(smp_processor_id(), HK_TYPE_DOMAIN) ||
> > !housekeeping_cpu(smp_processor_id(), HK_TYPE_WQ)
> 
> oh, sorry 's/smp_processor_id()/cpu/' here:
> 
> if(!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) || !housekeeping_cpu(cpu, HK_TYPE_WQ))

Do you also need to handle cpuset.sched_load_balance=0 (aka. cpuset v2 "isolated"
partition type). It has the same effect as isolcpus=, but it can be changed at
runtime.

And then on_null_domain() look like what you need. You'd have to make that API
more generally available though, and rename it to something like
"bool cpu_has_null_domain(int cpu)".

But then you also need to handle concurrent cpuset changes. If you can tolerate
it to be racy, then RCU alone is fine.

Thanks.

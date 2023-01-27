Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695E967F268
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 00:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjA0Xup (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 18:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjA0Xuo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 18:50:44 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3B786636;
        Fri, 27 Jan 2023 15:50:37 -0800 (PST)
Date:   Fri, 27 Jan 2023 15:50:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674863436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/s356kjQjTo/NKt8pwAEyADOkBLZ0BqETecZLsYgjM=;
        b=Oje197PRQ2GU1rKiuR/Hn8mnMhKtnmSzuaghr6jKx8M84GPls+gqP225AjheHQL1QVvC0C
        MUgefT43v07E2KVZUjbAEqfrnW86BJk9+nzjXNDGp5WNLYqVWXGVcFb8lsLUfUjo1tT1lG
        TIDxvvbRZ89OPikOzZ+OIsGWdiodBLo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9RjRxe5Ao2/u+1Y@P9FQF9L96D.corp.robot.car>
References: <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
 <55ac6e3cbb97c7d13c49c3125c1455d8a2c785c3.camel@redhat.com>
 <Y9N7UMrLTyZT71uA@dhcp22.suse.cz>
 <15c605f27f87d732e80e294f13fd9513697b65e3.camel@redhat.com>
 <Y9OZezjUPITtEvTx@dhcp22.suse.cz>
 <029147be35b5173d5eb10c182e124ac9d2f1f0ba.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <029147be35b5173d5eb10c182e124ac9d2f1f0ba.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 04:29:37PM -0300, Leonardo Brás wrote:
> On Fri, 2023-01-27 at 10:29 +0100, Michal Hocko wrote:
> > On Fri 27-01-23 04:35:22, Leonardo Brás wrote:
> > > On Fri, 2023-01-27 at 08:20 +0100, Michal Hocko wrote:
> > > > On Fri 27-01-23 04:14:19, Leonardo Brás wrote:
> > > > > On Thu, 2023-01-26 at 15:12 -0800, Roman Gushchin wrote:
> > > > [...]
> > > > > > I'd rather opt out of stock draining for isolated cpus: it might slightly reduce
> > > > > > the accuracy of memory limits and slightly increase the memory footprint (all
> > > > > > those dying memcgs...), but the impact will be limited. Actually it is limited
> > > > > > by the number of cpus.
> > > > > 
> > > > > I was discussing this same idea with Marcelo yesterday morning.
> > > > > 
> > > > > The questions had in the topic were:
> > > > > a - About how many pages the pcp cache will hold before draining them itself? 
> > > > 
> > > > MEMCG_CHARGE_BATCH (64 currently). And one more clarification. The cache
> > > > doesn't really hold any pages. It is a mere counter of how many charges
> > > > have been accounted for the memcg page counter. So it is not really
> > > > consuming proportional amount of resources. It just pins the
> > > > corresponding memcg. Have a look at consume_stock and refill_stock
> > > 
> > > I see. Thanks for pointing that out!
> > > 
> > > So in worst case scenario the memcg would have reserved 64 pages * (numcpus - 1)
> > 
> > s@numcpus@num_isolated_cpus@
> 
> I was thinking worst case scenario being (ncpus - 1) being isolated.
> 
> > 
> > > that are not getting used, and may cause an 'earlier' OOM if this amount is
> > > needed but can't be freed.
> > 
> > s@OOM@memcg OOM@
>  
> > > In the wave of worst case, supposing a big powerpc machine, 256 CPUs, each
> > > holding 64k * 64 pages => 1GB memory - 4MB (one cpu using resources).
> > > It's starting to get too big, but still ok for a machine this size.
> > 
> > It is more about the memcg limit rather than the size of the machine.
> > Again, let's focus on actual usacase. What is the usual memcg setup with
> > those isolcpus
> 
> I understand it's about the limit, not actually allocated memory. When I point
> the machine size, I mean what is expected to be acceptable from a user in that
> machine.
> 
> > 
> > > The thing is that it can present an odd behavior: 
> > > You have a cgroup created before, now empty, and try to run given application,
> > > and hits OOM.
> > 
> > The application would either consume those cached charges or flush them
> > if it is running in a different memcg. Or what do you have in mind?
> 
> 1 - Create a memcg with a VM inside, multiple vcpus pinned to isolated cpus. 
> 2 - Run multi-cpu task inside the VM, it allocates memory for every CPU and keep
>     the pcp cache
> 3 - Try to run a single-cpu task (pinned?) inside the VM, which uses almost all
>     the available memory.
> 4 - memcg OOM.
> 
> Does it make sense?

It can happen now as well, you just need a competing drain request.

Honestly, I feel the probability of this scenario to be a real problem is fairly low.
I don't recall any complains on spurious OOMs because of races in the draining code.
Usually machines which are tight on memory are rarely have so many idle cpus.

Thanks!

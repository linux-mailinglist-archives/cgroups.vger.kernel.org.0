Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5205F475C
	for <lists+cgroups@lfdr.de>; Tue,  4 Oct 2022 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJDQSu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJDQSt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 12:18:49 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E645F119
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 09:18:48 -0700 (PDT)
Date:   Tue, 4 Oct 2022 09:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664900326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUComksE3kcEt46sxXrKqcpfs6gx5hGj/h6rV5lmqcA=;
        b=sMO7vktZT5MGx84xs2oOUmu8oUi89tdQnMxkIFjywwl4y39OEIc2bizLFqfa+JS6ri6azL
        Puy0FUqzIvk0/3dyPuJS4UoaxKZk12X/YFishkxYpBUyyi2TlsCqf3i3rXFq8BZhbPfgA+
        IgKU+H2s3Qlcq0X/zgTyfbpEgtEQMgw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexander Fedorov <halcien@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <Yzxc0jzOnAu667F8@P9FQF9L96D.lan>
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
 <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
 <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 03, 2022 at 06:01:35PM +0300, Alexander Fedorov wrote:
> On 03.10.2022 17:27, Michal Hocko wrote:
> > On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
> >> On 03.10.2022 16:32, Michal Hocko wrote:
> >>> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> >>>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> >>>>  		stock->nr_bytes = 0;
> >>>>  	}
> >>>>  
> >>>> -	obj_cgroup_put(old);
> >>>> +	/*
> >>>> +	 * Clear pointer before freeing memory so that
> >>>> +	 * drain_all_stock() -> obj_stock_flush_required()
> >>>> +	 * does not see a freed pointer.
> >>>> +	 */
> >>>>  	stock->cached_objcg = NULL;
> >>>> +	obj_cgroup_put(old);
> >>>
> >>> Do we need barrier() or something else to ensure there is no reordering?
> >>> I am not reallyu sure what kind of barriers are implied by the pcp ref
> >>> counting.
> >>
> >> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
> >> of this:
> > 
> > This is a very subtle guarantee. Also it would only apply if this is the
> > last reference, right?
> 
> Hmm, yes, for the last reference only, also not sure about pcp ref
> counter ordering rules for previous references.
> 
> > Is there any reason to not use
> > 	WRITE_ONCE(stock->cached_objcg, NULL);
> > 	obj_cgroup_put(old);
> > 
> > IIRC this should prevent any reordering. 
> 
> Now that I think about it we actually must use WRITE_ONCE everywhere
> when writing cached_objcg because otherwise compiler might split the
> pointer-sized store into several smaller-sized ones (store tearing),
> and obj_stock_flush_required() would read garbage instead of pointer.
>
> And thinking about memory barriers, maybe we need them too alongside
> WRITE_ONCE when setting pointer to non-null value?  Otherwise
> drain_all_stock() -> obj_stock_flush_required() might read old data.
> Since that's exactly what rcu_assign_pointer() does, it seems
> that we are going back to using rcu_*() primitives everywhere?

Hm, Idk, I'm still somewhat resistant to the idea of putting rcu primitives,
but maybe it's the right thing. Maybe instead we should always schedule draining
on all cpus instead and perform a cpu-local check and bail out if a flush is not
required? Michal, Johannes, what do you think?

Btw the same approach is used for the memcg part (stock->cached),
so if we're going to change anything, we need to change it too.

Thanks!

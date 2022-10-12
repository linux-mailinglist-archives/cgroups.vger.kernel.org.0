Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E15FCAF5
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJLStp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJLSto (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 14:49:44 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02662F7
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 11:49:41 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:49:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665600579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Tsf5zz1GW2rML7CvmH3MY34IWxeLBZAZox8uNXTDHU=;
        b=H5WmaHCzc7Mu/b1qg3xj/6AAJ3EjnFJH8hsQWN8lEpm12u4w3Icd9wY4OIrVZEiRiseZtw
        8b9WEv2Lq644/rOIRbjwdSdWVEBpgjiRLcrgyT5CogKbpr7IobBnmzVmpODs6qaEMuW7cn
        gyyNLv09fLsjlm/isyRoMmOi5hR2YsI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alexander Fedorov <halcien@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <Y0cMMPwE4aus3P9c@P9FQF9L96D.corp.robot.car>
References: <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
 <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
 <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
 <Yzxc0jzOnAu667F8@P9FQF9L96D.lan>
 <Y0b3/wGDBL7GaNWJ@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0b3/wGDBL7GaNWJ@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 12, 2022 at 01:23:11PM -0400, Johannes Weiner wrote:
> On Tue, Oct 04, 2022 at 09:18:26AM -0700, Roman Gushchin wrote:
> > On Mon, Oct 03, 2022 at 06:01:35PM +0300, Alexander Fedorov wrote:
> > > On 03.10.2022 17:27, Michal Hocko wrote:
> > > > On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
> > > >> On 03.10.2022 16:32, Michal Hocko wrote:
> > > >>> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> > > >>>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> > > >>>>  		stock->nr_bytes = 0;
> > > >>>>  	}
> > > >>>>  
> > > >>>> -	obj_cgroup_put(old);
> > > >>>> +	/*
> > > >>>> +	 * Clear pointer before freeing memory so that
> > > >>>> +	 * drain_all_stock() -> obj_stock_flush_required()
> > > >>>> +	 * does not see a freed pointer.
> > > >>>> +	 */
> > > >>>>  	stock->cached_objcg = NULL;
> > > >>>> +	obj_cgroup_put(old);
> > > >>>
> > > >>> Do we need barrier() or something else to ensure there is no reordering?
> > > >>> I am not reallyu sure what kind of barriers are implied by the pcp ref
> > > >>> counting.
> > > >>
> > > >> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
> > > >> of this:
> > > > 
> > > > This is a very subtle guarantee. Also it would only apply if this is the
> > > > last reference, right?
> > > 
> > > Hmm, yes, for the last reference only, also not sure about pcp ref
> > > counter ordering rules for previous references.
> > > 
> > > > Is there any reason to not use
> > > > 	WRITE_ONCE(stock->cached_objcg, NULL);
> > > > 	obj_cgroup_put(old);
> > > > 
> > > > IIRC this should prevent any reordering. 
> > > 
> > > Now that I think about it we actually must use WRITE_ONCE everywhere
> > > when writing cached_objcg because otherwise compiler might split the
> > > pointer-sized store into several smaller-sized ones (store tearing),
> > > and obj_stock_flush_required() would read garbage instead of pointer.
> > >
> > > And thinking about memory barriers, maybe we need them too alongside
> > > WRITE_ONCE when setting pointer to non-null value?  Otherwise
> > > drain_all_stock() -> obj_stock_flush_required() might read old data.
> > > Since that's exactly what rcu_assign_pointer() does, it seems
> > > that we are going back to using rcu_*() primitives everywhere?
> > 
> > Hm, Idk, I'm still somewhat resistant to the idea of putting rcu primitives,
> > but maybe it's the right thing. Maybe instead we should always schedule draining
> > on all cpus instead and perform a cpu-local check and bail out if a flush is not
> > required? Michal, Johannes, what do you think?
> 
> I agree it's overkill.
> 
> This is a speculative check, and we don't need any state coherency,
> just basic lifetime. READ_ONCE should fully address this problem. That
> said, I think the code could be a bit clearer and better documented.
> 
> How about the below?

I'm fine with using READ_ONCE() to fix this immediate issue (I suggested it
in the thread above), please feel free to add my ack:
Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

We might need a barrier() between zeroing stock->cached and dropping the last
reference, as discussed above, however I don't think this issue can be
realistically trgiggered in the real life.

However I think our overall approach to flushing is questionable:
1) we often don't flush when it's necessary: if there is a concurrent flushing
we just bail out, even if that flushing is related to a completely different
part of the cgroup tree (e.g. a leaf node belonging to a distant branch).
2) we can race and flush when it's not necessarily: if another cpu is busy,
likely by the time when work will be executed there will be already another
memcg cached. So IMO we need to move this check into the flushing thread.

I'm working on a different approach, but it will take time and also likely be
too invasive for @stable, so fixing the crash discovered by Alexander with
READ_ONCE() is a good idea.

Thanks!

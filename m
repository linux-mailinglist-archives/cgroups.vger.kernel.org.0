Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE975F240C
	for <lists+cgroups@lfdr.de>; Sun,  2 Oct 2022 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJBQRA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 2 Oct 2022 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBQQ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 2 Oct 2022 12:16:59 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119D2DAB6
        for <cgroups@vger.kernel.org>; Sun,  2 Oct 2022 09:16:57 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:16:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664727415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0nWc8MunwJqD9KPrKGnLf0JLwwF80l+3rGQtQR1k1PY=;
        b=Lyp+X/s8OqKJKuTIQTX8DMlSg4GRJZi9mxdh9lNhazDQEJafn4I+NEUkPaMVKQROjW8jQO
        E1+vpn71+zP2lxW8Hun8+foAsB2/MD50vrWPHXfMiBIV0s6BIjURXDE9XMgMw/fvt7Unu3
        lwwcAn9mHtZtvVE9xgAefgJKiFyTTO8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexander Fedorov <halcien@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 01, 2022 at 03:38:43PM +0300, Alexander Fedorov wrote:
> On 30.09.2022 21:26, Roman Gushchin wrote:
> > On Fri, Sep 30, 2022 at 02:06:48PM +0000, Alexander Fedorov wrote:
> >> 1) First CPU:
> >>    css_killed_work_fn() -> mem_cgroup_css_offline() ->
> >> drain_all_stock() -> obj_stock_flush_required()
> >>         if (stock->cached_objcg) {
> >>
> >> This check sees a non-NULL pointer for *another* CPU's `memcg_stock`
> >> instance.
> >>
> >> 2) Second CPU:
> >>   css_free_rwork_fn() -> __mem_cgroup_free() -> free_percpu() ->
> >> obj_cgroup_uncharge() -> drain_obj_stock()
> >> It frees `cached_objcg` pointer in its own `memcg_stock` instance:
> >>         struct obj_cgroup *old = stock->cached_objcg;
> >>         < ... >
> >>         obj_cgroup_put(old);
> >>         stock->cached_objcg = NULL;
> >>
> >> 3) First CPU continues after the 'if' check and re-reads the pointer
> >> again, now it is NULL and dereferencing it leads to kernel panic:
> >> static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> >>                                      struct mem_cgroup *root_memcg)
> >> {
> >> < ... >
> >>         if (stock->cached_objcg) {
> >>                 memcg = obj_cgroup_memcg(stock->cached_objcg);
> > 
> > Great catch!
> > 
> > I'm not sure about switching to rcu primitives though. In all other cases
> > stock->cached_objcg is accessed only from a local cpu, so using rcu_*
> > function is an overkill.
> > 
> > How's something about this? (completely untested)
> 
> Tested READ_ONCE() patch and it works.

Thank you!

> But are rcu primitives an overkill?
> For me they are documenting how actually complex is synchronization here.

I agree, however rcu primitives will add unnecessary barriers on hot paths.
In this particular case most accesses to stock->cached_objcg are done from
a local cpu, so no rcu primitives are needed. So in my opinion using a
READ_ONCE() is preferred.

Thanks!

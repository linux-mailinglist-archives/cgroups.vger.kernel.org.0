Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0168B171
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBETt3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 14:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBETt2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 14:49:28 -0500
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7C1B544
        for <cgroups@vger.kernel.org>; Sun,  5 Feb 2023 11:49:27 -0800 (PST)
Date:   Sun, 5 Feb 2023 11:49:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675626564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCXR2fdD5KUizgsD+r8xIXos+I6YOtrXfgJwLA6SDKs=;
        b=EiKIcs3Klx+YgeINRkbrjeT48IQMnlUunMLev5pz3djUhjV6YTD/1jYT489gdALY33FZCx
        dSbnndEJe4EaJCa9nw0etCNxIxWraIHACeTmUQS0DGR5VCNsZsBBcLx7vhAaIdbA07JJPu
        9kXpNSVt5VA+kI0R8AAL2XXGsKB+Ues=
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
Message-ID: <Y+AIOQy0HdVXCw8m@P9FQF9L96D>
References: <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
 <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
 <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
 <Y9j9BnMwfm4TJks7@tpad>
 <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
 <28e08669302ad1e7a41bdf8b9988de6a352b5fe1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e08669302ad1e7a41bdf8b9988de6a352b5fe1.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Leonardo!

> Yes, but we are exchanging an "always schedule_work_on()", which is a kind of
> contention, for a "sometimes we hit spinlock contention".
> 
> For the spinlock proposal, on the local cpu side, the *worst case* contention
> is:
> 1 - wait the spin_unlock() for a complete <percpu cache drain process>,
> 2 - wait a cache hit for local per-cpu cacheline 
> 
> What is current implemented (schedule_work_on() approach), for the local
> cpu side there is *always* this contention:
> 1 - wait for a context switch,
> 2 - wait a cache hit from it's local per-cpu cacheline,
> 3 - wait a complete <percpu cache drain process>, 
> 4 - then for a new context switch to the current thread.

I think both Michal and me are thinking of a more generic case in which the cpu
is not exclusively consumed by 1 special process, so that the draining work can
be executed during an idle time. In this case the work is basically free.

And the introduction of a spin_lock() on the hot path is what we're are concerned
about. I agree, that on some hardware platforms it won't be that expensive, but
in general not having any spinlocks is so much better.

> 
> So moving from schedule_work_on() to spinlocks will save 2 context switches per
> cpu every time drain_all_stock() is called.
> 
> On the remote cpu side, my tests point that doing the remote draining is faster
> than scheduling a local draining, so it's also a gain.
> 
> Also, IIUC the possible contention in the spinlock approach happens only on
> page-faulting and syscalls, versus the schedule_work_on() approach that can
> interrupt user workload at any time. 
> 
> In fact, not interrupting the user workload in isolated cpus is just a bonus of
> using spinlocks.

I believe it significantly depends on the preemption model: you're right regarding
fully preemptive kernels, but with voluntary/none preemption it's exactly opposite:
the draining work will be executed at some point later (probably with 0 cost),
while the remote access from another cpu will potentially cause delays on the
spin lock as well as a need to refill the stock.

Overall I'd expect a noticeable performance regression from an introduction of
spin locks and remote draining. Maybe not on all platforms, but at least on some.
That's my main concern. And I don't think the problem we're aiming to solve here
justifies this potential regression.

Thanks!

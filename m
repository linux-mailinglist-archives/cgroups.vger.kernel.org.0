Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943814F1D09
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379413AbiDDV3w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379716AbiDDR56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 13:57:58 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816A34BB9;
        Mon,  4 Apr 2022 10:56:00 -0700 (PDT)
Date:   Mon, 4 Apr 2022 10:55:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649094958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmH99+DBVlr0RDRHg6d0xXShdFBM4MwOGHgQ6yh7ANk=;
        b=VhLZGR3a/zgPgv7sPn3xO5HKrgMX5L37P3/hPiSSDl6+1/fwGpvViwyXqvRV9ZJrrEX2Ci
        vUQTM1nHzb4OkOBjUpq8L/sMIrZYbUolYx/WGDtd/9iBG9aJouCY6w9kgo300dvxwOMPDg
        q+HvZZMqPl0nvGxqsXYZ45W6aAZ0V1Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <YksxIg185zt8LVp6@carbon.dhcp.thefacebook.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
 <CAJD7tkYVpnf1+sa9vRAQCw5H0LUH6zE6_yhNAFwKF3sW0BLzEA@mail.gmail.com>
 <YkdG4nv/uKI0EtMp@carbon.dhcp.thefacebook.com>
 <CAJD7tkZLdqFvoZzZMY860hxn-Fht2nyatF6Y1io6dTnhC8+xcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZLdqFvoZzZMY860hxn-Fht2nyatF6Y1io6dTnhC8+xcg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 04, 2022 at 10:13:03AM -0700, Yosry Ahmed wrote:
> On Fri, Apr 1, 2022 at 11:39 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Fri, Apr 01, 2022 at 02:11:51AM -0700, Yosry Ahmed wrote:
> > > On Thu, Mar 31, 2022 at 10:25 AM Roman Gushchin
> > > <roman.gushchin@linux.dev> wrote:
> > > >
> > > > On Thu, Mar 31, 2022 at 08:41:51AM +0000, Yosry Ahmed wrote:
> > > > > From: Shakeel Butt <shakeelb@google.com>
> > > > >
> > > > > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> > > > >
> > > > > Use case: Proactive Reclaim
> > > > > ---------------------------
> > > > >
> > > > > A userspace proactive reclaimer can continuously probe the memcg to
> > > > > reclaim a small amount of memory. This gives more accurate and
> > > > > up-to-date workingset estimation as the LRUs are continuously
> > > > > sorted and can potentially provide more deterministic memory
> > > > > overcommit behavior. The memory overcommit controller can provide
> > > > > more proactive response to the changing behavior of the running
> > > > > applications instead of being reactive.
> > > > >
> > > > > A userspace reclaimer's purpose in this case is not a complete replacement
> > > > > for kswapd or direct reclaim, it is to proactively identify memory savings
> > > > > opportunities and reclaim some amount of cold pages set by the policy
> > > > > to free up the memory for more demanding jobs or scheduling new jobs.
> > > > >
> > > > > A user space proactive reclaimer is used in Google data centers.
> > > > > Additionally, Meta's TMO paper recently referenced a very similar
> > > > > interface used for user space proactive reclaim:
> > > > > https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> > > > >
> > > > > Benefits of a user space reclaimer:
> > > > > -----------------------------------
> > > > >
> > > > > 1) More flexible on who should be charged for the cpu of the memory
> > > > > reclaim. For proactive reclaim, it makes more sense to be centralized.
> > > > >
> > > > > 2) More flexible on dedicating the resources (like cpu). The memory
> > > > > overcommit controller can balance the cost between the cpu usage and
> > > > > the memory reclaimed.
> > > > >
> > > > > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > > > > under memory pressure better reclaim candidates are selected. This also
> > > > > gives more accurate and uptodate notion of working set for an
> > > > > application.
> > > > >
> > > > > Why memory.high is not enough?
> > > > > ------------------------------
> > > > >
> > > > > - memory.high can be used to trigger reclaim in a memcg and can
> > > > >   potentially be used for proactive reclaim.
> > > > >   However there is a big downside in using memory.high. It can potentially
> > > > >   introduce high reclaim stalls in the target application as the
> > > > >   allocations from the processes or the threads of the application can hit
> > > > >   the temporary memory.high limit.
> > > > >
> > > > > - Userspace proactive reclaimers usually use feedback loops to decide
> > > > >   how much memory to proactively reclaim from a workload. The metrics
> > > > >   used for this are usually either refaults or PSI, and these metrics
> > > > >   will become messy if the application gets throttled by hitting the
> > > > >   high limit.
> > > > >
> > > > > - memory.high is a stateful interface, if the userspace proactive
> > > > >   reclaimer crashes for any reason while triggering reclaim it can leave
> > > > >   the application in a bad state.
> > > > >
> > > > > - If a workload is rapidly expanding, setting memory.high to proactively
> > > > >   reclaim memory can result in actually reclaiming more memory than
> > > > >   intended.
> > > > >
> > > > > The benefits of such interface and shortcomings of existing interface
> > > > > were further discussed in this RFC thread:
> > > > > https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> > > >
> > > > Hello!
> > > >
> > > > I'm totally up for the proposed feature! It makes total sense and is proved
> > > > to be useful, let's add it.
> > > >
> > > > >
> > > > > Interface:
> > > > > ----------
> > > > >
> > > > > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > > > > trigger reclaim in the target memory cgroup.
> > > > >
> > > > >
> > > > > Possible Extensions:
> > > > > --------------------
> > > > >
> > > > > - This interface can be extended with an additional parameter or flags
> > > > >   to allow specifying one or more types of memory to reclaim from (e.g.
> > > > >   file, anon, ..).
> > > > >
> > > > > - The interface can also be extended with a node mask to reclaim from
> > > > >   specific nodes. This has use cases for reclaim-based demotion in memory
> > > > >   tiering systens.
> > > > >
> > > > > - A similar per-node interface can also be added to support proactive
> > > > >   reclaim and reclaim-based demotion in systems without memcg.
> > > >
> > > > Maybe an option to specify a timeout? That might simplify the userspace part.
> > > > Also, please please add a test to selftests/cgroup/memcg tests.
> > > > It will also provide an example on how the userspace can use the feature.
> > > >
> > >
> > > Hi Roman, thanks for taking the time to review this!
> > >
> > > A timeout can be a good extension, I will add it to the commit message
> > > in the next version in possible extensions.
> > >
> > > I will add a test in v2, thanks!
> >
> > Great, thank you!
> >
> > >
> > > >
> > > > >
> > > > > For now, let's keep things simple by adding the basic functionality.
> > > >
> > > > What I'm worried about is how we gonna extend it? How do you see the interface
> > > > with 2-3 extensions from the list above? All these extensions look very
> > > > reasonable to me, so we'll likely have to implement them soon. So let's think
> > > > about the extensibility now.
> > > >
> > >
> > > My idea is to have these extensions as optional positional arguments
> > > (like Wei suggested), so that the interface does not get too
> > > complicated for users who don't care about tuning these options. If
> > > this is the case then I think there is nothing to worry about.
> > > Otherwise, if you think some of these options make sense to be a
> > > required argument instead, we can rethink the initial interface.
> >
> > The interface you're proposing is not really extensible, so we'll likely need to
> > introduce a new interface like memory.reclaim_ext very soon. Why not create
> > an extensible API from scratch?
> >
> > I'm looking at cgroup v2 documentation which describes various interface files
> > formats and it seems like given the number of potential optional arguments
> > the best option is nested keyed (please, refer to the Interface Files section).
> >
> > E.g. the format can be:
> > echo "1G type=file nodemask=1-2 timeout=30s" > memory.reclaim
> >
> > We can say that now we don't support any keyed arguments, but they can be
> > added in the future.
> >
> > Basically you don't even need to change any code, only document the interface
> > properly, so we can extend it later without breaking the API.
> >
> 
> Thanks a lot for suggesting this, it indeed looks very much cleaner.
> 
> I will make sure to document the interface properly as suggested in v2.
> 
> > >
> > > > I wonder if it makes more sense to introduce a sys_reclaim() syscall instead?
> > > > In the end, such a feature might make sense on the system level too.
> > > > Yes, there is the drop_caches sysctl, but it's too radical for many cases.
> > > >
> > >
> > > I think in the RFC discussion there was consensus to add both a
> > > per-memcg knob, as well as per-node / per-system knobs (through sysfs
> > > or syscalls) later. Wei also points out that it's not common for a
> > > syscall to have a cgroup argument.
> >
> > Actually there are examples (e.g. sys_bpf), but my only point is to make
> > the API extensible, so maybe syscall is not the best idea.
> >
> > I'd add the root level interface from scratch: the code change is simple
> > and it makes sense as a feature. Then likely we don't really need another
> > system-level interface at all.
> >
> 
> I think we would still need a system-level interface anyway for
> systems with no memcg that wish to make use of proactive memory
> reclaim. We can still make the memory.reclaim interface available for
> root as well if you think this is desirable.

Yes, I think it's a good idea. !memcg systems is a different story, we can
handle them separately.

Thanks!

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E71682C5C
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 13:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAaMPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 07:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjAaMPK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 07:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF973FF09
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675167263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZI6TznWrCUh+xycNx8ZosQqJbANhtpTUAwz/zUSHIhs=;
        b=ClB6+t231VWVALVehqCX4f1gmd6bmjdcBi4YVoCkAL5e4ED7vtCovSO1X9t/7jteBm96ep
        llo7VdxxqcB0sBaWILoXgW92rIx7nYnfspeELbCjtLTIQJtSbTuEqmv4mqlgtSoQGzdSaM
        /noD+0a9JWqNbLILsKOSghDjB6mBwi4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-smrMK5jWOvuF5LsHUZQ0ng-1; Tue, 31 Jan 2023 07:14:20 -0500
X-MC-Unique: smrMK5jWOvuF5LsHUZQ0ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2E6C3C0D1AA;
        Tue, 31 Jan 2023 12:14:19 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FF1E112132C;
        Tue, 31 Jan 2023 12:14:19 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 3BE07401346FB; Tue, 31 Jan 2023 08:35:34 -0300 (-03)
Date:   Tue, 31 Jan 2023 08:35:34 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9j9BnMwfm4TJks7@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
 <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
 <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 03:55:39AM -0300, Leonardo Brás wrote:
> On Thu, 2023-01-26 at 20:13 +0100, Michal Hocko wrote:
> > On Thu 26-01-23 15:14:25, Marcelo Tosatti wrote:
> > > On Thu, Jan 26, 2023 at 08:45:36AM +0100, Michal Hocko wrote:
> > > > On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
> > > > [...]
> > > > > Remote draining reduces interruptions whether CPU 
> > > > > is marked as isolated or not:
> > > > > 
> > > > > - Allows isolated CPUs from benefiting of pcp caching.
> > > > > - Removes the interruption to non isolated CPUs. See for example 
> > > > > 
> > > > > https://lkml.org/lkml/2022/6/13/2769
> > > > 
> > > > This is talking about page allocato per cpu caches, right? In this patch
> > > > we are talking about memcg pcp caches. Are you sure the same applies
> > > > here?
> > > 
> > > Both can stall the users of the drain operation.
> > 
> > Yes. But it is important to consider who those users are. We are
> > draining when
> > 	- we are charging and the limit is hit so that memory reclaim
> > 	  has to be triggered.
> > 	- hard, high limits are set and require memory reclaim.
> > 	- force_empty - full memory reclaim for a memcg
> > 	- memcg offlining - cgroup removel - quite a heavy operation as
> > 	  well.
> > all those could be really costly kernel operations and they affect
> > isolated cpu only if the same memcg is used by both isolated and non-isolated
> > cpus. In other words those costly operations would have to be triggered
> > from non-isolated cpus and those are to be expected to be stalled. It is
> > the side effect of the local cpu draining that is scheduled that affects
> > the isolated cpu as well.
> > 
> > Is that more clear?
> 
> I think so, please help me check:
> 
> IIUC, we can approach this by dividing the problem in two working modes:
> 1 - Normal, meaning no drain_all_stock() running.
> 2 - Draining, grouping together pre-OOM and userspace 'config' : changing,
> destroying, reconfiguring a memcg.
> 
> For (1), we will have (ideally) only local cpu working on the percpu struct.
> This mode will not have any kind of contention, because each CPU will hold it's
> own spinlock only. 
> 
> For (2), we will have a lot of drain_all_stock() running. This will mean a lot
> of schedule_work_on() running (on upstream) or possibly causing contention, i.e.
> local cpus having to wait for a lock to get their cache, on the patch proposal.
> 
> Ok, given the above is correct:
> 
> # Some arguments point that (1) becomes slower with this patch.
> 
> This is partially true: while test 2.2 pointed that local cpu functions running
> time had became slower by a few cycles, test 2.4 points that the userspace
> perception of it was that the syscalls and pagefaulting actually became faster:
> 
> During some debugging tests before getting the performance on test 2.4, I
> noticed that the 'syscall + write' test would call all those functions that
> became slower on test 2.2. Those functions were called multiple millions of
> times during a single test, and still the patched version performance test
> returned faster for test 2.4 than upstream version. Maybe the functions became
> slower, but overall the usage of them in the usual context became faster.
> 
> Is not that a small improvement?
> 
> # Regarding (2), I notice that we fear contention 
> 
> While this seems to be the harder part of the discussion, I think we have enough
> data to deal with it. 
> 
> In which case contention would be a big problem here? 
> IIUC it would be when a lot of drain_all_stock() get running because the memory
> limit is getting near. I mean, having the user to create / modify a memcg
> multiple times a second for a while is not something that is expected, IMHO.

Considering that the use of spinlocks with remote draining is the more general solution,
what would be a test-case to demonstrate a contention problem?

> Now, if I assumed correctly and the case where contention could be a problem is
> on a memcg with high memory pressure, then we have the argument that Marcelo
> Tosatti brought to the discussion[P1]: using spinlocks on percpu caches for page
> allocation brought better results than local_locks + schedule_work_on().
> 
> I mean, while contention would cause the cpu to wait for a while before getting
> the lock for allocating a page from cache, something similar would happen with
> schedule_work_on(), which would force the current task to wait while the
> draining happens locally. 
> 
> What I am able to see is that, for each drain_all_stock(), for each cpu getting
> drained we have the option to (a) (sometimes) wait for a lock to be freed, or
> (b) wait for a whole context switch to happen.
> And IIUC, (b) is much slower than (a) on average, and this is what causes the
> improved performance seen in [P1].

Moreover, there is a delay for the remote CPU to execute a work item 
(there could be high priority tasks, IRQ handling on the remote CPU,
which delays execution of the work item even further).

Also, the other point is that the spinlock already exists for
PREEMPT_RT (which means that any potential contention issue 
with the spinlock today is limited to PREEMPT_RT users).

So it would be good to point out a specific problematic 
testcase/scenario with using the spinlock in this particular case?

> (I mean, waiting while drain_local_stock() runs in the local CPU vs waiting for
> it to run on the remote CPU may not be that different, since the cacheline is
> already writen to by the remote cpu on Upstream)
> 
> Also according to test 2.2, for the patched version, drain_local_stock() have
> gotten faster (much faster for 128 cpus), even though it does all the draining
> instead of just scheduling it on the other cpus. 
> I mean, summing that to the brief nature of local cpu functions, we may not hit
> contention as much as we are expected.
> 
> ##
> 
> Sorry for the long text.
> I may be missing some point, please let me know if that's the case.
> 
> Thanks a lot for reviewing!
> Leo
> 
> [P1]: https://lkml.org/lkml/2022/6/13/2769
> 
> 


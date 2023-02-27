Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA06A42A2
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjB0NaM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 08:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjB0NaM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 08:30:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF11C303;
        Mon, 27 Feb 2023 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AB/JJQoz7Q3YSgyTBOyspLv2ZEi2yhJlHwTRl8RgmcI=; b=IDrwwV6BUNud8U9fRntTASkSMH
        ZjLWpC+aiFuWVnovyo1te3tMFRKO3ZyDIO3x0iNv1YskrQJfmFGjmxxDGeJlTozh5OBHwQyzynoqh
        Y8JW086CTgeio8ueWCt8u4l9XYG7mOKI1mreVzU0qgCbUDhqU+qhJoT9TatgBw7x6MOXUwoa3M1ug
        L5bVFP8oY5Gwl5WHdDLKHYhHl+pPD22GB6D0EeWABivGof/q9ZmfVRzEwEyAvCg0+Ku1qNiE3ziEB
        VLQUqEGyheEFwIXLT9NatbYetmw4JO3CBOa3+qEDij/Bard6BM7EcWJYjLYZckNyAlaH0HMn5fWkZ
        rJigvvyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWdZL-0008Kg-7o; Mon, 27 Feb 2023 13:29:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3341300328;
        Mon, 27 Feb 2023 14:29:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5CAE23B2480F; Mon, 27 Feb 2023 14:29:27 +0100 (CET)
Date:   Mon, 27 Feb 2023 14:29:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v10 8/9] sched/fair: Add latency list
Message-ID: <Y/ywN3Sz33gHO3Vj@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-9-vincent.guittot@linaro.org>
 <Y/XlR+wLtn54CkE4@hirez.programming.kicks-ass.net>
 <CAKfTPtBJD6So-0-S3sgFqTE1HVMypg_S23+uuH6BnGk5atxUKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBJD6So-0-S3sgFqTE1HVMypg_S23+uuH6BnGk5atxUKA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 22, 2023 at 12:16:29PM +0100, Vincent Guittot wrote:
> On Wed, 22 Feb 2023 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jan 13, 2023 at 03:12:33PM +0100, Vincent Guittot wrote:
> >
> > > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > > +{
> > > +
> > > +     /* Only latency sensitive entity can be added to the list */
> > > +     if (se->latency_offset >= 0)
> > > +             return;
> > > +
> > > +     if (!RB_EMPTY_NODE(&se->latency_node))
> > > +             return;
> > > +
> > > +     /*
> > > +      * An execution time less than sysctl_sched_min_granularity means that
> > > +      * the entity has been preempted by a higher sched class or an entity
> > > +      * with higher latency constraint.
> > > +      * Put it back in the list so it gets a chance to run 1st during the
> > > +      * next slice.
> > > +      */
> > > +     if (!(flags & ENQUEUE_WAKEUP)) {
> > > +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > > +
> > > +             if (delta_exec >= sysctl_sched_min_granularity)
> > > +                     return;
> > > +     }
> >
> > I'm not a big fan of this dynamic enqueueing condition; it makes it
> > rather hard to interpret the below addition to pick_next_entity().
> >
> > Let me think about this more... at the very least the comment with
> > __pick_first_latency() use below needs to be expanded upon if we keep it
> > like so.
>
> Only the waking tasks should be added in the latency rb tree so they

But that's what I'm saying, you can game this by doing super short
sleeps every min_gran.

> can be selected to run 1st (as long as they don't use too much
> runtime). But task A can wake up, preempts current task B thanks to
> its latency nice , starts to run few usecs but then is immediately
> preempted by a RT task C as an example. In this case, we consider that
> the task A didn't get a chance to run after its wakeup and we put it
> back to the latency rb tree just as if task A has just woken up but
> didn't preempted the new current task C.

So ideally, and this is where I'm very slow with thinking, that
wakeup_preempt_entity() condition here:

> > > @@ -5008,6 +5082,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >               se = cfs_rq->last;
> > >       }
> > >
> > > +     /* Check for latency sensitive entity waiting for running */
> > > +     latency = __pick_first_latency(cfs_rq);
> > > +     if (latency && (latency != se) &&
> > > +         wakeup_preempt_entity(latency, se) < 1)
> > > +             se = latency;

should be sufficient to provide fair bandwidth usage. The EEVDF paper
achieves this by selecting the leftmost elegible task, where elegibility
is dependent on negative lag. Only those tasks that are behind the pack
are allowed runtime.

Now clearly our min_vruntime is unsuited for that exact scheme, but iirc
wake_preempt_entity() does not allow for starvation, so we should be
good, even without that weird condition in __enqueue_latency(), hmm?

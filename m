Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8969F355
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 12:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjBVLQn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 06:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVLQm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 06:16:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5275B470
        for <cgroups@vger.kernel.org>; Wed, 22 Feb 2023 03:16:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so208949pja.5
        for <cgroups@vger.kernel.org>; Wed, 22 Feb 2023 03:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677064600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+BI276LAtkDkFkhbO8UzGamxJ+PETieQFjUz5/ET20=;
        b=mb1mn3MhGDW6cSSFeJGsoejg4FxJ9bOZTCBKtgQJiOvDt4d1akIBSE+tToXBmRv0E5
         V1RjjG21ff9Kjre2RNazc44d3hTcEmIkgSFqWEpspIH5YNcw2ZPZ9r0NED4OVol31OIk
         c1FCoGYVnOwaAdFQel8Vc8L/nWNUWKWpc9TVrPyy5bJpqSeaBu3cL2aDuUSqd23BXnkF
         51MGu3neCN1nafaepdFkzyI4Q4TgVGhAOmxvaLMeEXBCG1ZcSA74MnRquSp8+8auIb6l
         cSay+rcKRs8F96+IAhYtQl/e9pRuw7aZmFwWgT/skm/DBXycpX/cSqdnUslHt0Ko/5Qq
         Y5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677064600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+BI276LAtkDkFkhbO8UzGamxJ+PETieQFjUz5/ET20=;
        b=BkWx0w/C3FUswQ5JZVlX36npOhGypjlN/B4oW55EvvTMo6Sjk5Hm8EPFxm4wYCyW9e
         nRec0C1MqvzHVlv4nwOhZKX0EEBDtT3H7Iar0CVdhXkr18T2W0pxad4BqSqMiaUH0X2p
         db2F08yxsAmu+Z123XyaoYESoqfbk8EzXO7gfpX3LRB9FDGlkgh/Yzlwo6NJ1bU4u7uJ
         YyzgcskKH7ucKgZPiysjfYSKTBCjXklqLEc//EcFYJUvjLxTfdSAsHQEcLmchPNwzftg
         wrVGkz0B9Sq7QApFnrhHaBbIORoDmS4JIPodeedE1CXJGUEBPrfyzFc5A6lcY9LyTv92
         oWZg==
X-Gm-Message-State: AO0yUKViuRjIC6nBITfDeEugtFMm8/T0sSFcP4YLjvbD1XfFRqhAqBGW
        +z3oG3eVOg10XB2o1CJ1DlswqkSR60ZaMsaZX9gfhw==
X-Google-Smtp-Source: AK7set9tTntBeySGs6cc9FTifkpF6RjvarGsSFvPGNeOLLnbEAAFLpi0+jfKdQ9iNmXprDcX7nT/cq4ZTYJTOa49eLY=
X-Received: by 2002:a17:903:110c:b0:19c:92f5:6bb3 with SMTP id
 n12-20020a170903110c00b0019c92f56bb3mr760089plh.28.1677064600194; Wed, 22 Feb
 2023 03:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-9-vincent.guittot@linaro.org> <Y/XlR+wLtn54CkE4@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/XlR+wLtn54CkE4@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Feb 2023 12:16:29 +0100
Message-ID: <CAKfTPtBJD6So-0-S3sgFqTE1HVMypg_S23+uuH6BnGk5atxUKA@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] sched/fair: Add latency list
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 22 Feb 2023 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 03:12:33PM +0100, Vincent Guittot wrote:
>
> > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +
> > +     /* Only latency sensitive entity can be added to the list */
> > +     if (se->latency_offset >= 0)
> > +             return;
> > +
> > +     if (!RB_EMPTY_NODE(&se->latency_node))
> > +             return;
> > +
> > +     /*
> > +      * An execution time less than sysctl_sched_min_granularity means that
> > +      * the entity has been preempted by a higher sched class or an entity
> > +      * with higher latency constraint.
> > +      * Put it back in the list so it gets a chance to run 1st during the
> > +      * next slice.
> > +      */
> > +     if (!(flags & ENQUEUE_WAKEUP)) {
> > +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > +
> > +             if (delta_exec >= sysctl_sched_min_granularity)
> > +                     return;
> > +     }
>
> I'm not a big fan of this dynamic enqueueing condition; it makes it
> rather hard to interpret the below addition to pick_next_entity().
>
> Let me think about this more... at the very least the comment with
> __pick_first_latency() use below needs to be expanded upon if we keep it
> like so.

Only the waking tasks should be added in the latency rb tree so they
can be selected to run 1st (as long as they don't use too much
runtime). But task A can wake up, preempts current task B thanks to
its latency nice , starts to run few usecs but then is immediately
preempted by a RT task C as an example. In this case, we consider that
the task A didn't get a chance to run after its wakeup and we put it
back to the latency rb tree just as if task A has just woken up but
didn't preempted the new current task C.

I have used sysctl_sched_min_granularity has this is min runtime for a
task before being possibly preempted at tick by another cfs task with
a lower vruntime so if it runs less than sysctl_sched_min_granularity
we are sure that it has been preempted by higher prio tasks and it's
not because it used all its runtime compared to others

>
> > +
> > +     rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
> > +}
>
> > @@ -4966,7 +5040,7 @@ static struct sched_entity *
> >  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >  {
> >       struct sched_entity *left = __pick_first_entity(cfs_rq);
> > -     struct sched_entity *se;
> > +     struct sched_entity *latency, *se;
> >
> >       /*
> >        * If curr is set we have to see if its left of the leftmost entity
> > @@ -5008,6 +5082,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >               se = cfs_rq->last;
> >       }
> >
> > +     /* Check for latency sensitive entity waiting for running */
> > +     latency = __pick_first_latency(cfs_rq);
> > +     if (latency && (latency != se) &&
> > +         wakeup_preempt_entity(latency, se) < 1)
> > +             se = latency;
>
> I'm not quite sure why this condition isn't sufficient on it's own.
> After all, if a task does a 'spurious' nanosleep it can get around the
> 'restriction' in __enqueue_latency() without any great penalty to it's
> actual bandwidth consumption.

Yes it until it used all its runtime.

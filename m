Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8923D6A454A
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjB0Ozr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 09:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0Ozq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 09:55:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC62D68
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 06:55:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id bd34so3688672pfb.3
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=efbKjJH0/z14qy23LAnj3qOzaYlgzxY7qzc2uyxfBtM=;
        b=bYs/Mq/rnU7wfxfHK/u5aYqdDlwXoJFuckIsoy5byLynRv5u0ZCZfVzujMy7fUFPEn
         6CljPG9t+qcZzYvOPRKlsbFQ1295zC+HM3kdHK+Aw21LfJUDXrGkKyBvkz1UkCbGkod1
         8QsOAwMSFfKOx2zRxSsxDd+tplnZJu04B5jPoMoM6Y7lBEa8FiuDi6EVm6xcjKxggZ2o
         pBAgwyeu5SqnHbQCR6capDuQlaVhdJXm/4d1NPoS/xdV+oJHajwZk29IyOGFVofhS6bx
         SbeTbNYxtfLIfmMTdZ9nFCUiE3HzxWn5Mp35zaZd14QYE7/MAE72SttksI0yLdisPLoW
         32rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efbKjJH0/z14qy23LAnj3qOzaYlgzxY7qzc2uyxfBtM=;
        b=wIeJaYinl8ft1l/Q19cYUAvtm3NcgqjM4NjDLhA7Xx1UfnL36i2ctsmxDPVnhojaqT
         G0rS4nreiwgD8OQBkNzsgLTT0RbD88NQLxb/YzCasLjcAf2+lB40VQa5ypbsfEVrbbuD
         PljZD1wAos+4uTiWqOBgRr0PsYyy0Et1szmcBWhVvQNms4UIPb/tuDrOHyFEjCw5hvw6
         ZSH+z8OUN0OD5R1+6a5pAGO3MPYLm0obwRh5d6WJi/DtX1SthKN87OJp8DLeXfwHQGoV
         liyXAel9cKF30WhGuV2Jn3SF/gN7rwNHakYzBDegsiBtTyG3+tL/D1NG/ljbGyNuFibY
         rRFQ==
X-Gm-Message-State: AO0yUKXxPfVY1MUfGAVTueUam432LcJygOqTYPL7JCTw5SapIbj7mqer
        ewUFnjv0DpMFCr6aTyDQwY4f0SZbQiS5Fz4gMdZk/w==
X-Google-Smtp-Source: AK7set+8+IFz4k0JhE8UowrEtKZi4ufexRbPO1hsztdc2KHFwYzpPLuYJBmk+bqIyFARsLXmU9cVLlIeyYnM8TqhQjE=
X-Received: by 2002:aa7:848f:0:b0:590:3183:60eb with SMTP id
 u15-20020aa7848f000000b00590318360ebmr5854937pfn.3.1677509726695; Mon, 27 Feb
 2023 06:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-9-vincent.guittot@linaro.org> <Y/XlR+wLtn54CkE4@hirez.programming.kicks-ass.net>
 <CAKfTPtBJD6So-0-S3sgFqTE1HVMypg_S23+uuH6BnGk5atxUKA@mail.gmail.com> <Y/ywN3Sz33gHO3Vj@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/ywN3Sz33gHO3Vj@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Feb 2023 15:55:15 +0100
Message-ID: <CAKfTPtDjSTEaXQ8t8gz-DS_UbMUmN3F2PnbF5m-vJcL-KxaJfQ@mail.gmail.com>
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

On Mon, 27 Feb 2023 at 14:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 22, 2023 at 12:16:29PM +0100, Vincent Guittot wrote:
> > On Wed, 22 Feb 2023 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jan 13, 2023 at 03:12:33PM +0100, Vincent Guittot wrote:
> > >
> > > > +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > > > +{
> > > > +
> > > > +     /* Only latency sensitive entity can be added to the list */
> > > > +     if (se->latency_offset >= 0)
> > > > +             return;
> > > > +
> > > > +     if (!RB_EMPTY_NODE(&se->latency_node))
> > > > +             return;
> > > > +
> > > > +     /*
> > > > +      * An execution time less than sysctl_sched_min_granularity means that
> > > > +      * the entity has been preempted by a higher sched class or an entity
> > > > +      * with higher latency constraint.
> > > > +      * Put it back in the list so it gets a chance to run 1st during the
> > > > +      * next slice.
> > > > +      */
> > > > +     if (!(flags & ENQUEUE_WAKEUP)) {
> > > > +             u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > > > +
> > > > +             if (delta_exec >= sysctl_sched_min_granularity)
> > > > +                     return;
> > > > +     }
> > >
> > > I'm not a big fan of this dynamic enqueueing condition; it makes it
> > > rather hard to interpret the below addition to pick_next_entity().
> > >
> > > Let me think about this more... at the very least the comment with
> > > __pick_first_latency() use below needs to be expanded upon if we keep it
> > > like so.
> >
> > Only the waking tasks should be added in the latency rb tree so they
>
> But that's what I'm saying, you can game this by doing super short
> sleeps every min_gran.

yes, it 's for a time. But i'm not sure this will be always beneficial
at the end because most of the time you will have your full slice
without doing this game

>
> > can be selected to run 1st (as long as they don't use too much
> > runtime). But task A can wake up, preempts current task B thanks to
> > its latency nice , starts to run few usecs but then is immediately
> > preempted by a RT task C as an example. In this case, we consider that
> > the task A didn't get a chance to run after its wakeup and we put it
> > back to the latency rb tree just as if task A has just woken up but
> > didn't preempted the new current task C.
>
> So ideally, and this is where I'm very slow with thinking, that
> wakeup_preempt_entity() condition here:
>
> > > > @@ -5008,6 +5082,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > >               se = cfs_rq->last;
> > > >       }
> > > >
> > > > +     /* Check for latency sensitive entity waiting for running */
> > > > +     latency = __pick_first_latency(cfs_rq);
> > > > +     if (latency && (latency != se) &&
> > > > +         wakeup_preempt_entity(latency, se) < 1)
> > > > +             se = latency;
>
> should be sufficient to provide fair bandwidth usage. The EEVDF paper
> achieves this by selecting the leftmost elegible task, where elegibility
> is dependent on negative lag. Only those tasks that are behind the pack
> are allowed runtime.
>
> Now clearly our min_vruntime is unsuited for that exact scheme, but iirc
> wake_preempt_entity() does not allow for starvation, so we should be
> good, even without that weird condition in __enqueue_latency(), hmm?

If we unconditionally  __enqueue_latency() the task then it can end up
providing more bandwidth to those tasks because it's like having a
larger sleep credit than others.

The original condition in __enqueue_latency() was :
    if (!(flags & ENQUEUE_WAKEUP)) {
        return;
    }

So that task gets a chance to preempt others only at wakeup.
But then, I have seen such tasks being preempted immediately but RT
tasks and as a result lost their latency advantage. Maybe I should be
the condition above and add the weird condition in a separate patch
with dedicated figures

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17669E2B8
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjBUOwo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 09:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjBUOwn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 09:52:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78BA2B2B0;
        Tue, 21 Feb 2023 06:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4gjS0VL1c7Mf2LU1z+Upr3IT88WAxIkZvxMIbrGmLPY=; b=oyOZjduCHNsxUeSdEagS2UwE71
        ext/glsIX86ijI7qxlwzONE6+w1cbGtZyzR1pucDbVilbs+3Lwj/cmdXmQ22UVbOWZdlQb65Abd+4
        VUGfW7gO6uvbDfqMLSqyv7b+yYPKWIsOZkHJuHqGmucs2RLbnsmo9WSwJUX5d5N2BTb4j+gr5iSZz
        Q3PL75Ufn4wb00eQE8paWHDRNO4n3Yw8RuQhKjZwOrzyXsZ5SWOEcRLBldWP4ZaeZ+v6Zq5c7jaaB
        PWun1btc4VXh+WP0ZOySQem8d/EE7t/WFJMG+f6wySepeAV6qhZCEE2fwRVRGLk05eKOm1DjqjCCI
        TRRgSwrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUTzk-00CByA-2t;
        Tue, 21 Feb 2023 14:51:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5897B3003E1;
        Tue, 21 Feb 2023 15:51:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E09B20D8CD90; Tue, 21 Feb 2023 15:51:51 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:51:51 +0100
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
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority
 at wakeup
Message-ID: <Y/Tah7zRSqAH6IRP@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org>
 <Y/TBdB23akBbUjqd@hirez.programming.kicks-ass.net>
 <CAKfTPtAk2A8zPgOfpbN0s4LZv+d7ABB9=5tAEMCbVrf263XtjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAk2A8zPgOfpbN0s4LZv+d7ABB9=5tAEMCbVrf263XtjA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 03:21:54PM +0100, Vincent Guittot wrote:
> On Tue, 21 Feb 2023 at 14:05, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
> > > @@ -6155,6 +6159,35 @@ static int sched_idle_cpu(int cpu)
> > >  }
> > >  #endif
> > >
> > > +static void set_next_buddy(struct sched_entity *se);
> > > +
> > > +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
> > > +{
> > > +     struct sched_entity *next;
> > > +
> > > +     if (se->latency_offset >= 0)
> > > +             return;
> > > +
> > > +     if (cfs->nr_running <= 1)
> > > +             return;
> > > +     /*
> > > +      * When waking from another class, we don't need to check to preempt at
> > > +      * wakeup and don't set next buddy as a candidate for being picked in
> > > +      * priority.
> > > +      * In case of simultaneous wakeup when current is another class, the
> > > +      * latency sensitive tasks lost opportunity to preempt non sensitive
> > > +      * tasks which woke up simultaneously.
> > > +      */
> > > +
> > > +     if (cfs->next)
> > > +             next = cfs->next;
> > > +     else
> > > +             next = __pick_first_entity(cfs);
> > > +
> > > +     if (next && wakeup_preempt_entity(next, se) == 1)
> > > +             set_next_buddy(se);
> > > +}
> > > +
> > >  /*
> > >   * The enqueue_task method is called before nr_running is
> > >   * increased. Here we update the fair scheduling stats and
> > > @@ -6241,14 +6274,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >       if (!task_new)
> > >               update_overutilized_status(rq);
> > >
> > > +     if (rq->curr->sched_class != &fair_sched_class)
> > > +             check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
> > > +
> > >  enqueue_throttle:
> > >       assert_list_leaf_cfs_rq(rq);
> > >
> > >       hrtick_update(rq);
> > >  }
> >
> > Hmm.. This sets a next selection when the task gets enqueued while not
> > running a fair task -- and looses a wakeup preemption opportunity.
> >
> > Should we perhaps also do this for latency_nice == 0?, in any case I
> > think this can be moved to its own patch to avoid doing too much in the
> > one patch. It seems fairly self contained.
> 
> This function is then removed by patch 9 as the additional rb tree
> fixes all cases

Ah, I'm currently 'stuck' at 8.. I'll get there :-)

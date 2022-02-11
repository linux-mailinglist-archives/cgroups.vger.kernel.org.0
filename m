Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9624B1E04
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiBKFzl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 00:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiBKFzl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 00:55:41 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7577102F;
        Thu, 10 Feb 2022 21:55:40 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id o17so11143142ljp.1;
        Thu, 10 Feb 2022 21:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC1KApq7e2Tv1mRrJaVJbGFX4EPFBr5Wq82MxBaNzD0=;
        b=7kLiSQdB+67poBRL/OG48goLLOYPRN4hM0qliz9Rq72HKkp3z1sBsES/sKySUdj0DJ
         /shIxVGD3VlnCzaPHwaN+9ToowVByp9Xu/KaGXIvJWS7XtOkjti8OSh4ajo8Sr6EIUg8
         6iF5o0H/JOlSffKiLmqeGw8TGCCngN+4ElqiE7zQPqtcWSpnHi/ll9Q6U6DlMAE4OY9J
         2zCy2k2IMReMHZMZ9kIqOinhR7V/1uvyqaKfIxOnKB4d726JLn81tJqaXOU8vbfmFfxy
         NvdfH+ENthTDdZzwEweChOjZH8Fexp2Ubxih2CimR4VfSlXUwKFVaPGVSU+dqViCQmqb
         qbGw==
X-Gm-Message-State: AOAM530Buvtn9WtnBpPB6BZ0tfZBhLZnTA8pWBimqxv/zhm8kbkusLYw
        3qMXJ5pgg2j+QHltNe7lygHhqgI8h9u2b08wPBc=
X-Google-Smtp-Source: ABdhPJzbOzw/0zV4IgkYBd1T8G0wbLX3SjAMswL8OAcpI2VPdwnBvfBks/G9AKwLofLucGjL/8xeS4WMPSxifL2SCtI=
X-Received: by 2002:a05:651c:a04:: with SMTP id k4mr74921ljq.180.1644558938779;
 Thu, 10 Feb 2022 21:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com> <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net>
In-Reply-To: <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Feb 2022 21:55:27 -0800
Message-ID: <CAM9d7cgPFLjQyopX04MwG6Leq6DwDJF2q6BxOL_Nw6J2LEZF4g@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 1:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 09, 2022 at 04:32:58PM -0800, Namhyung Kim wrote:
> > On Wed, Feb 9, 2022 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
> > >
> > > > Eventually I'm mostly interested in the contended locks only and I
> > > > want to reduce the overhead in the fast path.  By moving that, it'd be
> > > > easy to track contended locks with timing by using two tracepoints.
> > >
> > > So why not put in two new tracepoints and call it a day?
> > >
> > > Why muck about with all that lockdep stuff just to preserve the name
> > > (and in the process continue to blow up data structures etc..). This
> > > leaves distros in a bind, will they enable this config and provide
> > > tracepoints while bloating the data structures and destroying things
> > > like lockref (which relies on sizeof(spinlock_t)), or not provide this
> > > at all.
> >
> > If it's only lockref, is it possible to change it to use arch_spinlock_t
> > so that it can remain in 4 bytes?  It'd be really nice if we can keep
> > spin lock size, but it'd be easier to carry the name with it for
> > analysis IMHO.
>
> It's just vile and disgusting to blow up the lock size for convenience
> like this.
>
> And no, there's more of that around. A lot of effort has been spend to
> make sure spinlocks are 32bit and we're not going to give that up for
> something as daft as this.
>
> Just think harder on the analysis side. Like said; I'm thinking the
> caller IP should be good enough most of the time.

Ok, I'll go in this direction then.

So you are ok with adding two new tracepoints, even if they are
similar to what we already have in lockdep/lock_stat, right?

Thanks,
Namhyung

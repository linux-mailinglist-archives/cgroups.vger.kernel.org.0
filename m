Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E254B1E0A
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 06:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiBKF55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 00:57:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiBKF55 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 00:57:57 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FBBB98;
        Thu, 10 Feb 2022 21:57:56 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id i34so14570177lfv.2;
        Thu, 10 Feb 2022 21:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHj2jwcJGwmoQOFICOnj7VYD0ZfKr1aHs76v7p1GNas=;
        b=uwhFFmZaoJ0Cr/wimNIHZZ6x4a/+thc3/aS8+HS65kdqj1dm1UHjNKzHcxEQAuTk0z
         phMs+5h3zEdSmiuDODWMVs2PIaEgINGUz1lsxLjf3qd56szk8QAUu9oMCTJD5yogmJhM
         jF77iSL6eB+659tby+T2+CKs3EZ2iH1iTMQ0pAoaKUsdiKnG1WN6Z6CRaJwLE0LPKIAS
         rEINvMt2KQAlNLorAaTv4JVBIAGjGksB+vZ3jk2yr3sHlujQjBm2f5sspgdjakqd4inv
         AD+4pRRB1WvR6AKuT8QpapzOJZft6MiAF4ChmUR06WNHPtRei8coh5IGxO3aZgflOOgS
         jbYQ==
X-Gm-Message-State: AOAM531bK8J1RQZyOuJcdBKg5JKSd7LKo1TuF+K/FSjRIrI5UhabkRJh
        esU+YmVcImVZVtk+mSQhqh7azqW7cd+tx9qx6IAZ8WSa
X-Google-Smtp-Source: ABdhPJy2dlN3fWiUhcT5boKFhlYkHBnGFHgB3K+4K4i+akzobdalchyFHlfYniU0eYARcVvOesbduvyh2ZcH9Ept6BA=
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr131920lfe.47.1644559074965;
 Thu, 10 Feb 2022 21:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
 <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net> <20220210191404.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <52de2e14-33d9-bdda-4b37-3e72ae9954c7@redhat.com> <20220210201058.GP4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220210201058.GP4285@paulmck-ThinkPad-P17-Gen-1>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Feb 2022 21:57:43 -0800
Message-ID: <CAM9d7cj-PhX16jKu8DT=tfVf=OfH78xYYaMB8BVk-Hj_eoR4kQ@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
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

Hi Paul,

On Thu, Feb 10, 2022 at 12:10 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Feb 10, 2022 at 02:27:11PM -0500, Waiman Long wrote:
> > On 2/10/22 14:14, Paul E. McKenney wrote:
> > > On Thu, Feb 10, 2022 at 10:13:53AM +0100, Peter Zijlstra wrote:
> > > > On Wed, Feb 09, 2022 at 04:32:58PM -0800, Namhyung Kim wrote:
> > > > > On Wed, Feb 9, 2022 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
> > > > > >
> > > > > > > Eventually I'm mostly interested in the contended locks only and I
> > > > > > > want to reduce the overhead in the fast path.  By moving that, it'd be
> > > > > > > easy to track contended locks with timing by using two tracepoints.
> > > > > > So why not put in two new tracepoints and call it a day?
> > > > > >
> > > > > > Why muck about with all that lockdep stuff just to preserve the name
> > > > > > (and in the process continue to blow up data structures etc..). This
> > > > > > leaves distros in a bind, will they enable this config and provide
> > > > > > tracepoints while bloating the data structures and destroying things
> > > > > > like lockref (which relies on sizeof(spinlock_t)), or not provide this
> > > > > > at all.
> > > > > If it's only lockref, is it possible to change it to use arch_spinlock_t
> > > > > so that it can remain in 4 bytes?  It'd be really nice if we can keep
> > > > > spin lock size, but it'd be easier to carry the name with it for
> > > > > analysis IMHO.
> > > > It's just vile and disgusting to blow up the lock size for convenience
> > > > like this.
> > > >
> > > > And no, there's more of that around. A lot of effort has been spend to
> > > > make sure spinlocks are 32bit and we're not going to give that up for
> > > > something as daft as this.
> > > >
> > > > Just think harder on the analysis side. Like said; I'm thinking the
> > > > caller IP should be good enough most of the time.
> > >
> > > Another option is to keep any additional storage in a separate data
> > > structure keyed off of lock address, lockdep class, or whatever.
> > >
> > > Whether or not this is a -good- option, well, who knows?  ;-)
> >
> > I have suggested that too. Unfortunately, I was replying to an email with
> > your wrong email address. So you might not have received it.
>
> Plus I was too lazy to go look at lore.  ;-)

Sorry for the noise about the email address in the first place.
It has been so long since the last time I sent you a patch..

Thanks,
Namhyung

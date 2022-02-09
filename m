Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD74AFD82
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiBITbt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 14:31:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbiBITbf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 14:31:35 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B9C1DC06A;
        Wed,  9 Feb 2022 11:22:57 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id t14so4842705ljh.8;
        Wed, 09 Feb 2022 11:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAb9RMF5rdP3oF08yRzn8MffJjQ5kNb8IB5u5y/hypk=;
        b=1MyEJIKn09+g71ZGo4sfbjB6JpK4pIgqZv140B6IXhwCbq87UNojDO+Z4kzQExxmCl
         lPVaxagvpIkvOihaA6lfkZG8dRJ0q4NWO98Ox7WehBxX4fXR71PaO3vLUXneWIT23MkM
         yKzhQYWWRwRBBfM1ttRzzn1bbJRQ5yrR/R6lJs0xIJyQHsdJxqSc/9LOAeIBqjDvaBMs
         Y1qGCcdIbGof/eIJ/gK03TgSP1LZBUjF0iY135Ic9XodIsoLsHhg1TtDZWiMI74NryOP
         L8KUDPYF5n6aYmvHlpy1ZPii2hQ4Ulk5zhRYhQ7Z5L/MlvTX6nrCGtCcEXlFg1a0cCNe
         ZhHA==
X-Gm-Message-State: AOAM532H1fR2XRsXn+PrPcWmvfr3Mhxti0GS5WSfekNQkvgOaBzwTsWb
        iW+YOsl2iX9VbWUrBlIJvtCgyv+pwQHJWBxPGVI=
X-Google-Smtp-Source: ABdhPJw08QD4wUSfZkYC8eoOu9YPXO1KD3DoKCorkCNdm3c9GLfZqlvWEz+RohSDhEAzIwcPChf/Tq1QQHAWfxCujNM=
X-Received: by 2002:a2e:5352:: with SMTP id t18mr2459533ljd.241.1644434575676;
 Wed, 09 Feb 2022 11:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com> <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com>
In-Reply-To: <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 11:22:44 -0800
Message-ID: <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     Waiman Long <longman@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
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

Hello,

On Wed, Feb 9, 2022 at 11:02 AM Waiman Long <longman@redhat.com> wrote:
>
> On 2/9/22 13:29, Mathieu Desnoyers wrote:
> > ----- On Feb 9, 2022, at 1:19 PM, Waiman Long longman@redhat.com wrote:
> >
> >> On 2/9/22 04:09, Peter Zijlstra wrote:
> >>> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
> >>>
> >>>> Eventually I'm mostly interested in the contended locks only and I
> >>>> want to reduce the overhead in the fast path.  By moving that, it'd be
> >>>> easy to track contended locks with timing by using two tracepoints.
> >>> So why not put in two new tracepoints and call it a day?
> >>>
> >>> Why muck about with all that lockdep stuff just to preserve the name
> >>> (and in the process continue to blow up data structures etc..). This
> >>> leaves distros in a bind, will they enable this config and provide
> >>> tracepoints while bloating the data structures and destroying things
> >>> like lockref (which relies on sizeof(spinlock_t)), or not provide this
> >>> at all.
> >>>
> >>> Yes, the name is convenient, but it's just not worth it IMO. It makes
> >>> the whole proposition too much of a trade-off.
> >>>
> >>> Would it not be possible to reconstruct enough useful information from
> >>> the lock callsite?
> >>>
> >> I second that as I don't want to see the size of a spinlock exceeds 4
> >> bytes in a production system.
> >>
> >> Instead of storing additional information (e.g. lock name) directly into
> >> the lock itself. Maybe we can store it elsewhere and use the lock
> >> address as the key to locate it in a hash table. We can certainly extend
> >> the various lock init functions to do that. It will be trickier for
> >> statically initialized locks, but we can probably find a way to do that too.
> > If we go down that route, it would be nice if we can support a few different
> > use-cases for various tracers out there.
> >
> > One use-case (a) requires the ability to query the lock name based on its address as key.
> > For this a hash table is a good fit. This would allow tracers like ftrace to
> > output lock names in its human-readable output which is formatted within the kernel.
> >
> > Another use-case (b) is to be able to "dump" the lock { name, address } tuples
> > into the trace stream (we call this statedump events in lttng), and do the
> > translation from address to name at post-processing. This simply requires
> > that this information is available for iteration for both the core kernel
> > and module locks, so the tracer can dump this information on trace start
> > and module load.
> >
> > Use-case (b) is very similar to what is done for the kernel tracepoints. Based
> > on this, implementing the init code that iterates on those sections and populates
> > a hash table for use-case (a) should be easy enough.
>
> Yes, that are good use cases for this type of functionality. I do need
> to think about how to do it for statically initialized lock first.

Thank you all for the review and good suggestions.

I'm also concerning dynamic allocated locks in a data structure.
If we keep the info in a hash table, we should delete it when the
lock is gone.  I'm not sure we have a good place to hook it up all.

Thanks,
Namhyung

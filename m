Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2109C4B0944
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiBJJO0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 04:14:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbiBJJOZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 04:14:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC9F1C;
        Thu, 10 Feb 2022 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WhfsZGHRyj3BiYrePm2T7nfqolEn4234PiR7dKjI6oY=; b=q4NJZI6DxE2Kvi7IDsQkKmgYd+
        CdvNqs4GIuOeJFL07OBuo6jwtRivpLI81AjuWAK6/X5/bATwaztFCccoCMOKOgc03i6EibzJI3zex
        jiDMkf3RS+yh8mPUne5xny6D2Hs+o1qHbOe3Pv8xVEJTTnWkR82+c2sVrEy5oTt+Ov89Jtd6yla1l
        JQmlCNuH0gck2TW8MO0xMhXcUQEkiPSaCSjD/eLqgX5JiM+NGur6WVyM/z3L/l2TnzwosdxIuUC20
        3dBDXEmpxjcWUKkFe36yEwmqw0YpwEFQHpAS0mFAAPeVksb0F+hagIQzkB9qTmDOw9En54KjuiBnA
        zuhFipnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI5WW-008f0W-PO; Thu, 10 Feb 2022 09:13:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33B2F3002DB;
        Thu, 10 Feb 2022 10:13:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04AD2201D84A1; Thu, 10 Feb 2022 10:13:54 +0100 (CET)
Date:   Thu, 10 Feb 2022 10:13:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Message-ID: <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 09, 2022 at 04:32:58PM -0800, Namhyung Kim wrote:
> On Wed, Feb 9, 2022 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
> >
> > > Eventually I'm mostly interested in the contended locks only and I
> > > want to reduce the overhead in the fast path.  By moving that, it'd be
> > > easy to track contended locks with timing by using two tracepoints.
> >
> > So why not put in two new tracepoints and call it a day?
> >
> > Why muck about with all that lockdep stuff just to preserve the name
> > (and in the process continue to blow up data structures etc..). This
> > leaves distros in a bind, will they enable this config and provide
> > tracepoints while bloating the data structures and destroying things
> > like lockref (which relies on sizeof(spinlock_t)), or not provide this
> > at all.
> 
> If it's only lockref, is it possible to change it to use arch_spinlock_t
> so that it can remain in 4 bytes?  It'd be really nice if we can keep
> spin lock size, but it'd be easier to carry the name with it for
> analysis IMHO.

It's just vile and disgusting to blow up the lock size for convenience
like this.

And no, there's more of that around. A lot of effort has been spend to
make sure spinlocks are 32bit and we're not going to give that up for
something as daft as this.

Just think harder on the analysis side. Like said; I'm thinking the
caller IP should be good enough most of the time.

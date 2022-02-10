Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5984E4B16C4
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiBJULC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 15:11:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJULB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 15:11:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE42735;
        Thu, 10 Feb 2022 12:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F912B8272A;
        Thu, 10 Feb 2022 20:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD1C004E1;
        Thu, 10 Feb 2022 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644523858;
        bh=iLVxmxOrhgeAZwTkFuG1YJotZgqgklwTkad+usc+SbM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o56gSkY6KjsTqaNLucwpbwSfiS6lwFJGp+betDu9X8aq4l5khh7ZxFWlsuOatT/SU
         kOGdUu/H0ffGyVffjwXC/ybeD43ppXkNTvDupxItbHL7c25YO9JTjYo5liSOPlcZC2
         S1l9sx6T5hVnihTP/6rf8lhrpqqKkZFEIUwl5KM59cYjlYCu/0Yr+pjZ3xGxIECloB
         CApZ1rDMi8muJMOR27g2MNZAWOGq2UPWWAP3ejtxogM0Zp3M0cGAvHvgqTg5t4J52t
         BAlD+tYaAE1gb9pplHq+kCcw19EB/b00N+HnvtaBqE+Exhnq3oBWfkbhFmD3qaQRE5
         TDTWUZVxVnWFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B70E5C0439; Thu, 10 Feb 2022 12:10:58 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:10:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Message-ID: <20220210201058.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
 <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net>
 <20220210191404.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <52de2e14-33d9-bdda-4b37-3e72ae9954c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52de2e14-33d9-bdda-4b37-3e72ae9954c7@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 02:27:11PM -0500, Waiman Long wrote:
> On 2/10/22 14:14, Paul E. McKenney wrote:
> > On Thu, Feb 10, 2022 at 10:13:53AM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 09, 2022 at 04:32:58PM -0800, Namhyung Kim wrote:
> > > > On Wed, Feb 9, 2022 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
> > > > > 
> > > > > > Eventually I'm mostly interested in the contended locks only and I
> > > > > > want to reduce the overhead in the fast path.  By moving that, it'd be
> > > > > > easy to track contended locks with timing by using two tracepoints.
> > > > > So why not put in two new tracepoints and call it a day?
> > > > > 
> > > > > Why muck about with all that lockdep stuff just to preserve the name
> > > > > (and in the process continue to blow up data structures etc..). This
> > > > > leaves distros in a bind, will they enable this config and provide
> > > > > tracepoints while bloating the data structures and destroying things
> > > > > like lockref (which relies on sizeof(spinlock_t)), or not provide this
> > > > > at all.
> > > > If it's only lockref, is it possible to change it to use arch_spinlock_t
> > > > so that it can remain in 4 bytes?  It'd be really nice if we can keep
> > > > spin lock size, but it'd be easier to carry the name with it for
> > > > analysis IMHO.
> > > It's just vile and disgusting to blow up the lock size for convenience
> > > like this.
> > > 
> > > And no, there's more of that around. A lot of effort has been spend to
> > > make sure spinlocks are 32bit and we're not going to give that up for
> > > something as daft as this.
> > > 
> > > Just think harder on the analysis side. Like said; I'm thinking the
> > > caller IP should be good enough most of the time.
> > 
> > Another option is to keep any additional storage in a separate data
> > structure keyed off of lock address, lockdep class, or whatever.
> > 
> > Whether or not this is a -good- option, well, who knows?  ;-)
> 
> I have suggested that too. Unfortunately, I was replying to an email with
> your wrong email address. So you might not have received it.

Plus I was too lazy to go look at lore.  ;-)

For whatever it is worth, we did something similar in DYNIX/ptx, whose
spinlocks were limited to a single byte.  But it does have its drawbacks.

							Thanx, Paul

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA644AEDAF
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiBIJKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 04:10:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiBIJKA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 04:10:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C7E078229;
        Wed,  9 Feb 2022 01:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kNBxEECZ8nYVRQBlRi4s4bPsYk+6wGvc+UHQLe+LfQY=; b=FuT01ILcnQE1hlwV0N6QoRzje7
        8leIgTUsGHbhfy7cNPjN8ZrjHcSG0wypOKtgyb8t04GcdHB5bH2yXofjaCs8wpl1CIqqOkec3R9OV
        nApYAVlzrV8ZfypyHa4mIELkzUQhBcEibVe6rjqueMf/NegoUT6rvZNNsoc4Uw2YqsFP9t1UTNqIf
        jNC72U1XwX8JGYxfA0nQlHqSjCcVfzkGjPBeAtSDlLt6otVC5r0jjKiMiAMeC9xmjVZ1sMuKSSBys
        rCFVdCTkXxb8dN7UTtpmiYJWVdWQaduq6Qanmd7JpqkCzBgIpJKnbvw5fQS2u7k6VjPF4p+ScGV/Y
        cDMFRHqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiyL-007ELN-4I; Wed, 09 Feb 2022 09:09:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7873986226; Wed,  9 Feb 2022 10:09:08 +0100 (CET)
Date:   Wed, 9 Feb 2022 10:09:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, cgroups@vger.kernel.org,
        linux-btrfs@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Message-ID: <20220209090908.GK23216@worktop.programming.kicks-ass.net>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:

> Eventually I'm mostly interested in the contended locks only and I
> want to reduce the overhead in the fast path.  By moving that, it'd be
> easy to track contended locks with timing by using two tracepoints.

So why not put in two new tracepoints and call it a day?

Why muck about with all that lockdep stuff just to preserve the name
(and in the process continue to blow up data structures etc..). This
leaves distros in a bind, will they enable this config and provide
tracepoints while bloating the data structures and destroying things
like lockref (which relies on sizeof(spinlock_t)), or not provide this
at all.

Yes, the name is convenient, but it's just not worth it IMO. It makes
the whole proposition too much of a trade-off.

Would it not be possible to reconstruct enough useful information from
the lock callsite?

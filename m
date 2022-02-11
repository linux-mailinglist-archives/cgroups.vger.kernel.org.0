Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE64B238F
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349262AbiBKKkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 05:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349279AbiBKKkZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 05:40:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0921117E;
        Fri, 11 Feb 2022 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OF/IgiH+v6IN/Pzp4IQTqAUh7fLzy/AMqRrw5uRs6QM=; b=LbJP76jKebDs3mjRSiss+VrY7f
        dyaOfWlffhDUHwB5AhCZaYYvYgwPKcloLfHaKYcpTn89ucITWQacDwWZdCUpXsJ1W4aPGDu1CoKWg
        Rfzrrf4xgw1gmNI7TdQWjDRc8mKeLyhdnOKMRPCY5pRyEN3Wib9vTBUNOwdD95nCv5VqFC6/0V7FQ
        Haq8I+dR+Ow1pT7b6qWtQv5lKaUKPND5wFWM1sqdcOOios9N3Wn/zaVMAzaStBFXvrfKDhY+htVJN
        9uOg2NJnn422jyJBwlc67KqBfJSE0Vw19ZHFnLq5WuwjQtRMOFXBa8cNi2XxrR2RAgKJ34Y8iRUb+
        Lw5VTLVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nITKd-00AJv5-4D; Fri, 11 Feb 2022 10:39:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12A749853C7; Fri, 11 Feb 2022 11:39:14 +0100 (CET)
Date:   Fri, 11 Feb 2022 11:39:13 +0100
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
Message-ID: <20220211103913.GR23216@worktop.programming.kicks-ass.net>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
 <YgTXUQ9CBoo3+A+c@hirez.programming.kicks-ass.net>
 <CAM9d7cgPFLjQyopX04MwG6Leq6DwDJF2q6BxOL_Nw6J2LEZF4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgPFLjQyopX04MwG6Leq6DwDJF2q6BxOL_Nw6J2LEZF4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 09:55:27PM -0800, Namhyung Kim wrote:

> So you are ok with adding two new tracepoints, even if they are
> similar to what we already have in lockdep/lock_stat, right?

Yeah, I don't think adding tracepoints to the slowpaths of the various
locks should be a problem.

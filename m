Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F308A502B
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfIBHrd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 03:47:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfIBHrc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 03:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fYldPtPtIGj2tv2z5tJVF8kAtfN8pBR+/NHizVHdMpM=; b=ekpdxU+knZnMh5434px+hOBhu
        xgI39mMze/viBKrF5jrQZH+mkLMoohlXfDe0/u13CYG3hXiDHMPeOz4UjmmXWLN5Ti389lpMRFkio
        yrGbsDy9anQTvaAS0K4RbukmDAoNI6BYkMgFvE3VGY9tRhA0sthaWBVk961VP2RBni2fx0qNAgqMF
        3AA/0QAs2C3g+aq91j2RodonXMsrSDZSj1si2zYbOZpEoo/lsgsbybwYU/6bE/h6btT7WEEr1vnUk
        /l23WCvfHXgt4MCUhpIOzfoy9gF/w75iELWGRYhcG+r7Z6Xrw3+sGxhCNzUFerRwIK17qOXc0MBOH
        0hCOQ2u9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4h3e-0004LW-NT; Mon, 02 Sep 2019 07:47:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E523301A76;
        Mon,  2 Sep 2019 09:46:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEA3F29B7E7A5; Mon,  2 Sep 2019 09:47:24 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:47:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v14 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190902074724.GP2369@hirez.programming.kicks-ass.net>
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
 <20190822132811.31294-2-patrick.bellasi@arm.com>
 <20190830094505.GA2369@hirez.programming.kicks-ass.net>
 <87zhjnnqz2.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhjnnqz2.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 02, 2019 at 07:38:53AM +0100, Patrick Bellasi wrote:
> 
> On Fri, Aug 30, 2019 at 09:45:05 +0000, Peter Zijlstra wrote...
> 
> > On Thu, Aug 22, 2019 at 02:28:06PM +0100, Patrick Bellasi wrote:
> >> +#define _POW10(exp) ((unsigned int)1e##exp)
> >> +#define POW10(exp) _POW10(exp)
> >
> > What is this magic? You're forcing a float literal into an integer.
> > Surely that deserves a comment!
> 
> Yes, I'm introducing the two constants:
>   UCLAMP_PERCENT_SHIFT,
>   UCLAMP_PERCENT_SCALE
> similar to what we have for CAPACITY. Moreover, I need both 100*100 (for
> the scale) and 100 further down in the code for the: 

Ooh, right you are. I clearly was in need of weekend. Somehow I read
that code as if you were forcing the float representation into an
integer, which is not what you do.

> 	percent = div_u64_rem(percent, POW10(UCLAMP_PERCENT_SHIFT), &rem);
> 
> used in cpu_uclamp_print().
> 
> That's why adding a compile time support to compute a 10^N is useful.
> 
> C provides the "1eN" literal, I just convert it to integer and to do
> that at compile time I need a two level macros.
> 
> What if I add this comment just above the macro definitions:
> 
> /*
>  * Integer 10^N with a given N exponent by casting to integer the literal "1eN"
>  * C expression. Since there is no way to convert a macro argument (N) into a
>  * character constant, use two levels of macros.
>  */
> 
> is this clear enough?

Yeah, let me go add that.

> >
> >> +struct uclamp_request {
> >> +#define UCLAMP_PERCENT_SHIFT	2
> >> +#define UCLAMP_PERCENT_SCALE	(100 * POW10(UCLAMP_PERCENT_SHIFT))
> >> +	s64 percent;
> >> +	u64 util;
> >> +	int ret;
> >> +};
> >> +
> >> +static inline struct uclamp_request
> >> +capacity_from_percent(char *buf)
> >> +{
> >> +	struct uclamp_request req = {
> >> +		.percent = UCLAMP_PERCENT_SCALE,
> >> +		.util = SCHED_CAPACITY_SCALE,
> >> +		.ret = 0,
> >> +	};
> >> +
> >> +	buf = strim(buf);
> >> +	if (strncmp("max", buf, 4)) {
> >
> > That is either a bug, and you meant to write: strncmp(buf, "max", 3),
> > or it is not, and then you could've written: strcmp(buf, "max")
> 
> I don't think it's a bug.
> 
> The usage of 4 is intentional, to force a '\0' check while using
> strncmp(). Otherwise, strncmp(buf, "max", 3) would accept also strings
> starting by "max", which we don't want.

Right; I figured.

> > But as written it doesn't make sense.
> 
> The code is safe but I agree that strcmp() does just the same and it
> does not generate confusion. That's actually a pretty good example
> on how it's not always better to use strncmp() instead of strcmp().

OK, I made it strcmp(), because that is what I figured was the intended
semantics.

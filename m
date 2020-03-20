Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7451618CCFE
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2020 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCTL2d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Mar 2020 07:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:47774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgCTL2d (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 20 Mar 2020 07:28:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 882ED31B;
        Fri, 20 Mar 2020 04:28:30 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D863F85E;
        Fri, 20 Mar 2020 04:28:28 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:28:26 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
Message-ID: <20200320112825.gn5glqsy6uebxp3w@e107158-lin.cambridge.arm.com>
References: <20200311010113.136465-1-joshdon@google.com>
 <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
 <20200317192401.GE20713@hirez.programming.kicks-ass.net>
 <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
 <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
 <CABk29NvvJCYyEnEkDt4JgZacf6XLd+0wxx_BNGnX8oZcrBp4EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABk29NvvJCYyEnEkDt4JgZacf6XLd+0wxx_BNGnX8oZcrBp4EA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/19/20 15:45, Josh Don wrote:
> On Wed, Mar 18, 2020 at 4:35 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 03/17/20 14:35, Josh Don wrote:
> > > On Wed, Mar 11, 2020 at 7:05 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > It might be a good idea to split the API from the user too.
> > >
> > > Not sure what you mean by this, could you clarify?
> >
> > I meant it'd be a good idea to split the cpumask API into its own patch and
> > have a separate patch for the user in sched/core.c. But that was a small nit.
> > If the user (in sched/core.c) somehow introduces a regression, reverting it
> > separately should be trivial.
> >
> > Thanks
> 
> Ah, yes I agree that sounds like a good idea, I can do that.
> 
> Peter, any other nit before I re-send?

AFAICT it was already picked up, so no need to resend to fix the nits from my
side.

--
Qais Yousef

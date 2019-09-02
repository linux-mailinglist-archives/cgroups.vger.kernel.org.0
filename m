Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16EA5009
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfIBHiy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 03:38:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42268 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBHiy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 03:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=czLm9+6XeObljoXUlErx8mAKQvTAxkpX8YXKtxnvR4g=; b=UQykYbAyrrel/FfPuS6bPE+5w
        MBmQ3B4whQzp+6X6/IjDTCyaNfY6g6oYXjxje/EICxmgJrmUETodNdZ2yhi00ffprnn6MrVDdL8LV
        RyddXIHAQU4AMu1E/qJjB/BwhEyX+sOJc7N+88IML2MdGM/QvT7weXDugntF0SFaDiv7C5YTe2mEc
        Hl+edJpyJU+brRrkfIDEkoF9Kg2BL7YZdExZOmbQPDE5FCoHtNhMC9EzhScErMWcR2oWTkj2wB0KJ
        uLKTD2rl5Pi4jV5/ulydOP1bJ480eK7uy1k6r9ABehMfydGQj2iJmIlZIY+/XSYkWOf9XzIoMeLMi
        jC8lQl3yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4gv8-0004iF-Mo; Mon, 02 Sep 2019 07:38:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 070F330116F;
        Mon,  2 Sep 2019 09:38:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9574829B7E7A5; Mon,  2 Sep 2019 09:38:36 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:38:36 +0200
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
Subject: Re: [PATCH v14 5/6] sched/core: uclamp: Update CPU's refcount on
 TG's clamp changes
Message-ID: <20190902073836.GO2369@hirez.programming.kicks-ass.net>
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
 <20190822132811.31294-6-patrick.bellasi@arm.com>
 <20190830094834.GB2369@hirez.programming.kicks-ass.net>
 <87woernqnb.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woernqnb.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 02, 2019 at 07:44:40AM +0100, Patrick Bellasi wrote:
> On Fri, Aug 30, 2019 at 09:48:34 +0000, Peter Zijlstra wrote...
> > On Thu, Aug 22, 2019 at 02:28:10PM +0100, Patrick Bellasi wrote:

> >> +	rq = task_rq_lock(p, &rf);
> >
> > Since modifying cgroup parameters is priv only, this should be OK I
> > suppose. Priv can already DoS the system anyway.
> 
> Are you referring to the possibility to DoS the scheduler by keep
> writing cgroup attributes?

Yep.

> Because, in that case I think cgroup attributes could be written also by
> non priv users. It all depends on how they are mounted and permissions
> are set. Isn't it?
> 
> Anyway, I'm not sure we can fix that here... and in principle we could
> have that DoS by setting CPUs affinities, which is user exposed.
> Isn't it?

Only for a single task; by using the cgroup thing we have that in-kernel
iteration of tasks.

The thing I worry about is bouncing rq->lock around the system; but
yeah, I suppose a normal user could achieve something similar with
enough tasks.

> >> +	/*
> >> +	 * Setting the clamp bucket is serialized by task_rq_lock().
> >> +	 * If the task is not yet RUNNABLE and its task_struct is not
> >> +	 * affecting a valid clamp bucket, the next time it's enqueued,
> >> +	 * it will already see the updated clamp bucket value.
> >> +	 */
> >> +	if (!p->uclamp[clamp_id].active)
> >> +		goto done;
> >> +
> >> +	uclamp_rq_dec_id(rq, p, clamp_id);
> >> +	uclamp_rq_inc_id(rq, p, clamp_id);
> >> +
> >> +done:
> >
> > I'm thinking that:
> >
> > 	if (p->uclamp[clamp_id].active) {
> > 		uclamp_rq_dec_id(rq, p, clamp_id);
> > 		uclamp_rq_inc_id(rq, p, clamp_id);
> > 	}
> >
> > was too obvious? ;-)
> 
> Yep, right... I think there was some more code in prev versions but I
> forgot to get rid of that "goto" pattern after some change.

OK, already fixed that.

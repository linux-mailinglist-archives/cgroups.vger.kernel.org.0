Return-Path: <cgroups+bounces-12979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D25B0D02FB6
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 14:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA899316B03B
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E423D3324;
	Thu,  8 Jan 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNkbDbQW"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE81338592;
	Thu,  8 Jan 2026 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872539; cv=none; b=udr3EQ4yQdnl20ORWSuIqbUmJzQ75yeS0W4466tUVd0wfpW0ecswDPAQbAPelIKYlDtKQlqRb3EEIDO7fWqG0QPoYVK80SS1ThWPJoP6CzUU/ooLS8FH1gg2vEmv5icuwkBWiq4sAj9JSw9J9DPcIXnpykESlyCD7qOj4VUyKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872539; c=relaxed/simple;
	bh=ttupqEGkMEcEuPViZy3HWzygBgTOKjkQ58B9GvzZqPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6jZF41Fnu1HmjDIKnYRVaDrgfE7d5YrsZNsXwipF9a7qS1pNMSpP/npEwY2UiKigJC3bo2l1A5Uzy+emydD1Dy+3g6x/o1s/iUuRByUidFrEYBa76xtfvoLbAOJcNlBXw05TQby+uehJVqbjYaDH4Lff4u0MApeZ1+AjmToNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DNkbDbQW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=auld4VZzwjVZ31uDi1pYt/0YjX5oiUGQGK3GzcaTNUs=; b=DNkbDbQWcWwr1ypqVVlaMKGHEK
	zB2ik2MFJ67Fd97QEp38RHTpH+a3EJRrUWQR2vOT/NIf3/6WdEJnn9743FkjVsWh3YM/tZanTwtb/
	AMIKbzaTVmKCnjnEE2icYVImYDXEld1WKF2gx1IkDU3aleDda9qUuBBwxsrUpIp+qvcjgttsrYTIK
	aJ60s2W+IL20lO4h7NVdMjuvEcStMLq/DpOQS5l7hUVc54SaTJuozrRlzseICl7c51mwlEl3udKtd
	+AAdD4W8CVKGdbGZ2I1nsjIzTr6gk24/lH+GV84qEBg7IBgc8LESR3w9sdjhlAagl0s2X0yVEAX/b
	hZNXEmlw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdoP0-0000000EsPO-0AbM;
	Thu, 08 Jan 2026 11:42:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42184300E8E; Thu, 08 Jan 2026 12:42:05 +0100 (CET)
Date: Thu, 8 Jan 2026 12:42:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCHv2 0/2] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
Message-ID: <20260108114205.GJ272712@noisy.programming.kicks-ass.net>
References: <20251119095525.12019-3-piliu@redhat.com>
 <20251125032630.8746-1-piliu@redhat.com>
 <aSVlX5Rk1y2FuThP@jlelli-thinkpadt14gen4.remote.csb>
 <9deefb73-fb3a-4bb0-a808-88c478ea3240@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9deefb73-fb3a-4bb0-a808-88c478ea3240@redhat.com>

On Wed, Jan 07, 2026 at 02:57:00PM -0500, Waiman Long wrote:
> 
> On 11/25/25 3:14 AM, Juri Lelli wrote:
> > Hi,
> > 
> > On 25/11/25 11:26, Pingfan Liu wrote:
> > > These two patches address the issue reported by Juri [1] (thanks!).
> > > 
> > > The first removes an unnecessary comment, the second is the actual fix.
> > > 
> > > @Tejun, while these could be squashed together, I kept them separate to
> > > maintain the one-patch-one-purpose rule. let me know if you'd like me to
> > > resend these in a different format, or feel free to adjust as needed.
> > > 
> > > [1]: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
> > > 
> > > Pingfan Liu (2):
> > >    sched/deadline: Remove unnecessary comment in
> > >      dl_add_task_root_domain()
> > >    sched/deadline: Fix potential race in dl_add_task_root_domain()
> > > 
> > >   kernel/sched/deadline.c | 12 ++----------
> > >   1 file changed, 2 insertions(+), 10 deletions(-)
> > For both
> > 
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Peter,
> 
> Are these 2 patches eligible to be merged into the the scheduler branch of
> the tip tree? These are bug fixes to the deadline scheduler code.

Thanks for the ping -- just to double check, I need to take the v2
patches, that are posted inside the v7 thread?

I mean; I absolutely detest posting new series in the same thread as an
older series and then you go and do non-linear versioning just to make
it absolutely impossible to tell what's what. :-(


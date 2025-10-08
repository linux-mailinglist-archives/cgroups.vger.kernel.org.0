Return-Path: <cgroups+bounces-10601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58ABC4402
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7E351511
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA42EBBB7;
	Wed,  8 Oct 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Z0AtejY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2671253944;
	Wed,  8 Oct 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918021; cv=none; b=IepCfmv6HNFeziQWi39tHDdlX+FMnHws3y2A2A5xlKxIcRf+yslrg9pdawqqguCh6CIIfzXM6wHWGt08ikzo1jXtkgh6iRB+Nw5lb3aIClsiW7+j0pQNskLkKu5ek/wiVVLUK4CEPz08svWQvPjuZGev0Qov/xRzNdn0oXk0klA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918021; c=relaxed/simple;
	bh=KQXZN/ofW0OKkLGaG3YnpairLb8pItAMJg4NG+XRaQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWFDa3WUaTw4NHfYOVMbkTrV1OJdYecT05OrSuBt+QlaKYDd6bMPGUUWroPgzNDocCvQw3Vhjm4GOiXxMgRWSzbs/Colu0XaBTnaEhRAkSYHVsf3/X69nPbPE30PGgNz5Ytl6GOmJXZeoXMInM7RZ7QeBjCfXqJMu8nSULTEI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Z0AtejY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2106C4CEF4;
	Wed,  8 Oct 2025 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759918019;
	bh=KQXZN/ofW0OKkLGaG3YnpairLb8pItAMJg4NG+XRaQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Z0AtejYv/gO11P+YePtAAXSpl9OfNpwjNrkG/8IlcEcWlOVaSfWRtQXkgVp+a6pV
	 Ycb0mON+I88I1GC5puf1wIFNQTT3OgHYhKXkqQuR17xcv+/1zfAy9x2pYDAx588ba8
	 wYHwYyFDF+a9sT//mCTG9qHd9pfQn6o9zzCOlmi4=
Date: Wed, 8 Oct 2025 12:06:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <2025100838-undermine-zit-83b6@gregkh>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
 <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
 <20251008070419.GR4067720@noisy.programming.kicks-ass.net>
 <2025100822-drained-foe-2426@gregkh>
 <aOYyOYrzoKDLCl7F@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOYyOYrzoKDLCl7F@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Oct 08, 2025 at 11:43:21AM +0200, Juri Lelli wrote:
> On 08/10/25 09:33, Greg Kroah-Hartman wrote:
> > On Wed, Oct 08, 2025 at 09:04:19AM +0200, Peter Zijlstra wrote:
> > > On Tue, Oct 07, 2025 at 11:54:18AM +0200, Juri Lelli wrote:
> > > 
> > > > Not for this patch, but I wondered if, while we are at it, we wanted to
> > > > complete documentation of these flags. My new AI friend is suggesting
> > > > the following, is it very much garbage? :)
> > > 
> > > Heh; its not terrible. I've been playing with local LLMs, but mostly
> > > I've found they struggle with getting enough context to not be utterly
> > > demented. And when you up the context window, they get unusable slow :/
> > > 
> > > Setting up and configuring the whole pile of subtly interlocking stacks
> > > of software to get anything useful out of this stuff is non-trivial (it
> > > reminds me of the sendmail m4 days).
> > > 
> > > > ---
> > > > 
> > > > From: Claude <claude-sonnet-4-5@anthropic.com>
> > > > Date: Mon, 7 Oct 2025 12:44:13 +0200
> > > > Subject: sched: Document remaining DEQUEUE/ENQUEUE flags
> > > > 
> > > > Complete the flag documentation by adding descriptions for the three
> > > > previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
> > > > ENQUEUE_INITIAL.
> > > > 
> > > > DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
> > > > traced, parked, dead, or frozen) that don't use the normal wait-loop
> > > > pattern and must not use delayed dequeue.
> > > > 
> > > > DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
> > > > CFS bandwidth throttling, preventing delayed dequeue to ensure proper
> > > > throttling behavior.
> > > > 
> > > > ENQUEUE_INITIAL is used when enqueueing newly created tasks in
> > > > wake_up_new_task(), allowing the fair scheduler to give them preferential
> > > > initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).
> > > > 
> > > > Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
> > > > Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
> > > 
> > > Is this the generally acceptable form of attribution for these things?
> > > I'm not sure what the official guidance is on using these AI tools.
> > > 
> > > Greg, you have any insights here?
> > 
> > First off, Claude can NOT sign off on anything, so that's a non-starter.
> > All Red Hat people should know that :)
> 
> Yep, knew that. But I felt guilty nontheless as I didn't touch the
> change at all. Current SoB was kind of a (silly) joke. :)
> 
> > Otherwise, there is a draft of something that was going to address stuff
> > like this floating around by Dave Hansen, I'll go poke him to see what
> > the status of that is.
> 
> I believe it was suggested something like Co-developed-by: <model> and
> then Signed-off-by: <human>, but indeed curious to know how that
> discussion ended.

The general answer is "you better know the copyright ownership
information of the output of the tool you use" before you do anything
with any of these tools.  Be careful about this, because adding your
signed-off-by to a patch like makes it your responsibility :)

After that, treat it like any other tool that you use to generate a
patch, document what you used and why/how, and you should be fine.  You
have to do this today if you were to use any type of tool, so in that
way, "AI" is no different, with the exception of the ownership of the
output result (again, consult the terms of the tool used.)

Hopefully documentation updates to our process documents will reflect
this in the near future.

thanks,

greg k-h


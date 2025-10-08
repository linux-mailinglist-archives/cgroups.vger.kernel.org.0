Return-Path: <cgroups+bounces-10598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B4BC3B4A
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 09:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 983634F8C16
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49302F291B;
	Wed,  8 Oct 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="THOnTZK3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03C2F25E7;
	Wed,  8 Oct 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908820; cv=none; b=ExyOvCUNoaK5uUoyBoMOgTvOmkEU76Z74ae/Mec+Np9bik1vw1JyzfZXSdoM021MvJyB5r1/qJne02Fl0Ohk98nCjUREoChe9GgF6Nig3tXQeqeE8Dv26Tn/vgdXdLGEmmk453q2dp7LAPFXttTvZDC4MlwiAxT5a7MUwLEyhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908820; c=relaxed/simple;
	bh=vSTrDhYTu+3yxhRib3qN4tlG/ZihFmEN4MbkyJmClT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEBk02kdliIt1sKHYjTrQyD9iJpk+q/0eSs6MUwaPzx4AD2tpZ9uUO4HJBtGHQ7rm30SYJgQZAeb60gsIKmLLLdqrnsEjYij/ixm0qv11rY+gSFMiRRWCXtXd9/0mL7fCSAfH1FlIk7C/tWXLspjfE9eZKeu5s2x+ikJ/ArqfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=THOnTZK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D499C4CEF4;
	Wed,  8 Oct 2025 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759908819;
	bh=vSTrDhYTu+3yxhRib3qN4tlG/ZihFmEN4MbkyJmClT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THOnTZK3vm5Unkk3PoQnjYbs4LByUBhEmcV6PaIQDvR0TcAVjec9xvhRi6hQ2XTdb
	 21bLH4YB8Mi2nD9Yl+cHDcloXRN+emtkALmQtGcPHsGz/X8KuVSo46hVZE8fCLLstz
	 yvIDs/GB9mGT6I+t/Fh2wdljANYvw6jfjbDKmkOI=
Date: Wed, 8 Oct 2025 09:33:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <2025100822-drained-foe-2426@gregkh>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
 <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
 <20251008070419.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008070419.GR4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 08, 2025 at 09:04:19AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 11:54:18AM +0200, Juri Lelli wrote:
> 
> > Not for this patch, but I wondered if, while we are at it, we wanted to
> > complete documentation of these flags. My new AI friend is suggesting
> > the following, is it very much garbage? :)
> 
> Heh; its not terrible. I've been playing with local LLMs, but mostly
> I've found they struggle with getting enough context to not be utterly
> demented. And when you up the context window, they get unusable slow :/
> 
> Setting up and configuring the whole pile of subtly interlocking stacks
> of software to get anything useful out of this stuff is non-trivial (it
> reminds me of the sendmail m4 days).
> 
> > ---
> > 
> > From: Claude <claude-sonnet-4-5@anthropic.com>
> > Date: Mon, 7 Oct 2025 12:44:13 +0200
> > Subject: sched: Document remaining DEQUEUE/ENQUEUE flags
> > 
> > Complete the flag documentation by adding descriptions for the three
> > previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
> > ENQUEUE_INITIAL.
> > 
> > DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
> > traced, parked, dead, or frozen) that don't use the normal wait-loop
> > pattern and must not use delayed dequeue.
> > 
> > DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
> > CFS bandwidth throttling, preventing delayed dequeue to ensure proper
> > throttling behavior.
> > 
> > ENQUEUE_INITIAL is used when enqueueing newly created tasks in
> > wake_up_new_task(), allowing the fair scheduler to give them preferential
> > initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).
> > 
> > Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
> > Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
> 
> Is this the generally acceptable form of attribution for these things?
> I'm not sure what the official guidance is on using these AI tools.
> 
> Greg, you have any insights here?

First off, Claude can NOT sign off on anything, so that's a non-starter.
All Red Hat people should know that :)

Otherwise, there is a draft of something that was going to address stuff
like this floating around by Dave Hansen, I'll go poke him to see what
the status of that is.

thanks,

greg k-h


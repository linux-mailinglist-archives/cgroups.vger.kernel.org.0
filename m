Return-Path: <cgroups+bounces-10659-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EAABD2BB2
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F5D189D0AB
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26352264A7F;
	Mon, 13 Oct 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cG0sNGyY"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAA26B76C;
	Mon, 13 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353757; cv=none; b=Ed3yGKDm4+N3zF5mJP6semobZkIONv9Fhd1ZpW7YpqTe+H/LStv2Eciq4vNojI9cvDDwiZqNHPTkcODyfLX7H+q9j8kNBWTsz4Ftya1VvArMlI9eoJPwY9G9E763iLCZFwWT/0vzJFFOs3wUL8XQaWmyaivm6FTjUw6u9wTTrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353757; c=relaxed/simple;
	bh=MKgbCh5+PeoXCFzh8mT44Rc1zzkwCJBYMrM/dofaojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmIqteqqsILWFTz6Ke7tlxhcuVujA7vFLq6YvugO/Oj+mULneksREpoXTa8UBBL/ONoZ9wvH2khFbAW1lJI/lbbVELWxVfs2eDUFztH9U80co+iyrENE/iLetc3A2xb4q3c+GdFHruX7akdLhWzi2pLvsgkmtlccTPClAVD6WaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cG0sNGyY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ln6jMyn2VDXvL2sZKXJr6+vplFpVlXzE5nAWdWfdXCs=; b=cG0sNGyYREKs2g5glhxVNrE2Ee
	/Dh36kw5tZt/ZQLQIFn6gV4jnGCMo8vX9d8nk341CrB/v2Vpsv53jWd5qEtVSrkxYSxun4/09FIAQ
	j1zscMiS2VyBqZW8MEuhGo5zKIdnC24Lh1zGkca3s6nY+mPf+vvdxcFWjapzbc5WLYjvZ723wDwVh
	sCgepAGZkTXrn8OLyw+VGxMJdMWAe1nmCiFQxbgGK25w8Pgk16GkQJg3RiE+ZVv3BNpwM71JP2lCR
	unF9+FAhtU8CGBr5+5BawQ57p01VLPowoV7idt8QrSM+G+SDhPgsUNGqhx8ozlrk7bXDLjFnifKoM
	ycQG2MQQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8GQQ-00000004iQO-1k8j;
	Mon, 13 Oct 2025 11:09:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D4EF300325; Mon, 13 Oct 2025 13:09:11 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:09:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
Message-ID: <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org>
 <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
 <20251013110449.GJ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013110449.GJ4067720@noisy.programming.kicks-ass.net>

On Mon, Oct 13, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:

> Bah; so yeah, this new behaviour is better for indeed always calling
> newidle when it is needed, but you're also right that in case of ext
> this might not be ideal.
> 
> So I have a pile of newidle hacks here:
> 
>   https://lkml.kernel.org/r/20251010170937.GG4067720@noisy.programming.kicks-ass.net
> 
> and while I don't particularly like NI_SPARE (the has_spare_tasks thing
> is fickle); the idea seems to have some merit for this situation --
> where we know we'll not be having fair tasks at all.
> 
> I mean, we can always do something like this to sched_balance_newidle():
> 
> 	if (scx_switched_all())
> 		return 0;
> 
> Not pretty, but should do the job.

Oh, never mind, none of this is needed.

__pick_next_task()

	if (scx_enabled())
	  goto restart;

	...
restart:
	for_each_active_class(class) {
		...
	}


And then we have next_active_class() skip fair_sched_class entirely when
scx_switch_all().

So in the common ext case, we'll not hit pick_next_task_fair() at all.


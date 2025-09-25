Return-Path: <cgroups+bounces-10448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386EBB9E135
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E0C385184
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FE277011;
	Thu, 25 Sep 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gLx/GZsq"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08782741D1;
	Thu, 25 Sep 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789353; cv=none; b=B7fs7bO5tp+T1guogLKXjrAWPeLq7QNO285ZeRyVqUTIyRh8PPakPaZ96V7RbYbn6laJmnSG8Zj635xJscUUBO3GHX2vlDyljI6yFPEqYY5ycsde6lbNgdKVw+MJyDkLuutc1LygWRDTfRzJ3deZqw06htW+m6xKyVNFj8LuNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789353; c=relaxed/simple;
	bh=2JRVbBJCOluYqiAsg0vq24eZTm6yiFewFVLwtwDNLU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8PQ9r+GEofj4ICovWlUPmO02hBU3NlDKnxrEhznABovP4rp6B4DhvrS77hlKTsER2RxBHiHsixfAyQTGz7SnG1hS3xyXMUMgyIKOO/ZoA4l+oB+GNMhmxtaDL3AeR9jIx/oLeihI5Zs4thSlYHDp79+50mvY3LD95khs5x/hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gLx/GZsq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W7n0abhXsFOJSAIc43b/GMwuWyJPVw+tYz88nXK6Yos=; b=gLx/GZsqPH02Zz2sV9cupHgHJ2
	FjCU6q63E+KYCJMLiH1CLcm8RvBIp/FH20uyP7btzTNhGnKFAV5W+VRuxDj5Ha3i1CHT0Q10jhWa3
	81wSCE9DkODiObyH+qaxneyVP6Uj3jGBIWU0z7zabyXleqekYFQ6w9wMOE7Auf6FW7xmpYFXtSFeg
	NkgdS9z4gF7VTUKH8cYtYW/MoX0oMqwABbzc1KeK0DmpWCJ44V8DZCn56ijWSvUqd63lRoNok/prA
	f9K1Fb0ircgjP4U/E/qwUMWlhitKPg1Iq8Ebjzcb2IqJKi+B1QwBnby7W0x3OAxDS9YpAZXNdMAT1
	CU7vFRjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1hRt-000000005wE-3x8e;
	Thu, 25 Sep 2025 08:35:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40382300579; Thu, 25 Sep 2025 10:35:33 +0200 (CEST)
Date: Thu, 25 Sep 2025 10:35:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnnslT_mUfAtytN@slm.duckdns.org>


Hi! Sorry for the delay,

On Tue, Sep 16, 2025 at 12:41:54PM -1000, Tejun Heo wrote:

> On Tue, Sep 16, 2025 at 12:29:57PM -1000, Tejun Heo wrote:
> ...
> > Long term, I think maintaining flexibility is of higher importance for
> > sched_ext than e.g. small performance improvements or even design or
> > implementation aesthetics. The primary purpose is enabling trying out new,
> > sometimes wild, things after all. As such, I don't think it'd be a good idea
> > to put strict restrictions on how the BPF side operates unless it affects
> > the ability to recover the system from a malfunctioning BPF scheduler, of
> > course.
> 
> Thinking a bit more about it. I wonder the status-quo is actually an okay
> balance. All in-kernel sched classes are per-CPU rich rq design, which
> meshes well with the current locking scheme, for obvious reasons.
> 
> sched_ext is an oddball in that it may want to hot-migrate tasks at the last
> minute because who knows what the BPF side wants to do. However, this just
> boils down to having to always call balance() before any pick_task()
> attempts (including DL server case). Yeah, it's a niggle, especially as
> there needs to be a secondary hook to handle losing the race between
> balance() and pick_task(), but it's pretty contained conceptually and not a
> lot of code.

Status quo isn't sufficient; there is that guy that wants to fix some RT
interaction, and there is that dl_server series.

The only viable option other than overhauling the locking, is pushing rf
into pick_task() and have that do all the lock dancing. This gets rid of
that balance abuse (which is needed for dl_server) and also allows
fixing that rt thing.

It just makes a giant mess of pick_task_scx() which might have to drop
locks and retry/abort -- which you weren't very keen on, but yeah, it
should work.

As to letting BPF do wild experiments; that's fine of course, but not
exposing the actual locking requirements is like denying reality. You
can't do lock-break in pick_task_scx() and then claim lockless or
advanced locking -- that's just not true.

Also, you cannot claim bpf-sched author is clever enough to implement
advanced locking, but then somehow not clever enough to deal with a
simple interface to express locking to the core code. That feels
disingenuous.

For all the DSQ based schedulers, this new locking really is an
improvement, but if you don't want to constrain bpf-sched authors to
reality, then perhaps only do the lock break dance for them?

Anyway, I'll go poke at this series again -- the latest queue.git
version seemed to work reliably for me (I could run stress-ng while
having scx_simple loaded), but the robot seems to have found an issue.



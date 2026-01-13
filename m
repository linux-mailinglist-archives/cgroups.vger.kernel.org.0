Return-Path: <cgroups+bounces-13145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A3D1899F
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6028B3046994
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341E38E121;
	Tue, 13 Jan 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eWz50Dd1"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4138BF99;
	Tue, 13 Jan 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305390; cv=none; b=p44PAeumjONv5/+ugFC0ig5eL3Ffl+slMOilCKVTk1UmERmPkFO0zN9d89Lj1XhPrLYX2RbCoFyrx2+d4CLdDyleAAiXj/KWVxLGon3qnqfre55rItmWRm4/aJiOzbe37fOlfLvhdQMLX3mezI5Rqi1B3Hweu5j9kz8kdglLBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305390; c=relaxed/simple;
	bh=PLINpjm7eUCp1HsiKUyIP4tyjri37fh+wD1dDfgZ1d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0sMPVOOuSzbELUQOEnmZ2OqLVjWWm/iI0s3eYHqayne4RDjIknJ4P60elEGkHMyQCXszZM+f9mH1rK9byf3yY/B0P+3zCGomAt8FJH86hvLnwokDafPlBgmTbZ81v6QCfwMawX/GEl9rmWEp6M+7wRQpEE88eTTZw5pFWUdz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eWz50Dd1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Z3s2IJr2MRvr+ihpTUvHpk2NWB1i3v1041MBc/NhTo=; b=eWz50Dd1vGagt/tZizYceGdgz2
	YisyKS9vruWQeSnN/Bh0mfdMXNjHtOTUAVyqRUG4UWXd4iXqr2JE+UAN/DgHjn8y/G0O1DRoBmmSi
	yDtyEYqvfhA5wqnh7W4agOZ+jDf+Xuz8OoIGf4BCPCU6tSLUmctNofXD2D7dHh9Ri5SwNjvSQhZD7
	fDoAJmspfeM/kElDT5U74eEW8u5IrhjCqiyjWJcgz99PlUVbeZZklW4xRd0tb2cX66Z9DMjoG3YIG
	NZ7owagkXQrjpqWN65ekIFX9nmWPgSTA9toXlLK7A68fqYLUR139y5lowj4YglPXF2Pw6SyN/ZFeW
	HQn4Gjyw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfd0Y-00000004fWO-2lwm;
	Tue, 13 Jan 2026 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B27730049A; Tue, 13 Jan 2026 12:56:22 +0100 (CET)
Date: Tue, 13 Jan 2026 12:56:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260113115622.GA831285@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <ef8d8e46-06eb-46c1-9402-d292c2eb51f9@amd.com>
 <20260113115309.GB831050@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113115309.GB831050@noisy.programming.kicks-ass.net>

On Tue, Jan 13, 2026 at 12:53:09PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 13, 2026 at 04:35:02PM +0530, K Prateek Nayak wrote:
> 
> > Does enabling WARN_DOUBLE_CLOCK warn of a double clock update before
> > hitting this warning?
> 
> setup_new_dl_entity() -> update_rq_clock() seems like it will trip that
> in this case.

Something like so to fix: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")


--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -752,8 +752,6 @@ static inline void setup_new_dl_entity(s
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
-	update_rq_clock(rq);
-
 	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
 
@@ -1834,6 +1832,7 @@ void sched_init_dl_servers(void)
 		rq = cpu_rq(cpu);
 
 		guard(rq_lock_irq)(rq);
+		update_rq_clock(rq);
 
 		dl_se = &rq->fair_server;
 


Return-Path: <cgroups+bounces-9995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC0B5354F
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1553B64BB
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAED33CEA3;
	Thu, 11 Sep 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="odYy6zC8"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27633A03D;
	Thu, 11 Sep 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601014; cv=none; b=tCJSxKbYKffCnaKYXWauSGDL6nCPKg8sBj/gLaQIoV0M2014xNxY+dcq+FgEc+qFYswa82eXDeNS9LrRgkQkxkjCwdBVdsqd9T1sOxPP+kza0XLfrrKZyXUOgOy+DPqyX/muVGDMX5MKW3hSH/qboSvto12edeWyN3e9X9nceFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601014; c=relaxed/simple;
	bh=+nuHJJgA1UZzmSSrRpr9RqIkTonjYqdsreUt0Fvixjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpkKDFGAu5g4WbvWgEtqWHBz6FwH4FEgrePz1bp7Tna+7XatGrin6DemUEJQRpqSBGKV8kbvQpuGA7DFaw2Iab244uBLlBIv4/hHwLXGk97b8gYnpPpP3MN8Ma03wjagEWY30ZUePU8cAmR3V6UsESPQqbRSLBk+AhmIf+B/H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=odYy6zC8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Lz8ZDk2B2FZe4fQIDBwLWIa5BFq5+bd/klhhnDYKyU=; b=odYy6zC8sXQ8uabmcdh6Rv/K12
	OxB1NSuHhiZVI1dQ8pYWV4X7PkDYEHVv6WgMZVa0pIrTmDgZzng7yP6t0ixe2h1418XoMVYjASK1o
	3U4HwUXP2eWQ+hvqDjkpnElX18KNxQZRmkgL0L1cueTxutUbDSKq6M9dN95F290ME1Tgv60NhRT/t
	34Z2G0I2KM22JLTDIcJhojzCCN5W+5jHBpbhhUHeHUJRpxUoWx+i63B79zHqXaqazoG44/fzvf55d
	+RanpJJj8IUkINYQ5GoYn22aamFoEIwWUCVpX75LHpqCMqZi89+NbDjbrZOPQ2KRhI/sacJKcTtQ8
	AkMVC0Ew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwiJF-0000000CWZe-2B6f;
	Thu, 11 Sep 2025 14:30:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 299DF300579; Thu, 11 Sep 2025 16:30:00 +0200 (CEST)
Date: Thu, 11 Sep 2025 16:30:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <20250911143000.GT4068168@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
 <20250911140022.GP4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911140022.GP4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 11, 2025 at 04:00:22PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 10, 2025 at 07:32:12PM +0200, Andrea Righi wrote:
> 
> > Reproducer:
> > 
> >  $ cd tools/sched_ext
> >  $ make scx_simple
> 
> FWIW, I only have one machine where this works. Most of my machines this
> results in an endless stream of build fail; same for the selftest stuff.
> 
> No clues given, just endless build fail :-(

Ah, I need to do: make O=/build-path/. The one machine it worked on had
an actual test kernel installed and booted.




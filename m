Return-Path: <cgroups+bounces-8634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C722AEA637
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E1C189E948
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638E2EF9AE;
	Thu, 26 Jun 2025 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yv222yez"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CC2EF9B5
	for <cgroups@vger.kernel.org>; Thu, 26 Jun 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965362; cv=none; b=uVHIWt9hE2eO/6SC0wAUR8lqJ45C/v7hoRmj7A3my8xDJcen1xdGBgcgw7uT7R5d6vt1XSGG+Eshw3tHnIDFRCr4o2W6FxHysbqELT7tNoUNn+8Ffl6CF4j/XBfZzcZq8EGgE05R2sceQk962Vi6tJGbELt9c/VaCeLxFEZIeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965362; c=relaxed/simple;
	bh=IQ5Y9xKlQMDuOZ0bFX8LdFrsrUKqhytF9hxz6hFtHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7hVy3L7gk1LV2Eubn48IspKEYtRRQKc9PTebVQAOTYFqNYShtnMkigSWKV4yifG4T1HqvxAyzCFFog2q+AD+gmfqaEgD67GJNm/lvrJu5LmTCI7n8UBKkxcd6YAMUwj/Id8hYKknhdQD9ahze1PPfLmbmYOoXnkVUkLi2rsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yv222yez; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 12:15:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750965358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsoK1nloP/OzwN9AIRjEVF3ypV5O0KTTf4bgrugiJbk=;
	b=Yv222yezeQR7onrl97UjEf2o2CR998cMQF6TtPrpL926xSEOQQjgWNUhgL+Xp8tm6TrSyq
	JS201xpksbv6rcxoedGPr6jmF5qTKSFGcnXnFJMzlTRYE8biUNLUiiD4hS2b6Ta+opO8P/
	GSEeloZ6cdHLiwwiBJJHSVyk9OydUeo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, inwardvessel@gmail.com
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 24, 2025 at 04:45:58PM +0200, Bertrand Wlodarczyk wrote:
> The kernel faces scalability issues when multiple userspace
> programs attempt to read cgroup statistics concurrently.
> 
> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
> which prevents access and updates to the statistics
> of the css from multiple CPUs in parallel.
> 
> Given that rstat operates on a per-CPU basis and only aggregates
> statistics in the parent cgroup, there is no compelling reason
> why these statistics cannot be atomic.
> By eliminating the lock during CPU statistics access,
> each CPU can traverse its rstat hierarchy independently, without blocking.
> Synchronization is achieved during parent propagation through
> atomic operations.
> 
> This change significantly enhances performance on commit
> 8dcb0ed834a3ec03 ("memcg: cgroup: call css_rstat_updated irrespective of in_nmi()")
> in scenarios where multiple CPUs accessCPU rstat within a
> single cgroup hierarchy, yielding a performance improvement of around 40 times.
> Notably, performance for memory and I/O rstats remains unchanged,
> as the lock remains in place for these usages.
> 
> Additionally, this patch addresses a race condition detectable
> in the current mainline by KCSAN in __cgroup_account_cputime,
> which occurs when attempting to read a single hierarchy
> from multiple CPUs.
> 
> Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>

This patch breaks memory controller as explained in the comments on the
previous version. Also the response to the tearing issue explained by JP
is not satisfying. 


Please run scripts/faddr2line on css_rstat_flush+0x1b0/0xed0 and
css_rstat_updated+0x8f/0x1a0 to see which field is causing the race.


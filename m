Return-Path: <cgroups+bounces-8618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909F3AE22E0
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411B51C252FC
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869492ECD0E;
	Fri, 20 Jun 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifMtgACB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9B2EB5D5
	for <cgroups@vger.kernel.org>; Fri, 20 Jun 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447824; cv=none; b=GTgDFYD7vuZ1ry3oCT149Bc5+ErY0PtBTPgkUU9E2hvCDNcI3m3f8iJepCpzYqXYjR/nBk5QUzJkcWmUerm+l6FJdELlunvUfqDoXvM37JFZG49JOXcBEtVkOqyTbMFZLMNODV14j85JcqLs6p94jJjgZMZza2vuUG85x63N1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447824; c=relaxed/simple;
	bh=QP5FKXkOvXJVgnLo7dy4hr0VyXj3zHtRrrMGGJwoX2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgToAstR4Z/5wiTcoTsh7SBKaQtcW1N6mgE7Cnp7YNXGScNbvaLhco5z8GSzNxYVt88LYREuWXy2cnTyNF05r1ppWW2I0PFYejdSK3Pfoh/Y64xSMysomuO11WVGaPBJcU56ny86QTWLecxX6gj9t4oCs9g5cuBo7fSSVYogSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifMtgACB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Jun 2025 12:30:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750447810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+AJ4MmUMawQsQJ+yWlhSORCWDOitW49EDv6tCdjnvxs=;
	b=ifMtgACBjxoEMcXauHo4b23Gv5jsjQGterQCy2KA4Sfgqlvde2QOw/2B+PW7evPpfEyRSa
	ZqrVUH6ZlpzLtTe0rvef+HYnKRQXA2vNtdxlEWx1U8o+g+h0hWkV9uW+aOTEuGk5l8LorR
	uuzP9jfZvTl1MrrXGB/NKoQ2zOm5GWU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 16/27] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
Message-ID: <ezplssjtvj5kfp7zutj5ufmmxvvyd2bioxdsfqaauzi5i6b3yv@2hbbax4kfct6>
References: <20250620152308.27492-1-frederic@kernel.org>
 <20250620152308.27492-17-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620152308.27492-17-frederic@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 05:22:57PM +0200, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> order to synchronize against memcg workqueue to make sure that no
> asynchronous draining is still pending or executing on a newly made
> isolated CPU, the housekeeping susbsystem must flush the memcg
> workqueues.
> 
> However the memcg workqueues can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
> 
> Solve this with creating a memcg specific pool and provide and use the
> appropriate flushing API.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


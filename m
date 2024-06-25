Return-Path: <cgroups+bounces-3362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D4916DEC
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BF1F26C3C
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97A172764;
	Tue, 25 Jun 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n/QoJ+WT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34643170835
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332515; cv=none; b=uyDl1oZOJbVTmA4pHcITBK9uJpmp1og14gzjTdhWrOP5q0Hu6xj9sfxOIjKsGHRbSCj5uMJm232gg+0mVBHzZUAgXiI2p4TpbWXx5lbNdJi1SiT3Zk6w65RigcGJPt9PKJdJG4pqwgKByRZIJELfaHqhROZ3DzxEvy8LVS1dZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332515; c=relaxed/simple;
	bh=GSbTAVbvcqI5Vx642k8ynr7B6qZnt/MHvqVuF5WIwwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNnz9Xd/LvUlQ7nFVZPFmQLwKTJGZTrk8QZQ4R03hb0dqu0vPVfPLTD66mqUGq56genaVCP8bErKt1J2+MKwYZ0up0OxApJYnl4/5yClVKV9/lkmUP18pRJ09uKmF8TPbPoEAd0CVk3QNBRe3v7mjzX2tvqAvN2LObl874rnjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n/QoJ+WT; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719332510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JsKwkOzJRkCqgK9b5/5y5ypM04LA5hn9jja5vwe8JZM=;
	b=n/QoJ+WTvdLjzgtm28UanSfKZZ2a/8eil2rV0T5ZZZC4BtSvhbqbhcIIUPZoJQI1zdnXjY
	87z5TX8a8vLXjSWAEk8nWSN0hceNXpfp93IwWGJMjj9OzwBC+JNBYft1kLeeYx0ASlvyuP
	ejYTFzvlUkg/YdaHwSUQgaOQ38B32lo=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 09:21:45 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
References: <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
 <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 09:00:03AM GMT, Yosry Ahmed wrote:
[...]
> 
> My point is not about accuracy, although I think it's a reasonable
> argument on its own (a lot of things could change in a short amount of
> time, which is why I prefer magnitude-based ratelimiting).
> 
> My point is about logical ordering. If a userspace program reads the
> stats *after* an event occurs, it expects to get a snapshot of the
> system state after that event. Two examples are:
> 
> - A proactive reclaimer reading the stats after a reclaim attempt to
> check if it needs to reclaim more memory or fallback.
> - A userspace OOM killer reading the stats after a usage spike to
> decide which workload to kill.
> 
> I listed such examples with more detail in [1], when I removed
> stats_flush_ongoing from the memcg code.
> 
> [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/

You are kind of arbitrarily adding restrictions and rules here. Why not
follow the rules of a well established and battle tested stats infra
used by everyone i.e. vmstats? There is no sync flush and there are
frequent async flushes. I think that is what Jesper wants as well.

Shakeel


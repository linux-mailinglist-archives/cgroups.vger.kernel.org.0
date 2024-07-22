Return-Path: <cgroups+bounces-3848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A910093948A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 22:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643752810A6
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA21B95B;
	Mon, 22 Jul 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjVJkToG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7671429A
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678530; cv=none; b=c3KvEU780ljen8j8W85/3nuXm2DMQ5oQHJsz5iGM1hG7BAAK1DdLB7XO/gWHl/f3H9oqAoNjPZlhCPW6mcVF+L2QusdBqiJPjEP1HiIbjCBkdWLqInmUtoywLEf1ykA1yGVaHttkAJwF+zvwJIsn+60mMl9HX5bRs5jVtmDqpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678530; c=relaxed/simple;
	bh=2XmbHjGcGR9LGQHP3Jsf7zU4TMAM+Fq+l3di2wlMGoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXUBKL/CLl8osL30rgi/r+rrklAkI0rlm8reGpyv34ZuGs8kzn3EgDk0o7//VjCCZ1qcaJS1Vv8Y2zpJxQQXzItg5lN0LszypCNuCqsMblGzSjXYJJFOd/EpVWwslE9AqANJyMuRWaP/hZywFg5Gt0HdcoRdDAAg/gRu329t4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjVJkToG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721678526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivKGMe+zLq7jQ9Li9BCjPFPZ7oqpm0THNZ5W1uzUhes=;
	b=IjVJkToGM18K/3eL+3aWlIHarEsLnUVfTmjMIi0c1Igq+MqWvQPpzSqWfXQNyiI/caEOTs
	SoMF+xhQ3yBPr4YCZq85ajT8E6V8cuCn8QSlXMxuzZwUsvqayTzLLWRxcUTQ2Idn7pDipV
	APRnBeVCzRfj6LPBFzTh7lkYHaL6dcY=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2024 13:02:00 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
 <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> On Fri, Jul 19, 2024 at 3:48 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > >
> > >
> > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > Hi Jesper,
> > > >
> > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > > > >
> > > > [...]
> > > > >
> > > > >
> > > > > Looking at the production numbers for the time the lock is held for level 0:
> > > > >
> > > > > @locked_time_level[0]:
> > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> > > > >
> > > >
> > > > Is it possible to get the above histogram for other levels as well?
> > >
> > > Data from other levels available in [1]:
> > >  [1]
> > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org/
> > >
> > > IMHO the data shows we will get most out of skipping level-0 root-cgroup
> > > flushes.
> > >
> >
> > Thanks a lot of the data. Are all or most of these locked_time_level[0]
> > from kswapds? This just motivates me to strongly push the ratelimited
> > flush patch of mine (which would be orthogonal to your patch series).
> 
> Jesper and I were discussing a better ratelimiting approach, whether
> it's measuring the time since the last flush, or only skipping if we
> have a lot of flushes in a specific time frame (using __ratelimit()).
> I believe this would be better than the current memcg ratelimiting
> approach, and we can remove the latter.
> 
> WDYT?

The last statement gives me the impression that you are trying to fix
something that is not broken. The current ratelimiting users are ok, the
issue is with the sync flushers. Or maybe you are suggesting that the new
ratelimiting will be used for all sync flushers and current ratelimiting
users and the new ratelimiting will make a good tradeoff between the
accuracy and potential flush stall?


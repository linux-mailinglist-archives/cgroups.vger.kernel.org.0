Return-Path: <cgroups+bounces-3523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D4926714
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7211F23680
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41232185093;
	Wed,  3 Jul 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9WoHKyN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2811836C3
	for <cgroups@vger.kernel.org>; Wed,  3 Jul 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027655; cv=none; b=ZGfWLpNdiqgVR3yaT9e1wPb6O52rhsATi01bXFbEjKz0lDFmpY0K5vzH1/PSDt2OAIbyp3LlPaEW30dGBzjP4HYvU8el+JZqJUZS3AKMlt7NXegiBPCjbD6tsua/zv/hn4t5j73xH2PcESdCRoGqnZ37q2DHsPscrEIBpQKm4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027655; c=relaxed/simple;
	bh=FqSyU+a73jyu6OuLG6kVV6BIzAH4QLJf32ezyh/nspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5oPSd8UiBORgOYFrQcu7lLWO5Vkrtlw74bZg19WV3b6SSpCrYVlo2AtnHrbxBs7EfxMEPWiUvASSya/ceI6NiWrlBvtasJa/fS4M3HAOuTxysRxefFlDeEffZ2c7YrUT192o04PGuHe36/hA2Or9uaSNQXn5KirpqIzB7tnzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9WoHKyN; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: link@vivo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720027650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyZPON5O6++ZHw+uOQ1ftlsCqOJ1FTyz/rf8eKpBQ2w=;
	b=Y9WoHKyNvOR3yrZpzen3hMsN5tO7VfI+HQSl8+BSeYtnVxAC1Ec3bH2P1EVOXnntkaY3kz
	7V0dqSdBtGdFbdeT4lPGWF0Unbk8eK9dDYlzkLWSbxjdpacMLUTU3qbea6JYFPh5SfAF/e
	5t5pOrj19c1JrDfKXPVG43kpZdftikg=
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: david@redhat.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: schatzberg.dan@gmail.com
X-Envelope-To: kasong@tencent.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: brauner@kernel.org
X-Envelope-To: opensource.kernel@vivo.com
Date: Wed, 3 Jul 2024 10:27:25 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chris Li <chrisl@kernel.org>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
Message-ID: <tlnxo4rawxryyzlpiqhjaum667q2arecgp2u4rz2s3gcsxyaqo@qeffvy5ezufc>
References: <20240702084423.1717904-1-link@vivo.com>
 <ZoRUukQUNqGHn_x1@google.com>
 <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 03, 2024 at 10:23:35AM GMT, Huan Yang wrote:
> 
> 在 2024/7/3 3:27, Roman Gushchin 写道:
[...]
> > Hello Huan,
> > 
> > thank you for sharing your work.
> thanks
> > 
> > Some high-level thoughts:
> > 1) Naming is hard, but it took me quite a while to realize that you're talking
> Haha, sorry for my pool english
> > about free memory. Cache is obviously an overloaded term, but per-memcg-cache
> > can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's not
> 
> Currently, my idea is that all memory released by processes under memcg will
> go into the `cache`,
> 
> and the original attributes will be ignored, and can be freely requested by
> processes under memcg.
> 
> (so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more friendly?
> :)
> 
> > the best choice.
> > 2) Overall an idea to have a per-memcg free memory pool makes sense to me,
> > especially if we talk 2MB or 1GB pages (or order > 0 in general).
> I like it too :)
> > 3) You absolutely have to integrate the reclaim mechanism with a generic
> > memory reclaim mechanism, which is driven by the memory pressure.
> Yes, I all think about it.
> > 4) You claim a ~50% performance win in your workload, which is a lot. It's not
> > clear to me where it's coming from. It's hard to believe the page allocation/release
> > paths are taking 50% of the cpu time. Please, clarify.
> 
> Let me describe it more specifically. In our test scenario, we have 8GB of
> RAM, and our camera application
> 
> has a complex set of algorithms, with a peak memory requirement of up to
> 3GB.
> 
> Therefore, in a multi-application background scenario, starting the camera
> and taking photos will create a
> 
> very high memory pressure. In this scenario, any released memory will be
> quickly used by other processes (such as file pages).
> 
> So, during the process of switching from camera capture to preview, DMA-BUF
> memory will be released,
> 
> while the memory used for the preview algorithm will be simultaneously
> requested.
> 
> We need to take a lot of slow path routes to obtain enough memory for the
> preview algorithm, and it seems that the
> 
> just released DMA-BUF memory does not provide much help.
> 
> But using PMC (let's call it that for now), we are able to quickly meet the
> memory needs of the subsequent preview process
> 
> with the just released DMA-BUF memory, without having to go through the slow
> path, resulting in a significant performance improvement.
> 
> (of course, break migrate type may not good.)
> 

Please correct me if I am wrong, IIUC you have applcations with
different latency or performance requirements, running on the same
system but the system is memory constraint. You want applications with
stringent performance requirement to go less in the allocation slowpath
and want the lower priority (or no perf requirement) applications to do
more slowpath work (reclaim/compaction) for themselves as well as for
the high priority applications.

What about the allocations from the softirqs or non-memcg-aware kernel
allocations? 

An alternative approach would be something similar to the watermark
based approach. Low priority applications (or kswapds) doing
reclaim/compaction at a higher newly defined watermark and the higher
priority applications are protected through the usual memcg protection.

I can see another use-case for whatever the solution we comeup with and
that is userspace reliable oom-killer.

Shakeel



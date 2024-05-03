Return-Path: <cgroups+bounces-2775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C68BB3CB
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 21:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB73D1F25869
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 19:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76491581FD;
	Fri,  3 May 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2BxOp6Z"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC613A27D
	for <cgroups@vger.kernel.org>; Fri,  3 May 2024 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763902; cv=none; b=bTRWSzIyKKcFDkHg2UXuzRsaX4KN9tk4LbMNv7JasuIIxlsl0PxXvjk0+gep1jH9ivHjMoj4/MtPD5EaQGIofy0AmI/Mp74xqOZU2HAVx9M4ZKh8kgLnnFcgXYeXvbYhIf0QyTV4VDt04f+x/NsDkHdJOFhpQr0IiuW/ixlTOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763902; c=relaxed/simple;
	bh=VBe/SOv0mwQ5XI5qY/WFjxdIHLqFgILCJ6ieyL0XOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdtPgbEEu6IptdBoKxYCy1PsXv4Be+Nx2XCSqts5ZzvW7KW3A/1iTAK9uLVXMIr0CcbOIhF9+q53srRNHZYeFZpYYxcNTjQ18PJ1iCF9RybI/J+fR/SY5d7GuTwZfl5EX9z+r9pywJQUyUgxUWMWdNodT86PyX+q33IhS3KogBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V2BxOp6Z; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 12:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714763898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mckXklrCvW8qW39pcWOiZpvvEZSd/ILPXQUzKCJtjD8=;
	b=V2BxOp6ZWWszRo+ezP4vqmUAsMOz43rjBG7TStVGd9+e9l5CVUB72pTp2yzXXpYNsQFFw0
	TS5ChN5xanrZZE1bD+BTlQyWWZU7A7d81b5Qq8cXa0yyZ+PgE1QMWIT7EHDnAdzyOOyk7g
	pa3WaVWrgo12UH9Fc5kOuLDUaSj54aM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
 <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 03, 2024 at 04:00:20PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
[...]
> > 
> > I may have mistakenly thinking the lock hold time refers to just the
> > cpu_lock. Your reported times here are about the cgroup_rstat_lock.
> > Right? If so, the numbers make sense to me.
> > 
> 
> True, my reported number here are about the cgroup_rstat_lock.
> Glad to hear, we are more aligned then :-)
> 
> Given I just got some prod machines online with this patch
> cgroup_rstat_cpu_lock tracepoints, I can give you some early results,
> about hold-time for the cgroup_rstat_cpu_lock.

Oh you have already shared the preliminary data.

> 
> From this oneliner bpftrace commands:
> 
>   sudo bpftrace -e '
>          tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>            @start[tid]=nsecs; @cnt[probe]=count()}
>          tracepoint:cgroup:cgroup_rstat_cpu_locked {
>            $now=nsecs;
>            if (args->contended) {
>              @wait_per_cpu_ns=hist($now-@start[tid]); delete(@start[tid]);}
>            @cnt[probe]=count(); @locked[tid]=$now}
>          tracepoint:cgroup:cgroup_rstat_cpu_unlock {
>            $now=nsecs;
>            @locked_per_cpu_ns=hist($now-@locked[tid]); delete(@locked[tid]);
>            @cnt[probe]=count()}
>          interval:s:1 {time("%H:%M:%S "); print(@wait_per_cpu_ns);
>            print(@locked_per_cpu_ns); print(@cnt); clear(@cnt);}'
> 
> Results from one 1 sec period:
> 
> 13:39:55 @wait_per_cpu_ns:
> [512, 1K)              3 |      |
> [1K, 2K)              12 |@      |
> [2K, 4K)             390
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4K, 8K)              70 |@@@@@@@@@      |
> [8K, 16K)             24 |@@@      |
> [16K, 32K)           183 |@@@@@@@@@@@@@@@@@@@@@@@@      |
> [32K, 64K)            11 |@      |
> 
> @locked_per_cpu_ns:
> [256, 512)         75592 |@      |
> [512, 1K)        2537357
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1K, 2K)          528615 |@@@@@@@@@@      |
> [2K, 4K)          168519 |@@@      |
> [4K, 8K)          162039 |@@@      |
> [8K, 16K)         100730 |@@      |
> [16K, 32K)         42276 |      |
> [32K, 64K)          1423 |      |
> [64K, 128K)           89 |      |
> 
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_lock_contended]: 3 /sec
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_unlock]: 3200  /sec
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_locked]: 3200  /sec
> 
> 
> So, we see "flush-code-path" per-CPU-holding @locked_per_cpu_ns isn't
> exceeding 128 usec.

Hmm 128 usec is actually unexpectedly high. How does the cgroup
hierarchy on your system looks like? How many cgroups have actual
workloads running? Can the network softirqs run on any cpus or smaller
set of cpus? I am assuming these softirqs are processing packets from
any or all cgroups and thus have larger cgroup update tree. I wonder if
you comment out MEMCG_SOCK stat update and still see the same holding
time.

> 
> My latency requirements, to avoid RX-queue overflow, with 1024 slots,
> running at 25 Gbit/s, is 27.6 usec with small packets, and 500 usec
> (0.5ms) with MTU size packets.  This is very close to my latency
> requirements.
> 
> --Jesper
> 


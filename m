Return-Path: <cgroups+bounces-3827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEE937DEF
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 01:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A820282324
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3178148827;
	Fri, 19 Jul 2024 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G1mjbLP4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3AC8C7
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721430133; cv=none; b=jBuSCVF4QD3Iowv6MtUl+X8XB6Ef6+046qLaYMBdUuij86xLOS7VvaUCN8IqJOoJbvuv9ZJRMVYIz76MZ3htTQqM0pufAzgFqcLiDRDwcKr7v4azWe/d6zJiB3khwpKoq7EuJ/H7n18agvlc/XBpiZpqzxMK3RIipsAeuYmIZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721430133; c=relaxed/simple;
	bh=9W7XgB4rsZGerv02WanbEritEOYoNHH9GxwVAPTgL2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKn52P4PzKWXDxn+JEyTj5F9PQzSGHvliHxfBCMI9OyJOVsGUD3MWzYCCgaApDyDPa1NOEPgF+R8hgRd6RBCdhol6S2xzmEak9dpWGkAfEnAsZYe++IznMIGFmFZQOEMzbixtA1L9kAcTmYg7BtwlLqizsahhf40Fai9qrNE6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G1mjbLP4; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721430127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0zD0aA4CXe4tpOLD1gGPpbJDDXrQ2vOJBNWM34Kaa0=;
	b=G1mjbLP4/VizFq7tfwvP/yTuxNlKmKxb/zMUkDEmgh0Dut/p/A99cJkLgmPsjRpMAAfTz+
	RuI5kSSsMG+YO8hX08qxBK76kQYb1qYKV12vGGahL1BaQXd0W5PR8JdWI7HLP8ITMqNfNo
	mYs6BDEbF9CXlBYzkMoYw7tpSNzDOF4=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jul 2024 16:01:59 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <mlrz5ek6zx2dyw3kfikv4girua4lqblkl3ri6qbpmpblprx6kc@fflln5bhjbl4>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <CAJD7tkZbOf7125mcuN-EQdn6MB=dEasHWpoLmY1p-KCjjRxGXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZbOf7125mcuN-EQdn6MB=dEasHWpoLmY1p-KCjjRxGXQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 08:11:32PM GMT, Yosry Ahmed wrote:
> On Thu, Jul 18, 2024 at 5:41 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Hi Jesper,
> >
> > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > >
> > [...]
> > >
> > >
> > > Looking at the production numbers for the time the lock is held for level 0:
> > >
> > > @locked_time_level[0]:
> > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> > >
> >
> > Is it possible to get the above histogram for other levels as well? I
> > know this is 12 numa node machine, how many total CPUs are there?
> >
> > > The time is in nanosec, so M corresponds to ms (milliseconds).
> > >
> > > With 36 flushes per second (as shown earlier) this is a flush every
> > > 27.7ms.  It is not unreasonable (from above data) that the flush time
> > > also spend 27ms, which means that we spend a full CPU second flushing.
> > > That is spending too much time flushing.
> >
> > One idea to further reduce this time is more fine grained flush
> > skipping. At the moment we either skip the whole flush or not. How
> > about we make this decision per-cpu? We already have per-cpu updates
> > data and if it is less than MEMCG_CHARGE_BATCH, skip flush on that cpu.
> 
> Good idea.
> 
> I think we would need a per-subsystem callback to decide whether we
> want to flush the cgroup or not. This needs to happen in the core
> rstat flushing code (not the memcg flushing code), as we need to make
> sure we do not remove the cgroup from the per-cpu updated tree if we
> don't flush it.

Unless we have per-subsystem update tree, I don't think per-subsystem
callback would work or we would be flushing all if any subsystem wants
it. Anyways we can discuss when we have data that it really helps.

> 
> More generally, I think we should be able to have a "force" flush API
> that skips all optimizations and ensures that a flush occurs. I think
> this will be needed in the cgroup_rstat_exit() path, where stats of a
> cgroup being freed must be propagated to its parent, no matter how
> insignificant they may be, to avoid inconsistencies.

Agree.


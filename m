Return-Path: <cgroups+bounces-5163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778479A4589
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291801F21F98
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1704204F7F;
	Fri, 18 Oct 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1AwoeN7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415D20494F
	for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275075; cv=none; b=lhQi+twQ/KyliGKo/Ewp9XSa7wnu4pXDRAQHPpIXAwPyOr35zozJFx0BB28EHFTX7dxCTGdBKyPPCDXLV8h6uu7oT0mYoBVM1YZAsJ3mdvdg52YfUsuT3/teCz8TohuXeA3KtloDXcF3IhOxo+cLSe90fRtSkaGylUDL5gyYldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275075; c=relaxed/simple;
	bh=9stCk0bz/OqbCgSaLt0ZFmXMk/HLV0EkkdKV0pKwvBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye/nlCQvWIQTrJCgCtbp2MlFCAgRCTgsemOrSwHP26QGUb9t00EJ0dgVdtLqn6o7N32h+U14j1fiNc6zaAK96Z1Bi5tkn7DuojJsAh6CcTFwTht/0OazBeO65A0NBp+OEP17dxdu4OPRp6SBoKyVCTuuS6CujdKw6qEDTkqdgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1AwoeN7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Oct 2024 11:11:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729275070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z82kJau4OVTLyLsXdTp4fLHxKIf/MeK3WitqQjXeHUY=;
	b=X1AwoeN7SRMpYcfR5PjVN4DPXX6EnDTxE7m7adtF6+FnC/wJuFQuKbrYhItKeTNNJZuuWV
	EEipetN9LWnUuK6+WWn72sz50LhaoZR3Pont95nb4+2NYJcUeadBjlz7DVM+eUZUoaaRSU
	IPDTQlPipglDcpXSK3rlVpjL86/NCDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJltegdzUYGiMfR@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 18, 2024 at 03:42:13PM GMT, Michal Hocko wrote:
> On Fri 18-10-24 08:31:22, Johannes Weiner wrote:
> > On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> > > On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > > > HugeTLB usage is a metric that can provide utility for monitors hoping
> > > > to get more insight into the memory usage patterns in cgroups. It also
> > > > helps identify if large folios are being distributed efficiently across
> > > > workloads, so that tasks that can take most advantage of reduced TLB
> > > > misses are prioritized.
> > > > 
> > > > While cgroupv2's hugeTLB controller does report this value, some users
> > > > who wish to track hugeTLB usage might not want to take on the additional
> > > > overhead or the features of the controller just to use the metric.
> > > > This patch introduces hugeTLB usage in the memcg stats, mirroring the
> > > > value in the hugeTLB controller and offering a more fine-grained
> > > > cgroup-level breakdown of the value in /proc/meminfo.
> > > 
> > > This seems really confusing because memcg controller is not responsible
> > > for the hugetlb memory. Could you be more specific why enabling hugetlb
> > > controller is not really desirable when the actual per-group tracking is
> > > needed?
> > 
> > We have competition over memory, but not specifically over hugetlb.
> > 
> > The maximum hugetlb footprint of jobs is known in advance, and we
> > configure hugetlb_cma= accordingly. There are no static boot time
> > hugetlb reservations, and there is no opportunistic use of hugetlb
> > from jobs or other parts of the system. So we don't need control over
> > the hugetlb pool, and no limit enforcement on hugetlb specifically.
> > 
> > However, memory overall is overcommitted between job and system
> > management. If the main job is using hugetlb, we need that to show up
> > in memory.current and be taken into account for memory.high and
> > memory.low enforcement. It's the old memory fungibility argument: if
> > you use hugetlb, it should reduce the budget for cache/anon.
> > 
> > Nhat's recent patch to charge hugetlb to memcg accomplishes that.
> > 
> > However, we now have potentially a sizable portion of memory in
> > memory.current that doesn't show up in memory.stat. Joshua's patch
> > addresses that, so userspace can understand its memory footprint.
> > 
> > I hope that makes sense.
> 
> Looking at 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory
> in memory controller") describes this limitation
> 
>       * Hugetlb pages utilized while this option is not selected will not
>         be tracked by the memory controller (even if cgroup v2 is remounted
>         later on).
> 
> and it would be great to have an explanation why the lack of tracking
> has proven problematic. Also the above doesn't really explain why those
> who care cannot really enabled hugetlb controller to gain the
> consumption information.

Let me give my take on this. The reason is the ease and convenience to
see what is happening when I see unexpectedly large memory.current
value. Logically I would look at memory.stat to make sense of it.
Without this I have to remember that the user might have hugetlb memcg
accounting option enabled and they are use hugetlb cgroup to find the
answer. If they have not enabled hugetlb cgroup then I am in dark.

> 
> Also what happens if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled.
> Should we report potentially misleading data?

I think with what Johannes has suggested (to use lruvec_stat_mod_folio),
the metric will only get updated when hugetlb memcg accounting is
enabled and zero otherwise.


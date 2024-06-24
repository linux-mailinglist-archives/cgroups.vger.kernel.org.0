Return-Path: <cgroups+bounces-3312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80D915727
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338D11F231EA
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264C41A01A1;
	Mon, 24 Jun 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aVH3akGp"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E41A00F3
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257351; cv=none; b=mOKKhaquSUzSfJDeygIZm+ErOX0pi8hl3WswNH1a9jROtdl3KxkbEUsy4WhWlYOSg/eGS4Lj676pWnGznWDfP2v5fVqyZFVqBvQa1fd1ZcQvjjb9xJPLCBGDo5fH4UW2DD3k8d75HnfMc22UKZBd3rEAt4R7r+VCPUBhTcXvrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257351; c=relaxed/simple;
	bh=eRxLfJL/pkncDZellsqU80PotfWh5XvXDu95Ul0Zyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgJqAbF5a8fUfzuhCn6/s8YxaBg3RaBVyy/3/bM1o/OkBIXPaoBtkYSVSYOyH9SHPRLNW3wd8chlURVYAG5zzpOti5ghEHXa7Oob69gKE9ksJDY41huQPPVm4mQaiXiOguIxPmFROxaMTIR4fG3HsZLHptToU9qX92PHGlZgFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aVH3akGp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719257345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73YsBBClGIt5TbpSPiOKHwE9/5M+RqUyWGrm+k8BonY=;
	b=aVH3akGpYdpiiuoa/xlXRi3TVb3tLF8wrOExf95ahoOmx+UryJXTKOo1HwsLG3NaTrHW9i
	/iPoMlwVVa5wYX0iPZ4WF132PJtk+LhlPcroFQUE8hHifyJZIuibvjvtGQZwpocmkNVf38
	rGivv3CUv/ajtvqG/vyScQQdhsz+T74=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 12:29:00 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 10:40:48AM GMT, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 10:32 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> > > On Mon, Jun 24, 2024 at 4:55 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > >
> > [...]
> > > I am assuming this supersedes your other patch titled "[PATCH RFC]
> > > cgroup/rstat: avoid thundering herd problem on root cgrp", so I will
> > > only respond here.
> > >
> > > I have two comments:
> > > - There is no reason why this should be limited to the root cgroup. We
> > > can keep track of the cgroup being flushed, and use
> > > cgroup_is_descendant() to find out if the cgroup we want to flush is a
> > > descendant of it. We can use a pointer and cmpxchg primitives instead
> > > of the atomic here IIUC.
> > >
> > > - More importantly, I am not a fan of skipping the flush if there is
> > > an ongoing one. For all we know, the ongoing flush could have just
> > > started and the stats have not been flushed yet. This is another
> > > example of non deterministic behavior that could be difficult to
> > > debug.
> >
> > Even with the flush, there will almost always per-cpu updates which will
> > be missed. This can not be fixed unless we block the stats updaters as
> > well (which is not going to happen). So, we are already ok with this
> > level of non-determinism. Why skipping flushing would be worse? One may
> > argue 'time window is smaller' but this still does not cap the amount of
> > updates. So, unless there is concrete data that this skipping flushing
> > is detrimental to the users of stats, I don't see an issue in the
> > presense of periodic flusher.
> 
> As you mentioned, the updates that happen during the flush are
> unavoidable anyway, and the window is small. On the other hand, we
> should be able to maintain the current behavior that at least all the
> stat updates that happened *before* the call to cgroup_rstat_flush()
> are flushed after the call.
> 
> The main concern here is that the stats read *after* an event occurs
> should reflect the system state at that time. For example, a proactive
> reclaimer reading the stats after writing to memory.reclaim should
> observe the system state after the reclaim operation happened.

What about the in-kernel users like kswapd? I don't see any before or
after events for the in-kernel users.

> 
> Please see [1] for more details about why this is important, which was
> the rationale for removing stats_flush_ongoing in the first place.
> 
> [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/
> 


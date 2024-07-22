Return-Path: <cgroups+bounces-3851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EF939583
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 23:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630142823B9
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B743A1B6;
	Mon, 22 Jul 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3c9Zvlk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BA1BF54
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683935; cv=none; b=egUFt+bxFSYttMFyH4aeuhDITlVCUOXYKVdcn8nZvfmvrViwN8hAtj4ORokQMDkgRgzUidGLYuwouMrVCFShHnLj/K1CNPYsuuEiA94pT6AMPexvV0FZPO2Sj5jGpzFEHigvbYtiPSdrKgGRds9JPpoQZpWBkCIW/aWJ0WEU+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683935; c=relaxed/simple;
	bh=O3B0krzXqr5yZE8W+NEyfBeqYvObJsiZzpzSo3eTRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F18z79fqakBnf+Jo7md1LGsDhcPT5HakK54KJflk77F44VSCW/00E6VraHYvi1oVcyJCMxXpT3oMDCOF0Nm1YdV+n8fUBHI0j6hYTWB/0jdOWSwBaLtMoW7Lm92Nk7IqabX6nvwHlVQUhxMF+p3blXB60x+h3QJaE+quKfguFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3c9Zvlk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721683931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlW4hE/bVZrm7lqT+13f/Ft9E0jLCjkDyeH7NK78Ioo=;
	b=l3c9ZvlkouHAlNrKNYGTeotRR/IB559jgdrUkaXA7qGWwaYL1BnJLdOe3L1ukoX4ukDTyx
	YYfawvGJ9nyvUvcwpDlpN8uUMZh+ILhgW5W8CMk7qQw+9QfqvEEnSYLnwdVTMpqkJncr9Y
	fsOeCZPPotvHVIgUWfLeCk7KHqu3w8Q=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2024 14:32:03 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <x45wrx26boy2junfx6wzrfgdlvhvw6gji5grreadcrobs6jvhu@o5bn2hcpxul3>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
 <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
 <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
 <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 22, 2024 at 01:12:35PM GMT, Yosry Ahmed wrote:
> On Mon, Jul 22, 2024 at 1:02 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> > > On Fri, Jul 19, 2024 at 3:48 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > > > >
> > > > >
> > > > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > > > Hi Jesper,
> > > > > >
> > > > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > > > > > >
> > > > > > [...]
> > > > > > >
> > > > > > >
> > > > > > > Looking at the production numbers for the time the lock is held for level 0:
> > > > > > >
> > > > > > > @locked_time_level[0]:
> > > > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> > > > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > > > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> > > > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> > > > > > >
> > > > > >
> > > > > > Is it possible to get the above histogram for other levels as well?
> > > > >
> > > > > Data from other levels available in [1]:
> > > > >  [1]
> > > > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org/
> > > > >
> > > > > IMHO the data shows we will get most out of skipping level-0 root-cgroup
> > > > > flushes.
> > > > >
> > > >
> > > > Thanks a lot of the data. Are all or most of these locked_time_level[0]
> > > > from kswapds? This just motivates me to strongly push the ratelimited
> > > > flush patch of mine (which would be orthogonal to your patch series).
> > >
> > > Jesper and I were discussing a better ratelimiting approach, whether
> > > it's measuring the time since the last flush, or only skipping if we
> > > have a lot of flushes in a specific time frame (using __ratelimit()).
> > > I believe this would be better than the current memcg ratelimiting
> > > approach, and we can remove the latter.
> > >
> > > WDYT?
> >
> > The last statement gives me the impression that you are trying to fix
> > something that is not broken. The current ratelimiting users are ok, the
> > issue is with the sync flushers. Or maybe you are suggesting that the new
> > ratelimiting will be used for all sync flushers and current ratelimiting
> > users and the new ratelimiting will make a good tradeoff between the
> > accuracy and potential flush stall?
> 
> The latter. Basically the idea is to have more informed and generic
> ratelimiting logic in the core rstat flushing code (e.g. using
> __ratelimit()), which would apply to ~all flushers*. Then, we ideally
> wouldn't need mem_cgroup_flush_stats_ratelimited() at all.
> 

I wonder if we really need a universal ratelimit. As you noted below
there are cases where we want exact stats and then we know there are
cases where accurate stats are not needed but they are very performance
sensitive. Aiming to have a solution which will ignore such differences
might be a futile effort.

> *The obvious exception is the force flushing case we discussed for
> cgroup_rstat_exit().
> 
> In fact, I think we need that even with the ongoing flusher
> optimization, because I think there is a slight chance that a flush is
> missed. It wouldn't be problematic for other flushers, but it
> certainly can be for cgroup_rstat_exit() as the stats will be
> completely dropped.
> 
> The scenario I have in mind is:
> - CPU 1 starts a flush of cgroup A. Flushing complete, but waiters are
> not woke up yet.
> - CPU 2 updates the stats of cgroup A after it is flushed by CPU 1.
> - CPU 3 calls cgroup_rstat_exit(), sees the ongoing flusher and waits.
> - CPU 1 wakes up the waiters.
> - CPU 3 proceeds to destroy cgroup A, and the updates made by CPU 2 are lost.


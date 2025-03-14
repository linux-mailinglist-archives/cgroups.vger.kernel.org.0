Return-Path: <cgroups+bounces-7077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96830A614DD
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B691B63824
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8840202970;
	Fri, 14 Mar 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDfx+ZY7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E2202968
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966182; cv=none; b=Fvb6WJstubJFO01mkRtyWQVRoUh/ubZ54kaun+SLm/Rf79vFC9ZGi6k/6wLwvWtFfcGN1SGV8qYf9OHyIF/FES8fyoI4VXVRWgtWJ0m27so3Sx/hyUX+HKsK+ujToUMU8JZ+pPnsQHyWLEa3Ge7zuQbO1yhA+pmwJOWOdn4uwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966182; c=relaxed/simple;
	bh=N08HYeEx2BLrOY3nk+p6mAez4Kgu5A5p0jeN14xGrDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDjtYVbe8TaCXF3j1opo+igTQ9HSyI7BP7AewIi6+jEG5LINq3DEk8n1qrGcUV5xf82uKE7RqHXGzUiTKrlYaLrTtASv0XVxJeex0vtgvFPawIxCC8AWBMrnpi13C2YKnghBmxs6t6Kz74mk8IFR8i7qptkza+XN/nQkPVtxuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDfx+ZY7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741966168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NX9W4pphy205/je/RVrubGPLxjHvf8FAm0FIpSStotM=;
	b=kDfx+ZY7HutAn6rwpzWwfre1nFXudLPhjbodB85y6jIN/Ln6IkoL9WULIxtXkUJGr1TiPD
	VXyBzBgfexKieRjL91Prs3oJZx0FlorqnOO4kREJEPGP9ujsaSo8kzPxdyVSl8oVwLgFnd
	JpiuBv1U/4Dey65VG6hDinMXaFa8DQU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 06/10] memcg: do obj_cgroup_put inside drain_obj_stock
Message-ID: <grxsn6nng2hetvcx4o463g27p6cnv3x5tsc73bquuu2m34lb65@a5pp5nfdps22>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-7-shakeel.butt@linux.dev>
 <0b3ab5e5-e684-44ce-b6ed-276ad37784e6@suse.cz>
 <20250314113533.jNrVXeyr@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113533.jNrVXeyr@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:35:33PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 11:17:28 [+0100], Vlastimil Babka wrote:
> > On 3/14/25 07:15, Shakeel Butt wrote:
> > > Previously we could not call obj_cgroup_put() inside the local lock
> > > because on the put on the last reference, the release function
> > > obj_cgroup_release() may try to re-acquire the local lock. However that
> > > chain has been broken. Now simply do obj_cgroup_put() inside
> > > drain_obj_stock() instead of returning the old objcg.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Hm is this really safe? I can see obj_cgroup_release() doing
> > percpu_ref_exit() -> kfree(), do we have guaranteed that allocation won't be
> > also in a kmemcg and recurse?
> 
> This was like this until commit
> 	5675114623872 ("mm/memcg: protect memcg_stock with a local_lock_t")
> 
> at which point the put had to happen outside. This "percpu_ref_exit() ->
> kfree()" was also prior this commit.

Yes, as Sebastian said, this is as safe as before commit 567511462387.
Also the ref->data which is getting kfree()'ed from percpu_ref_exit() is
not a __GFP_ACCOUNT allocation, so can't recurse.


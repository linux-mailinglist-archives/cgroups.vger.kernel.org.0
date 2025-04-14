Return-Path: <cgroups+bounces-7523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC36A88A71
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E411899243
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63355274677;
	Mon, 14 Apr 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYNcJlvn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF51A3A80
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653340; cv=none; b=B3i8W3QUWdYc6n3V0FteuXjbDNq+1OKIXx3jHaGlBxN3GKUnzIbiqkZE9KFvWbpN354UuJgqy6rlu1UJZ1sAiOvZFT/AJVMuaj1kEFz4fCWMDDZ80XenNR52mCp/eSGnA1l08sz4t0qnn1cZM1w9WqArsf/uydXSWoXP4Vk1a+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653340; c=relaxed/simple;
	bh=nW3p7+wE7/lwNaWRvze0Y3CNGJXQgh7d1oS4++gmo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKilYBNvBBuvJMsJO5PKmyAjIzBi2FGdejRf4Dw1Pct4YwUAANMsIRg6IZxYYKbwtdnWDgje1u+25Bq3VpCeARyLk+CpPJfaHoRl0apu4YRl/IY4ILzGLfaT5k9+GtrCpsLALreYguc5lDyK/b1/MT7EUeoKpmrrX2dRVCKCZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYNcJlvn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 10:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744653336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+3eEggjd5QTRtUIj7cAsYQvM1HXr9Ku4rtj4bUFtT8=;
	b=EYNcJlvnyq/gWHNNZ6g3SvfVKaA7zwZCkPusItP0EIdMBplF3wRj0RA4VlwGPErpATy5Wx
	/8885b8gZfeVvpssCWZGVYVGF49uTU0ZBvvl7vDQ2ThWbhpie0UbOQwcOaXGSQRv+xlGnw
	ca1pCmW9tPVx1cydaqgdo45b10n8SvU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <esdt7fygdyzxxlb7ql6qzwqydzokmfi4uxkfwvxiqedff5wnxl@n34muduktzou>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
 <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
 <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
 <CAGj-7pXRmG2D+5=yj-5uuciiNccWws6erBg_hSm9S6coEhN+3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGj-7pXRmG2D+5=yj-5uuciiNccWws6erBg_hSm9S6coEhN+3Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 11, 2025 at 02:12:46PM -0400, Shakeel Butt wrote:
> On Fri, Apr 11, 2025 at 2:06 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 4/11/25 19:54, Shakeel Butt wrote:
> > > (my migadu/linux.dev stopped working and I have to send through gmail,
> > > sorry for any formatting issue)
> > >
> > > I don't see how local_irq_save() will break anything. We are working on
> > > a stock of a dead remote cpu. We actually don't even need to disable irq
> > > or need local cpu's local_lock. It is actually the calls to
> > > __mod_memcg_lruvec_state() and __mod_memcg_state() in
> > > __drain_obj_stock() which need irq-disabled on non-RT kernels and for
> > > RT-kernels they already have preempt_disable_nested().
> > >
> > > Disabling irq even on RT seems excessive but this is not a performance
> > > critical code, so I don't see an issue unless there is
> > > local_lock_irqsave() alternative which does not disables irqs on RT
> > > kernels.
> >
> > local_lock_irqsave() does not disable irqs on RT kernels :)
> 
> Sorry, I wanted to say local_irq_save() here instead of local_lock_irqsave().
> 
> > so keeping
> > local_lock as is would do the irq disable on !RT and be more RT-friendly on
> > RT. It's just wrong from the logical scope of the lock to perform it on a
> > different cpu than the stock we modify. If one day we have some runtime
> > checks for that, they would complain.
> 
> Basically I don't want to use stock_lock here. Maybe I should explore
> adding a new local_lock for __mod_memcg_lruvec_state and
> __mod_memcg_state.

Vlastimil & Sebastian, if you don't have a strong opinion/push-back on
this patch then I will keep it as is. However I am planning to rework
the memcg stats (& vmstats) to see if I can use dedicated local_lock for
them and able to modify them in any context.


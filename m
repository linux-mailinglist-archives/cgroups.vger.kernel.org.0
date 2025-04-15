Return-Path: <cgroups+bounces-7581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0CA8A4D6
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FA67AC8AF
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD831EA7DE;
	Tue, 15 Apr 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iy/SSM2A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D418B0F
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736478; cv=none; b=Xpmq8hDppkMtRFSVQ2aOKLIYZ5My+VA2J5byHdpSnALpmbSbe7pLxvB9YmyNpkxQxVEx3X3TM4KJKKmMKP7Y72Duz/LEeejYRPho+k1ZpiYs03OHPsg4sycG3v4FprhSNidVgIolT9+MWmgZG2UQM8ch7KEs3kTvRkpY2PpVT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736478; c=relaxed/simple;
	bh=SpmS5NI6cI27DpZ8jk6vBMjCGQ+6ydg3ZrQIOhSjac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp5LgDTqicw5SPVtnoe7c2OlztakfJoFH9CZoPHoSb2fISyxD+tCqx2q5//zVMdOttsLGNgq1m9wz61D/ROEIylMPvoiH9gbQ4e4pDJGuH2/Rojm0Rkk+WGJ3BugAEZIjyraCPvaxfCOhKFXmm4/7Uh0f9mGVe1CqukZvCFe2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iy/SSM2A; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Apr 2025 10:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744736473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmWFqdKuu4gt5mYfCAK/YlboynoixgjtC+GEXND4eKA=;
	b=iy/SSM2AD+vdcsUwN0V0ojVN6nJYo3xxM8bxqQvsuPlcjPZOm6vcI+v0Cd0DxgLUzNJNMS
	kimr4OBLSps6BnK2fR6sUaKjFHVPPDPs/SW5Cm6lSaoLsXuq8+bs6dUjJl1qrRGi+QQhp+
	2PTzD1X5CTfFDc7UKa+MKgQ9BDiEZlA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Waiman Long <llong@redhat.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <lw5d66yoesg2z57brkdkqbh4xqbv5kssgr2htzzhpe3pobwm6i@vr3dufhjquje>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
 <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
 <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
 <CAGj-7pXRmG2D+5=yj-5uuciiNccWws6erBg_hSm9S6coEhN+3Q@mail.gmail.com>
 <esdt7fygdyzxxlb7ql6qzwqydzokmfi4uxkfwvxiqedff5wnxl@n34muduktzou>
 <20250415063054.jerbqGF8@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415063054.jerbqGF8@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 15, 2025 at 08:30:54AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-14 10:55:31 [-0700], Shakeel Butt wrote:
> > Vlastimil & Sebastian, if you don't have a strong opinion/push-back on
> > this patch then I will keep it as is. However I am planning to rework
> > the memcg stats (& vmstats) to see if I can use dedicated local_lock for
> > them and able to modify them in any context.
> 
> Please don't use local_irq_save().

Sounds good. Andrew, can you please drop this patch (I think it was
picked into mm-new).

BTW I think using local_irq_save() is not wrong and just not preferred
for RT kernel, is that correct?


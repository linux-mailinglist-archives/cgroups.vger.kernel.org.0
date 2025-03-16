Return-Path: <cgroups+bounces-7096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC1A6340C
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 05:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69643B070A
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB51448E0;
	Sun, 16 Mar 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrBFtTd9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED027702
	for <cgroups@vger.kernel.org>; Sun, 16 Mar 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742100247; cv=none; b=Cb27LuqExIrGehRDyYtSuOOlQjCFVtGZd/yBaafKwBIv90OMkKDB1nwLkuk/jsnBy0vA2ywl/xRvFmU+fk56aFGA+1GeyCJXsTmdejgKu5E287RSnN8CwzXXSn7UO3IWr6waDRHdyPHnWivqHdd6nRhWAocAAXED++JBn34V4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742100247; c=relaxed/simple;
	bh=AUnrriapiGkwd2RqI8DO908oV92FiqsRwTYsawiwcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxwCU52n8FGpv544xDHGOkzRuZew/epbEamwjOkZ5KCR+UVzOdXZ3QQW72X6pSmzXSWysyROyfQW7duTymjN1qaN4t4/AQ8LHJpOp4Y7RYhM5OvdEzq82FZ/SAy0FtIevkiVwuG2tv2viCfg6+SSnzi+ZOkbV3nAb2snU0QPLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrBFtTd9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Mar 2025 21:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742100232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFMOPq6zqDYkg+++uZfW7MyXeWairUVM1+MW/9m9jVk=;
	b=SrBFtTd9cwU7FP/mitEkfJAy+Ozt/iurTTbwwDCTwVcNDItp0GqZigptnn9bXfDoVxVqCr
	i7SJq5LouoAMPQpkog3TCq9F5FJb/m0Cy8NIin8Q1L+1OEhZwOThX4ixTRnC3xrMAby8yy
	fraMejiSeY5xuorHe7lcohCBg6FybMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-ID: <s6va6ux3y2nb7cy36zeyj6wbvhd4w4qakmx52jvxzj3onq53h4@yztw4rayrj36>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 08:57:59PM -0700, Andrew Morton wrote:
> On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > 
> > This is a cleanup series which is trying to simplify the memcg per-cpu
> > stock code, particularly it tries to remove unnecessary dependencies on
> > local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> > optimizes the charge path by combining the charging and accounting.
> > 
> > This series is based on next-20250314 plus two following patches:
> > 
> > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> 
> Unfortunately the bpf tree has been making changes in the same area of
> memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
> stock_lock.")
> 
> Sigh.  We're at -rc7 and I don't think it's worth working around that
> for a cleanup series.  So I'm inclined to just defer this series until
> the next -rc cycle.
> 
> If BPF merges reasonably early in the next merge window then please
> promptly send this along and I should be able to squeak it into
> 6.15-rc1.
> 

Seems reasonable to me and thanks for taking a look.


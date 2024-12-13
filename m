Return-Path: <cgroups+bounces-5879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19519F0140
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39B2188A748
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB24C7D;
	Fri, 13 Dec 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EDyPU9ta"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A510F7
	for <cgroups@vger.kernel.org>; Fri, 13 Dec 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050994; cv=none; b=cOORcdLXXuA7WRlEvoJeHnHn8H+GPpeT2pj3v1R8YnKT2FhuDwHu6SmyyClW6xuXUExpNPaGNCGFw8ktQiAsj4qDrCJ4b2LiIjPgK3loQ+U2T2YKwdtQejKNA7QsUBO4lBypUz8Qp2HYxqW6a+5k5X9SlighZu2JrV7vWEqmxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050994; c=relaxed/simple;
	bh=DwXV4o14XPM+SNZqwjftGFrENhILzuj8vbZ8EdSk8Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZtUj6be+BvinXNDiGrCQx1CRHgV4Yp38+/YvOU6cl+mid+xzNm1J0yoPUsnPWGVg5Tj8jKjXY32hxIXVI0lSnrSGtekpd1TUFRNSLGmKXM0ynqVJFfKod8bw/3Ul0QTim59sopOHg1Q2fEowDMkfRqj+rHFlaXaC9e8WxJaBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EDyPU9ta; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Dec 2024 00:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734050990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nIPWnjKprkNZasvPhVtfRiElviBP/q4ZO6QUFyEJt0=;
	b=EDyPU9tafbgcXhGkaS3TjLXpnimikZgo4DCJaPiA+u7l+EolaHl1rMv+o0ISICVyg0nYJd
	n706QWoFTj8pQ0/W/qR9ggYM1FZt3W3reW9DcGOE2ADiFxDz200YdFI4oe7wC3q6l2mqIe
	fFR6/t269zyyxLpXYIxPyyYwcFtIjVg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z1uEp5lCGFQK4vFb@google.com>
References: <20241212115754.38f798b3@fangorn>
 <Z1ssHQYI-Wyc1adP@google.com>
 <20241212150003.1a0ed845@fangorn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212150003.1a0ed845@fangorn>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 03:00:03PM -0500, Rik van Riel wrote:
> On Thu, 12 Dec 2024 18:31:57 +0000
> Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > Is it about a single task or groups of tasks or the entire cgroup?
> > If former, why it's a problem? A tight memcg limit can slow things down
> > in general and I don't see why we should treat the exit() path differently.
> > 
> I think the exit path does need to be treated a little differently,
> since this exit may be the only way such a cgroup can free up memory.

It's true if all tasks in a cgroup are exiting. Otherwise there are
other options (at least in theory).

> 
> > If it's about the entire cgroup and we have essentially a deadlock,
> > I feel like we need to look into the oom reaper side.
> 
> You mean something like the below?
> 
> I have not tested it yet, because we don't have any stuck
> cgroups right now among the workloads that I'm monitoring.

Yeah, something like this...

Thanks!


Return-Path: <cgroups+bounces-7211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C2A6C0BB
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1619C1887E4A
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD222D4E2;
	Fri, 21 Mar 2025 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IG2le371"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237C33F6
	for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576143; cv=none; b=BCCEseWqMsiyPdWo9Q/y56wWRK+M7q9HK3VjGoF8dfhYY/n6hVH4iyTL2bEBr/ka0aMKPnrSsLkUZaiZ1uWpbdxPPPEtcLRgMfP7lCq6Ii/A/S+jGhK049QtzXAAq213lVLDc4vFzuFrX2CrNcGfGF7lU82gWxw4NsWkxnk7aIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576143; c=relaxed/simple;
	bh=VZuWKWwqx+D4t4EN9rOo44JbxcxMII7+7ELn8GMomqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJiD836WEcjZjm42MKP2Ka1lz6F8gNlozhf18gXpvadW2tXM0B06DDnfxFyiVvFzk/OaQjSr/2xLxEhHgLZGgICjSNBDI0yMn1VcWe7aNn6+hzbKeLihgLx5QciKvVtI0aclQFEG9ocG982cHaSRGd8CPaMfHRyBayWGSihxF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IG2le371; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Mar 2025 09:55:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742576129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k4BG0pUG6A1oGGXbZDig3252bONMGhq0TL6wCJItwM=;
	b=IG2le371hUF+BSyoky5EjdInNnAZOAN3FbWyq17bhJkLgRldYBBGqn6ItUpSnUNkxlj0V2
	Pr6c4FemD9GcNp/LhOgmvJSI/qZRRseq9C++gaPtSwRPmNPqlEc7X0RYDyi5A8pbb+tMvB
	WaataOkAKAl+EW6H6Emf4K40DzGbKQg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/9] memcg: remove root memcg check from refill_stock
Message-ID: <yldsarkfr3hjf4hyojxguxshyi6lml5tau2fykoj7s4lelxcpo@cdh67zvt5dmk>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-2-shakeel.butt@linux.dev>
 <fcfbb44b-6ab9-4c39-8a00-3e6200dc25b0@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfbb44b-6ab9-4c39-8a00-3e6200dc25b0@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 08:59:59AM +0100, Vlastimil Babka wrote:
> On 3/15/25 18:49, Shakeel Butt wrote:
> > refill_stock can not be called with root memcg, so there is no need to
> > check it.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> It's not trivial to verify this so I'd add
> VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg)); as Roman suggested in patch 4 reply.
> 

Ack, will do in the next version.


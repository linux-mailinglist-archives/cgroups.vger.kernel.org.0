Return-Path: <cgroups+bounces-7098-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57AA639C7
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 02:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF75188DF06
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78732C8B;
	Mon, 17 Mar 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnQ3qMY8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0BDDC1;
	Mon, 17 Mar 2025 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742173941; cv=none; b=ls1FRUxaG/9SKYmA3LQvDaWu39SzhPWn5vsOo9YyOzICvZnMjwzyympmDazcA5b60/95QOcxYGwkLKzWi1Cc80yiVUwrTYBKj3dLJEzlc6DdOiS49msrKYZKvJ9/CTakDdp/xwW8a/LxeJSHCkRpdWf3FP9jBrTtY1jV9rR8+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742173941; c=relaxed/simple;
	bh=9y4sD9Cw4eyXxkh5JX9TsNdK0e8fgFEbpeL3YGHyIWo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D7XQXH+gGt4K4cIkGOlIBh1vgA/THUfbXkzovTepj8AzI4wCo/hj3ej1Isoym2/wnT9KOT9MFtK2qtE0hrc36LfAS0vnNf9SexHYGeIjAe4GcqjWL7Q9RJrzjPSbQAEo1TReqvA+WtlF9VZzPZCBH3QsBUjVJ25btjUwjN0YU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DnQ3qMY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B8C4CEE9;
	Mon, 17 Mar 2025 01:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742173935;
	bh=9y4sD9Cw4eyXxkh5JX9TsNdK0e8fgFEbpeL3YGHyIWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DnQ3qMY8orU8ma1/CRFzbAkQpsin7NchoJEopWxFLPHMgsz3YQdl2Kqahr9ovtrq9
	 RHPdIJJB+rtyQuVe3p14bG4d3aHE0jJ8tXnsizsTEZw1aIHHqNAmP5v3IEM0amnKUX
	 gb9KbHMlifLfqOtE+rdMqcWBBlYrJAlLB6mjCiQo=
Date: Sun, 16 Mar 2025 18:12:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, Michal
 Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-Id: <20250316181214.704966dd41abccab249e11dc@linux-foundation.org>
In-Reply-To: <20250227035155.GA110982@cmpxchg.org>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
	<mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
	<ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
	<5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
	<20250210225234.GB2484@cmpxchg.org>
	<Z6rYReNBVNyYq-Sg@google.com>
	<bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
	<t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
	<rpwhn5zwemr63x4tafcheekdmqullcjvvabdgrm3jgtbtfwgki@6sxglgvtgzof>
	<20250227035155.GA110982@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 22:51:55 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > > start only with memory.max as
> > > that has some usecases).
> > 
> > Yes, I can link [2] with more info added to the commit message.
> > 
> > Johannes, do you want effective interface for low and min as well or for
> > now just keep the current targeted interfaces?
> 
> I think it would make sense to do min, low, high, max for memory in
> one go, as a complete new feature, rather than doing them one by one.
> 
> Tejun, what's your take on this, considering other controllers as
> well? Does that seem like a reasonable solution to address the "I'm in
> a namespace and can't see my configuration" problem?

I guess Tejun missed this.

It seems that more think time is needed on this patch?


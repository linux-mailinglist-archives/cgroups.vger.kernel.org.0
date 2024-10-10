Return-Path: <cgroups+bounces-5097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E18998E4E
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4031F2554E
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF719CC0A;
	Thu, 10 Oct 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u8k1EL9o"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF819CC01
	for <cgroups@vger.kernel.org>; Thu, 10 Oct 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581251; cv=none; b=gwnOEfDCb38LwYq0ydProi1SJy583amkak7KT07B5xIGf7l1Lbh7kSnX1hE8kPW/hd4jD4YpDn3TQHBZVG+ecs7PrGdu+zgJR6elfMOqbvSuLsd88HnJusd6tKoAwR3T2SxOveHOYLr+jc6GzIVg/NUexn6iNA8ZAFYk8PTRe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581251; c=relaxed/simple;
	bh=Ao4t8Rd+GNMX4tFjKE5sXChnKVztvnZ5xoHE0429CRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WROL6qzCupwnLbEmarc1TzbVpBN6RXEORMtdoiTzpompkhrFHUyQdLXFwlYd8BX1yLdUa45b0nNgfhRYluffOf5Ka3HP8HXv7uvIJbgps90FTiepj+pRK4BtnXTFwi1O0ECo6ANO517AN0at22X/CfFfTOZ/C+uTc7cVvn2GtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u8k1EL9o; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Oct 2024 10:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728581247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cte0SjyxO3LPNz1UcE8kNcEfEtgnbXauFmqf2BL8sEw=;
	b=u8k1EL9ojeo8f2L/H89Hnd6deF/3qbzjy7PUJ/n0yNK3YIH1Skln2Sk3vEfTSL9Oh0AvNB
	Swzv/vbxwZIHT9KPXMwGQIG8pRsSyDY3d2v6yGFYVnAlY9Zgey18SLPjIZHWJDPeNluF9J
	mUS+viPu0UrxFXBEiZ936DhRKuQURa4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <hp45j5kdj5lrqltor5zsx5ti5fsw5j6pzomgtgixr3iq6z2qdd@6if6wvwmzi4h>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <Zwcj5SC_MYrPpNQq@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwcj5SC_MYrPpNQq@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 12:46:29AM GMT, Roman Gushchin wrote:
> On Wed, Oct 09, 2024 at 05:35:50PM -0700, Shakeel Butt wrote:
> > The memcg stats are maintained in rstat infrastructure which provides
> > very fast updates side and reasonable read side. However memcg added
> > plethora of stats and made the read side, which is cgroup rstat flush,
> > very slow. To solve that, threshold was added in the memcg stats read
> > side i.e. no need to flush the stats if updates are within the
> > threshold.
> > 
> > This threshold based improvement worked for sometime but more stats were
> > added to memcg and also the read codepath was getting triggered in the
> > performance sensitive paths which made threshold based ratelimiting
> > ineffective. We need more visibility into the hot and cold stats i.e.
> > stats with a lot of updates. Let's add trace to get that visibility.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks for the review.


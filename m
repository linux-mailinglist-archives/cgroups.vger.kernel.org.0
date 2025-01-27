Return-Path: <cgroups+bounces-6331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1864A1D0EB
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 07:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C43A346C
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9F1514EE;
	Mon, 27 Jan 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w98TqN4H"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F38A59
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959491; cv=none; b=juL8zPT5L4KBItORIPYDchHWF08DxUvkhkkNdmQ1Enb17H6DCIF1r8lpbxwCSH43L+RQKzQX+4na5b1zQfT+pIwzhzWufVJ4w2IzXN4iWE5gWmNn+2mqmVrRcre1/XcsD5yLkfVFxIlgjBLfeIDZkO1DzLp7sCQKnTPIPtGj234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959491; c=relaxed/simple;
	bh=+p+ZgUsZcyIgV31GaoLzkVaCOn5rT0PLRxQV3IEMAEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stSoMaLldeUfoNI5K6k2KbGhzDGbZExnMiZ6xP+iTXDeHU9x3no9GkYrGYn016BBsbVV7p1fJ6aUuVa77TklrnHNFn0/rWZtCVRddnoMuuBPA7mNy7+JEbqpTn/w3o7xrSJ/aKgqvrLFJF4uCua39/Yrb3SykN56zfzMSQUOr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w98TqN4H; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 26 Jan 2025 22:31:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737959476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7YZFYRpMp8b2yHITL2IcUj9ucb1cofXsJ9DfiW8b2w=;
	b=w98TqN4H61A4WW0VPHdSG197xC7RT6jgVIYyLkOdgfvqnLxbJE75yuoqp3PvP/w9x7igWR
	jwrUo/C97IZioE+MOIS9k0fYYyhn7A/zWFfaS5vKwutY+9MRA6s8t1pl7ZPr0rmdhWMvCl
	UHWShsgNX6qKnp+Vjnf2y1fJPVmZjs4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Message-ID: <ai7tz7posbzx4jgleqitnf2bs7gdiqgve3jgvfwb6vycmml34h@nzzhd2sjag4a>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 12:41:32AM -0500, Johannes Weiner wrote:
> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Johannes for the patch as it is related to the topic which I
think we need to make a decision on i.e. v1's swap accounting semantics
in v2. I know Google and Tencent [1] are still very deeply dependent on
v1's swap accounting semantics.

Folks from Google and Tencent, if this topic is still relevant for you,
can you please propose a LSFMM topic for this (or any other forum where
we can reach a decision).

[1] https://lore.kernel.org/all/CAMgjq7ARr0=OG8GQOJvzLtfdrtiwvJ19-mx1snxqmLE0Za+QCw@mail.gmail.com/


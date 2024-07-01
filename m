Return-Path: <cgroups+bounces-3469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962991E50E
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A69A282218
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CC16DC23;
	Mon,  1 Jul 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f0GZJ2Ag"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017116D9D4
	for <cgroups@vger.kernel.org>; Mon,  1 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850457; cv=none; b=iI2KVMCqJMYC07eVAb2b/NN7Naqaz/h/LtOGLc6fTT/Job3P6UlxuiGgh6LcBNcqorz+lRtwUhTOQ+T1PcXkLvGtdY4lOcwpm0wrYF+N9PWz8u74EjxbxpIwCDalxACMhNpFevrqAUKr66fdh7VMPys9uQdNJP/qObRu6218AX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850457; c=relaxed/simple;
	bh=OWpgVxq94AnaXy40oEfyFQCvVULf4SkmjQOkXtNdSY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVAa7gDwv6lFmaktRnAzOZXNpUYuSPMsml2ehgQxmr37dY8JIzsk/vnSCYMmTSsnpZL1B3CgRyIEMx0rBT7CqWf5EdOz0ZL0yXkJVz8XS1hN3yPseSkW1BwTzc6cTHaPaUkkftKrALfMhdSIsoOCVvFYXSsxJFuVQdSQSbDTCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f0GZJ2Ag; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hannes@cmpxchg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719850451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPLJpg0ZWsKvO6bldQkwFKZFa0IzyOnUYGnjX5tTzRw=;
	b=f0GZJ2AgngB33Srskxqd79L7EHwmuOBZzYnKiNJXjLPfMJVhXT7l7zVn/uJTv1jviDqsB3
	CRuR5sThqZ4/DBkyD4X49rNm494GON27vn38PZKte3Kw4DSLrTCBuASJDOYUqrq7hyf4nw
	3OUZgcmrtbGCe6EYv2vANguD/L+IFJ0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 1 Jul 2024 09:14:07 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Message-ID: <uf7eyxzbpq7bmngdsre4qxyzkzzukqyw5oz5c4v4fzcdrbptss@3o6uwbvr7e7o>
References: <20240701153148.452230-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701153148.452230-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 11:31:15AM GMT, Johannes Weiner wrote:
> CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
> tracking is enabled. It has been default-enabled and equivalent to
> CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
> accounting sites since, and there is no imaginable cgroup usecase
> going forward that wants to track user pages but not the multitude of
> user-drivable kernel allocations.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


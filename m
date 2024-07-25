Return-Path: <cgroups+bounces-3898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4067493C6E5
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A6A1C21B44
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1019D89E;
	Thu, 25 Jul 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MwDtNN0x"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42519D895
	for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923109; cv=none; b=KiFFkZGcYac57auS9RHxyIrFeqq3RRCl9mlEZZUpNDYW6IPD3lFkgiwDmrn/swVJo9P+qsPGpzyHOEMQC6IFwIqYua9WJx3ODDyhJgYsIw0S0bLb5HA/rKsksdh8tB6hEt8ufNBVKTogOyRJFbQuF0ltggVpWFIgL47BZAaKfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923109; c=relaxed/simple;
	bh=Gg3qOkyKWzSPtHOylZLZPM98LObUiDyDGCldIoS8GKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAhfm/FiFy79jQyzVU0t1xN8H9M4m5tXr4zAI2q24Kj1ovAl12ovv3BN61jdLU/LfcUSfGqklWP3ua2LMbf5VeoGq+36dlbjlxkpOQrJVVZbqGtFtoAS67OZrmCw84iM5lk0AjsYQAKxQDJZS2plKFCGmZKqF5MOvENz3pKzFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MwDtNN0x; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 08:58:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721923105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHy3kMv2+9CvwokKG6SI4pSO0K4nWpJXUttrkSjNaHI=;
	b=MwDtNN0xYUcYHlHs5WBURHCSX6acncLBPvSBWss8baAl5dJLlCi/7W1lUmuhU+OpS72J88
	GQhLuqUFOqx7F25tBQKZEGP9is0416Io+vE2O5qfZrN437Y4FCQ6+k+QaKh1n6ZcOM0Fhr
	wuLfqgK3sTYwy0QV6V183cXk+qD01DU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-ID: <jim27oum4wu6q3yp6skiemwckvoq64uyuyb75or7a326ojhuza@kn4l5dezqenj>
References: <20240725094330.72537-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725094330.72537-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 05:43:30PM GMT, Muchun Song wrote:
> The obj_cgroup_memcg() is supposed to safe to prevent the returned
> memory cgroup from being freed only when the caller is holding the
> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> ignore thoes conditions when users call some upper APIs which call
> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> the link below). So it is better to add lockdep assertion to
> obj_cgroup_memcg() to find those issues ASAP.
> 
> Because there is no user of obj_cgroup_memcg() holding objcg_lock
> to make the returned memory cgroup safe, do not add objcg_lock
> assertion (We should export objcg_lock if we really want to do).
> Additionally, this is some internal implementation detail of memcg
> and should not be accessible outside memcg code.
> 
> Some users like __mem_cgroup_uncharge() do not care the lifetime
> of the returned memory cgroup, which just want to know if the
> folio is charged to a memory cgroup, therefore, they do not need
> to hold the needed locks. In which case, introduce a new helper
> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> could eliminate a memory access of objcg->memcg for kmem, actually,
> a really small gain.
> 
> Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>



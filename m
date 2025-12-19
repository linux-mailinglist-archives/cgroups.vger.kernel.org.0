Return-Path: <cgroups+bounces-12535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEACD22F7
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D36030285B1
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429625742F;
	Fri, 19 Dec 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWZp3BGO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6821257E
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187117; cv=none; b=MQ8k0/gPzQ161nJuk+npIeqGeScEkCfhL4Hd0HN8hv4AjrNGJX2oNPe7OW52a2v7F++3YrDSclfbEEerpLhfYB7TLzUNd5d1F+OUZjl7wEXAYAZwVq1I4OCNIFqdg2TrmjvzhCdLrrUAlImhIbR/gwividl7oT4MIoZWl8SoQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187117; c=relaxed/simple;
	bh=8WEP2e6Zg+IP3J216Do6ljcFKRlsZUJlTvkmf2ty6Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYQsfVfEjO4ufNbqPa9va/B4W/TDk8c2/k6Xu8Qh9QxrLQc2X6292lPsVZio/UQLLFTL/OhsxxS3HLJO5PDK3IxyXHRzlczvWqo+KZx3BeD6CqAeg8ZviSjaK0hYmrqNGQ8aG3g6M1hKxgMaB2pV74+1VaFTVWQyYLWsisbeQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWZp3BGO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 15:31:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766187107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vOgNTsLKhausqFQtwp3EgZuPBkHhNtQ3ISVh7bYcnY=;
	b=ZWZp3BGOxJ8WQwxJg2TsZfRWziizPCWD8adQ31MjlcBekLIqCb9Cd/7MCRgvgURLOGmRXS
	R2ReQ8DTmIreOyurwVMJSmfRMQ5V+GFWhZrhfh/f3P0n0//PItZBHEaUQwqkQ7bYTpuhqJ
	pRnkdAD5xbFndyAeJLsFHfsj+ciGU34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 11/28] mm: memcontrol: prevent memory cgroup release
 in count_memcg_folio_events()
Message-ID: <th24uujlegbefmxlz2gngavlvddyfls4swm6zolqggtfoauztr@jhawlcvuiqsy>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:35PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in count_memcg_folio_events().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


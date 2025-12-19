Return-Path: <cgroups+bounces-12523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564ACCE0DA
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 01:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A03303BDE1
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EDF1EBFF7;
	Fri, 19 Dec 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZLJt1u5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558341B4F0A
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103844; cv=none; b=tGjl/XfMMzmFjLL81NcGl77QpQUg55nEPb7Iq2lGsEeBgimlAF7BcUT0my6hS2Qr55sLexAcAT8W5YlNIKPZbndozLMhtDcghMihWIroie09hMYtTsqzC+SWTzySFNCOWO988/2xzoOgfTkciULmSWwffSzWbZMWGJD/4ftYNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103844; c=relaxed/simple;
	bh=q6PtpFdNP0YgO/Nyt0pyGvz4g+MvK9cP/e196uf7tpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8NgMVLN2QW5miNl38893itfUjxwF6PieXnW37VZjEYn3kqDzuXvY1V+XmF+c1Db9sJ9pk+3gx7f9ZaPBBnJN6XjZgfByW69qI+yaMLMmLwQJm7dsHkpCJ4sLxvyb0CAcRDACPV/aNrHMtA/yE5/8lZoLninEVT+oGiZQFtU3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZLJt1u5; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 16:23:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766103835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0+oX+rExeXmom0V9N+9NGQb1ojEVAyEotZoi27S/X8=;
	b=RZLJt1u5LXNALiyxSmprVDFAeGIC8zaGmEKBAXGhMBXumB2jhDT9m3Pk3Lz9HhjTREr/Yo
	c2X0SVlJ3bCSJ/afGcgX87ZYT8QZyUalb/341yZwsC7GC1bCHFc6AHuhiul32xy/6y9QkT
	4hPhtTx8JW6Rth5C++VhaPwaCc0lHD4=
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
Subject: Re: [PATCH v2 06/28] mm: memcontrol: allocate object cgroup for
 non-kmem case
Message-ID: <l26tcucw2mwym44dftd54m2ewdfty3m4zwzewqpyj3bl7zrgf2@avxii6qcwp7k>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:30PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.
> 
> As a result, the objcg infrastructure is no longer solely applicable
> to the kmem case. In this patch, we extend the scope of the objcg
> infrastructure beyond the kmem case, enabling LRU folios to reuse
> it for folio charging purposes.
> 
> It should be noted that LRU folios are not accounted for at the root
> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
> the folio->memcg_data of LRU folios always points to a valid pointer.
> However, the root_mem_cgroup does not possess an object cgroup.
> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


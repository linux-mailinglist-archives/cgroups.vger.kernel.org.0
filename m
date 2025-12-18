Return-Path: <cgroups+bounces-12478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2BCCA969
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0223F304BF63
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4AF2459E5;
	Thu, 18 Dec 2025 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wo9TLXqB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066923BB40
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041765; cv=none; b=QVIIz5DyEvhJi9T0EgHzprt0gfU6oe2xcD8D+zKYr98Tmpn1/k1a+QQH2XXA+yQzGpwiI30cPR9bmtiFXjKQ4ECUa3Uvm0DLVdPRDoBIA6n9tnHMghQAHjQs3+O57t1/RM1lWwECdwjuECdGUmLgTyqu18VxYSWRBId+m4F949I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041765; c=relaxed/simple;
	bh=euI2VhBjWYNev2qUAva7gjMCWWNQOrHza/ppJ6R9gzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYRPOVfvV3Yf21YtuOjKfG0VsP2sduWRVILIiyJm7qxZdbmmjtQDv3AEaOSJgXU+W+jMWjrGfvbOgkouKwsEn6hVIrafMYhyJVMkqK9+N7Oqe1y5eCyTj+TD4K/WTmS0DewgBBGt9/fLf/5QfJ1r5se1VZ4BGfSzOLyFgelCbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wo9TLXqB; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8aee44f5-11ec-410a-9b45-5cb224e9e23a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766041759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUoGWDo/ueOcvU1k8f5hEcEJi1kwbtQAhA8TscsLJ8c=;
	b=wo9TLXqBZg4c+msgguYsic0XAZGdytn6yFZ3/W45uO5LfEOX9QMvyNr5REVy1yBgtjP/GH
	KNsaOWX0RZJDlSuKh7JM+rbcn9obJMFT8Byxvn/J43GwgGJDRn1eZ2CI7aI+UG1NgTiIpW
	LiEqHefQt8UMdpFjTS+Z4nlZuU6nv6c=
Date: Thu, 18 Dec 2025 15:09:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 20/28] mm: zswap: prevent lruvec release in
 zswap_folio_swapin()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <bd929a89469bff4f1f77dbe6508b06e386b73595.1765956026.git.zhengqi.arch@bytedance.com>
 <aUMvp5WzDp6dZCVr@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUMvp5WzDp6dZCVr@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 6:33 AM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:44PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. So an lruvec returned by folio_lruvec() could be
>> released without the rcu read lock or a reference to its memory
>> cgroup.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the lruvec in zswap_folio_swapin().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

> 
> Btw, it would make the series shorter if you combined the changes to
> workingset.c, zswap.c etc. It should still be easy to review as long
> as you just stick to making folio_memcg(), folio_lruvec() calls safe.

I prefer to separate them. For example, as you pointed out, in some
places, it would be more appropriate to switch to use
get_mem_cgroup_from_folio() to handle it. Separating them also makes
subsequent updates and iterations easier.




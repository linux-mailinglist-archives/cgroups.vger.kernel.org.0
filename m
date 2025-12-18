Return-Path: <cgroups+bounces-12486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE24CCB1B1
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635573009836
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981042FD681;
	Thu, 18 Dec 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUwTZfEp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068F2F6586;
	Thu, 18 Dec 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048968; cv=none; b=OP/71Eu/1/kEV4tLXcjzQvEDxLf5qFB8QFEvlMVDsTkwpFD5e6D76giG0jAYO1lb69CdMckMLXacIqEmoitJ7/FS0K5WU9MQODjPu3lhqISH6GlykbSbMPrTjeUM0N6nBnaPDs8mGEHNc2lSjJOtER4JVQf6zgaCXwD2TUIN4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048968; c=relaxed/simple;
	bh=cy6MizIU13WGE5axn5arnaf5rhN5ZiFE8ex8K1Wi8R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnZ+R0iQm0on3ovD22u0jgotPQlYGEFGNB1TWxr219ki/YGfoHEgwiR44XWEbiVHHbTVrorJTkbChqMYcIzEavyRiJftwbpU4Xbk4frVTpHg+gkUzR889SVuOgTbEj2SB01kfRbXgbFG2iC21/4nUCdTm0XekZ7Zio8NzASpREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUwTZfEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47EAC4CEFB;
	Thu, 18 Dec 2025 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766048967;
	bh=cy6MizIU13WGE5axn5arnaf5rhN5ZiFE8ex8K1Wi8R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUwTZfEpT3RS/Yc0n40yQFEks21Ug9cS7pT/oBG2l3gPWBMXll3cWqRb4bsmIKBuI
	 TpyrA/6eRsJ5rekjU/PiGTvoEVYK4YuHbKnRFRRnbnyjdujNPKIvXM/LmOx1n6mNZQ
	 /hEJ23EBt4Cyp56TWXusIE5oCTHDotgtvp3AzFvUy1o/WeGSV1A2KLkcQcAf5zSy3U
	 /27qcDJL9F3uBSn8UF5qruCwE23yBabi3UNyLnCm0VA9opcyOagXKTnLwAVQaBYlzA
	 enYz1yaUrs3Z1OymV7JL07tkK9a513V2JsIKvO6pYu8xwV6X+8S0x1dlW5sEPpWMCD
	 StnHpnGbDB9SA==
Message-ID: <3a6ab69e-a2cc-4c61-9de1-9b0958c72dda@kernel.org>
Date: Thu, 18 Dec 2025 10:09:21 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 08:27, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in folio_migrate_mapping().

We usually avoid talking about "patches".

In __folio_migrate_mapping(), the rcu read lock ...

> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>   mm/migrate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5169f9717f606..8bcd588c083ca 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   		struct lruvec *old_lruvec, *new_lruvec;
>   		struct mem_cgroup *memcg;
>   
> +		rcu_read_lock();
>   		memcg = folio_memcg(folio);

In general, LGTM

I wonder, though, whether we should embed that in the ABI.

Like "lock RCU and get the memcg" in one operation, to the "return memcg 
and unock rcu" in another operation.

Something like "start / end" semantics.

--
Cheers

David


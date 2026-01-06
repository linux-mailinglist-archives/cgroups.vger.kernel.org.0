Return-Path: <cgroups+bounces-12929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBFCF6F63
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 08:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FA930194E2
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281A309DDD;
	Tue,  6 Jan 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TUbUUym+"
X-Original-To: cgroups@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB526309DCC
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683214; cv=none; b=VlTYCxh6bcHS8cUEpmWwumaHdtbtunuzOlf2AABkWp+3UtOU28euQGAmJCwxoW3kgwdgkpGx5iL30gvJNFZOEB2hj6n7xC+M2CbKt9+AdaaIYPBVhHLiCSVBH/9k14yiXfQegWs315Wa72ShOv9bYR4xJS0CbjJP/7bsV5L+YL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683214; c=relaxed/simple;
	bh=aoGSrz+CkJnvaCagYd3ETrYa+2YJWWSbdOX21uGasR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgqqTMEtl2k/4Uw0Z3j9HgFXybTgd6OODXRJdskytHHp6s8SoNErC6cRRoxmE05Ab4iZTEaTt9ozlwc+APUhCDo7EiAWzoQR9Cwi6K9ht7nvHiYoOcTxMBxeopwOWTxqeqTU1kpwIwzOGGa0diQu2Sr+auf/3OML5zhbNOQvawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TUbUUym+; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id cxFyv0Pc3v724d19YvkdlR; Tue, 06 Jan 2026 07:06:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id d19XvtsXuqfpWd19XvWkhj; Tue, 06 Jan 2026 07:06:51 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=695cb48b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Aea70ojWhvW6xI+oM0giEQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=5tb3p9ZK3EDu03-LinIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uMhJZrD3f1ak8P2O+NaNyG4FF8ORDpoegVJDwB4K754=; b=TUbUUym+UFNA05D57hsUPgC5by
	dmYbgjxM2XsqxxG6AG/sUCHyCX0K6TD2R8MOXK80wC2HN/GutAFCNGnOxf1/itbLXMe7q+Y4uaw2B
	b8DY06IJArCwIcFBLD8UEOXVUx5LnN5g92b1n+yU5CBz06SjyVTxDel6AyuMM/AUMexH89fRiRRMo
	Rrs8vYo5FOzccjYjvqIzRKsnZFVhTngZEX4CC9/XwHMz9/GteTPOjkA8o+koKam/EIIF+IPPoN9M0
	dvpemkXVqDbGAd3KeLx60cIw/2aglAvcw3TQbZVKCi//wKHoh33GSAzkvTxVqCfZdYNc2QxXsG/oj
	Av/p0PuA==;
Received: from flh4-122-130-137-161.osk.mesh.ad.jp ([122.130.137.161]:49098 helo=[10.221.196.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vd19W-00000003yH0-3I7G;
	Tue, 06 Jan 2026 01:06:50 -0600
Message-ID: <4e2d8a58-a78f-46e3-81a1-342e571b4273@embeddedor.com>
Date: Tue, 6 Jan 2026 16:06:47 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cgroup: Eliminate cgrp_ancestor_storage in
 cgroup_root
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-2-mkoutny@suse.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251217162744.352391-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 122.130.137.161
X-Source-L: No
X-Exim-ID: 1vd19W-00000003yH0-3I7G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-122-130-137-161.osk.mesh.ad.jp ([10.221.196.44]) [122.130.137.161]:49098
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCJZxvELne1N0RWgvqLdQx4oyooCZggohvUyAUUClM+9llBDiQOKMytR6V8/7cqw9+XL+bZhmZPA2inWTrOtzQN0HPLJT1fxPUPas0ks2Y+Ui7YbzdJ7
 n2MwtNk5dz56hf/kAl7KjsGGZIFTghvDJyVV/NwYda8rlSLoLj3ol9XjnwRO1aWuQoJ+BAKZNun364TKHMcL0Gq2SZ5qjtruMds=



On 12/18/25 01:27, Michal Koutný wrote:
> The cgrp_ancestor_storage has two drawbacks:
> - it's not guaranteed that the member immediately follows struct cgrp in
>    cgroup_root (root cgroup's ancestors[0] might thus point to a padding
>    and not in cgrp_ancestor_storage proper),
> - this idiom raises warnings with -Wflex-array-member-not-at-end.
> 
> Instead of relying on the auxiliary member in cgroup_root, define the
> 0-th level ancestor inside struct cgroup (needed for static allocation
> of cgrp_dfl_root), deeper cgroups would allocate flexible
> _low_ancestors[].  Unionized alias through ancestors[] will
> transparently join the two ranges (ancestors is wrapped in a struct to
> avoid 'error: flexible array member in union').
> 
> The above change would still leave the flexible array at the end of
> struct cgroup, so move cgrp also towards the end of cgroup_root to
> resolve the -Wflex-array-member-not-at-end.
> 
> Link: https://lore.kernel.org/r/5fb74444-2fbb-476e-b1bf-3f3e279d0ced@embeddedor.com/
> Reported-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Closes: https://lore.kernel.org/r/b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com/
> Cc: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   include/linux/cgroup-defs.h | 28 +++++++++++++++++-----------
>   kernel/cgroup/cgroup.c      |  2 +-
>   2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b760a3c470a56..9247e437da5ce 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -626,7 +626,16 @@ struct cgroup {
>   #endif
>   
>   	/* All ancestors including self */
> -	struct cgroup *ancestors[];
> +	union {
> +		struct {
> +			void *_sentinel[0]; /* XXX to avoid 'flexible array member in a struct with no named members' */
> +			struct cgroup *ancestors[];
> +		};

Instead of the above anonymous struct, we can use the DECLARE_FLEX_ARRAY()
helper here:

		DECLARE_FLEX_ARRAY(struct cgroup, *ancestors);

In any case:

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> +		struct {
> +			struct cgroup *_root_ancestor;
> +			struct cgroup *_low_ancestors[];
> +		};
> +	};
>   };
>   
>   /*
> @@ -647,16 +656,6 @@ struct cgroup_root {
>   	struct list_head root_list;
>   	struct rcu_head rcu;	/* Must be near the top */
>   
> -	/*
> -	 * The root cgroup. The containing cgroup_root will be destroyed on its
> -	 * release. cgrp->ancestors[0] will be used overflowing into the
> -	 * following field. cgrp_ancestor_storage must immediately follow.
> -	 */
> -	struct cgroup cgrp;
> -
> -	/* must follow cgrp for cgrp->ancestors[0], see above */
> -	struct cgroup *cgrp_ancestor_storage;
> -
>   	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
>   	atomic_t nr_cgrps;
>   
> @@ -668,6 +667,13 @@ struct cgroup_root {
>   
>   	/* The name for this hierarchy - may be empty */
>   	char name[MAX_CGROUP_ROOT_NAMELEN];
> +
> +	/*
> +	 * The root cgroup. The containing cgroup_root will be destroyed on its
> +	 * release. This must be embedded last due to flexible array at the end
> +	 * of struct cgroup.
> +	 */
> +	struct cgroup cgrp;
>   };
>   
>   /*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e717208cfb185..554a02ee298ba 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5847,7 +5847,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>   	int ret;
>   
>   	/* allocate the cgroup and its ID, 0 is reserved for the root */
> -	cgrp = kzalloc(struct_size(cgrp, ancestors, (level + 1)), GFP_KERNEL);
> +	cgrp = kzalloc(struct_size(cgrp, _low_ancestors, level), GFP_KERNEL);
>   	if (!cgrp)
>   		return ERR_PTR(-ENOMEM);
>   



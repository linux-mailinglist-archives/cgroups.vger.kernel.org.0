Return-Path: <cgroups+bounces-7647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B6A940F3
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF98B462F65
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060381ACA;
	Sat, 19 Apr 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqgSFJzz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603F249EB
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745027955; cv=none; b=c15Bz/j0Tp7zL52y1aVWjKsfMC4j/s7OgCADkskM/uFORKkpPtYwtrEaoGfGyyuq4W8ZmAo+a9NUCcJ5c9yYTLe47JUAyWJptwCYLTPRGws4DwHOfWpV0XNhxTWgGLvz4HCcaHhPYhd8CTEE4Yecx5gR1C3AImSXN+P4kFdvN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745027955; c=relaxed/simple;
	bh=9n9HtjJv8+BJmPIFKBtxa5gCuPSM+N4P1U/vEDnhiSo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O882aEXmia1jiAj0hFU9bAYFAUnflKlVM5CKke4hKzHQnVnKgiZdp6CEbNsxDhtDw3qNmALdx7XhVAywk962yclHOlclmv1rfnbZV2PsQtHs0R3lUhd9ykyQ+HX8gEbdGS6jJGW41Ht04HVz7zkeCHGB1RsU7nMGn7hRwuj27ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqgSFJzz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745027950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MyE2GzEt6O7iPqkt2gvQatRQFTaplB3Bd3IRBQ3niCU=;
	b=BqgSFJzzwQhl8CT9dxhWYTMW3OwU5WbhLuvkBmjIKE/lKqjzg7ArrXIA4dBCtT07HFLzf1
	DWJiWi2mWP8ts2sybYt1J/6+4LRhe++jYYNDQ3qB3tVN+7f8iHivLAh3SSPbNHhNq3gz64
	GtyV+5HyMJFW5VGGCxFKnqJm+kc4vmc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-dQR8l8S0M8SoTz-0nfBC1g-1; Fri, 18 Apr 2025 21:59:07 -0400
X-MC-Unique: dQR8l8S0M8SoTz-0nfBC1g-1
X-Mimecast-MFC-AGG-ID: dQR8l8S0M8SoTz-0nfBC1g_1745027947
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c572339444so344844985a.3
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 18:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745027947; x=1745632747;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyE2GzEt6O7iPqkt2gvQatRQFTaplB3Bd3IRBQ3niCU=;
        b=DLRGivlJE3p204iihj9fuGLYVy+LhxS6bEZHm8liTyr05sFdE2qs3moDryC2sDDEsM
         DxldbjCRoguTpNHHZSWHCAiMeReuJF6s4ZyBGIlu6sarLy4XctyR5fW2fSuq9+dWs9dD
         26xO72LtzgXwRcMXjTAh8IYnWcCBgaoJ5ClADKgvCTuVQsPENNJcuqoHYR+MtEAicGWr
         WwcKGESt0jpzL9EB6b8DTIrf8I52yF4ot94RhUerO0IucAyHiz5QPkeRA9F69VcMn8fr
         kno0qwE3lVxFHTqDiPFB9uBQRFWBRQSTz2dCArOPh5UK1+Xl60GAFg6ywfPx6x3ElZHi
         6hiA==
X-Forwarded-Encrypted: i=1; AJvYcCUNkzeBWpKyDjxeXZAHQDccdCXvBNkzXJLqf5LH+z1dvjpy7CG+ELqBZE2vOhRtZAvRmfm5Fj3d@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuCg8nex+NVtGVH6bpkRB08CYVX/hjhalOL6n6L3BVxf8ajFb
	BRvDWisw/uUblm2JZNTs/e4kj1tZQF1PNn+cujGt0CjI1rvyWm5qa06+ZfSbR71HptlLA+/XodB
	t9p1rlOYRmBiGVqM70m7YtHS1BG9mAc3ZbHQh9emq4JgryjQ1M6HUCgo=
X-Gm-Gg: ASbGnctEvEDoiMbR+ktDeSgo5NT5juCJGdFwaM6d0vYEFVIfKkURsV+wY9BRJ6/eyFf
	qSjbvH7HaRXsYBU7Bzf6HzRy1sbQcFyNwnJUcrYhBL2fuQ/KCJCSWlQ3kXATx0c+Du1L0mnhp55
	3AQiHmMziYL6rDreqR+k/smem0PHq3K1Nap5yeQwQL24LcV6Ribh7TADBxPjgMFb1E8mPWLzVJX
	UpQGwcZSNCzdpVGlfNeyCz58LjHJugMo0yx8my8W9gTlPIMVBQxCklDEJddDb4h90wR4i6tPFNJ
	ZXq1oh0hCs8JOPmhijd5XRE1YlzolSauDzw6P3bN1HGL+8Oa5A==
X-Received: by 2002:a05:620a:2a12:b0:7c5:3b52:517d with SMTP id af79cd13be357-7c92804942dmr920493585a.54.1745027946868;
        Fri, 18 Apr 2025 18:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcXj4b/NM1OREe7QzWswzHIaHccrZVLgLJcaMbiSk/L6WwkHUEvx8kXDiJC2XmvPRO2v/pUg==
X-Received: by 2002:a05:620a:2a12:b0:7c5:3b52:517d with SMTP id af79cd13be357-7c92804942dmr920491585a.54.1745027946562;
        Fri, 18 Apr 2025 18:59:06 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6ea8dsm168807885a.9.2025.04.18.18.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 18:59:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9bcb139c-451b-4ea5-b4ff-21916372d94e@redhat.com>
Date: Fri, 18 Apr 2025 21:59:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpuset: rename cpuset_node_allowed to
 cpuset_current_node_allowed
To: Gregory Price <gourry@gourry.net>, cgroups@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org
References: <20250418031352.1277966-1-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250418031352.1277966-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 11:13 PM, Gregory Price wrote:
> Rename cpuset_node_allowed to reflect that the function checks the
> current task's cpuset.mems.  This allows us to make a new
> cpuset_node_allowed function that checks a target cgroup's cpuset.mems.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   include/linux/cpuset.h | 4 ++--
>   kernel/cgroup/cpuset.c | 4 ++--
>   mm/page_alloc.c        | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 835e7b793f6a..893a4c340d48 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -82,11 +82,11 @@ extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   void cpuset_init_current_mems_allowed(void);
>   int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>   
> -extern bool cpuset_node_allowed(int node, gfp_t gfp_mask);
> +extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
>   
>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>   {
> -	return cpuset_node_allowed(zone_to_nid(z), gfp_mask);
> +	return cpuset_current_node_allowed(zone_to_nid(z), gfp_mask);
>   }
>   
>   static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..d6ed3f053e62 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4090,7 +4090,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>   }
>   
>   /*
> - * cpuset_node_allowed - Can we allocate on a memory node?
> + * cpuset_current_node_allowed - Can current task allocate on a memory node?
>    * @node: is this an allowed node?
>    * @gfp_mask: memory allocation flags
>    *
> @@ -4129,7 +4129,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>    *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
>    *	GFP_USER     - only nodes in current tasks mems allowed ok.
>    */
> -bool cpuset_node_allowed(int node, gfp_t gfp_mask)
> +bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   {
>   	struct cpuset *cs;		/* current cpuset ancestors */
>   	bool allowed;			/* is allocation in zone z allowed? */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5079b1b04d49..233ce25f8f3d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3461,7 +3461,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>   retry:
>   	/*
>   	 * Scan zonelist, looking for a zone with enough free.
> -	 * See also cpuset_node_allowed() comment in kernel/cgroup/cpuset.c.
> +	 * See also cpuset_current_node_allowed() comment in kernel/cgroup/cpuset.c.
>   	 */
>   	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
>   	z = ac->preferred_zoneref;
> @@ -4148,7 +4148,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>   		/*
>   		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
>   		 * GFP_ATOMIC) rather than fail, see the comment for
> -		 * cpuset_node_allowed().
> +		 * cpuset_current_node_allowed().
>   		 */
>   		if (alloc_flags & ALLOC_MIN_RESERVE)
>   			alloc_flags &= ~ALLOC_CPUSET;
Acked-by: Waiman Long <longman@redhat.com>



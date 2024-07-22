Return-Path: <cgroups+bounces-3836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52930938A55
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7614A1C20257
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC1156257;
	Mon, 22 Jul 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oY1O8i41"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BE155CB3
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634373; cv=none; b=O2IOw/Tq8CYGCfJ2vFaBy7zJPHmypKvVbXjdyxx8pnwSJxWz6BVFWip65EMjwG0ZUsga8OoxC6eAuGBRpYh1wUQXQeU42mrjnRsZaGpVoqCS4wEkHJNn4tIp6ZWgIi4vGDC1gPrgb4Cnf1NjsckxfkPEAP1jwST+CH7j6QoAVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634373; c=relaxed/simple;
	bh=LDhKpDLrdI3N8cptvMB+KnFzM4gxNCTzU7kYnwSHj28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9S3w1BAQ6RhY2KflzAWNvZi8zJ746GccJ/qKMVodeNHQ6ICLNedN4XLteKwLo1Qu9d21ndnxIZt7Dtt1Wj5UkEizFzatdsS63Aj0V1OJgrs62u4wMEzd8gv+MsN456MyBNrhIDtvYobWOWXhcJD6IruTZuJRfbqJbZRNtdG/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oY1O8i41; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: songmuchun@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721634367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DvJeNnfExF7u6zH1jSiObdNgef3OT+XWYUKS2Aah9o=;
	b=oY1O8i41AG97/AXEIyP2bmkEgOb4d23jRBbKoixeX3ZsfdUOmZWzJInb9M1keqFnzmQLjh
	8E9jICrXZRLG3rY/hj1Wveq5c7iC2Lv2QB9VF7eY4udd+J/zw5qI3Ven3vuwpktBiLiPN+
	4PsIqlf36R67n8oQCy8/N4tzCCpBnBU=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <d30c7de3-65b5-4b5c-9046-4eed2c7d0b57@linux.dev>
Date: Mon, 22 Jul 2024 15:46:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kmem: add lockdep assertion to obj_cgroup_memcg
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240722070810.46016-1-songmuchun@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240722070810.46016-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/22 15:08, Muchun Song wrote:
> The obj_cgroup_memcg() is supposed to safe to prevent the returned
> memory cgroup from being freed only when the caller is holding the
> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> ignore thoes conditions when users call some upper APIs which call
> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> the link below). So it is better to add lockdep assertion to
> obj_cgroup_memcg() to find those issues ASAP.

Yeah, some users care about the lifetime of returned memcg, while
some other users maybe not.

Maybe a dumb question, can we just make objcg hold the refcount of
its pointed memcg? So the users of that objcg don't need to care
about the refcount of memcg? (We could switch the refcount from
old memcg to the new memcg when objcg switch memcg pointer, right?)

Thanks.

> 
> Because there is no user of obj_cgroup_memcg() holding objcg_lock
> to make the returned memory cgroup safe, do not add objcg_lock
> assertion (We should export objcg_lock if we really want to do)
> and leave a comment to indicate it is intentional.
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
> ---
>   include/linux/memcontrol.h | 22 +++++++++++++++++++---
>   mm/memcontrol.c            |  6 +++---
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fc94879db4dff..d616c50025098 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -360,11 +360,13 @@ static inline bool folio_memcg_kmem(struct folio *folio);
>    * After the initialization objcg->memcg is always pointing at
>    * a valid memcg, but can be atomically swapped to the parent memcg.
>    *
> - * The caller must ensure that the returned memcg won't be released:
> - * e.g. acquire the rcu_read_lock or css_set_lock.
> + * The caller must ensure that the returned memcg won't be released.
>    */
>   static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>   {
> +	WARN_ON_ONCE(!rcu_read_lock_held() &&
> +		  /* !lockdep_is_held(&objcg_lock) && */
> +		     !lockdep_is_held(&cgroup_mutex));
>   	return READ_ONCE(objcg->memcg);
>   }
>   
> @@ -438,6 +440,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>   	return __folio_memcg(folio);
>   }
>   
> +/*
> + * folio_memcg_charged - If a folio is charged to a memory cgroup.
> + * @folio: Pointer to the folio.
> + *
> + * Returns true if folio is charged to a memory cgroup, otherwise returns false.
> + */
> +static inline bool folio_memcg_charged(struct folio *folio)
> +{
> +	if (folio_memcg_kmem(folio))
> +		return __folio_objcg(folio) != NULL;
> +	return __folio_memcg(folio) != NULL;
> +}
> +
>   /**
>    * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>    * @folio: Pointer to the folio.
> @@ -454,7 +469,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>   	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
>   
>   	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> -	WARN_ON_ONCE(!rcu_read_lock_held());
>   
>   	if (memcg_data & MEMCG_DATA_KMEM) {
>   		struct obj_cgroup *objcg;
> @@ -463,6 +477,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>   		return obj_cgroup_memcg(objcg);
>   	}
>   
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
>   	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
>   }
>   
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 622d4544edd24..3da0284573857 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>   
>   static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>   {
> -	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
>   	/*
>   	 * Any of the following ensures page's memcg stability:
>   	 *
> @@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>   	struct uncharge_gather ug;
>   
>   	/* Don't touch folio->lru of any random page, pre-check: */
> -	if (!folio_memcg(folio))
> +	if (!folio_memcg_charged(folio))
>   		return;
>   
>   	uncharge_gather_clear(&ug);
> @@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>   		return;
>   
>   	/* Page cache replacement: new folio already charged? */
> -	if (folio_memcg(new))
> +	if (folio_memcg_charged(new))
>   		return;
>   
>   	memcg = folio_memcg(old);


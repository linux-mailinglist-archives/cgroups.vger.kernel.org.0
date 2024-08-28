Return-Path: <cgroups+bounces-4536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2197961C30
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7DF28235E
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3083CDA;
	Wed, 28 Aug 2024 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKjwqr+M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA0487BE
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812611; cv=none; b=XykFz2LrL8XHm2VS0vsfMFyAGe6oC5h1wvJN71XEnsikYypyFqoQdEJMTTdtvnuXtv6w751hEGF8DdDvrq9vQTWIjXVKspbjPTeL+iaH4XTLEPamEf94gVyIYUGT+bOrENEgEMxvuTnHBp//Ciw07JQat3UfZJ8+i05crHi4irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812611; c=relaxed/simple;
	bh=9KVtrDIkQrqhoaYoDfW1bZqVYvk8MaW3jm5v/WUJYY8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=phYrI0ROif9cWxzTSTl5Nq4sX6/h9cE4nE9y2nlHr2iYKttLcmEnhu222CZf5Qq5NH6/gBpMAkGejdGzwBXH0AFQ84+VvqWSQ2SblLOjwM+jQIS5fA0Bmi69zAwUmBJRIQ1ihYzRNAPMmzPJs+PE413nOIu9492gXkNI9t5Wpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKjwqr+M; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724812606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8P34oY8EX3iB+WHKFWcxCiPxWsH5mZsU2qtXZYBDx8=;
	b=YKjwqr+Ms2AzytPHOJSEy7hIUuE3z3kiC2SNH71agCNDB0qczG2rbXsaOUosiWH2XcN8gS
	I9g2bFPumA0+f+icndZTriMglTW6AY6PWXaBG/9DaxualYBzxxEeSC72Nhi74bDX5wvc93
	FaxJlji4d14otrl1zaw7d0LWgP6Sl+8=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v1] memcg: add charging of already allocated slab objects
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
Date: Wed, 28 Aug 2024 10:36:06 +0800
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org,
 netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA5F7851-B519-4570-B299-8A096A09D6E7@linux.dev>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
 <Zs1CuLa-SE88jRVx@google.com>
 <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 28, 2024, at 01:23, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> On Tue, Aug 27, 2024 at 03:06:32AM GMT, Roman Gushchin wrote:
>> On Mon, Aug 26, 2024 at 04:29:08PM -0700, Shakeel Butt wrote:
>>> At the moment, the slab objects are charged to the memcg at the
>>> allocation time. However there are cases where slab objects are
>>> allocated at the time where the right target memcg to charge it to =
is
>>> not known. One such case is the network sockets for the incoming
>>> connection which are allocated in the softirq context.
>>>=20
>>> Couple hundred thousand connections are very normal on large loaded
>>> server and almost all of those sockets underlying those connections =
get
>>> allocated in the softirq context and thus not charged to any memcg.
>>> However later at the accept() time we know the right target memcg to
>>> charge. Let's add new API to charge already allocated objects, so we =
can
>>> have better accounting of the memory usage.
>>>=20
>>> To measure the performance impact of this change, tcp_crr is used =
from
>>> the neper [1] performance suite. Basically it is a network ping pong
>>> test with new connection for each ping pong.
>>>=20
>>> The server and the client are run inside 3 level of cgroup hierarchy
>>> using the following commands:
>>>=20
>>> Server:
>>> $ tcp_crr -6
>>>=20
>>> Client:
>>> $ tcp_crr -6 -c -H ${server_ip}
>>>=20
>>> If the client and server run on different machines with 50 GBPS NIC,
>>> there is no visible impact of the change.
>>>=20
>>> For the same machine experiment with v6.11-rc5 as base.
>>>=20
>>>         base (throughput)     with-patch
>>> tcp_crr   14545 (+- 80)         14463 (+- 56)
>>>=20
>>> It seems like the performance impact is within the noise.
>>>=20
>>> Link: https://github.com/google/neper [1]
>>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>>=20
>> Hi Shakeel,
>>=20
>> I like the idea and performance numbers look good. However some =
comments on
>> the implementation:
>>=20
>=20
> Thanks for taking a look.
>=20
>>> ---
>>>=20
>>> Changes since the RFC:
>>> - Added check for already charged slab objects.
>>> - Added performance results from neper's tcp_crr
>>>=20
>>> include/linux/slab.h            |  1 +
>>> mm/slub.c                       | 54 =
+++++++++++++++++++++++++++++++++
>>> net/ipv4/inet_connection_sock.c |  5 +--
>>> 3 files changed, 58 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>> index eb2bf4629157..05cfab107c72 100644
>>> --- a/include/linux/slab.h
>>> +++ b/include/linux/slab.h
>>> @@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct =
kmem_cache *s, struct list_lru *lru,
>>>    gfp_t gfpflags) __assume_slab_alignment __malloc;
>>> #define kmem_cache_alloc_lru(...) =
alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
>>>=20
>>> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>>> void kmem_cache_free(struct kmem_cache *s, void *objp);
>>>=20
>>> kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t =
flags,
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index c9d8a2497fd6..580683597b5c 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2185,6 +2185,16 @@ void memcg_slab_free_hook(struct kmem_cache =
*s, struct slab *slab, void **p,
>>>=20
>>> __memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>>> }
>>> +
>>> +static __fastpath_inline
>>> +bool memcg_slab_post_charge(struct kmem_cache *s, void *p, gfp_t =
flags)
>>> +{
>>> + if (likely(!memcg_kmem_online()))
>>> + return true;
>>=20
>> We do have this check in kmem_cache_charge(), why do we need to check =
it again?
>>=20
>=20
> I missed to remove this one. I am going to rearrange the code bit more
> in these functions to avoid the build errors in non MEMCG builds.
>=20
>>> +
>>> + return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
>>> +}
>>> +
>>> #else /* CONFIG_MEMCG */
>>> static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
>>>      struct list_lru *lru,
>>> @@ -2198,6 +2208,13 @@ static inline void =
memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>>> void **p, int objects)
>>> {
>>> }
>>> +
>>> +static inline bool memcg_slab_post_charge(struct kmem_cache *s,
>>> +   void *p,
>>> +   gfp_t flags)
>>> +{
>>> + return true;
>>> +}
>>> #endif /* CONFIG_MEMCG */
>>>=20
>>> /*
>>> @@ -4062,6 +4079,43 @@ void *kmem_cache_alloc_lru_noprof(struct =
kmem_cache *s, struct list_lru *lru,
>>> }
>>> EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
>>>=20
>>> +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
>>> +       SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
>>> +
>>> +bool kmem_cache_charge(void *objp, gfp_t gfpflags)
>>> +{
>>> + struct slabobj_ext *slab_exts;
>>> + struct kmem_cache *s;
>>> + struct folio *folio;
>>> + struct slab *slab;
>>> + unsigned long off;
>>> +
>>> + if (!memcg_kmem_online())
>>> + return true;
>>> +
>>> + folio =3D virt_to_folio(objp);
>>> + if (unlikely(!folio_test_slab(folio)))
>>> + return false;
>>=20
>> Does it handle the case of a too-big-to-be-a-slab-object allocation?
>> I think it's better to handle it properly. Also, why return false =
here?
>>=20
>=20
> Yes I will fix the too-big-to-be-a-slab-object allocations. I presume =
I
> should just follow the kfree() hanlding on !folio_test_slab() i.e. =
that
> the given object is the large or too-big-to-be-a-slab-object.

Hi Shakeel,

If we decide to do this, I suppose you will use memcg_kmem_charge_page
to charge big-object. To be consistent, I suggest renaming =
kmem_cache_charge
to memcg_kmem_charge to handle both slab object and big-object. And I =
saw
all the functions related to object charging is moved to memcontrol.c =
(e.g.
__memcg_slab_post_alloc_hook), so maybe we should also do this for
memcg_kmem_charge?

Muhcun,
Thanks.=


Return-Path: <cgroups+bounces-4602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAD96575D
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C501F24F9F
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 06:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1E14D44F;
	Fri, 30 Aug 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wigjlgn+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB753389
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998242; cv=none; b=Pu7gl5HSOjZa8r7gUfhrZHawPY6w+kmQHA6Sw/k+iR3+fia3OLYhOgFVjDVu7KXmGeh2IgSsc2ESGgKPRfvCqPmFI1h7dybZY4+sVCJh1jeTI8BpNKDpDSVxbekJXkYrXJkH1cFMt+tb8fv1cEI6XqbFK4LaNdOk7jAdLjd8uIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998242; c=relaxed/simple;
	bh=nkHJbeEg0+QEjgdCbTpKvNB45+hmK9J6uhHUFwVHosU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bSFJ2RXz8PKFexgDBYBnYwtxcetX+1mUcLkxrixkOXZGyRWrLLqb+S+MmHmQuQw/kb2C/glId8GhC2LEHLEzx/AFGekSVwbYsKpqqDVgnBYt5rCm5BIQBTn+ihjTEdp244Advpr7/qvqtJRl+7B82hmKntRn/ywLrMBU4HK6K08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wigjlgn+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724998239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkHJbeEg0+QEjgdCbTpKvNB45+hmK9J6uhHUFwVHosU=;
	b=Wigjlgn+sIZ3NIO96mtgt0axwGAJBzKGSc1KMvciFjPOCGlYdCNu5D48n351f/f7R7IK5S
	4xp05lYeArtrcngFl+gGUYx7YKrPOMOUPi0fGuzMKMRM7eIPyBsxEMxsffQQm5bZ2QJIu3
	XSPiLgY/5PlPdxI00yzLKHgZfuUGY2E=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v1] memcg: add charging of already allocated slab objects
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <nt5zhccndtrj2pyyjm6wkah4iizzijdamaqce24t7nqioy4c5y@3vtipktwtzkn>
Date: Fri, 30 Aug 2024 14:09:57 +0800
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
Message-Id: <6088647D-147A-4704-BBA1-8CEDEDAE2885@linux.dev>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
 <Zs1CuLa-SE88jRVx@google.com>
 <yiyx4fh6dklqpexfstkzp3gf23hjpbjujci2o6gs7nb4sutzvb@b5korjrjio3m>
 <EA5F7851-B519-4570-B299-8A096A09D6E7@linux.dev>
 <a5rzw7uuf7pgrhhut7keoy66c6u4rgiuxx2qmwywbvl2iktfku@23dzxczejcet>
 <97F404E9-C3C2-4BD2-9539-C40237E71B2B@linux.dev>
 <nt5zhccndtrj2pyyjm6wkah4iizzijdamaqce24t7nqioy4c5y@3vtipktwtzkn>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 29, 2024, at 23:49, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> On Thu, Aug 29, 2024 at 10:36:01AM GMT, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 29, 2024, at 03:03, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>>>=20
>>> Hi Muchun,
>>>=20
>>> On Wed, Aug 28, 2024 at 10:36:06AM GMT, Muchun Song wrote:
>>>>=20
>>>>=20
>>>>> On Aug 28, 2024, at 01:23, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>>>>>=20
>>> [...]
>>>>>>=20
>>>>>> Does it handle the case of a too-big-to-be-a-slab-object =
allocation?
>>>>>> I think it's better to handle it properly. Also, why return false =
here?
>>>>>>=20
>>>>>=20
>>>>> Yes I will fix the too-big-to-be-a-slab-object allocations. I =
presume I
>>>>> should just follow the kfree() hanlding on !folio_test_slab() i.e. =
that
>>>>> the given object is the large or too-big-to-be-a-slab-object.
>>>>=20
>>>> Hi Shakeel,
>>>>=20
>>>> If we decide to do this, I suppose you will use =
memcg_kmem_charge_page
>>>> to charge big-object. To be consistent, I suggest renaming =
kmem_cache_charge
>>>> to memcg_kmem_charge to handle both slab object and big-object. And =
I saw
>>>> all the functions related to object charging is moved to =
memcontrol.c (e.g.
>>>> __memcg_slab_post_alloc_hook), so maybe we should also do this for
>>>> memcg_kmem_charge?
>>>>=20
>>>=20
>>> If I understand you correctly, you are suggesting to handle the =
general
>>> kmem charging and slab's large kmalloc (size > =
KMALLOC_MAX_CACHE_SIZE)
>>> together with memcg_kmem_charge(). However that is not possible due =
to
>>> slab path updating NR_SLAB_UNRECLAIMABLE_B stats while no updates =
for
>>> this stat in the general kmem charging path =
(__memcg_kmem_charge_page in
>>> page allocation code path).
>>>=20
>>> Also this general kmem charging path is used by many other users =
like
>>> vmalloc, kernel stack and thus we can not just plainly stuck updates =
to
>>> NR_SLAB_UNRECLAIMABLE_B in that path.
>>=20
>> Sorry, maybe I am not clear . To make sure we are on the same page, =
let
>> me clarify my thought. In your v2, I thought if we can rename
>> kmem_cache_charge() to memcg_kmem_charge() since kmem_cache_charge()
>> already has handled both big-slab-object (size > =
KMALLOC_MAX_CACHE_SIZE)
>> and small-slab-object cases. You know, we have a function of
>> memcg_kmem_charge_page() which could be used for charging =
big-slab-object
>> but not small-slab-object. So I thought maybe memcg_kmem_charge() is =
a
>> good name for it to handle both cases. And if we do this, how about =
moving
>> this new function to memcontrol.c since all memcg charging functions =
are
>> moved to memcontrol.c instead of slub.c.
>>=20
>=20
> Oh you want the core function to be in memcontrol.c. I don't have any
> strong opinion where the code should exist but I do want the interface
> to still be kmem_cache_charge() because that is what we are providing =
to
> the users which charging slab objects. Yes some of those might be
> big-slab-objects but that is transparent to the users.
>=20
> Anyways, for now I will go with my current approach but on the =
followup
> will explore and discuss with you on which code should exist in which
> file. I hope that is acceptable to you.

Fine. No problem.

Thanks.

>=20
> thanks,
> Shakeel




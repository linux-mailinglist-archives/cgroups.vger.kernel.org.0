Return-Path: <cgroups+bounces-13169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124DD1CCC2
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5571B3008EBF
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1452D359712;
	Wed, 14 Jan 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/7FT5Lk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAE3502BF
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375220; cv=none; b=uvGG93o3XtDe8Adrqidlt245kQ/SPOb62UgFrVy3zaltUhHSa1i0U0DtsC+c8ww7tgGEODMuEpHSArokuFOVmyivAysd0i66mSjx5UCde0id4D1QAmGSFNNbmlc+JFsl4pek+QN1T0Sim/g+u3jgoau8gG/Qf2OawL3BCRKgHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375220; c=relaxed/simple;
	bh=NDTG66GhCGm989GVOep7bEj1PIw65VfHHrqHcVitZw8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N7vCNnXl2MkJyUYnp4CGhZltx7MC8W1ZT/VrDBl+F//izEUJlqOqvcGlU/AS5t0Tnd21PaNTxO/recxsriugSjpK14yyuDRylexLBpXN02pFUrUmOdK1Vlv70iKO0IqQrlWhAvbTfk8zgnFyG34uAwsmz+E9Iq4fMTz5D6xvxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/7FT5Lk; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768375209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZhuQ4Kj6PEI3Wh95q/aQ/X7uFCtTD8uLx3UOMlw/Og=;
	b=M/7FT5LkHJfTtlvj1MpmkPypLWsVSfMh7dQpCKJjFQQakzEied/8pKbIeQ/Bpy1ujuzlwv
	JCdzG8dWTDZ+rGCkA0WZDuhKEk5JxI2WzjjYtOJYW8ZqXXQzTDpqPu7pZ5IrygKsLN0ELm
	4vz+i99TpW10TuJoCzUWRN9bF8ROlt4=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v6 4/4] mm: thp: reparent the split queue during memcg
 offline
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <3d8dd14c-d3a7-4cae-99e3-10ebe4ad52aa@linux.dev>
Date: Wed, 14 Jan 2026 15:19:25 +0800
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Chris Mason <clm@meta.com>,
 hannes@cmpxchg.org,
 hughd@google.com,
 mhocko@suse.com,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 david@redhat.com,
 lorenzo.stoakes@oracle.com,
 ziy@nvidia.com,
 baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com,
 npache@redhat.com,
 ryan.roberts@arm.com,
 dev.jain@arm.com,
 baohua@kernel.org,
 lance.yang@linux.dev,
 akpm@linux-foundation.org,
 richard.weiyang@gmail.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5A78F53-47F6-4A98-AB66-0CBD3D8B10B4@linux.dev>
References: <8703f907c4d1f7e8a2ef2bfed3036a84fa53028b.1762762324.git.zhengqi.arch@bytedance.com>
 <20260113220046.2274684-1-clm@meta.com> <aWcrVRT_RjxdjoN7@hyeyoo>
 <3d8dd14c-d3a7-4cae-99e3-10ebe4ad52aa@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 14, 2026, at 14:25, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
>=20
>=20
> On 1/14/26 1:36 PM, Harry Yoo wrote:
>> On Tue, Jan 13, 2026 at 02:00:43PM -0800, Chris Mason wrote:
>>> On Mon, 10 Nov 2025 16:17:58 +0800 Qi Zheng <qi.zheng@linux.dev> =
wrote:
>>>=20
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>=20
>>>> Similar to list_lru, the split queue is relatively independent and =
does
>>>> not need to be reparented along with objcg and LRU folios (holding
>>>> objcg lock and lru lock). So let's apply the similar mechanism as =
list_lru
>>>> to reparent the split queue separately when memcg is offine.
>>>>=20
>>>=20
>>> Hi everyone,
>>>=20
>>> I'm running all of the MM commits since v6.18 through the AI patch =
review
>>> tools, and this one was flagged.  I'm much less confident in this =
report,
>>> AI tends to get these races wrong:
>>>=20
>>> [AI review output]
>>>=20
>>>> diff --git a/include/linux/memcontrol.h =
b/include/linux/memcontrol.h
>>>> index b0c6a4635c67b..cc6db20d7dca0 100644
>>>> --- a/include/linux/memcontrol.h
>>>> +++ b/include/linux/memcontrol.h
>>>> @@ -1775,6 +1775,12 @@ static inline void count_objcg_events(struct =
obj_cgroup *objcg,
>>>>  bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
>>>>=20
>>>>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
>>>> +
>>>> +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>>>> +{
>>>> + return memcg ? css_is_dying(&memcg->css) : false;
>>>> +}
>>>=20
>>> [ ... ]
>>>=20
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 13684e5376e82..d17d3810a882c 100644
>>>=20
>>> [ ... ]
>>>=20
>>>> @@ -1129,8 +1140,14 @@ split_queue_lock_irqsave(int nid, struct =
mem_cgroup *memcg, unsigned long *flags
>>>>  {
>>>>   struct deferred_split *queue;
>>>>=20
>>>> +retry:
>>>>   queue =3D memcg_split_queue(nid, memcg);
>>>>   spin_lock_irqsave(&queue->split_queue_lock, *flags);
>>>> + if (unlikely(memcg_is_dying(memcg))) {
>>>> + spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
>>>> + memcg =3D parent_mem_cgroup(memcg);
>>>> + goto retry;
>>>> + }
>>>>=20
>>>>   return queue;
>>>>  }
>>>=20
>>> There appears to be a race window that can cause split_queue_len =
counter
>>> mismatch. Between the time CSS_DYING is set (in kill_css()) and when
>>> reparent_deferred_split_queue() actually runs (asynchronously in
>>> css_offline), folios can be unqueued via =
__folio_unqueue_deferred_split().
>>>=20
>>> In this scenario:
>>>   __folio_unqueue_deferred_split()
>>>     -> folio_split_queue_lock_irqsave()
>>>        -> split_queue_lock_irqsave() sees memcg_is_dying() =3D=3D =
true
>>>        -> returns parent's queue (locked)
>>>     -> ds_queue->split_queue_len-- decrements parent's counter
>>>     -> list_del_init() removes folio from child's list
>>>=20
>>> The folio is correctly removed from the child's list (list_del_init =
is
>>> self-referential), but the wrong queue's counter is decremented.
>> Good point. Sounds pretty possible to me?
>> I don't think there's anything that prevents it from unqueued
>> before it's reparented.
>>> If the parent queue was empty (split_queue_len =3D=3D 0), this would =
cause an
>>> unsigned long underflow to ULONG_MAX.
>> Although the accounting mismatch will only persist until
>> reparent_deferred_split_queue() reparents the deferred split queue.
>=20
> This period is very short, and the only thing affected should be
> deferred_split_count(), but it does not cause a system error.
>=20
> So I think maybe we can leave it unrepaired.

I didn=E2=80=99t look closely at the specific issue, but based on Qi=E2=80=
=99s point,
we can actually take a cue from list_lru_count_one and provide a similar
workaround to keep deferred_split_count from returning an enormous
value=E2=80=94see commit 41d17431df4aa.

>=20
>> Ideally this should be fixed by checking if the folio has been
>> reparented after acquiring the split queue lock, but since we don't =
reparent
>> LRU pages yet ... do we need a band-aid before then?
>> Do we want to have is_dying property in the split queue as it was in =
v2? [1]
>> [1] =
https://lore.kernel.org/linux-mm/55370bda7b2df617033ac12116c1712144bb7591.=
1758618527.git.zhengqi.arch@bytedance.com
>>> Could this be addressed by checking that the folio is actually in =
the
>>> queue being unlocked, perhaps by verifying the list head matches =
before
>>> decrementing split_queue_len?
>>> [ ... ]
>>>=20
>>>> @@ -3920,6 +3920,7 @@ static void mem_cgroup_css_offline(struct =
cgroup_subsys_state *css)
>>>>   zswap_memcg_offline_cleanup(memcg);
>>>>=20
>>>>   memcg_offline_kmem(memcg);
>>>> + reparent_deferred_split_queue(memcg);
>>>=20
>>> The race window exists because CSS_DYING is set in kill_css() before
>>> css_offline() callbacks run asynchronously. The comment in =
split_queue_lock
>>> mentions that THPs will be "hidden from the shrinker side" during =
this
>>> period, but does not address the counter accounting issue when =
folios
>>> are unqueued.
>=20



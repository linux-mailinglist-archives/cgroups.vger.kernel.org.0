Return-Path: <cgroups+bounces-9707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4BB43FE1
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967CD5A4CBC
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB23043DC;
	Thu,  4 Sep 2025 15:02:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AF1EB9F2;
	Thu,  4 Sep 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998144; cv=none; b=G9euYVaz5O7Q7ZVUc0103WYQ7mCLIAbUJHEFDiBgf8J24CXE9zXPT9Zy3Ho3sBfY4EoNj2OzOrVL/tBMRjcuF70Aiz4i7I9/MAG93eIjjDridTloeHVre+0+D1RLGGooHY1Cc93FGOo0KuCF1krSKFdRs0ReS7FSB78b4HRY9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998144; c=relaxed/simple;
	bh=qFfIkT+IHDZ8fnDNUiRdAyOuIIVzoZKpkNFhTj3neu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roSYENAmc5+dDR3fHPpr0+qu+P+ldDCYz84E5tioM8CrZ2h44dkRlqeobvoZxir0B+4wLpU8JpOLm2Xe01rB2GTBJYvNX7pqo37TnRQDNjPj83QybPJ4TigC9oIA+8F66calPnI9kY+C5HSA7TaHGcgMOSHhBDZFGwMELnrP2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <740924f6-e241-428d-beaa-630cad8c3e05@lankhorst.se>
Date: Thu, 4 Sep 2025 17:02:11 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?=27Michal_Koutn=C3=BD=27?=
 <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20250819114932.597600-5-dev@lankhorst.se>
 <dc21e54c-d7ae-4d7e-9acb-6a3fa573b20f@redhat.com>
 <9c296c72-768e-4893-a099-a2882027f2b9@lankhorst.se>
 <b6b13ad22345bcdf43325173052614c17e803d00.camel@linux.intel.com>
 <776629b2-5459-4fa0-803e-23d4824e7b24@redhat.com>
 <da5885a94d89a2c0dece04e09182e832e8e40410.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <da5885a94d89a2c0dece04e09182e832e8e40410.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2025-09-02 kl. 15:42, skrev Thomas Hellström:
> On Mon, 2025-09-01 at 20:38 +0200, David Hildenbrand wrote:
>> On 01.09.25 20:21, Thomas Hellström wrote:
>>> Hi,
>>>
>>> On Mon, 2025-09-01 at 20:16 +0200, Maarten Lankhorst wrote:
>>>> Hello David,
>>>>
>>>> Den 2025-09-01 kl. 14:25, skrev David Hildenbrand:
>>>>> On 19.08.25 13:49, Maarten Lankhorst wrote:
>>>>>> When exporting dma-bufs to other devices, even when it is
>>>>>> allowed
>>>>>> to use
>>>>>> move_notify in some drivers, performance will degrade
>>>>>> severely
>>>>>> when
>>>>>> eviction happens.
>>>>>>
>>>>>> A perticular example where this can happen is in a multi-card
>>>>>> setup,
>>>>>> where PCI-E peer-to-peer is used to prevent using access to
>>>>>> system memory.
>>>>>>
>>>>>> If the buffer is evicted to system memory, not only the
>>>>>> evicting
>>>>>> GPU wher
>>>>>> the buffer resided is affected, but it will also stall the
>>>>>> GPU
>>>>>> that is
>>>>>> waiting on the buffer.
>>>>>>
>>>>>> It also makes sense for long running jobs not to be preempted
>>>>>> by
>>>>>> having
>>>>>> its buffers evicted, so it will make sense to have the
>>>>>> ability to
>>>>>> pin
>>>>>> from system memory too.
>>>>>>
>>>>>> This is dependant on patches by Dave Airlie, so it's not part
>>>>>> of
>>>>>> this
>>>>>> series yet. But I'm planning on extending pinning to the
>>>>>> memory
>>>>>> cgroup
>>>>>> controller in the future to handle this case.
>>>>>>
>>>>>> Implementation details:
>>>>>>
>>>>>> For each cgroup up until the root cgroup, the 'min' limit is
>>>>>> checked
>>>>>> against currently effectively pinned value. If the value will
>>>>>> go
>>>>>> above
>>>>>> 'min', the pinning attempt is rejected.
>>>>>>
>>>>>> Pinned memory is handled slightly different and affects
>>>>>> calculating
>>>>>> effective min/low values. Pinned memory is subtracted from
>>>>>> both,
>>>>>> and needs to be added afterwards when calculating.
>>>>>
>>>>> The term "pinning" is overloaded, and frequently we refer to
>>>>> pin_user_pages() and friends.
>>>>>
>>>>> So I'm wondering if there is an alternative term to describe
>>>>> what
>>>>> you want to achieve.
>>>>>
>>>>> Is it something like "unevictable" ?
>>>> It could be required to include a call pin_user_pages(), in case
>>>> a
>>
>> We'll only care about long-term pinnings (i.e., FOLL_LONGTERM).
>> Ordinary 
>> short-term pinning is just fine.
>>
>> (see how even "pinning" is overloaded? :) )
>>
>>>> process wants to pin
>>>> from a user's address space to the gpu.
>>>>
>>>> It's not done yet, but it wouldn't surprise me if we want to
>>>> include
>>>> it in the future.
>>>> Functionally it's similar to mlock() and related functions.
>>
>> Traditionally, vfio, io_uring and rdma do exactly that: they use GUP
>> to 
>> longterm pin and then account that memory towards RLIMIT_MEMLOCK.
>>
>> If you grep for "rlimit(RLIMIT_MEMLOCK)", you'll see what I mean.
>>
>> There are known issues with that: imagine long-term pinning the same 
>> folio through GUP with 2 interfaces (e.g., vfio, io_uring, rdma), or 
>> within the same interface.
>>
>> You'd account the memory multiple times, which is horrible. And so
>> far 
>> there is no easy way out.
>>
>>>>
>>>> Perhaps call it mlocked instead?
>>>
>>> I was under the impression that mlocked() memory can be migrated to
>>> other physical memory but not to swap? whereas pinned memory needs
>>> to
>>> remain the exact same physical memory.
>>
>> Yes, exactly.
>>
>>>
>>> IMO "pinned" is pretty established within GPU drivers (dma-buf,
>>> TTM)
>>> and essentially means the same as "pin" in "pin_user_pages", so
>>> inventing a new name would probably cause even more confusion?
>>
>> If it's the same thing, absolutely. But Marteen said "It's not done
>> yet, 
>> but it wouldn't surprise me if we want to include it in the future".
>>
>> So how is the memory we are talking about in this series "pinned" ?
> 
> Reading the cover-letter from Maarten, he only talks about pinning
> affecting performance, which would be similar to user-space calling
> mlock(), although I doubt that moving content to other physical pages
> within the same memory type will be a near-term use-case.
> 
> However what's more important are situation where a device (like RDMA)
> needs to pin, because it can't handle the case where access is
> interrupted and content transferred to another physical location.
> 
> Perhaps Maarten could you elaborate whether this series is intended for
> both these use-cases?
Yeah, this is definitely for the latter case too.

It's a performance optimization for the generic case, and very nice
to have for the second case, to prevent unlimited vram pinning.
With cgroups, we would be able to limit the amounts of used memory there.

Kind regards,
~Maarten


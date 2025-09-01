Return-Path: <cgroups+bounces-9580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A2BB3EDB2
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A207AC288
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303730F923;
	Mon,  1 Sep 2025 18:16:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CB239E63;
	Mon,  1 Sep 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750614; cv=none; b=aJvtKkjL5sNXg5vZ501400V8hszQCWUAXkOSoXpY64F1vmCBefoj8Apu/ZQwAVGfW6I0yNMZCS5KrCeCQhJz8tEuYPcbi/9NSzYDdXr9EmuKGVCDkGCz5PVPVF8HYOfezQ/r0XHFAz5EMS/2Ez+g96nRCxV1M9nvtoa6u1SG8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750614; c=relaxed/simple;
	bh=Eh1zldRmbeNzX3SovhN21eadq9oHnHFN9RyWfqu++Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFBzWtdbUkuQigODEqM/7lsbqvgohWlmOwrv7daP6kwfFVjXDLviclgFwfyihLfkrnt0TVjh+nj69e+e8GUeDOZ+C/R4E+VV+wVHkCq964ciuDMsZHQRdbgVsizS0nPHeyfSPDVHsEOHjTbUycRtsZr9znAmjXhgakVzPbHjweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <9c296c72-768e-4893-a099-a2882027f2b9@lankhorst.se>
Date: Mon, 1 Sep 2025 20:16:40 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
To: David Hildenbrand <david@redhat.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?=27Thomas_Hellstr=C3=B6m=27?= <thomas.hellstrom@linux.intel.com>,
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
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <dc21e54c-d7ae-4d7e-9acb-6a3fa573b20f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello David,

Den 2025-09-01 kl. 14:25, skrev David Hildenbrand:
> On 19.08.25 13:49, Maarten Lankhorst wrote:
>> When exporting dma-bufs to other devices, even when it is allowed to use
>> move_notify in some drivers, performance will degrade severely when
>> eviction happens.
>>
>> A perticular example where this can happen is in a multi-card setup,
>> where PCI-E peer-to-peer is used to prevent using access to system memory.
>>
>> If the buffer is evicted to system memory, not only the evicting GPU wher
>> the buffer resided is affected, but it will also stall the GPU that is
>> waiting on the buffer.
>>
>> It also makes sense for long running jobs not to be preempted by having
>> its buffers evicted, so it will make sense to have the ability to pin
>> from system memory too.
>>
>> This is dependant on patches by Dave Airlie, so it's not part of this
>> series yet. But I'm planning on extending pinning to the memory cgroup
>> controller in the future to handle this case.
>>
>> Implementation details:
>>
>> For each cgroup up until the root cgroup, the 'min' limit is checked
>> against currently effectively pinned value. If the value will go above
>> 'min', the pinning attempt is rejected.
>>
>> Pinned memory is handled slightly different and affects calculating
>> effective min/low values. Pinned memory is subtracted from both,
>> and needs to be added afterwards when calculating.
> 
> The term "pinning" is overloaded, and frequently we refer to pin_user_pages() and friends.
> 
> So I'm wondering if there is an alternative term to describe what you want to achieve.
> 
> Is it something like "unevictable" ?
It could be required to include a call pin_user_pages(), in case a process wants to pin 
from a user's address space to the gpu.

It's not done yet, but it wouldn't surprise me if we want to include it in the future.
Functionally it's similar to mlock() and related functions.

Perhaps call it mlocked instead?

Kind regards,
~Maarten Lankhorst


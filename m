Return-Path: <cgroups+bounces-9582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3BB3EDC8
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D35208077
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6146324B0D;
	Mon,  1 Sep 2025 18:22:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D713D8A4;
	Mon,  1 Sep 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750934; cv=none; b=s0PG3UZ7pdJUvFggFg0bmycjPoPug+5qteDVb8Dvdc4MWtS4HYvdycOEEKLjwKVEvku2qyqU8wmQc0Dq0tsigZiiM6hLTEV8Bvta7T/lHskZBRPs49PLpmjjjFpMs22+ucJtOil9dAHpgn8p45DHdLOzH771oZy0rIm96+l8cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750934; c=relaxed/simple;
	bh=Dif9nTEXUhWJH66uOwpP6ag9nFFL0TtqhTtlAZYlHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTFobeioIqT0b37utNmt1sBtSGPXnyreQQC3lZJ4Vx3ckIIrFZDAPLkclCUpOF/vzEDXvVpDQiGFXXBP+QvWsZa973Ch2uVOa5wGe4jM6orTMXakiGNTzuggsmUAP/Ori/Jo6Xbmr2+/XPdFSZRtg4jfHoB90He15NL9rh7fXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Message-ID: <0d8199c3-8c3f-4838-81dd-ad191cb7afc1@lankhorst.se>
Date: Mon, 1 Sep 2025 20:22:08 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
To: Natalie Vock <natalie.vock@gmx.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?=27Thomas_Hellstr=C3=B6m=27?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?=27Michal_Koutn=C3=BD=27?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20250819114932.597600-5-dev@lankhorst.se>
 <25b42c8e-7233-4121-b253-e044e022b327@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <25b42c8e-7233-4121-b253-e044e022b327@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Nathalie,

Den 2025-09-01 kl. 14:45, skrev Natalie Vock:
> Hi,
> 
> On 8/19/25 13:49, Maarten Lankhorst wrote:
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
> 
> Why do you want to reject pins in this case? What happens in desktop usecases (e.g. PRIME buffer sharing)? AFAIU, you kind of need to be able to pin buffers and export them to other devices for that whole thing to work, right? If the user doesn't explicitly set a min value, wouldn't the value being zero mean any pins will be rejected (and thus PRIME would break)?
> 
> If your objective is to prevent pinned buffers from being evicted, perhaps you could instead make TTM try to avoid evicting pinned buffers and prefer unpinned buffers as long as there are unpinned buffers to evict? As long as the total amount of pinned memory stays below min, no pinned buffers should get evicted with that either.
That would be setting an eviction priority, that can be done but that gives no guarantee memory will not be evicted.

Kind regards,
~Maarten


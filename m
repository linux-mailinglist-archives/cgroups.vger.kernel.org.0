Return-Path: <cgroups+bounces-5940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730A39F4DB5
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D47163131
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD71F4E49;
	Tue, 17 Dec 2024 14:29:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504F61FF2;
	Tue, 17 Dec 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445742; cv=none; b=TOpIxZIS52xrdibqmqpdJw/4o1sXND6qBiGoSPDQ3Me1Od7JyxfU/d1LiNi5q/cqJd7YIyGV9ajVwMvhA49bwBzdqBwmiHCDJaLB5qjEy6JwK2ZuEccBeTHWZulme15my3qujhCEXFW4a57kQsZPvkS3HympvfiUp1qXh9NOtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445742; c=relaxed/simple;
	bh=H8atj59mU3BGOUZknvtJG3k4fp+kooCZkwZj8ZpmTMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os3H35L1TgFxUwM5bsvVE8x8AVhjqwN2qOIryb6WBbu/rsPicbP0y13AmdZ3W8fGCT4UP7cYAPzyBD4Vksav+rbW3PQJnACaLFSbbfsWfhSFFHEqhosv4/sTGeE/e/qI8daBEZLDOn7Gb2EmDmef7LB2ilJ/d3pCq8cVHjqR2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
Date: Tue, 17 Dec 2024 15:28:50 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20241217-meek-bullfinch-of-luck-2c3468@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

Now that all patches look good, what is needed to merge the series? 
Without patch 6/7 as it is a hack for testing.

I've also posted a IGT for verifying read/write works (rule out 
copy/paste errors) and min, max semantics work as intended.

https://lists.freedesktop.org/archives/igt-dev/2024-December/083345.html

Cheers,
~Maarten


Den 2024-12-17 kl. 08:46, skrev Maxime Ripard:
> On Fri, Dec 13, 2024 at 05:06:05PM +0100, Maarten Lankhorst wrote:
>> Hey,
>>
>> Den 2024-12-13 kl. 16:21, skrev Maxime Ripard:
>>> On Fri, Dec 13, 2024 at 03:53:13PM +0100, Maarten Lankhorst wrote:
>>>>
>>>>
>>>> Den 2024-12-13 kl. 14:03, skrev Maxime Ripard:
>>>>> Hi,l
>>>>>
>>>>> Thanks for the new update!
>>>>>
>>>>> On Wed, Dec 04, 2024 at 02:44:00PM +0100, Maarten Lankhorst wrote:
>>>>>> New update. Instead of calling it the 'dev' cgroup, it's now the
>>>>>> 'dmem' cgroup.
>>>>>>
>>>>>> Because it only deals with memory regions, the UAPI has been updated
>>>>>> to use dmem.min/low/max/current, and to make the API cleaner, the
>>>>>> names are changed too.
>>>>>
>>>>> The API is much nicer, and fits much better into other frameworks too.
>>>>>
>>>>>> dmem.current could contain a line like:
>>>>>> "drm/0000:03:00.0/vram0 1073741824"
>>>>>>
>>>>>> But I think using "drm/card0/vram0" instead of PCIID would perhaps be
>>>>>> good too. I'm open to changing it to that based on feedback.
>>>>>
>>>>> Do we have any sort of guarantee over the name card0 being stable across
>>>>> reboots?
>>>>>
>>>>> I also wonder if we should have a "total" device that limits the amount
>>>>> of memory we can allocate from any region?
>>>>
>>>> I don't think it is useful. Say your app can use 1 GB of main memory or 2 GB
>>>> of VRAM, it wouldn't make sense to limit the total of those. In a lot of
>>>> cases there is only 1 region, so the total of that would still be the same.
>>>>
>>>> On top, we just separated the management of each region, adding a 'total'
>>>> would require unseparating it again. :-)
>>>
>>> I didn't mean the total for a device, but for the system. It would
>>> definitely not make sense for a VRAM, but for CMA for example, you have
>>> a single, limited, allocator that will be accessible from heaps, v4l2
>>> and DRM devices.
>>>
>>> If an application has to allocate both from v4l2 and DRM buffers, we
>>> should be able to limit its total usage of CMA, not just on a single
>>> device.
>>
>> In this case, I think it makes more sense if CMA creates a region, then use
>> that region in both v4l2 and DRM instead of a separate region for both, with
>> CMA being responsible for lifetime.
> 
> Ack, thanks for your feedback :)
> 
> Maxime



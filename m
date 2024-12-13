Return-Path: <cgroups+bounces-5886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A119F0F00
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 15:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2528C287BFB
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F71E0DE3;
	Fri, 13 Dec 2024 14:20:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135771DF975;
	Fri, 13 Dec 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099600; cv=none; b=skV4KSl4JImC6G7fPuJHNRqwWFwYU3j1Vi0TkthaB7+fJltzYTjiCOdoV7JrLXmjGLU/1tRpcKqKfmGPF8GXWh1x7jjeC7zCWAlZaD56D50asbmHwAIGADaFoUiGsE0Ycj/mg7139VynDrJ74xZm6n+QGlp3v+VA1R9VkRuxNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099600; c=relaxed/simple;
	bh=8HWdDCZDmZQ7lFfWptEaYOgH0655564X8XMhKRhZp5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1TQFhDUkY+x+NECVHwIPWjGYL9OxC2lx/RDAJKZEcsWC7GI00r7fs73CVKcO2N8a1x7kdeIiwqNQiU3VjmHK1J6fz2HCPVTraS2Itpyo+13hjjWwCK0KZdsD5ltYL3VtpuC9KqLU6/cB6vF/let5gtX43CfEg3T0hnvncVbgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <789d78c1-d16a-4cb3-b4ad-ba5f0ddcacaf@lankhorst.se>
Date: Fri, 13 Dec 2024 15:13:23 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
To: Maxime Ripard <mripard@kernel.org>, Friedrich Vock <friedrich.vock@gmx.de>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <29a71119-04de-4c76-a98a-d0fcb906390f@gmx.de>
 <20241213-sceptical-maize-gazelle-fadc34@houat>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20241213-sceptical-maize-gazelle-fadc34@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

Den 2024-12-13 kl. 14:07, skrev Maxime Ripard:
> On Sun, Dec 08, 2024 at 01:15:34PM +0100, Friedrich Vock wrote:
>> Hi,
>>
>> On 04.12.24 14:44, Maarten Lankhorst wrote:
>>
>>> Because it only deals with memory regions, the UAPI has been updated
>>> to use dmem.min/low/max/current, and to make the API cleaner, the
>>> names are changed too.
>>>
>>> dmem.current could contain a line like:
>>> "drm/0000:03:00.0/vram0 1073741824"
>>>
>>> But I think using "drm/card0/vram0" instead of PCIID would perhaps
>>> be good too. I'm open to changing it to that based on feedback.
>>
>> Agree, allowing userspace to reference DRM devices via "cardN" syntax
>> sounds good.
>>
>> What about other subsystems potentially using dmem cgroups?
>> I'm not familiar with the media subsystem, but I imagine we might be
>> dealing with things like USB devices there? Is something like a
>> "deviceN" possible there as well, or would device IDs look completely
>> different?
I'd just take what makes sense for each driver. dev_name() would be a 
good approximation.

I agree that cardN is not stable.

> > I have some patches to enable the cgroup in GEM-based drivers, media
> ones and dma-buf heaps. The dma-buf heaps are simple enough since the
> heaps names are supposed to be stable.

I've used your patch as a base enable cgroup in drivers that use the 
VRAM manager. I didn't want to enable it for all of GEM, because it 
would conflict with drivers using TTM. Some more discussion is needed first.

For DMA-BUF heaps, I think it's fine and there is a lot less need of 
discussion. I just felt it should be sent separately from the initial 
enablement.

> I don't think using card0 vs card1 (or v4l0 vs v4l1 for example) will
> work because I don't think we have any sort of guarantee that these
> names will always point to the same devices across reboots or updates.
> 
> If the module is loaded later than it used to for example, we could very
> well end up in a situation where card0 and card1 are swapped, while the
> constraints apply to the previous situation.
I agree, just put it out there for discussion. I don't think the 
benefits weigh up against the downsides :-)

Cheers,
~Maarten


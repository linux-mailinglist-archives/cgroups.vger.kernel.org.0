Return-Path: <cgroups+bounces-3464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C591DB5A
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829F8B22654
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615484D12;
	Mon,  1 Jul 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRD7CfPz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574082876;
	Mon,  1 Jul 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825909; cv=none; b=RAiJ9T62g5Q0dMdIpCK8kL8xjPbGEooZ20nCGe+R67uR7YjfTkqTVQUSbCdszhspLgHFZWiNsklFOcU6V5hTRQUWL7xDvQBNSWiuUW8V89zjjZfevjze8mPXB5XxuArU1b5eAb4UcMUh6nct0n0aKjqGNBocQFnf5NcJUFo+tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825909; c=relaxed/simple;
	bh=zBGVaBqNwJqKSJ/XcD3Kc7/O+kfYBiURgInjfNkFM2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTacRXqwuTF2kMT3SipWZsBmO/S43+y8uDqzlFhboBKm6uOUBkKgtcLspFg1DVW8EEiTBGApJtcL1cf82TPMq5WSBgv6d/GxQNmX+Rdv3+zEpShp04jFfJ9LbhwRtzCUOgG+iLOjNet+b06geExqoTamcCHdczbnJpI8zy6/MmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRD7CfPz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719825908; x=1751361908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zBGVaBqNwJqKSJ/XcD3Kc7/O+kfYBiURgInjfNkFM2I=;
  b=TRD7CfPzesVAzx37m//UCW+3AHIQJw2Fw98k5sZoyzJHmRZrmEJgZ0uR
   0mZs4GuTPkOTY+8OTXH1MV6w0PPsQVhB8K41dCFGpTfyLKRkXLkX5V9dS
   LE9NRx12l0+2pihnbP0ZnTs+jQIt/Ur+k6nELAjFBG2/NIHFJ6odsGRcl
   uN7AjPvmUUgT81Q+l4I8N7boMeUhI8704NHzzqbbXdKgnYMj+Q+eKPHHs
   t76n3yOQMTmh381XtmkUnWdHUnFBRdR+Kb+a5Fr/gjlZm0IuQhQb7AIbH
   xJtgxoxeBpGm8FAEgJ9py9OigcEHPIkJgE9P/kAPvgnH9EVzm+7Ta14tZ
   g==;
X-CSE-ConnectionGUID: PF720MjVRjmvqHCIVGQhzg==
X-CSE-MsgGUID: UfSX0ffiQs6swSt+oByBcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27559457"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="27559457"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:25:07 -0700
X-CSE-ConnectionGUID: gx3ZGV9+QWixFP9x1bnqLg==
X-CSE-MsgGUID: 8TddMy73TtytfYhco8qPUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45445623"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.51]) ([10.245.244.51])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:25:02 -0700
Message-ID: <70289c58-7947-4347-8600-658821a730b0@linux.intel.com>
Date: Mon, 1 Jul 2024 11:25:12 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] drm/cgroup: Add memory accounting DRM cgroup
To: Maxime Ripard <mripard@kernel.org>
Cc: intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>
 <20240627-paper-vicugna-of-fantasy-c549ed@houat>
 <6cb7c074-55cb-4825-9f80-5cf07bbd6745@linux.intel.com>
 <20240628-romantic-emerald-snake-7b26ca@houat>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20240628-romantic-emerald-snake-7b26ca@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Den 2024-06-28 kl. 16:04, skrev Maxime Ripard:
> Hi,
> 
> On Thu, Jun 27, 2024 at 09:22:56PM GMT, Maarten Lankhorst wrote:
>> Den 2024-06-27 kl. 19:16, skrev Maxime Ripard:
>>> Hi,
>>>
>>> Thanks for working on this!
>>>
>>> On Thu, Jun 27, 2024 at 05:47:21PM GMT, Maarten Lankhorst wrote:
>>>> The initial version was based roughly on the rdma and misc cgroup
>>>> controllers, with a lot of the accounting code borrowed from rdma.
>>>>
>>>> The current version is a complete rewrite with page counter; it uses
>>>> the same min/low/max semantics as the memory cgroup as a result.
>>>>
>>>> There's a small mismatch as TTM uses u64, and page_counter long pages.
>>>> In practice it's not a problem. 32-bits systems don't really come with
>>>>> =4GB cards and as long as we're consistently wrong with units, it's
>>>> fine. The device page size may not be in the same units as kernel page
>>>> size, and each region might also have a different page size (VRAM vs GART
>>>> for example).
>>>>
>>>> The interface is simple:
>>>> - populate drmcgroup_device->regions[..] name and size for each active
>>>>    region, set num_regions accordingly.
>>>> - Call drm(m)cg_register_device()
>>>> - Use drmcg_try_charge to check if you can allocate a chunk of memory,
>>>>    use drmcg_uncharge when freeing it. This may return an error code,
>>>>    or -EAGAIN when the cgroup limit is reached. In that case a reference
>>>>    to the limiting pool is returned.
>>>> - The limiting cs can be used as compare function for
>>>>    drmcs_evict_valuable.
>>>> - After having evicted enough, drop reference to limiting cs with
>>>>    drmcs_pool_put.
>>>>
>>>> This API allows you to limit device resources with cgroups.
>>>> You can see the supported cards in /sys/fs/cgroup/drm.capacity
>>>> You need to echo +drm to cgroup.subtree_control, and then you can
>>>> partition memory.
>>>>
>>>> Signed-off-by: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
>>>> Co-developed-by: Friedrich Vock<friedrich.vock@gmx.de>
>>> I'm sorry, I should have wrote minutes on the discussion we had with TJ
>>> and Tvrtko the other day.
>>>
>>> We're all very interested in making this happen, but doing a "DRM"
>>> cgroup doesn't look like the right path to us.
>>>
>>> Indeed, we have a significant number of drivers that won't have a
>>> dedicated memory but will depend on DMA allocations one way or the
>>> other, and those pools are shared between multiple frameworks (DRM,
>>> V4L2, DMA-Buf Heaps, at least).
>>>
>>> This was also pointed out by Sima some time ago here:
>>> https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/
>>>
>>> So we'll want that cgroup subsystem to be cross-framework. We settled on
>>> a "device" cgroup during the discussion, but I'm sure we'll have plenty
>>> of bikeshedding.
>>>
>>> The other thing we agreed on, based on the feedback TJ got on the last
>>> iterations of his series was to go for memcg for drivers not using DMA
>>> allocations.
>>>
>>> It's the part where I expect some discussion there too :)
>>>
>>> So we went back to a previous version of TJ's work, and I've started to
>>> work on:
>>>
>>>    - Integration of the cgroup in the GEM DMA and GEM VRAM helpers (this
>>>      works on tidss right now)
>>>
>>>    - Integration of all heaps into that cgroup but the system one
>>>      (working on this at the moment)
>>
>> Should be similar to what I have then. I think you could use my work to
>> continue it.
>>
>> I made nothing DRM specific except the name, if you renamed it the device
>> resource management cgroup and changed the init function signature to take a
>> name instead of a drm pointer, nothing would change. This is exactly what
>> I'm hoping to accomplish, including reserving memory.
> 
> I've started to work on rebasing my current work onto your series today,
> and I'm not entirely sure how what I described would best fit. Let's
> assume we have two KMS device, one using shmem, one using DMA
> allocations, two heaps, one using the page allocator, the other using
> CMA, and one v4l2 device using dma allocations.
> 
> So we would have one KMS device and one heap using the page allocator,
> and one KMS device, one heap, and one v4l2 driver using the DMA
> allocator.
> 
> Would these make different cgroup devices, or different cgroup regions?

Each driver would register a device, whatever feels most logical for that device I suppose.

My guess is that a prefix would also be nice here, so register a device with name of drm/$name or v4l2/$name, heap/$name. I didn't give it much thought and we're still experimenting, so just try something. :)

There's no limit to amount of devices, I only fixed amount of pools to match TTM, but even that could be increased arbitrarily. I just don't think there is a point in doing so.

>> The nice thing is that it should be similar to the memory cgroup controller
>> in semantics, so you would have the same memory behavior whether you use the
>> device cgroup or memory cgroup.
>>
>> I'm sad I missed the discussion, but hopefully we can coordinate more now
>> that we know we're both working on it. :)
> 
> Yeah, definitely :)
> 
> Maxime
Cheers,
~Maarten


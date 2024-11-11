Return-Path: <cgroups+bounces-5508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32C9C3AD8
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F261F210AE
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C23170A0B;
	Mon, 11 Nov 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq1aoUAi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB81684B4;
	Mon, 11 Nov 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317300; cv=none; b=Pc1MftpbEh1VFzgqpvpE+0qhLPYjw8qqCcn43jnR3Ti6FZu8dJ11n1J4N91bw+ERzy+/IkgrxHCqLxCq0BQwc+EOcljQuyonDF0QlmZxfj/5B8K54CCeeiXmN2N4VZn/Rb/zQKqbGA7T4qemypC8ssKa5xTBGB3ABwfULrx/uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317300; c=relaxed/simple;
	bh=+SBAacjvUsQOBkoIHgArPsT8A8OVUexjcQWHe3IJnow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVPl7ZUuz0tQ1wwogZAlYyyzV/3D6vCii6DmrO8BGRJoZDrwG2rFfVLj0zUgjiSH/e8/jOZlhgy1Cpbkyi0tjotKylwU+g9pmjZlThkFcVfGSn8AUj+Rnu0eRTZASNORJfDPAp2D4MDz23trj3jGl0dCTBzeYi9aiPRIlyVIVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lq1aoUAi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731317298; x=1762853298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+SBAacjvUsQOBkoIHgArPsT8A8OVUexjcQWHe3IJnow=;
  b=Lq1aoUAiQJSWkzPvw3yj0zcjviffLYux13/OBRhYEu5I/EARFx22embi
   U3QTTCkSvd3/x7FV3EJYw7hWA+TZ4NVgCR6OCsXBVqTyrUUOfTndOc/kR
   HMzTBf1IhUnJ8oWHE0DPEjLwZRhE8PodHnymvXzsBjX1ldZLddkA6tauA
   j/7t3Ph7fG2MWvDq1IRGj5dFK4R4eHUeWWZf15Zsq/tl3r0YwBKV0toLO
   f4Fv/bTSA4NZbd9lA2sTGUR82VukwuQ+nYkrLRbYtD/h9v5vaEmWKjFCi
   co1LHsj8w35RRj5qb/KfAj5L0KoF6BoCAXdlcD0icMz7sD7KguTnBvN3e
   A==;
X-CSE-ConnectionGUID: F/xn/7WZR9WJp7kH5YjDrQ==
X-CSE-MsgGUID: bwdr/PVBRgCx1zguMh5BWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42213212"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42213212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:28:17 -0800
X-CSE-ConnectionGUID: 9XbZoz18Tn2Q4+fN1Oe4ww==
X-CSE-MsgGUID: P6Jt0NSkQg6jvR5zvXnVWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86583250"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.88]) ([10.245.244.88])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:28:14 -0800
Message-ID: <2ddaf010-ce31-4957-bc4f-7f4c1bfe0826@linux.intel.com>
Date: Mon, 11 Nov 2024 10:28:11 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] kernel/cgroup: Add "dev" memory accounting cgroup
To: Waiman Long <llong@redhat.com>, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <20241023075302.27194-2-maarten.lankhorst@linux.intel.com>
 <813cc1d5-1648-4900-ae56-5405e52926df@redhat.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <813cc1d5-1648-4900-ae56-5405e52926df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Den 2024-10-23 kl. 17:26, skrev Waiman Long:
> On 10/23/24 3:52 AM, Maarten Lankhorst wrote:
>> The initial version was based roughly on the rdma and misc cgroup
>> controllers, with a lot of the accounting code borrowed from rdma.
>>
>> The current version is a complete rewrite with page counter; it uses
>> the same min/low/max semantics as the memory cgroup as a result.
>>
>> There's a small mismatch as TTM uses u64, and page_counter long pages.
>> In practice it's not a problem. 32-bits systems don't really come with
>>> =4GB cards and as long as we're consistently wrong with units, it's
>> fine. The device page size may not be in the same units as kernel page
>> size, and each region might also have a different page size (VRAM vs GART
>> for example).
>>
>> The interface is simple:
>> - populate dev_cgroup_try_charge->regions[..] name and size for each 
>> active
>>    region, set num_regions accordingly.
>> - Call (dev,drmm)_cgroup_register_device()
>> - Use dev_cgroup_try_charge to check if you can allocate a chunk of 
>> memory,
>>    use dev_cgroup__uncharge when freeing it. This may return an error 
>> code,
>>    or -EAGAIN when the cgroup limit is reached. In that case a reference
>>    to the limiting pool is returned.
>> - The limiting cs can be used as compare function for
>>    dev_cgroup_state_evict_valuable.
>> - After having evicted enough, drop reference to limiting cs with
>>    dev_cgroup_pool_state_put.
>>
>> This API allows you to limit device resources with cgroups.
>> You can see the supported cards in /sys/fs/cgroup/dev.region.capacity
>> You need to echo +dev to cgroup.subtree_control, and then you can
>> partition memory.
>>
>> Co-developed-by: Friedrich Vock <friedrich.vock@gmx.de>
>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> Co-developed-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  51 ++
>>   Documentation/core-api/cgroup.rst       |   9 +
>>   Documentation/core-api/index.rst        |   1 +
>>   Documentation/gpu/drm-compute.rst       |  54 ++
>>   include/linux/cgroup_dev.h              |  91 +++
>>   include/linux/cgroup_subsys.h           |   4 +
>>   include/linux/page_counter.h            |   2 +-
>>   init/Kconfig                            |   7 +
>>   kernel/cgroup/Makefile                  |   1 +
>>   kernel/cgroup/dev.c                     | 893 ++++++++++++++++++++++++
>>   mm/page_counter.c                       |   4 +-
>>   11 files changed, 1114 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/core-api/cgroup.rst
>>   create mode 100644 Documentation/gpu/drm-compute.rst
>>   create mode 100644 include/linux/cgroup_dev.h
>>   create mode 100644 kernel/cgroup/dev.c
> 
> Just a general comment.
> 
> Cgroup v1 has a legacy device controller in security/device_cgroup.c 
> which is no longer available in cgroup v2. So if you use the name device 
> controller, the documentation must be clear that it is completely 
> different and have no relationship from the device controller in cgroup v1.
Hey,

Thanks for noticing. I didn't know there was such a controller. Seems 
weird to have one for managing access to opening devnodes instead of a
security module.

I'll update the documentation in the next version to make it more clear.

Cheers,
~Maarten


Return-Path: <cgroups+bounces-5204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E719ACEB0
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4DE1F22005
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382551C0DCB;
	Wed, 23 Oct 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALF4GfAx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D271E51D
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697178; cv=none; b=aZLMf40e0fuW18iESFoJ4/QJawBLnuYMLL/klEVHIc3Xw6k52viiw0m9KRtMdavV9izB0W7jk3qwXyjzyjoRSX1pin9T0t/MrfWnTZk9NBMn0D7rIwoU/WUohWrR27iRfkY+asDV6UUBsTae56a0Cd6Og5AV2x9+u6WnI4BwAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697178; c=relaxed/simple;
	bh=NMWmB4dTqKJtnEu3UyDlc4UyPLTOKHxcbHCZ8gly7GM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TWjAALgJiXsULejxUH2MYjVeeYLV44YP0Ixdg+hF8vWTyVs5t4gKAQRwv58KMMnMxT0ru5hj2tje4Ta5TOuXAoWAiBZ7BzjALudmCvjcfuMyqvd1bs1M9teb+xioxLvG5jdTkEPRu2eAaEeviEYr/ca4w8fVNynmANFQCp8JK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALF4GfAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729697175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUh0g17SqyKPeTvfCPnxLjLxXG/Lptz+4Dsb0wobQHw=;
	b=ALF4GfAxMYSAwmb0MscpgT5ycslvdxMrN8zR3YIBd989d+t20P9u+9ZQvRpiXeGLpqEbPG
	UtKLkYUum/IXa+gkXDmtjM02sCaBEx17LhIUpOQDCG0BCzxl/+EK07JYvtjCbn/o7YKKK2
	m0y/UASML+vozj/yLuBPYK9EaLCcyaY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-h2pgNtMtN1-AHQAO90d8yA-1; Wed, 23 Oct 2024 11:26:13 -0400
X-MC-Unique: h2pgNtMtN1-AHQAO90d8yA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-718074f58fcso5912989a34.1
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 08:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697173; x=1730301973;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUh0g17SqyKPeTvfCPnxLjLxXG/Lptz+4Dsb0wobQHw=;
        b=qZmfFua/AmPm108OU7vdgXE1GVvojA6ZfP8PxpCoU+N6p7t0zUNLaRcKuiidT7O2d0
         sPG5kHprFSxaSWGwNjjofT+pagxk6DzHRCFueDp4JAEXbQIPYdzCSD0Jjn8nDHgnK1SM
         BjYkJLnKtZFa2IwuW4DegocxBVA3iqxunivqQ/356GRZH2NdFo1Pn0ZKK7amJ5+VSUDA
         9scOUO3IL1kSURsajqXnDMlj/oxpoB/POvBd4fxux3uOkoeVVVXDxgv9maq/O1QFkGpe
         oBQVl6Mtn8Jw5eJneyiR22uyhk/FP6KsyX1GzxVq+iPW9Fh/ulUscrJHfMcrTclx6fBU
         AN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKD7EbXXibM5GAeDc5s3Rq1o2+/owfy8Bc+di9fHMvQOWGru3XHLW+n+GqzoFpJoicI190Lnr+@vger.kernel.org
X-Gm-Message-State: AOJu0YzXv95KPg00kTBDJMURU0GN1SXEpeNWIkeX8T7WUTsbZujOrkEd
	5oqqsSCPqMlAI5DNuR+ZiZY7A+aXpM42MS6P5fCUH0useAMmY+FirTSoeC62MHO79LI1ZXu0jFl
	YBMxfDkFMrP0K7KE6v6IHywFq0yUZKW8tUEb765VojYYiYAYmeQrkCBI=
X-Received: by 2002:a05:6830:4428:b0:718:119:ee15 with SMTP id 46e09a7af769-7184b2d43abmr3322089a34.10.1729697173026;
        Wed, 23 Oct 2024 08:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ8HZNZZ1NdptD5eLWfYWIKUwYpZpDtDkhL+yfDSXkQRcv/wze/ury8WoK60x0GCFuj5xePQ==
X-Received: by 2002:a05:6830:4428:b0:718:119:ee15 with SMTP id 46e09a7af769-7184b2d43abmr3322057a34.10.1729697172730;
        Wed, 23 Oct 2024 08:26:12 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb5e0sm40518826d6.33.2024.10.23.08.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:26:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <813cc1d5-1648-4900-ae56-5405e52926df@redhat.com>
Date: Wed, 23 Oct 2024 11:26:10 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] kernel/cgroup: Add "dev" memory accounting cgroup
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <20241023075302.27194-2-maarten.lankhorst@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20241023075302.27194-2-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 3:52 AM, Maarten Lankhorst wrote:
> The initial version was based roughly on the rdma and misc cgroup
> controllers, with a lot of the accounting code borrowed from rdma.
>
> The current version is a complete rewrite with page counter; it uses
> the same min/low/max semantics as the memory cgroup as a result.
>
> There's a small mismatch as TTM uses u64, and page_counter long pages.
> In practice it's not a problem. 32-bits systems don't really come with
>> =4GB cards and as long as we're consistently wrong with units, it's
> fine. The device page size may not be in the same units as kernel page
> size, and each region might also have a different page size (VRAM vs GART
> for example).
>
> The interface is simple:
> - populate dev_cgroup_try_charge->regions[..] name and size for each active
>    region, set num_regions accordingly.
> - Call (dev,drmm)_cgroup_register_device()
> - Use dev_cgroup_try_charge to check if you can allocate a chunk of memory,
>    use dev_cgroup__uncharge when freeing it. This may return an error code,
>    or -EAGAIN when the cgroup limit is reached. In that case a reference
>    to the limiting pool is returned.
> - The limiting cs can be used as compare function for
>    dev_cgroup_state_evict_valuable.
> - After having evicted enough, drop reference to limiting cs with
>    dev_cgroup_pool_state_put.
>
> This API allows you to limit device resources with cgroups.
> You can see the supported cards in /sys/fs/cgroup/dev.region.capacity
> You need to echo +dev to cgroup.subtree_control, and then you can
> partition memory.
>
> Co-developed-by: Friedrich Vock <friedrich.vock@gmx.de>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst |  51 ++
>   Documentation/core-api/cgroup.rst       |   9 +
>   Documentation/core-api/index.rst        |   1 +
>   Documentation/gpu/drm-compute.rst       |  54 ++
>   include/linux/cgroup_dev.h              |  91 +++
>   include/linux/cgroup_subsys.h           |   4 +
>   include/linux/page_counter.h            |   2 +-
>   init/Kconfig                            |   7 +
>   kernel/cgroup/Makefile                  |   1 +
>   kernel/cgroup/dev.c                     | 893 ++++++++++++++++++++++++
>   mm/page_counter.c                       |   4 +-
>   11 files changed, 1114 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/core-api/cgroup.rst
>   create mode 100644 Documentation/gpu/drm-compute.rst
>   create mode 100644 include/linux/cgroup_dev.h
>   create mode 100644 kernel/cgroup/dev.c

Just a general comment.

Cgroup v1 has a legacy device controller in security/device_cgroup.c 
which is no longer available in cgroup v2. So if you use the name device 
controller, the documentation must be clear that it is completely 
different and have no relationship from the device controller in cgroup v1.

Cheers,
Longman



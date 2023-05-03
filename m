Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0226F540F
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECJMQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjECJMO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 05:12:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171459E2;
        Wed,  3 May 2023 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683105114; x=1714641114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yZdDxF7eM2/0DaJdrpLaz+vSoS07hfHOMx2AFF1OeTM=;
  b=fjkkNotiRbH6MTQkXKJgLKWgAy6gMqzwVWVZjj9eCS5zfa7yexe3IWgO
   Yk2jV2ejpozSwUbMO5QVe34PhOiGpsjAS5/3lZ31qcRUf4gw2q6r++Gra
   gZXDm/QX9vwv/xxl/adRM2j16y4CXtB0mVtgKyLOvXuMr0Uxy8IhH/zDc
   mItAcS72CxS95UkpeDF1rFxfbKHF0u4sH5feD8MdHPrkLYv9owkdmj3xy
   ZHbNDZtAvY73AChq/tL8O8fFrcw5O0hzYRxjGQX4Ez6mqSAesCWgRgGB/
   CfXjo85f0+DB6peqpkd5InQJrkv77RW2bxHG1DHIL/ZvP6BrOK9SxlRh3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337745862"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="337745862"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 02:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="674010950"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="674010950"
Received: from skallurr-mobl1.ger.corp.intel.com (HELO [10.249.254.212]) ([10.249.254.212])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 02:11:35 -0700
Message-ID: <888841c4-7bd4-8174-7786-033715c995c6@linux.intel.com>
Date:   Wed, 3 May 2023 11:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Intel-xe] [RFC PATCH 3/4] drm/ttm: Handle -EAGAIN in
 ttm_resource_alloc as -ENOSPC.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        intel-xe@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, David Airlie <airlied@gmail.com>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
 <20230503083500.645848-4-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20230503083500.645848-4-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Maarten

On 5/3/23 10:34, Maarten Lankhorst wrote:
> This allows the drm cgroup controller to return no space is available..
>
> XXX: This is a hopeless simplification that changes behavior, and
> returns -ENOSPC even if we could evict ourselves from the current
> cgroup.
>
> Ideally, the eviction code becomes cgroup aware, and will force eviction
> from the current cgroup or its parents.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Thinking of the shrinker analogy, do non-cgroup aware shrinkers just 
shrink blindly or do they reject shrinking like this patch when a cgroup 
limit is reached?

/Thomas


> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bd5dae4d1624..e057d5d8f09a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -731,6 +731,8 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
>   		ret = ttm_resource_alloc(bo, place, mem);
>   		if (likely(!ret))
>   			break;
> +		if (ret == -EAGAIN)
> +			return -ENOSPC;
>   		if (unlikely(ret != -ENOSPC))
>   			return ret;
>   		ret = ttm_mem_evict_first(bdev, man, place, ctx,
> @@ -783,7 +785,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
>   
>   		type_found = true;
>   		ret = ttm_resource_alloc(bo, place, mem);
> -		if (ret == -ENOSPC)
> +		if (ret == -ENOSPC || ret == -EAGAIN)
>   			continue;
>   		if (unlikely(ret))
>   			goto error;

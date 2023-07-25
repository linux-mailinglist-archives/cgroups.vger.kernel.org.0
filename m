Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C173761B05
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjGYOJB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGYOIv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 10:08:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9D1FF0;
        Tue, 25 Jul 2023 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690294128; x=1721830128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Knqc8R0mT6fenbyn7oqDjc0TJDtO4aGF9VcaDoL2Pq8=;
  b=Kw2roxenD2KMHCw+N03NZrl6duCrXAUItgXOWDVwYO/z1lbyGnVIkdEc
   H5VGnLpERcRnVkKTz+EgZPlOTfkzgzFAJ7Zb1o6RaA+IiEbAHlOlOhLER
   U2Y2iYyOU5+DlZ/tNC+Uka5gn4UnOe65t3PQhSrlI2+qH0M5dsL/iic8t
   qor04Kv5O2ag5va8qzmyAme8R7rwarQ+pyLkungroq4VoubRcwtG0CAZV
   KDIrX60BVyZ7ZajsKe6dcwsskwcGRf07leoX6bDainHGJc3w4HhKhhNvE
   sx0nI21Quo3Q9xAtBBJy40qNPYYURl2onAMuftIR8JfFKZRdRXaThk0t6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="347340882"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347340882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="816266454"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="816266454"
Received: from grdarcy-mobl1.ger.corp.intel.com (HELO [10.213.228.4]) ([10.213.228.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:08:42 -0700
Message-ID: <3b96cada-3433-139c-3180-1f050f0f80f3@linux.intel.com>
Date:   Tue, 25 Jul 2023 15:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/17] cgroup/drm: Expose GPU utilisation
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
References: <20230712114605.519432-1-tvrtko.ursulin@linux.intel.com>
 <20230712114605.519432-16-tvrtko.ursulin@linux.intel.com>
 <ZLsEdJeEAPYWFunT@slm.duckdns.org> <ZLsEomsuxoy-YnkA@slm.duckdns.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZLsEomsuxoy-YnkA@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 21/07/2023 23:20, Tejun Heo wrote:
> On Fri, Jul 21, 2023 at 12:19:32PM -1000, Tejun Heo wrote:
>> On Wed, Jul 12, 2023 at 12:46:03PM +0100, Tvrtko Ursulin wrote:
>>> +  drm.active_us
>>> +	GPU time used by the group recursively including all child groups.
>>
>> Maybe instead add drm.stat and have "usage_usec" inside? That'd be more
>> consistent with cpu side.

Could be, but no strong opinion from my side either way. Perhaps it boils down to what could be put in the file, I mean to decide whether keyed format makes sense or not.
  
> Also, shouldn't this be keyed by the drm device?
  
It could have that too, or it could come later. Fun with GPUs that it not only could be keyed by the device, but also by the type of the GPU engine. (Which are a) vendor specific and b) some aree fully independent, some partially so, and some not at all - so it could get complicated semantics wise really fast.)

If for now I'd go with drm.stat/usage_usec containing the total time spent how would you suggest adding per device granularity? Files as documented are either flag or nested, not both at the same time. So something like:

usage_usec 100000
card0 usage_usec 50000
card1 usage_usec 50000

Would or would not fly? Have two files along the lines of drm.stat and drm.dev_stat?

While on this general topic, you will notice that for memory stats I have _sort of_ nested keyed per device format, for example on integrated Intel GPU:

   $ cat drm.memory.stat
   card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
   card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0

If one a discrete Intel GPU two more lines would appear with memory regions of local and local-system. But then on some server class multi-tile GPUs even further regions with more than one device local memory region. And users do want to see this granularity for container use cases at least.

Anyway, this may not be compatible with the nested key format as documented in cgroup-v2.rst, although it does not explicitly say.

Should I cheat and create key names based on device and memory region name and let userspace parse it? Like:

   $ cat drm.memory.stat
   card0.system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
   card0.stolen-system total=0 shared=0 active=0 resident=0 purgeable=0

Regards,

Tvrtko

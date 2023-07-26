Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DD763586
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjGZLo7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGZLo6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 07:44:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E73582;
        Wed, 26 Jul 2023 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690371876; x=1721907876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PkVu2FDpja2qAE94z99NnNol7HutAbJ4ogDZ3EgAmRI=;
  b=KhIG6kDvpcjokOwh8O6CgLrxkDRuIOZcy3ftWAD3wvGZTyOcOrfj1N6A
   f20rjwyWmPjiv7UngMdw0QhgvIXUtkfqNJKMmhboK7x8gPEMxpakvpdxd
   WcLTlv1zTayBYq7Jp3V7vtZdMr18ZKNxCzTyyk6rP8Xb4k7Vaf6GUMpMb
   TCN16WM8nWyf2DXDQ1vRm0INcA+9NC5D9ii+mCrNKRONLpHVtU00LDDN5
   OvO9YbGxKaj+5cu9KffOOZr8yyXsYUEAH/WdyvzF+TQeUF8nk9qbUSUMH
   Kyr/n8r8lDZ+gSZwbKXp7qnGoCCGIVIy0Xxs0jN6ph5Tx2CWDMcWmQ2oO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="347601785"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="347601785"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="850437409"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="850437409"
Received: from spsmyth-mobl1.ger.corp.intel.com (HELO [10.213.229.32]) ([10.213.229.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:41:29 -0700
Message-ID: <89d7181c-6830-ca6e-0c39-caa49d14d474@linux.intel.com>
Date:   Wed, 26 Jul 2023 12:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
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
 <20230712114605.519432-17-tvrtko.ursulin@linux.intel.com>
 <ZLsFBHqCQdPHoZVw@slm.duckdns.org>
 <ea64d7bf-c01b-f4ad-a36b-f77e2c2ea931@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ea64d7bf-c01b-f4ad-a36b-f77e2c2ea931@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 26/07/2023 11:14, Maarten Lankhorst wrote:
> Hey,
> 
> On 2023-07-22 00:21, Tejun Heo wrote:
>> On Wed, Jul 12, 2023 at 12:46:04PM +0100, Tvrtko Ursulin wrote:
>>>    $ cat drm.memory.stat
>>>    card0 region=system total=12898304 shared=0 active=0 
>>> resident=12111872 purgeable=167936
>>>    card0 region=stolen-system total=0 shared=0 active=0 resident=0 
>>> purgeable=0
>>>
>>> Data is generated on demand for simplicty of implementation ie. no 
>>> running
>>> totals are kept or accounted during migrations and such. Various
>>> optimisations such as cheaper collection of data are possible but
>>> deliberately left out for now.
>>>
>>> Overall, the feature is deemed to be useful to container orchestration
>>> software (and manual management).
>>>
>>> Limits, either soft or hard, are not envisaged to be implemented on 
>>> top of
>>> this approach due on demand nature of collecting the stats.
>>
>> So, yeah, if you want to add memory controls, we better think through how
>> the fd ownership migration should work.
> I've taken a look at the series, since I have been working on cgroup 
> memory eviction.
> 
> The scheduling stuff will work for i915, since it has a purely software 
> execlist scheduler, but I don't think it will work for GuC (firmware) 
> scheduling or other drivers that use the generic drm scheduler.

It actually works - I used to have a blurb in the cover letter about it 
but apparently I dropped it. Just a bit less well with many clients, 
since there are fewer priority levels.

All that the design requires from the invididual drivers is some way to 
react to the "you are over budget by this much" signal. The rest is 
driver and backend specific.

> For something like this,  you would probably want it to work inside the 
> drm scheduler first. Presumably, this can be done by setting a weight on 
> each runqueue, and perhaps adding a callback to update one for a running 
> queue. Calculating the weights hierarchically might be fun..

It is not needed to work in drm scheduler first. In fact drm scheduler 
based drivers can plug into what I have since it already has the notion 
of scheduling priorities.

They would only need to implement a hook which allow the cgroup 
controller to query client GPU utilisation and another to received the 
over budget signal.

Amdgpu and msm AFAIK could be easy candidates because they both support 
per client utilisation and priorities.

Looks like I need to put all this info back into the cover letter.

Also, hierarchic weights and time budgets are all already there. What 
could be done later is make this all smarter and respect the time budget 
with more precision. That would however, in many cases including Intel, 
require co-operation with the firmware. In any case it is only work in 
the implementation, while the cgroup control interface remains the same.

> I have taken a look at how the rest of cgroup controllers change 
> ownership when moved to a different cgroup, and the answer was: not at 
> all. If we attempt to create the scheduler controls only on the first 
> time the fd is used, you could probably get rid of all the tracking.

Can you send a CPU file descriptor from process A to process B and have 
CPU usage belonging to process B show up in process' A cgroup, or 
vice-versa? Nope, I am not making any sense, am I? My point being it is 
not like-to-like, model is different.

No ownership transfer would mean in wide deployments all GPU utilisation 
would be assigned to Xorg and so there is no point to any of this. No 
way to throttle a cgroup with un-important GPU clients for instance.

> This can be done very easily with the drm scheduler.
> 
> WRT memory, I think the consensus is to track system memory like normal 
> memory. Stolen memory doesn't need to be tracked. It's kernel only 
> memory, used for internal bookkeeping  only.
> 
> The only time userspace can directly manipulate stolen memory, is by 
> mapping the pinned initial framebuffer to its own address space. The 
> only allocation it can do is when a framebuffer is displayed, and 
> framebuffer compression creates some stolen memory. Userspace is not
> aware of this though, and has no way to manipulate those contents.

Stolen memory is irrelevant and not something cgroup controller knows 
about. Point is drivers say which memory regions they have and their 
utilisation.

Imagine instead of stolen it said vram0, or on Intel multi-tile it shows 
local0 and local1. People working with containers are interested to see 
this breakdown. I guess the parallel and use case here is closer to 
memory.numa_stat.

Regards,

Tvrtko

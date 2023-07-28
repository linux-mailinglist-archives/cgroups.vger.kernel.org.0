Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9093766F1B
	for <lists+cgroups@lfdr.de>; Fri, 28 Jul 2023 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjG1OPl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jul 2023 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjG1OPk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jul 2023 10:15:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B593A94;
        Fri, 28 Jul 2023 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690553739; x=1722089739;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=AZ/ocz0hEyx4b7zjwB+nv50Nb+TCW7LuxkGS/3Orf7M=;
  b=MMohJhwRXLC5sVZtoRZsxTLJc5rdelLxmOOy6SOJyzDlIyD0hSdwxYB8
   bvLziTmxNWkWra1cyo/3T1Zl2YQBEnS9GQVf3IRqfKf9UF+lCR9m7dIY0
   qVAw2n2nQ+YgISJY7W9mY8g3ikXbrOEGUbxQUuQRHde4sMuInjKyFaUGF
   KteOn7qdUQO2+uOO3kV4Jo1Cn3g1JnBZoY8j0jGh/YUwjDG7K9J2h4SwT
   AfTCPtxmTbdjtI0WunbaDVbcxVXohz8qvGw9Oth4W/8zWBW2BbmxaRdyJ
   +OvRbXcNTcJC2t/hNE4e5tTDsGSSNp8ejkfwS2T9sMQbK/G5nDzN9vQFK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454959091"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="454959091"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="974085643"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="974085643"
Received: from atoomey-mobl.amr.corp.intel.com (HELO [10.213.197.30]) ([10.213.197.30])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:15:31 -0700
Message-ID: <0d51725f-d4d3-ae75-1d14-e9816cb8d33c@linux.intel.com>
Date:   Fri, 28 Jul 2023 15:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
 <89d7181c-6830-ca6e-0c39-caa49d14d474@linux.intel.com>
 <fb734626-6041-1e68-38d7-221837284cf1@linux.intel.com>
 <5d65d387-2718-06c3-ee5d-8a7da6e3ddfd@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <5d65d387-2718-06c3-ee5d-8a7da6e3ddfd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


One additional thought on one sub-topic:

On 27/07/2023 18:08, Tvrtko Ursulin wrote:

[snip]

>>>> For something like this,  you would probably want it to work inside 
>>>> the drm scheduler first. Presumably, this can be done by setting a 
>>>> weight on each runqueue, and perhaps adding a callback to update one 
>>>> for a running queue. Calculating the weights hierarchically might be 
>>>> fun..
>>>
>>> It is not needed to work in drm scheduler first. In fact drm 
>>> scheduler based drivers can plug into what I have since it already 
>>> has the notion of scheduling priorities.
>>>
>>> They would only need to implement a hook which allow the cgroup 
>>> controller to query client GPU utilisation and another to received 
>>> the over budget signal.
>>>
>>> Amdgpu and msm AFAIK could be easy candidates because they both 
>>> support per client utilisation and priorities.
>>>
>>> Looks like I need to put all this info back into the cover letter.
>>>
>>> Also, hierarchic weights and time budgets are all already there. What 
>>> could be done later is make this all smarter and respect the time 
>>> budget with more precision. That would however, in many cases 
>>> including Intel, require co-operation with the firmware. In any case 
>>> it is only work in the implementation, while the cgroup control 
>>> interface remains the same.
>>>
>>>> I have taken a look at how the rest of cgroup controllers change 
>>>> ownership when moved to a different cgroup, and the answer was: not 
>>>> at all. If we attempt to create the scheduler controls only on the 
>>>> first time the fd is used, you could probably get rid of all the 
>>>> tracking.
>>>
>>> Can you send a CPU file descriptor from process A to process B and 
>>> have CPU usage belonging to process B show up in process' A cgroup, 
>>> or vice-versa? Nope, I am not making any sense, am I? My point being 
>>> it is not like-to-like, model is different.
>>>
>>> No ownership transfer would mean in wide deployments all GPU 
>>> utilisation would be assigned to Xorg and so there is no point to any 
>>> of this. No way to throttle a cgroup with un-important GPU clients 
>>> for instance.
>> If you just grab the current process' cgroup when a drm_sched_entity 
>> is created, you don't have everything charged to X.org. No need for 
>> complicated ownership tracking in drm_file. The same equivalent should 
>> be done in i915 as well when a context is created as it's not using 
>> the drm scheduler.
> 
> Okay so essentially nuking the concept of DRM clients belongs to one 
> cgroup and instead tracking at the context level. That is an interesting 
> idea. I suspect implementation could require somewhat generalizing the 
> concept of an "execution context", or at least expressing it via the DRM 
> cgroup controller.
> 
> I can give this a spin, or at least some more detailed thought, once we 
> close on a few more details regarding charging in general.

I didn't get much time to brainstorm this just yet, only one downside 
randomly came to mind later - with this approach for i915 we wouldn't 
correctly attribute any GPU activity done in the receiving process 
against our default contexts. Those would still be accounted to the 
sending process.

How much problem in practice that would be remains to be investigated, 
including if it applies to other drivers too. If there is a good amount 
of deployed userspace which use the default context, then it would be a 
bit messy.

Regards,

Tvrtko

*) For non DRM and non i915 people, default context is a GPU submission 
context implicitly created during the device node open. It always 
remains valid, including in the receiving process if SCM_RIGHTS is used.

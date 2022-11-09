Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB66230F0
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 18:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKIRC0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKIRBF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 12:01:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08B275DB;
        Wed,  9 Nov 2022 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668013148; x=1699549148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wMJggPLd/L+ccuE+e7h8X2BxRK2M9kKo7llg0NL7kvU=;
  b=b7GLDMr1jrJe+sHn6bK9QW/JLgixfaSAkKXu6dWsQUOcB3iYhhnrcc3m
   93rfdcubxd3LIH5g+LAm6/FgVIk7z27M/dYX/4SbvUPk1TVEJZd0AGdko
   R+9nHceh87bR1U9SIQFtklppHP32PFVA0OK+jsPAazX/mc7YkqIs4DuwB
   CV6JNWmpEU2LTqqBlqok91D3Rf7zgKUamYnI55/QdUrovXwVGxFffZdtA
   iAMoenv4qLoEvDz+fRWNupUujZIjTf28kXKMLTe0CtCx24LNZk9WyC7tt
   jkHaXcvVG2IPdnHrL2KdDcZwxaIPXcedCXJgi3jSPjP7PqujqMxYy6CiC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373179088"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="373179088"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:59:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811699084"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="811699084"
Received: from smurnane-mobl.ger.corp.intel.com (HELO [10.213.196.238]) ([10.213.196.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:59:04 -0800
Message-ID: <8aade97f-35f3-a4ec-9e91-e5b739ee8973@linux.intel.com>
Date:   Wed, 9 Nov 2022 16:59:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC 00/17] DRM scheduling cgroup controller
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
 <Y1BFziiJdBzsIJWH@slm.duckdns.org>
 <908129fa-3ddc-0f62-18df-e318dc760955@linux.intel.com>
 <Y2AuAtSmS8X7a1qC@slm.duckdns.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y2AuAtSmS8X7a1qC@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 31/10/2022 20:20, Tejun Heo wrote:
> Hello,
> 
> On Thu, Oct 27, 2022 at 03:32:00PM +0100, Tvrtko Ursulin wrote:
>> Looking at what's available in cgroups world now, I have spotted the
>> blkio.prio.class control. For my current use case (lower GPU scheduling of
>> background/unfocused windows) that would also work. Even if starting with
>> just two possible values - 'no-change' and 'idle' (to follow the IO
>> controller naming).
> 
> I wouldn't follow that example. That's only meaningful within the context of
> bfq and it probabaly shouldn't have been merged in the first place.
> 
>> How would you view that as a proposal? It would be a bit tougher "sell" to
>> the DRM community, perhaps, given that many drivers do have scheduling
>> priority, but the concept of scheduling class is not really there.
>> Nevertheless a concept of normal-vs-background could be plausible in my
>> mind. It could be easily implemented by using the priority controls
>> available in many drivers.
> 
> I don't feel great about that.
> 
> * The semantics aren't clearly defined. While not immediately obvious in the
>    interface, the task nice levels have definite mappings to weight values
>    and thus clear meanings. I don't think it's a good idea to leave the
>    interface semantics open to interpretation.

Agreed it is not clearly defined, but it was the same with nice levels. 
As in it changed a lot over the years how exactly they behave (with a 
few scheduler rewrites) and they were constantly at least somewhat 
useful as a mean of external control.

Nevertheless you will notice I have dropped everything priority based 
from the v2 of the RFC to simplify the conversation going forward.

> * Maybe GPUs are better but my experience with optional hardware features in
>    the storage world has been that vendors diverge wildly and unexpectedly to
>    the point many features are mostly useless. There are fewer GPU vendors
>    and more software effort behind each, so maybe the situation is better but
>    I think it'd be helpul to keep some skepticism.
> 
> * Even when per-vendor or per-driver features are consistent enough to be
>    useful, they often aren't thought through enough to be truly useful. e.g.
>    nvme has priority features but they aren't really that useful because they
>    can't do much without congestion control on the issuer side and once you
>    have congestion control on the issuer side which is usually a lot more
>    complex (e.g. dealing with work-conserving hierarchical weight
>    distributions, priority inversions and so on), you can achieve most of
>    what you need in terms of resource control from the issuer side anyway.

GPUs will not be fully uniform either, especially in the terms of how 
well the controls work, which is why I am spelling out how this is only 
attempting to do "soft limits", everywhere in the documentation, cover 
letter and patch commit message.

But at least concept of GPU time feels to me like a very universal one 
so should be something which we can base the control on.

> So, I'd much prefer to have a fuller solution on the kernel side which
> integrates per-vendor/driver features where they make sense.
> 
>>>>     drm.budget_supported
>>>> 	One of:
>>>> 	 1) 'yes' - when all DRM clients in the group support the functionality.
>>>> 	 2) 'no' - when at least one of the DRM clients does not support the
>>>> 		   functionality.
>>>> 	 3) 'n/a' - when there are no DRM clients in the group.
>>>
>>> Yeah, I'm not sure about this. This isn't a per-cgroup property to begin
>>> with and I'm not sure 'no' meaning at least one device not supporting is
>>> intuitive. The distinction between 'no' and 'n/a' is kinda weird too. Please
>>> drop this.
>>
>> The idea actually is for this to be per-cgroup and potentially change
>> dynamically. It implements the concept of "observability", how I have,
>> perhaps clumsily, named it.
>>
>> This is because we can have a mix of DRM file descriptors in a cgroup, not
>> all of which support the proposed functionality. So I wanted to have
>> something by which the administrator can observe the status of the group.
>>
>> For instance seeing some clients do not support the feature could be signal
>> that things have been misconfigured, or that appeal needs to be made for
>> driver X to start supporting the feature. Seeing a "no" there in other words
>> is a signal that budgeting may not really work as expected and needs to be
>> investigated.
> 
> I still don't see how this is per-cgroup given that it's indicating whether
> the driver supports some feature. Also, the eventual goal would be
> supporting the same control mechanisms across most (if not all) GPUs, right?

I have dropped this from v2 as well, to focus the feedback on most 
important points.

But in general the problem it wanted to address is that a single cgroup 
can contain multiple processes, each with zero to N open DRM file 
descriptors to any random GPU which happens to be installed in the 
system. And it can all change dynamically. It may be different vendors 
or different hardware generations, where some do not support the 
required functionality to support the cgroup controller.

So I wanted to give the sysadmin some visibility if at any given time 
the configuration applied to a cgroup has a chance to work fully, or 
only partially.

For instance with i915 we can have two supported devices in a laptop - 
integrated and discrete. Integrated can support the controller well, 
while for discrete is work in progress, maybe comes in the next kernel 
release. And then we can have this:

1)

cgexec -g drm:gfx/clients glxgears

This runs fully on integrated and budgeting works as expected.

2) DRI_PRIME=1 cgexec -g drm:gfx/clients glxgears

This one runs on the discrete GPU where budgeting does not work yet. 
While at the same time there can be another client in the same cgroup 
for which budgeting works. Or in other words:

cgexec -g drm:gfx/clients transcode_me_a_video
DRI_PRIME=1 cgexec -g drm:gfx/clients run_a_game

In this case game is not taking part in budgeting, even though it is a 
same driver. Maybe it will in a few kernel releases but not yet. Or in 
case of super old GPUs maybe support never gets added.

Perhaps I am over complicating things and what it would enough is to log 
the capability per device during driver probe:

i915 0000:00:02.0: DRM cgroup support: weights
i915 0000:01:00.0: DRM cgroup support: none

?

>>> Rather than doing it hierarchically on the spot, it's usually a lot cheaper
>>> and easier to calculate the flattened hierarchical weight per leaf cgroup
>>> and divide the bandwidth according to the eventual portions. For an example,
>>> please take a look at block/blk-iocost.c.
>>
>> This seems exactly what I had in mind (but haven't implemented it yet). So
>> in this RFC I have budget splitting per group where each tree level adds up
>> to "100%" and the thing which I have not implemented is "borrowing" or
>> yielding (how blk-iocost.c calls it, or donating) unused budgets to
>> siblings.
>>
>> I am very happy to hear my idea is the right one and someone already
>> implemented it. Thanks for this pointer!
> 
> The budget donation thing in iocost is necessary only because it wants to
> make the hot path local to the cgroup because io control has to support very
> high decision rate. For time-slicing GPU, it's likely that following the
> current hierarchical weight on the spot is enough.

I think I completed this part in v2. At least some quick smoke testing 
showed me that budgets now correctly propagate through the tree.

Not guaranteeing no bugs just yet and there are certainly still things 
to polish up in v2.

Regards,

Tvrtko

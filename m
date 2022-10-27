Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42660FA80
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiJ0Ogl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiJ0Ogk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 10:36:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E8189827;
        Thu, 27 Oct 2022 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666881399; x=1698417399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eevl7ITna1hMKAHJnc1Xawqrv3pRigvhaJzPJ4rONVQ=;
  b=MxK9JRmSRzZ6mAARTVY23+U1PtGFR8meZrVNJ5eXeOlNcN07A223FkzJ
   d96eqq00h7aWwvr8JovZ57OWh0HiA6aL7QxaIYnaOQFKAdqM5Pws2clL4
   Rbbli4EK6tKv3x9S+Rb1VkwQXY2cHDP/bgU0Ijr1cP+pN2BOECTU6/O5g
   6D6uMZUYZ6t7VfbIl7yI4YH87+r8AF61Fo2swC/f5MXEOn1ggoiSNCUtp
   F1mjiIkpYxr8uiI6SqixWuq92nRVfp2u0nXjIW+j0X+VukXZyeiKjouou
   jX+BsezupsoJSDfeWiVg1apUVCXh3b02qOKCmZi03tkabQsZhUSB2yHRY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="394553993"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="394553993"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 07:32:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="634926260"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="634926260"
Received: from rgrilak-mobl.ger.corp.intel.com (HELO [10.213.238.72]) ([10.213.238.72])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 07:32:02 -0700
Message-ID: <908129fa-3ddc-0f62-18df-e318dc760955@linux.intel.com>
Date:   Thu, 27 Oct 2022 15:32:00 +0100
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
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y1BFziiJdBzsIJWH@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi Tejun,

On 19/10/2022 19:45, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 19, 2022 at 06:32:37PM +0100, Tvrtko Ursulin wrote:
> ...
>> DRM static priority interface files
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>    drm.priority_levels
>> 	One of:
>> 	 1) And integer representing the minimum number of discrete priority
>> 	    levels for the whole group.
>> 	    Optionally followed by an asterisk ('*') indicating some DRM clients
>> 	    in the group support more than the minimum number.
>> 	 2) '0'- indicating one or more DRM clients in the group has no support
>> 	    for static priority control.
>> 	 3) 'n/a' - when there are no DRM clients in the configured group.
>>
>>    drm.priority
>> 	A read-write integer between -10000 and 10000 (inclusive) representing
>> 	an abstract static priority level.
>>
>>    drm.effective_priority
>> 	Read only integer showing the current effective priority level for the
>> 	group. Effective meaning taking into account the chain of inherited
> 
>>From interface POV, this is a lot worse than the second proposal and I'd
> really like to avoid this. Even if we go with mapping user priority
> configuration to per-driver priorities, I'd much prefer if the interface
> presented to user is weight based and let each driver try to match the
> resulting hierarchical weight (ie. the absolute proportion a given cgroup
> should have at the point in time) as best as they can rather than exposing
> opaque priority numbers to userspace whose meaning isn't defined at all.

I actually somewhat agree here and this proposal was mainly motivated by 
my desire to come up with *something* which would allow similar 
_external_ control as it exists in the CPU and IO world (nice/ionice).

Because currently priority of GPU workloads cannot be controlled from 
the outside at all. And especially if we consider pipelines composed of 
stages where part of the processing is done on the CPU and part on the 
GPU (or AI/VPU accelerator), then I think it would be really useful to 
be able to do so.

To this effect I proposed connecting CPU nice with GPU priority, same as 
it is connected for IO priority (so only if it hasn't been explicitly 
changed away from the defaults), but at that point I was getting 
feedback nudging me into direction of cgroups.

Looking at what's available in cgroups world now, I have spotted the 
blkio.prio.class control. For my current use case (lower GPU scheduling 
of background/unfocused windows) that would also work. Even if starting 
with just two possible values - 'no-change' and 'idle' (to follow the IO 
controller naming).

How would you view that as a proposal? It would be a bit tougher "sell" 
to the DRM community, perhaps, given that many drivers do have 
scheduling priority, but the concept of scheduling class is not really 
there. Nevertheless a concept of normal-vs-background could be plausible 
in my mind. It could be easily implemented by using the priority 
controls available in many drivers.

>> DRM scheduling soft limits interface files
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>    drm.weight
>> 	Standard cgroup weight based control [1, 10000] used to configure the
>> 	relative distributing of GPU time between the sibling groups.
> 
> Please take a look at io.weight. This can follow the same convention to
> express both global and per-device weights.
> 
>>    drm.period_us
>> 	An integer representing the period with which the controller should look
>> 	at the GPU usage by the group and potentially send the over/under budget
>> 	signal.
>> 	Value of zero (defaul) disables the soft limit checking.
> 
> Can we not do period_us or at least make it a per-driver tuning parameter
> exposed as module param? Weight, users can easily understand and configure.
> period_us is a lot more an implementation detail. If we want to express the
> trade-off between latency and bandwidth at the interface, we prolly should
> encode the latency requirement in a more canonical way but let's leave that
> for the future.

Yes agreed - for the moment (while RFC) it is handy for me to have it 
controllable per group. But I agree a kernel global (modparam) should be 
sufficient in the final solution.

> 
>>    drm.budget_supported
>> 	One of:
>> 	 1) 'yes' - when all DRM clients in the group support the functionality.
>> 	 2) 'no' - when at least one of the DRM clients does not support the
>> 		   functionality.
>> 	 3) 'n/a' - when there are no DRM clients in the group.
> 
> Yeah, I'm not sure about this. This isn't a per-cgroup property to begin
> with and I'm not sure 'no' meaning at least one device not supporting is
> intuitive. The distinction between 'no' and 'n/a' is kinda weird too. Please
> drop this.

The idea actually is for this to be per-cgroup and potentially change 
dynamically. It implements the concept of "observability", how I have, 
perhaps clumsily, named it.

This is because we can have a mix of DRM file descriptors in a cgroup, 
not all of which support the proposed functionality. So I wanted to have 
something by which the administrator can observe the status of the group.

For instance seeing some clients do not support the feature could be 
signal that things have been misconfigured, or that appeal needs to be 
made for driver X to start supporting the feature. Seeing a "no" there 
in other words is a signal that budgeting may not really work as 
expected and needs to be investigated.

> Another basic interface question. Is everyone happy with the drm prefix or
> should it be something like gpu? Also, in the future, if there's a consensus
> around how to control gpu memory, what prefix would that take?

Given the current effort to bring in AI/VPU/ML accelerator devices under 
the DRM umbrella I think drm prefix is okay. At least some of those 
devices (the ones I looked at) will accept the same concepts of 
scheduling and memory allocation as well.

And for memory specifically, I don't see why the drm prefix would not work.

But yeah, I echo the calls for wider feedback. Given how drm cgroup 
controller has been on a wish list for ages I have to say I expected a 
bit more interest. :)

>> The second proposal is a little bit more advanced in concept and also a little
>> bit less finished. Interesting thing is that it builds upon the per client GPU
>> utilisation work which landed recently for a few drivers. So my thinking is that
>> in principle, an intersect of drivers which support both that and some sort of
>> priority scheduling control, could also in theory support this.
>>
>> Another really interesting angle for this controller is that it mimics the same
>> control menthod used by the CPU scheduler. That is the proportional/weight based
>> GPU time budgeting. Which makes it easy to configure and does not need a new
>> mental model.
>>
>> However, as the introduction mentions, GPUs are much more heterogenous and
>> therefore the controller uses very "soft" wording as to what it promises. The
>> general statement is that it can define budgets, notify clients when they are
>> over them, and let individual drivers implement best effort handling of those
>> conditions.
>>
>> Delegation of duties in the implementation goes likes this:
>>
>>   * DRM cgroup controller implements the control files and the scanning loop.
>>   * DRM core is required to track all DRM clients belonging to processes so it
>>     can answer when asked how much GPU time is a process using.
>>   * DRM core also provides a call back which the controller will call when a
>>     certain process is over budget.
>>   * Individual drivers need to implement two similar hooks, but which work for
>>     a single DRM client. Over budget callback and GPU utilisation query.
>>
>> What I have demonstrated in practice is that when wired to i915, in a really
>> primitive way where the over-budget condition simply lowers the scheduling
>> priority, the concept can be almost equally effective as the static priority
>> control. I say almost because the design where budget control depends on the
>> periodic usage scanning has a fundamental delay, so responsiveness will depend
>> on the scanning period, which may or may not be a problem for a particular use
>> case.
>>
>> The unfinished part is the GPU budgeting split which currently does not
>> propagate unused bandwith to children, neither can share it with siblings. But
>> this is not due fundamental reasons, just to avoid spending too much time on it
>> too early.
> 
> Rather than doing it hierarchically on the spot, it's usually a lot cheaper
> and easier to calculate the flattened hierarchical weight per leaf cgroup
> and divide the bandwidth according to the eventual portions. For an example,
> please take a look at block/blk-iocost.c.

This seems exactly what I had in mind (but haven't implemented it yet). 
So in this RFC I have budget splitting per group where each tree level 
adds up to "100%" and the thing which I have not implemented is 
"borrowing" or yielding (how blk-iocost.c calls it, or donating) unused 
budgets to siblings.

I am very happy to hear my idea is the right one and someone already 
implemented it. Thanks for this pointer!

> I don't know much about the drm driver side, so can't comment much on it but
> I do really like the idea of having the core implementation determining who
> should get how much and then letting each driver enforce the target. That
> seems a lot more robust and generic than trying to somehow coax and expose
> per-driver priority implementations directly.

Thanks, and thanks for having a detailed read and providing great 
feedback so far!

Regards,

Tvrtko


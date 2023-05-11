Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213EB6FEF92
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjEKKDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEKKDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 06:03:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FE7EDD;
        Thu, 11 May 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683799393; x=1715335393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QlT9To/OXd8EOJgtiTI8cBaN4OaCchdOcuG26O4bS00=;
  b=mX9uxVKLxVUhs2atxKLLhdH8TgisX0f5SSdBdO4OriBsm4CfWQS5spTN
   l0MjKHeXEXgFTYg9ZbtBoM1V2md5fGcIyzDeYrijhXWiK1fXaVS7Qrvc4
   crxZUhhkgybLD2kMMITZ0klB4/XcrYRheMs/xcxD53uDddV+tF081WEEL
   wZU3KIfh97ctbYv+v0XqzcPbLW5Wgifuh61yrzG2pJfV5LswoisSWnHzj
   kVTP6BniIXdT35yX21EWoCSQHe4OFuiqBPOhX6UrbPDnXWHfLkhhNof6Q
   3/NwtKdULdsqJ1H9akydPvKn1FLwbaLESEfZVYy7OsCt9tCqcaEMGtRXb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353549906"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="353549906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 03:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843886962"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843886962"
Received: from acharach-mobl.ger.corp.intel.com (HELO [10.251.219.38]) ([10.251.219.38])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 03:03:06 -0700
Message-ID: <56668e29-f697-bd9b-2c13-182e8456dbce@linux.intel.com>
Date:   Thu, 11 May 2023 12:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/4] Add support for DRM cgroup memory accounting.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
        intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
 <ZFVeI2DKQXddKDNl@slm.duckdns.org>
 <4d6fbce3-a676-f648-7a09-6f6dcc4bdb46@linux.intel.com>
 <ZFvmaGNo0buQEUi1@slm.duckdns.org>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ZFvmaGNo0buQEUi1@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

On 2023-05-10 20:46, Tejun Heo wrote:
> Hello,
>
> On Wed, May 10, 2023 at 04:59:01PM +0200, Maarten Lankhorst wrote:
>> The misc controller is not granular enough. A single computer may have any number of
>> graphics cards, some of them with multiple regions of vram inside a single card.
> Extending the misc controller to support dynamic keys shouldn't be that
> difficult.
>
> ...
>> In the next version, I will move all the code for handling the resource limit to
>> TTM's eviction layer, because otherwise it cannot handle the resource limit correctly.
>>
>> The effect of moving the code to TTM, is that it will make the code even more generic
>> for drivers that have vram and use TTM. When using TTM, you only have to describe your
>> VRAM, update some fields in the TTM manager and (un)register your device with the
>> cgroup handler on (un)load. It's quite trivial to add vram accounting to amdgpu and
>> nouveau. [2]
>>
>> If you want to add a knob for scheduling weight for a process, it makes sense to
>> also add resource usage as a knob, otherwise the effect of that knob is very
>> limited. So even for Tvrtko's original proposed usecase, it would make sense.
> It does make sense but unlike Tvrtko's scheduling weights what's being
> proposed doesn't seem to encapsulate GPU memory resource in a generic enough
> manner at least to my untrained eyes. ie. w/ drm.weight, I don't need any
> specific knoweldge of how a specific GPU operates to say "this guy should
> get 2x processing power over that guy". This more or less holds for other
> major resources including CPU, memory and IO. What you're proposing seems a
> lot more tied to hardware details and users would have to know a lot more
> about how memory is configured on that particular GPU.

There's not much need of knowing the specifics of a card, but there might
be a need of knowing the workload to determine what allocation limits to set.

I've left region to be implementation specific, but it would make sense to
standardise it.
TTM, the layer used by drivers that support VRAM, have the following regions:
* sysmem - All system memory allocated; includes evicted VRAM.
* mapped - All physical system memory that is mapped to the GPU, when unbound
           moves to sysmem. When evicting VRAM to sysmem, it's temporarily
           mapped here.
* vramN - All VRAM regions of the device.
* driver specific regions - probably doesn't make sense to put in cgroup at all,
  this includes stolen from the PoC.

That leaves the question, what regions would make sense for a cgroup?
Since vramN can be moved to mapped and sysmem (VRAM eviction, suspend/resume,
driver_madvise), it becomes a subject of debate if we should include the other
regions, since things become complicated fast.

For the first iteration, I focus on a single category, vramN.

Even when not knowing anything about a GPU, it will be easy to partition its
memory like that.

If you can assign a weight for the scheduler, then you can also partition it's
vram by parsing /drm.capacity for total amount, and then splitting it across
cgroups.


> Now, if this is inherent to how all, or at least most, GPUs operate, sure,
> but otherwise let's start small in terms of interface and not take up space
> which should be for something universal. If this turns out to be the way,
> expanding to take up the generic interface space isn't difficult.
>
> I don't know GPU space so please educate me where I'm wrong.

Most GPU's have dedicated vram that works roughly in the same way, some
integrated chips like i915 or arm use shared memory from the host system
only. I would say amd, nvidia and intel's chips with dedicated memory work
roughly in the same way for vram.

I hope this explains it a little bit more,

~Maarten


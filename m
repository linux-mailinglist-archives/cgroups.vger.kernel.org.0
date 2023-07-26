Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FD76335B
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGZKWJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 06:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGZKWI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 06:22:08 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 03:22:06 PDT
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7397E7
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 03:22:06 -0700 (PDT)
Message-ID: <ea64d7bf-c01b-f4ad-a36b-f77e2c2ea931@linux.intel.com>
Date:   Wed, 26 Jul 2023 12:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/17] cgroup/drm: Expose memory stats
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ZLsFBHqCQdPHoZVw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

On 2023-07-22 00:21, Tejun Heo wrote:
> On Wed, Jul 12, 2023 at 12:46:04PM +0100, Tvrtko Ursulin wrote:
>>    $ cat drm.memory.stat
>>    card0 region=system total=12898304 shared=0 active=0 resident=12111872 purgeable=167936
>>    card0 region=stolen-system total=0 shared=0 active=0 resident=0 purgeable=0
>>
>> Data is generated on demand for simplicty of implementation ie. no running
>> totals are kept or accounted during migrations and such. Various
>> optimisations such as cheaper collection of data are possible but
>> deliberately left out for now.
>>
>> Overall, the feature is deemed to be useful to container orchestration
>> software (and manual management).
>>
>> Limits, either soft or hard, are not envisaged to be implemented on top of
>> this approach due on demand nature of collecting the stats.
> 
> So, yeah, if you want to add memory controls, we better think through how
> the fd ownership migration should work.
I've taken a look at the series, since I have been working on cgroup 
memory eviction.

The scheduling stuff will work for i915, since it has a purely software 
execlist scheduler, but I don't think it will work for GuC (firmware) 
scheduling or other drivers that use the generic drm scheduler.

For something like this,  you would probably want it to work inside the 
drm scheduler first. Presumably, this can be done by setting a weight on 
each runqueue, and perhaps adding a callback to update one for a running 
queue. Calculating the weights hierarchically might be fun..

I have taken a look at how the rest of cgroup controllers change 
ownership when moved to a different cgroup, and the answer was: not at 
all. If we attempt to create the scheduler controls only on the first 
time the fd is used, you could probably get rid of all the tracking.
This can be done very easily with the drm scheduler.

WRT memory, I think the consensus is to track system memory like normal 
memory. Stolen memory doesn't need to be tracked. It's kernel only 
memory, used for internal bookkeeping  only.

The only time userspace can directly manipulate stolen memory, is by 
mapping the pinned initial framebuffer to its own address space. The 
only allocation it can do is when a framebuffer is displayed, and 
framebuffer compression creates some stolen memory. Userspace is not
aware of this though, and has no way to manipulate those contents.

Cheers,
~Maarten

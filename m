Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12EF0AE1
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfKFAIX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Nov 2019 19:08:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:54144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfKFAIX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 5 Nov 2019 19:08:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 16:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="200947698"
Received: from brianwel-mobl1.amr.corp.intel.com (HELO [10.24.15.137]) ([10.24.15.137])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2019 16:08:22 -0800
Subject: Re: [RFC PATCH] cgroup: Document interface files and rationale for
 DRM controller
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Leon Romanovsky <leon@kernel.org>
References: <20191104220847.23283-1-brian.welty@intel.com>
 <20191105001505.GR3622521@devbig004.ftw2.facebook.com>
From:   Brian Welty <brian.welty@intel.com>
Message-ID: <d565fc2c-0bd0-a85a-c7ce-12ee5393154d@intel.com>
Date:   Tue, 5 Nov 2019 16:08:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105001505.GR3622521@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 11/4/2019 4:15 PM, Tejun Heo wrote:
> On Mon, Nov 04, 2019 at 05:08:47PM -0500, Brian Welty wrote:
>> +  gpuset.units
>> +  gpuset.units.effective
>> +  gpuset.units.partition
>> +
>> +  gpuset.mems
>> +  gpuset.mems.effective
>> +  gpuset.mems.partition
>> +
>> +  sched.max
>> +  sched.stats
>> +  sched.weight
>> +  sched.weight.nice
>> +
>> +  memory.current
>> +  memory.events
>> +  memory.high
>> +  memory.low
>> +  memory.max
>> +  memory.min
>> +  memory.stat
>> +  memory.swap.current
>> +  memory.swap.max
> 
> I don't understand why it needs to replicate essentially *all* the
> interfaces that system resources are implementing from the get-go.
> Some of the above have intersecting functionalities and exist more for
> historical reasons and I fail to see how distinctions like min vs. low
> and high vs. max would make sense for gpus.  Also, why would it have a
> separate swap limit of its own?
> 
> Please start with something small and intuitive.  I'm gonna nack
> anything which sprawls out like this.  Most likely, there's still a
> ton you guys need to work through to reach the resource model which is
> actually useful and trying to define a comprehensive interface upfront
> like this is gonna look really silly and will become an ugly drag by
> the time the problem space is actually understood.
> 
> It doesn't seem like this is coming through but can you please start
> with a simple weight knob?
> 
> Thanks.
> 

Thanks Tejun for the feedback.
I was more interested in hearing your thoughts on whether you like
the approach to have a set of controls that are consistent with 
some subset of the existing CPU/MEM ones.  Any feedback on this?
Didn't really mean to suggest that all of these would be included
from the start.

Would you agree that this reduced set is a reasonable starting point?
+  sched.weight
+  memory.current
+  memory.max

Thoughts on whether this should be very GPU-specific cgroups controller
or should be more forward thinking to be useful for other 'accelerator'
type devices as well?

Thanks,
-Brian




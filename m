Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF76416BAF
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2019 21:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEGTuv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 May 2019 15:50:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:2626 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfEGTuv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 7 May 2019 15:50:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 12:50:51 -0700
X-ExtLoop1: 1
Received: from brianwel-mobl1.amr.corp.intel.com (HELO [10.144.155.123]) ([10.144.155.123])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2019 12:50:50 -0700
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>, kenny.ho@amd.com
References: <20190501140438.9506-1-brian.welty@intel.com>
 <20190506152643.GL374014@devbig004.ftw2.facebook.com>
From:   "Welty, Brian" <brian.welty@intel.com>
Message-ID: <cf58b047-d678-ad89-c9b6-96fc6b01c1d7@intel.com>
Date:   Tue, 7 May 2019 12:50:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190506152643.GL374014@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 5/6/2019 8:26 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, May 01, 2019 at 10:04:33AM -0400, Brian Welty wrote:
>> The patch series enables device drivers to use cgroups to control the
>> following resources within a GPU (or other accelerator device):
>> *  control allocation of device memory (reuse of memcg)
>> and with future work, we could extend to:
>> *  track and control share of GPU time (reuse of cpu/cpuacct)
>> *  apply mask of allowed execution engines (reuse of cpusets)
>>
>> Instead of introducing a new cgroup subsystem for GPU devices, a new
>> framework is proposed to allow devices to register with existing cgroup
>> controllers, which creates per-device cgroup_subsys_state within the
>> cgroup.  This gives device drivers their own private cgroup controls
>> (such as memory limits or other parameters) to be applied to device
>> resources instead of host system resources.
>> Device drivers (GPU or other) are then able to reuse the existing cgroup
>> controls, instead of inventing similar ones.
> 
> I'm really skeptical about this approach.  When creating resource
> controllers, I think what's the most important and challenging is
> establishing resource model - what resources are and how they can be
> distributed.  This patchset is going the other way around - building
> out core infrastructure for bolierplates at a significant risk of
> mixing up resource models across different types of resources.
> 
> IO controllers already implement per-device controls.  I'd suggest
> following the same interface conventions and implementing a dedicated
> controller for the subsystem.
>
Okay, thanks for feedback.  Preference is clear to see this done as
dedicated cgroup controller.

Part of my proposal was an attempt for devices with "mem like" and "cpu 
like" attributes to be managed by common controller.   We can ignore this
idea for cpu attributes, as those can just go in a GPU controller.

There might still be merit in having a 'device mem' cgroup controller.
The resource model at least is then no longer mixed up with host memory.
RDMA community seemed to have some interest in a common controller at
least for device memory aspects.
Thoughts on this?   I believe could still reuse the 'struct mem_cgroup' data
structure.  There should be some opportunity to reuse charging APIs and
have some nice integration with HMM for charging to device memory, depending
on backing store.

-Brian

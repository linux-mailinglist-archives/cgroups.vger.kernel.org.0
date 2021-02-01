Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690BF30B367
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 00:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBAXWY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Feb 2021 18:22:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:63479 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhBAXWX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 1 Feb 2021 18:22:23 -0500
IronPort-SDR: TJIOth9aKhTMy+8ZLcXAL4XEYMfIYFvGg1YXdP0GNXZHzRWZSzd4wzCyxx3brAjd4eJoCWNJKZ
 NYmPqYj8xK2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180912141"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="180912141"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:21:37 -0800
IronPort-SDR: rkwNIz2b0CynlLQSBraKJF/Zx+NCJg2sKZ1YwCbqyPmXEy0SZF+z0NWvk+YdmCtiAxUf6qcXpi
 oS++1PY/AHdg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412942564"
Received: from brianwel-mobl1.amr.corp.intel.com (HELO [10.209.88.198]) ([10.209.88.198])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:21:36 -0800
Subject: Re: [RFC PATCH 0/9] cgroup support for GPU devices
To:     Xingyou Chen <rockrush@rockwork.org>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
 <84b79978-84c9-52aa-b761-3f4be929064e@rockwork.org>
From:   Brian Welty <brian.welty@intel.com>
Message-ID: <5307d21b-7494-858c-30f0-cb5fe1d86004@intel.com>
Date:   Mon, 1 Feb 2021 15:21:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <84b79978-84c9-52aa-b761-3f4be929064e@rockwork.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 1/28/2021 7:00 PM, Xingyou Chen wrote:
> On 2021/1/27 上午5:46, Brian Welty wrote:
> 
>> We'd like to revisit the proposal of a GPU cgroup controller for managing
>> GPU devices but with just a basic set of controls.  This series is based on 
>> the prior patch series from Kenny Ho [1].  We take Kenny's base patches
>> which implement the basic framework for the controller, but we propose an
>> alternate set of control files.  Here we've taken a subset of the controls
>> proposed in earlier discussion on ML here [2]. 
>>
>> This series proposes a set of device memory controls (gpu.memory.current,
>> gpu.memory.max, and gpu.memory.total) and accounting of GPU time usage
>> (gpu.sched.runtime).  GPU time sharing controls are left as future work.
>> These are implemented within the GPU controller along with integration/usage
>> of the device memory controls by the i915 device driver.
>>
>> As an accelerator or GPU device is similar in many respects to a CPU with
>> (or without) attached system memory, the basic principle here is try to
>> copy the semantics of existing controls from other controllers when possible
>> and where these controls serve the same underlying purpose.
>> For example, the memory.max and memory.current controls are based on
>> same controls from MEMCG controller.
> 
> It seems not to be DRM specific, or even GPU specific. Would we have an universal
> control group for any accelerator, GPGPU device etc, that hold sharable resources
> like device memory, compute utility, bandwidth, with extra control file to select
> between devices(or vendors)?
> 
> e.g. /cgname.device that stores PCI BDF， or enum(intel, amdgpu, nvidia, ...),
> defaults to none, means not enabled.
> 

Hi, thanks for the feedback.  Yes, I tend to agree.  I've asked about this in
earlier work; my suggestion is to name the controller something like 'XPU' to
be clear that these controls could apply to more than GPU.

But at least for now, based on Tejun's reply [1], the feedback is to try and keep
this controller as small and focused as possible on just GPU.  At least until
we get some consensus on set of controls for GPU.....  but for this we need more
active input from community......

-Brian

[1] https://lists.freedesktop.org/archives/dri-devel/2019-November/243167.html

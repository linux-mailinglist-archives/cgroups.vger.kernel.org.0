Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6290767D3EA
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAZSQp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjAZSQe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 13:16:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C845E504;
        Thu, 26 Jan 2023 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674756984; x=1706292984;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fR8V4aQuW/ZVKBC+MbolGNbeqVBRPpZSaKYM1TDnfic=;
  b=hButNLzdVYQAzhOBJxi/+34liyGebvcPW8oIunwyZGLr9D/cVl/Blgux
   EM5qq0w+2UZv0XVja909bb2oBRCsP1GRXxNgQ3J81QtVPbuWBQmZOlRxp
   DhMOtBdUNNIo0Law9QYfh4GOhMJhK+Hl8koa1DJh5AAv7BQXl2JgmsPrb
   UxWVu9gQdEit91NFQ8W1vaJxEu9rzRxKTa2qpAgYskgPMCeO5zrUFR7Pn
   UXSRUozSnt3p30jfY7UzIqT2vd4LgvQK4K4PnjXCqZWTXGcFDK+FtiN02
   W7Tq7/nj40osRofc5R4fU6xERn2KMvObDFs4WPyYD//bIo0bDnXeYbbAr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413119264"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="413119264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:14:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695207731"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="695207731"
Received: from kbrennan-mobl.ger.corp.intel.com (HELO [10.213.233.58]) ([10.213.233.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:14:49 -0800
Message-ID: <2c14b00c-c3bc-75dd-361b-54c6846fc59a@linux.intel.com>
Date:   Thu, 26 Jan 2023 18:14:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v3 00/12] DRM scheduling cgroup controller
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
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
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230123154239.GA24348@blackbody.suse.cz>
 <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
 <20230126130050.GA22442@blackbody.suse.cz> <Y9KyiCPYj2Mzym3Z@slm.duckdns.org>
 <b8a0872c-fe86-b174-ca3b-0fc04a98e224@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <b8a0872c-fe86-b174-ca3b-0fc04a98e224@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 26/01/2023 17:57, Tvrtko Ursulin wrote:
> On 26/01/2023 17:04, Tejun Heo wrote:

>> driver folks think about the current RFC tho. Is at least AMD on board 
>> with
>> the approach?
> 
> Yes I am keenly awaiting comments from the DRM colleagues as well.

Forgot to mention one thing on this point which may interest AMD.

Some time ago I tested the super primitive "throttling via lowering the 
scheduling priority" on a GuC based i915 GPU, so only three supported 
priority levels, and FWIW it can be somewhat effective.

It certainly was effective for my main use case which is "run this GPU 
workload in the background while I use the GPU for something else".

The actual test was along the lines of running a GPU hog in parallel to 
an interactive client which can measure dropped frames.

With equal drm.weights the interactive client was seeing ~10 (i915 
pre-GuC) or ~27 (i915 GuC) dropped frames per second (60 fps target). 
With the GPU hog drm.weight lowered to 1:10 that dropped to ~3 dropped 
frames per second (all 3 before the over budget condition was noticed by 
the controller).

Main take here is that improved user experience is possible even with 
this primitive throttling method and even on GPUs which support only 
three scheduling priority levels.

Although main thing still is that individual drivers are completely free 
to improve their method of handling to the over budget signal. Nothing 
in the controller itself should be precluding that.

Regards,

Tvrtko

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FC67E95A
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjA0PV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 10:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0PV2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 10:21:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D871C32A;
        Fri, 27 Jan 2023 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674832887; x=1706368887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TEe+LuzRxflW6HpNyLU4rEMAiDmakglx8dNsR89Re44=;
  b=mZ8jyyWWHfhrQDYnOEGlGSJyrx9JsrsZ/CQmgOO9UpxpESZb8cqYklZf
   vGxm/ggxm8L4q1YIPw430V9z6tgnEtyHCWSaQj5fl/ym3he7m1ExS7hiQ
   QbyufHip6/QvEu5Mn+Qxe7h1OCGqzS9DlXiERO0Izptt6s7ESrrnrA1ny
   NAHM8gJilSZlQmkRoKRHsfXvhR1Ec7t8670icgcrNQWtFi6hTETyrCYaB
   3w//MyxNAQep0Jr50CA1ye0PUyzOBZf7uhnwg7npcktp4IkLA3XP0rbnI
   G5V0ZdVXJuITNeMSJSuPrBjYf+jrX+OIZ7Yt3MsH2IJS6+nBBVTuV0TIg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389481853"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="389481853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:21:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="752023992"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="752023992"
Received: from jgeary-mobl1.ger.corp.intel.com (HELO [10.213.233.162]) ([10.213.233.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:21:22 -0800
Message-ID: <63b6853a-f24f-d97b-0fea-6200a004c41f@linux.intel.com>
Date:   Fri, 27 Jan 2023 15:21:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 10/12] cgroup/drm: Introduce weight based drm cgroup control
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
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
 <20230112165609.1083270-11-tvrtko.ursulin@linux.intel.com>
 <20230127130134.GA15846@blackbody.suse.cz>
 <a96e6b5c-b538-f7e7-d603-cabb29137de7@linux.intel.com>
 <20230127141136.GG3527@blackbody.suse.cz>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230127141136.GG3527@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 27/01/2023 14:11, Michal Koutný wrote:
> On Fri, Jan 27, 2023 at 01:31:54PM +0000, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>> I think you missed the finish_suspend_scanning() part:
>>
>> 	if (root_drmcs.suspended_period_us)
>> 		cancel_delayed_work_sync(&root_drmcs.scan_work);
>>
>> So if scanning was in progress migration will wait until it finishes.
> 
> Indeed, I've missed that. Thank you!
> 
>> Not claiming I did not miss something because I was totally new with cgroup
>> internals when I started working on this. So it is definitely useful to have
>> more eyes looking.
> 
> The custom with (especially v2, especially horizontal) migrations
> is that they're treated leniently to avoid performance costs.
> 
> I'm afraid waiting for scan in can_attach() can propagate globally (via
> cgroup_update_dfl_csses() and cgroup_attach_lock()) sometimes.

That something along those lines might be a concern was indeed worrying 
me when coming up with the scheme. Good inside knowledge hint, thank 
you. I will have a deeper look.

> OTOH, unless I misunderstood, you need to cover explicit (not task but
> resource, when sending client FD around) migration anyway?

Correct. So far that was handled outside the cgroup controller in the 
drm layer and any lock dependency propagation was hidden behind RCU.
But that will likely change once I try your suggestion of eliminating 
the struct pid based client tracking and so become relevant.

> (I.e. my suggestion would be to mutualy exclude scanning and explicit
> migration but not scanning and task migration in order to avoid possible
> global propagation.)

Thanks, I will look into this all hopefully shortly. Perhaps what you 
suggest will come naturally with the removal of struct pid based tracking.

Regards,

Tvrtko

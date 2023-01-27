Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7267E6C2
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjA0NcE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjA0NcD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 08:32:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF77448F;
        Fri, 27 Jan 2023 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674826320; x=1706362320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7mC15fOVSE6NegzxHk/BX7UWkKB1AkE7p5o74pyZvt0=;
  b=FQuWs8hjrBVGcHF4IWhbLkPxigoAJ+8TMm+tL72Kw5mBIlLc8FtqUxj4
   y0H9jw3H9709it7RHmVedqxV9OYZ791r5l1PEVPP9AZmygWJH0xpyhkDM
   uyv8UvptWrsYwsR05TGEbQAith9JmLUHHovB5ZESjuBIravMUaH57sbIv
   8kM1tTcNFZSwoRNsPsOofO8pRwPnjlNK3KpcWILu2Rci+cTUDCeyFK37y
   UO/xJ8cUjyIx+ApHq8D6CJZJrEVXl/xcXELFppdczC5OyKxIhVOYQgyt8
   azQl7EcmGoNi0Kz5wLJ4U/8CHcJHsJkegGkc1FWoHvZjcDHvT9fJ9rHMK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325757614"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325757614"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:32:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="731836563"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="731836563"
Received: from jgeary-mobl1.ger.corp.intel.com (HELO [10.213.233.162]) ([10.213.233.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:31:56 -0800
Message-ID: <a96e6b5c-b538-f7e7-d603-cabb29137de7@linux.intel.com>
Date:   Fri, 27 Jan 2023 13:31:54 +0000
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
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230127130134.GA15846@blackbody.suse.cz>
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


On 27/01/2023 13:01, Michal Koutný wrote:
> On Thu, Jan 12, 2023 at 04:56:07PM +0000, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>> +static int drmcs_can_attach(struct cgroup_taskset *tset)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * As processes are getting moved between groups we need to ensure
>> +	 * both that the old group does not see a sudden downward jump in the
>> +	 * GPU utilisation, and that the new group does not see a sudden jump
>> +	 * up with all the GPU time clients belonging to the migrated process
>> +	 * have accumulated.
>> +	 *
>> +	 * To achieve that we suspend the scanner until the migration is
>> +	 * completed where the resume at the end ensures both groups start
>> +	 * observing GPU utilisation from a reset state.
>> +	 */
>> +
>> +	ret = mutex_lock_interruptible(&drmcg_mutex);
>> +	if (ret)
>> +		return ret;
>> +	start_suspend_scanning();
>> +	mutex_unlock(&drmcg_mutex);
>> +
>> +	finish_suspend_scanning();
> 
> Here's scanning suspension, communicated via
> 
> 	root_drmcs.scanning_suspended = true;
> 	root_drmcs.suspended_period_us = root_drmcs.period_us;
> 	root_drmcs.period_us = 0;
> 
> but I don't see those used in scan_worker() and the scanning traversal
> can apparently run concurrently with a task migration.

I think you missed the finish_suspend_scanning() part:

	if (root_drmcs.suspended_period_us)
		cancel_delayed_work_sync(&root_drmcs.scan_work);

So if scanning was in progress migration will wait until it finishes. 
And re-start only when migration is done (drmcs_attach), or it failed 
(drmcs_cancel_attach).

Not claiming I did not miss something because I was totally new with 
cgroup internals when I started working on this. So it is definitely 
useful to have more eyes looking.

>> [...]
>> +static bool
>> +__start_scanning(struct drm_cgroup_state *root, unsigned int period_us)
>> [...]
>> +	css_for_each_descendant_post(node, &root->css) {
>> [...]
>> +		active = drmcs_get_active_time_us(drmcs);
>> +		if (period_us && active > drmcs->prev_active_us)
>> +			drmcs->active_us += active - drmcs->prev_active_us;
>> +		drmcs->prev_active_us = active;
> 
> drmcs_get_active_time_us() could count a task's contribution here,
> the task would migrate to a different drmcs,
> and it'd be counted 2nd time.

Lets see.. __start_scanning() can be called from the worker, so max one 
instance at a time, no issue.

Then from resume scanning, so it is guaranteed worker is not running and 
can't restart since mutex guards the re-start.

Finally from drmcs_write_period_us() - yes there __start_scanning() can 
race with it being invoked by the worker - oops! However.. this is just 
a debugging aid as the cover letter explains. This file is not intended 
to be present in the final version, rather as per earlier discussion 
with Tejun the idea is to only have boot time option to control the 
functionality (enable/disable or period).

I will nevertheless try to fix this race up for the next posting to 
avoid further confusion!

Regards,

Tvrtko

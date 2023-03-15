Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED516BACB3
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 10:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjCOJyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjCOJxy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 05:53:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DC77CA8;
        Wed, 15 Mar 2023 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678873947; x=1710409947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gBg6Vr33FAryjFmPnYb0dmG82k9ImBYRN0MW7OCbJHU=;
  b=MFuh0nQPeDUWwjbq5zjWg/IEUboL4vL/pzfFypAOYJSMuNa+fz7deuA/
   nk1RbD8Z7epAnQ1sSLmOq1Kxuk7cJCYAaE2Oe37KkQ3+mv9Yx5qVfz6FO
   ylpeEGfcY6kyP0q2JhrlfSTmnLyfAOKRCE5/IRz5C8+8vASWuSLr50SOU
   ay+HjWdZx33v2u+lEHMndXCHNthwvSgOLhrqfbgPsMrOdUayvOwO9IWSg
   e6Hn3WmvyvTwJNw5fBT7wTJzjO+XDefpIARIvymliCI0IWfyigRrlSXrX
   BWaaf4Dk/syjoec6ps1tBgGlpzeW24wbl1J9brkkm3F/mncw34bZeM4WL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="326019499"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="326019499"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 02:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748355968"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748355968"
Received: from mchanan-mobl.ger.corp.intel.com (HELO [10.213.222.39]) ([10.213.222.39])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 02:52:22 -0700
Message-ID: <b3b63d6e-438e-1b5a-6d01-6164c2160f75@linux.intel.com>
Date:   Wed, 15 Mar 2023 09:52:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 01/10] drm: Track clients by tgid and not tid
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Zack Rusin <zackr@vmware.com>,
        linux-graphics-maintainer@vmware.com,
        Alex Deucher <alexander.deucher@amd.com>
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
 <20230314141904.1210824-2-tvrtko.ursulin@linux.intel.com>
 <2d4c10c7-6406-7458-4f52-4260b415874e@amd.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <2d4c10c7-6406-7458-4f52-4260b415874e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi,

On 14/03/2023 15:33, Christian König wrote:
> Am 14.03.23 um 15:18 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> Thread group id (aka pid from userspace point of view) is a more
>> interesting thing to show as an owner of a DRM fd, so track and show that
>> instead of the thread id.
>>
>> In the next patch we will make the owner updated post file descriptor
>> handover, which will also be tgid based to avoid ping-pong when multiple
>> threads access the fd.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Cc: Zack Rusin <zackr@vmware.com>
>> Cc: linux-graphics-maintainer@vmware.com
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Reviewed-by: Zack Rusin <zackr@vmware.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Should we push the already reviewed cleanups like this one to 
> drm-misc-next? That makes sense even without the rest of the 
> functionality and reduce the amount of patches re-send.

I don't have the commit rights so if you could do that I certainly would 
not mind, thanks!

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>>   drivers/gpu/drm/drm_debugfs.c           | 4 ++--
>>   drivers/gpu/drm/drm_file.c              | 2 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_gem.c     | 2 +-
>>   4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index d8e683688daa..863cb668e000 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -969,7 +969,7 @@ static int amdgpu_debugfs_gem_info_show(struct 
>> seq_file *m, void *unused)
>>            * Therefore, we need to protect this ->comm access using RCU.
>>            */
>>           rcu_read_lock();
>> -        task = pid_task(file->pid, PIDTYPE_PID);
>> +        task = pid_task(file->pid, PIDTYPE_TGID);
>>           seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
>>                  task ? task->comm : "<unknown>");
>>           rcu_read_unlock();
>> diff --git a/drivers/gpu/drm/drm_debugfs.c 
>> b/drivers/gpu/drm/drm_debugfs.c
>> index 4f643a490dc3..4855230ba2c6 100644
>> --- a/drivers/gpu/drm/drm_debugfs.c
>> +++ b/drivers/gpu/drm/drm_debugfs.c
>> @@ -80,7 +80,7 @@ static int drm_clients_info(struct seq_file *m, void 
>> *data)
>>       seq_printf(m,
>>              "%20s %5s %3s master a %5s %10s\n",
>>              "command",
>> -           "pid",
>> +           "tgid",
>>              "dev",
>>              "uid",
>>              "magic");
>> @@ -94,7 +94,7 @@ static int drm_clients_info(struct seq_file *m, void 
>> *data)
>>           bool is_current_master = drm_is_current_master(priv);
>>           rcu_read_lock(); /* locks pid_task()->comm */
>> -        task = pid_task(priv->pid, PIDTYPE_PID);
>> +        task = pid_task(priv->pid, PIDTYPE_TGID);
>>           uid = task ? __task_cred(task)->euid : GLOBAL_ROOT_UID;
>>           seq_printf(m, "%20s %5d %3d   %c    %c %5d %10u\n",
>>                  task ? task->comm : "<unknown>",
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index a51ff8cee049..c1018c470047 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -156,7 +156,7 @@ struct drm_file *drm_file_alloc(struct drm_minor 
>> *minor)
>>       if (!file)
>>           return ERR_PTR(-ENOMEM);
>> -    file->pid = get_pid(task_pid(current));
>> +    file->pid = get_pid(task_tgid(current));
>>       file->minor = minor;
>>       /* for compatibility root is always authenticated */
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c 
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
>> index d6baf73a6458..c0da89e16e6f 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
>> @@ -241,7 +241,7 @@ static int vmw_debugfs_gem_info_show(struct 
>> seq_file *m, void *unused)
>>            * Therefore, we need to protect this ->comm access using RCU.
>>            */
>>           rcu_read_lock();
>> -        task = pid_task(file->pid, PIDTYPE_PID);
>> +        task = pid_task(file->pid, PIDTYPE_TGID);
>>           seq_printf(m, "pid %8d command %s:\n", pid_nr(file->pid),
>>                  task ? task->comm : "<unknown>");
>>           rcu_read_unlock();
> 

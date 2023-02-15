Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A64697A02
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjBOKhB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjBOKgz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 05:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912183647C
        for <cgroups@vger.kernel.org>; Wed, 15 Feb 2023 02:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676457369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DULdTVfIZoN5gfe54AIlB0FglUr8CaQBCm49yRWhdM=;
        b=CgZ+cYfjvhwVCBJ8SgIa1eNrfT6zqK72UN/T4nPtWYtu+4zIjF+/lHu1fK/4iMUjUC3fyC
        c+FJI30UogSeYIKiacMetXAtVFzK59LuDiHkoKaBqwln1W0RqnAcaaU7EGCknm+A1hQ3lL
        NSS9yEAQJcsZEqQMPlTZQuT19GGwtac=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-_G0YOkJTMZSdlzaIiFEolg-1; Wed, 15 Feb 2023 05:36:09 -0500
X-MC-Unique: _G0YOkJTMZSdlzaIiFEolg-1
Received: by mail-pl1-f197.google.com with SMTP id d21-20020a170902cb9500b0019ab46166a3so3056566ply.5
        for <cgroups@vger.kernel.org>; Wed, 15 Feb 2023 02:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DULdTVfIZoN5gfe54AIlB0FglUr8CaQBCm49yRWhdM=;
        b=FnNvwS2fEYbJqNQYcCt1bo6bXUQ6WHJyYPHGgFvmHaLaadxiL3CQlS4XEB8bc9bBPd
         LnVS1KrV0wx0KH58w1sQXqVypXFzSLJYMJ5e1iOZvm2/Uyk//YpDJFjS2loSUC1ygr3I
         jzeLPH34q6T+YPC6pB9ZEOoV4bwkS5bIwVWqWcIvcZAiew/4BiIQEHVVSxvDpFZNkmox
         EvQb5TqmmYButwBlnShlr9xPtjIEDrQFBCSyWN5UGA2W5bI/sYAr6qDf2RLuMXZVOlGR
         9zMO/VrZM07lEpWp8gKH5JbJVQgjBFlFvJFLTvyIBZYXEl3fgdBEVgKMvyjUTpgMC0J7
         N72g==
X-Gm-Message-State: AO0yUKXQMPy+4UgSQgu98RJa7xo27EAUZWEID+rEmfn+X21QFYL0n2rY
        nLruO3FdEGYkC+9rXny8UnXJEuD7LWcLSX3zAl6us7tFylkuiOFt54+BzkDHzZrhYY2HyASROPo
        I7N2AWjRtqDzuT6aQBWFvHox0nh8I
X-Received: by 2002:a62:6386:0:b0:5a8:d774:b1bb with SMTP id x128-20020a626386000000b005a8d774b1bbmr1242717pfb.17.1676457367428;
        Wed, 15 Feb 2023 02:36:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9LIdiV+BZC34EN4XzgfYunSTZ8ydX5eez16+K7fnvylsGll/d6Y1RhpFXInG2c+mL+K9q5gA==
X-Received: by 2002:a62:6386:0:b0:5a8:d774:b1bb with SMTP id x128-20020a626386000000b005a8d774b1bbmr1242709pfb.17.1676457367110;
        Wed, 15 Feb 2023 02:36:07 -0800 (PST)
Received: from [10.72.12.170] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j21-20020aa78d15000000b00581c741f95csm11322638pfe.46.2023.02.15.02.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 02:36:06 -0800 (PST)
Message-ID: <90147a2b-982e-ae57-9b7c-062bee0fab07@redhat.com>
Date:   Wed, 15 Feb 2023 18:36:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: cgroup: deadlock between cpu_hotplug_lock and freezer_mutex
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230215072501.3764-1-hdanton@sina.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230215072501.3764-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hillf,

On 15/02/2023 15:25, Hillf Danton wrote:
> On Wed, 15 Feb 2023 10:07:23 +0800 Xiubo Li <xiubli@redhat.com>
>> Hi
>>
>> Recently when running some test cases for ceph we hit the following
>> deadlock issue in cgroup code. Has this been fixed ? I have checked the
>> latest code and it seems no any commit is fixing this.
>>
>> This call trace could also be found in
>> https://tracker.ceph.com/issues/58564#note-4, which is more friendly to
>> read.
>>
>>    ======================================================
>>    WARNING: possible circular locking dependency detected
>>    6.1.0-rc5-ceph-gc90f64b588ff #1 Tainted: G S
>>    ------------------------------------------------------
>>    runc/90769 is trying to acquire lock:
>>    ffffffff82664cb0 (cpu_hotplug_lock){++++}-{0:0}, at:
>> static_key_slow_inc+0xe/0x20
>>    #012but task is already holding lock:
>>    ffffffff8276e468 (freezer_mutex){+.+.}-{3:3}, at: freezer_write+0x89/0x530
>>    #012which lock already depends on the new lock.
>>    #012the existing dependency chain (in reverse order) is:
>>    #012-> #2 (freezer_mutex){+.+.}-{3:3}:
>>          __mutex_lock+0x9c/0xf20
>>          freezer_attach+0x2c/0xf0
>>          cgroup_migrate_execute+0x3f3/0x4c0
>>          cgroup_attach_task+0x22e/0x3e0
>>          __cgroup1_procs_write.constprop.12+0xfb/0x140
>>          cgroup_file_write+0x91/0x230
>>          kernfs_fop_write_iter+0x137/0x1d0
>>          vfs_write+0x344/0x4d0
>>          ksys_write+0x5c/0xd0
>>          do_syscall_64+0x34/0x80
>>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>    #012-> #1 (cgroup_threadgroup_rwsem){++++}-{0:0}:
>>          percpu_down_write+0x45/0x2c0
>>          cgroup_procs_write_start+0x84/0x270
>>          __cgroup1_procs_write.constprop.12+0x57/0x140
>>          cgroup_file_write+0x91/0x230
>>          kernfs_fop_write_iter+0x137/0x1d0
>>          vfs_write+0x344/0x4d0
>>          ksys_write+0x5c/0xd0
>>          do_syscall_64+0x34/0x80
>>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>    #012-> #0 (cpu_hotplug_lock){++++}-{0:0}:
>>          __lock_acquire+0x103f/0x1de0
>>          lock_acquire+0xd4/0x2f0
>>          cpus_read_lock+0x3c/0xd0
>>          static_key_slow_inc+0xe/0x20
>>          freezer_apply_state+0x98/0xb0
>>          freezer_write+0x307/0x530
>>          cgroup_file_write+0x91/0x230
>>          kernfs_fop_write_iter+0x137/0x1d0
>>          vfs_write+0x344/0x4d0
>>          ksys_write+0x5c/0xd0
>>          do_syscall_64+0x34/0x80
>>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>    #012other info that might help us debug this:
>>    Chain exists of:#012  cpu_hotplug_lock --> cgroup_threadgroup_rwsem
>> --> freezer_mutex
>>    Possible unsafe locking scenario:
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(freezer_mutex);
>>                                  lock(cgroup_threadgroup_rwsem);
>>                                  lock(freezer_mutex);
>>     lock(cpu_hotplug_lock);
>>    #012 *** DEADLOCK ***
> Thanks for your report.
>
> Change locking order if it is impossible to update freezer_active in atomic manner.
>
> Only for thoughts.

Sure, I will test this.

Thanks


>
> Hillf
> +++ linux-6.1.3/kernel/cgroup/legacy_freezer.c
> @@ -350,7 +350,7 @@ static void freezer_apply_state(struct f
>   
>   	if (freeze) {
>   		if (!(freezer->state & CGROUP_FREEZING))
> -			static_branch_inc(&freezer_active);
> +			static_branch_inc_cpuslocked(&freezer_active);
>   		freezer->state |= state;
>   		freeze_cgroup(freezer);
>   	} else {
> @@ -361,7 +361,7 @@ static void freezer_apply_state(struct f
>   		if (!(freezer->state & CGROUP_FREEZING)) {
>   			freezer->state &= ~CGROUP_FROZEN;
>   			if (was_freezing)
> -				static_branch_dec(&freezer_active);
> +				static_branch_dec_cpuslocked(&freezer_active);
>   			unfreeze_cgroup(freezer);
>   		}
>   	}
> @@ -379,6 +379,7 @@ static void freezer_change_state(struct
>   {
>   	struct cgroup_subsys_state *pos;
>   
> +	cpus_read_lock();
>   	/*
>   	 * Update all its descendants in pre-order traversal.  Each
>   	 * descendant will try to inherit its parent's FREEZING state as
> @@ -407,6 +408,7 @@ static void freezer_change_state(struct
>   	}
>   	rcu_read_unlock();
>   	mutex_unlock(&freezer_mutex);
> +	cpus_read_unlock();
>   }
>   
>   static ssize_t freezer_write(struct kernfs_open_file *of,
>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li


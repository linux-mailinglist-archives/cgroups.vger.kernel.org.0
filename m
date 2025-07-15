Return-Path: <cgroups+bounces-8740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE3AB063B2
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C80582198
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1026281;
	Tue, 15 Jul 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW6aBWGB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5377261D
	for <cgroups@vger.kernel.org>; Tue, 15 Jul 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595252; cv=none; b=GuEAbeyiND3bFQL42myK3DWM22kBj7qoZjXmyH8DNSUyf0MHVpX4e38Et8R/JORtIIw+gcW3E0GIiWhZW8Ml5fWwTtopGHVPiUlIq4E181ffZ3tZYOCoea1pxGUNBdX6Bm6aPZlTgX66f6MOUwiCnoCLIBWS47FJ2a/4/AQLsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595252; c=relaxed/simple;
	bh=QGDL0kvdCWFlRnKscgJjq+k+L0QvyBPNvfMVFZrVcWo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lQQKIqPcpjJ+KNP+zBsiUtotdKtcclCpffO1tBWODppmSDgTolj/CN0qDjBnfRnIH1RnxEiHlrmWGdirtVzE12z57h41NAS1GsfPggUwcj6jT2mhig36lH4/FCZ5/XynRNXpF+ftxiu/WaK9Vjq4RaUXCqbfeH72d98caPRYV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VW6aBWGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXwosRAk7cpmUzQUy+WVJ4W1gQSc+hb1c+UjkCUp6Uk=;
	b=VW6aBWGBQVMiFNXHP6ciyoAVrFbwZ+wcLfDhsvJWkkXXg/RGZG/7aJ5WllrI7LSRelWJQk
	pRMa7DkYPo3Imk2gyCYtns+ZrM1TG6Mp4+XJckWVCqrENGfLqCwIHnJ/xCeCUMJoN9eLtc
	Qd3iM4WQH4bRfG6M+5auS106rqVyass=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Hmy0AKg1Py2_X-KFTbKAUw-1; Tue, 15 Jul 2025 12:00:48 -0400
X-MC-Unique: Hmy0AKg1Py2_X-KFTbKAUw-1
X-Mimecast-MFC-AGG-ID: Hmy0AKg1Py2_X-KFTbKAUw_1752595248
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7da0850c9e5so923999985a.0
        for <cgroups@vger.kernel.org>; Tue, 15 Jul 2025 09:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595248; x=1753200048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXwosRAk7cpmUzQUy+WVJ4W1gQSc+hb1c+UjkCUp6Uk=;
        b=ml3S2wuWD42FySa6yO9JSdCdHHNRCmrU+G4OEVQ5SJcv86jjrfx3tVw0AuVJcw+SJU
         JT4HeH26XYZcZ5RFOYyh/AiMOpms5m1lNGalbIvkDIRxlyRIedpDCM2GOmENE4pnMreE
         eelGkNl9eJX44AZzYxpvVUOv0gUmHJtU9Rn46DBJEdhvw48veetSDecrAVS95kVLsWG2
         rN3zEnXyxAYzNQoFbaziqrXyHCk04MRBrsQYWY4h1D7U8mlTbgauV/7l47F3l2EBLaWZ
         t0KYgTZL1PpEKFBJilG3p0freZmr0X/Z5QrZ9mg+ixqw4/pQ4AG3zjAeF63dXgtxv39Q
         2sZQ==
X-Gm-Message-State: AOJu0YxAkpTSIwCeiq32T1LK69W6M1xKyeQt3cd1T4ck5GO5BjZcE2b6
	1UymAdKzHH2UpGEwU5o2r64fGFbdr8XBFGnaV/IgZzOIzQFAS1YE0tAsDj0eWlmbVhXfJqO80uW
	HZb2NwaCQMC9OmR3XlNTnyfiMONVZyBfKOy6FL+AhS0Fs2QeysuVaPBbHnuA=
X-Gm-Gg: ASbGncuobmrckzijRMFE63y5QaFzr77zvdn0gIZI2DvTqQbQZkL6qI2Slw/5E3IG+1t
	d6lSpe9edxwYPpt1ES3gBuhjQIDMTeZDd1Q6GTaV3Dq9yBSgnN1fpTSm+jlAqkafrXr8QsNZvtb
	+BdygDLUrxwMd/YXb4kMonsvoEyl57dCLzczobt/L+sdR9LnwDVBIHplJ4iXoHkei20DMZ0NE6w
	HpEkhK6kcvAuOciFAMkWqSUaiKG2Kohn+6vmPWLyp2wMctCrbE66uHrHiw7vvVbyZwax70IVCDp
	KbJwpRqI3/TVKnm/+o7ZcspM0/jvfTRejH4g5qD5Gd3c6Sado66fjssu1kk7n5o+vcXeyeVvQN1
	UfoDvH1hC4Q==
X-Received: by 2002:a05:620a:4592:b0:7e0:2c05:6b98 with SMTP id af79cd13be357-7e338be52fbmr423929285a.20.1752595247513;
        Tue, 15 Jul 2025 09:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OqdBxsggnkLBvim314ncx0zbBASpaeaktiw40LuYsgyHA1nGTYgcxijPhPza/ECjub3h5Q==
X-Received: by 2002:a05:620a:4592:b0:7e0:2c05:6b98 with SMTP id af79cd13be357-7e338be52fbmr423920985a.20.1752595246781;
        Tue, 15 Jul 2025 09:00:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3081e036esm240838585a.107.2025.07.15.09.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:00:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eec0c87e-b5bf-45b7-9eff-b84d53784678@redhat.com>
Date: Tue, 15 Jul 2025 12:00:43 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, peterz@infradead.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250715023340.3617147-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250715023340.3617147-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 10:33 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A kernel warning was observed in the cpuset migration path:
>
>       WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>       cgroup_migrate_execute+0x8df/0xf30
>       Call Trace:
>        cgroup_transfer_tasks+0x2f3/0x3b0
>        cpuset_migrate_tasks_workfn+0x146/0x3b0
>        process_one_work+0x5ba/0xda0
>        worker_thread+0x788/0x1220
>
> The issue can be reliably reproduced with:
>
>       # Setup test cpuset
>       mkdir /sys/fs/cgroup/cpuset/test
>       echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>       echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>
>       # Start test process
>       sleep 100 &
>       pid=$!
>       echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>       taskset -p 0xC $pid  # Bind to CPUs 2-3
>
>       # Take CPUs offline
>       echo 0 > /sys/devices/system/cpu/cpu3/online
>       echo 0 > /sys/devices/system/cpu/cpu2/online
>
> Root cause analysis:
> When tasks are migrated to top_cpuset due to CPUs going offline,
> cpuset_attach_task() sets the CPU affinity using cpus_attach which
> is initialized from cpu_possible_mask. This mask may include offline
> CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
> 1. cpus_attach (possible CPUs, may include offline)
> 2. p->user_cpus_ptr (original user-set mask)
> The resulting new_mask may contain only offline CPUs, causing the
> operation to fail.
>
> To resolve this issue, if the call to set_cpus_allowed_ptr fails, retry
> using the intersection of cpus_attach and cpu_active_mask.
>
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Suggested-by: Waiman Long <llong@redhat.com>
> Reported-by: Yang Lijin <yanglijin@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Thanking further about this problem, the cpuset patch that I proposed is 
just a bandage. It is better to fix the problem at its origin in 
kernel/sched/core.c. I have posted a new patch to do that.

Cheers,
Longman

>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..2cf788a8982a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   static cpumask_var_t cpus_attach;
>   static nodemask_t cpuset_attach_nodemask_to;
>   
> +/*
> + * Note that tasks in the top cpuset won't get update to their cpumasks when
> + * a hotplug event happens. So we include offline CPUs as well.
> + */
>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
>   	lockdep_assert_held(&cpuset_mutex);
> @@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	 * can_attach beforehand should guarantee that this doesn't
>   	 * fail.  TODO: have a better way to handle failure here
>   	 */
> -	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +	if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
> +		/*
> +		 * Since offline CPUs are included for top_cpuset,
> +		 * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
> +		 * only offline CPUs. Take out the offline CPUs and retry.
> +		 */
> +		if (cs == &top_cpuset)
> +			cpumask_and(cpus_attach, cpus_attach, cpu_active_mask);
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +	}
>   
>   	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
>   	cpuset1_update_task_spread_flags(cs, task);



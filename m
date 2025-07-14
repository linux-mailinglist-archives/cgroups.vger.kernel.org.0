Return-Path: <cgroups+bounces-8728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E2B0480E
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAED1A61203
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C2207A2A;
	Mon, 14 Jul 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtRJsetv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB31CD1F
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522392; cv=none; b=fQgYXhX9kEOWK143jOYMrexovz2YgbYDXV3roNTxDRA7YVMzNhC813/nuabRX3x9z0whR4zbpTzb4wvLopO6o6KEQTuLWHMQSD31Hev+Jup0HcsegM6JVHthJ2gleG8PeKCvu+v0DzGIKk5Oxsm5fKGiHjyTzEBrPRBfgS3TXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522392; c=relaxed/simple;
	bh=vQOqi9iZD6wccfid1TBvWsr440HmgFH1TPenVglGRzM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oYCgedbEVchg4f+Lko8wT4ulCm29y4eNShtuXrtXoZgrLSgLEZT8jQpcTWfzbcC42lUsNIIdlHVnmfaOqfXwcMrGi+wWbwEgGJlEMGtzrbca9XJs5OdUa7FtC/xNWFb/4s3WgM9mmSN0j/gx0vdW/nCsvRFPAqmTeSlf/Hdi4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtRJsetv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752522388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e77DmMCoRU1Wn+QB8qyXAVxRpVcBX5B1RuM9TG938xk=;
	b=LtRJsetvRIaXnxhNgSA7qbBpO38KBP3aGI5ZdIWH80j51vM7fzJ/jX5o6xL1hO5esDDhjD
	KAbvVGmAJAtNr/K9WbtFwmnCyPMPB8+vkX/YCIRnUfZGIZjxD94a77Tin9nZRSKpRQGPdF
	gCxxia1UcbUjOMkQ+3wLYcNzxQjMeBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-qR2bsB0gOzS6qR-rMJ2rxA-1; Mon, 14 Jul 2025 15:46:27 -0400
X-MC-Unique: qR2bsB0gOzS6qR-rMJ2rxA-1
X-Mimecast-MFC-AGG-ID: qR2bsB0gOzS6qR-rMJ2rxA_1752522387
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fab979413fso84444836d6.2
        for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522387; x=1753127187;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e77DmMCoRU1Wn+QB8qyXAVxRpVcBX5B1RuM9TG938xk=;
        b=F35cJB590MbZy0rBHbyh6Oj/4s0hoaL/Jga8RbAnp8Gk8b1VaJPdix/Iyce9wIh7lY
         g8LUEI0AxuCBhuXM5eRgp9e3MzHOTKbdMinAJAEThShHK7i2YHF9fUSNVIvbwmX5YnVi
         1jZe2otqWTzykab63027kk3K9egdOx3LYAJbfY7gRC0CYbFjTuAFf9X22aDbfOwOavH+
         OserDJv8jwjC9mSet9mDHPXo+VEeJVgSMu9KMdK5lqM2Ul285E4vVJSwCHYkOU3gpVtf
         ywOn29rjikMQtPX7DW/VU12jQs3dzL7TyyMs7YpuW3vtZl7FUa/+2yMNyQ/rmriPxQ8k
         Rzsg==
X-Gm-Message-State: AOJu0YzUWZkqqVgk3KHamTZwv2R4Tj+X/RbvYUUmx0QhyQES3urXuUDr
	lCzgahNxR9XXWNI9N/P0dhgbfJLQPglZagKlgsQgA8fUK8MD4irBBgNUsmttvrgXhOERga2klrk
	UH6rtpvNXK9AWJjZpvS5M81xhtG/pBCKo7ZHhyMUyzLqu8CP2dtYQ5AoSD/A=
X-Gm-Gg: ASbGncuBYY0IAsYstzkUuxyBRbFHv6kofBZF3wI8uyioY0mJu/8U2xW8fWU2VUg8R8c
	WcgYBbxkAw83dguDRq/ihe6KNd/gTMj2vulG7iQFIwdFQl4De1vn5jhMEvUojez6QXXGII7IN1l
	AafRDIZA1MKYPUu6FIC91M+J8B4D1ZyHLFY+AU5P1UID12Tw9fQ3ymfSZGBvHSebusMXHaFRZ/m
	U3LwbU5TdOmcAU2XL3JcDAmiHlYH8ext5Hr25OGISgTGaragsa+7//d65iYGi6HuQzzpl+igpoe
	f1BsnUsVsQIRyn8WnlMFK3z7b8GVRX2NkSZ8L5hlUpZC9dxSugHptFfCWC9jbSYPkR9ikIuNvj+
	ylget4DyJJw==
X-Received: by 2002:a05:6214:cc2:b0:704:7dfc:f56e with SMTP id 6a1803df08f44-704a3613b4dmr244553006d6.18.1752522386896;
        Mon, 14 Jul 2025 12:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElhu76RklpmkE20l9U4kG/pwoEeaDE5mQBdKQN+0kBAtrFc9uJ9PSyHoUopb1ufV0fL2J4VQ==
X-Received: by 2002:a05:6214:cc2:b0:704:7dfc:f56e with SMTP id 6a1803df08f44-704a3613b4dmr244552446d6.18.1752522386276;
        Mon, 14 Jul 2025 12:46:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71424sm50382696d6.85.2025.07.14.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 12:46:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0dac8a78-79d1-41d0-bc82-0c8af8db9104@redhat.com>
Date: Mon, 14 Jul 2025 15:46:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, peterz@infradead.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250714032311.3570157-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 11:23 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A kernel warning was observed in the cpuset migration path:
>
>      WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>      cgroup_migrate_execute+0x8df/0xf30
>      Call Trace:
>       cgroup_transfer_tasks+0x2f3/0x3b0
>       cpuset_migrate_tasks_workfn+0x146/0x3b0
>       process_one_work+0x5ba/0xda0
>       worker_thread+0x788/0x1220
>
> The issue can be reliably reproduced with:
>
>      # Setup test cpuset
>      mkdir /sys/fs/cgroup/cpuset/test
>      echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>      echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>
>      # Start test process
>      sleep 100 &
>      pid=$!
>      echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>      taskset -p 0xC $pid  # Bind to CPUs 2-3
>
>      # Take CPUs offline
>      echo 0 > /sys/devices/system/cpu/cpu3/online
>      echo 0 > /sys/devices/system/cpu/cpu2/online
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
> The fix changes cpus_attach initialization to use cpu_active_mask
> instead of cpu_possible_mask, ensuring we only consider online CPUs
> when setting the new affinity. This prevents the scenario where
> the intersection would result in an invalid CPU set.
>
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Reported-by: Yang Lijin <yanglijin@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..5401adbdffa6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	if (cs != &top_cpuset)
>   		guarantee_active_cpus(task, cpus_attach);
>   	else
> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
> +		cpumask_andnot(cpus_attach, cpu_active_mask,
>   			       subpartitions_cpus);
>   	/*
>   	 * can_attach beforehand should guarantee that this doesn't

Offline CPUs are explicitly included for tasks in top_cpuset. Can you 
try the following patch to see if it works?

Thanks,
Longman

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3bc4301466f3..acd70120228c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct 
cgroup_taskset *tset)
  static cpumask_var_t cpus_attach;
  static nodemask_t cpuset_attach_nodemask_to;

+/*
+ * Note that tasks in the top cpuset won't get update to their cpumasks 
when
+ * a hotplug event happens. So we include offline CPUs as well.
+ */
  static void cpuset_attach_task(struct cpuset *cs, struct task_struct 
*task)
  {
         lockdep_assert_held(&cpuset_mutex);
@@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, 
struct task_struct *task)
          * can_attach beforehand should guarantee that this doesn't
          * fail.  TODO: have a better way to handle failure here
          */
-       WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+       if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
+               /*
+                * Since offline CPUs are included for top_cpuset,
+                * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
+                * only offline CPUs. Take out the offline CPUs and retry.
+                */
+               if (cs == &top_cpuset)
+                       cpumask_and(cpus_attach, cpus_attach, 
cpu_active_mask);
+               WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+       }

         cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
         cpuset1_update_task_spread_flags(cs, task);



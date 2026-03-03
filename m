Return-Path: <cgroups+bounces-14568-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK1TGGEJp2k7bgAAu9opvQ
	(envelope-from <cgroups+bounces-14568-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:16:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E41F3786
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7748C30C7EE2
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A84A2E13;
	Tue,  3 Mar 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+v20/q4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515F496904
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554159; cv=none; b=tZlLEb1/6/8TXGFYTZ6H/yzHxLLJkhYL81Oy5MWuIPHIw9aeECgzv4H6KS/H0Zn6e3tNQuXp3fyUAueOvl5rTDMl9Fu1OjiJ28Y6ZUjYCkxh5F+aEEMnhx3xcfWnHSeLBFas5Iv4Pwy7uBdK6sttv7BUjazxkjWP8R2SH4Lfyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554159; c=relaxed/simple;
	bh=akDQhYOtKo7tEfR4mpv/Gy7p5q5J91eAOdn+8M51fdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw2qDufhqlCx4qAlJ+16Z5lN9igT76CK7dCoZpNFVVVkqjJeh42CVfYCuoL/uaPqfru1ObvaaRZnMf43nXhdUkk6x3KWfTdVX12dA/m7P3hZ91QuOU5PPbUH6FA/bMX9CNvDXCL50/G3d2nJe8cvcbz3IMN2OcaYtx8bpX8g1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+v20/q4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772554155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzSCbJR/VtGBu6zb1m/kKqEWAmdsH+6Wgot4P7Bc760=;
	b=T+v20/q4OEP0itmqNDaUHUosoHMeRotx1TFkTIgyfBqzh432R4/zu4+2ySRfGBudE7/vWw
	762YYURf2RQsp73miFzSKUaQELfrD6G1hCNNRjKHyo3PMfWNGtPhm7GgwQ7CMbBSO1EUmA
	ywv1TcDY5cnw7wrkg6J1f6Es93mkLv4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-2H7HGOKtO3GMZIXqiYklUg-1; Tue,
 03 Mar 2026 11:09:12 -0500
X-MC-Unique: 2H7HGOKtO3GMZIXqiYklUg-1
X-Mimecast-MFC-AGG-ID: 2H7HGOKtO3GMZIXqiYklUg_1772554147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A0371956068;
	Tue,  3 Mar 2026 16:09:07 +0000 (UTC)
Received: from [10.22.88.179] (unknown [10.22.88.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47B5E30001B9;
	Tue,  3 Mar 2026 16:09:03 +0000 (UTC)
Message-ID: <5132ea39-de35-4002-a053-4976dd5390bc@redhat.com>
Date: Tue, 3 Mar 2026 11:09:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Jon Hunter <jonathanh@nvidia.com>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: BB3E41F3786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14568-lists,cgroups=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/3/26 10:18 AM, Jon Hunter wrote:
> Hi Waiman,
>
> On 21/02/2026 18:54, Waiman Long wrote:
>> The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
>> for instance, when an isolated partition is invalidated because its
>> last active CPU has been put offline.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update() 
>> directly
>> from update_isolation_cpumasks() will likely cause deadlock. So we
>> have to defer any call to housekeeping_update() after the CPU hotplug
>> operation has finished. This is now done via the workqueue where
>> the update_hk_sched_domains() function will be invoked via the
>> hk_sd_workfn().
>>
>> An concurrent cpuset control file write may have executed the required
>> update_hk_sched_domains() function before the work function is 
>> called. So
>> the work function call may become a no-op when it is invoked.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 31 ++++++++++++++++---
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++++-
>>   2 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3d0d18bf182f..2c80bfc30bbc 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1323,6 +1323,16 @@ static void update_hk_sched_domains(void)
>>           rebuild_sched_domains_locked();
>>   }
>>   +/*
>> + * Work function to invoke update_hk_sched_domains()
>> + */
>> +static void hk_sd_workfn(struct work_struct *work)
>> +{
>> +    cpuset_full_lock();
>> +    update_hk_sched_domains();
>> +    cpuset_full_unlock();
>> +}
>> +
>>   /**
>>    * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by 
>> sibling cpusets
>>    * @parent: Parent cpuset containing all siblings
>> @@ -3795,6 +3805,7 @@ static void cpuset_hotplug_update_tasks(struct 
>> cpuset *cs, struct tmpmasks *tmp)
>>    */
>>   static void cpuset_handle_hotplug(void)
>>   {
>> +    static DECLARE_WORK(hk_sd_work, hk_sd_workfn);
>>       static cpumask_t new_cpus;
>>       static nodemask_t new_mems;
>>       bool cpus_updated, mems_updated;
>> @@ -3877,11 +3888,21 @@ static void cpuset_handle_hotplug(void)
>>       }
>>     -    if (update_housekeeping || force_sd_rebuild) {
>> -        mutex_lock(&cpuset_mutex);
>> -        update_hk_sched_domains();
>> -        mutex_unlock(&cpuset_mutex);
>> -    }
>> +    /*
>> +     * Queue a work to call housekeeping_update() & 
>> rebuild_sched_domains()
>> +     * There will be a slight delay before the HK_TYPE_DOMAIN 
>> housekeeping
>> +     * cpumask can correctly reflect what is in isolated_cpus.
>> +     *
>> +     * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item 
>> that
>> +     * is still pending. Before the pending bit is cleared, the work 
>> data
>> +     * is copied out and work item dequeued. So it is possible to queue
>> +     * the work again before the hk_sd_workfn() is invoked to 
>> process the
>> +     * previously queued work. Since hk_sd_workfn() doesn't use the 
>> work
>> +     * item at all, this is not a problem.
>> +     */
>> +    if (update_housekeeping || force_sd_rebuild)
>> +        queue_work(system_unbound_wq, &hk_sd_work);
>> +
>>       free_tmpmasks(ptmp);
>>   }
>>   diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh 
>> b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> index 0c5db118f2d1..dc2dff361ec6 100755
>> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> @@ -246,6 +246,9 @@ TEST_MATRIX=(
>>       "  C2-3:P1  C3:P1   .      .     O3=0    .      . .     0 
>> A1:2|A2: A1:P1|A2:P1"
>>       "  C2-3:P1  C3:P1   .      .    T:O2=0   .      . .     0 
>> A1:3|A2:3 A1:P1|A2:P-1"
>>       "  C2-3:P1  C3:P1   .      .      .    T:O3=0   . .     0 
>> A1:2|A2:2 A1:P1|A2:P-1"
>> +    "  C2-3:P1  C3:P2   .      .    T:O2=0   .      . .     0 
>> A1:3|A2:3 A1:P1|A2:P-2"
>> +    "  C1-3:P1  C3:P2   .      .      .    T:O3=0   . .     0 
>> A1:1-2|A2:1-2 A1:P1|A2:P-2 3|"
>> +    "  C1-3:P1  C3:P2   .      .      .    T:O3=0  O3=1 .     0 
>> A1:1-2|A2:3 A1:P1|A2:P2  3"
>>       "$SETUP_A123_PARTITIONS    .     O1=0    .      . .     0 
>> A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
>>       "$SETUP_A123_PARTITIONS    .     O2=0    .      . .     0 
>> A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
>>       "$SETUP_A123_PARTITIONS    .     O3=0    .      . .     0 
>> A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
>> @@ -762,7 +765,7 @@ check_cgroup_states()
>>   # only CPUs in isolated partitions as well as those that are 
>> isolated at
>>   # boot time.
>>   #
>> -# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
>> +# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
>>   # <isolcpus1> - expected sched/domains value
>>   # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not 
>> defined
>>   #
>> @@ -771,6 +774,7 @@ check_isolcpus()
>>       EXPECTED_ISOLCPUS=$1
>>       ISCPUS=${CGROUP2}/cpuset.cpus.isolated
>>       ISOLCPUS=$(cat $ISCPUS)
>> +    HKICPUS=$(cat /sys/devices/system/cpu/isolated)
>>       LASTISOLCPU=
>>       SCHED_DOMAINS=/sys/kernel/debug/sched/domains
>>       if [[ $EXPECTED_ISOLCPUS = . ]]
>> @@ -808,6 +812,11 @@ check_isolcpus()
>>       ISOLCPUS=
>>       EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
>>   +    #
>> +    # The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match 
>> $ISOLCPUS
>> +    #
>> +    [[ "$ISOLCPUS" != "$HKICPUS" ]] && return 1
>> +
>>       #
>>       # Use the sched domain in debugfs to check isolated CPUs, if 
>> available
>>       #
>
> We have a CPU hotplug test that cycles through all CPUs off-lining 
> them and on-lining them in different combinations. Since this change 
> was added to -next, this test is failing on our Tegra210 boards. 
> Bisecting the issue, it pointed to this commit and reverting this on 
> top of -next fixes the issue.
>
> The test is quite simple and part of Thierry's tegra-test suite [0].
>
> $ ./tegra-tests/tests/cpu.py --verbose hotplug
> cpu: hotplug: CPU#0: mask: 1
> cpu: hotplug: CPU#1: mask: 2
> cpu: hotplug: CPU#2: mask: 4
> cpu: hotplug: CPU#3: mask: 8
> cpu: hotplug: applying mask 0xf
> cpu: hotplug: applying mask 0xe
> cpu: hotplug: applying mask 0xd
> cpu: hotplug: applying mask 0xc
> cpu: hotplug: applying mask 0xb
> cpu: hotplug: applying mask 0xa
> ...
> cpu: hotplug: applying mask 0x1
> Traceback (most recent call last):
>   File "./tegra-tests/tests/cpu.py", line 159, in <module>
>     runner.standalone(module)
>   File "./tegra-tests/tests/runner.py", line 147, in standalone
>     log.test(log = log, args = args)
>   File "./tegra-tests/tests/cpu.py", line 29, in __call__
>     cpus.apply_mask(mask)
>   File "./tegra-tests/linux/system.py", line 149, in apply_mask
>     cpu.set_online(False)
>   File "./tegra-tests/linux/system.py", line 45, in set_online
>     self.online = online
> OSError: [Errno 16] Device or resource busy
>
> From looking at different runs it appears to fail at different places.
>
> Let me know if you have any thoughts.
>
> Thanks
> Jon
>
> [0] https://github.com/thierryreding/tegra-tests/blob/master/tests/cpu.py

Thanks for the report. Will take a further look into this problem and 
report back what I find.

Cheers,
Longman



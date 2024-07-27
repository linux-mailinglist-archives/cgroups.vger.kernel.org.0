Return-Path: <cgroups+bounces-3924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BE93DEB3
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 12:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DD7283A4C
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A80481B9;
	Sat, 27 Jul 2024 10:22:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896833080;
	Sat, 27 Jul 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075729; cv=none; b=Fwkq/mPoDNW8A3b1+G0o+2LfWDVnh/eiiE6Gs6MdKyVAyUB402hPJWETBbrYtCnI6pP29Y9uhCkT+icDPMqduKa4sM+QqjcM5m273kfzV1uLUeMkB82sUTlXYxBEo4tZ2cdMyb45X0ShYSuHpD5JvTK+CasWVsOKcJmhHSn806E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075729; c=relaxed/simple;
	bh=r/s221Qa+JOcOCXX6RgbsecWV+FYHIHcvmhcwWTZHPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IxZuSY50vTlHsm51VePAwryZgQ+FUSnfECMg7FoStyhLtjGT6NekQ+oVxbOQ61AoiZJWqF3N0e/S746jZ7E+FCWsLpUk0MFC3gaZ3S0Y+LVQOE4tQ95ZxSRGaVhQLX87AKROtaF4Q/DwZ2Dkgl5MkPnL1J/cftP64klCwl2jvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WWLCp1zNHzPsyl;
	Sat, 27 Jul 2024 18:17:42 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BF7651800A1;
	Sat, 27 Jul 2024 18:21:56 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 27 Jul
 2024 18:21:56 +0800
Message-ID: <e7d4e1ce-7c12-4a06-ad03-1291dc6f22b5@huawei.com>
Date: Sat, 27 Jul 2024 18:21:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: Hillf Danton <hdanton@sina.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, <tj@kernel.org>, <bpf@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240724110834.2010-1-hdanton@sina.com>
 <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
 <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/26 21:04, Michal Koutný wrote:
> Hello.
> 
> On Thu, Jul 25, 2024 at 09:48:36AM GMT, chenridong <chenridong@huawei.com> wrote:
>>>> This issue can be reproduced by the following methods:
>>>> 1. A large number of cpuset cgroups are deleted.
>>>> 2. Set cpu on and off repeatly.
>>>> 3. Set watchdog_thresh repeatly.
> 
> BTW I assume this is some stress testing, not a regular use scenario of
> yours, right?
> 
Yes, I have offered the scripts in Link(V1).

>>>>
>>>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>>>> acquired in different tasks, which may lead to deadlock.
>>>> It can lead to a deadlock through the following steps:
>>>> 1. A large number of cgroups are deleted, which will put a large
>>>>      number of cgroup_bpf_release works into system_wq. The max_active
>>>>      of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can not
>>>>      get cgroup_metux, it may cram system_wq, and it will block work
>>>>      enqueued later.
> 
> Who'd be the holder of cgroup_mutex preventing cgroup_bpf_release from
> progress? (That's not clear to me from your diagram.)
> 
This is a cumulative process. The stress testing deletes a large member 
of cgroups, and cgroup_bpf_release is asynchronous, competing with 
cgroup release works. You know, cgroup_mutex is used in many places. 
Finally, the number of `cgroup_bpf_release` instances in system_wq 
accumulates up to 256, and it leads to this issue.


> ...
>>> Given idle worker created independent of WQ_DFL_ACTIVE before handling
>>> work item, no deadlock could rise in your scenario above.
>>
>> Hello Hillf, did you mean to say this issue couldn't happen?
> 
> Ridong, can you reproduce this with CONFIG_PROVE_LOCKING (or do you have
> lockdep message from it aready)? It'd be helpful to get insight into
> the suspected dependencies.
> 
> Thanks,
> Michal


There is a part of logs, I hope that is enough.
Thanks.

[  955.972520]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  955.976820] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.979235] task:kworker/0:0     state:D stack:14824 pid:8     tgid:8 
     ppid:2      flags:00
[  955.982879] Workqueue: events cgroup_bpf_release
[  955.985403] Call Trace:
[  955.986851]  <TASK>
[  955.988108]  __schedule+0x393/0x1650
[  955.990202]  ? find_held_lock+0x2b/0x80
[  955.991481]  ? find_held_lock+0x2b/0x80
[  955.992734]  schedule+0x3e/0x130
[  955.993661]  schedule_preempt_disabled+0x15/0x30
[  955.995196]  __mutex_lock+0x6a7/0xce0
[  955.996443]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  955.997280]  ? cgroup_bpf_release+0x5c/0x360
[  955.999220]  ? cgroup_bpf_release+0x5c/0x360
[  956.000452]  ? __pfx_delay_tsc+0x10/0x10
[  956.001390]  cgroup_bpf_release+0x5c/0x360
[  956.002865]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.004836]  process_one_work+0x1f0/0x610
[  956.005974]  worker_thread+0x183/0x340
[  956.007115]  ? __pfx_worker_thread+0x10/0x10
[  956.008276]  kthread+0xd6/0x110
[  956.009291]  ? __pfx_kthread+0x10/0x10
[  956.010474]  ret_from_fork+0x34/0x50
[  956.011581]  ? __pfx_kthread+0x10/0x10
[  956.012741]  ret_from_fork_asm+0x1a/0x30
[  956.014069]  </TASK>
[  956.014875] INFO: task kworker/0:1:9 blocked for more than 327 seconds.
[  956.016724]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.018531] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.020718] task:kworker/0:1     state:D stack:14648 pid:9     tgid:9 
     ppid:2      flags:00
[  956.021664] Workqueue: events cgroup_bpf_release
[  956.024475] Call Trace:
[  956.025225]  <TASK>
[  956.025913]  __schedule+0x393/0x1650
[  956.026947]  ? find_held_lock+0x2b/0x80
[  956.027862]  ? find_held_lock+0x2b/0x80
[  956.029165]  schedule+0x3e/0x130
[  956.030012]  schedule_preempt_disabled+0x15/0x30
[  956.031474]  __mutex_lock+0x6a7/0xce0
[  956.032729]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.034174]  ? cgroup_bpf_release+0x5c/0x360
[  956.035561]  ? cgroup_bpf_release+0x5c/0x360
[  956.036839]  ? __pfx_delay_tsc+0x10/0x10
[  956.038046]  cgroup_bpf_release+0x5c/0x360
[  956.039261]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.041119]  process_one_work+0x1f0/0x610
[  956.042348]  worker_thread+0x183/0x340
[  956.043531]  ? __pfx_worker_thread+0x10/0x10
[  956.044993]  kthread+0xd6/0x110
[  956.045171]  ? __pfx_kthread+0x10/0x10
[  956.045306]  ret_from_fork+0x34/0x50
[  956.045428]  ? __pfx_kthread+0x10/0x10
[  956.045552]  ret_from_fork_asm+0x1a/0x30
[  956.046025]  </TASK>
[  956.046162] INFO: task kworker/2:0:30 blocked for more than 327 seconds.
[  956.046400]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.046566] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.047068] task:kworker/2:0     state:D stack:14152 pid:30 
tgid:30    ppid:2      flags:00
[  956.047377] Workqueue: events cgroup_bpf_release
[  956.047539] Call Trace:
[  956.047809]  <TASK>
[  956.047927]  __schedule+0x393/0x1650
[  956.048068]  ? find_held_lock+0x2b/0x80
[  956.048224]  ? find_held_lock+0x2b/0x80
[  956.048452]  schedule+0x3e/0x130
[  956.048561]  schedule_preempt_disabled+0x15/0x30
[  956.048881]  __mutex_lock+0x6a7/0xce0
[  956.049039]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.049203]  ? cgroup_bpf_release+0x5c/0x360
[  956.049441]  ? cgroup_bpf_release+0x5c/0x360
[  956.049584]  ? __pfx_delay_tsc+0x10/0x10
[  956.049887]  cgroup_bpf_release+0x5c/0x360
[  956.050038]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.050247]  process_one_work+0x1f0/0x610
[  956.050395]  worker_thread+0x183/0x340
[  956.050570]  ? __pfx_worker_thread+0x10/0x10
[  956.050925]  kthread+0xd6/0x110
[  956.051049]  ? __pfx_kthread+0x10/0x10
[  956.051177]  ret_from_fork+0x34/0x50
[  956.051294]  ? __pfx_kthread+0x10/0x10
[  956.051414]  ret_from_fork_asm+0x1a/0x30
[  956.051604]  </TASK>
[  956.051804] INFO: task kworker/3:0:35 blocked for more than 327 seconds.
[  956.052038]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.052222] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.052424] task:kworker/3:0     state:D stack:14968 pid:35 
tgid:35    ppid:2      flags:00
[  956.052964] Workqueue: events cgroup_bpf_release
[  956.053199] Call Trace:
[  956.053304]  <TASK>
[  956.053397]  __schedule+0x393/0x1650
[  956.053536]  ? find_held_lock+0x2b/0x80
[  956.053801]  ? find_held_lock+0x2b/0x80
[  956.054017]  schedule+0x3e/0x130
[  956.054166]  schedule_preempt_disabled+0x15/0x30
[  956.054312]  __mutex_lock+0x6a7/0xce0
[  956.054454]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.054645]  ? cgroup_bpf_release+0x5c/0x360
[  956.055025]  ? cgroup_bpf_release+0x5c/0x360
[  956.055200]  ? __pfx_delay_tsc+0x10/0x10
[  956.055347]  cgroup_bpf_release+0x5c/0x360
[  956.055479]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.055846]  process_one_work+0x1f0/0x610
[  956.056026]  worker_thread+0x183/0x340
[  956.056211]  ? __pfx_worker_thread+0x10/0x10
[  956.056354]  kthread+0xd6/0x110
[  956.056511]  ? __pfx_kthread+0x10/0x10
[  956.056636]  ret_from_fork+0x34/0x50
[  956.056949]  ? __pfx_kthread+0x10/0x10
[  956.057091]  ret_from_fork_asm+0x1a/0x30
[  956.057315]  </TASK>
[  956.057430] INFO: task kworker/2:1:48 blocked for more than 327 seconds.
[  956.057602]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.058009] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.058291] task:kworker/2:1     state:D stack:15016 pid:48 
tgid:48    ppid:2      flags:00
[  956.058555] Workqueue: events cgroup_bpf_release
[  956.058727] Call Trace:
[  956.058984]  <TASK>
[  956.059082]  __schedule+0x393/0x1650
[  956.059260]  ? find_held_lock+0x2b/0x80
[  956.059382]  ? find_held_lock+0x2b/0x80
[  956.059524]  schedule+0x3e/0x130
[  956.059636]  schedule_preempt_disabled+0x15/0x30
[  956.059965]  __mutex_lock+0x6a7/0xce0
[  956.060096]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.060344]  ? cgroup_bpf_release+0x5c/0x360
[  956.060529]  ? cgroup_bpf_release+0x5c/0x360
[  956.060828]  ? __pfx_delay_tsc+0x10/0x10
[  956.060980]  cgroup_bpf_release+0x5c/0x360
[  956.061114]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.061412]  process_one_work+0x1f0/0x610
[  956.061614]  worker_thread+0x183/0x340
[  956.062090]  ? __pfx_worker_thread+0x10/0x10
[  956.062278]  kthread+0xd6/0x110
[  956.062395]  ? __pfx_kthread+0x10/0x10
[  956.062544]  ret_from_fork+0x34/0x50
[  956.062807]  ? __pfx_kthread+0x10/0x10
[  956.062955]  ret_from_fork_asm+0x1a/0x30
[  956.063167]  </TASK>
[  956.063276] INFO: task kworker/3:1:49 blocked for more than 327 seconds.
[  956.063466]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.063646] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.064045] task:kworker/3:1     state:D stack:13592 pid:49 
tgid:49    ppid:2      flags:00
[  956.064339] Workqueue: events cgroup_bpf_release
[  956.064488] Call Trace:
[  956.064571]  <TASK>
[  956.064864]  __schedule+0x393/0x1650
[  956.065082]  ? find_held_lock+0x2b/0x80
[  956.065222]  ? find_held_lock+0x2b/0x80
[  956.065395]  schedule+0x3e/0x130
[  956.065521]  schedule_preempt_disabled+0x15/0x30
[  956.065945]  __mutex_lock+0x6a7/0xce0
[  956.066078]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.066240]  ? cgroup_bpf_release+0x5c/0x360
[  956.066396]  ? cgroup_bpf_release+0x5c/0x360
[  956.066542]  ? __pfx_delay_tsc+0x10/0x10
[  956.066777]  cgroup_bpf_release+0x5c/0x360
[  956.067008]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.067225]  process_one_work+0x1f0/0x610
[  956.067411]  worker_thread+0x183/0x340
[  956.067554]  ? __pfx_worker_thread+0x10/0x10
[  956.067934]  kthread+0xd6/0x110
[  956.068092]  ? __pfx_kthread+0x10/0x10
[  956.068234]  ret_from_fork+0x34/0x50
[  956.068426]  ? __pfx_kthread+0x10/0x10
[  956.068554]  ret_from_fork_asm+0x1a/0x30
[  956.068962]  </TASK>
[  956.069129] INFO: task kworker/3:2:69 blocked for more than 327 seconds.
[  956.069319]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.069484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.069842] task:kworker/3:2     state:D stack:14576 pid:69 
tgid:69    ppid:2      flags:00
[  956.070163] Workqueue: events cgroup_bpf_release
[  956.070312] Call Trace:
[  956.070419]  <TASK>
[  956.070510]  __schedule+0x393/0x1650
[  956.070948]  ? find_held_lock+0x2b/0x80
[  956.071104]  ? find_held_lock+0x2b/0x80
[  956.071280]  schedule+0x3e/0x130
[  956.071415]  schedule_preempt_disabled+0x15/0x30
[  956.071574]  __mutex_lock+0x6a7/0xce0
[  956.071888]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.072075]  ? cgroup_bpf_release+0x5c/0x360
[  956.072233]  ? cgroup_bpf_release+0x5c/0x360
[  956.072484]  ? __pfx_delay_tsc+0x10/0x10
[  956.072623]  cgroup_bpf_release+0x5c/0x360
[  956.073091]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.073395]  process_one_work+0x1f0/0x610
[  956.073582]  worker_thread+0x183/0x340
[  956.073981]  ? __pfx_worker_thread+0x10/0x10
[  956.074125]  kthread+0xd6/0x110
[  956.074308]  ? __pfx_kthread+0x10/0x10
[  956.074441]  ret_from_fork+0x34/0x50
[  956.074555]  ? __pfx_kthread+0x10/0x10
[  956.074834]  ret_from_fork_asm+0x1a/0x30
[  956.075067]  </TASK>
[  956.075407] INFO: task kworker/2:2:78 blocked for more than 327 seconds.
[  956.075593]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.076081] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.076375] task:kworker/2:2     state:D stack:14992 pid:78 
tgid:78    ppid:2      flags:00
[  956.076814] Workqueue: events cgroup_bpf_release
[  956.076993] Call Trace:
[  956.077081]  <TASK>
[  956.077174]  __schedule+0x393/0x1650
[  956.077369]  ? find_held_lock+0x2b/0x80
[  956.077524]  ? find_held_lock+0x2b/0x80
[  956.077796]  schedule+0x3e/0x130
[  956.077935]  schedule_preempt_disabled+0x15/0x30
[  956.078112]  __mutex_lock+0x6a7/0xce0
[  956.078261]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.078474]  ? cgroup_bpf_release+0x5c/0x360
[  956.078631]  ? cgroup_bpf_release+0x5c/0x360
[  956.079004]  ? __pfx_delay_tsc+0x10/0x10
[  956.079149]  cgroup_bpf_release+0x5c/0x360
[  956.079358]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.079604]  process_one_work+0x1f0/0x610
[  956.080047]  worker_thread+0x183/0x340
[  956.080186]  ? __pfx_worker_thread+0x10/0x10
[  956.080369]  kthread+0xd6/0x110
[  956.080480]  ? __pfx_kthread+0x10/0x10
[  956.080608]  ret_from_fork+0x34/0x50
[  956.080954]  ? __pfx_kthread+0x10/0x10
[  956.081123]  ret_from_fork_asm+0x1a/0x30
[  956.081286]  </TASK>
[  956.081386] INFO: task kworker/0:2:110 blocked for more than 327 seconds.
[  956.081621]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.082080] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.082313] task:kworker/0:2     state:D stack:14856 pid:110 
tgid:110   ppid:2      flags:00
[  956.082643] Workqueue: events cgroup_bpf_release
[  956.082995] Call Trace:
[  956.083091]  <TASK>
[  956.083226]  __schedule+0x393/0x1650
[  956.083366]  ? find_held_lock+0x2b/0x80
[  956.083531]  ? find_held_lock+0x2b/0x80
[  956.083977]  schedule+0x3e/0x130
[  956.084161]  schedule_preempt_disabled+0x15/0x30
[  956.084314]  __mutex_lock+0x6a7/0xce0
[  956.084450]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.084613]  ? cgroup_bpf_release+0x5c/0x360
[  956.085053]  ? cgroup_bpf_release+0x5c/0x360
[  956.085200]  ? __pfx_delay_tsc+0x10/0x10
[  956.085340]  cgroup_bpf_release+0x5c/0x360
[  956.085508]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.085919]  process_one_work+0x1f0/0x610
[  956.086098]  worker_thread+0x183/0x340
[  956.086235]  ? __pfx_worker_thread+0x10/0x10
[  956.086367]  kthread+0xd6/0x110
[  956.086478]  ? __pfx_kthread+0x10/0x10
[  956.086610]  ret_from_fork+0x34/0x50
[  956.087015]  ? __pfx_kthread+0x10/0x10
[  956.087156]  ret_from_fork_asm+0x1a/0x30
[  956.087368]  </TASK>
[  956.087456] INFO: task kworker/0:3:111 blocked for more than 327 seconds.
[  956.087631]       Not tainted 6.10.0-rc6-00163-g661e504db04c-dirty #135
[  956.088141] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  956.088397] task:kworker/0:3     state:D stack:14312 pid:111 
tgid:111   ppid:2      flags:00
[  956.088828] Workqueue: events cgroup_bpf_release
[  956.089092] Call Trace:
[  956.089200]  <TASK>
[  956.089308]  __schedule+0x393/0x1650
[  956.089480]  ? find_held_lock+0x2b/0x80
[  956.089624]  ? find_held_lock+0x2b/0x80
[  956.090053]  schedule+0x3e/0x130
[  956.090205]  schedule_preempt_disabled+0x15/0x30
[  956.090383]  __mutex_lock+0x6a7/0xce0
[  956.090503]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  956.090889]  ? cgroup_bpf_release+0x5c/0x360
[  956.091069]  ? cgroup_bpf_release+0x5c/0x360
[  956.091211]  ? __pfx_delay_tsc+0x10/0x10
[  956.091368]  cgroup_bpf_release+0x5c/0x360
[  956.091498]  ? trace_event_raw_event_workqueue_execute_start+0x52/0x90
[  956.092000]  process_one_work+0x1f0/0x610
[  956.092216]  worker_thread+0x183/0x340
[  956.092417]  ? __pfx_worker_thread+0x10/0x10
[  956.092558]  kthread+0xd6/0x110
[  956.092883]  ? __pfx_kthread+0x10/0x10
[  956.093102]  ret_from_fork+0x34/0x50
[  956.093229]  ? __pfx_kthread+0x10/0x10
[  956.093363]  ret_from_fork_asm+0x1a/0x30
[  956.093547]  </TASK>
[  956.093642] Future hung task reports are suppressed, see sysctl 
kernel.hung_task_warnings
[  956.139943]
[  956.139943] Showing all locks held in the system:
[  956.140446] 4 locks held by systemd/1:
[  956.140645]  #0: ffff8881021503f8 (sb_writers#7){....}-{0:0}, at: 
do_rmdir+0xde/0x1b0
[  956.141933]  #1: ffff8881025c1350 
(&type->i_mutex_dir_key#7/1){....}-{3:3}, at: do_rmdir+0x100
[  956.142365]  #2: ffff888105dd17d0 
(&type->i_mutex_dir_key#8){....}-{3:3}, at: vfs_rmdir+0x5b/0
[  956.142887]  #3: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_kn_lock_live+0x4e/0x0
[  956.143460] 3 locks held by kworker/0:0/8:
[  956.143825]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.144198]  #1: ffffc9000004be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.144560]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.145087] 3 locks held by kworker/0:1/9:
[  956.145256]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.145547]  #1: ffffc90000053e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.146180]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.146556] 3 locks held by kworker/2:0/30:
[  956.146926]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.147253]  #1: ffffc90000117e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.147632]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.148195] 3 locks held by kworker/3:0/35:
[  956.148331]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.148826]  #1: ffffc90000143e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.149171]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.149487] 1 lock held by khungtaskd/40:
[  956.149624]  #0: ffffffff82b58840 (rcu_read_lock){....}-{1:2}, at: 
debug_show_all_locks+0x36/0
[  956.150097] 3 locks held by kworker/2:1/48:
[  956.150252]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.150541]  #1: ffffc900001afe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.151173]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.151457] 3 locks held by kworker/3:1/49:
[  956.151619]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.152091]  #1: ffffc900001b7e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.152475]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.153026] 3 locks held by kworker/3:2/69:
[  956.153156]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.153471]  #1: ffffc90000dafe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.154094]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.154430] 3 locks held by kworker/2:2/78:
[  956.154589]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.155061]  #1: ffffc90000d5fe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.156230]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.156638] 3 locks held by kworker/0:2/110:
[  956.157016]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.157357]  #1: ffffc90000e43e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.157983]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.158303] 3 locks held by kworker/0:3/111:
[  956.158425]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.159041]  #1: ffffc90000e53e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.159390]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.159832] 3 locks held by kworker/3:3/113:
[  956.160005]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.160357]  #1: ffffc90000e6fe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.160912]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.161235] 3 locks held by kworker/0:4/122:
[  956.161388]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.161816]  #1: ffffc90000ebbe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.162164]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.162486] 3 locks held by kworker/0:5/124:
[  956.162605]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.163015]  #1: ffffc90000ec7e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.163406]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.163890] 3 locks held by kworker/3:4/126:
[  956.164045]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.164322]  #1: ffffc90000ed7e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.164906]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.165331] 4 locks held by systemd-udevd/127:
[  956.165463]  #0: ffff888103e376f8 (&p->lock){....}-{3:3}, at: 
seq_read_iter+0x59/0x4c0
[  956.166017]  #1: ffff888111081488 (&of->mutex){....}-{3:3}, at: 
kernfs_seq_start+0x27/0x110
[  956.166409]  #2: ffff8881008774d8 (kn->active#11){....}-{0:0}, at: 
kernfs_seq_start+0x2f/0x110
[  956.166953]  #3: ffff888237cae410 (&dev->mutex){....}-{3:3}, at: 
uevent_show+0x99/0x120
[  956.167248] 3 locks held by kworker/3:5/128:
[  956.167403]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.167965]  #1: ffffc90000e9be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.168292]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.168611] 3 locks held by kworker/0:6/132:
[  956.168952]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.169238]  #1: ffffc90000e77e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.169578]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.170047] 3 locks held by kworker/2:3/173:
[  956.170179]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.170485]  #1: ffffc90000e0fe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.171090]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.171455] 3 locks held by kworker/2:4/182:
[  956.171603]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.172039]  #1: ffffc90000f57e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.172365]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.172801] 1 lock held by in:imklog/204:
[  956.173012] 1 lock held by sshd/346:
[  956.173153] 4 locks held by systemd-udevd/388:
[  956.173299]  #0: ffff888103e378c8 (&p->lock){....}-{3:3}, at: 
seq_read_iter+0x59/0x4c0
[  956.173633]  #1: ffff888111080088 (&of->mutex){....}-{3:3}, at: 
kernfs_seq_start+0x27/0x110
[  956.174083]  #2: ffff8881008774d8 (kn->active#11){....}-{0:0}, at: 
kernfs_seq_start+0x2f/0x110
[  956.174410]  #3: ffff888237cae410 (&dev->mutex){....}-{3:3}, at: 
uevent_show+0x99/0x120
[  956.174882] 7 locks held by cpu_up_down.sh/389:
[  956.175110]  #0: ffff8881021413f8 (sb_writers#5){....}-{0:0}, at: 
ksys_write+0x69/0xf0
[  956.175440]  #1: ffff888111080288 (&of->mutex#2){....}-{3:3}, at: 
kernfs_fop_write_iter+0xf7/0
[  956.176030]  #2: ffff8881008776e8 (kn->active#54){....}-{0:0}, at: 
kernfs_fop_write_iter+0xff0
[  956.176355]  #3: ffffffff82c12ce8 (device_hotplug_lock){....}-{3:3}, 
at: online_store+0x42/0x0
[  956.176623]  #4: ffff888237cae410 (&dev->mutex){....}-{3:3}, at: 
device_online+0x24/0x90
[  956.177126]  #5: ffffffff82a67a48 (cpu_add_remove_lock){....}-{3:3}, 
at: cpu_up+0x31/0xb0
[  956.177436]  #6: ffffffff82a679b0 (cpu_hotplug_lock){....}-{0:0}, at: 
_cpu_up+0x32/0x1e0
[  956.178182] 3 locks held by watchdog.sh/391:
[  956.178362]  #0: ffff8881021403f8 (sb_writers#4){....}-{0:0}, at: 
ksys_write+0x69/0xf0
[  956.179092]  #1: ffffffff82b6ea48 (watchdog_mutex){....}-{3:3}, at: 
proc_watchdog_thresh+0x2f0
[  956.179377]  #2: ffffffff82a679b0 (cpu_hotplug_lock){....}-{0:0}, at: 
__lockup_detector_recon0
[  956.179996] 3 locks held by kworker/2:5/4630:
[  956.180188]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.180503]  #1: ffffc90007cebe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.181158]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.181517] 3 locks held by kworker/3:6/4635:
[  956.181640]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.182118]  #1: ffffc90007803e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.182542]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.183216] 3 locks held by kworker/0:7/4637:
[  956.183348]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.183827]  #1: ffffc90007ba3e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.184228]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.184523] 3 locks held by kworker/2:6/4640:
[  956.184812]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.185162]  #1: ffffc90007bf3e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.185518]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.186047] 3 locks held by kworker/3:7/4641:
[  956.186211]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.186508]  #1: ffffc90007d33e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.187106]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.187443] 3 locks held by kworker/0:8/4642:
[  956.187565]  #0: ffff888100064548 
((wq_completion)events){....}-{0:0}, at: process_one_work+00
[  956.188177]  #1: ffffc90007d3be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, a0
[  956.188589]  #2: ffffffff82b67d08 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0x5c/0x30
[  956.189051] 3 locks held by kworker/2:7/4643:


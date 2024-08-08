Return-Path: <cgroups+bounces-4168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452394B506
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 04:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EA11F2127D
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D64C2C6;
	Thu,  8 Aug 2024 02:22:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436C8F7D;
	Thu,  8 Aug 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083749; cv=none; b=UTsESXguPgcbqSMV2lCQZAwIt/NXGmnbR9dZgSrGI1YEV6wdkcI6m06l/jm+XuHUNI1f9ODQ5oH0E+2mnY54KbCZij/6qpsNBADvLkpzGguaKxx+u0pTvnPi0s8qkUwVrfcsHHhnAKtlt3BiQt3I+esJBdE8g/I7ak79RME38xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083749; c=relaxed/simple;
	bh=hNYNxJn1Gu4e4cnU+3Ow8D4IXYCa7RwMSJ3ds/xAtQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WH/fpv8ZUoDGuRSB08/mVP4LAJfaFgb8o3jfNLdzA2CYz6GsCLRrNcdF9O2cn1Q6Qtt8VQfhY9stX87gkpr05aBr4DBH5SdcxpfSWUIOoDqla9FxLn9o9BXJdQEsAsHzaA4jVmcy0DwZPMJWfvPv3QWNT3QTDprJLa8nJzj6bqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WfW5g1JDMzcdQY;
	Thu,  8 Aug 2024 10:22:15 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 24BA714041A;
	Thu,  8 Aug 2024 10:22:23 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 8 Aug
 2024 10:22:22 +0800
Message-ID: <8be4c357-a111-4134-b7de-ffa6f769c9e4@huawei.com>
Date: Thu, 8 Aug 2024 10:22:21 +0800
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
 <e7d4e1ce-7c12-4a06-ad03-1291dc6f22b5@huawei.com>
 <mxyismki3ln2pvrbhd36japfffpfcwgyvgmy5him3n746w6wd6@24zlflalef6x>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <mxyismki3ln2pvrbhd36japfffpfcwgyvgmy5him3n746w6wd6@24zlflalef6x>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/7 21:32, Michal Koutný wrote:
> Hello.
> 
> On Sat, Jul 27, 2024 at 06:21:55PM GMT, chenridong <chenridong@huawei.com> wrote:
>> Yes, I have offered the scripts in Link(V1).
> 
> Thanks (and thanks for patience).
> There is no lockdep complain about a deadlock (i.e. some circular
> locking dependencies). (I admit the multiple holders of cgroup_mutex
> reported there confuse me, I guess that's an artifact of this lockdep
> report and they could be also waiters.)
> 
>>> Who'd be the holder of cgroup_mutex preventing cgroup_bpf_release from
>>> progress? (That's not clear to me from your diagram.)
>>>
>> This is a cumulative process. The stress testing deletes a large member of
>> cgroups, and cgroup_bpf_release is asynchronous, competing with cgroup
>> release works.
> 
> Those are different situations:
> - waiting for one holder that's stuck for some reason (that's what we're
>    after),
> - waiting because the mutex is contended (that's slow but progresses
>    eventually).
> 
>> You know, cgroup_mutex is used in many places. Finally, the number of
>> `cgroup_bpf_release` instances in system_wq accumulates up to 256, and
>> it leads to this issue.
> 
> Reaching max_active doesn't mean that queue_work() would block or the
> items were lost. They are only queued onto inactive_works list.

Yes, I agree. But what if 256 active works can't finish because they are 
waiting for a lock? the works at inactive list can never be executed.
> (Remark: cgroup_destroy_wq has only max_active=1 but it apparently
> doesn't stop progress should there be more items queued (when
> when cgroup_mutex is not guarding losing references.))
> 
cgroup_destroy_wq is not stopped by cgroup_mutex, it has acquired 
cgroup_mutex, but it was blocked cpu_hotplug_lock.read. 
cpu_hotplug_lock.write is held by cpu offline process(step3).
> ---
> 
> The change on its own (deferred cgroup bpf progs removal via
> cgroup_destroy_wq instead of system_wq) is sensible by collecting
> related objects removal together (at the same time it shouldn't cause
> problems by sharing one cgroup_destroy_wq).
> 

> But the reasoning in the commit message doesn't add up to me. There
> isn't obvious deadlock, I'd say that system is overloaded with repeated
> calls of __lockup_detector_reconfigure() and it is not in deadlock
> state -- i.e. when you stop the test, it should eventually recover.
> Given that, I'd neither put Fixes: 4bfc0bb2c60e there.
> If I stop test, it can never recover. It does not need to be fixed if it 
could recover.
I have to admit, it is a complicated issue.

System_wq was not overloaded with __lockup_detector_reconfigure, but 
with cgroup_bpf_release_fn. A large number of cgroups were deleted. 
There were 256 active works in system_wq that were 
cgroup_bpf_release_fn, and they were all blocked by cgroup_mutex.

To make it simple, just imagine what if the max_active max_active of 
system_wq is 1? Could it result in a deadlock? If it could be deadlock, 
just imagine all works in system_wq are same.


> (One could symetrically argue to move smp_call_on_cpu() away from
> system_wq instead of cgroup_bpf_release_fn().)
> 
I also agree, why I move cgroup_bpf_release_fn away, cgroup has it own 
queue. As TJ said "system wqs are for misc things which shouldn't create 
a large number of concurrent work items. If something is going to 
generate 256+ concurrent work items, it should use its own workqueue."

> Honestly, I'm not sure it's worth the effort if there's no deadlock.
> 
There is a deadlock, and i think it have to be fixed.
> It's possible that I'm misunderstanding or I've missed a substantial
> detail for why this could lead to a deadlock. It'd be best visible in a
> sequence diagram with tasks/CPUs left-to-right and time top-down (in the
> original scheme it looks like time goes right-to-left and there's the
> unclear situation of the initial cgroup_mutex holder).
> 
> Thanks,
> Michal

I will modify the diagram.
And I hope you can understand how it leads to deadlock.
Thank you Michal for your reply.

Thanks,
Ridong


Return-Path: <cgroups+bounces-4449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56E95F22C
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6965D1F2307F
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0D8183CDA;
	Mon, 26 Aug 2024 12:53:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BE28366;
	Mon, 26 Aug 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676802; cv=none; b=DjIKpjJz71qURL0fmdgIBf2Oz30q2b0m5WYuwULGvj0k9Rjjb3FHbntRaDVOo6Izlsg/Tb315MqnBRJWP2NZJj72W9lRQmKe18jrVILcpNpuqREaE7NihATZvTflgbWIbYGFOurB2bY04yTbn1+J9BeoKpY+SOVVJh2x6ddSwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676802; c=relaxed/simple;
	bh=xcGbVNISfES7CZKICkbUNJVyNdU6CJ14L3t19uNG0P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxbCB+QPXtLI+KUxhvIN8Wr8Q8ViGATQm2YwsJHjyScGe0PqKSnfGZciFN2KyU3hB6VrSa5XGewRwfiIyBUwpk51v3sVE5vuaBPFcF8shc+UveoiigM9txKaMZwRCOPNx2BusDa07YMeBRqwMRZDv9lYjrJwq8pm7rgzBiib1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsrFG2hJpz4f3kpl;
	Mon, 26 Aug 2024 20:53:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3F0A31A07B6;
	Mon, 26 Aug 2024 20:53:16 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCX+ri6esxmB0u6Cg--.12158S2;
	Mon, 26 Aug 2024 20:53:16 +0800 (CST)
Message-ID: <153a238e-7b85-4334-9108-e665bcb233eb@huaweicloud.com>
Date: Mon, 26 Aug 2024 20:53:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 10/11] cgroup/cpuset: guard cpuset-v1 code under
 CONFIG_CPUSETS_V1
To: Waiman Long <longman@redhat.com>, tj@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823100110.472120-1-chenridong@huawei.com>
 <20240823100110.472120-11-chenridong@huawei.com>
 <de64f686-fccb-4d33-99d8-b8b44dc534fa@redhat.com>
 <bcbaeb36-ad90-47a0-b832-86eadefd3e6a@huaweicloud.com>
 <8aec8306-18aa-44af-81ba-dbb6ca9dcca0@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <8aec8306-18aa-44af-81ba-dbb6ca9dcca0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCX+ri6esxmB0u6Cg--.12158S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrJFyDCrWrXFy3Xw43Wrg_yoWrGrW3p3
	Z7GFyUCrWkJr1xGrWSqw4DAFyrtw48J3W7Jr17JFyUXw12yF1qvr1DXrn0gr1DJr4rGr4U
	tFZ3uw4a9r1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/26 10:18, Waiman Long wrote:
> On 8/25/24 21:34, Chen Ridong wrote:
>>
>>
>> On 2024/8/26 1:25, Waiman Long wrote:
>>> On 8/23/24 06:01, Chen Ridong wrote:
>>>> This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
>>>> CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
>>>> user who adopted v2 don't have 'pay' for cpuset v1.
>>>> Besides, to make code succinct, rename 
>>>> '__cpuset_memory_pressure_bump()'
>>>> to 'cpuset_memory_pressure_bump()', and expose it to the world, which
>>>> takes place of the old mocro 'cpuset_memory_pressure_bump'.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>   include/linux/cpuset.h          |  8 +-------
>>>>   init/Kconfig                    | 13 +++++++++++++
>>>>   kernel/cgroup/Makefile          |  3 ++-
>>>>   kernel/cgroup/cpuset-internal.h | 15 +++++++++++++++
>>>>   kernel/cgroup/cpuset-v1.c       | 10 ++++++----
>>>>   kernel/cgroup/cpuset.c          |  2 ++
>>>>   6 files changed, 39 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>>> index 2a6981eeebf8..f91f1f61f482 100644
>>>> --- a/include/linux/cpuset.h
>>>> +++ b/include/linux/cpuset.h
>>>> @@ -99,13 +99,7 @@ static inline bool cpuset_zone_allowed(struct 
>>>> zone *z, gfp_t gfp_mask)
>>>>   extern int cpuset_mems_allowed_intersects(const struct task_struct 
>>>> *tsk1,
>>>>                         const struct task_struct *tsk2);
>>>> -#define cpuset_memory_pressure_bump()                 \
>>>> -    do {                            \
>>>> -        if (cpuset_memory_pressure_enabled)        \
>>>> -            __cpuset_memory_pressure_bump();    \
>>>> -    } while (0)
>>>> -extern int cpuset_memory_pressure_enabled;
>>>> -extern void __cpuset_memory_pressure_bump(void);
>>>> +extern void cpuset_memory_pressure_bump(void);
>>>>   extern void cpuset_task_status_allowed(struct seq_file *m,
>>>>                       struct task_struct *task);
>>>
>>> As you are introducing a new CONFIG_CPUSET_V1 kconfig option, you can 
>>> use it to eliminate a useless function call if cgroup v1 isn't 
>>> enabled. Not just this function, all the v1 specific functions should 
>>> have a !CONFIG_CPUSET_V1 version that can be optimized out.
>>>
>>> Cheers,
>>> Longman
>>>
>>>
>> Hi, Longman, currently, we have only added one place to manage all the 
>> functions whose are empty if !CONFIG_CPUSET_V1 is not defined , and 
>> the caller does not need to care about using cpuset v1 or v2, which 
>> makes it succinct.
>>
>> However, we have to add !CONFIG_CPUSET_V1 to many places to avoid 
>> useless function calls. I am not opposed to do this if you thick it 'a 
>> better implementation.
> 
> You don't need to touch any files that use these cgroup v1 only 
> functions. You only need to add some #ifdef code in the cpuset.h header 
> file like
> 
> #ifdef CONFIG_CPUSET_V1
> extern void cpuset_memory_pressure_bump(void);
> #else
> static inline void cpuset_memory_pressure_bump(void) { }
> #endif
> 
> BTW, try not to introduce unnecessary performance regression. The reason 
> cpuset_memory_pressure_bump() is a macro is to avoid a function call if 
> cpuset_memory_pressure_enabled isn't set which is most likely case. It 
> is cheaper to read a variable than do a function call.
> 
> Cheers,
> Longman
> 
> 
> 
> 
Thank you for your patience, I just misunderstood.
I will do it in v2.

Best regards,
Ridong



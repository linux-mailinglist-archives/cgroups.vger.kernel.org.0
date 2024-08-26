Return-Path: <cgroups+bounces-4443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E052E95E654
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8590C1F21265
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B524A07;
	Mon, 26 Aug 2024 01:35:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB6321D;
	Mon, 26 Aug 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636111; cv=none; b=VKYvHuPuendbJ24jjrJGDhhc07Kd3Jyew6+YMbSyVbocpKQ3Xc4ZYwjt4D23XRzc5bFmTeM/NU5l7j31zEzCb7jC2PJhlCHE0tR0LNvcI7VI3VL7WMMQS26x7JaBwo08cq7G6aHX+ElBxzW06SAC7jfQuYFlJL72nnl6eF+lIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636111; c=relaxed/simple;
	bh=NAdz+o1KoUVh3TWqM8oCFuY5xeLKFpsOQchgZ9FQIic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LohMPgpKoH/kkwPl4qK+TRtW0+Oj2964q7TWGgwLeqrofxhJ+6LmRKL/PNiwMtAAPtrvm91BVeaa+Ty3LpeO5HXM5Xhg/oluwMFGFfpz5gHKn64xHK/5g8hhuW3h5qjtIw8GkrGbgttVR4q4gU5dmA1Lzhswr8JIxA57EVmPD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsYBX28Vbz4f3kvs;
	Mon, 26 Aug 2024 09:34:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A287C1A058E;
	Mon, 26 Aug 2024 09:34:59 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgBXu7nC28tmqvqOCg--.7987S2;
	Mon, 26 Aug 2024 09:34:59 +0800 (CST)
Message-ID: <bcbaeb36-ad90-47a0-b832-86eadefd3e6a@huaweicloud.com>
Date: Mon, 26 Aug 2024 09:34:58 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <de64f686-fccb-4d33-99d8-b8b44dc534fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXu7nC28tmqvqOCg--.7987S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry5Kw1UuFW3ur17GF4Durg_yoW5WFWfpF
	n7Gry8GrykJr1xG3yfXw1DAFyrtw48G3W7JryUJ3WUXw12yF1qvr1DXrn0gr1UJr48Gw1U
	tF47uw4Y9ryUJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/26 1:25, Waiman Long wrote:
> On 8/23/24 06:01, Chen Ridong wrote:
>> This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
>> CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
>> user who adopted v2 don't have 'pay' for cpuset v1.
>> Besides, to make code succinct, rename '__cpuset_memory_pressure_bump()'
>> to 'cpuset_memory_pressure_bump()', and expose it to the world, which
>> takes place of the old mocro 'cpuset_memory_pressure_bump'.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   include/linux/cpuset.h          |  8 +-------
>>   init/Kconfig                    | 13 +++++++++++++
>>   kernel/cgroup/Makefile          |  3 ++-
>>   kernel/cgroup/cpuset-internal.h | 15 +++++++++++++++
>>   kernel/cgroup/cpuset-v1.c       | 10 ++++++----
>>   kernel/cgroup/cpuset.c          |  2 ++
>>   6 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index 2a6981eeebf8..f91f1f61f482 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -99,13 +99,7 @@ static inline bool cpuset_zone_allowed(struct zone 
>> *z, gfp_t gfp_mask)
>>   extern int cpuset_mems_allowed_intersects(const struct task_struct 
>> *tsk1,
>>                         const struct task_struct *tsk2);
>> -#define cpuset_memory_pressure_bump()                 \
>> -    do {                            \
>> -        if (cpuset_memory_pressure_enabled)        \
>> -            __cpuset_memory_pressure_bump();    \
>> -    } while (0)
>> -extern int cpuset_memory_pressure_enabled;
>> -extern void __cpuset_memory_pressure_bump(void);
>> +extern void cpuset_memory_pressure_bump(void);
>>   extern void cpuset_task_status_allowed(struct seq_file *m,
>>                       struct task_struct *task);
> 
> As you are introducing a new CONFIG_CPUSET_V1 kconfig option, you can 
> use it to eliminate a useless function call if cgroup v1 isn't enabled. 
> Not just this function, all the v1 specific functions should have a 
> !CONFIG_CPUSET_V1 version that can be optimized out.
> 
> Cheers,
> Longman
> 
> 
Hi, Longman, currently, we have only added one place to manage all the 
functions whose are empty if !CONFIG_CPUSET_V1 is not defined , and the 
caller does not need to care about using cpuset v1 or v2, which makes it 
succinct.

However, we have to add !CONFIG_CPUSET_V1 to many places to avoid 
useless function calls. I am not opposed to do this if you thick it 'a 
better implementation.

Thanks,
Ridong



Return-Path: <cgroups+bounces-3942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D319405F9
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 05:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E47D1F2362A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9951448FA;
	Tue, 30 Jul 2024 03:34:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8412DD88;
	Tue, 30 Jul 2024 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310453; cv=none; b=IH/Cg/DgJIkQ5RgpfaIQFB9qSPMntCAb8PYVbZdMN79Hn4qHCuZTXKl3EPko7z/M/v7P5Jcyc+skblSAq9W7KthDLTQJwIZSZNunN50PpO+MxNnWIDb04FFH+eyfuo15of99V78ikLeIT4hUfQOXF59D5wBdyvMKHYgm94n1xNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310453; c=relaxed/simple;
	bh=215awUfrUo+9AO7Z7NY8YI8DBKl84utjMsfMUyusO7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBLbyzgZHTjZpCY6AUR4C7Kt0iKG/VDN0Hmw+5MaOWokZScNC9XMjePsyGxvn7PmLsmW90XNbIZo//jGf9ftXPMii7EnAqhWjMrfR01gA6jwMKgzVZ0g92o0EPpB2ZRrw7iXoolb9Hz64mKDLl/OP8eb0UZE0e0iH6EC+TPP1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WY16L0hBfz4f3kvN;
	Tue, 30 Jul 2024 11:33:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F09CE1A06D7;
	Tue, 30 Jul 2024 11:33:59 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP3 (Coremail) with SMTP id _Ch0CgBnGLcmX6hmPeL0AA--.30530S2;
	Tue, 30 Jul 2024 11:33:59 +0800 (CST)
Message-ID: <cd074750-172f-89e6-f46b-45c808b84d06@huaweicloud.com>
Date: Tue, 30 Jul 2024 11:33:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/pids: Avoid spurious event notification
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
References: <20240729105824.3665753-1-xiujianfeng@huaweicloud.com>
 <k2cfhjs33ch6dd2v3wzrs77dthcgavhaleinaxgt4oulaztekc@pikhtt5e52tc>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <k2cfhjs33ch6dd2v3wzrs77dthcgavhaleinaxgt4oulaztekc@pikhtt5e52tc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnGLcmX6hmPeL0AA--.30530S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW7Gw4ktrWfXF4xuFW7urg_yoW8trW7pF
	nxZFyrKrWrX3Z8u3WSqrnrZasxWa9ag34DCF4UJryxJrn7C3Z7Ja4IkF45XF1UZFy3W3s7
	Xa1Y9as8KryjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2024/7/30 0:07, Michal Koutný wrote:
> Hello.
> 
> On Mon, Jul 29, 2024 at 10:58:24AM GMT, Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
>> To address this issue, only the cgroups from 'pids_over_limit' to root
>> will have their PIDCG_MAX counter increased and event notifications
>> generated.
>>
> 
> For completeness here
> 
> Fixes: 385a635cacfe0 ("cgroup/pids: Make event counters hierarchical")>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  kernel/cgroup/pids.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> 
> 
>> @@ -257,15 +256,11 @@ static void pids_event(struct pids_cgroup *pids_forking,
>>  	    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
>>  		return;
>>  
>> -	for (; parent_pids(p); p = parent_pids(p)) {
>> -		if (p == pids_over_limit) {
>> -			limit = true;
>> -			atomic64_inc(&p->events_local[PIDCG_MAX]);
>> -			cgroup_file_notify(&p->events_local_file);
>> -		}
>> -		if (limit)
>> -			atomic64_inc(&p->events[PIDCG_MAX]);
>> +	atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
>> +	cgroup_file_notify(&pids_over_limit->events_local_file);
>>  
>> +	for (p = pids_over_limit; parent_pids(p); p = parent_pids(p)) {
>> +		atomic64_inc(&p->events[PIDCG_MAX]);
>>  		cgroup_file_notify(&p->events_file);
>>  	}
> 
> When I look at it applied altogther, there's one extra notification
> (heritage of forkfail events), it should be fixed with:
> 
> --- a/kernel/cgroup/pids.c
> +++ b/kernel/cgroup/pids.c
> @@ -251,10 +251,11 @@ static void pids_event(struct pids_cgroup *pids_forking,
>                 pr_cont_cgroup_path(p->css.cgroup);
>                 pr_cont("\n");
>         }
> -       cgroup_file_notify(&p->events_local_file);
>         if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
> -           cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
> +           cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS) {
> +               cgroup_file_notify(&p->events_local_file);
>                 return;
> +       }

Thanks, looks good, will do in the next version.

>  
>         atomic64_inc(&pids_over_limit->events_local[PIDCG_MAX]);
>         cgroup_file_notify(&pids_over_limit->events_local_file);
> 
> Besides that it makes sense to me.
> 
> Thanks,
> Michal



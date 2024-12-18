Return-Path: <cgroups+bounces-5962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778819F6099
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608261885B4F
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07590158208;
	Wed, 18 Dec 2024 09:00:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153081922F6;
	Wed, 18 Dec 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512447; cv=none; b=mco8bXgsSnlV9dyaICp7B6eH/FTWUgfjUKpi6Ny43/YnsStO7Wv15LOEnq2+me2w2wQ0Wi2XOLYOfFYQD15mhhES3mthgZLox4/opUIymETrHqGaCGFnAQOpUltUySeMHRoLSFib24LbTB2y6C6MmC1/j3ieufbvSf4cTIE2Uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512447; c=relaxed/simple;
	bh=iHVkWEtt4j2t063KxaEE/3ClKaWQq0T/VndFs9JQEf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGrP/BIshAi5jpL+ak+ZB6xJytFfVyJuKqEo7Pp7bD5M9MR2dHCAOBband1BAmT2OUfz/XF+ZyZaPx1dQMnNvVzBrZHT2jE/00zpfjPdn7sFZFLLb221JS/kABNWCkwVHQ4ywSB7jx8ivARsCix/6S3SbF5zI+gN4UlASfnNRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCnh345Rtz4f3lVs;
	Wed, 18 Dec 2024 17:00:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1FA991A07BA;
	Wed, 18 Dec 2024 17:00:40 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAHr7A2j2JnGiFEEw--.54528S2;
	Wed, 18 Dec 2024 17:00:39 +0800 (CST)
Message-ID: <02f7d744-f123-4523-b170-c2062b5746c8@huaweicloud.com>
Date: Wed, 18 Dec 2024 17:00:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
To: Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, vbabka@suse.cz, handai.szj@taobao.com,
 rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
 <Z2F0ixNUW6kah1pQ@tiehlicka>
 <872c5042-01d6-4ff3-94bc-8df94e1e941c@huaweicloud.com>
 <Z2KAJZ4TKZnGxsOM@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z2KAJZ4TKZnGxsOM@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAHr7A2j2JnGiFEEw--.54528S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF18ZFyrCr4kZw1fur1rJFb_yoW5Cr1fpF
	yDWasFyws8uay0qrnFvw1vvr1Sy392kF4jgr4ktryFyrn0qw1Svryjy3y3uryfZFn2yF12
	vF4j9w17Wr1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/18 15:56, Michal Hocko wrote:
> On Wed 18-12-24 15:44:34, Chen Ridong wrote:
>>
>>
>> On 2024/12/17 20:54, Michal Hocko wrote:
>>> On Tue 17-12-24 12:18:28, Chen Ridong wrote:
>>> [...]
>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>>> index 1c485beb0b93..14260381cccc 100644
>>>> --- a/mm/oom_kill.c
>>>> +++ b/mm/oom_kill.c
>>>> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
>>>>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
>>>>  		return 0;
>>>>  
>>>> +	cond_resched();
>>>>  	task = find_lock_task_mm(p);
>>>>  	if (!task) {
>>>>  		/*
>>>
>>> This is called from RCU read lock for the global OOM killer path and I
>>> do not think you can schedule there. I do not remember specifics of task
>>> traversal for crgoup path but I guess that you might need to silence the
>>> soft lockup detector instead or come up with a different iteration
>>> scheme.
>>
>> Thank you, Michal.
>>
>> I made a mistake. I added cond_resched in the mem_cgroup_scan_tasks
>> function below the fn, but after reconsideration, it may cause
>> unnecessary scheduling for other callers of mem_cgroup_scan_tasks.
>> Therefore, I moved it into the dump_task function. However, I missed the
>> RCU lock from the global OOM.
>>
>> I think we can use touch_nmi_watchdog in place of cond_resched, which
>> can silence the soft lockup detector. Do you think that is acceptable?
> 
> It is certainly a way to go. Not the best one at that though. Maybe we
> need different solution for the global and for the memcg OOMs. During
> the global OOM we rarely care about latency as the whole system is
> likely to struggle. Memcg ooms are much more likely. Having that many
> tasks in a memcg certainly requires a further partitioning so if
> configured properly the OOM latency shouldn't be visible much. But I am
> wondering whether the cgroup task iteration could use cond_resched while
> the global one would touch_nmi_watchdog for every N iterations. I might
> be missing something but I do not see any locking required outside of
> css_task_iter_*.

Do you mean like that:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436..9d197a731841 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5023,7 +5023,7 @@ struct task_struct *css_task_iter_next(struct
css_task_iter *it)
        }

        spin_unlock_irqrestore(&css_set_lock, irqflags);
-
+       cond_resched();
        return it->cur_task;
 }

@@ -433,8 +433,10 @@ static void dump_tasks(struct oom_control *oc)
                struct task_struct *p;

                rcu_read_lock();
-               for_each_process(p)
+               for_each_process(p) {
+                       touch_nmi_watchdog();
                        dump_task(p, oc);
+               }
                rcu_read_unlock();
        }


The 'css_task_iter_*' functions are used in many places. We should be
very careful when adding cond_resched within these functions. I don't
see any RCU or spinlock usage outside of css_task_iter_*, except for
mutex locks, such as in cgroup_do_freeze.

And perhaps Tj will have some opinions on this?

Best regards,
Ridong



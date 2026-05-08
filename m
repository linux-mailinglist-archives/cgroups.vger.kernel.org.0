Return-Path: <cgroups+bounces-15672-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0sB5dM/WmUaAAAu9opvQ
	(envelope-from <cgroups+bounces-15672-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 04:38:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76D4F0E0C
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 04:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C90302F391
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D527E05F;
	Fri,  8 May 2026 02:34:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8321D590;
	Fri,  8 May 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207681; cv=none; b=K/jTb2s1YrnNNxoQSzoq+M2jRKm8XK6tkcntLWscPrWrvUb1egGBpc8R80yjBAiBYCxKZt9IkyOpc5qbdHZ8iFX0sPybsLjYQ4EtpKsWEDqlRRaLfdoMyZeEILsCCI1Himr04O9wfdSPBPknWPDp9U7gdKnUBruYHh85joDlqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207681; c=relaxed/simple;
	bh=yqAPr+L7+pskUBuH/ID4imCmvtdA37YvmxMz/JHx+4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/HdvHR9s/yw/8p9kFsp9tjlvmBEi43ePP3DwKJ7JvESOpb75/8krB0z3ocHhnLslghmQ3oNTxtxwygOOfDwcwwa0c4cfnf8WHLfe2dOvejNp37388kcXFC273SSIZUOZvavjcG9khTgLC43f1HQTQHpxrBOl8Cqv+RlL+i8R6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gBXjJ59rnzKHMsH;
	Fri,  8 May 2026 10:13:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1B4AB40574;
	Fri,  8 May 2026 10:14:26 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHYP4AR_1pHZL1BQ--.1677S2;
	Fri, 08 May 2026 10:14:25 +0800 (CST)
Message-ID: <5d69e8bb-c925-4de2-8d50-0880b23864e0@huaweicloud.com>
Date: Fri, 8 May 2026 10:14:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Waiman Long <longman@redhat.com>, Guopeng Zhang
 <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-2-zhangguopeng@kylinos.cn>
 <6410d11c-1d8a-4e72-ac22-43058027b304@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6410d11c-1d8a-4e72-ac22-43058027b304@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHYP4AR_1pHZL1BQ--.1677S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48Xw18urWkGw1Duw15Jwb_yoW5Ar4kpF
	1vgryUtryYvFykKa17Kw1UWry2qw18X3WUKrn5ta48Jr17AFyj9r1UWrn0gr1UJr4xGa45
	JF1Uuw17uF1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Rspamd-Queue-Id: 6E76D4F0E0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.991];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15672-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,huaweicloud.com:mid]
X-Rspamd-Action: no action



On 2026/5/7 22:31, Waiman Long wrote:
> On 5/7/26 6:33 AM, Guopeng Zhang wrote:
>> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
>> state in the destination cpuset while walking the taskset.
>>
>> If a later task_can_attach() or security_task_setscheduler() check
>> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
>> and does not call cpuset_cancel_attach() for it. The partially
>> accumulated state is then left behind and can be consumed by a later
>> attach, corrupting cpuset DL task accounting and pending DL bandwidth
>> accounting.
>>
>> Reset the pending DL migration state before returning from those
>> per-task failure paths.
>>
>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>   kernel/cgroup/cpuset.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e3a081a07c6d..ae41736399a1 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>       cgroup_taskset_for_each(task, css, tset) {
>>           ret = task_can_attach(task);
>>           if (ret)
>> -            goto out_unlock;
>> +            goto out_reset_dl_data;
>>             if (setsched_check) {
>>               ret = security_task_setscheduler(task);
>>               if (ret)
>> -                goto out_unlock;
>> +                goto out_reset_dl_data;
>>           }
>>             if (dl_task(task)) {
>> @@ -3070,6 +3070,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>        * changes which zero cpus/mems_allowed.
>>        */
>>       cs->attach_in_progress++;
>> +    goto out_unlock;
>> +
>> +out_reset_dl_data:
>> +    reset_migrate_dl_data(cs);
>>   out_unlock:
>>       mutex_unlock(&cpuset_mutex);
>>       return ret;
> 
> I would prefer the likely success path be a straight line instead of doing a
> goto. IOW, move out_reset_dl_data below return. Other than that, this patch
> looks good to me.
> 

I've read the code and found several places that call reset_migrate_dl_data(cs).

I think it would be better to call reset_migrate_dl_data(cs) only when we
encounter an error, for example:

```
static int cpuset_can_attach(struct cgroup_taskset *tset)
{
...
out_unlock:
	if (ret)
		reset_migrate_dl_data(cs);
	mutex_unlock(&cpuset_mutex);
	return ret;
}
```
After that, no other places would need to call reset_migrate_dl_data(cs), right?

-- 
Best regards,
Ridong



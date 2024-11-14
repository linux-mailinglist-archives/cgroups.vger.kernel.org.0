Return-Path: <cgroups+bounces-5550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1AE9C8434
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 08:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6131B239E4
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F61F7559;
	Thu, 14 Nov 2024 07:48:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0F1F7544;
	Thu, 14 Nov 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570493; cv=none; b=Qa3uWx7+3ge6FFNU6uPkJDDlk2Mvb0CVGiZXgQy+HQTdg2EcTB5tHbt/H8aVo4SebvSNW1mxZgaviZbRCfc/8Wo1XV3bZfoTioyDRaiD7mUU0X7xtH+sftBucPdT8pWDf3UIxWriM/AbAd7o2J9cTDBaWOPFfZTkuHeDaPNILUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570493; c=relaxed/simple;
	bh=/X/lqXT5kCe1MZeScw8zFh9gO602/wZFaNkoS8k0Nt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSXPpLzG4sAsPfnZNy2XanYx6DYNd2qsLLMH10zz/lDVi9UJeNAlrmxFkdYPM4qleXbkO4lz9XmtcQ8+JeRFaeDDKQmSqmb6Nz/nJJOb2GrUB7nAlLSiEn2xYUw026M+RCUH1c+W0jppdDQgSy+WRIyTJC9TED74hLn6mjjw7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xpsgy1vmNz4f3nTX;
	Thu, 14 Nov 2024 15:47:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 68B781A0194;
	Thu, 14 Nov 2024 15:48:01 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBH77AuqzVnoVPRBg--.6215S2;
	Thu, 14 Nov 2024 15:47:59 +0800 (CST)
Message-ID: <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
Date: Thu, 14 Nov 2024 15:47:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
To: Valentin Schneider <vschneid@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 cgroups@vger.kernel.org
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBH77AuqzVnoVPRBg--.6215S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfWFWftw43ZF48uw4kJFb_yoW5WFWkpF
	ZxZr47Gan7Kry0krnrZw47WFyvgws2vr17Cr98WrWxKa45JFn09rn2vry5KF4UZrWFyFW7
	Aa1Yvr97C3yqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/13 22:34, Valentin Schneider wrote:
> On 11/11/24 13:54, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
>> logic"), the frozen task stat was reported as 'D' in cgroup v1.
>> However, after rewriting core freezer logic, the frozen task stat is
>> reported as 'R'. This is confusing, especially when a task with stat of
>> 'S' is frozen.
>>
>> This can be reproduced as bellow step:
>> cd /sys/fs/cgroup/freezer/
>> mkdir test
>> sleep 1000 &
>> [1] 739         // task whose stat is 'S'
>> echo 739 > test/cgroup.procs
>> echo FROZEN > test/freezer.state
>> ps -aux | grep 739
>> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
>>
>> As shown above, a task whose stat is 'S' was changed to 'R' when it was
>> frozen. To solve this issue, simply maintain the same reported state as
>> before the rewrite.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  include/linux/sched.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index f0f23efdb245..878acce2f8d6 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>>  	 * We're lying here, but rather than expose a completely new task state
>>  	 * to userspace, we can make this appear as if the task has gone through
>>  	 * a regular rt_mutex_lock() call.
>> +	 * Report the frozen task uninterruptible.
>>  	 */
>> -	if (tsk_state & TASK_RTLOCK_WAIT)
>> +	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)
> 
> Hmph, for RTLOCK this was good enough since !PREEMPT_RT really would be
> TASK_UNINTERRUPTIBLE. 
> 
> For the freezer AFAICT there's more variation, following your example:
> 

Thank you for your reply.
I tried to freeze a task whose stat is 'R', the saved_state is variable.

crash> task -R __state,saved_state 821
PID: 821    TASK: ffff888101df8000  CPU: 6   COMMAND: "test.sh"
  __state = 32768,
  saved_state = 0,

However, if a task is frozen, it will be better to show same stat in
case of confusion. In cgroup v2, it is shown as 'S'. In cgroup v1, the
prior stat shown was 'D'. Therefore, it might be a good choice to
maintain the same reported state as before the rewrite.

Or does anyone have a better idea?

Best regards,
Ridong

>   crash> task -R __state,saved_state 195
>   PID: 195      TASK: ffff888004abab80  CPU: 1    COMMAND: "sh"
>     __state = 32768    -> 0x8000 aka TASK_FROZEN
>     saved_state = 8193 -> 0x2001 aka TASK_INTERRUPTIBLE | TASK_FREEZABLE
> 
> so we ought to read ->saved_state, but as pointed out in [1] this is
> racy...
> 
> [1]: https://lore.kernel.org/lkml/20220120162520.570782-3-valentin.schneider@arm.com/
> 
>>  		state = TASK_UNINTERRUPTIBLE;
>>  
>>  	return fls(state);
>> -- 
>> 2.34.1
> 
> 



Return-Path: <cgroups+bounces-1913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8786C7AE
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 12:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644601F24D06
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA27AE4D;
	Thu, 29 Feb 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F+JaC3wB"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3397A709;
	Thu, 29 Feb 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204805; cv=none; b=iX+JD+gLfxh/u7O4YKgeAV3s5fPeEYlJYSqo5d9Ba67pDXKWMLNXN4zNbrfKD6iUGiKlhgo9VZrxK6O4rFl7Zf3UNB95q+hRgAnplMvhorXJb344gP8iTAth9yw67+XKuY49oFBLek/mLaNEB7OE0m0JcWnL2FPUTmLqPe5TktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204805; c=relaxed/simple;
	bh=ojcLD8Z5Xvok8y1Eu1turX6g6LXlVVTK404be4hZ6PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3eOGM9vKoGP820RejNulpAjWe/FahpJrvh4QYfUkTt4n52Ov4OAO1O10wF48sB5uIRIPJ4OeHUqR3GVcCv6adjvWeimPm3naYje0S3bkhMIP0yYcLMM6XS2iU20qqyKPKZNgbcDVQckPN3uO0mRFRMRIqD83iecw4dXvGVN+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F+JaC3wB; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709204793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ymMWfNt/MW/wN+WKRTvmcf7uTUkwFW8Yar/C6/y6t2o=;
	b=F+JaC3wBYqCW345iADuGVDPdZb6yiXnTaIpGG/ws+PXlEEluZ6hm8EkKFpBY5I/rUz9UxN0oxXUgDA5EfWaUXVwGCMwNTYeaMG47hr46CIE9VU71TyEburtoDDSNkXITHTVebBQj/raY332ZvR60hpJak/qpYa9I80TShjU479k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1SnSIK_1709204782;
Received: from 30.97.48.231(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0W1SnSIK_1709204782)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 19:06:31 +0800
Message-ID: <f79a301f-9c6c-4d29-9f79-1c66a492b909@linux.alibaba.com>
Date: Thu, 29 Feb 2024 19:06:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: introduce CPUTIME_FORCEIDLE_TASK
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219084134.10673-1-CruzZhao@linux.alibaba.com>
 <pb7jf52x2qpofgttzz3fphkeiuxuamjbjqb64paw7dvvtv2sxd@mgcol2syra6z>
From: cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <pb7jf52x2qpofgttzz3fphkeiuxuamjbjqb64paw7dvvtv2sxd@mgcol2syra6z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2024/2/26 23:28, Michal Koutný 写道:
> Hello.
> 
> On Mon, Feb 19, 2024 at 04:41:34PM +0800, Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>> As core sched uses rq_clock() as clock source to account forceidle
>> time, irq time will be accounted into forceidle time. However, in
>> some scenarios, forceidle sum will be much larger than exec runtime,
>> e.g., we observed that forceidle time of task calling futex_wake()
>> is 50% larger than exec runtime, which is confusing.
> 
> And those 50% turned out to be all attributed to irq time (that's
> suggested by your diagram)?
> 
> (Could you argue about that time with data from /proc/stat alone?)
> 

Sure. task 26281 is the task with this problem, and we bound it to cpu0,
and it's SMT sibling is running stress-ng -c 1.

[root@localhost 26281]# cat ./sched |grep -E
"forceidle|sum_exec_runtime" && cat /proc/stat |grep cpu0 && echo "" &&
sleep 10 && cat ./sched |grep -E "forceidle|sum_exec_runtime" && cat
/proc/stat |grep cpu0
se.sum_exec_runtime                          :          3353.788406
core_forceidle_sum                           :          4522.497675
core_forceidle_task_sum                      :          3354.383413
cpu0 1368 74 190 87023149 1 2463 3308 0 0 0

se.sum_exec_runtime                          :          3952.897106
core_forceidle_sum                           :          5311.687917
core_forceidle_task_sum                      :          3953.571613
cpu0 1368 74 190 87024043 1 2482 3308 0 0 0


As we can see from the data, se.sum_exec_runtime increased by 600ms,
core_forceidle_sum(using rq_clock) increased by 790ms,
and core_forceidle_task_sum(using rq_clock_task, which subtracts irq
time) increased by 600ms, closing to sum_exec_runtime.

As for the irq time from /proc/stat, irq time increased by 19 ticks,
190ms, closing to the difference of increment of core_forceidle_sum and
se.sum_exec_runtime.

>> Interfaces:
>>  - task level: /proc/$pid/sched, row core_forceidle_task_sum.
>>  - cgroup level: /sys/fs/cgroup/$cg/cpu.stat, row
>>      core_sched.force_idle_task_usec.
> 
> Hm, when you touch this, could you please also add a section into
> Documentation/admin-guide/cgroup-v2.rst about these entries?
> 

Sure, in the next version, I will update the document.

> (Alternatively, explain in the commit message why those aren't supposed
> to be documented.
> Alternative altenratively, would mere documenting of
> core_sched.force_idle_usec help to prevent the confusion that you called
> out above?)
> 
> Also, I wonder if the rstat counting code shouldn't be hidden with
> CONFIG_SCHED_DEBUG too? (IIUC, that's the same one required to see
> analogous stats in /proc/$pid/sched.)
> 
> Regards,
> Michal


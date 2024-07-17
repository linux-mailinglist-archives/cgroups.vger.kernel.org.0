Return-Path: <cgroups+bounces-3722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB493354B
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082871C22103
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC92582;
	Wed, 17 Jul 2024 02:08:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CB6FB6;
	Wed, 17 Jul 2024 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182103; cv=none; b=jQWTp+wQ+v4KrLkTemfGrVRN3QBNYXMFecrxvkh+lDVfOzBKm76bXBC+uszltPOJNXfwwiBVrlWvZZNQwSGK5ZwnNvj5iySNNUt2HYRGEbWnPKjxhpVJcoSiSCdraG6H8JjZihr36EXAXWJaqGAqjc/I+jy6eYUwQKezZrHRhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182103; c=relaxed/simple;
	bh=72g2/YLVNE/1Jty0PS+F0RaNrCg5AttxmEgcZ5dlFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S+gNMH2J4r2eWB9rBPiuYH4MMcYbFT7hFRvSTcvGgBDjsINPbTmlF+3NfCWGBEXb4C7Zcj/XdCbkeZCka+ne8taGdC72FPyPR1/bdZziNDU/4kv6hka56t185G+Fdv78Whq43q4RUU05HwWNIRO2Kh6XyBr+nG3Ud2rQgUNJ4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WNznk1DJJz20lLy;
	Wed, 17 Jul 2024 10:06:34 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id DDA78140360;
	Wed, 17 Jul 2024 10:08:12 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 17 Jul
 2024 10:08:11 +0800
Message-ID: <f93d3b5d-f58b-4787-abaf-8b07d37b7302@huawei.com>
Date: Wed, 17 Jul 2024 10:08:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: Tejun Heo <tj@kernel.org>, <martin.lau@linux.dev>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
 <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
 <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
 <Zo9XAmjpP6y0ZDGH@google.com> <ZpAYGU7x6ioqBir5@slm.duckdns.org>
 <5badbb85-b9e9-4170-a1b9-9b6d13135507@huawei.com>
 <c6d10b39-4583-4162-b481-375f41aaeba1@huawei.com>
 <ZpaJUIyiDguRQWSn@google.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ZpaJUIyiDguRQWSn@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/16 22:53, Roman Gushchin wrote:
> On Tue, Jul 16, 2024 at 08:14:31PM +0800, chenridong wrote:
>>
>>
>> On 2024/7/12 9:15, chenridong wrote:
>>>
>>>
>>> On 2024/7/12 1:36, Tejun Heo wrote:
>>>> Hello,
>>>>
>>>> On Thu, Jul 11, 2024 at 03:52:34AM +0000, Roman Gushchin wrote:
>>>>>> The max_active of system_wq is WQ_DFL_ACTIVE(256). If all
>>>>>> active works are
>>>>>> cgroup bpf release works, it will block smp_call_on_cpu work
>>>>>> which enque
>>>>>> after cgroup bpf releases. So smp_call_on_cpu holding
>>>>>> cpu_hotplug_lock will
>>>>>> wait for completion, but it can never get a completion
>>>>>> because cgroup bpf
>>>>>> release works can not get cgroup_mutex and will never finish.
>>>>>> However, Placing the cgroup bpf release works on cgroup
>>>>>> destroy will never
>>>>>> block smp_call_on_cpu work, which means loop is broken.
>>>>>> Thus, it can solve
>>>>>> the problem.
>>>>>
>>>>> Tejun,
>>>>>
>>>>> do you have an opinion on this?
>>>>>
>>>>> If there are certain limitations from the cgroup side on what
>>>>> can be done
>>>>> in a generic work context, it would be nice to document (e.g. don't grab
>>>>> cgroup mutex), but I still struggle to understand what exactly is wrong
>>>>> with the blamed commit.
>>>>
>>>> I think the general rule here is more "don't saturate system wqs" rather
>>>> than "don't grab cgroup_mutex from system_wq". system wqs are for misc
>>>> things which shouldn't create a large number of concurrent work items. If
>>>> something is going to generate 256+ concurrent work items, it should
>>>> use its
>>>> own workqueue. We don't know what's in system wqs and can't expect
>>>> its users
>>>> to police specific lock usages.
>>>>
>>> Thank you, Tj. That's exactly what I'm trying to convey. Just like
>>> cgroup, which has its own workqueue and may create a large number of
>>> release works, it is better to place all its related works on its
>>> workqueue rather than on system wqs.
>>>
>>> Regards,
>>> Ridong
>>>
>>>> Another aspect is that the current WQ_DFL_ACTIVE is an arbitrary number I
>>>> came up with close to 15 years ago. Machine size has increased by
>>>> multiple
>>>> times, if not an order of magnitude since then. So, "there can't be a
>>>> reasonable situation where 256 concurrency limit isn't enough" is most
>>>> likely not true anymore and the limits need to be pushed upward.
>>>>
>>>> Thanks.
>>>>
>>>
>> Hello, Tejun, and Roman, is the patch acceptable? Do I need to take any
>> further actions?
>>
> 
> I'm not against merging it. I still find the explanation/commit message
> a bit vague and believe that maybe some changes need to be done on the watchdog
> side to make such lockups impossible. As I understand the two most important
> pieces are the watchdog which tries to run a system work on every cpu while
> holding cpu_hotplug_lock on read and the cpuset controller which tries
> to grab cpu_hotplug_lock on writing.
> 
> It's indeed a tricky problem, so maybe there is no simple and clear explanation.
> 
> Anyway thank you for finding the problem and providing a reproducer!
> 
> Thanks!

Originally, we have tried several methods to address this issue on the 
watchdog side, but they failed to fix the problem. This is the only way 
we have found that can fix it now. Perhaps the commit message could be 
clearer; I will do it in v2.

Hello, Tejun, should i add a commit to modify the WQ_DFL_ACTIVE value? 
Perhaps 1024 is reasonable?

Thanks


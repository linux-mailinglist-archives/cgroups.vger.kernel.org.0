Return-Path: <cgroups+bounces-3699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C137932656
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536681C22223
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6D17A5BE;
	Tue, 16 Jul 2024 12:14:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB95146A8A;
	Tue, 16 Jul 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132078; cv=none; b=JL92gfox3DZwp+5iEqfvzptZUlL68CQQ6chJ9ogpCEg8nmkL5GQOESXphEi6NH6h1AKz0cNEMBPZP8zeGwJUFr4Ic3Glr6/9ara7mmMr8sxhJspw2MungvMA3LnIpbZtkIfxaqw75Y0C+0Fv9pYJZHrDDzWRWAP/6dmQT2CVJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132078; c=relaxed/simple;
	bh=m5EP5zYf0FNCFvIMCApC8o9k3JJ5QCLIwoKuW5AEFrA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=LzKxGXG+cwq9TxSmqked40wsIs+Xv7cMs9a7nr9WuFO37s24WPZBs0DVTSTazw4WrtTusgaTKexqxXpacx8yp3FVS383B2QGpI3sT4CmBUSvJrR4FHB1zTN/xg52ePdSt7QOq01pg29HLxO8zysd9L9A3VcDmq0kcR0NvKgULfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNdHj3DN2zdj0J;
	Tue, 16 Jul 2024 20:12:49 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id B9355140158;
	Tue, 16 Jul 2024 20:14:32 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 16 Jul
 2024 20:14:31 +0800
Message-ID: <c6d10b39-4583-4162-b481-375f41aaeba1@huawei.com>
Date: Tue, 16 Jul 2024 20:14:31 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
From: chenridong <chenridong@huawei.com>
To: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
CC: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <bpf@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
 <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
 <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
 <Zo9XAmjpP6y0ZDGH@google.com> <ZpAYGU7x6ioqBir5@slm.duckdns.org>
 <5badbb85-b9e9-4170-a1b9-9b6d13135507@huawei.com>
Content-Language: en-US
In-Reply-To: <5badbb85-b9e9-4170-a1b9-9b6d13135507@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/12 9:15, chenridong wrote:
> 
> 
> On 2024/7/12 1:36, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Jul 11, 2024 at 03:52:34AM +0000, Roman Gushchin wrote:
>>>> The max_active of system_wq is WQ_DFL_ACTIVE(256). If all active 
>>>> works are
>>>> cgroup bpf release works, it will block smp_call_on_cpu work which 
>>>> enque
>>>> after cgroup bpf releases. So smp_call_on_cpu holding 
>>>> cpu_hotplug_lock will
>>>> wait for completion, but it can never get a completion because 
>>>> cgroup bpf
>>>> release works can not get cgroup_mutex and will never finish.
>>>> However, Placing the cgroup bpf release works on cgroup destroy will 
>>>> never
>>>> block smp_call_on_cpu work, which means loop is broken. Thus, it can 
>>>> solve
>>>> the problem.
>>>
>>> Tejun,
>>>
>>> do you have an opinion on this?
>>>
>>> If there are certain limitations from the cgroup side on what can be 
>>> done
>>> in a generic work context, it would be nice to document (e.g. don't grab
>>> cgroup mutex), but I still struggle to understand what exactly is wrong
>>> with the blamed commit.
>>
>> I think the general rule here is more "don't saturate system wqs" rather
>> than "don't grab cgroup_mutex from system_wq". system wqs are for misc
>> things which shouldn't create a large number of concurrent work items. If
>> something is going to generate 256+ concurrent work items, it should 
>> use its
>> own workqueue. We don't know what's in system wqs and can't expect its 
>> users
>> to police specific lock usages.
>>
> Thank you, Tj. That's exactly what I'm trying to convey. Just like 
> cgroup, which has its own workqueue and may create a large number of 
> release works, it is better to place all its related works on its 
> workqueue rather than on system wqs.
> 
> Regards,
> Ridong
> 
>> Another aspect is that the current WQ_DFL_ACTIVE is an arbitrary number I
>> came up with close to 15 years ago. Machine size has increased by 
>> multiple
>> times, if not an order of magnitude since then. So, "there can't be a
>> reasonable situation where 256 concurrency limit isn't enough" is most
>> likely not true anymore and the limits need to be pushed upward.
>>
>> Thanks.
>>
> 
Hello, Tejun, and Roman, is the patch acceptable? Do I need to take any 
further actions?


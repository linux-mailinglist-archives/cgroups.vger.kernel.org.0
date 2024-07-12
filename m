Return-Path: <cgroups+bounces-3644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA792F352
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 03:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E6828255F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A73D71;
	Fri, 12 Jul 2024 01:16:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B92645;
	Fri, 12 Jul 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746960; cv=none; b=O7Do5NviuF3yeOPSM8qemQVUu9CcXRYeBor5mer35lUtcXNVETg7RrTsIciM32c2uPBbASI1wlx5dQ51JH44AD5OfbsnuObXNfi3pDeSV3AU67ChRydTJJ/Q6hh6+4Oi6lBF19E+6DPPaxXrIZS5vuA4d+qcOm5QTlZdF+am4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746960; c=relaxed/simple;
	bh=DZQooscX4frirN7UCJVpBt9EYIMsRQUeEgdySVoRiQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HGqgvrE4bJ5RhKjO00sIZLHykqwD+bOlOUos6uKqczqpQOqmEW+0inzgSNxIo8j3KfDQ8cHpQ0qAxUSuVzwrGk7ITG3lvB4XS4SLy/ehzxZAfMk3lmbJns0En9eYvY0fZfLl/+vgTiEp1/r84Y0yq8+KfOiG4HY+20JvGMRE89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WKtpj1Q6Yz2ClCY;
	Fri, 12 Jul 2024 09:11:41 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F032140337;
	Fri, 12 Jul 2024 09:15:55 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 12 Jul
 2024 09:15:54 +0800
Message-ID: <5badbb85-b9e9-4170-a1b9-9b6d13135507@huawei.com>
Date: Fri, 12 Jul 2024 09:15:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
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
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ZpAYGU7x6ioqBir5@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/12 1:36, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jul 11, 2024 at 03:52:34AM +0000, Roman Gushchin wrote:
>>> The max_active of system_wq is WQ_DFL_ACTIVE(256). If all active works are
>>> cgroup bpf release works, it will block smp_call_on_cpu work which enque
>>> after cgroup bpf releases. So smp_call_on_cpu holding cpu_hotplug_lock will
>>> wait for completion, but it can never get a completion because cgroup bpf
>>> release works can not get cgroup_mutex and will never finish.
>>> However, Placing the cgroup bpf release works on cgroup destroy will never
>>> block smp_call_on_cpu work, which means loop is broken. Thus, it can solve
>>> the problem.
>>
>> Tejun,
>>
>> do you have an opinion on this?
>>
>> If there are certain limitations from the cgroup side on what can be done
>> in a generic work context, it would be nice to document (e.g. don't grab
>> cgroup mutex), but I still struggle to understand what exactly is wrong
>> with the blamed commit.
> 
> I think the general rule here is more "don't saturate system wqs" rather
> than "don't grab cgroup_mutex from system_wq". system wqs are for misc
> things which shouldn't create a large number of concurrent work items. If
> something is going to generate 256+ concurrent work items, it should use its
> own workqueue. We don't know what's in system wqs and can't expect its users
> to police specific lock usages.
> 
Thank you, Tj. That's exactly what I'm trying to convey. Just like 
cgroup, which has its own workqueue and may create a large number of 
release works, it is better to place all its related works on its 
workqueue rather than on system wqs.

Regards,
Ridong

> Another aspect is that the current WQ_DFL_ACTIVE is an arbitrary number I
> came up with close to 15 years ago. Machine size has increased by multiple
> times, if not an order of magnitude since then. So, "there can't be a
> reasonable situation where 256 concurrency limit isn't enough" is most
> likely not true anymore and the limits need to be pushed upward.
> 
> Thanks.
> 


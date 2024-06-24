Return-Path: <cgroups+bounces-3297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6569140D7
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59453283C76
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 03:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBD79E1;
	Mon, 24 Jun 2024 03:34:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F153A7;
	Mon, 24 Jun 2024 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719200050; cv=none; b=reEmUfQ93u/99jHTT02fnhnDWgc2j9vOJJSOGDCNFNwZkKiQ4SnMm8lpFaGbJ7FDVugdVetQLKRd1sAxxvAYa54ZA+eAy2vsj6Pf7rkNYowZPdnAoL9KP8tsLxLQ/becfYJZncZyGBtqdm4MV8kHxrPazzpcI+4gGYIIU2j5oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719200050; c=relaxed/simple;
	bh=7/n+f02nawQmkJqsWXiakU82X4+sVM55DsDxY24Z89E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rgh+O0P1n7KRfleNQDP5mq0ZszMC6Qk4HHjAhs6/swX6oXCd4cx6LGYtEKiJoKpCxWb/wruMll+fLVOGpcAsMg5q7Ik6oNuIt77WO96mot3mi5rjdnW/4BXZovZ4ZoTzLVicpXsvdKjD/IC5QywA85wXmv3wLSaiGS1ns+Zgywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W6tkL2VkSzxTFZ;
	Mon, 24 Jun 2024 11:29:46 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 998F41402E2;
	Mon, 24 Jun 2024 11:34:03 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 24 Jun
 2024 11:34:03 +0800
Message-ID: <2d495a96-3ddd-4e8f-a055-159dc182cf8f@huawei.com>
Date: Mon, 24 Jun 2024 11:34:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: Markus Elfring <Markus.Elfring@web.de>, <cgroups@vger.kernel.org>,
	<bpf@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo
	<tj@kernel.org>, Waiman Long <longman@redhat.com>, Zefan Li
	<lizefan.x@bytedance.com>
CC: LKML <linux-kernel@vger.kernel.org>
References: <20240622113814.120907-1-chenridong@huawei.com>
 <e1e51582-7ecb-40af-aae1-498993d0f935@web.de>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <e1e51582-7ecb-40af-aae1-498993d0f935@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)


On 2024/6/22 21:45, Markus Elfring wrote:
>> We found a refcount UAF bug as follows:
>>
>> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
> …
>
> How do you think about to use a summary phrase like “Avoid use-after-free
> in proc_cpuset_show()”?
>
>
>> This is also reported by: https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
> Would you like to add any tags (like “Fixes”) accordingly?
>
Thank you for review, i will do that.
> …
>> +++ b/kernel/cgroup/cpuset.c
> …
>> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>>   		goto out;
>>
>>   	css = task_get_css(tsk, cpuset_cgrp_id);
>> +	rcu_read_lock();
> …
>> +	rcu_read_unlock();
>>   	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>   				current->nsproxy->cgroup_ns);
> …
>
> Would you become interested to apply a statement like “guard(rcu_read_lock)();”?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#L133
>
> Regards,
> Markus

We hope somebody could have another better solution.

Regards

Ridong





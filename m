Return-Path: <cgroups+bounces-2634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB818AB8DB
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 04:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A6BB20EE1
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749326FB1;
	Sat, 20 Apr 2024 02:47:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D77524A;
	Sat, 20 Apr 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581260; cv=none; b=nBwqJMqfHvFMvQ+a7fy6IlzsKL8+uLmgG8FeLEOPVeghTgiJWsVMb4a+kL9fSI8iP3ZHrfedxS5pETE/oq5ZQbgJbxAxZBeLbddtft30nPCL8b4ATW9hsbSImt/GTuR8tlPORnhveTn5/pFG1CEpI0P1oae0L6CyXC2V1GKGM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581260; c=relaxed/simple;
	bh=aS7AYAhkokyxjMLIzsxuz8z0CxtgKtzwfBkoE/R0NRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXmW24Hj6Lm8OkKF0y8TLX2CySRrrP4VaBnKGI1se1iN9CCJboBG2oDEg49eYlRKCyvFd91SvS+4YOf4dfJPHAYZgKJSjFYbuELqP1mqoso3XSBV6enWv5GUzLwLd0B4EqqNo08BGR97tB31Q8hX3seTyJlBeiNZRyDnHby2mLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLwp36cVYzcdqV;
	Sat, 20 Apr 2024 10:44:27 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id EE61C18006C;
	Sat, 20 Apr 2024 10:47:33 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 10:47:33 +0800
Message-ID: <a7205c3c-4abe-fb43-9c18-976e22bb226e@huawei.com>
Date: Sat, 20 Apr 2024 10:47:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cgroup: make cgroups info more readable
To: Huan Yang <11133793@vivo.com>, Huan Yang <link@vivo.com>, Tejun Heo
	<tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner
	<hannes@cmpxchg.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <opensource.kernel@vivo.com>
References: <20240409021826.1171921-1-link@vivo.com>
 <9d01ab99-bbfd-536b-a375-9c44f988aa9a@huawei.com>
 <945d1e73-21f6-4a56-81ee-9625491f3b26@vivo.com>
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <945d1e73-21f6-4a56-81ee-9625491f3b26@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/4/19 14:25, Huan Yang wrote:
> HI jianfeng
> 
> 在 2024/4/19 11:33, xiujianfeng 写道:
>> [Some people who received this message don't often get email from
>> xiujianfeng@huawei.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi,
>>
>> I found a discussion about this change in the email thread bellow, and
>> hope it helps you.
> It's helpful to know why this patch not need, thank you.
>>
>> https://lore.kernel.org/all/YwMwlMv%2FtK3sRXbB@slm.duckdns.org/#t
> 
> I have a question, that, now that only for cgroup1, when I running qemu
> ubuntu, I got this:
> 
>> mount | grep cgroup
>> cgroup2 on /sys/fs/cgroup type cgroup2
> (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> 
> Only cgroup2 mount in my system, but /proc/cgroup also worked, maybe
> better to disable this when only cgroup2 mounted?

I’m not the maintainer, so the official answer to this question should
be left to them:).

However, I don’t think this is the right way. Even though the
information shown by /proc/cgroups doesn’t seem as useful for cgroup2 as
for cgroup1 due to cgroup2 has only single hierarchy, it’s not entirely
useless, IMHO.

> 
>> On 2024/4/9 10:18, Huan Yang wrote:
>>> The current cgroups output format is based on tabs, which
>>> may cause misalignment of output information.
>>>
>>> Using placeholder formatting can make the output information
>>> more readable.
>>>
>>> Signed-off-by: Huan Yang <link@vivo.com>
>>> ---
>>>   kernel/cgroup/cgroup-v1.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>>> index 520a11cb12f4..c082a78f4c22 100644
>>> --- a/kernel/cgroup/cgroup-v1.c
>>> +++ b/kernel/cgroup/cgroup-v1.c
>>> @@ -669,15 +669,16 @@ int proc_cgroupstats_show(struct seq_file *m,
>>> void *v)
>>>        struct cgroup_subsys *ss;
>>>        int i;
>>>
>>> -     seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
>>> +     seq_printf(m, "%16s %16s %16s %16s\n", "#subsys_name",
>>> "hierarchy",
>>> +                "num_cgroups", "enabled");
>>>        /*
>>>         * Grab the subsystems state racily. No need to add avenue to
>>>         * cgroup_mutex contention.
>>>         */
>>>
>>>        for_each_subsys(ss, i)
>>> -             seq_printf(m, "%s\t%d\t%d\t%d\n",
>>> -                        ss->legacy_name, ss->root->hierarchy_id,
>>> +             seq_printf(m, "%16s %16d %16d %16d\n", ss->legacy_name,
>>> +                        ss->root->hierarchy_id,
>>>                           atomic_read(&ss->root->nr_cgrps),
>>>                           cgroup_ssid_enabled(i));
>>>


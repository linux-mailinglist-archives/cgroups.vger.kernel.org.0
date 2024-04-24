Return-Path: <cgroups+bounces-2688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB1B8AFDDC
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77A31F23FF3
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518456FB8;
	Wed, 24 Apr 2024 01:30:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E36112;
	Wed, 24 Apr 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922234; cv=none; b=pnnY1f0cVgWX0I9xUcW86SoZDWaFBr7BSgfocmS9C6ZCGFJK1eYIHht7W4jy4slScUR1xvndZaTkeVRVJn2ALHlNKtb6RDy8gE4/OuEgbmm1EYhhzih44inU+zLcttyBG8sr+4S7I+DZbYaInEFnwsjuhSo/NIzibxaZ8pFhCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922234; c=relaxed/simple;
	bh=dsn1DoWOB7tBfi/2dFhNu6AhjYULhhc5E2avYV0nMZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hMzwNzeBkK7Ss12biOGgBy6x4uEdhntc9s1UlXkVXIfcLT3EmNKEEOjchUW2kgraeOXqNwzkItd51pxwc22VBTf6YES4BYqAohIM8R5AsucNjhkqUBrfb2ULf/aEB3sEed7sjq0lSRtiFS6AIZiQHDHpsserPMHPbsqaOQSosHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VPLvB1btLz1RCjJ;
	Wed, 24 Apr 2024 09:27:18 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 720751A0188;
	Wed, 24 Apr 2024 09:30:22 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 09:30:22 +0800
Message-ID: <9e451410-f043-5f0e-a2a1-b77b69a3f110@huawei.com>
Date: Wed, 24 Apr 2024 09:30:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Fix incorrect top_cpuset flags
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Zefan Li
	<lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
References: <20240424010020.181305-1-longman@redhat.com>
 <5c5089de-311c-4563-b534-2340e328a5ee@redhat.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <5c5089de-311c-4563-b534-2340e328a5ee@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/4/24 9:02, Waiman Long wrote:
> 
> On 4/23/24 21:00, Waiman Long wrote:
>> Commit 8996f93fc388 ("cgroup/cpuset: Statically initialize more
>> members of top_cpuset") uses an incorrect "<" relational operator for
>> the CS_SCHED_LOAD_BALANCE bit when initializing the top_cpuset. This
>> results in load_balancing turned off by default in the top cpuset which
>> is bad for performance.
>>
>> Fix this by using the BIT() helper macro to set the desired top_cpuset
>> flags and avoid similar mistake from being made in the future.
>>
>> Fixes: 8996f93fc388 ("cgroup/cpuset: Statically initialize more
>> members of top_cpuset")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e70008a1d86a..b0a97efa5f20 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -368,8 +368,8 @@ static inline void notify_partition_change(struct
>> cpuset *cs, int old_prs)
>>   }
>>     static struct cpuset top_cpuset = {
>> -    .flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
>> -          (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
>> +    .flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
>> +         BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>       .partition_root_state = PRS_ROOT,
>>       .relax_domain_level = -1,
>>       .remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
> Add cc to xiujianfeng <xiujianfeng@huawei.com>

Thanks, this looks good. :)

> 


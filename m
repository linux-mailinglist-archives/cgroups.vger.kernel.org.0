Return-Path: <cgroups+bounces-2661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F48ADB99
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 03:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47541C212D6
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169712B8B;
	Tue, 23 Apr 2024 01:40:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11441FC18;
	Tue, 23 Apr 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836416; cv=none; b=hzcPrne4HKsmsi5U3o1fGyZgMtYRKJp44+J97eXuiZuX+ry7bXB/ccIy9iX5GWABoKs+UX3Ivy9v8jtNIKDXYGpBXvebZQ+D8+y+KLC/gORWOdhPYkRF7SWSgr10yVSHPkLojklSDnlRTMR4Hu5A2cKqv4nkT8NpSWC+B4ELTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836416; c=relaxed/simple;
	bh=C3q9CN1Aw3AQlHj+PYz1Ias/ZokIKQ8/J+ECE84ngOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OnY3usF3yqLGDtai4TkZaHlZROfV9TJVw6ezSoxQwi6+reGTmOskBjW8oIgV3Z13ZdFymv6dh4W5REf/+c2Ft+SVtqf3NNakgYlzctw9OAdBvkbcQsbh0KQXEBUwxg/GO6VVc6kanCgg84x/z/8sXsQAsGdONCg26V1MGgKaQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNl8V6cMvzXmKG;
	Tue, 23 Apr 2024 09:36:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E15E140136;
	Tue, 23 Apr 2024 09:40:10 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 09:40:10 +0800
Message-ID: <8bfc0013-8268-0e7e-1ee0-99ad04b0b467@huawei.com>
Date: Tue, 23 Apr 2024 09:40:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE
 twice
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, <lizefan.x@bytedance.com>,
	<tj@kernel.org>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240420094713.1028579-1-xiujianfeng@huawei.com>
 <f2fc2eb8-44e0-4805-86c0-f9062380b3e8@redhat.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <f2fc2eb8-44e0-4805-86c0-f9062380b3e8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/4/23 2:38, Waiman Long wrote:
> On 4/20/24 05:47, Xiu Jianfeng wrote:
>> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE has been cleared in the
>> is_in_v2_mode() case under the same condition, don't do it twice.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e70008a1d86a..159525cdaeb9 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4059,13 +4059,6 @@ static int cpuset_css_online(struct
>> cgroup_subsys_state *css)
>>               clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>>       }
>>   -    /*
>> -     * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
>> -     */
>> -    if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
>> -        !is_sched_load_balance(parent))
>> -        clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>> -
>>       spin_unlock_irq(&callback_lock);
>>         if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
> 
> Thanks for catching this duplication.
> 
> Could you remove the check inside is_in_v2_mode() instead?
> is_in_v2_mode() can be true for cgroup v1 if the"cpuset_v2_mode" mount
> option is specified. That balance flag change isn't appropriate for this
> particular case.

Sure, thanks for explanation, will do in v2.

> 
> Thanks,
> Longman
> 


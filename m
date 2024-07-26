Return-Path: <cgroups+bounces-3903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B5993CC33
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 03:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB7B21A76
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E05FEDB;
	Fri, 26 Jul 2024 01:00:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422C37E;
	Fri, 26 Jul 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955611; cv=none; b=EUsoqyDyy10rbrn9lgNI0WFSd+TsiX6OYo6/W2zv6++8zWh5WyYoDMo5c6vYqoiOr6LmVLOtGeV8qMyGT4YotJwgXJnb+yc4MgVD/HETHKMpcE4bOIGCRFhjzNu3TxOx56AMoiRb9lxEiL/+3j3hdSum7IRmaUF48aN9tMEARw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955611; c=relaxed/simple;
	bh=R+gjdZfA0AhekP+wqwaD71ka8R8428oPL0eRb/1+DX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g3tlFycTFCIxAEfopXRyOLN3DAZJnxiy+JoOey2MHroYl42q693fCH1viPcPkUn+WjwsjWxLinncUeNOQ/JjLGG/qM3pfkvys/5YkAcgvUWnmocCvs+2rR46spXaew+UnNklrOfwfP0Zmok3gONSgMJLfjLZQ6qrgz1nuqmaHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WVTrn1VdszMr6f;
	Fri, 26 Jul 2024 08:58:17 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 19FA114011B;
	Fri, 26 Jul 2024 09:00:05 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 26 Jul
 2024 09:00:04 +0800
Message-ID: <3ea9ec53-8bcc-4c3d-b589-7d5922daabbb@huawei.com>
Date: Fri, 26 Jul 2024 09:00:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: add dec_attach_in_progress helper
To: Waiman Long <longman@redhat.com>, Kamalesh Babulal
	<kamalesh.babulal@oracle.com>, <tj@kernel.org>, <lizefan.x@bytedance.com>,
	<hannes@cmpxchg.org>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240725015551.2221867-1-chenridong@huawei.com>
 <e5c92f54-d767-4e71-9f57-9352923bd3e7@oracle.com>
 <de6958aa-27f8-4baa-b76d-88266d009f81@huawei.com>
 <b45c24d2-98ee-4ecc-8d7d-6ac5dfa65c17@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <b45c24d2-98ee-4ecc-8d7d-6ac5dfa65c17@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/26 3:07, Waiman Long wrote:
> 
> On 7/25/24 07:40, chenridong wrote:
>>
>>
>> On 2024/7/25 19:01, Kamalesh Babulal wrote:
>>>
>>>
>>> On 7/25/24 7:25 AM, Chen Ridong wrote:
>>>> There are several functions to decrease attach_in_progress, and they
>>>> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
>>>> add a helper to make it concise.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>   kernel/cgroup/cpuset.c | 28 +++++++++++++++-------------
>>>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index d4322619e59a..c241845694ac 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -490,6 +490,17 @@ static inline void 
>>>> check_insane_mems_config(nodemask_t *nodes)
>>>>       }
>>>>   }
>>>>   +/*
>>>> + * decrease cs->attach_in_progress.
>>>> + * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
>>>
>>> In the description, adding locking constraint of cpuset_mutex would 
>>> be helpful.
>>> Something like "cpuset_mutex must be held by the caller."
>>>
>> Thank you, I will to that.
>>>> + */
>>>> +static inline void dec_attach_in_progress(struct cpuset *cs)
>>>> +{
>>>> +    cs->attach_in_progress--;
>>>> +    if (!cs->attach_in_progress)
>>>> +        wake_up(&cpuset_attach_wq);
>>>> +}
>>>> +
> 
> I would suggested a dec_attach_in_progress_locked() and a 
> dec_attach_in_progress() helpers. The dec_attach_in_progress() helper 
> acquires the cpuset_mutex and call dec_attach_in_progress_locked(). 
> Inside the dec_attach_in_progress_locked(), you can either add a comment 
> about requiring cpuset_mutex held or add a 
> lockdep_assert_held(&cpuset_mutex).
> 
> Cheers,
> Longman
> 
> 
> 
Thanks, I will do that in v2.

Ridong


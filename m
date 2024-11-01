Return-Path: <cgroups+bounces-5381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC10A9B92C8
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 15:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FA91F236B6
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319831A263F;
	Fri,  1 Nov 2024 14:03:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E53EEC3;
	Fri,  1 Nov 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469834; cv=none; b=I4DM43R7oh4SsPEp6gOsJn6ZFvIs9DmithRVH3dAuBTPBUue0oDBY/Ex4F9f0umygRrinFgdsCGCDignnCoHOUzg3w8RVl8zbridE34FDuNhzoqkdjyCzRqw8CykcjcSnZtIZJPJhYoavJL9PJ/CRFV3NYvAoAD1q4UIVXum2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469834; c=relaxed/simple;
	bh=0aSCMMdGWW8uVV2qD2dpIx5qDvOcUAZ2zAffj152WB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WsLcKzHv+1/pV9Uj1zNdjdJWDErsQw9HXryinNo49u3d6BtRifyiYaI5mEHhYLF4eR/FnY9f5iOj4gPX9v5khcQUkANavIND8d+HA+NbTb36/r3fivzAqLqXuyaMVfn6KKunGifExB9yKQ9ZADxRIKGzUr0lBZLSulfnBjSsx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg2cH2SBRz6JB91;
	Fri,  1 Nov 2024 22:02:23 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 43DAC140A70;
	Fri,  1 Nov 2024 22:03:47 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 17:03:46 +0300
Message-ID: <0f533707-e9fc-4abd-95fb-bf22c322285d@huawei.com>
Date: Fri, 1 Nov 2024 17:03:46 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>
CC: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>, <nikita.panov@huawei-partners.com>
References: <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
 <ZyTUd5wH1T_IJYRL@tiehlicka>
 <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>
 <ZyTXYnbDfGYGuxlt@tiehlicka>
 <5baa6024-a0a4-4b0b-a7d1-641bba7e5b87@huawei.com>
 <ZyTcmvihAl_m4FZM@tiehlicka>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ZyTcmvihAl_m4FZM@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 11/1/2024 4:50 PM, Michal Hocko wrote:
> On Fri 01-11-24 16:39:07, Stepanov Anatoly wrote:
>> On 11/1/2024 4:28 PM, Michal Hocko wrote:
>>> On Fri 01-11-24 16:24:55, Stepanov Anatoly wrote:
>>>> On 11/1/2024 4:15 PM, Michal Hocko wrote:
>>>>> On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
>>>>>> On 11/1/2024 10:35 AM, Michal Hocko wrote:
>>>>>>> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
>>>>>>>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
>>>>>>>> THP mode property for several tasks at once, in this case some batch-change approach needed.
>>>>>>>
>>>>>>> I do not follow. How is this any different from a single process? Or do
>>>>>>> you mean to change the mode for an already running process?
>>>>>>>
>>>>>> yes, for already running set of processes
>>>>>
>>>>
>>>>> Why is that preferred over setting the policy upfront?
>>>> Setting the policy in advance is fine, as the first step to do.
>>>> But we might not know in advance
>>>> which exact policy is the most beneficial for one set of apps or another.
>>
>>>
>>> How do you plan to find that out when the application is running
>>> already?
>> For example, if someone willing to compare some DB server performance with THP-off vs THP-on,
>> and DB server restart isn't an option.

> 
> So you essentially expect user tell you that they want THP and you want
> to make that happen on fly, correct? It is not like there is an actual
> monitoring and dynamic policing.
For a user/sysadmin this scenario is almost the same as experimenting with 
global THP settings, but with explicit THP usage, less THP overuse by some random apps,
so more predictable.

> 
> If that is the case then I am not really convinced this is a worthwhile
> to support TBH. I can see that a workload knows in advance that they
> benefit from THP but I am much more dubious about "learning during the
> runtime" is a real life thing. I might be wrong of course but if
> somebody has performance monitoring that is able to identify performance
> bottlenecks based on specific workload then applying THP on the whole
> group of proceesses seems like a very crude way to deal with that. I

> could see a case for madvice_process(MADV_COLLAPSE) to deal with
> specific memory hotspots though.
Yes, we have something like this in mind.

-- 
Anatoly Stepanov, Huawei


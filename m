Return-Path: <cgroups+bounces-5379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271C9B922D
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 14:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911CCB2110B
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7519E971;
	Fri,  1 Nov 2024 13:39:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3A15B984;
	Fri,  1 Nov 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468354; cv=none; b=c24GNzurkKTfvuYIIPkm739eutUBKU2ULb4KkuG8M9BhtFp9mBapPB21ISLtMBRVpGyUvYal9Op2pparLtAXGDprPtY2v+KM490/byxVU/IDZo6oJK/Ct+oUjdool4cK7kmdxYRgAPssXQKqD/bEKZ16hyyjBLKhKixPFlQqVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468354; c=relaxed/simple;
	bh=6w9ddJfdC+wbWkJ9nmnUl3R3iz0LbUYDbRnBNm1Sjdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QfyU7OdguEw+MNGh8S8xew/jFrLYbp4Vpv0R5JKaf+1v6m/NJn4MAy+4kAR98CHDKSkdyTwar8/DwvU/iULAf2Es4Rnxc8vACbngpJ1efh70uwOPUosCsXyliiuL+kdP3hvm6kk+zgFYgXZNEDIlYKZKW05IuOSPFy2+1EA97mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg1zp0lQYz6LD3y;
	Fri,  1 Nov 2024 21:34:14 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A46B140445;
	Fri,  1 Nov 2024 21:39:08 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 16:39:07 +0300
Message-ID: <5baa6024-a0a4-4b0b-a7d1-641bba7e5b87@huawei.com>
Date: Fri, 1 Nov 2024 16:39:07 +0300
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
References: <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
 <ZyTUd5wH1T_IJYRL@tiehlicka>
 <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>
 <ZyTXYnbDfGYGuxlt@tiehlicka>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ZyTXYnbDfGYGuxlt@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 11/1/2024 4:28 PM, Michal Hocko wrote:
> On Fri 01-11-24 16:24:55, Stepanov Anatoly wrote:
>> On 11/1/2024 4:15 PM, Michal Hocko wrote:
>>> On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
>>>> On 11/1/2024 10:35 AM, Michal Hocko wrote:
>>>>> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
>>>>>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
>>>>>> THP mode property for several tasks at once, in this case some batch-change approach needed.
>>>>>
>>>>> I do not follow. How is this any different from a single process? Or do
>>>>> you mean to change the mode for an already running process?
>>>>>
>>>> yes, for already running set of processes
>>>
>>
>>> Why is that preferred over setting the policy upfront?
>> Setting the policy in advance is fine, as the first step to do.
>> But we might not know in advance
>> which exact policy is the most beneficial for one set of apps or another.

> 
> How do you plan to find that out when the application is running
> already?
For example, if someone willing to compare some DB server performance with THP-off vs THP-on,
and DB server restart isn't an option.
Of course, if the restart is ok then we don't need such feature, "launcher" approach would be enough.
if i got your question right.


-- 
Anatoly Stepanov, Huawei


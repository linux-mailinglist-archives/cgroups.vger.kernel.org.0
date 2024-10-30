Return-Path: <cgroups+bounces-5338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F39B66B2
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812A41F22192
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839111F4710;
	Wed, 30 Oct 2024 14:58:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27B43173;
	Wed, 30 Oct 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300291; cv=none; b=Eg9nc1N+7wVZ4z2rQnxzWiPeIOp5SWQImyomqUZxqyZMKJDwUidEgQA44Xic9fjEOj26BGpkcTgDz/QvMaQGrbfej8ALSGYsdH05s35THDpFiCIvaSqg2uuav8h5q8fxQqWd1Ob9kLEy36QFbkmxbjmnvSpeG8B6EmWr+igvgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300291; c=relaxed/simple;
	bh=WcIB+KKO5hJsYai/GyBGuuWhmswlEVCGJdwusoHNSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ptp/dqfm3At9B96kV9hFapCU7+y41f665YBWoBWNCBHogP5V+ADLCDlaWcWphYugMFegIoqeYSQltmYh55bALdglb/423QbtoDHlLs4ct4SebKm9OGOhAanggdWEXX58QeYhW9Mwm239BjaJPZ5Iu2BMLyHEbr8WmgR5PxCw8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdqvy6zmCz6HJg7;
	Wed, 30 Oct 2024 22:56:46 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 52EAE140A35;
	Wed, 30 Oct 2024 22:58:05 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 17:58:04 +0300
Message-ID: <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
Date: Wed, 30 Oct 2024 17:58:04 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stepanov.anatoly@huawei.com>, <alexander.kozhevnikov@huawei-partners.com>,
	<guohanjun@huawei.com>, <weiyongjun1@huawei.com>,
	<wangkefeng.wang@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>, <kang.sun@huawei.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <ZyI0LTV2YgC4CGfW@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 10/30/2024 4:27 PM, Michal Hocko wrote:
> On Wed 30-10-24 15:51:00, Gutierrez Asier wrote:
>>
>>
>> On 10/30/2024 11:38 AM, Michal Hocko wrote:
>>> On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>
>>>> Currently THP modes are set globally. It can be an overkill if only some
>>>> specific app/set of apps need to get benefits from THP usage. Moreover, various
>>>> apps might need different THP settings. Here we propose a cgroup-based THP
>>>> control mechanism.
>>>>
>>>> THP interface is added to memory cgroup subsystem. Existing global THP control
>>>> semantics is supported for backward compatibility. When THP modes are set
>>>> globally all the changes are propagated to memory cgroups. However, when a
>>>> particular cgroup changes its THP policy, the global THP policy in sysfs remains
>>>> the same.
>>>
>>> Do you have any specific examples where this would be benefitial?
>>
>> Now we're mostly focused on database scenarios (MySQL, Redis).  
> 
> That seems to be more process than workload oriented. Why the existing
> per-process tuning doesn't work?
> 
> [...]

1st Point

We're trying to provide a transparent mechanism, but all the existing per-process
methods require to modify an app itself (MADV_HUGE, MADV_COLLAPSE, hugetlbfs)

Moreover we're using file-backed THPs too (for .text mostly), which make it for
user-space developers even more complicated.

>>>> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
>>>> cgroup mode changes aren't propagated to child cgroups.
>>>
>>> So this breaks hierarchical property, doesn't it? In other words if a
>>> parent cgroup would like to enforce a certain policy to all descendants
>>> then this is not really possible. 
>>
>> The first idea was to have some flexibility when changing THP policies. 
>>
>> I will submit a new patch set which will enforce the cgroup hierarchy and change all
>> the children recursively.
> 
> What is the expected semantics then?

2nd point (on semantics)
1. Children inherit the THP policy upon creation
2. Parent's policy changes are propagated to all the children
3. Children can set the policy independently

-- 
Asier Gutierrez
Huawei



Return-Path: <cgroups+bounces-3565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8992A3CE
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F761B21C07
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C613A26B;
	Mon,  8 Jul 2024 13:40:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BB137C35;
	Mon,  8 Jul 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446047; cv=none; b=PlruYR/lWY2i1UA/XEV/DmFhZDSD0e/A/fRyE5H0+mG+0TwDOZ5oGvT1E+McvgNdKJWBcdas6dHrRImtyGhwzO5Zr5vQDpHC/tWtcEUhqtI7+9jxJou8S2Oy9+Th4sHIrWFUqa+QDFoYVFqV/ufWcgX2ShtclYVdCCGoXHuVx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446047; c=relaxed/simple;
	bh=8H1ig13FFkRAj4yqBY4MhnQGTyMG3U690diuLbRAvKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yta65/aRXaopkyavV0uoht7HBWxJVnbtcBJR+TOznN6EOFvEsgKO/FpFOD1DudgSUfv2Kv21kKCGZVewaiRg7d80qBIwXE5GAdibL98wXfGZy54gT6e9jc4OwF7vi+dcbs7gIgE+xZ/usl6TFcoCAGeJfXJnaaV6d1s9tmLt50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WHlXG2MTbzQkvM;
	Mon,  8 Jul 2024 21:36:46 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 18ABB140156;
	Mon,  8 Jul 2024 21:40:40 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 21:40:39 +0800
Message-ID: <5ce7be39-ac42-98c9-65fc-589385b8f65b@huawei.com>
Date: Mon, 8 Jul 2024 21:40:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak to
 v2
To: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Sidhartha Kumar
	<sidhartha.kumar@oracle.com>, Miaohe Lin <linmiaohe@huawei.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
 <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
 <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
 <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>
 <ZovgDfGFJdc6lVN3@tiehlicka>
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZovgDfGFJdc6lVN3@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/8 20:48, Michal Hocko wrote:
> On Wed 03-07-24 13:38:04, Andrew Morton wrote:
>> On Wed, 3 Jul 2024 10:45:56 +0800 xiujianfeng <xiujianfeng@huawei.com> wrote:
>>
>>>
>>>
>>> On 2024/7/3 9:58, Andrew Morton wrote:
>>>> On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>>>>
>>>>> Introduce peak and rsvd.peak to v2 to show the historical maximum
>>>>> usage of resources, as in some scenarios it is necessary to configure
>>>>> the value of max/rsvd.max based on the peak usage of resources.
>>>>
>>>> "in some scenarios it is necessary" is not a strong statement.  It
>>>> would be helpful to fully describe these scenarios so that others can
>>>> better understand the value of this change.
>>>>
>>>
>>> Hi Andrew,
>>>
>>> Is the following description acceptable for you?
>>>
>>>
>>> Since HugeTLB doesn't support page reclaim, enforcing the limit at
>>> page fault time implies that, the application will get SIGBUS signal
>>> if it tries to fault in HugeTLB pages beyond its limit. Therefore the
>>> application needs to know exactly how many HugeTLB pages it uses before
>>> hand, and the sysadmin needs to make sure that there are enough
>>> available on the machine for all the users to avoid processes getting
>>> SIGBUS.
> 
> yes, this is pretty much a definition of hugetlb.
> 
>>> When running some open-source software, it may not be possible to know
>>> the exact amount of hugetlb it consumes, so cannot correctly configure
>>> the max value. If there is a peak metric, we can run the open-source
>>> software first and then configure the max based on the peak value.
> 
> I would push back on this. Hugetlb workloads pretty much require to know
> the number of hugetlb pages ahead of time. Because you need to
> preallocate them for the global hugetlb pool. What I am really missing
> in the above justification is an explanation of how come you know how to
> configure the global pool but you do not know that for a particular
> cgroup. How exactly do you configure the global pool then?

Yes, in this scenario, it's indeed challenging to determine the
appropriate size for the global pool. Therefore, a feasible approach is
to initially configure a larger value. Once the software is running
within the container successfully, the maximum value for the container
and the size of the system's global pool can be determined based on the
peak value, otherwise, increase the size of the global pool and try
again. so I believe the peak metric is useful for this scenario.


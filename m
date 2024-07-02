Return-Path: <cgroups+bounces-3476-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AF91EBC0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8109E1C21F6A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236348F44;
	Tue,  2 Jul 2024 00:19:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7E817;
	Tue,  2 Jul 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879556; cv=none; b=UK4jvO6PsAy/wtgR4m3Ywhg/0TCXCOhq4BwzajYE8KNG4LifX1s4rSWnG50xxLatg/1ol+QmNZ2cnuWSXqRnLpRNa5Kbpp+xDe2BvCCOhw/Zogtt2NAKCHyHFlirJmL46jX4Sm72HjelaNIfY5k0tDkW4TyZvO/pP1rAR8Uu4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879556; c=relaxed/simple;
	bh=M+44DFQP1ah2DNL1TocHiBNwyFYryPGUnuaQ9b8Cfz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OAZ2F3HqQwcb8c+w/At7W1w8poqx5f7i1rXNxxFDg51WCBclNQYZ5Dp2g38L4M/4c9yccv8PyZprNB8ObBEP1DX+6gNhbwtt7fIA3bNUa59bTDolXBeI+IDMVZoIMTGoWTqSnavs5mzZkc9PBdmAuN56V8LOAGMaiLMOFKjJrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCk6P648wznYls;
	Tue,  2 Jul 2024 08:18:53 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 87B5C18007E;
	Tue,  2 Jul 2024 08:19:08 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 08:19:08 +0800
Message-ID: <a7dbb226-9382-fe4f-43b2-9ce46c12026d@huawei.com>
Date: Tue, 2 Jul 2024 08:19:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/misc: Introduce misc.peak
To: Randy Dunlap <rdunlap@infradead.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<kamalesh.babulal@oracle.com>, <haitao.huang@linux.intel.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240701125259.2611466-1-xiujianfeng@huawei.com>
 <047579c5-582a-46ac-8967-e9ca9a90cea7@infradead.org>
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <047579c5-582a-46ac-8967-e9ca9a90cea7@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/1 23:01, Randy Dunlap wrote:
> Hi--
> 
> On 7/1/24 5:52 AM, Xiu Jianfeng wrote:
>> Introduce misc.peak to record the historical maximum usage of the
>> resource, as in some scenarios the value of misc.max could be
>> adjusted based on the peak usage of the resource.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++++
>>  include/linux/misc_cgroup.h             |  2 ++
>>  kernel/cgroup/misc.c                    | 29 +++++++++++++++++++++++++
>>  3 files changed, 40 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index ae0fdb6fc618..48ae30f2d9ab 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2646,6 +2646,15 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
>>  	  res_a 3
>>  	  res_b 0
>>  
>> +  misc.peak
>> +        A read-only flat-keyed file shown in the all cgroups.  It shows
> 
> 	                               shown in all cgroups. It shows

Thanks for your review, will fix it in v2.
> 
>> +        the historical maximum usage of the resources in the cgroup and
>> +        its children.::
>> +
>> +	  $ cat misc.peak
>> +	  res_a 10
>> +	  res_b 8
>> +
>>    misc.max
>>          A read-write flat-keyed file shown in the non root cgroups. Allowed
>>          maximum usage of the resources in the cgroup and its children.::
>> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
>> index e799b1f8d05b..8aa69818291e 100644
>> --- a/include/linux/misc_cgroup.h
>> +++ b/include/linux/misc_cgroup.h
>> @@ -30,11 +30,13 @@ struct misc_cg;
>>  /**
>>   * struct misc_res: Per cgroup per misc type resource
>>   * @max: Maximum limit on the resource.
>> + * $watermark: Historical maximum usage of the resource.
> 
>       @watermark:
> 
>>   * @usage: Current usage of the resource.
>>   * @events: Number of times, the resource limit exceeded.
>>   */
>>  struct misc_res {
>>  	u64 max;
>> +	u64 watermark;
>>  	atomic64_t usage;
>>  	atomic64_t events;
>>  };
> 
> 


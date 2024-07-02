Return-Path: <cgroups+bounces-3483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81791F0AA
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB650284522
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3381487E2;
	Tue,  2 Jul 2024 08:00:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601222AE66;
	Tue,  2 Jul 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907222; cv=none; b=QvKYfXggYbuCYgCABtkwSIsfT65+EmrL57y7onq/FBLQsgNhhjDCbiRcdQZZwN3hWs1GyjyMuM22N70ZzH4RFgQiPYWrQSYeZPmPNs6D/oC2fBRw+lo9NqYWgltFFFcKTEOtgkmr71Yre5cMyUg9XsZHooKntDHg3tmu0UAYxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907222; c=relaxed/simple;
	bh=c8VGHJXPXEpy3xwGECZzCe1tAvhvCx2JnJAKiN5R+Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PbzMcFxzjsiNocY+VmtxMMLAxHjIpSBzQ3obSXbvM8lHSxddOn/iOrTMK0msyDbf5CyXbPx52i4kHaXs4EKzOonPhTWLWQ+q3BCj7G5GO0yig7l+nqsb8eeHwOB/GlJysuJQng8oEb5bvDzNKpSyO1ggf6AOrQDSVtWBxgrnH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WCwFf2JFbzxTt7;
	Tue,  2 Jul 2024 15:55:50 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 99641180A9C;
	Tue,  2 Jul 2024 16:00:16 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 16:00:16 +0800
Message-ID: <acebe1de-1281-cfd2-8497-b7d52a26e8ec@huawei.com>
Date: Tue, 2 Jul 2024 16:00:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 -next] cgroup/misc: Introduce misc.peak
Content-Language: en-US
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<haitao.huang@linux.intel.com>
CC: <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240702004820.2645868-1-xiujianfeng@huawei.com>
 <8bd9b2a6-e1c2-423c-9cea-45b14763e251@oracle.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <8bd9b2a6-e1c2-423c-9cea-45b14763e251@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/2 15:24, Kamalesh Babulal wrote:
> Hi,
> 
> On 7/2/24 6:18 AM, Xiu Jianfeng wrote:
> [...]
> 
>> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>> index 79a3717a5803..7f5180a8f461 100644
>> --- a/kernel/cgroup/misc.c
>> +++ b/kernel/cgroup/misc.c
>> @@ -121,6 +121,17 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
>>  		  misc_res_name[type]);
>>  }
>>  
>> +static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
>> +{
>> +	u64 old;
>> +
>> +	do {
>> +		old = READ_ONCE(res->watermark);
>> +		if (cmpxchg(&res->watermark, old, new_usage) == old)
>> +			break;
>> +	} while (1);
>> +}
>> +
>>  /**
>>   * misc_cg_try_charge() - Try charging the misc cgroup.
>>   * @type: Misc res type to charge.
>> @@ -159,6 +170,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
>>  			ret = -EBUSY;
>>  			goto err_charge;
>>  		}
> 
> you may need to re-introduce the check:
> 	if (new_usage > READ_ONCE(res->watermark))
> 
> without it, the res->watermark will be updated unconditionally.

Thanks for your review, will fix it.

> 
>> +		misc_cg_update_watermark(res, new_usage);
>>  	}
>>  	return 0;
>>  
> 
> 


Return-Path: <cgroups+bounces-3124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675388FF9C3
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 03:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01192283A6A
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 01:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238311185;
	Fri,  7 Jun 2024 01:53:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78B4C76;
	Fri,  7 Jun 2024 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725205; cv=none; b=JM/ZBMtZQGx4XGdVOFV7Yf9SHYFlEE4NZcovbJR0vpyjj/Un1v6GehamESmHoKgvMdttBAAG3+z5f9hzofBEaTnhmZ5/w0tz7FJ5h8Chxv24KvNeQi1W4uQnqZifcB9jDMDXw18X6IX9BOBn81ybae50dQX4W+OXgVmKtx0rsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725205; c=relaxed/simple;
	bh=7vGIMh1HNy8AvtODTNNL5y8KTBjmNAZW3NpHkolT8OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F5h+BFRAnIWcxbjzDZ4yUGVxpsGBsY5utv9LNlitzJCrurLIa3xTvlhpLFccuKwdtolvNaX+mKE5eBy6fP4FQmXTCF0LlVXAcPTxGBwwZN75IfeSnj8BWW5pDELzIZI3T/CM2d3FLj46bvu3tXf0CTv3g009og5G/IXUcOPbBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VwPMD1B90z1xsND;
	Fri,  7 Jun 2024 09:51:52 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E31B1A0188;
	Fri,  7 Jun 2024 09:53:13 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 7 Jun
 2024 09:53:12 +0800
Message-ID: <683e88d8-aa34-40c0-a8d5-d7f8f9d4deee@huawei.com>
Date: Fri, 7 Jun 2024 09:53:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/14] cgroup/misc: Add per resource callbacks for CSS
 events
To: Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
	<dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
	<mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-3-haitao.huang@linux.intel.com>
 <eeb1f936-2989-4de0-8353-b2373ce47474@huawei.com>
 <op.2ox8wt11wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <op.2ox8wt11wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

I think it is better when _misc_cg_res_alloc fails, it just calls 
_misc_cg_res_free(cg, index)(add index parameter, it means ending of 
iterator), so it can avoid calling ->free() that do not call ->alloc().

And in misc_cg_free, just call _misc_cg_res_free(cg, MISC_CG_RES_TYPES)  
to free all.


Thanks

Ridong


On 2024/6/6 22:51, Haitao Huang wrote:
> On Thu, 06 Jun 2024 08:37:31 -0500, chenridong <chenridong@huawei.com> 
> wrote:
>
>>
>>   If _misc_cg_res_alloc fails, maybe some types do not call 
>> ->alloc(), but all types ->free() callback >will be called, is that ok?
>>
> Not sure I understand. Are you suggesting we ignore failures from 
> ->alloc() callback in _misc_cg_res_alloc() as it is per-resource, and 
> have ->free() callback and resource provider of the failing type to 
> handle the failure internally?
>
> IIUC, this failure only happens when a specific subcgroup is created 
> (memory running out for allocation) so failing that subcgroup as a 
> whole seems fine to me. Note the root node is static and no 
> pre-resource callbacks invoked by misc. And resource provider handles 
> its own allocations for root. In SGX case we too declare a static 
> object for corresponding root sgx_cgroup struct.
>
> Note also misc cgroup (except for setting capacity[res] = 0 at root) 
> is all or nothing so no mechanism to tell user "this resource does not 
> work but others are fine in this particular cgroup."
>
> Thanks
> Haitao
>


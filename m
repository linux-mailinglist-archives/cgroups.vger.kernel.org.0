Return-Path: <cgroups+bounces-4304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003C952E3E
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159F01F2614B
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FC17C9B0;
	Thu, 15 Aug 2024 12:29:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D5148847;
	Thu, 15 Aug 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724945; cv=none; b=PCYGjdWRcjTjXQxuQZ5fgAPo2kPbd8GuN+H++y/ztVOAi54pzhiUm7RlujZTXyWEUtMJZ777K2uAtNdV5s9zSGlK4RZHBBFl8mb3IDuiVSUNd7yUS466xvRZKQqBDyUhxk5WHA9NoesvgqRjkz0ySXVQTmegXNW/X+lYlWlbSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724945; c=relaxed/simple;
	bh=q+3JW+TJIv2uaOj0tc308BO0oWOka3Uf9ZIKkpfddTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FaXmj7Tlc4SFwFrpQMdSpFlTS/gZhZMPiL8rS49qgBnJ3Po+01cd9MxmemTxCJz8ILLREZbMgvIzYhzULT0eAHWnWWD29njTuJdugMabwdfYpHPFWvI6TVFcgdVtD/8kZzmuNxAAqSMtdRViS406DEY5xtyzraRJlzaXqZZocfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wl4754y4lz20lhY;
	Thu, 15 Aug 2024 20:24:17 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C6D86180019;
	Thu, 15 Aug 2024 20:28:52 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 15 Aug
 2024 20:28:52 +0800
Message-ID: <5262cc0e-8e89-4ba0-8777-2ba49ec7c1f8@huawei.com>
Date: Thu, 15 Aug 2024 20:28:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: update some statememt about delegation
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240815024118.3137952-1-chenridong@huawei.com>
 <vrozw5w2l32ni43akbf3xceq6rqpkskdlwbp2ko32qxv546n6s@qtw4l3qt357v>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <vrozw5w2l32ni43akbf3xceq6rqpkskdlwbp2ko32qxv546n6s@qtw4l3qt357v>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/15 20:12, Michal Koutný wrote:
> Hi,
> thanks for writing up on the care needed when you only use namespacing
> (and not de-privilgation) for delegation.
> 
> On Thu, Aug 15, 2024 at 02:41:18AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> ...
> 
> What about some more clarifications to prevent other confusions?
> 
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -533,10 +533,12 @@ cgroup namespace on namespace creation.
>>   Because the resource control interface files in a given directory
>>   control the distribution of the parent's resources, the delegatee
>>   shouldn't be allowed to write to them.  For the first method, this is
>> -achieved by not granting access to these files.  For the second, the
>> -kernel rejects writes to all files other than "cgroup.procs" and
>> -"cgroup.subtree_control" on a namespace root from inside the
>> -namespace.
>> +achieved by not granting access to these files.  For the second, files
>> +outside the namespace shouldn't be visible from within the delegated
>                           should be hidden from the delegatee by the
> means of at least mount namespacing, and the kernel...
> 
>> +namespace, and the kernel rejects writes to all files on a namespace
>> +root from inside the namespace, except for those files listed in
>            inside the cgroup namespace
> 
>> +"/sys/kernel/cgroup/delegate" (including "cgroup.procs", "cgroup.threads",
>> +"cgroup.subtree_control", etc.).
>    
> ...
>> -	 * except for the files explicitly marked delegatable -
>> -	 * cgroup.procs and cgroup.subtree_control.
>> +	 * except for the set delegatable files shown in /sys/kernel/cgroup/delegate,
>> +	 * including cgroup.procs, cgroup.threads and cgroup.subtree_control, etc.
> 
> "Marked delegatable" (meaning CFTYPE_NS_DELEGATABLE) is appropriate
> comment in the code, a reference to the sysfs file is only consequential
> to this marking. A minimal change would be like:
> 
> -	 * cgroup.procs and cgroup.subtree_control.
> +	 * e.g. cgroup.procs and cgroup.subtree_control.
Thank you, Michal, I will send new patch.

Thanks,
Ridong


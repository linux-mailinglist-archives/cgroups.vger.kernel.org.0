Return-Path: <cgroups+bounces-2572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5D8A9107
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA54E1C20F3C
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51F43AAD;
	Thu, 18 Apr 2024 02:11:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFC3BB3D;
	Thu, 18 Apr 2024 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406279; cv=none; b=ccs5IJA+kJU9gzkMH0CaNMjncQmPks+Irxckf9iFL0oqj7fVL+0NhAD2U0uKuS5hw72v6bbKJTqrDTC2PgEDg3F346KSMkEh8cjJ41QBxPypcNJpQK/C324eI3g4ycC2VXQpf8NTe0RmzuDHk7v075ZYZ/D9LW48vlj0x0bTSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406279; c=relaxed/simple;
	bh=4V4cAQ/jRx0zM3nrZljvL+0RkNZz00kTJnbQyfB1IwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IRyv8uAA0PwSDfqjeXaA0F7zAuXtXue8HPLzKTqiFGLlzNo6t9J5qDS2ggs38rLM3FOBSUfNQnYoxovz/PNh3Fl8E/Qyjjcr9IetoK6/KN5zqZU0iMODi0z4NEJGg1YGErL5mlz++ML7i/3H0BWtKdAN3MZ/3xfSd2qvRFc/auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VKh5n0YxKz1xv3q;
	Thu, 18 Apr 2024 10:08:45 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C52C1A016C;
	Thu, 18 Apr 2024 10:11:09 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:11:08 +0800
Message-ID: <f5c946d2-6271-8619-72ca-15860555218d@huawei.com>
Date: Thu, 18 Apr 2024 10:11:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup: don't call cgroup1_pidlist_destroy_all()
 for v2
To: Tejun Heo <tj@kernel.org>, Xiu Jianfeng <xiujianfeng@huaweicloud.com>
CC: <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240417021359.883736-1-xiujianfeng@huaweicloud.com>
 <ZiB_Jhj2I8YdYs64@slm.duckdns.org>
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZiB_Jhj2I8YdYs64@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/4/18 10:02, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 17, 2024 at 02:13:59AM +0000, Xiu Jianfeng wrote:
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> Currently cgroup1_pidlist_destroy_all() will be called when releasing
>> cgroup even if the cgroup is on default hierarchy, however it doesn't
>> make any sense for v2 to destroy pidlist of v1.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  kernel/cgroup/cgroup-v1.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index 520a11cb12f4..46d89157d558 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -197,6 +197,8 @@ void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
>>  {
>>  	struct cgroup_pidlist *l, *tmp_l;
>>  
>> +	if (cgroup_on_dfl(cgrp))
>> +		return;
> 
> Can you move the test to the caller?

Sure, will do in v2.

> 
> Thanks.
> 


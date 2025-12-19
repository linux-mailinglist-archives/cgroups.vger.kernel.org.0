Return-Path: <cgroups+bounces-12525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6463CCE161
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66393042195
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CB15539A;
	Fri, 19 Dec 2025 00:42:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167579CD;
	Fri, 19 Dec 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104946; cv=none; b=LDSAJ5sf88jqr+ovBvjC+/ZW85TfuxN2mniHK64GWJFLoLk/sj1l/iwi1rSz0MrnE00ub+2ztaiFD0lkkKetKdadZ8ZS1a8/ocNuUoxCuoxFhuSH5u1E4qS59FyIchUM9+fkCoqBtIVvK8Seq3MOl5lYcPsXcFy8miWqLuiE0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104946; c=relaxed/simple;
	bh=JEX17vKOEKNHE+UdilwGUxfWiwOKI+hzfHs/1W51WyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BexbaR8ZyRPUj0gIhYP9TqSWngy4De+dhlE5VaRl60AX8qibg7pEfdpWpLZCr8uTSdmd6bSg5220eeft9R5CApMS/S6fkeh99WHUbQzE9nW7auCvbUKre52cQEHmIaou0Qkrxp07e7A7uikcxlOd8QpyTSQ+XReWiEPGHi07zJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dXTJK1tH6zKHMMs;
	Fri, 19 Dec 2025 08:42:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4D344056E;
	Fri, 19 Dec 2025 08:42:20 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_dsn0RpGjG9Ag--.52091S2;
	Fri, 19 Dec 2025 08:42:20 +0800 (CST)
Message-ID: <2473d785-0c5f-495d-9922-27e8efa17af1@huaweicloud.com>
Date: Fri, 19 Dec 2025 08:42:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 0/6] cpuset: further separate v1 and v2
 implementations
To: Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251218093141.2687291-1-chenridong@huaweicloud.com>
 <199daf7b81a301a7709e586ed3ffe49e@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <199daf7b81a301a7709e586ed3ffe49e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3l_dsn0RpGjG9Ag--.52091S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5
	UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/19 2:39, Tejun Heo wrote:
>> Chen Ridong (6):
>>   cpuset: add lockdep_assert_cpuset_lock_held helper
>>   cpuset: add cpuset1_online_css helper for v1-specific operations
>>   cpuset: add cpuset1_init helper for v1 initialization
>>   cpuset: move update_domain_attr_tree to cpuset_v1.c
>>   cpuset: separate generate_sched_domains for v1 and v2
>>   cpuset: remove v1-specific code from generate_sched_domains
> 
> Applied 1-6 to cgroup/for-6.20.
> 
> Thanks.
> 

Thank you.

-- 
Best regards,
Ridong



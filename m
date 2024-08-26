Return-Path: <cgroups+bounces-4444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EEC95E659
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CE928137C
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E06FB0;
	Mon, 26 Aug 2024 01:37:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF146BA;
	Mon, 26 Aug 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636228; cv=none; b=HBSUOElaIzEyd2fntpoz8K3AdCZ+My5pqguW/c9AVD0QDF6OwTHTNR0BmSBzS2KOVZpJaN59tRKPk0rnbXEcDO/G1qOm/TpCaa/IUbkbrUEIxRuYHeQKwxeVjBZM8uGIqJhjOjSJ29pRPXaRkL6LyyV34PZkFUl5pxlWO6Ol9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636228; c=relaxed/simple;
	bh=EBjWHjEKR4e+UpG33k5Fm9SLYq4gbv5Jp9fncEdu2gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d3AGA9bA9XT8VcSTEi5w1X5R7TdtDJguWJLyXypltb5xS7s6rIoYc2u0djLwLwkt4F4vWZpiBk3cehtyO841sIBKP3hFEk+9Q0Fhihsv6HWUcVj7HpNzjKAGBmjbbnPZO38fjcwme9ZjhMDDliBPt0MfOgQ1S3qrKgYPiFa7Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WsYDX54KtzyR2T;
	Mon, 26 Aug 2024 09:36:28 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 66D301402CA;
	Mon, 26 Aug 2024 09:36:56 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 09:36:55 +0800
Message-ID: <96d8bd54-e390-40c8-a649-02ba7dafbf47@huawei.com>
Date: Mon, 26 Aug 2024 09:36:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 00/11] cgroup:cpuset:separate legacy cgroup v1
 code and put under config option
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240823100110.472120-1-chenridong@huawei.com>
 <6dde95a0-2cad-4ca8-9ea3-2b4c6e70db93@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <6dde95a0-2cad-4ca8-9ea3-2b4c6e70db93@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/26 1:20, Waiman Long wrote:
> On 8/23/24 06:00, Chen Ridong wrote:
>> Cgroups v2 have been around for a while and many users have fully adopted
>> them, so they never use cgroups v1 features and functionality. Yet they
>> have to "pay" for the cgroup v1 support anyway:
>> 1) the kernel binary contains an unused cgroup v1 code,
>> 2) some code paths have additional checks which are not needed,
>> 3) some common structures like task_struct and mem_cgroup contain unused
>>     cgroup v1-specific members.
>>
>> Cgroup memory controller has already separated legacy code to
>> memory-v1.c. So it is time to do the same thing for cpuset controller.
>>
>> This patchset aims to do:
>> 1) moving cgroup v1-specific cpuset code to the new cpuset-v1.c file,
>> 2) putting definitions shared by cpuset.c and cpuset-v1.c into the
>>     cpuset-internal.h header,
>> 3) introducing the CONFIG_CPUSETS_V1 config option, turned off by 
>> default,
>> 4) making cpuset-v1.c to compile only if CONFIG_CPUSETS_V1 is set.
>>
>> This patchset is based on -next commit c79c85875f1a ("Add linux-next
>> specific files for 20240823") and assumes that "Some optimizations about
>> cpuset" series are merged, which are applied to cgroup/for-6.12.
>>
>>
>> Chen Ridong (11):
>>    cgroup/cpuset: introduce cpuset-v1.c
>>    cgroup/cpuset: move common code to cpuset-internal.h
>>    cgroup/cpuset: move memory_pressure to cpuset-v1.c
>>    cgroup/cpuset: move relax_domain_level to cpuset-v1.c
>>    cgroup/cpuset: move memory_spread to cpuset-v1.c
>>    cgroup/cpuset: add callback_lock helper
>>    cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
>>    cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
>>    cgroup/cpuset: move v1 interfaces to cpuset-v1.c
>>    cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
>>    cgroup/cpuset: add sefltest for cpuset v1
>>
>>   MAINTAINERS                                   |   3 +
>>   include/linux/cpuset.h                        |   8 +-
>>   init/Kconfig                                  |  13 +
>>   kernel/cgroup/Makefile                        |   1 +
>>   kernel/cgroup/cpuset-internal.h               | 307 +++++++
>>   kernel/cgroup/cpuset-v1.c                     | 565 ++++++++++++
>>   kernel/cgroup/cpuset.c                        | 850 +-----------------
>>   .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
>>   8 files changed, 987 insertions(+), 837 deletions(-)
>>   create mode 100644 kernel/cgroup/cpuset-internal.h
>>   create mode 100644 kernel/cgroup/cpuset-v1.c
>>   create mode 100755 
>> tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
>>
> Patch 2 doesn't apply to the latest cgroup/for-6.12 branch of the cgroup 
> tree. You will have to update the patch series.
> 
> Cheers,
> Longman
> 
> 

Thanks, I will update soon.

Thanks,
Ridong


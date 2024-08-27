Return-Path: <cgroups+bounces-4487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31B95FE7F
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686271F21F3C
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998A8F66;
	Tue, 27 Aug 2024 01:47:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F0610C;
	Tue, 27 Aug 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723256; cv=none; b=R46Lun4+BHTGk62+8R90ve8nQtIvytUVSAyMdxI43cYr6MWoZdxwy5zfsYWDM9pU/9qz7n/6tZ2JhYvtMEibxAAaYpe8VD+rskFBmdKY/AFrou6RDD4aaQnDdHh7nRQWiHurlIx7Aektw1J0MSv7/v5Fq8iyY3uM+BMJbzWH0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723256; c=relaxed/simple;
	bh=NWVpJt6OANH3ysPHjZ2B+1M+5IOXGK9SHbhGWio8vQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tPx/eHfyOWV95BnsyS5E7ZRx8Xd2rL2MiSTKDE1d1OuQMXCXEcbreUPoT6RbDo+J9QxxFupa2Ac7e0X63sOdhW5gWKUTcvbIArwPstUGtpTGguKm6ZO8q98EfAuyD283MoJ3Q2PxSPkjQu8/OH9V++2CGgCRohb6+Lz90SQb1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wt9Pv0h7lz16PQM;
	Tue, 27 Aug 2024 09:46:43 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F8851800D3;
	Tue, 27 Aug 2024 09:47:29 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 09:47:28 +0800
Message-ID: <4feacb1b-5b6e-4e5f-b621-78ec3cd57a01@huawei.com>
Date: Tue, 27 Aug 2024 09:47:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 09/11] cgroup/cpuset: move v1 interfaces to
 cpuset-v1.c
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
CC: <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <adityakali@google.com>,
	<sergeh@kernel.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenridong@huaweicloud.com>
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-10-chenridong@huawei.com>
 <eaef1faf-c3f3-4664-ae7d-5cca611925e4@redhat.com>
 <ZszaJFzcmBskojVS@slm.duckdns.org>
 <9793ce0d-842a-4876-860a-9b7b8d538e45@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <9793ce0d-842a-4876-860a-9b7b8d538e45@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/27 3:47, Waiman Long wrote:
> 
> On 8/26/24 15:40, Tejun Heo wrote:
>> On Mon, Aug 26, 2024 at 03:30:14PM -0400, Waiman Long wrote:
>> ...
>>> Another alternative is to include cpuset-v1.c directly into cpuset.c 
>>> like
>>>
>>> #ifdef CONFIG_CPUSETS_V1
>>> #include "cpuset-v1.c"
>>> #else
>>>     ....
>>> #endif
>>>
>>> Then you don't need to change the names and will not need 
>>> cpuset-internal.h.
>>> It is up to you to decide what you want to do.
>> FWIW, I'd prefer to have cpuset1_ prefixed functions declared in 
>> cpuset1.h
>> or something rather than including .c file.
> 
> Sure. Let's have "cpuset1_" prefix if it is v1 specific and "cpuset_" 
> prefix if it is used by both v1 and v2. That applies only to newly 
> exposed names.
> 
> Cheers,
> Longman
> 
I will rename the functions with cpuset1_/cpuset_ prefix.

Thanks,
Ridong


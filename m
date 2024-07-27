Return-Path: <cgroups+bounces-3923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A993DDAB
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 09:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234AE1F22C43
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0670381D4;
	Sat, 27 Jul 2024 07:26:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D0374C2;
	Sat, 27 Jul 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722065182; cv=none; b=Eja+TU9S9E+rNqextgnSA9sGK3/Nu3x+S/p0Pq8igud4KmjBKd3lJD5Hk8bpMYq7sIwsOCXZu2+VziWAqxBbRm4C8N4utDxIGgRbr7y3anaooKmQKQKAJp0NukI2noxKE4ioDmbLf7dKA+HHIGZndPYUrJbB1Qwd5WH8mJJZyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722065182; c=relaxed/simple;
	bh=O5h6v4LX/XxQHqQLQSNlrrEJ6Ieu09w7kscKsBy0cuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cp5ccEUrl9nqcFmjPtPyB7XxX7O1bpmrHZM0l9x+CELWnbLoCmovEBFoHvG9Q8IVz5gU1Zx+6YSR6annADe+X4Xm9VwFmuBcr9ETZPGmYL79cXtFYiv16rHt4PxH8x2WwxzGUmsheNa8R27qqdjrj1/TLdNCOHcX31zwqjEyda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WWGJk5nRhz28fcQ;
	Sat, 27 Jul 2024 15:21:42 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F3451402CF;
	Sat, 27 Jul 2024 15:26:11 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 27 Jul
 2024 15:26:10 +0800
Message-ID: <62b0b761-37bf-4ae8-9eef-9ac275e99d6c@huawei.com>
Date: Sat, 27 Jul 2024 15:26:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: reduce redundant comparisons for
 generating shecd domains
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240726085946.2243526-1-chenridong@huawei.com>
 <cfpvrcplrjeb7r4zscfjnmeahpi5c5c3kxtql2jyrj4hdp2l2x@25sfleq3wjph>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <cfpvrcplrjeb7r4zscfjnmeahpi5c5c3kxtql2jyrj4hdp2l2x@25sfleq3wjph>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/26 19:37, Michal Koutný wrote:
> Hello.
> 
> On Fri, Jul 26, 2024 at 08:59:46AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> In the generate_sched_domains function, it's unnecessary to start the
>> second for loop with zero, which leads redundant comparisons.
>> Simply start with i+1, as that is sufficient.
> 
> Please see
> https://lore.kernel.org/r/20240704062444.262211-1-xavier_qy@163.com
> 
> Your patch is likely obsoleted with that.
> 
> Michal

Thanks, Michal, I'm sorry I didn't notice these patches. It's a good 
idea to optimize with uf_node.

Thanks
Ridong


Return-Path: <cgroups+bounces-2907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0348C5F39
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF7C1C20B70
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D72364DC;
	Wed, 15 May 2024 02:47:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB012E83F;
	Wed, 15 May 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741234; cv=none; b=pz4laoqbZa2dJ+uq7aWmvE3UsjleFpc4ZNTnhbMW0vm7cVljCoERvmtDXkWDdAr2vvW3hGfBSdD3i5oA89su12z300lbCKvJWQTtsl6Y2du7Q4i7GKTDyLXhbngv4HlV8AmA/TBsIPsflzuNt/IRBoT8PJKUsLfFmI2guluhG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741234; c=relaxed/simple;
	bh=I9V72DkiQhdP85f8x4+pkp/kW6Su4vtYx3XDQpiP11k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HGuRbkw1ANeFztygbqxQaDskKpywi6vIz2kKIEf/gjjYoeLxHMOR38DC9/S9VFoUmmjAMkGHM2GjKecoaUo+BQgap08WUMHbfCo9Ub7TpfzFBggHRSzvdO5+BJX9liqrzHRf1/47bs6B+W9wmKcCl0j3G+bySp5Eqbml40Cb1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VfHZz5Xn0zgZCs;
	Wed, 15 May 2024 10:43:07 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CF52140155;
	Wed, 15 May 2024 10:47:08 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 10:47:08 +0800
Message-ID: <41fdf6cb-ec1b-ff07-44f4-3ba01b45ebda@huawei.com>
Date: Wed, 15 May 2024 10:47:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] memcg: don't handle event_list for v2 when
 offlining
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240514131106.1326323-1-xiujianfeng@huawei.com>
 <ZkNwthw5vJrnQSLL@tiehlicka> <ZkOBaNffNi4rmR8h@P9FQF9L96D>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZkOBaNffNi4rmR8h@P9FQF9L96D>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/5/14 23:21, Roman Gushchin wrote:
> On Tue, May 14, 2024 at 04:09:58PM +0200, Michal Hocko wrote:
>> On Tue 14-05-24 13:11:06, Xiu Jianfeng wrote:
>>> The event_list for memcg is only valid for v1 and not used for v2,
>>> so it's unnessesary to handle event_list for v2.
>>
>> You are right but the code as is works just fine. The list will be
>> empty. It is true that we do not need to take event_list_lock lock but
>> nobody should be using this lock anyway. Also the offline callback is
>> not particularly hot path. So why do we want to change the code?
> 
> +1 to that.
> 
> Plus this code will be moved to a separate function in mm/memcontrol-v1.c
> and luckily can be compiled out entirely for users who don't need the
> cgroup v1 support.

I found the patchset you mentioned, Thanks.

> 
> Thanks!


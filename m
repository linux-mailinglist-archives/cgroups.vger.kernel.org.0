Return-Path: <cgroups+bounces-4929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CF97E500
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 05:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AFB1C20ED1
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70CE2CA9;
	Mon, 23 Sep 2024 03:37:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C77256E
	for <cgroups@vger.kernel.org>; Mon, 23 Sep 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727062646; cv=none; b=VaHcI4lJkQPOiChSHlt91y1DY5leZwmj7KLPXMCOrJ+o0ghQpwm7DjmbVHp/xJAvXXIqCD65bCDenkaC1S9oVBlN+ZJkamIirSty0UFroJP0EXLenfIxZmeHlhdgEA3sQs4s6zHm0z0yB35uFFy0EMIyYcnN1JWKSFNHkII2jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727062646; c=relaxed/simple;
	bh=ur5YDFEeG9hSzNThhj3L5wKruJQXdOIJOuyTtA5FLcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=tHqwPDIX7Fr9/qvY/Dnb0X7JAzshH3bTmkBYIbZCZtDDBHRfM3ZsNHOh4AGxRBbloBbUerna3AkYHh+Qxg+9oJU7CGHjd0tVJjlwqGpOK2w1jQxQceM+IfnJWWp/nkr+xBRTy3DyCZat2TMMPU4suzhKTHBUq/ZtOrxftottZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XBpZc68WwzQrRr;
	Mon, 23 Sep 2024 11:36:56 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id CF3A01403D4;
	Mon, 23 Sep 2024 11:37:15 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 23 Sep
 2024 11:37:15 +0800
Message-ID: <d9a9186b-8b4b-4ead-8e39-83b173539f3e@huawei.com>
Date: Mon, 23 Sep 2024 11:37:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHC v3 -next 0/3] Some optimizations about freezer
From: chenridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
References: <20240915071307.1976026-1-chenridong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240915071307.1976026-1-chenridong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/9/15 15:13, Chen Ridong wrote:
> I optimized the freezer to reduce redundant loops, and I add helper
> to make code concise.
> 
> The following subtree was tested to prove whether my optimizations are
> effective.
>     0
>   / | \ \
> A  B C  1
>        / | \ \
>       A  B C  2
>          .....
> 	         n
>                 / | \
>                A  B C
> 
> I tested by following steps:
> 1. freeze 0
> 2. unfreeze 0
> 3. freeze 0
> 4. freeze 1
> 
> And I measured the elapsed time(ns).
> 
> n=10
> 	freeze 0	unfreeze 0	freeze 0	freeze 1
> BEFORE	106179390	94016050	110423650	95063770
> AFTER	96473608	91054188	94936398	93198510
> 
> n=50
> 	freeze 0	unfreeze 0	freeze 0	freeze 1
> BEFORE	109506660	105643800	105970220	96948940
> AFTER	105244651	97357482	97517358	88466266
> 
> n=100
> 	freeze 0	unfreeze 0	freeze 0	freeze 1
> BEFORE	127944210	122049330	120988900	101232850
> AFTER	117298106	107034146	105696895	91977833
> 
> As shown above, after optimizations, it can save elapsed time.
> By freezing 0 and subsequently freezing 1, the elapsed time is consistent,
> indicating that my optimizations are highly effective.
> 
> ---
> v3:
> - fix build warnings reported-by kernel test robot.
> 
> v2:
> - open code inside the loop of cgroup_freeze instead of inline function.
> - add helper to make code concise.
> - remove selftest script(There are hierarchy test in test_freeze.c, I
>    think that is enough for this series).
> 
> Chen Ridong (3):
>    cgroup/freezer: Reduce redundant traversal for cgroup_freeze
>    cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper
>    cgroup/freezer: Reduce redundant propagation for
>      cgroup_propagate_frozen
> 
>   include/linux/cgroup-defs.h |   6 +-
>   kernel/cgroup/freezer.c     | 110 ++++++++++++++++++------------------
>   2 files changed, 59 insertions(+), 57 deletions(-)
> 

Friendly ping.

Best regards,
Ridong


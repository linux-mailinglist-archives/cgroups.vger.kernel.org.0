Return-Path: <cgroups+bounces-3674-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9B931463
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F841C21416
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38A18C322;
	Mon, 15 Jul 2024 12:35:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A46188CDE;
	Mon, 15 Jul 2024 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046938; cv=none; b=u+YI94+OrDZaYUdILFbOifzIQjR3nooEBhatytDi6FhlhID1SeKd97dVC49MgTl9A1L9eW6z0t83FTImq9J5Vwz8YlNEbvBqgJTCw+0r4LSspPaIRDTpvMZ/JvAfctlY1q5ZX17iM6/KXS9fL/gTa6SPfOuZwpHcKzNEK2mLaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046938; c=relaxed/simple;
	bh=f/IoyPJRtU8HcxhEgeP6DA0rm03S9PM75FzmRXAvQug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XreBfRn5/xK6bwltMXNz6x5Fm2L1lp4OW4/RcoFs7ZzDZYceObwXRSCcAx1wQ/oiEkMrikyW9L+RQua8OF3/adUfezHGxYZg25FJSwtBcrKZ0efMu134yBncht/S9pidwLFawdqvYpHd6eP3xGBY9VsbKeYb1xxiQKSLNCDdkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WN1kp4GZNzxStB;
	Mon, 15 Jul 2024 20:30:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 057D11800A0;
	Mon, 15 Jul 2024 20:35:32 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 20:35:31 +0800
Message-ID: <57994fe4-edd0-bc28-c134-83f72579c6c8@huawei.com>
Date: Mon, 15 Jul 2024 20:35:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
CC: <josef@toxicpanda.com>, <axboe@kernel.dk>, <lizefan.x@bytedance.com>,
	<hannes@cmpxchg.org>, <cgroups@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240712085141.3288708-1-xiujianfeng@huawei.com>
 <ZpK8Nup6_sOvSZ7E@slm.duckdns.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZpK8Nup6_sOvSZ7E@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/14 1:41, Tejun Heo wrote:
> Hello,
> 
> Sorry about the previous reply. I completely misread the patch.
> 
> On Fri, Jul 12, 2024 at 08:51:41AM +0000, Xiu Jianfeng wrote:
> ...
>> only compiling tested
> 
> It'd be better if there's a bit more verification.
> 
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 37e6cc91d576..01d3408c2fc6 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -2183,11 +2183,13 @@ void blk_cgroup_bio_start(struct bio *bio)
>>  bool blk_cgroup_congested(void)
>>  {
>>  	struct cgroup_subsys_state *css;
>> +	struct blkcg *blkcg;
> 
> It'd be better to define this within the loop.
> 
>>  	bool ret = false;
>>  
>>  	rcu_read_lock();
>>  	for (css = blkcg_css(); css; css = css->parent) {
> 
> Also, if we're now dealing with blkcg's, there's no reason to go blkcg ->
> css -> blkcg again. It'd be better to get the initial blkcg and then walk up
> using blkcg_parent().

Thanks, will do in v2.


> 
>> @@ -95,6 +95,8 @@ struct blkcg {
>>  	struct cgroup_subsys_state	css;
>>  	spinlock_t			lock;
>>  	refcount_t			online_pin;
>> +	/* If there is block congestion on this cgroup. */
>> +	atomic_t congestion_count;
> 
> Can you please match the indentation?

Sure, I copied it from the original place, will do in v2

> 
> Thanks.
> 


Return-Path: <cgroups+bounces-3445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4F91B97A
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 10:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DCD1C231C0
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6420145340;
	Fri, 28 Jun 2024 08:09:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE4436A;
	Fri, 28 Jun 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562148; cv=none; b=qf35aBNrzDL9thW6wxlEXy8VeKFujMfFFtN6rv8Lg2j5KqksR2WAlfpMn1NRwcyxYLuPRx6c4vsAjPtHaUUpGciBfGL8KY7uOVkRW2c+LQD5s/lHhKu5R54JaCXchVJ0BKlgiinRC1cKcaFgTqfIjFbjTJwXVciRvk3vUMYIzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562148; c=relaxed/simple;
	bh=hwR37mpitfXqaglW1XKiP3SvjhzhbS+E11sEx8aR4MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pSanAz3S5PnENtHvPha7r8vyxxTDpqJpggJWMjoy3Bi9f1O2/Mbmq38wiOtyOj7rIF98V7POL0f4Ox5l53l2DWNmMrfBk2HHDHa7ZpN+/ZO3ZSCvXN5CMDN5YrlfTmcGDhH96yuecgTtvmp4U/MwLk8iU0jZIwfjT++Dog7n9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4W9Sf44z9Kz1X4HC;
	Fri, 28 Jun 2024 16:05:00 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id B48451A0188;
	Fri, 28 Jun 2024 16:09:02 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 16:09:02 +0800
Message-ID: <0e44be2c-7039-710b-202f-c452bfc3f1ad@huawei.com>
Date: Fri, 28 Jun 2024 16:09:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm: memcg: adjust the warning when seq_buf
 overflows
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240628072333.2496527-1-xiujianfeng@huawei.com>
 <Zn5qELsJZ0CrdlZA@tiehlicka>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zn5qELsJZ0CrdlZA@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/28 15:45, Michal Hocko wrote:
> On Fri 28-06-24 07:23:33, Xiu Jianfeng wrote:
>> Currently it uses WARN_ON_ONCE() if seq_buf overflows when user reads
>> memory.stat, the only advantage of WARN_ON_ONCE is that the splat is
>> so verbose that it gets noticed. And also it panics the system if
>> panic_on_warn is enabled. It seems like the warning is just an over
>> reaction and a simple pr_warn should just achieve the similar effect.
>>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> I would just squash this with other patch removing it from
> memcg_stat_format. But this is up to you.

Sorry, I might have misunderstood, if you can squash them, it looks good
to me, thanks.

> 
> Thanks!
> 
>> ---
>>  mm/memcontrol.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c251bbe35f4b..8e5590ac43d7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1484,7 +1484,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>>  		memcg_stat_format(memcg, s);
>>  	else
>>  		memcg1_stat_format(memcg, s);
>> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>> +	if (seq_buf_has_overflowed(s))
>> +		pr_warn("%s: Warning, stat buffer overflow, please report\n", __func__);
>>  }
>>  
>>  /**
>> -- 
>> 2.34.1
>>
> 


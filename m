Return-Path: <cgroups+bounces-3444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91791B911
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 09:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80061F238D5
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B414375A;
	Fri, 28 Jun 2024 07:55:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0E1420C9;
	Fri, 28 Jun 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561351; cv=none; b=V47NCN0qz+m1vC4D+uCJ7uIjLSN/JYLRvfaXn7RbSoyBf4BzYpISQowXsH4S0riZsllJ4qCktDBI0qo7lBc0y1FJvNMzBnKdbqY4fD0hub1KvUvrYZA+de4EQSJy3TNvMyeEYw7DrIBymFzAstRN4LfZMzBgNr+bqOHgq0eC4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561351; c=relaxed/simple;
	bh=rouP7AZbJgtItnr42jIYAOArh3T9tBOICId49m/0Es4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDnVHMSAm6JK1b6poXifsCCCHRy9gHDOE3N/1fR8ei/DacnO8fgZyU8NpC6mP+x/hP6XMUb2YLbRy9EMEIp00w3qrDNArFkmp6TzecU01+/eW1hcuO/wzqfA15k2QtylzC+s3EqEiE7viM/LzWYJyzC0LPnQUmxZv0ABiUdTs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4W9SLk6M8Lz1X4J8;
	Fri, 28 Jun 2024 15:51:42 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id E331E14022E;
	Fri, 28 Jun 2024 15:55:44 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:55:44 +0800
Message-ID: <c13718c7-2999-9afd-2dc3-693fcf45cdd6@huawei.com>
Date: Fri, 28 Jun 2024 15:55:44 +0800
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

Thanks, the other patch has already been merged into the -next branch by
Andrew. In this situation, I'm not quite clear whether I should send a
small separate patch, or squash them and send a v2. If Andrew wants, I
can do it.

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


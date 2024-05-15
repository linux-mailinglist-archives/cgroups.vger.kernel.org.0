Return-Path: <cgroups+bounces-2906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92178C5F35
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 04:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842A1283897
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641C36126;
	Wed, 15 May 2024 02:45:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9478F5A;
	Wed, 15 May 2024 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741110; cv=none; b=oo4eGMP8PzNQhgvCMCLC+YKb+dkadCPwXe/BNHrijL56meZl8cj/o8chtEBUDiFhdA2iX12yZwkU7DwLkx5IilJzL5GF5Ct8LfwjNW/hqn6wKuMT5RgYtTkPIagGPdlhLR3tv4xvfwdONxe0dImo/F9a96sLFNngQEdnoBpovB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741110; c=relaxed/simple;
	bh=y5b1xG04vn1CcIUIecHfF8Tcjak6yElJQa34HoZDmyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UqO5xqUdcm8BXx7xRsuTrVp6aK1vB3WF3xc3ACLlQwy/+oa4rD2gwLWMDPsFFfS3Z99yl5sEWtXgMXFQs6a3MO1U1twtUnqsFL9i67Su7CdzA7GqhEEe5VjaLKIKdHfO0ApYHWmYVOJjE1dMfSG3aXLsAuzU6nTaMSQ+SDa5/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VfHYD3chGzvYjJ;
	Wed, 15 May 2024 10:41:36 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A074180085;
	Wed, 15 May 2024 10:45:05 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 10:45:04 +0800
Message-ID: <29aae825-6a1c-1935-a50f-d824c308c4c9@huawei.com>
Date: Wed, 15 May 2024 10:45:04 +0800
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
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240514131106.1326323-1-xiujianfeng@huawei.com>
 <ZkNwthw5vJrnQSLL@tiehlicka>
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZkNwthw5vJrnQSLL@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/5/14 22:09, Michal Hocko wrote:
> On Tue 14-05-24 13:11:06, Xiu Jianfeng wrote:
>> The event_list for memcg is only valid for v1 and not used for v2,
>> so it's unnessesary to handle event_list for v2.
> 
> You are right but the code as is works just fine. The list will be
> empty. It is true that we do not need to take event_list_lock lock but
> nobody should be using this lock anyway. Also the offline callback is
> not particularly hot path. So why do we want to change the code?
> 

Actually, I don’t quite agree, but I don't insist on this patch.
Thanks for your feedback.


>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  mm/memcontrol.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d127c9c5fabf..4254f9cd05f4 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5881,12 +5881,14 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>  	 * Notify userspace about cgroup removing only after rmdir of cgroup
>>  	 * directory to avoid race between userspace and kernelspace.
>>  	 */
>> -	spin_lock_irq(&memcg->event_list_lock);
>> -	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
>> -		list_del_init(&event->list);
>> -		schedule_work(&event->remove);
>> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>> +		spin_lock_irq(&memcg->event_list_lock);
>> +		list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
>> +			list_del_init(&event->list);
>> +			schedule_work(&event->remove);
>> +		}
>> +		spin_unlock_irq(&memcg->event_list_lock);
>>  	}
>> -	spin_unlock_irq(&memcg->event_list_lock);
>>  
>>  	page_counter_set_min(&memcg->memory, 0);
>>  	page_counter_set_low(&memcg->memory, 0);
>> -- 
>> 2.34.1
> 


Return-Path: <cgroups+bounces-6177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12FA130B0
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 02:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74711163B5E
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316227462;
	Thu, 16 Jan 2025 01:21:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945E28E37;
	Thu, 16 Jan 2025 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990514; cv=none; b=bRNLisUcYGSk1zC6avYuExMPMCWgdHGEBAFYRmxyXQz4K0Sms96rAJ/01xp+fYpvDL/IICxmWn3EPelVacXp9BrXMwA0FVJJETZcBve4K2Z9c1wMiIT1kOaeFvtHJ5rHsoWnYH/NEMAWgFUe6aKKGEQskZ1gXh8Hm5s++1bY7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990514; c=relaxed/simple;
	bh=d7EEn4nKleEKHHxP3Vapn99mKqGWWVzE/sttOKMBTYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKlynn9rEOB1BibuYuscgP9LIY8L6tSDzogKDbmAc8rW2FypqSOr6QuQoJL2yZMyWluldXhsanN39a3+7No4az7xMIFg7ESCUo/2sR+zWR45y7Zi1MH0BdEh9ulfz+zIE+vDe2Z9ZwbaQ/d46GKIeos3PEBpAhkaPrTEYvtvOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YYQ764v1rz4f3kFh;
	Thu, 16 Jan 2025 09:21:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1B8F11A0F2D;
	Thu, 16 Jan 2025 09:21:43 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDX4WQlX4hn8ntLBA--.58672S2;
	Thu, 16 Jan 2025 09:21:42 +0800 (CST)
Message-ID: <a4dd27e4-dca4-45e7-8c37-c53e88cf878c@huaweicloud.com>
Date: Thu, 16 Jan 2025 09:21:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 next 4/4] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, muchun.song@linux.dev, davidf@vimeo.com,
 vbabka@suse.cz, mkoutny@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-5-chenridong@huaweicloud.com>
 <Z4awwH3cbhjl0H4W@google.com>
 <csuymdtyrj2tch2m4lhn5hz5aeojhzvixepxydvphvawqsn5ky@dx4o25o4wzlw>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <csuymdtyrj2tch2m4lhn5hz5aeojhzvixepxydvphvawqsn5ky@dx4o25o4wzlw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDX4WQlX4hn8ntLBA--.58672S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4fXrWDGr45GF1fXF1rCrg_yoW8uw43pF
	ZrJayakayUXrySgr9IqF4DZryYyF1xtr4UXrZrtrySqFnFva43K345KFy8uFWUZrWkZF12
	va4jyrnrXw4jvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/16 8:57, Shakeel Butt wrote:
> On Tue, Jan 14, 2025 at 06:45:20PM +0000, Roman Gushchin wrote:
>> On Tue, Jan 14, 2025 at 12:25:19PM +0000, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The only difference between 'lruvec_page_state' and
>>> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
>>> respectively. Factor out an inner functions to make the code more concise.
>>> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>  mm/memcontrol.c | 72 +++++++++++++++++++++----------------------------
>>>  1 file changed, 30 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index b10e0a8f3375..14541610cad0 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -375,7 +375,8 @@ struct lruvec_stats {
>>>  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
>>>  };
>>>  
>>> -unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>>> +static unsigned long __lruvec_page_state(struct lruvec *lruvec,
>>> +		enum node_stat_item idx, bool local)
>>>  {
>>>  	struct mem_cgroup_per_node *pn;
>>>  	long x;
>>> @@ -389,7 +390,8 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>>>  		return 0;
>>>  
>>>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>>> -	x = READ_ONCE(pn->lruvec_stats->state[i]);
>>> +	x = local ? READ_ONCE(pn->lruvec_stats->state_local[i]) :
>>> +		    READ_ONCE(pn->lruvec_stats->state[i]);
>>>  #ifdef CONFIG_SMP
>>>  	if (x < 0)
>>>  		x = 0;
>>> @@ -397,27 +399,16 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>>>  	return x;
>>>  }
>>>  
>>> +
>>> +unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>>> +{
>>> +	return __lruvec_page_state(lruvec, idx, false);
>>> +}
>>
>> I'd move these wrapper function definitions to memcontrol.h and make them
>> static inline.
> 
> +1
> 

Thank you.

Will update.

Best regards,
Ridong
>>
>> Other than that, lgtm.
>>
>> Thank you!



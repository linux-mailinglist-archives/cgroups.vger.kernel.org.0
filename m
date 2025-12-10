Return-Path: <cgroups+bounces-12320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF1CB26D4
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF5AA31290FD
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC626CE1A;
	Wed, 10 Dec 2025 08:31:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF3263F5E;
	Wed, 10 Dec 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355505; cv=none; b=sqKKmWCKykYvbxUyF9a9qhYR1a3CC+CpBjU8pb+36QUMl8c3BNJmLhEzW3WBiVtrHU6iQYLO3aXlU2yeM2FO3iUAxCCpngrngeBzO4KfF4xim2/yWk0/6iW3YhNjHmDo08BDikoB2XuCYcsQXhQyr4EdMVvooGlApAeCH/qwK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355505; c=relaxed/simple;
	bh=pXubeHDS0HgpDE4p08D2CpOfGPDE/TL8I/ULIwFzFdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjZzlZ3jsTyt+peQ2euU1SL6D6/mzl1K3W67KyDtzr9tT6QyU+wGI1pzGTx+LZ+dNLd41MJEhzBh8yINCAltUhFgiKxGIf8XNWzS3V1pBr84tsYNqm9x0z9H8clnFegBjOh1/6qGfcoYKn1L5MaBCJraUC/IquJpWHGRpAT3tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dR8733z5xzKHMhw;
	Wed, 10 Dec 2025 16:30:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5110A1A06DD;
	Wed, 10 Dec 2025 16:31:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDXt1HpLzlpSPr2BA--.8485S2;
	Wed, 10 Dec 2025 16:31:39 +0800 (CST)
Message-ID: <9a9abc04-8915-40ac-ad40-2ae67d429ddb@huaweicloud.com>
Date: Wed, 10 Dec 2025 16:31:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
 <aTkp1tIIiw8Nti10@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aTkp1tIIiw8Nti10@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXt1HpLzlpSPr2BA--.8485S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW8Wr18Kw13Wry8Krg_yoW8AFWfpF
	W0ka45tr45try3Cw1avas5Z34Fv3y0qa45GryxKr1IqwnxJr1rtF92k3WvgryUGF9xZF1S
	vayYgFs3ArWjk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/10 16:05, Michal Hocko wrote:
> On Wed 10-12-25 07:11:42, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The mem_cgroup_size helper is used only in apply_proportional_protection
>> to read the current memory usage. Its semantics are unclear and
>> inconsistent with other sites, which directly call page_counter_read for
>> the same purpose.
>>
>> Remove this helper and replace its usage with page_counter_read for
>> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
>> to better reflect its meaning.
>>
>> This change is safe because page_counter_read() is only called when memcg
>> is enabled in the apply_proportional_protection.
>>
>> No functional changes intended.
> 
> I would prefer to keep the code as is. 
> 
> Btw.
> [...]
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 670fe9fae5ba..fe48d0376e7c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
>>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		struct scan_control *sc, unsigned long scan)
>>  {
>> +#ifdef CONFIG_MEMCG
>>  	unsigned long min, low;
>>  
>>  	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
> [...]
>> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>>  		 */
>>  		scan = max(scan, SWAP_CLUSTER_MAX);
>>  	}
>> +#endif
>>  	return scan;
>>  }
> 
> This returns a random garbage for !CONFIG_MEMCG, doesn't it?
> 

This returns what was passed as input. This means the scan behavior remains unchanged when memcg is
disabled. When memcg is enabled, the scan amount may be proportionally scaled.

-- 
Best regards,
Ridong



Return-Path: <cgroups+bounces-5967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167819F7265
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAFF16E637
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 01:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33CB4DA04;
	Thu, 19 Dec 2024 01:54:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88A4207F;
	Thu, 19 Dec 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573298; cv=none; b=fQbiyz2YK0FpBe/YZ6PoKew3R/8ZEqeuRHUAw5iBVEJzGNS5uROjLyI63wDPkyEgSkDwAMP0RSCXJ9gMfvCU3jGvdnVBoAYXdQt25vzFVL94GAp9gc6zdnT/NZ5UgDQwneyNEb2d5cos27BTLc2asaAknyIXYajpLJzsDhzNzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573298; c=relaxed/simple;
	bh=wtu2vnxn9r/J/OcgjmetgtV5zs3hVNSiC8XkruQ6fN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSLYqxmll9VEnZEAP+zwAYRLlJpw1RCQ6rVpE7KoLRCJChTmsgwg+fqSlwy1dPhIkBfXXx/bf5G/gMt4e+zme7H9mcft5QFzNwCXRLVQMGfNenfdfuqwpyPq5V48Z2gE13zf9dePjTq2tRB6/JJSJyx2aMKHVkNAbvV+IGnD8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDDBJ2n1Qz4f3jXc;
	Thu, 19 Dec 2024 09:54:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E38FB1A0359;
	Thu, 19 Dec 2024 09:54:51 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXcobqfGNndZsDFA--.17867S2;
	Thu, 19 Dec 2024 09:54:51 +0800 (CST)
Message-ID: <2a28dc42-bd9c-4799-9fe8-0298f5341093@huaweicloud.com>
Date: Thu, 19 Dec 2024 09:54:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next -v1 4/5] memcg: factor out the __refill_obj_stock function
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-5-chenridong@huaweicloud.com>
 <q7k5vqzeit4ib6joowtib6mlpwu2zdnrzse5kx44wx7jhmb6ta@w6deef6omz3d>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <q7k5vqzeit4ib6joowtib6mlpwu2zdnrzse5kx44wx7jhmb6ta@w6deef6omz3d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXcobqfGNndZsDFA--.17867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45JrWfGFWUZF1DAw43ZFb_yoW5ur1rpr
	ZrWa4UKw48ZrW2grsI9F47Zr1rZr4vqFnFkr4Iq34xCFna9Fn0qryjka4jya48Jr93tF4x
	Jr4qvFn2kF4UGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2024/12/18 2:19, Shakeel Butt wrote:
> On Fri, Dec 06, 2024 at 01:35:11AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Factor out the '__refill_obj_stock' function to make the code more
>> cohesive.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/memcontrol.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index f977e0be1c04..0c9331d7b606 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2697,6 +2697,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>>  	obj_cgroup_put(objcg);
>>  }
>>  
>> +/* If the cached_objcg was refilled, return true; otherwise, return false */
>> +static bool __refill_obj_stock(struct memcg_stock_pcp *stock,
>> +		struct obj_cgroup *objcg, struct obj_cgroup **old_objcg)
>> +{
>> +	if (READ_ONCE(stock->cached_objcg) != objcg) {
> 
> Keep the above check in the calling functions and make this a void
> function. Also I think we need a better name.
> 

Thank you for your review。

How about keeping the check in the calling functions and renaming like that:
/* Replace the stock objcg with objcg, return the old objcg */
static obj_cgroup *replace_stock_objcg (struct memcg_stock_pcp *stock,
struct obj_cgroup *objcg)

Best regards,
Ridong

>> +		*old_objcg = drain_obj_stock(stock);
>> +		obj_cgroup_get(objcg);
>> +		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>> +				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>> +		WRITE_ONCE(stock->cached_objcg, objcg);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>  static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>  		     enum node_stat_item idx, int nr)
>>  {
>> @@ -2713,12 +2728,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>  	 * accumulating over a page of vmstat data or when pgdat or idx
>>  	 * changes.
>>  	 */
>> -	if (READ_ONCE(stock->cached_objcg) != objcg) {
>> -		old = drain_obj_stock(stock);
>> -		obj_cgroup_get(objcg);
>> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>> -				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>> -		WRITE_ONCE(stock->cached_objcg, objcg);
>> +	if (__refill_obj_stock(stock, objcg, &old)) {
>>  		stock->cached_pgdat = pgdat;
>>  	} else if (stock->cached_pgdat != pgdat) {
>>  		/* Flush the existing cached vmstat data */
>> @@ -2871,14 +2881,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>>  	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>>  
>>  	stock = this_cpu_ptr(&memcg_stock);
>> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>> -		old = drain_obj_stock(stock);
>> -		obj_cgroup_get(objcg);
>> -		WRITE_ONCE(stock->cached_objcg, objcg);
>> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>> -				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>> +	if (__refill_obj_stock(stock, objcg, &old))
>>  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
>> -	}
>> +
>>  	stock->nr_bytes += nr_bytes;
>>  
>>  	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
>> -- 
>> 2.34.1
>>



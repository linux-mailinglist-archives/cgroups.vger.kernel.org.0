Return-Path: <cgroups+bounces-12740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EBDCDE3C5
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09FFA3000B02
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333562E8DEB;
	Fri, 26 Dec 2025 02:29:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361B495E5;
	Fri, 26 Dec 2025 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766716161; cv=none; b=DFZJdInTS+cSeYW3JS4BqPT+rHwsBhXTeBdv9etyyNjeYHGA85G5dqGHiWyJ1mbUn/BfxpGxUds/QSRXcvzuOUdM9WAM3BXm4ihEcLIlusz+crxo6tPSg+SUaYP5JtdFwMdoiIsdGWg93T+CC8oU+UbrjSnAjPOoP8MefemeyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766716161; c=relaxed/simple;
	bh=LMjkjmJTsH5mpGk7h/BIXSrp4C/jnJiUfeP+9EG2/Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNJ8675mjeNJNHUzyS8UXloLMfhptZwui7/6YUytPVnPBGAJhdIBbe760Wgw3+ULlsAfL3zYM07SQny96pjuSbpBhx8mQyx2UK5OcFL95DM7pNXaSgXkNkAx+RMSPr1duYUpHvJJcv6HGyYWK9fBwvRfpLmIoVuXwqDnxnOINWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcqKt4xV6zYQtfq;
	Fri, 26 Dec 2025 10:28:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F30554056C;
	Fri, 26 Dec 2025 10:29:15 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAXefn68k1pwXQEBg--.55072S2;
	Fri, 26 Dec 2025 10:29:15 +0800 (CST)
Message-ID: <76e134d7-19ae-43dd-abb8-6ce8ba24670c@huaweicloud.com>
Date: Fri, 26 Dec 2025 10:29:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/28] mm: memcontrol: prevent memory cgroup release in
 mem_cgroup_swap_full()
To: Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>
 <hvta76slujbvyb4av4cgipcevd7jctjrq2tmyw2pwpynfpjytg@ihr3aqp2brzq>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <hvta76slujbvyb4av4cgipcevd7jctjrq2tmyw2pwpynfpjytg@ihr3aqp2brzq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXefn68k1pwXQEBg--.55072S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fKr1UWr1DAr1fKryUZFb_yoW5Xr1rpF
	Z5Kas8AF48Aw4xur1aq3Wj9ryFy3yIqws8tFWxKw1fA3W3Xwn8CrW7Kw1UXa45AF1xuFyx
	XF1jv3W7uayjya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/20 9:05, Shakeel Butt wrote:
> On Wed, Dec 17, 2025 at 03:27:39PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. To ensure safety, it will only be appropriate to
>> hold the rcu read lock or acquire a reference to the memory cgroup
>> returned by folio_memcg(), thereby preventing it from being released.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the memory cgroup in mem_cgroup_swap_full().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>  mm/memcontrol.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 131f940c03fa0..f2c891c1f49d5 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5267,17 +5267,21 @@ bool mem_cgroup_swap_full(struct folio *folio)
>>  	if (do_memsw_account())
>>  		return false;
>>  
>> -	memcg = folio_memcg(folio);
>> -	if (!memcg)
>> +	if (!folio_memcg_charged(folio))
>>  		return false;
>>  
>> +	rcu_read_lock();
>> +	memcg = folio_memcg(folio);
>>  	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>>  		unsigned long usage = page_counter_read(&memcg->swap);
>>  
>>  		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
>> -		    usage * 2 >= READ_ONCE(memcg->swap.max))
>> +		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
>> +			rcu_read_unlock();
>>  			return true;
>> +		}
>>  	}
>> +	rcu_read_unlock();
>>  
>>  	return false;
>>  }
> 
> How about the following?
> 
> 
>  bool mem_cgroup_swap_full(struct folio *folio)
>  {
>  	struct mem_cgroup *memcg;
> +	bool ret = false;
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
>  	if (vm_swap_full())
>  		return true;
> -	if (do_memsw_account())
> -		return false;
>  
> -	if (!folio_memcg_charged(folio))
> -		return false;
> +	if (do_memsw_account() || !folio_memcg_charged(folio))
> +		return ret;
>  
>  	rcu_read_lock();
>  	memcg = folio_memcg(folio);
> @@ -5277,13 +5276,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
>  
>  		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
>  		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
> -			rcu_read_unlock();
> -			return true;
> +			ret = true;
> +			break;
>  		}
>  	}
>  	rcu_read_unlock();
>  
> -	return false;
> +	return ret;
>  }
>  
> 
> Anyways LGTM.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

More compact.

LGTM.

-- 
Best regards,
Ridong



Return-Path: <cgroups+bounces-12285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A9CABDC4
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 03:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A983008E8D
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C0285C9D;
	Mon,  8 Dec 2025 02:36:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6B26F443;
	Mon,  8 Dec 2025 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161362; cv=none; b=KRnybhh5eMWJtxBifc0LysAqaBz1q7/nGmFtHLryzz3js805+x4p0LRc8g59/o1dBb0YCqIBYodY4y0sedizJUwkis5DKml/zlwM8JDfHokGPBEl9TPe/TREASCG151z1/SRajqwJtT6/DQ/npMpPdVJtDChVSYtWCzTR7oMg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161362; c=relaxed/simple;
	bh=4RBBJ2MTS3R42s0VMAGDcjsLJzSl3G6p+77JhRs4+5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVzPKPi6cIXdkXmc8Ywg7EVrvN3iRJm2NOc2H+oIiGs4gKBlbNlW46reFnIo3o0BhRkjZK6+oGNINpooY6Rw9LrWztjtTdTnzUqgGjZZIsBT2PcPhiVrmKq7GCageJnENAomvNyXPo2EXXrvv7qQfO79DDZh8/A0lpiv0ePZamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dPmLM1q45zYQtL4;
	Mon,  8 Dec 2025 10:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 495E01A0EB2;
	Mon,  8 Dec 2025 10:35:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB3sX2EOTZpaUznAw--.9363S2;
	Mon, 08 Dec 2025 10:35:49 +0800 (CST)
Message-ID: <14b2584b-3ac7-4358-9d81-40ca32683e4f@huaweicloud.com>
Date: Mon, 8 Dec 2025 10:35:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 1/2] mm/mglru: use mem_cgroup_iter for global
 reclaim
To: zhongjinji <zhongjinji@honor.com>, hannes@cmpxchg.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, cgroups@vger.kernel.org, chenridong@huawei.com,
 corbet@lwn.net, david@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, lujialin4@huawei.com, mhocko@suse.com,
 muchun.song@linux.dev, roman.gushchin@linux.dev, rppt@kernel.org,
 shakeel.butt@linux.dev, surenb@google.com, vbabka@suse.cz,
 weixugc@google.com, yuanchu@google.com, yuzhao@google.com,
 zhengqi.arch@bytedance.com
References: <20251204183437.GB481418@cmpxchg.org>
 <20251205025727.8324-1-zhongjinji@honor.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251205025727.8324-1-zhongjinji@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3sX2EOTZpaUznAw--.9363S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFW5CF45XF1DGF48JFb_yoW5Jr13pF
	ZxAa1jk3yfXryxAFs2kwnruw1fZ348Cw43WrnYqw1xAa9xAFnYvr47Kr15WFWkAr4vg3W2
	qrZ0vwnYvFWDJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/5 10:57, zhongjinji wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The memcg LRU was originally introduced for global reclaim to enhance
>> scalability. However, its implementation complexity has led to performance
>> regressions when dealing with a large number of memory cgroups [1].
>>
>> As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
>> cookie-based iteration for global reclaim, aligning with the approach
>> already used in shrink_node_memcgs. This simplification removes the
>> dedicated memcg LRU tracking while maintaining the core functionality.
>>
>> It performed a stress test based on Zhao Yu's methodology [2] on a
>> 1 TB, 4-node NUMA system. The results are summarized below:
>>
>> 					memcg LRU    memcg iter
>> stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
>> sum(pgsteal) / sum(requested)             216.4%        230.5%
> 
> Are there more data available? For example, the load of kswapd or the refault values.
> 
> I am concerned about these two data points because Yu Zhao's implementation controls
> the fairness of aging through memcg gen (get_memcg_gen). This helps reduce excessive
> aging for certain cgroups, which is beneficial for kswapd's power consumption.
> 
> At the same time, pages that age earlier can be considered colder pages (in the entire system),
> so reclaiming them should also help with the refault values.
> 

I re-ran the test and observed a 3.2% increase in refaults. Is this enough for what you were
concerned about?

The complete data set is offered in my earlier email:

https://lore.kernel.org/all/e657d5ac-6f92-4dbb-bf32-76084988d024@huaweicloud.com/

>> The new implementation demonstrates a significant improvement in
>> fairness, reducing the standard deviation relative to the mean by
>> 15.5 percentage points. While the reclaim accuracy shows a slight
>> increase in overscan (from 85086871 to 90633890, 6.5%).
>>
>> The primary benefits of this change are:
>> 1. Simplified codebase by removing custom memcg LRU infrastructure
>> 2. Improved fairness in memory reclaim across multiple cgroups
>> 3. Better performance when creating many memory cgroups
>>
>> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
>> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong



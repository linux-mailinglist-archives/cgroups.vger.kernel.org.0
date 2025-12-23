Return-Path: <cgroups+bounces-12596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2597CD78F0
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 01:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7270B302B101
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43F4502A;
	Tue, 23 Dec 2025 00:45:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D94A3E;
	Tue, 23 Dec 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450745; cv=none; b=iyd/eftrI5J4LZ6X/NwbQTZa2uUR75np54AgExWXljqpB+6E4LDAOup8IDWLpBsUlwVY3lT0gH3bJV74zxIY7SV3BNLmwhltZYlhgpPtz2u3uSKi29jVjKi0I8EU6sA+0oA7WlTvwQ3Hd/lmkeciiHIfmvEUR+h/028r8gxNsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450745; c=relaxed/simple;
	bh=9qoJptYo6efb2w6roc6+xkk0qgg6GEed8MiPnNXaHZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPBHmXuILkn8bGy+3rUwsulslOMnhmLbYLREPCK58TPQRYhfyEuo0eZdnGrKloaa8TOPNBdonKVCUAW3sLg/oGol8eXg7M3/V6e+otXY7HE/UdkbHC19Ef9T1OAz7veRCiH51dYGcuqhKhR+62oIZmfsHa79qEgRqPuPIPm8nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZx9q5dsDzYQtfr;
	Tue, 23 Dec 2025 08:45:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E26F74058C;
	Tue, 23 Dec 2025 08:45:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB31_cy5klp8wiXBA--.20992S2;
	Tue, 23 Dec 2025 08:45:39 +0800 (CST)
Message-ID: <8aff3f15-79d6-48a0-a63d-735fabf6759d@huaweicloud.com>
Date: Tue, 23 Dec 2025 08:45:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/5] mm/mglru: use mem_cgroup_iter for global
 reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-2-chenridong@huaweicloud.com>
 <gkudpvytcc3aa5yjaigwtkyyyglmvnnqngrexfuqiv2mzxj5cn@e7rezszexd7l>
 <702b6c0b-5e65-4f55-9a2f-4d07c3a84e39@huaweicloud.com>
 <c4fjngkwbjlfnbjl5merldg5k2fiu43p46osagmy3ibr62cgxh@oesgt5l35kns>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <c4fjngkwbjlfnbjl5merldg5k2fiu43p46osagmy3ibr62cgxh@oesgt5l35kns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB31_cy5klp8wiXBA--.20992S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rCw15Gw1DKw47Aw4Utwb_yoW8JFWkpr
	WDWa42ya1kA3y3GrsaqF4Fgw4Fkw4rJ3y5Xr4fJ343Aws8W3WfAF47Kw429F929w40yF10
	qFW2v395WFWjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/23 5:18, Shakeel Butt wrote:
> On Mon, Dec 22, 2025 at 03:27:26PM +0800, Chen Ridong wrote:
>>
> [...]
>>
>>>> -		if (should_abort_scan(lruvec, sc))
>>>> +		if (should_abort_scan(lruvec, sc)) {
>>>> +			if (cookie)
>>>> +				mem_cgroup_iter_break(target, memcg);
>>>>  			break;
>>>
>>> This seems buggy as we may break the loop without calling
>>> mem_cgroup_iter_break(). I think for kswapd the cookie will be NULL and
>>> if should_abort_scan() returns true, we will break the loop without
>>> calling mem_cgroup_iter_break() and will leak a reference to memcg.
>>>
>>
>> Thank you for catching that—my mistake.
>>
>> This also brings up another point: In kswapd, the traditional LRU iterates through all memcgs, but
>> stops for the generational LRU (GENLRU) when should_abort_scan is met (i.e., enough pages are
>> reclaimed or the watermark is satisfied). Shouldn't both behave consistently?
>>
>> Perhaps we should add should_abort_scan(lruvec, sc) in shrink_node_memcgs for the traditional LRU as
>> well?
> 
> We definitely should discuss about should_abort_scan() for traditional
> reclaim but to keep things simple, let's do that after this series. For
> now, follow Johannes' suggestion of lru_gen_should_abort_scan().
> 

Okey, understood.

-- 
Best regards,
Ridong



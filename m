Return-Path: <cgroups+bounces-12578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5CBCD4E38
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 08:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400B23009837
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FC316185;
	Mon, 22 Dec 2025 07:44:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6E231A55;
	Mon, 22 Dec 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389489; cv=none; b=QttFy5jBO9CDVvTcloW8mz8CT/q+eQu8jd9y1wXopdM9tt2RxDMauR61ME3hu9ntaYsXR3m/PN5Y8oEBgfZZMWXsoyYi5UokL+uhCPyELNKVm8yBbSGJ9v3RwBiXLahS4IimB+xG8u3zOUAVAb1U9zR/QF+6Q3eMuFP7XlPSVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389489; c=relaxed/simple;
	bh=aInChE2ckT8gDzRpMpzeVMwVuduo5uSoEmJS9mqJCGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4hsMRixWopIxBfAbWifTfArzJCUnNyxzohr6fJpXKap62E25a7SdGqHCWJh1DdmtWinsS82YIv6JmMl4CHapzU3f9bdSU5XBvP6iA0tylgo701KYWW7XprH8/SrVDCEWMvqYUcMsxZhO86uU2y13R6TbK12np9o8T0uMOBxaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZVXF02BtzKHMQP;
	Mon, 22 Dec 2025 15:44:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6F8184058A;
	Mon, 22 Dec 2025 15:44:45 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB34+js9khpkz4zBA--.9566S2;
	Mon, 22 Dec 2025 15:44:45 +0800 (CST)
Message-ID: <b945a2e7-6347-46b9-b06a-60ad0691201b@huaweicloud.com>
Date: Mon, 22 Dec 2025 15:44:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and
 non-lrugen
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-4-chenridong@huaweicloud.com>
 <7oyimceude4iqtc6z6e2l2l2em236qa3s6r5daf4c64mzmafp5@s5ayqhbow7s4>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <7oyimceude4iqtc6z6e2l2l2em236qa3s6r5daf4c64mzmafp5@s5ayqhbow7s4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB34+js9khpkz4zBA--.9566S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4kGF1xZF47uFWUZr4Dtwb_yoW8JFykpF
	ZxJF98ta1kAr93urn7tF4UWw4F9r13Grn3JryY93WfAFyDXr1YkrW2kr10vFWUXryFk3y7
	Gr4agw1UWws8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/22 11:49, Shakeel Butt wrote:
> On Tue, Dec 09, 2025 at 01:25:55AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Currently, flush_reclaim_state is placed differently between
>> shrink_node_memcgs and shrink_many. shrink_many (only used for gen-LRU)
>> calls it after each lruvec is shrunk, while shrink_node_memcgs calls it
>> only after all lruvecs have been shrunk.
>>
>> This patch moves flush_reclaim_state into shrink_node_memcgs and calls it
>> after each lruvec. This unifies the behavior and is reasonable because:
>>
>> 1. flush_reclaim_state adds current->reclaim_state->reclaimed to
>>    sc->nr_reclaimed.
>> 2. For non-MGLRU root reclaim, this can help stop the iteration earlier
>>    when nr_to_reclaim is reached.
>> 3. For non-root reclaim, the effect is negligible since flush_reclaim_state
>>    does nothing in that case.
> 
> Please decouple flush_reclaim_state() changes in a separate patch i.e.
> making calls to flush_reclaim_state() similar for MGLRU and non-MGLRU.
> 
> For the remaining of the patch, I will respond on the other email chain.

Thank you for the suggestion.

This change essentially moves only one line of code. I will add a separate patch to handle it
accordingly.

-- 
Best regards,
Ridong



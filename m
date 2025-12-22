Return-Path: <cgroups+bounces-12577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D76CD4E1A
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB529300E7B3
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E33101C0;
	Mon, 22 Dec 2025 07:40:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4F32573D;
	Mon, 22 Dec 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389254; cv=none; b=FJ/j+eTVjn2+dGSUYLXjdKer2HyclzaRMLwCFa4n0znEE3upQiyqgUwMXU8zJlu6AYdboMb/hfKLo2nAXt3JPdQoid0+J1UA8SVjZevZMksgUSvrepa8Fu2+RQEroRmqQLHd8g+8afIZeN5w0ZWEkE8dU6oNQb+L1SuEE/CvXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389254; c=relaxed/simple;
	bh=VoLg4/ohDa7XtABuLGlVpUnX768QrqzYcC25Qz3X0KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAuE6A93FJ9PY544Co5S1RQzh9T6xBsE7mFqct+UjM6M+ocHgm3c+43kRnJCwUzHr5Ddp+0AKXZtkVqBfdGHISKyQkc5f0EwpowJucVuL9Lr1JS++0Kmqlryat1HIxFz+52Igrw1qu86QnzP6Qsy12aGLWEde8h0BSCg3QO2SOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZVRf3NlmzKHMRT;
	Mon, 22 Dec 2025 15:40:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DE4F44056D;
	Mon, 22 Dec 2025 15:40:46 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3F_j99UhpLPhCBA--.61919S2;
	Mon, 22 Dec 2025 15:40:46 +0800 (CST)
Message-ID: <f9593c1e-feda-4c03-a1c9-7e84637819f8@huaweicloud.com>
Date: Mon, 22 Dec 2025 15:40:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/5] mm/mglru: combine shrink_many into
 shrink_node_memcgs
To: Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-5-chenridong@huaweicloud.com>
 <20251215211754.GG905277@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251215211754.GG905277@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3F_j99UhpLPhCBA--.61919S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1DArW8uw43CFy7tw17Awb_yoWDArgE9w
	1FvF1Iyw1UCw4vganrCrsYyFnxGF17CrykJw18XryxW345Zry7uF4kGF93WFn2grWFy345
	Cas8ZrySkry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxo
	7KDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/16 5:17, Johannes Weiner wrote:
> On Tue, Dec 09, 2025 at 01:25:56AM +0000, Chen Ridong wrote:
>> @@ -5822,6 +5779,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>  
>>  		shrink_one(lruvec, sc);
>>  
>> +		if (should_abort_scan(lruvec, sc)) {
> 
> Can you please rename this and add the jump label check?
> 
> 		if (lru_gen_enabled() && lru_gen_should_abort_scan())
> 
> The majority of the checks in there already happen inside
> shrink_node_memcgs() itself. Factoring those out is probably better in
> another patch, but no need to burden classic LRU in the meantime.

Adding should_abort_scan for the classic LRU seems reasonable, as it would allow the scan to stop
earlier when sufficient pages have been reclaimed or watermark is satisfied for global recalim.

Refer to the discussion here:

https://lore.kernel.org/lkml/20251209012557.1949239-1-chenridong@huaweicloud.com/T/#m4eea017f5a222ba676d9222f59ad8c898ac2aefe

-- 
Best regards,
Ridong



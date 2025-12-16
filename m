Return-Path: <cgroups+bounces-12372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 742DECC078C
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 02:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10A623021DD3
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6132266B46;
	Tue, 16 Dec 2025 01:38:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7176273816;
	Tue, 16 Dec 2025 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849097; cv=none; b=k8ZInF80q7IisTgPns38VZtGL5BynSmRVRIY5u+TxiKIqWHyavin7ulm+HXf1iK/mUFaU9R1fnXrGu2pnFjxiCrbDPnom8RZbfnBmkYt3c7PzPqCXIUartQTCMSqzj3avmMFn4KdK0/nKXxfvibf7LOeXv6Z9hUUwtW8I7+3Z1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849097; c=relaxed/simple;
	bh=naqp9nM/h3AJKFLDYdsL0rqKRLX4lZ/o/5FesZmYhQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCJJylGyg0D+jzEqK2wcgYnKmbuiQUz1INE4OrRAHuEh8VKwCQ1VNJqhH5ah8zyw/Aq8hGGHkGyBiFADV0f7NM8aEs7uQuIBWP7eCxzUwbYa+pFG+8eEbdE5AH8ogqNujKpiB6/De7uQGFeDbc0mi660SgLgTFmQyUjMsSathiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVfgt555FzYQtkG;
	Tue, 16 Dec 2025 09:37:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21FC41A0DD7;
	Tue, 16 Dec 2025 09:38:11 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnB_j_t0BpppBdAQ--.40469S2;
	Tue, 16 Dec 2025 09:38:08 +0800 (CST)
Message-ID: <fa7b6432-a35b-4768-91dd-926b45bb6980@huaweicloud.com>
Date: Tue, 16 Dec 2025 09:38:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm/memcontrol: make lru_zone_size atomic and simplify
 sanity check
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com>
 <3edf7d6a-5e32-45f1-a6fc-ca5ca786551b@huaweicloud.com>
 <CAMgjq7DVcpdBskYTRMz1U_k9qt4b0Vgrz3Qt5V7kzdj=GJ7CQg@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAMgjq7DVcpdBskYTRMz1U_k9qt4b0Vgrz3Qt5V7kzdj=GJ7CQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnB_j_t0BpppBdAQ--.40469S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rCr45tw4kGw1DGF1kuFg_yoW5Cr48pF
	WUta48tF4kArn8A3sFyw12qayYk3s7GFs8ZrnxKw4UuF909F1Sqryakr45uFWvkwn3Gryj
	vF4j9asrC3W8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/12/15 16:29, Kairui Song wrote:
> On Mon, Dec 15, 2025 at 3:38 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> On 2025/12/15 14:45, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> commit ca707239e8a7 ("mm: update_lru_size warn and reset bad lru_size")
>>> introduced a sanity check to catch memcg counter underflow, which is
>>> more like a workaround for another bug: lru_zone_size is unsigned, so
>>> underflow will wrap it around and return an enormously large number,
>>> then the memcg shrinker will loop almost forever as the calculated
>>> number of folios to shrink is huge. That commit also checks if a zero
>>> value matches the empty LRU list, so we have to hold the LRU lock, and
>>> do the counter adding differently depending on whether the nr_pages is
>>> negative.
>>>
>>> But later commit b4536f0c829c ("mm, memcg: fix the active list aging for
>>> lowmem requests when memcg is enabled") already removed the LRU
>>> emptiness check, doing the adding differently is meaningless now. And if
>>
>> Agree.
>>
>> I did submit a patch to address that, but it was not accepted.
>>
>> For reference, here is the link to the discussion:
>> https://lore.kernel.org/lkml/CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com/
>>
> 
> Thanks for letting me know, I wasn't aware that you noticed this too.
> 
>>From my side I'm noticing that, lru_zone_size has only one reader:
> shrink_lruvec -> get_scan_count -> lruvec_lru_size, while the updater
> is every folio on LRU.
> 
> The oldest commit introduced this was trying to catch an underflow,
> with extra sanity check to catch LRU emptiness mis-match. A later
> commit removed the LRU emptiness mis-match, and the only thing left
> here is the underflow check.
> 
> LRU counter leak (if there are) may happen anytime due to different
> reasons, and I think the time an updater sees an underflowed value is
> not unlikely to be the time the actual leak happens. (e.g. A folio was

This is exactly our concern. If we don’t read the LRU size, we won’t get a warning even if it has
overflowed. I’d like to hear the experts’ opinions on this.

> removed without updating the counter minutes ago while there are other
> folios still on the LRU, then an updater will trigger the WARN much
> later). So the major issue here is the underflow mitigation.
> 
> Turning it into an atomic long should help mitigate both underflow,
> and race (e.g. forgot to put the counter update inside LRU lock).
> Overflow is really unlikely to happen IMO, and if that's corruption,
> corruption could happen anywhere.
> 
> The reason I sent this patch is trying to move
> mem_cgroup_update_lru_size out of lru lock scope in another series for
> some other feature, just to gather some comments for this particular
> sanity check, it seems a valid clean up and micro optimization on its
> own.

I agree — it is confusing. If several of us have been confused by this, maybe it’s time we consider
making some changes.

-- 
Best regards,
Ridong



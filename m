Return-Path: <cgroups+bounces-5895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EDA9F1BFF
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B15188E953
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A8125DF;
	Sat, 14 Dec 2024 01:47:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD3DF78;
	Sat, 14 Dec 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140852; cv=none; b=XbA0IkT23ANS89KDwTFNBZQxQ3wzeZwQDCW+0OSHOhP8Qd6IIjzFLuxUfkUjYaecvUYsag3liXhjzfsEUKUcUU8Gz1WBHdvsVS3V8b3kWR3epk8D4P3sUImNM6uKWnR4OKNz0nu+kyh4+USvhDUrwglOI7OvlQnfciMRozFqk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140852; c=relaxed/simple;
	bh=rDCnNx2vZgLhjzkNQxr71ZiD4sIPqXRF9rDkNyi3wL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5mSKa4YmlQDTwa7YNVdhTM8OaukCeXzTzt7RTetplGfOm9e7PiH0P/GFY2ph8qypRDHPhvjKwsNpxoeRip+PGodnH6E1jQVKTla9GcmE4j1p5Cm6aauyDKXO0Lhsyr2sTSPio8oWjralDUKPbtLui8Y/ACL/nlnfW5WUkDRCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y98G64M5bz4f3jqC;
	Sat, 14 Dec 2024 09:47:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF6D91A058E;
	Sat, 14 Dec 2024 09:47:24 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCXKcar41xnluWdEQ--.62887S2;
	Sat, 14 Dec 2024 09:47:24 +0800 (CST)
Message-ID: <ac7820cd-513b-478c-9fbb-4bc5ec8f21a2@huaweicloud.com>
Date: Sat, 14 Dec 2024 09:47:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next -v1 0/5] Some cleanup for memcg
To: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20241206013512.2883617-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCXKcar41xnluWdEQ--.62887S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWxGw1kAFWkJrW8Aw15twb_yoWxKwc_CF
	92vFyxKw4jqFyava4jkr45CFyxKFWUJr1UJF1jqr4rtry7J3sY9F1qqr48Zr1xXayfCF4U
	Ary5AFs7ur17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/6 9:35, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> 
> Chen Ridong (5):
>   memcg: use OFP_PEAK_UNSET instead of -1
>   memcg: call the free function when allocation of pn fails
>   memcg: simplify the mem_cgroup_update_lru_size function
>   memcg: factor out the __refill_obj_stock function
>   memcg: factor out stat(event)/stat_local(event_local) reading
>     functions
> 
>  mm/memcontrol.c | 140 ++++++++++++++++++++++--------------------------
>  1 file changed, 63 insertions(+), 77 deletions(-)
> 

Friendly ping.

I am looking forward to having someone review these patches, with the
exception of patch 3. I will drop patch 3(NAK by YU) in the next version.

Best regards,
Ridong



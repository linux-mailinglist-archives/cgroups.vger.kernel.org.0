Return-Path: <cgroups+bounces-12371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DCCC0729
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 02:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1042B3014A1F
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C7D25A2A4;
	Tue, 16 Dec 2025 01:23:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68125228C;
	Tue, 16 Dec 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848201; cv=none; b=KZ3An1W9FwOqk6guut/2AAkWB4fMdZsT37iwUNq1wQAVOMqw/UbCJUHWDBTr30m4hEASLK2mAmjQMUU1iNlxvz565kGYK5wLp4wJv5RWf0ypXEO0qK/6QY0FphgUD4rKaHY827IE6lhli5/6gHxdm5CzjVcSCBUOc1M/qbMj4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848201; c=relaxed/simple;
	bh=LCEOeOzcMYWYgrZ75Ac+2bNBFe90ePxI+pXsk9ejed0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4LYy46zwCunHqboqqTxW8TYXnAnI2k/XZbH+1wl2RBzIOgAnI48Qb7VFX7PeIw0DlNcqjZF55X8P/Rp31KIsIxaVPA3QBhTGQyOFCL9k2c719qI+7DIJQ4aFCimkQ6jURDlmhMHoiX7kLrpxWfmRQLkbUInIu7Wf4qaUxzlGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dVfM20XCVzKHMLf;
	Tue, 16 Dec 2025 09:23:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E4F0B1A06DD;
	Tue, 16 Dec 2025 09:23:16 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPiEtEBpyU9cAQ--.32796S2;
	Tue, 16 Dec 2025 09:23:16 +0800 (CST)
Message-ID: <aa796873-2b64-4211-b1b6-71f8aaba8441@huaweicloud.com>
Date: Tue, 16 Dec 2025 09:23:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/5] mm/mglru: combine shrink_many into
 shrink_node_memcgs
To: Johannes Weiner <hannes@cmpxchg.org>
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
X-CM-TRANSID:gCh0CgAniPiEtEBpyU9cAQ--.32796S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1DArW8uw43CFy7tw17Awb_yoWfGrbE93
	Wvv3W2kw1UKw4DKa17CrsYyFZ3GF18CF1DGw1UXrs7Kas8ZFW7Zr4kGryfXrn2grW2kFsx
	uFy5XrySkry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
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

Thank you very much.

Thank you for the suggestion. lru_gen_should_abort_scan() is indeed a better name, and including the
lru_gen_enabled() check in the condition is necessary.

I'll update the patch accordingly.

-- 
Best regards,
Ridong



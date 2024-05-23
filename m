Return-Path: <cgroups+bounces-2985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141CC8CCF86
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC691283883
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976E13D28D;
	Thu, 23 May 2024 09:44:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258D13D28B
	for <cgroups@vger.kernel.org>; Thu, 23 May 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457446; cv=none; b=EqXLYEzA4UetAHekzL8QItMeHWKf3VXO5jvn+v16R1g/6cGBm5hsOgKU0BiZaL2IRAU2CiYdN5xWR2OBQZwJUAfkKynGbWCVjiGA294ANHSag2zKHjeoIC5D5wa+c4eG2fCffa54oglHgUywExP7L1RMYXX9u3cymOTxpFKqd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457446; c=relaxed/simple;
	bh=1v0z/ygDK4ynWl6Ukr+/4W4wrH1Qlj7wRFN/Lm8RY1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/E/WonEknXj3t99X6HcJpclzhIGHdvHDCkK+ZGKMCQSAfydtGHFNHJST2gxJ+6sr1Waay/V4x224R08rTtAz9qQCX4m0Q9kKXG98ZefMmeB+VkD2zeiU69Ip11fsGMVaZRba3ZwuDXXCl3ySfp+iywhIPhH3AInazCsXsJ6i/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VlNW00Vssz1HCgc;
	Thu, 23 May 2024 17:42:20 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BC971A0188;
	Thu, 23 May 2024 17:43:53 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 May 2024 17:43:52 +0800
Message-ID: <3841ccf3-100a-4841-b62c-60b185494560@huawei.com>
Date: Thu, 23 May 2024 17:43:52 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, <linux-mm@kvack.org>, <cgroups@vger.kernel.org>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
 <Zkyt7vOQykukTTXc@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zkyt7vOQykukTTXc@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/21 22:21, Matthew Wilcox wrote:
> On Tue, May 21, 2024 at 09:15:56PM +0800, Kefeng Wang wrote:
>> -/* Test requires a stable page->memcg binding, see page_memcg() */
>> +/* Test requires a stable page->memcg binding, see folio_memcg() */
> 
> folio->memcg, not page->memcg

OK, will fix.


Return-Path: <cgroups+bounces-3397-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710091A590
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D756A2882B6
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAE14C5AA;
	Thu, 27 Jun 2024 11:43:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7513F441;
	Thu, 27 Jun 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488593; cv=none; b=XvplidyPCaaj3sNQEk7AnH7r7G1vINj2EH44oBoRVBgJDcyHzkJbD0c03aDaJ/BYGctRB9ntrDEPUdR1ZivruBWc0EZlam6qhoKxUVrGEcdMMUNXoMIv4kasSHUI7LkPId+85ERFYxGVCfa2Nrjg1jhp/M8EsuZy0zBbCgpAd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488593; c=relaxed/simple;
	bh=y+6vHuWXBzhzrgsU4rqdh8QHvIyewha10Zt5zjxvnJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g6i5BRRGvAdrBvQQm6JlZ6lvf9vbxmswuq/3Mzja+BC9npoJ+84J0kSZWowYXime79mDH3hNCIrsnbg9Cs7LSKaTPk+EiO9D2pAm8jdjkZMldbN8jxloIXyTSz7U6giLE8MeX39ZjjZK6i4nMOd9nr/BN1xCJ5ESTOHqM+QWD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W8xRY6Pqpz1j5qb;
	Thu, 27 Jun 2024 19:39:05 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id A13301A016C;
	Thu, 27 Jun 2024 19:43:06 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 19:43:06 +0800
Message-ID: <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>
Date: Thu, 27 Jun 2024 19:43:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
 <Zn1LFyO_cww9W758@tiehlicka>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zn1LFyO_cww9W758@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/27 19:20, Michal Hocko wrote:
> On Thu 27-06-24 16:33:00, xiujianfeng wrote:
>>
>>
>> On 2024/6/27 15:13, Michal Hocko wrote:
>>> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
>>>> Both the end of memory_stat_format() and memcg_stat_format() will call
>>>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
>>>> is the only caller of memcg_stat_format(), when memcg is on the default
>>>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
>>>> the reduntant one.
>>>
>>> Shouldn't we rather remove both? Are they giving us anything useful
>>> actually? Would a simpl pr_warn be sufficient? Afterall all we care
>>> about is to learn that we need to grow the buffer size because our stats
>>> do not fit anymore. It is not really important whether that is an OOM or
>>> cgroupfs interface path.
>>
>> I did a test, when I removed both of them and added a lot of prints in
>> memcg_stat_format() to make the seq_buf overflow, and then cat
>> memory.stat in user mode, no OOM occurred, and there were no warning
>> logs in the kernel.
> 
> The default buffer size is PAGE_SIZE.

Hi Michal,

I'm sorry, I didn't understand what you meant by this sentence. What I
mean is that we can't remove both, otherwise, neither the kernel nor
user space would be aware of a buffer overflow. From my test, there was
no OOM or other exceptions when the overflow occurred; it just resulted
in the displayed information being truncated. Therefore, we need to keep
one.

> 


Return-Path: <cgroups+bounces-11840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2DC5028D
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 01:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A67334C299
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 00:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6E1C6FEC;
	Wed, 12 Nov 2025 00:56:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F20B14B96E;
	Wed, 12 Nov 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908997; cv=none; b=h4ynm5EpJeTnFlq3L+V4ywEjcyBw0aBTL+zPavs7Nydq8fivbFZglWzp2yXtkALkinBP0NYR99dJQUtotLIyBbduFLEmbYCWwyeXaFiywEkXVmRj82FVZPZpEGSPKGTizbdjbYJaqPeJH8wB80rEjZQm96PH0FS5yqfFg1Sljg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908997; c=relaxed/simple;
	bh=TIoMZjpibgfM0vfF/TNu1msyh8gg3Ujr1PN57cUbzxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqH2BTULJ1IxQXtchLXXAJ/N6gsureZHjQlnypynfj0SCvRtmwE1RDafDIieZqbrolpOG3LN49cZXm7v6MMPTKjX8ytX5suj4x0bKR2wQIaK1ezjy/lj3Cwtq+4/nDGQGsq0GAzMX5rO3lx4JX9+oIifUTcHDT4URIW8rsIk7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5lMQ6pWBzYQtpG;
	Wed, 12 Nov 2025 08:56:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 881491A084B;
	Wed, 12 Nov 2025 08:56:30 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBnw3k92xNp7pW8AQ--.37935S2;
	Wed, 12 Nov 2025 08:56:30 +0800 (CST)
Message-ID: <2f43bdf7-5ce0-4835-9e60-39d91f637152@huaweicloud.com>
Date: Wed, 12 Nov 2025 08:56:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
 hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mclapinski@google.com, mhocko@kernel.org, mkoutny@suse.com,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 tj@kernel.org
References: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
 <20251111064415.75290-1-leon.huangfu@shopee.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251111064415.75290-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnw3k92xNp7pW8AQ--.37935S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45Wr4UJrW8Xr1fZr4DCFg_yoW8tr1rpF
	W3Jas0vF48tF97Crs2qwn7XryUtwn7WryUWr98Crn5G3ZxKr1akF45KFWYkF9xKr4fCr1j
	vw4jga4Iva45ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/11/11 14:44, Leon Huang Fu wrote:
> On Tue, Nov 11, 2025 at 9:00 AM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>>
>>
>> On 2025/11/10 21:50, Michal Koutný wrote:
>>> Hello Leon.
> 
> Hi Ridong,
> 
>>>
>>> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shopee.com> wrote:
>>>> Memory cgroup statistics are updated asynchronously with periodic
>>>> flushing to reduce overhead. The current implementation uses a flush
>>>> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
>>>> determining when to aggregate per-CPU memory cgroup statistics. On
>>>> systems with high core counts, this threshold can become very large
>>>> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
>>>> statistics when userspace reads memory.stat files.
>>>>
>>
>> We have encountered this problem multiple times when running LTP tests. It can easily occur when
>> using a 64K page size.
>>
>> error:
>>         memcg_stat_rss 10 TFAIL: rss is 0, 266240 expected
>>
> 
> Have you encountered this problem in real world?
> 
Do you mean whether we’ve encountered this issue in our product? We haven’t so far.

However, this fails the LTP test quite easily. The error logs come directly from LTP. The issue
occurs because the threshold isn’t reached, resulting in an RSS value of 0. We tried increasing the
memory allocated by the LTP case, but that wasn’t the right solution.

>>>> This is particularly problematic for monitoring and management tools
>>>> that rely on reasonably fresh statistics, as they may observe data
>>>> that is thousands of updates out of date.
>>>>
>>>> Introduce a new write-only file, memory.stat_refresh, that allows
>>>> userspace to explicitly trigger an immediate flush of memory statistics.
>>>
> [...]
>>>
>>> Next, v1 and v2 haven't been consistent since introduction of v2 (unlike
>>> some other controllers that share code or even cftypes between v1 and
>>> v2). So I'd avoid introducing a new file to V1 API.
>>>
>>
>> We encountered this problem in v1, I think this is a common problem should be fixed.
> 
> Thanks for pointing that out.
> 
> Thanks,
> Leon
> 
> [...]

-- 
Best regards,
Ridong



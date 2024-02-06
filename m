Return-Path: <cgroups+bounces-1377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6B84ACD8
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CD81F23380
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC4745D1;
	Tue,  6 Feb 2024 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tNOLalON"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0A73180
	for <cgroups@vger.kernel.org>; Tue,  6 Feb 2024 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189988; cv=none; b=pESkBQUcSOFrfH6PlT9kbFlV5O2DqknmqS5wT+TbBfSOvd4Fe4q/upy2V0BHr+Kg5xPfI1JnyfJg/rjzfYB4SN+uglJfJpjLZoorGheuoyiGb3UIaz6D+WD9bLgWp026KbZzWM8UTZl+QTtsecChWEQ+GDgsTxfWUqjRRLbrIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189988; c=relaxed/simple;
	bh=ZkTX61I2tt36xodQQmRzMrJjNf1JsLLmeuhhpXbqOYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcUQh9ySaVF1ZY6NmE5NvK8CF0PkfooaSfJW14M9xh3muSpD5iiM4vRsubyn3H057Ir+j93ZjnXXP0l0QCuji4b9ce/mwJljuWW/EwvLhT5gxv1z16pfqbmdEXsb+sX1H4gIfoJaEAKItikMX9j468tmzT4NKbe4NhjFKA+enbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tNOLalON; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5e918d6-e0a0-4233-b2c1-58505f5e8655@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707189984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClD2Z6Jo52GcH++My4a6PnVyBVRkcPKgaDGiH7iNA/k=;
	b=tNOLalON7SIXvMIFxF/K/Mn422ezvF3obOVRSojEkr+3MyY7JBT2TZoivbxMFGfoheZSZR
	Cjk3ZAZpBimhXqD+8iYSQYcMYlV8DxvXn2ro4ZHCi5H/JKQ9WJ+o7Rkm9/Fio8gfwcKH7V
	yhPF3WxlasNzIK//syGGSWpPSfbWb1E=
Date: Tue, 6 Feb 2024 11:25:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Content-Language: en-US
To: Waiman Long <longman@redhat.com>,
 "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Zefan Li <lizefan.x@bytedance.com>, Kees Cook <keescook@chromium.org>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
 <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
 <698633db-b066-4f75-b201-7b785819277b@linux.dev>
 <PH0PR11MB519280092AA66FAE6BB3FACEEC402@PH0PR11MB5192.namprd11.prod.outlook.com>
 <fb8161d9-16c0-da8c-09ee-905e39ae199b@linux.com>
 <PH0PR11MB5192FC6A7AA3CB84BA3BC7E6EC462@PH0PR11MB5192.namprd11.prod.outlook.com>
 <da2417c0-49f1-4674-95f9-297d6cd9e0fa@redhat.com>
 <2efa10b2-6732-4aa5-98ae-34053a5838ee@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <2efa10b2-6732-4aa5-98ae-34053a5838ee@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/6 11:20, Waiman Long wrote:
> 
> On 2/5/24 22:16, Waiman Long wrote:
>>
>> On 2/5/24 20:46, Song, Xiongwei wrote:
>>> Adding the maintainers of cpuset of cgroup.
>>>
>>>> On Sun, 4 Feb 2024, Song, Xiongwei wrote:
>>>>
>>>>> Once SLAB_MEM_SPREAD is removed, IMO, cpuset.memory_spread_slab is useless.
>>>> SLAB_MEM_SPREAD does not do anything anymore. SLUB relies on the
>>>> "spreading" via the page allocator memory policies instead of doing its
>>>> own like SLAB used to do.
>>>>
>>>> What does FILE_SPREAD_SLAB do? Dont see anything there either.
>>> The FILE_SPREAD_SLAB flag is used by cpuset.memory_spread_slab with read/write operations:
>>>
>>> In kernel/cgroup/cpuset.c,
>>> static struct cftype legacy_files[] = {
>>> ... snip ...
>>>          {
>>>                  .name = "memory_spread_slab",
>>>                  .read_u64 = cpuset_read_u64,
>>>                  .write_u64 = cpuset_write_u64,
>>>                  .private = FILE_SPREAD_SLAB,
>>>          },
>>> ... snip ...
>>> };
>>
>> It looks like that memory_spread_slab may have effect only on the slab allocator. With the removal of the slab allocator, memory_spread_slab is now a no-op. However, the memory_spread_slab cgroupfs file is an externally visible API. So we can't just remove it as it may break existing applications. We can certainly deprecate it and advise users not to use it.
> 
> BTW, cpuset doesn't use SLAB_MEM_SPREAD directly. Instead it set the task's PFA_SPREAD_SLAB and let other subsystems test it to act appropriately. Other than cpuset, the latest upstream kernel doesn't check or use this flag at all.
> 

Ok, get it. So cpuset_do_slab_mem_spread() can be removed, but
this cpuset file interface and PFA_SPREAD_SLAB will be keeped.

Thanks.


Return-Path: <cgroups+bounces-12244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD13C99F06
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 04:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5F14E2691
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 03:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AB2244685;
	Tue,  2 Dec 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eBxIFDjk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FD2AEE1;
	Tue,  2 Dec 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644704; cv=none; b=K6yy+P09D3M6AgGt2keNwPV24YhR59k3zJHeNjLrpPpKSdZBm0OSuP2+OYc3U6v35C0bLNMaJkbFcvtxnGEoIqqZsWRFOXWYYPcYLSMmf8vQUFsai46BB6Ox8yK2T2RPBK7jm1hZHYWE3lLgM8SqJM4nx9ZTMN00lvrVFqeJ374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644704; c=relaxed/simple;
	bh=/wad86lebxN88ArXRVT9vxEPrc4CJhtj2Bwv8PYKg04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUxvtj7vZHIyNpMOAP0foBhvV+a3peA8mw9LW5ugM+oLovDsvsmfqJzK53GM37qK78Di3ssVKnQD80CJwvVMJGWUvkZ86LnhFdc7p4t+yopu/PRWMWqADDVHiA6Usv7gpK1gThI35naLRfImSwVaO8p3n3TZYUPz7NUr9Zkrk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eBxIFDjk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3595bfda-d7a6-44a1-bc0a-414c890e00c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764644699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TMOXL6yAIfCfUfBfRhzLBPkFL4/fzP/8gLyV27jj8k=;
	b=eBxIFDjkFXnkO1qpCt2R9+AuPQyxVxruuEBuSgndZvMd8I/255bYj4MMMs5hsQzlI9niuu
	mhtlxmUI1YFtjV5YyvPH1LbOGMCgiABiVppQ3n7+GVnQ8r2DZdLZFe4HGHk8JcqGv1XQ8E
	b+UxsouADo3ix9LQtltlTUT9cmtjmFE=
Date: Tue, 2 Dec 2025 11:04:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
To: Yuanchu Xie <yuanchu@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, weixugc@google.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <cdcedd284f5706c557bb6f53858b8c2ac2815ecb.1761658311.git.zhengqi.arch@bytedance.com>
 <aScFNZjGficdjnvD@hyeyoo> <d94fe146-5cc6-4aa2-bd7f-8ca2a12e5457@linux.dev>
 <CAJj2-QHu3u1RQpkBw8uV9P+-xop+bJvxt+s-ZB_cj=u6ia+tbg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAJj2-QHu3u1RQpkBw8uV9P+-xop+bJvxt+s-ZB_cj=u6ia+tbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/2/25 5:50 AM, Yuanchu Xie wrote:
> On Mon, Dec 1, 2025 at 9:41 AM Qi Zheng <qi.zheng@linux.dev> wrote:
>>> Warning 1) Here we increment max_seq but we skip updating mm_state->seq.
>>> (try_to_inc_max_seq() iterates the mm list and update mm_state->seq after
>>> an iteration, but since we directly call inc_max_seq(), we don't update it)
>>>
>>> When mm_state->seq is more than one generation behind walk->seq, a warning is
>>> triggered in iterate_mm_list():
>>>
>>>           VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->max_seq);
>>
>> The mm_state->seq is just to record the completion of a full traversal
>> of mm_list. If we simply delete this warning, it may cause this judgment
>> in iterate_mm_list to become invalid:
>>
>>           if (walk->seq <= mm_state->seq)
>>                  goto done;
>>
>> So it seems we can manually increase mm_state->seq during reparenting to
>> avoid this warning.
> Agreed, don't get rid of the warning as this check is supposed to make
> stale walkers exit early.

OK, will incease mm_state->seq during reparenting in the next version.

> 
>>
>> However, we cannot directly call iterate_mm_list_nowalk() because we do
>> not want to reset mm_state->head and mm_state->tail to NULL. Otherwise,
>> we wouldn't be able to continue iterating over the mm_list.
>>
> 
>  From the original posting:
>> Of course, the same generation has different meanings in the parent and
>> child memcg, this will cause confusion in the hot and cold information of
>> folios. But other than that, this method is simple enough, the lru size
>> is correct, and there is no need to consider some concurrency issues (such
>> as lru_gen_del_folio()).
> One way to solve this is to map generations based on
> lrugen->timestamp, but of course this runs into the reading
> folio->flags issue you described. I think the current method is a good
> compromise, but the splicing of generations doesn't much make semantic
> sense. It would be good to leave a comment somewhere in
> __lru_gen_reparent_memcg to note this weirdness.

OK, will do.

Thanks!




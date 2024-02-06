Return-Path: <cgroups+bounces-1375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DF84ACC7
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 04:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A2E1F24546
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 03:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356C745F8;
	Tue,  6 Feb 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC2VTftJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32A745EC
	for <cgroups@vger.kernel.org>; Tue,  6 Feb 2024 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189410; cv=none; b=qo6aqizwq2Qf8K+LV23BtzPvfImJFVN9n8gne504caoffSZToVeAgGzQisuNnbbaCycAt+zaB5puzwyq8tlgBW7wHppnXB67w7ygyW/Cbid87bPswFHPQueRNPqdR/qUtZhSCn6WE1Eesc5TnnZJPDeeqOSRfONJHqbS3k8T1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189410; c=relaxed/simple;
	bh=XlT/oFXhFBECcFABqd/c6XAVL8ZjWF+z5VrLDcUku2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2uJJv2rX7/EQwsltig0n8zCcredZ7B0CMDdhhaBp3k+ks2pSo+6AgEItDqNmkxJ1VJYF66HUPAZlW+grGO2P6VdeQ1NpvQXaT58AXpXcliPAisNaJBp0a4Ct3VuV6zcHpJGroTC+BYvd2y+lFCigN9Doj9mP/KBq254EJYIbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TC2VTftJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707189407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNKnKIcGVgRey+WDdSS1pYfQz/TNzPFoLWEek88f+c0=;
	b=TC2VTftJ+XtcSQVa5QXdFACQeSzEt6FZdtywogSwDMN29zXh8T90hACw25UYDrMozt+N6U
	vwSXkQLB6nazfmTqEKsz2jixjEI28XZcLPdR05QLPdNuWhXtJp1/hr1GA6jYC6NazYIHBO
	/E03ei/k/unSt/wtEnFzATdS+uvn+Jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-K45c_6kFP7iWy58RcRhdfQ-1; Mon, 05 Feb 2024 22:16:42 -0500
X-MC-Unique: K45c_6kFP7iWy58RcRhdfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97904800074;
	Tue,  6 Feb 2024 03:16:41 +0000 (UTC)
Received: from [10.22.17.212] (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8716B492BF0;
	Tue,  6 Feb 2024 03:16:40 +0000 (UTC)
Message-ID: <da2417c0-49f1-4674-95f9-297d6cd9e0fa@redhat.com>
Date: Mon, 5 Feb 2024 22:16:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Content-Language: en-US
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <PH0PR11MB5192FC6A7AA3CB84BA3BC7E6EC462@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 2/5/24 20:46, Song, Xiongwei wrote:
> Adding the maintainers of cpuset of cgroup.
>
>> On Sun, 4 Feb 2024, Song, Xiongwei wrote:
>>
>>> Once SLAB_MEM_SPREAD is removed, IMO, cpuset.memory_spread_slab is useless.
>> SLAB_MEM_SPREAD does not do anything anymore. SLUB relies on the
>> "spreading" via the page allocator memory policies instead of doing its
>> own like SLAB used to do.
>>
>> What does FILE_SPREAD_SLAB do? Dont see anything there either.
> The FILE_SPREAD_SLAB flag is used by cpuset.memory_spread_slab with read/write operations:
>
> In kernel/cgroup/cpuset.c,
> static struct cftype legacy_files[] = {
> ... snip ...
>          {
>                  .name = "memory_spread_slab",
>                  .read_u64 = cpuset_read_u64,
>                  .write_u64 = cpuset_write_u64,
>                  .private = FILE_SPREAD_SLAB,
>          },
> ... snip ...
> };

It looks like that memory_spread_slab may have effect only on the slab 
allocator. With the removal of the slab allocator, memory_spread_slab is 
now a no-op. However, the memory_spread_slab cgroupfs file is an 
externally visible API. So we can't just remove it as it may break 
existing applications. We can certainly deprecate it and advise users 
not to use it.

Cheers,
Longman




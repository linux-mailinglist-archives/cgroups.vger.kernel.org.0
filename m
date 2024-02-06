Return-Path: <cgroups+bounces-1376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625884ACC8
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352B7285F9A
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495673188;
	Tue,  6 Feb 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN7rgMAH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536B2CA4
	for <cgroups@vger.kernel.org>; Tue,  6 Feb 2024 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189668; cv=none; b=abPuwA+WE3AzAqGO5KlubjvVI8cpIO29a1ypGy5RSUVcOeiTUg6n9S6ehbjuVP+muA58r5e0/fgeQd8xeu2Gxn3LWI6U7zO8h/wXbJnrQd/sPshyYHEIH0lGQuhumxRJCT/Lik8ZHNYuYhzs0VL5zncavH0bQh+OI3CnSf///t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189668; c=relaxed/simple;
	bh=D45sGI79V7I3jog6iYTL/qw664zIgKIyT8rlsh4HhjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dKJSmThqVcWZ6+RNKuJRGtbIEG6rBtk2cUiw6b4BqgvswIEjlncBv1vls52DZguMdHT4yK3sCvcierKE2SvXZ85KjIsg9lgqoNIcnehVdT4rxCNMGW7knR7vKPCcYSm71lhr25OupVtmGB1YPkj93ikbXDRTSS79Jt1yFNpEx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dN7rgMAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707189665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcVv/5RBXXyL4uRMPvuDyJl99xGfle/eegK32/iguR8=;
	b=dN7rgMAHkvD6nEnwXVFsaXn//+1awLCYuyxbG4y+tY+8eF0IP2+BNkbXQSQOAwWub5OFgX
	f+WadaqHvp3Sz52w3XrHSG32loXrCnz+JlOyFkradFv71d9t9PG1O1nzrVopKATDMJ/Kj8
	fqq+v0/Pazv2qkk4Mm65s31w0F3CU0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-q1G3jI78OEeWv3sa_NGZqQ-1; Mon, 05 Feb 2024 22:20:59 -0500
X-MC-Unique: q1G3jI78OEeWv3sa_NGZqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9138D83B86B;
	Tue,  6 Feb 2024 03:20:58 +0000 (UTC)
Received: from [10.22.17.212] (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CC0F1121313;
	Tue,  6 Feb 2024 03:20:57 +0000 (UTC)
Message-ID: <2efa10b2-6732-4aa5-98ae-34053a5838ee@redhat.com>
Date: Mon, 5 Feb 2024 22:20:57 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
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
 <da2417c0-49f1-4674-95f9-297d6cd9e0fa@redhat.com>
In-Reply-To: <da2417c0-49f1-4674-95f9-297d6cd9e0fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 2/5/24 22:16, Waiman Long wrote:
>
> On 2/5/24 20:46, Song, Xiongwei wrote:
>> Adding the maintainers of cpuset of cgroup.
>>
>>> On Sun, 4 Feb 2024, Song, Xiongwei wrote:
>>>
>>>> Once SLAB_MEM_SPREAD is removed, IMO, cpuset.memory_spread_slab is 
>>>> useless.
>>> SLAB_MEM_SPREAD does not do anything anymore. SLUB relies on the
>>> "spreading" via the page allocator memory policies instead of doing its
>>> own like SLAB used to do.
>>>
>>> What does FILE_SPREAD_SLAB do? Dont see anything there either.
>> The FILE_SPREAD_SLAB flag is used by cpuset.memory_spread_slab with 
>> read/write operations:
>>
>> In kernel/cgroup/cpuset.c,
>> static struct cftype legacy_files[] = {
>> ... snip ...
>>          {
>>                  .name = "memory_spread_slab",
>>                  .read_u64 = cpuset_read_u64,
>>                  .write_u64 = cpuset_write_u64,
>>                  .private = FILE_SPREAD_SLAB,
>>          },
>> ... snip ...
>> };
>
> It looks like that memory_spread_slab may have effect only on the slab 
> allocator. With the removal of the slab allocator, memory_spread_slab 
> is now a no-op. However, the memory_spread_slab cgroupfs file is an 
> externally visible API. So we can't just remove it as it may break 
> existing applications. We can certainly deprecate it and advise users 
> not to use it.

BTW, cpuset doesn't use SLAB_MEM_SPREAD directly. Instead it set the 
task's PFA_SPREAD_SLAB and let other subsystems test it to act 
appropriately. Other than cpuset, the latest upstream kernel doesn't 
check or use this flag at all.

Cheers,
Longman



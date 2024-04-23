Return-Path: <cgroups+bounces-2680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015938AF798
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50EE1F23642
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3F1422D5;
	Tue, 23 Apr 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyhVKDGv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3411224F0
	for <cgroups@vger.kernel.org>; Tue, 23 Apr 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901839; cv=none; b=mHXf6CSedXmiMMTQo4hSmIj1IyjQ0CP1oKsNLMUsdovUgPe2fCL9ZRrkWWI05z350xiQ3aaIoFqsdrSrkBFON5H3b8VuqNk1V2I2X2hrK4jLGluEYjb95bXYCTFISMPnctpyXp0mTpTuLHCMjFjpBTjLlkSSbTflZv3j7yRrI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901839; c=relaxed/simple;
	bh=pFj9t6VlpRLxHZnIcT1VrnG+fk41RI1/LJ9PeLBk/IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KivNZwoDqwEcgv2JQDjSOE9lVhY7dziwM4eeG62SKI4fkn6RMdMGuTyDdi1Bp3JlWaB8b3YMVVNMDl9JW18KmxmdCBb7Ta5fDwXsaLHJ5UwDg12baSXeFZDHgaNdEBUeGNIz8UJdc46XUIptGBPE0wwUhPs0MrxlBy5yLeZu/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyhVKDGv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713901836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewtLT1/cjSQQ557ikydUTGboR16eS4xNzisoXGg5JBk=;
	b=hyhVKDGvgZrz6Dx68PafMVtlQRdxTR8AGLSYoUnOrh8mRL1Zg7xpM4Y0w8PcGM395oejGW
	8O3iar57WefNd98716fDEVJTwgEfjTX+E3D1lWUswTGdTR0KkEEkxTs4lvsBsJ1guLmxZH
	k4pBSQk9BBO2PogGxS1qJ5NT4T8sm/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Br_0pyUyPB2MACWBfIuM5Q-1; Tue, 23 Apr 2024 15:50:33 -0400
X-MC-Unique: Br_0pyUyPB2MACWBfIuM5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE21834FB6;
	Tue, 23 Apr 2024 19:50:32 +0000 (UTC)
Received: from [10.22.33.184] (unknown [10.22.33.184])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 926A8200E290;
	Tue, 23 Apr 2024 19:50:31 +0000 (UTC)
Message-ID: <a583d400-ed59-46b8-a26d-b726055b5cad@redhat.com>
Date: Tue, 23 Apr 2024 15:50:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
To: Klara Modin <klarasmodin@gmail.com>, Xiu Jianfeng
 <xiujianfeng@huawei.com>, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
 <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 4/23/24 15:21, Klara Modin wrote:
> Hi,
>
> On 2024-04-20 11:46, Xiu Jianfeng wrote:
>> Initializing top_cpuset.relax_domain_level and setting
>> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
>> completed at the time of top_cpuset definition by compiler.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d8d3439eda4e..e70008a1d86a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -369,8 +369,9 @@ static inline void notify_partition_change(struct 
>> cpuset *cs, int old_prs)
>>     static struct cpuset top_cpuset = {
>>       .flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
>> -          (1 << CS_MEM_EXCLUSIVE)),
>> +          (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
>
> You dropped a '<' for the bitwise shift, this causes bad cpu 
> utilization for me.

Oh, now load_balancing is disable by default in the root cgroup. That is 
bad. Will post a patch to fix it.

Thanks,
Longman



>
>>       .partition_root_state = PRS_ROOT,
>> +    .relax_domain_level = -1,
>>       .remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
>>   };
>>   @@ -4309,8 +4310,6 @@ int __init cpuset_init(void)
>>       nodes_setall(top_cpuset.effective_mems);
>>         fmeter_init(&top_cpuset.fmeter);
>> -    set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
>> -    top_cpuset.relax_domain_level = -1;
>>       INIT_LIST_HEAD(&remote_children);
>>         BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>
> Kind regards,
> Klara Modin



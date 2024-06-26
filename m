Return-Path: <cgroups+bounces-3385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA29199CF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 23:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E21C1C21843
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3F19308E;
	Wed, 26 Jun 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp/8tqwL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A62AF1A;
	Wed, 26 Jun 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437711; cv=none; b=DzMcPXiQU4xf1zHH46u7it6B6HwiJCbzxeEpqc1T2rRdlpeNURjSuCQEZwU64TC3QZ8zrYK0bWQckosb0b7qFjDS9Rni9TegkLLfkLfk4PTtIcNqWYQrgLm5ZQsZW51uPhtsQ1QJKQslNeRGxzcnhFd6ZUcHUUUsydTDnGIbAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437711; c=relaxed/simple;
	bh=s0GeOvESFSBrRi+DN+LV5hCsx1lZA+34LfdNK7H/BjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUvdXLzW0I/ceDS/IPogTzwpl+s3AsyWigrb7rvZETDff66TcgfJNQsFPraq1TVu8GiaLJmjYQ7HS/nGEVUxnVTP/i9Yz7Swssg6T8+vX95vecUWOPBqI88bYyTcp1y//WRdQ7WX2mnXfFlSGKRXheHH2L/dSk0BFRPNSt56I/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp/8tqwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B57C116B1;
	Wed, 26 Jun 2024 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719437710;
	bh=s0GeOvESFSBrRi+DN+LV5hCsx1lZA+34LfdNK7H/BjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vp/8tqwLmUV0dpY+5G8PSbp0C94GyCfYCdhzDxYX5hLTjrHz+2FEunJDuJpg7uhQJ
	 8VQDPRLapN3ArwFx1H/jXPizTFxCFwGfRWadUVAS9H10eMP5gNsir/WtXSTd1eVIsy
	 Na6/IXVRnU+JdIwyWxjzFVjeyIxScxsnmdvkhIaUo3k/2Mlu/mwccIv4AVb+g03bNq
	 TdCUBm8QR0fnv0zME3/1Z08lHbnlkbv2V5T28Tg6bz+p0znXTpdssQUQEmfVRWLaQW
	 c6rNlSCfONB+d+pm/up857qhaWDrpo5MUuLlXp8dJ3CuP4ZuCxt4o32GQ7dmCMBtK3
	 V4y+7OQz4PDXw==
Message-ID: <43732a44-1f90-4119-9e52-000b5a6a2f99@kernel.org>
Date: Wed, 26 Jun 2024 23:35:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
 <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
 <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
 <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
 <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/06/2024 00.59, Yosry Ahmed wrote:
> On Tue, Jun 25, 2024 at 3:35 PM Christoph Lameter (Ampere) <cl@linux.com> wrote:
>>
>> On Tue, 25 Jun 2024, Yosry Ahmed wrote:
>>
>>>> In my reply above, I am not arguing to go back to the older
>>>> stats_flush_ongoing situation. Rather I am discussing what should be the
>>>> best eventual solution. From the vmstats infra, we can learn that
>>>> frequent async flushes along with no sync flush, users are fine with the
>>>> 'non-determinism'. Of course cgroup stats are different from vmstats
>>>> i.e. are hierarchical but I think we can try out this approach and see
>>>> if this works or not.
>>>
>>> If we do not do sync flushing, then the same problem that happened
>>> with stats_flush_ongoing could occur again, right? Userspace could
>>> read the stats after an event, and get a snapshot of the system before
>>> that event.
>>>
>>> Perhaps this is fine for vmstats if it has always been like that (I
>>> have no idea), or if no users make assumptions about this. But for
>>> cgroup stats, we have use cases that rely on this behavior.
>>
>> vmstat updates are triggered initially as needed by the shepherd task and
>> there is no requirement that this is triggered simultaenously. We
>> could actually randomize the intervals in vmstat_update() a bit if this
>> will help.
> 
> The problem is that for cgroup stats, the behavior has been that a
> userspace read will trigger a flush (i.e. propagating updates). We
> have use cases that depend on this. If we switch to the vmstat model
> where updates are triggered independently from user reads, it
> constitutes a behavioral change.

I implemented a variant using completions as Yosry asked for:
 
https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/

--Jesper


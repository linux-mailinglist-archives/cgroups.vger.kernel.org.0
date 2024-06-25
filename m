Return-Path: <cgroups+bounces-3368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A718917452
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 00:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E516A1F23E67
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332E17F50C;
	Tue, 25 Jun 2024 22:35:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D617DE0D;
	Tue, 25 Jun 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354930; cv=none; b=ESZ9mJQb4wFHCfYvpQ7OyO5s7t8jfvgIRlr6EVXg8/uKwRlO2txQ1hNmmO+GDah8gpbQpKR5IdMAS+K35QNW0tcJ37Sa1+hCE6fXqkQXI0reTVVCUhDe1psmuvUr+vLD8mC/GJMDLerxoIs69PwS8n9iWexXoP9oHAi1bhVmIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354930; c=relaxed/simple;
	bh=Nbm7pFV+HLXwpWP091wSzYZrgGqniCkWpwFtwGQ/xMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C3leFKaEsRkCDtcISv9Sy+1/RrtLSiQaEMqb5jlxgpF6biJ6Rnm8HAKizziBTqtI6vX84MZPppv1QPLMl/AC3ezZABy1GH/1zjEKC/JQwb8V6/V+fa08koEYKuQc6kBRj60iNVSX+tXkG/ne+wVGWZe+rOkdaeFHj9ArTI6fpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 38F8D4093E; Tue, 25 Jun 2024 15:35:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 37E0E4022C;
	Tue, 25 Jun 2024 15:35:21 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:35:21 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Yosry Ahmed <yosryahmed@google.com>
cc: Shakeel Butt <shakeel.butt@linux.dev>, 
    Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
    cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
    longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
In-Reply-To: <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
Message-ID: <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg> <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com> <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj> <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh> <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com> <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3> <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com> <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Jun 2024, Yosry Ahmed wrote:

>> In my reply above, I am not arguing to go back to the older
>> stats_flush_ongoing situation. Rather I am discussing what should be the
>> best eventual solution. From the vmstats infra, we can learn that
>> frequent async flushes along with no sync flush, users are fine with the
>> 'non-determinism'. Of course cgroup stats are different from vmstats
>> i.e. are hierarchical but I think we can try out this approach and see
>> if this works or not.
>
> If we do not do sync flushing, then the same problem that happened
> with stats_flush_ongoing could occur again, right? Userspace could
> read the stats after an event, and get a snapshot of the system before
> that event.
>
> Perhaps this is fine for vmstats if it has always been like that (I
> have no idea), or if no users make assumptions about this. But for
> cgroup stats, we have use cases that rely on this behavior.

vmstat updates are triggered initially as needed by the shepherd task and 
there is no requirement that this is triggered simultaenously. We 
could actually randomize the intervals in vmstat_update() a bit if this 
will help.



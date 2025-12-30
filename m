Return-Path: <cgroups+bounces-12812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4F0CE8AC6
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 05:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4FB301118D
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 04:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B82E7BD3;
	Tue, 30 Dec 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ccobxUBT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECE2E0418
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767067905; cv=none; b=PPiD1Te5uTw25LlNQMRcAwWI/VG/5tO6MrUw8lat3keqOhi/NnvQBdU9qFb8KdF3/KdIEiiYIrJ4Ufiru40NEkWm1b+cA5c/sgbqSo0q9JnVfpyWMXkcp3fd7WALdU4hj5wf3jnQch6sfsMVd/6ZmDdDY0PxYZ9Tx+k3nDe7hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767067905; c=relaxed/simple;
	bh=lWjIb4UZEyKKZwTvHdILRcV74BciZull5tIXRmGZM9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJqnKDhvkdts7tW8uXxI6fHBYJ8j6WLAitwdaDXewA/PCgiBs9pHxf7DU/qDXfdGMphWmV3LL5kZ5UNn83cH+ocQd/uAZTk9slep7qG925vRYGaTr7xUewlANzayDfAQTD4bqedJkbbj7Ydjd72qGBov09bC0mT7D03nvLo3qc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ccobxUBT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767067891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Gvt0xBPaqEQHpjlZBewh20jN1+cqjtxMqmPyTRtzI=;
	b=ccobxUBTuMWM7EGfjZbZGfYYmluDNpGprUkUsrrUwOgE1A/0Jz4Rd+dAiIV4sGNn8VaHsJ
	LU8ikPNPEIYA7HBVPiySWJff/Q74rwDsVFPPEHvuES3vY8x0NVc/ABFvlE5wYSEGnNEDQE
	d1lAn+7A+D0JdjkMw2ii8kU8IzBfZmA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>,  hannes@cmpxchg.org,  hughd@google.com,
  mhocko@suse.com,  muchun.song@linux.dev,  david@kernel.org,
  lorenzo.stoakes@oracle.com,  ziy@nvidia.com,  harry.yoo@oracle.com,
  imran.f.khan@oracle.com,  kamalesh.babulal@oracle.com,
  axelrasmussen@google.com,  yuanchu@google.com,  weixugc@google.com,
  chenridong@huaweicloud.com,  mkoutny@suse.com,
  akpm@linux-foundation.org,  hamzamahfooz@linux.microsoft.com,
  apais@linux.microsoft.com,  lance.yang@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,  Qi Zheng
 <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
In-Reply-To: <423puqc6tesx7y6l4oqmslbby2rfjenfnw5pn5mgi63aq74jwj@jwgorel2uj3m>
	(Shakeel Butt's message of "Mon, 29 Dec 2025 20:01:30 -0800")
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
	<7ia4ldikrbsj.fsf@castle.c.googlers.com>
	<423puqc6tesx7y6l4oqmslbby2rfjenfnw5pn5mgi63aq74jwj@jwgorel2uj3m>
Date: Mon, 29 Dec 2025 20:11:22 -0800
Message-ID: <87ecoc7gnp.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Tue, Dec 30, 2025 at 01:36:12AM +0000, Roman Gushchin wrote:
>> Qi Zheng <qi.zheng@linux.dev> writes:
>> 
>> Hey!
>> 
>> I ran this patchset through AI review and it found few regression (which
>> can of course be false positives). When you'll have time, can you,
>> please, take a look and comment on which are real and which are not?
>> 
>> Thank you!
>
> Hi Roman, this is really good. I assume this is Gemini model. I see BPF
> and networking folks have automated the AI review process which is
> really good. I think MM should also adopt that model. Are you looking
> into automating MM review bot?

Yes, absolutely. We're working on it, hopefully in January/February we
can have something reasonably solid.

Thanks


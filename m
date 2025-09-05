Return-Path: <cgroups+bounces-9756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75353B4656F
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE27B60D3
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254828488F;
	Fri,  5 Sep 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T92UJ6nl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2801F30AD
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107274; cv=none; b=DmDWKDYtZ1xVRXU+I+B+8v5vbZDgCqq5gwQnM0BcOxSZT0q55YbfUnlX48+2jlrjFg9R6G5JWLaKPUoidfpzKcQbXVzF2fx/3r01EHqm3zuHK1qipAgonLzW5k8iylEf9d0YXPZR4cT0Z0RL5wh5DEFNYQMUGXJ5lgVfZraT4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107274; c=relaxed/simple;
	bh=osQ9Lif183itocSuB65QNUmR7DDdBX3nJ25Dd19v7/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SwSPJVLtUHpdRr4UXI6ue8MPvb+88o53Zs2JW9OrtAZvfSlSLtNytF2C9rG4SSoP2KtPoT5tsx88yfFLVrhzm95leNJAeW+FMBb28MSz+pF0pp/t4JrC9CMhu7nCyoeTqUXz+ZsQjrYjL3sry2rZWTdCzVdF+jFMRRL6GT33jZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T92UJ6nl; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757107260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osQ9Lif183itocSuB65QNUmR7DDdBX3nJ25Dd19v7/A=;
	b=T92UJ6nlCLVsFWAjC543fR6YxZ7eSKX4N/EozztC9mQXQQZDNQpa1JqppUr7HfB/1DqVC1
	eMMGdMAl5kM/wbqM9bnCE4A7yj8zaOMAzfc1girqTcnRs2VN1F4AGpd0+z+Rm87itDCCbG
	IVdmYsC+5yZnrIvGVfOGBtML1s5j1Pg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Muchun Song <muchun.song@linux.dev>,  Alexei Starovoitov
 <ast@kernel.org>,  Peilin Ye <yepeilin@google.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  bpf@vger.kernel.org,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org,  Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Fri, 5 Sep 2025 13:16:06 -0700")
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Date: Fri, 05 Sep 2025 14:20:46 -0700
Message-ID: <87y0qsa95d.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
>
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.

Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
like a bit deal, but OOM events can be way more important.

Should we instead preserve the event (e.g. as a pending_event_mask) and
raise it on the next occasion / from a different context?

Thanks


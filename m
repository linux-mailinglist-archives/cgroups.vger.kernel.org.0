Return-Path: <cgroups+bounces-10367-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5289B93878
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 01:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD87164D5E
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CC286427;
	Mon, 22 Sep 2025 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pTMVo+nj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3B3AC39;
	Mon, 22 Sep 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582191; cv=none; b=XbDzNVXooB9Mf3HfmtcP2nITXlBeb4tMVCV7UTA/ryVKNN33PPrDP6aYJWWt2Dtbxg2pXeDqO/eJ1BfsixlCdefm3Ko78yUaxq7iVlU+66TX62mNRnOxIqFvKNFFAvqRlLS5/UbQMyeDJSQFJ8uL0DlX5cOdCMEFHpVx8AVRKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582191; c=relaxed/simple;
	bh=Ga3iCtdjN8K221Qg5mW5H1wWCF8VcrbTHNLCYL827Tg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oIPu35HTtydLfOuVg3c5oEIywGHRmGj+oLpWt06xnQjVVTuhoYnRb6RoJSDYpJhhU+s8NTDVH3QBNEDGD3YN2+KVTT+20n7euW6/cQjcv0jOGMAHXFbL27QF06zSbUs/DRWH78q1IRyvkwU8THS/tLgc+1pZjDrdDGjJncqNXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pTMVo+nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63BFC4CEF0;
	Mon, 22 Sep 2025 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758582189;
	bh=Ga3iCtdjN8K221Qg5mW5H1wWCF8VcrbTHNLCYL827Tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pTMVo+nj7csww0q3/7UDygDGBnLo3Te9cgJKYwUtiPgeHpi4Cwdke/MPEfT9PnXLX
	 DXeGEdvIfwsnOf+3RoWJNjmYPfdUYmGAVQd6LMP8N0/qkM1IOGHaiWl/Sl0aHaTn82
	 E4k7BPsCffyuL2niZV8EMfcE27uUOPkaH9zmFSAw=
Date: Mon, 22 Sep 2025 16:03:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-Id: <20250922160308.524be6ba4d418886095ab223@linux-foundation.org>
In-Reply-To: <20250922220203.261714-1-shakeel.butt@linux.dev>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

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
> 
> Alternative approach was also explored where instead of skipping
> cgroup_file_notify(), we defer the memcg event processing to irq_work
> [1]. However it adds complexity and it was decided to keep things simple
> until we need more memcg events with !allow_spinning requirement.

What are the downsides here?  Inaccurate charging obviously, but how
might this affect users?

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2307,12 +2307,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
> +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
>  

Does this affect only the problematic call chain which you have
identified, or might other callers be undesirably affected?


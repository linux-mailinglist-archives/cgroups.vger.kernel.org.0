Return-Path: <cgroups+bounces-9757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0317B46576
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8B8164844
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D72F1FED;
	Fri,  5 Sep 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovDb1vEK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9828000F;
	Fri,  5 Sep 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107536; cv=none; b=XQNjSfFH+bcjw3ERgoDzP16pQ3rqdBe7EtwwyqN9poVaTttSnU1KZejEXWC9YTbMEeQSNEqXmeeUvOdYXJv4oXLoV62KUBb4fAKy3orVo6/czc5t857++uWy6oEyoildsoqI/XD0HL6eBVbzDn5C+icalXfQse2u8rNHolWGhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107536; c=relaxed/simple;
	bh=WPoJwaVQXGkbzP/Vb9wAK4RsibkCO5VPcszwcm2D9Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYgNjPfrnQ+GeDhBOY/GOWoKIPrm73r/MYt9jgfLPoVdZyyXg5H76ckiHMopQ7QJ3zEsoqeZE3rIT20auT5ffvoNhx87vZRGcHvz/kcp4pBGitZPuNhk0qx0RxDSPz0ZQy+b5i5MnKjglkAvaFGv5aoRJvQOgwH59DRV97ZrIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovDb1vEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDACC4CEF1;
	Fri,  5 Sep 2025 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757107535;
	bh=WPoJwaVQXGkbzP/Vb9wAK4RsibkCO5VPcszwcm2D9Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovDb1vEKU6V+sG5Osq3FeR/x5JaHP5Z2nwXevsmXNAieLPlSNxerKnohvC9gMBTNO
	 z5c75iIrlm4TDIQ2TT4JI2BjOp31psrlEhVSKhaIYoUYqVEFX7283d17eygYFy015b
	 OCjKZu86gRL3/Rkpf2WrCSlvmkA23+xoVxKtiK8+d0gcreznM7veqM5/azH7D9VovY
	 prWeMNKZ4Ni7PsuEamTvcNq4zQ8aj0uAQifUUUj9em8M4YxcS6FrUZ1B4nPB1A7anF
	 V8EDj0TXZOSV+UmYT2ncSifCTM9PIf8yx96CQ/bOanGYwJ1S+ah93I1Prn1M20udjy
	 XbMJiYu+zQqug==
Date: Fri, 5 Sep 2025 11:25:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtVTo-Egnqdjxi2@slm.duckdns.org>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <87y0qsa95d.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0qsa95d.fsf@linux.dev>

On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> >
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> 
> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
> like a bit deal, but OOM events can be way more important.
> 
> Should we instead preserve the event (e.g. as a pending_event_mask) and
> raise it on the next occasion / from a different context?

Maybe punt with an irq_work?

Thanks.

-- 
tejun


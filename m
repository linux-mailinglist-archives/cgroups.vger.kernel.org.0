Return-Path: <cgroups+bounces-11291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45091C16439
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96349563549
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901034AB04;
	Tue, 28 Oct 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhpWFvXh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267117A2E0;
	Tue, 28 Oct 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673210; cv=none; b=QPxnFBLPQsPpjjB8+ipyOQXTHCWh9U7tIBNwvAjrEUYvgjkeUyrDwmeSpc6icRHxpOePNfQHBS4rKJwMHJl0zaYSYZhad4VGmwYFxMt1Rw36Zu7YhvzouP0SWWjN7bPwRcIz86AyYUqI8pLibMmnA/0PL+kS5VL8uGDLSzhTm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673210; c=relaxed/simple;
	bh=JEQpfJ799L7UkBwPLShI6fWI+pURiMoySEUTMZTFRT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFML7Z6qluodo2qtclIDatto8Hi2Tw+LVjyyt4Tg/HQp8UknibK0xvOhzsWPHZlSzJ0lIpKwjynOh88vhj1F8C1kxUYtzegFgcTKBhz/zOyyvEzgTyQ+UILL8l8IWUr7zykjosGQispxdgCRychqau6LGtIUGKTite9CQ+29iEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhpWFvXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F375AC4CEE7;
	Tue, 28 Oct 2025 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761673210;
	bh=JEQpfJ799L7UkBwPLShI6fWI+pURiMoySEUTMZTFRT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhpWFvXhSdhhVyXCw3aXi6KEYWQg1ikLqpo0HnL4cew9t+lTIWD+gF7HEotjTuYwI
	 0w7GVQJ1gVdHBiaAXuG2T1zPY9/By4Ca4Y/icS160SpZUfei2UgWqXX5BOvV/Pi2e2
	 6+KGBg48l1wCKPXkG1m0yGhqDCxlhlqsSTQL/a5/sNSBmXgjd7ziNPqCM9pajV00pw
	 gsEQ58uwgI5MolbjvLP4xJSuIoWc9Di9UtG/sE2bSj54qs42DqVODrwG08jVgqeziS
	 yqofkwVvCpqLd1FX94DT8PM2dQyITMIglG4QoM0zGOSOUV+T83udKEI2EeJdncbp0k
	 FQKYKTGUn6hiQ==
Date: Tue, 28 Oct 2025 07:40:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
Message-ID: <aQD_-a8oWHfRKcrX@slm.duckdns.org>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-10-roman.gushchin@linux.dev>

Hello,

On Mon, Oct 27, 2025 at 04:22:03PM -0700, Roman Gushchin wrote:
> This patch implements a BPF struct ops-based mechanism to create
> PSI triggers, attach them to cgroups or system wide and handle
> PSI events in BPF.
> 
> The struct ops provides 3 callbacks:
>   - init() called once at load, handy for creating PSI triggers
>   - handle_psi_event() called every time a PSI trigger fires
>   - handle_cgroup_online() called when a new cgroup is created
>   - handle_cgroup_offline() called if a cgroup with an attached
>     trigger is deleted
> 
> A single struct ops can create a number of PSI triggers, both
> cgroup-scoped and system-wide.
> 
> All 4 struct ops callbacks can be sleepable. handle_psi_event()
> handlers are executed using a separate workqueue, so it won't
> affect the latency of other PSI triggers.

Here, too, I wonder whether it's necessary to build a hard-coded
infrastructure to hook into PSI's triggers. psi_avgs_work() is what triggers
these events and it's not that hot. Wouldn't a fexit attachment to that
function that reads the updated values be enough? We can also easily add a
TP there if a more structured access is desirable.

Thanks.

-- 
tejun


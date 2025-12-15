Return-Path: <cgroups+bounces-12364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6ECBF65F
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 752B830072A3
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300D299928;
	Mon, 15 Dec 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3LqOJpa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AE30F55F
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822756; cv=none; b=ZNHnnRXs/jfRwx/jWZU95Jy7eMknxPSS0K/0UE5cQ1M1W9TRBLB6xBRDvsNiUb24LT8TZEqDlAF9jLlCXMUbWe/ppFaML+4R51urWgK+rrXV0W4greijvT6Tn7tI7Oy8Zn3+WTAmSGw7GwyMiT4aYtZ5Y6AUEypW9bVTLlKS0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822756; c=relaxed/simple;
	bh=fP3uNgHEcb9XOEi42AIN+oIdqd23kLSGNYQ67IqUdQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orah3v6RrIfVFzktl5T6HReylse47Dr7n1m9g+in/Mabk3OGI9Lx91s+BfLT7LfaNkb9inH2GZvA1wHYQILQc+e2WgHVosQ+DN3mYbvw0E3qurAtdiLw65YtlUXohm34jgkz5oRDj7vveJtFQKE6wSQN+uZ4Iaay+JcbMpxuOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3LqOJpa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 10:18:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765822751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM43wrnlnlkMNqFPDW8KYA5Kn3KbKiIXGK01EzxZsuk=;
	b=J3LqOJpafBGNgZS/H44p6FPOwYKxXkhb8+O+/PoV1ltWSxYSLr4nIJclgI28YDJeNqU+iv
	wAhQjhvcH+sBjL5dgEMNwyFKkK8p24U1qx6qjni3y49IGWOeKuK0TlRrB5gbFlwFDC52qo
	dN4GL7gHKXPvf23CsBAgk7OicW1+xJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <j4w2nyev23cdn7b4yop77baokq52cd4bkz64phosh2yuynlbfr@4azhrbquiyjw>
References: <20251205200106.3909330-1-shakeel.butt@linux.dev>
 <rrpswcxeciypobup7rdwvjknnsjkcnov2xdabbfng7se5yihk5@4wayqftotykw>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rrpswcxeciypobup7rdwvjknnsjkcnov2xdabbfng7se5yihk5@4wayqftotykw>
X-Migadu-Flow: FLOW_OUT

Hi Michal,

Sorry for the late response as I was travelling.

On Mon, Dec 08, 2025 at 07:11:31PM +0100, Michal Koutný wrote:
> On Fri, Dec 05, 2025 at 12:01:06PM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > On x86-64, this_cpu_cmpxchg() uses CMPXCHG without LOCK prefix which
> > means it is only safe for the local CPU and not for multiple CPUs.
> ...
> > The CMPXCNG without LOCK on CPU A is not safe and thus we need LOCK
> > prefix.
> 
> Does it mean that this_cpu_cmpxchg() is generally useless? (It appears
> so from your analysis.)

No it is still useful for single CPU atomicity i.e. process context vs
irq and NMIs.

> 
> > Now concurrently CPU B is running the flusher and it calls
> > llist_del_first_init() for CPU A and got rstatc_pcpu->lnode of cgroup C
> > which was added by the IRQ/NMI updater.
> 
> Or it's rather the case where rstat code combines both this_cpu_* and
> remote access from the flusher.

Yes.

> 
> Documentation/core-api/this_cpu_ops.rst washes its hands with:
> | Please note that accesses by remote processors to a per cpu area are
> | exceptional situations and may impact performance and/or correctness
> | (remote write operations) of local RMW operations via this_cpu_*.
> 
> I see there's currently only one other user of that in kernel/scs.c
> (__scs_alloc() vs scs_cleanup() without even WRITE_ONCE, but the race
> would involve CPU hotplug, so its impact may be limited(?)).

No, I don't think there is a race as hotplug callback happens in the
PREPARE state where the target CPU is already off and thus nothing is
running on it. BTW cached_stacks for VMAP kernel stack is similar.

> 
> I think your learnt-the-hard-way discovery should not only be in
> cgroup.c but also in this this_cpu_ops.rst document to be wary
> especially with this_cpu_cmpxchg (when dealing with pointers and not
> more tolerable counters).

Yes, this makes sense. I will followup on that.
> 
> 
> > Consider this scenario: Updater for cgroup stat C on CPU A in process
> > context is after llist_on_list() check and before this_cpu_cmpxchg() in
> > css_rstat_updated() where it get interrupted by IRQ/NMI. In the IRQ/NMI
> > context, a new updater calls css_rstat_updated() for same cgroup C and
> > successfully inserts rstatc_pcpu->lnode.
> > 
> > Now imagine CPU B calling init_llist_node() on cgroup C's
> > rstatc_pcpu->lnode of CPU A and on CPU A, the process context updater
> > calling this_cpu_cmpxchg(rstatc_pcpu->lnode) concurrently.
> 
> Sounds feasible to me.

Thanks for taking a look.


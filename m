Return-Path: <cgroups+bounces-7958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC6AA4F22
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C9F1707F0
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6419AD90;
	Wed, 30 Apr 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0wr+Ehh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BEB640
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024839; cv=none; b=h7snXu1GMkALvV1K8zmr899WdA1c9XovdD+5/f5VYaS67P61swjKYhWkLXyTXznXYhi/kUCKX3LxMe0eGfziRYbYm0p0JIS5MA65N3ZDDH7mYW6pfDyymaO0bhvgoRo//DjJa6ZadScM9hC5fc0TuWy7xdrhUMe+5pZP7du1pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024839; c=relaxed/simple;
	bh=0t/OWqEE+TONcYA8grt+EPvQWGLeiJ6QWPI4sdnUhtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSnARlVZwqw00Sjj/vBav7rZhVmCCIl3cFyiebVMpEvkSXZC236mngzpXM5ln+dxwIJWkfLefGMRTqTuj/MfTJ70m2/9N4yr76T9782JlQe+6EHHt1FFv4Up7hrV3hyfmbl3K8ebqa4NOaSnLs3BD6S+dj4x0fBVP44T8OeBqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0wr+Ehh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 14:53:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746024835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2WfIJfkULi6jd69VpstuPL+eloDnxf89UwFbTADE+M=;
	b=E0wr+Ehhi38fUhrRY4JGFtik3UcDULO4QpeMyNdfQtdQKsXxpN2TGmfVU+Ur2PKPjidHkj
	WalMJXXN+eDKOVzkfge/EK/AkqSxvpsPXNMFyf9hXcJREEh6VKYxXlt5d4YczRhebL3srL
	M/Jm5uC99IZZdpq2XcyINGE7biNDcvw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBI5fh28P1Qgi2zZ@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
 <aBC7_2Fv3NFuad4R@tiehlicka>
 <aBFFNyGjDAekx58J@google.com>
 <aBHQ69_rCqjnDaDl@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBHQ69_rCqjnDaDl@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 09:27:39AM +0200, Michal Hocko wrote:
> On Tue 29-04-25 21:31:35, Roman Gushchin wrote:
> > On Tue, Apr 29, 2025 at 01:46:07PM +0200, Michal Hocko wrote:
> > > On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> > > > Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> > > > an out of memory events and trigger the corresponding kernel OOM
> > > > handling mechanism.
> > > > 
> > > > It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> > > > as an argument, as well as the page order.
> > > > 
> > > > Only one OOM can be declared and handled in the system at once,
> > > > so if the function is called in parallel to another OOM handling,
> > > > it bails out with -EBUSY.
> > > 
> > > This makes sense for the global OOM handler because concurrent handlers
> > > are cooperative. But is this really correct for memcg ooms which could
> > > happen for different hierarchies? Currently we do block on oom_lock in
> > > that case to make sure one oom doesn't starve others. Do we want the
> > > same behavior for custom OOM handlers?
> > 
> > It's a good point and I had similar thoughts when I was working on it.
> > But I think it's orthogonal to the customization of the oom handling.
> > Even for the existing oom killer it makes no sense to serialize memcg ooms
> > in independent memcg subtrees. But I'm worried about the dmesg reporting,
> > it can become really messy for 2+ concurrent OOMs.
> > 
> > Also, some memory can be shared, so one OOM can eliminate a need for another
> > OOM, even if they look independent.
> > 
> > So my conclusion here is to leave things as they are until we'll get signs
> > of real world problems with the (lack of) concurrency between ooms.
> 
> How do we learn about that happening though? I do not think we have any
> counters to watch to suspect that some oom handlers cannot run.

The bpf program which declares an OOM can handle this: e.g. retry, wait
and retry, etc. We can also try to mimick the existing behavior and wait
on oom_lock (potentially splitting it into multiple locks to support
concurrent ooms in various memcgs). Do you think it's preferable?


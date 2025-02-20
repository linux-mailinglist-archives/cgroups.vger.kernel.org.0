Return-Path: <cgroups+bounces-6632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3EA3E589
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 21:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DA719C5AC6
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D161621480E;
	Thu, 20 Feb 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKTyc5JP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D020B1F1
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081851; cv=none; b=U/+SV3DEv10Qe0iYVlmFJtjWwzAflgKdjiYzLPKiAgZUvx5W7pKO/x/xvRwwsN/SlRKeNlXy7iDl+zFEvEF1mYN3cI5aqL+HKdZre9bmRM1XzGGBMA+0FyesU7sZajxJVawPvv2LM/Wizdbo9huCPxSl9Tf0Pb9EIhPihBKtzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081851; c=relaxed/simple;
	bh=zdsScYvROjQuFd8aMJz8mAfuB0ZaCT6rR2o6JhBQhgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeAgc8C6m6FnnZmb15F9uZN4gtYJwwD4ik1DKz/VCKrUqAy8d9l8sC4R1zTz7nUCzoHD00a7PjPsvQ4hEPWKi/UxUjLqDKpOk2CEmj5jXge0v+kJkW6eEjzh/ziI6mFajj+oI6v8xbfuPHwIrxskQkMzKVoTRMWXAze3C9L7tBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKTyc5JP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 20:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740081848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFmr3HO81FYdSZTDncLSYQG2DARQ+VMo12KXwJzsQb4=;
	b=EKTyc5JPlQWmkW1o9MgF05ua99Z2xCTkHJadGrCVmNA5e3C8mz/yLapdCep2wto5o7jD7c
	Ce5PmBE0RqDKI2+cw+GN+tNOoB415NcwhMemssKyg6nLDFhrG6Mj/0kBcqhcVXw8zNmHSb
	3YBr5JkfOzt+C9mkgfGB2SlKlyqjVeA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <Z7eKslSmYU-1lP3u@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
 <Z7dtce-0RCfeTPtG@google.com>
 <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 10:14:45AM -0800, JP Kobryn wrote:
> On 2/20/25 9:59 AM, Yosry Ahmed wrote:
> > On Thu, Feb 20, 2025 at 09:53:33AM -0800, Shakeel Butt wrote:
> > > On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
> > > > 
> > > > Another question is, does it make sense to keep BPF flushing in the
> > > > "self" css with base stats flushing for now? IIUC BPF flushing is not
> > > > very popular now anyway, and doing so will remove the need to support
> > > > flushing and updating things that are not css's. Just food for thought.
> > > > 
> > > 
> > > Oh if this simplifies the code, I would say go for it.
> > 
> > I think we wouldn't need cgroup_rstat_ops and some of the refactoring
> > may not be needed. It will also reduce the memory overhead, and keep it
> > constant regardless of using BPF which is nice.
> 
> Yes, this is true. cgroup_rstat_ops was only added to allow cgroup_bpf
> to make use of rstat. If the bpf flushing remains tied to
> cgroup_subsys_state::self, then the ops interface and supporting code
> can be removed. Probably stating the obvious but the trade-off would be
> that if bpf cgroups are in use, they would account for some extra
> overhead while flushing the base stats. Is Google making use of bpf-
> based cgroups?

Ironically I don't know, but I don't expect the BPF flushing to be
expensive enough to affect this. If someone has the use case that loads
enough BPF programs to cause a noticeable impact, we can address it
then.

This series will still be an improvement anyway.


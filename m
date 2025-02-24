Return-Path: <cgroups+bounces-6689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F4A42EC0
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 22:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A3116A98B
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A087198822;
	Mon, 24 Feb 2025 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OrK9uho2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094C1991BB
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431624; cv=none; b=KMvtK3qAWBfMvhUpqBee/6UXbCP9pGL0pBDo3I5J2U4IbcriELIFXU51NQ3zXXyTkUi+FABlxPzJgxuB1sF3eMmSRJX1X4zH1ZYNPOQ4c72e1jkvTNJpaD2rlJiNgwpukqRk4en3YEPUkX8jSeN4zah4edUY0ZTmB5DTD08EyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431624; c=relaxed/simple;
	bh=RkcyMhr5YStMeuAtNhrBDbBNSuSM8aFWYiNqUFL+i5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZMsTgdQLZ+FzMbkZK1KgUzROUDfy/OUJgEDcFUvYIzmRCcDec6tvQghcWS/3eM9Ks5WwpuzLU6Z2oYzS5q55ZPfhBGDWHNaGTkfd52+Hv/okYAYpBWfkURaoMqXVcCnXrtoZnXjrYz0hNqRKLwfg9UKaARVstzBHwlMrLVy0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OrK9uho2; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 13:13:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740431619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd/z29n0XcTUSzPpHZ0vSyZb839BUcJwORjsci4MRHc=;
	b=OrK9uho21fWRb9hZFlknbWCZdTvv/IZ31vRqecxkZDAo/RNiJR36D53nmFvCzUCKUTaEbu
	1dDwLkpbKBfS+nJX4UUlzE0qmvSuhlhd2mvjF400SGQxN6kSywPwzjJKm7wSvY/xs/48X0
	Wo9VUc1YuOsGXLY4S8A6yRUaDbL7suM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <k3ymi6ipegswgeqbduotm2pwrkimkubv7imjpzxuiluhtd5iuu@defld6yydzyb>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
 <Z7dtce-0RCfeTPtG@google.com>
 <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
 <Z7eKslSmYU-1lP3u@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eKslSmYU-1lP3u@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 08:04:02PM +0000, Yosry Ahmed wrote:
> On Thu, Feb 20, 2025 at 10:14:45AM -0800, JP Kobryn wrote:
> > On 2/20/25 9:59 AM, Yosry Ahmed wrote:
> > > On Thu, Feb 20, 2025 at 09:53:33AM -0800, Shakeel Butt wrote:
> > > > On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
> > > > > 
> > > > > Another question is, does it make sense to keep BPF flushing in the
> > > > > "self" css with base stats flushing for now? IIUC BPF flushing is not
> > > > > very popular now anyway, and doing so will remove the need to support
> > > > > flushing and updating things that are not css's. Just food for thought.
> > > > > 
> > > > 
> > > > Oh if this simplifies the code, I would say go for it.
> > > 
> > > I think we wouldn't need cgroup_rstat_ops and some of the refactoring
> > > may not be needed. It will also reduce the memory overhead, and keep it
> > > constant regardless of using BPF which is nice.
> > 
> > Yes, this is true. cgroup_rstat_ops was only added to allow cgroup_bpf
> > to make use of rstat. If the bpf flushing remains tied to
> > cgroup_subsys_state::self, then the ops interface and supporting code
> > can be removed. Probably stating the obvious but the trade-off would be
> > that if bpf cgroups are in use, they would account for some extra
> > overhead while flushing the base stats. Is Google making use of bpf-
> > based cgroups?
> 
> Ironically I don't know, but I don't expect the BPF flushing to be
> expensive enough to affect this. If someone has the use case that loads
> enough BPF programs to cause a noticeable impact, we can address it
> then.
> 
> This series will still be an improvement anyway.

If no one is using the bpf+rstat infra then maybe we should rip it out.
Do you have any concerns?


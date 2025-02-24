Return-Path: <cgroups+bounces-6696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3654A42F90
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEB917754A
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3191DF242;
	Mon, 24 Feb 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xj7puxSs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FD1A9B23
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434086; cv=none; b=L6KytZVzTaRfXxU1isuaPvHwanx3e6vkH/jjIG6k+AoGOcgoAjvKvAEclpRV+s2WZXnb0oeU5qfGPfy8Zf4nyRTdNg3XF71aV5hOpcEFMh6oJTaecVfclO8fBPynezQFeQe5SHFQQuk64p6ecf3eVAd+2kfRiTGa1R/7PhvNxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434086; c=relaxed/simple;
	bh=/ZJXIg83Z2fu+Y7BQryjBkInpGxCjeQ7dhSQOQEQga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKj8+OaDy/Q6hn86L6CtRb5WMuh2Q6kzG1gniQ7mFKceBmgDxwWKNFPq3k5Zo2vfNAyExFBc2PeI7sjRjEkLKC3+0qegpPKuLKqmc27WlUlc6rYMBK7Nq4umgNg176LbOTxBXj8rJcY8Rec6/WNqVRRR/ZaIClBDCygbckgm1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xj7puxSs; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 21:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740434082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKvtXyMTOUzB1AmErLiqadTS7N4LqKEv1hJE5pdBIgg=;
	b=xj7puxSsieUCrsCLFguHW7TfcXlZ1UOcgY7ki6qZ9yDeGvi202eYiQKUbmi/NfMgxKMCXq
	43r32cOv54objJL5JpeJNOMgB2wnGjW6QGxee9ODS/qngJQpxvBToWpl6fKGE8tKK75oT7
	p0TMggfxIwUTsbsQ+G49DABHTewcuPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <Z7zqnTcJCHPHO418@google.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dlrEI-dNPajxik@google.com>
 <p363sgbk7xu2s3lhftoeozmegjfa42fiqirs7fk5axrylbaj22@6feugkcvrpmv>
 <Z7dtce-0RCfeTPtG@google.com>
 <158ea157-3411-45e6-bca4-fb70d67fb1c5@gmail.com>
 <Z7eKslSmYU-1lP3u@google.com>
 <k3ymi6ipegswgeqbduotm2pwrkimkubv7imjpzxuiluhtd5iuu@defld6yydzyb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k3ymi6ipegswgeqbduotm2pwrkimkubv7imjpzxuiluhtd5iuu@defld6yydzyb>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 01:13:35PM -0800, Shakeel Butt wrote:
> On Thu, Feb 20, 2025 at 08:04:02PM +0000, Yosry Ahmed wrote:
> > On Thu, Feb 20, 2025 at 10:14:45AM -0800, JP Kobryn wrote:
> > > On 2/20/25 9:59 AM, Yosry Ahmed wrote:
> > > > On Thu, Feb 20, 2025 at 09:53:33AM -0800, Shakeel Butt wrote:
> > > > > On Thu, Feb 20, 2025 at 05:26:04PM +0000, Yosry Ahmed wrote:
> > > > > > 
> > > > > > Another question is, does it make sense to keep BPF flushing in the
> > > > > > "self" css with base stats flushing for now? IIUC BPF flushing is not
> > > > > > very popular now anyway, and doing so will remove the need to support
> > > > > > flushing and updating things that are not css's. Just food for thought.
> > > > > > 
> > > > > 
> > > > > Oh if this simplifies the code, I would say go for it.
> > > > 
> > > > I think we wouldn't need cgroup_rstat_ops and some of the refactoring
> > > > may not be needed. It will also reduce the memory overhead, and keep it
> > > > constant regardless of using BPF which is nice.
> > > 
> > > Yes, this is true. cgroup_rstat_ops was only added to allow cgroup_bpf
> > > to make use of rstat. If the bpf flushing remains tied to
> > > cgroup_subsys_state::self, then the ops interface and supporting code
> > > can be removed. Probably stating the obvious but the trade-off would be
> > > that if bpf cgroups are in use, they would account for some extra
> > > overhead while flushing the base stats. Is Google making use of bpf-
> > > based cgroups?
> > 
> > Ironically I don't know, but I don't expect the BPF flushing to be
> > expensive enough to affect this. If someone has the use case that loads
> > enough BPF programs to cause a noticeable impact, we can address it
> > then.
> > 
> > This series will still be an improvement anyway.
> 
> If no one is using the bpf+rstat infra then maybe we should rip it out.
> Do you have any concerns?

We did not end up using the BPF+rstat infra, so I have no objection over
removing that. They are kfuncs and supposedly there is no guarantee for
them hanging around.

However, looking back at the patch series [1], there were 3 main
components:
(a) cgroup_iter BPF programs support.
(b) kfunc hooks for BPF+rstat infra.
(c) Selftests.

I am not sure if there are other users for cgroup_iter for different
purposes than BPF+rstat, and I am not sure if we can remove an iterator
program type (in terms of stability).

We can drop the kfunc hooks, but they are not really a big deal imo. I
am fine either way.

If we remove (b) we can also remove the corresponding test, but not the
test for cgroup_iter as long as it stays.

[1]https://lore.kernel.org/all/20220824233117.1312810-1-haoluo@google.com/


Return-Path: <cgroups+bounces-7105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D0A65F13
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD5D3B6976
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE71F462D;
	Mon, 17 Mar 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GiaquPeV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5F1DE3B5;
	Mon, 17 Mar 2025 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243232; cv=none; b=mzk+efudhoNus19smEzFhz2zB5UhDu1dwXqYkaampDSsGgE/MfjmHvUbK9wELsSlFys47TzYNDxATdMruq6JhSJt8DOtHvqto9e1Eg6h+dz2Kg2D1SJBKyD+uo28RZP/UtkO49CMHBI2bkS5Vvz5EhGsXi3lTVLhvwUtUCynGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243232; c=relaxed/simple;
	bh=4UrGEzkEmzoSkM/fjn7XyKgiHlQMMSLunK8C6/I4oXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bKuzFDjS2crq0HMYnr80t7kG09By5V1SoopQYsCFMpQ6TPNz8Fhm+ouI1VCzB8Ij92fcCgZSTYuh55NsqiJSdvLMv/kNtYH0ygvyNK4BjSQo4j2ueIp5E6pdovnvnQfkmfIvprNgp21bmJcpvItL2i8KI1TpYmORvKJDkQO2U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GiaquPeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D81C4CEE3;
	Mon, 17 Mar 2025 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742243231;
	bh=4UrGEzkEmzoSkM/fjn7XyKgiHlQMMSLunK8C6/I4oXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GiaquPeVeNCWAt6uc6jdvHDZiz93WzrWqIl+q5V4rvijJAYhBulOuBdqIqrxnAZcc
	 1cUGxm9CDfEufEDL6EK7ZwyrH4HfwIsHk9MR+frqnOONfMEE7SJGcluH3tiK9iMaRz
	 4IHFHJI7GeXWWbOLBb0V2h/kQ3mR9LPd5uZwJjrY=
Date: Mon, 17 Mar 2025 13:27:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Vlastimil
 Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-Id: <20250317132710.fbcde1c8bb66f91f36e78c89@linux-foundation.org>
In-Reply-To: <tk35wbak4rp4cpz7khnkpwz7ortta26otktb67c5pmt3yan34z@qgyjxc44rvmp>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
	<20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
	<tk35wbak4rp4cpz7khnkpwz7ortta26otktb67c5pmt3yan34z@qgyjxc44rvmp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 08:59:20 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sat, Mar 15, 2025 at 08:57:59PM -0700, Andrew Morton wrote:
> > On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > 
> > > This is a cleanup series which is trying to simplify the memcg per-cpu
> > > stock code, particularly it tries to remove unnecessary dependencies on
> > > local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> > > optimizes the charge path by combining the charging and accounting.
> > > 
> > > This series is based on next-20250314 plus two following patches:
> > > 
> > > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> > 
> > Unfortunately the bpf tree has been making changes in the same area of
> > memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
> > stock_lock.")
> > 
> > Sigh.  We're at -rc7 and I don't think it's worth working around that
> > for a cleanup series.  So I'm inclined to just defer this series until
> > the next -rc cycle.
> > 
> > If BPF merges reasonably early in the next merge window then please
> > promptly send this along and I should be able to squeak it into
> > 6.15-rc1.
> 
> Ohh. I didn't realize that try_alloc changes are causing so much trouble.
> Sorry about that.
> 
> Andrew,
> 
> could you please instead take bpf-next.git try_alloc_pages branch
> into your tree and resolve two trivial conflicts:
> 1. https://lore.kernel.org/bpf/20250311120422.1d9a8f80@canb.auug.org.au/
> 2. https://lore.kernel.org/bpf/20250312145247.380c2aa5@canb.auug.org.au/
> There are 7 commits there.
> You can also squash Vlastimil's fix
> "Fix the flipped condition in gfpflags_allow_spinning" into 
> "Introduce try_alloc_pages" patch or keep everything as-is.
> 
> I'll drop it from bpf-next right after.
> 
> Then Shakeel can rebase/resend his set without conflicts and everything
> will be nicely ready for the merge window.
> 
> I'll defer other bpf side things to after merge window when trees converge.

Let's just leave things as they are, please.  It's only a cleanup
series and merging cleanups after -rc7 is rather dubious even without
issues such as these.



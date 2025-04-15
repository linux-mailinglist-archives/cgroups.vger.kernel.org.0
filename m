Return-Path: <cgroups+bounces-7585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4049A8A803
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB39F444C87
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC724E4C1;
	Tue, 15 Apr 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdAh6JKa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED724E4AC
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745437; cv=none; b=SpAvSHCpYdXVj4M+txsQ1idu/r32Z9iXyg+eB7CTIHsvPISffqKt9bVcvoHO8Yz5+t4QhViYTK318U/HMQ2+1I52wB4AwERn9Y0Wksm3unzpPjhtI5g0EoP4Qu9pvg3VgOg/7qcq11WXqq55LAHsyf/WmkT9baLBDxOqLTzGW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745437; c=relaxed/simple;
	bh=3fJM41hQlSy3O6CMcQPRPBH5R7jsuultqFk04SDMaKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4hYG+Mstla4usw/ozpF423kLMKt78juHKzSVsypZYMEWIAMgEXt6L1jnjP0lkNn1LjxH1i2fwcr8OCB5zXixaVPoIPUSsaAaTOm0WC45BjTmtkQFKIxnfbsI2xxBFIRqnAWdOYsKKJT+gBs0ofK3asrdVasrDpTPoNI8gppqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdAh6JKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D77FC4AF09;
	Tue, 15 Apr 2025 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744745436;
	bh=3fJM41hQlSy3O6CMcQPRPBH5R7jsuultqFk04SDMaKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdAh6JKa5mh0/MqvHlpkLuJPgooksUSw1I03/zFOSRcjE51am+cnML3xs6q4R8cix
	 p09soHyoMBtcQnxuaU/gbgRVdAFEvKbD02BKhtO444gzczGPAcXm+q56r65ycct5v/
	 jf+GkPGBv0NRO39W4mRpSOmKLUnJnjhG4rSB2y7j0aPSHXEi468LylB61yoPDpD2zE
	 t5D7YdShnUZP2dlGBKIahIJt4fIBdecR+o3WwuSaKPBnGqchGZTDgq5ngEFGMekDMC
	 zFLytQWQ25FRnDLXZfH2TzSvMtuU4JAt3vuzNUrvzoCN8aZQvbnnH6WUMyDThx2q+8
	 3wT3d947mXv8Q==
Date: Tue, 15 Apr 2025 09:30:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
	yosryahmed@google.com, hannes@cmpxchg.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <Z_6z2-qqLI7dbl8h@slm.duckdns.org>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>

On Tue, Apr 15, 2025 at 07:15:48PM +0200, Michal Koutný wrote:
> On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> ...
> >  static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
> >  		int cpu_in_loop)
> > -	__acquires(&cgroup_rstat_lock)
> > +	__acquires(lock)
> 
> Maybe
> 	__acquires(ss_rstat_lock(css->ss))
> 
> It shouldn't matter anyway but that may be more specific than a
> generic 'lock' expression [1].

I don't know whether this is a controversial opinion but I personally would
prefer to not have __acquires/__releases() notations at all. They add
unverifiable clutter and don't really add anything valuable on top of
lockdep.

Thanks.

-- 
tejun


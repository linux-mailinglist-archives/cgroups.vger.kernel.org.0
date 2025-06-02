Return-Path: <cgroups+bounces-8415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9DACBA54
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BD3176AF9
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55708224245;
	Mon,  2 Jun 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFR07+Hb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C72C326F;
	Mon,  2 Jun 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885458; cv=none; b=SvAzu/WjNc8JcBYCEIT+87AOmS8XjRYbUSnu8vIcyd7ZHr7eK+L5KUjXwg2kFDcXg1uVVZRUmXcSac+Xb7JEWfdgkXBrfQTRvzlkEHoaP3pEUwpPYhTXZpjV23flThSvYiHQ6Dyk6ad3U4LlOKNtAblCUHmz5AL7n4jRcprONrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885458; c=relaxed/simple;
	bh=53s2psCDL5SQIwqHxnGAlLY1Ue4hS4j0bbVgn0kFX2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGeo0x+L6zPcWjuUFQDPuNe+Dz23CA7w89N3BAAyThtfId1w4ueaGVc5RZ+uHeM0zpIsSoIOYue+9khVpu+jRzULYjSh39RwV9f04nRVje02iKNPChsndItVjxqbltUQRoCFJA8/zwCLJF5y+zKd/ouNew3xFG54NV72hiiHYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFR07+Hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D13C4CEEB;
	Mon,  2 Jun 2025 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748885457;
	bh=53s2psCDL5SQIwqHxnGAlLY1Ue4hS4j0bbVgn0kFX2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFR07+HbHriDHi70yRz6tfqei2FwqN4quZOTD2FbJyuwo3gJeUtxOAvC6XvfuLaH7
	 PQlfUYhOCbUIZNL/6fu6wjkdM8GW24lG8VJuOX++nf7HjKS8yfWhNNqzO91wqSeEEC
	 sAs0wEDW9p15kYc26Anl5hC3BSv4AoFKJlZR1OktJCu4a6ecvhUCeUZOK6tOXxEa+I
	 sjSpG/d2dd0u9AWSsfwkB8HyERb00gLy2xsSS2Jzlx4q3N5+Y3ki7IX6oqfmZiBj90
	 EWHtTjvyPmADqFDJMgZtywQr3cE4N+KBmD0nSqLcya0yntsKbOdmJFerJsFET1RiMV
	 ITYwZdLNkNY8A==
Date: Mon, 2 Jun 2025 07:30:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
Message-ID: <aD3f0OselwNoryP5@slm.duckdns.org>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
 <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
 <kzgswr6dlvzvcxcd6yajoqshpumus7fiwft7mmsh5vcygdc5zd@mfauedvifz7f>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kzgswr6dlvzvcxcd6yajoqshpumus7fiwft7mmsh5vcygdc5zd@mfauedvifz7f>

Hello,

On Mon, Jun 02, 2025 at 05:07:39PM +0200, Michal Koutný wrote:
> On Wed, May 14, 2025 at 12:44:44AM -0400, Tejun Heo <tj@kernel.org> wrote:
> > Other subsystems may make use of the cgroup hierarchy with the cgroup_bpf
> > support being one such example. For such a feature, it's useful to be able
> <snip>
> 
> > other uses are planned.
> <snip>
> 
> > @@ -5753,6 +5765,15 @@ static struct cgroup *cgroup_create(stru
> >  			goto out_psi_free;
> >  	}
> >  
> > +	ret = blocking_notifier_call_chain_robust(&cgroup_lifetime_notifier,
> > +						  CGROUP_LIFETIME_ONLINE,
> > +						  CGROUP_LIFETIME_OFFLINE, cgrp);
> 
> This is with cgroup_mutex taken.
> 
> Wouldn't it be more prudent to start with atomic or raw notifier chain?
> (To prevent future unwitting expansion of cgroup_mutex.)

This being primarily useful for init/exiting stuff, I think it'd be
reasonable to expect memory allocations. e.g. Even the existing BPF cgroup
support needs sleepable context for percpu_ref init and prog allocations.

If cgroup_mutex gets involved in locking dep loops, it'll light up lockdep,
so I'm not *too* worried.

Thanks.

-- 
tejun


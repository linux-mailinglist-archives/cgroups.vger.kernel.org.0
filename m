Return-Path: <cgroups+bounces-10372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DCB93A0D
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 01:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987662E0F82
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D22EE5FC;
	Mon, 22 Sep 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tiQ2QQ+/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890D4A32;
	Mon, 22 Sep 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584610; cv=none; b=e67l0iuiSuaf0Y3hU4JVbR5kf84M8mVViJ/RVrHMnlm5b3Uz+KvwMPRuCZRt1xByphFuvgdem1Gr+0EfrhcB/fvB2zDo1aOWy3SXS7TD3xhH+T0rCN2eEzDqgyHd4d1pEHFh6mXCpRyNKwjvDI0FTJ88FNivge42oaJQNevOcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584610; c=relaxed/simple;
	bh=+DoS20lbklC1Eq233nF5tfa9Kd7uyFIHyukV3z8UGtM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CNqVeBEN/kipld00bCHugINdnzqiLtojnvG6LicT4i1IY3k0v4VB9AGuFYhOqT6eXfaaXnyiCr42nsCeb4eLCAH0RNE4s4rBUInwPtudzWkXPKdEvlJfN09X5DfTpp1KZrAjD+7vge3fvnmsXtML1fjZS+7XOzhWKlDzgY+Vcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tiQ2QQ+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3CC4CEF0;
	Mon, 22 Sep 2025 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758584610;
	bh=+DoS20lbklC1Eq233nF5tfa9Kd7uyFIHyukV3z8UGtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tiQ2QQ+/tugRqJGTfepSFY1hDwW/i74IZieK5RoR+GP4YTR4Cb+1Zc4bBqSBS1N0P
	 LLnVNlvDIlQuGY+Rnz1AHWQZPuHeCjCgtjRK/zgILMh6FIAbuJ6POUDrIwljrgWgyM
	 5JdqQ24zfkvP7xBXYQ0/nsfVv9cNv1URigg1cYfc=
Date: Mon, 22 Sep 2025 16:43:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-Id: <20250922164328.0d766c95f9c15330e99514bd@linux-foundation.org>
In-Reply-To: <nzr2ztya3duztwfnpcnl2azzcdg74hjbwzzs3nxax67nsu6ffq@leycq6l5d5y2>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
	<20250922160308.524be6ba4d418886095ab223@linux-foundation.org>
	<nzr2ztya3duztwfnpcnl2azzcdg74hjbwzzs3nxax67nsu6ffq@leycq6l5d5y2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 16:22:57 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> > 
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2307,12 +2307,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  	bool drained = false;
> > >  	bool raised_max_event = false;
> > >  	unsigned long pflags;
> > > +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> > >  
> > 
> > Does this affect only the problematic call chain which you have
> > identified, or might other callers be undesirably affected?
> 
> It will only affect the call chain which can not spin due to possibly
> NMI context and at the moment only bpf programs can cause that.

"possibly" NMI context?  Is it possible that a bpf caller which could
have taken locks will now skip the notifications?  Or do the gfp_flags
get propagated all the way through?


Return-Path: <cgroups+bounces-15777-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OF7Hc4sAmq/ogEAu9opvQ
	(envelope-from <cgroups+bounces-15777-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:23:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC71515127
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C019F301AF72
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16147B425;
	Mon, 11 May 2026 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAcIB1SR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7734D2ED2;
	Mon, 11 May 2026 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527426; cv=none; b=OUhexK9nUfe8uIEBTvt5sP47YgJYKWJmKX1BH1jcXU7XVP7CM9R9fahNH9lcrwLKFYcfxOe2B6Vvh7qkIM15Dc8EWOQuP1MvKuLC0WJdlO/+2rbCGW3yxPTyOrp3+WIAFZGc/5AP9JqI8NPeiZMDUiNDeydriR63PZzkhSzxjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527426; c=relaxed/simple;
	bh=EIUsOp7Yw3j+8Z9FypyrNZ1gs/Yd0mDxCEtBIUOJKMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtuNXgGv4ggObKRsNqApCV8HpHLqkTflttMkhhDIgoYYPHnQN/UCjP0F8YW6EW0LEmd7E5aiYDD3cJwEkbVpbiLZzzscXCDtop6TrMx8tESVOFTvbTbX+o+91haTyQ0Jic50uZcN8E106MufUl5Xo78nuK8JVxm10Zuz5W9LJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAcIB1SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FDEC2BCB0;
	Mon, 11 May 2026 19:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778527426;
	bh=EIUsOp7Yw3j+8Z9FypyrNZ1gs/Yd0mDxCEtBIUOJKMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAcIB1SR717rb3c+Ptu0WOOp0zebEDt6z2jiEdXSi7zDHuYxSrkzlxy00uiy3Mhgc
	 OFC56wdpu1+mQ45PskHZT/iV2bu+z692Qq4iHRCvS0Iu0amAR5sF/8afS12gljg+WI
	 e27nLJUlqhtvzgDIQgn+tjOc3ZTjdLGAzMRgLkr0bjyUKM/cnintiB9eg3XwRkeMKQ
	 7vuXz9ig1OsIjK6IchBwcggMRmlGa9X8luEnkBZAqd1COYWso0rEJN7Ocwehpx7WYW
	 0l/MSQeEDM15HXb8OQRzeW/Tn40bBKqa0sn3zdflozhSALiWEDTCexPbSgEALKhWWw
	 y+fmA4g/nD8EQ==
Date: Mon, 11 May 2026 09:23:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <agIswZpCxlsQ2Xdk@slm.duckdns.org>
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511113104.563854162@infradead.org>
X-Rspamd-Queue-Id: 1FC71515127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15777-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello, Peter.

On Mon, May 11, 2026 at 01:31:04PM +0200, Peter Zijlstra wrote:
> So cgroup scheduling has always been a pain in the arse. The problems start
> with weight distribution and end with hierachical picks and it all sucks.
> 
> The problems with weight distribution are related to that infernal global
> fraction:
> 
>              tg->w * grq_i->w
>    ge_i->w = ----------------
>              \Sum_j grq_j->w
> 
> which we've approximated reasonably well by now. However, the immediate
> consequence of this fraction is that the total group weight (tg->w) gets
> fragmented across all your CPUs. And at 64 CPUs that means your per-cpu cgroup
> weight ends up being a nice 19 task worth. And more CPUs more tiny. Combine
> with the fact that 256 CPU systems are relatively common these days, this
> becomes painful.
> 
> The common 'solution' is to inflate the group weight by 'nr_cpus'; the
> immediate problem with that is that when all load of a group gets concentrated
> on a single CPU, the per-cpu cgroup weight becomes insanely large, easily
> exceeding nice -20.
> 
> Additionally there are numerical limits on the max weight you can have before
> the math starts suffering overflows. As such there is a definite limit on the
> total group weight. Which has annoyed people ;-)
> 
> The first few patches add a knob /debug/sched/cgroup_mode and a few different
> options on how to deal with this. My favourite is 'concur', but obviously that
> is also the most expensive one :-/ It adds a tg->tasks counter which makes the
> update_tg_load_avg() thing more expensive.

Ignoring fixed math accuracy problems, isn't the root problem here that
every thread in the root cgroup competes as if each is its own cgroup? ie.
Isn't the canonical solution here to create an enveloping group, at least
for share calculation purposes, for root threads and then assign them some
weight so that they compete in the same way that other cgroups do? Then, the
different modes go away or rather whatever the user wants can be expressed
via root's weight if that's to be made configurable.

Thanks.

-- 
tejun


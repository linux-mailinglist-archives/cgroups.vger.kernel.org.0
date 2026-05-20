Return-Path: <cgroups+bounces-16131-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MCuMK8vDmqD7wUAu9opvQ
	(envelope-from <cgroups+bounces-16131-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 00:03:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16559BA90
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 00:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8063660C78
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CEA33CEA2;
	Wed, 20 May 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmbjetki"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF33403E84;
	Wed, 20 May 2026 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302944; cv=none; b=b9AMopU0KOnVrr1ONO2m3w8Nuk2b3Y5ETEM1V+4BLgkbWF53vcKTsq1bFvQ2oxzhgjG+iHzAcgO/U1SZaY37UFLlcOJPUCBdCutnysO+xMEz8+xPrZ/jrv8dDgG+LECbj8NHQE945lA1OSm5CpYVSYYag6W1Nuu4Y6gCWOFrlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302944; c=relaxed/simple;
	bh=tYm6qIV7N1C9pbxA4KahMS0wxIAN0F0fTYD6NgR8Hwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOZjacEF5GIKFFljtw2E/bkG7uTn3F28/Bh4jrdzNGNYV3uQK3twzLUR0MHsXr4Jhge1vZZ4ZykkaqJM9T2nYZfwRd5Kbz7gnqlmUekFqPArdbFpDD6G1jdV+mjrUV1HxMfuKaUuhhERZb2tm34CJ9QoM1KxdKMGmGkLgM8EcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmbjetki; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB791F000E9;
	Wed, 20 May 2026 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302942;
	bh=Ue3/vox2FGh9UYD5VYOi7fGGp/zA5+v6297ZVYjapVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmbjetkizCdBDVjuDN8tZYK+22fH1o/WjBukyK/ruoMYCpo9bC1o7IMxWTQ9EtYr6
	 5H4sPYB4q0qmTy+qQOZlQR/PJmfAm/oRM1LZgZ6p8IZ+5gPZYZta2z5hj2gzdVf0Nh
	 FcvRhrE7MzP6yXHWLJpURn/TxW9T3pjG3iJdiOkrZa6AEhfEJneCpJIXT27iOCp7IJ
	 pXSYG0BlEH/KvEh4dOhtSTJx4WiKyyYjXl9UlH49KyDEI8rJDQ7B/8QpLZ0HY4d0zO
	 /bJTyuAjL7QZGAusKrwcete7L+snTURWFmqj3uxzuKwhz1A+zSgP8fabXLW9wLf6Ri
	 1cfrLlu4iMREA==
Date: Wed, 20 May 2026 08:49:01 -1000
From: Tejun Heo <tj@kernel.org>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: Re: [BULK] Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper
 hierarchies of RT cgroups
Message-ID: <ag4CHYXcwOXfRCBZ@slm.duckdns.org>
References: <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
 <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
 <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
 <20260514092546.4265d486@luca64>
 <8672eb9e7bbd6abde7762feb267799c5@kernel.org>
 <c51eb4b9-143d-495f-a35b-090fb688cca4@santannapisa.it>
 <agteySwOHszMVMp8@slm.duckdns.org>
 <20260519230258.0342358c@nowhere>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519230258.0342358c@nowhere>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16131-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 6D16559BA90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:02:58PM +0200, luca abeni wrote:
> On Mon, 18 May 2026 08:47:37 -1000
> Tejun Heo <tj@kernel.org> wrote:
> [...]
> > I wonder whether it can be generalized more. Would something like the
> > following work? I'm going to ignore period for the sake of simplicity
> > as it doesn't seem to affect admission decisions.
> > 
> > - There is no root cgroup.rt.max in line with other control knobs.
> 
> Well, the reason we had "rt.{runtime,period}_us" (now "rt.max") in the
> root cgroup is that RT cgroups are scheduled by dl entities (one dl
> entity per cpu), and these dl entities must be accounted for in the
> SCHED_DEADLINE admission test... The easiest way to do this is to
> reserve a fixed fraction of the CPU time to RT cgroups, leaving the
> remaining fraction to SCHED_DEADLINE tasks. And we used rt.max to
> configure the fraction of CPU time reserved for RT cgroups; do you have
> suggestions about alternative interfaces for this configuration?

I see. That makes sense. I think rt.max in the root fits the bill for that
purpose. This is different from other resources in that there's sub-division
at the root level but I think that's an inherent property here.

> > - Setting a budget is subject to admission control in both directions
> > - the budget source (the nearest budgeted ancestor, or the root pool
> > if none) should have enough to give out and the target budget should
> > be big enough to contain the actual usages and !max descendants in
> > the subtree. Going to max is always fine - the source previously gave
> > the budget out, so it has room to take everything back.
> 
> OK... Just to understand: if we consider this situation
> 	root cgroup -> G1 (50, 100) -> G2 (10, 100)
> and G1 switches to "max", what happens to G2? Does it stay (10, 100),
> or is it forced to switch to "max", too?

Stay (10, 100).

> I was thinking about enforcing that a cgroup can have runtime > 0 only
> if it is a direct child of the root cgroup, or if its parent has
> runtime > 0 and is not "max" (so, in the previous example G1 can switch
> to "max" only if G2 sets its runtime to 0). Could this be acceptable?

Interfaces which change their config values without being written to tend to
cause problems and confusions for users. So, if possible, and here it seems
the resulting behavior seems pretty consistent, better to stick with the
convention, I think.

Thanks.

-- 
tejun


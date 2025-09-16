Return-Path: <cgroups+bounces-10175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BAB7EA31
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539CA2A64D3
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442832BE7D2;
	Tue, 16 Sep 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8Uiiuss"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088B1E3DF2;
	Tue, 16 Sep 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062516; cv=none; b=bjLPePEB/HsWUNrd8wZg6H2BVjtdjxi4QspEWEeJUYh/AEMzjO87OBhvIgsqdq+OGwxVxr2yUIOdg+M7E0ulRAysz9zS5EbhspcMVuaG6J4Rq8xkRNV+YZ9zq12EXtQ8dJBZG2sLoS3T2VTJ2c73k1Yy0QjQdIcgYpNam5DocG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062516; c=relaxed/simple;
	bh=v+3wS5sLqhU0LglDjdXcdux+MerLj86GGSMD7aXW76M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP7mgpthhfxU6o5hnDRZYrBwE2sRvprWZ6jG8qfmn7mdmhAe03rPFPBJQleHd9S9/xRDHRDux0kyrRShFsc93wCb5pQQGNssd7N3JipbuSm/nZ0nt0sRi+k3TB1sSFs6F3FVC6rWJhj/Cu0sbW7OhixooiQJWYnwkWD0eWKlNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8Uiiuss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C4C4CEEB;
	Tue, 16 Sep 2025 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758062515;
	bh=v+3wS5sLqhU0LglDjdXcdux+MerLj86GGSMD7aXW76M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8UiiusskGw0mL0Usk64hbyD+MgaLSBTE7FFIDsusDUMtP3UXFM9BNd9gkqUEmDJd
	 ULMEfIVUDc6A2hVvgi/tvKByr3PH/JZhFavJ08riLO3ycr369jNGWCFjCU1PyJbrp6
	 KJvGxfkaL8CdFVv4VfBm5YU/dYoOKFQAxxUlJW/+wzwCFPqbe+QURmDhTGD+bty4HR
	 7bA3yqZ9QOqvDBYkC6l/MSRTnagsuVN3VQZ0DnG3o35kUyYyTX+wpn/QHCSI9W+sgc
	 t/ufnaFiNC9qw/BeyNYNhbZ7qeKtXCHV/K0o7rgrJY4Iwxksv5N+yOKaQS3Tp4fj7D
	 /nNH/j6lB3GXw==
Date: Tue, 16 Sep 2025 12:41:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <aMnnslT_mUfAtytN@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnk5Wcdr2q6BWqR@slm.duckdns.org>

Hello, again.

On Tue, Sep 16, 2025 at 12:29:57PM -1000, Tejun Heo wrote:
...
> Long term, I think maintaining flexibility is of higher importance for
> sched_ext than e.g. small performance improvements or even design or
> implementation aesthetics. The primary purpose is enabling trying out new,
> sometimes wild, things after all. As such, I don't think it'd be a good idea
> to put strict restrictions on how the BPF side operates unless it affects
> the ability to recover the system from a malfunctioning BPF scheduler, of
> course.

Thinking a bit more about it. I wonder the status-quo is actually an okay
balance. All in-kernel sched classes are per-CPU rich rq design, which
meshes well with the current locking scheme, for obvious reasons.

sched_ext is an oddball in that it may want to hot-migrate tasks at the last
minute because who knows what the BPF side wants to do. However, this just
boils down to having to always call balance() before any pick_task()
attempts (including DL server case). Yeah, it's a niggle, especially as
there needs to be a secondary hook to handle losing the race between
balance() and pick_task(), but it's pretty contained conceptually and not a
lot of code.

Thanks.

-- 
tejun


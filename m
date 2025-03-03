Return-Path: <cgroups+bounces-6785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DDA4CAE0
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E533A7ED1
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DF21858A;
	Mon,  3 Mar 2025 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l95/pFGx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346F1F0E5C
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025924; cv=none; b=rtO56D9ekYAvMN6g2xPR1fbYAih11dE7TX1p8u3LnPQcufgXxMftRTXjliI3FFaxWDB9KrLdfm1XL/O59n0J+RdcWPd4SZodrGCJAzQudi20rphPgZhoaz8JjfFMPhzuD/Mg2g8x5fDV1rN3al79hLGIJ0u+e0sA+li7DMD6Fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025924; c=relaxed/simple;
	bh=v2nf8hjUJxa2lBLFshXXyOm93RuOZDHUgrjnvfi1tj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP+JlXGStb/W9duaY2MeunUr9bSzgISkbt2Oeq9425et5nNQB3jaIH34cZTkvp7axaV8WvY0f9Jp/NcikXSQWYCE01bi8od2yEeL+CHzFOYDNwmjSEeoNETQSzj+/qj8xKGmM8tlhHV/ZNIErqPYdPiNVSFRz31efPUv7a7FsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l95/pFGx; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 10:18:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741025918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m21XiXDRbYhaCVEZyslTuWSdbjFHYn+/oFGQbkqyFGc=;
	b=l95/pFGxkxbLDqIZ2cVIX4HU/3uSV7rt8YP649hRQD0vB7O72eS8QKuNkb5UHQMBZhyGx8
	+1lnrWl3hkPnKy6pAkNjO2+RP6MThqTFM5nLvy0FMZi8QF1bdCD9/q1BcgJGlk2PZcAdss
	KlkDxF1xZ8ttUBD5pKECffcn5m4ksak=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <dyo5iygnln27eqo4wlgcwbuepzb55ks2ddlqg6ijyie5ugxmr5@b4mamkjocqj7>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
 <Z8IIxUdRpqxZyIHO@google.com>
 <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
 <Z8Jh7-lN_qltU7WD@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Jh7-lN_qltU7WD@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 01, 2025 at 01:25:03AM +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 05:06:23PM -0800, JP Kobryn wrote:
[...]
> > > 
> > > We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
> > > Otherwise we will call BPF rstat flush whenever any subsystem is
> > > flushed.
> > > 
> > > I guess it's because BPF can now pass any subsystem to
> > > cgroup_rstat_flush(), and we don't keep track. I think it would be
> > > better if we do not allow BPF programs to select a css and always make
> > > them flush the self css.
> > > 
> > > We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
> > > in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().
> > 
> > I'm fine with this if others are in agreement. A similar concept was
> > done in v1.
> 
> Let's wait for Shakeel to chime in here since he suggested removing this
> hook, but I am not sure if he intended to actually do it or not. Better
> not to waste effort if this will be gone soon anyway.
> 

Yes, let's remove this unused hook. JP, can you please followup after
this series with the removal/deprecation of this? One thing we might
want to careful about is if in future someone to add this functionality
again, that would not be a clean revert but what Yosry is asking for.


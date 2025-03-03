Return-Path: <cgroups+bounces-6786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC0A4CAE8
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19E53AC1B3
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10722CBE2;
	Mon,  3 Mar 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/ex8bVt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D62215058
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026117; cv=none; b=eh/eXRYb40vX5/DUrnlwWOheDqAtpcrCGMjSw5Wvb+RqWdmDAoBwY9YM5RIy74SxrHaCdv38JudD0UjfAnhvx079KT3FnZLC8jWO853Ha8lyQK2qdC/luC2BPb1D8HThzbxJ2/Ko5IIu2bByhOend9SRbtT08XHGfca3nNV84Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026117; c=relaxed/simple;
	bh=CeeOL45fCvVDi/JOUqfpLi4OcHC9aYrKhZG7suQLoKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJHiDxEeJq7REd053FZ8lS81IeYaEkOx10WhO5AWhmgvPswRC0VfgEoo3tES9CocDvSEuWEvNcvoPrF89bnssk9NwgGaZwNZcGGpdWAzfyfeOBKuxcVVK8Uocwj5F7I4ezPIO8mfCJvVeu5x91geHzjxLgKzrW/TQ4IlhLjJMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/ex8bVt; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 18:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741026113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfwPovpnDWwilLI8Gz0j1a2BVUrt/eXRIGTn4rbL9+I=;
	b=N/ex8bVtuJRm8IillGYO7NkQCJtbPmfUZqBFbgw6VnhG9lLoza4w6IGgAHInVaGT52PJP5
	D8U0Nx8evR0c71uChoJ+A8DRlsWVI4nxpLRD8OSx6OH7QY0qTl5exGy0aprvTi47l0rEES
	VqWdznhr28GCJHchUJUg/0hZLV0TTd4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <Z8XzO-4-AI9ftuNg@google.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
 <Z8IIxUdRpqxZyIHO@google.com>
 <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
 <Z8Jh7-lN_qltU7WD@google.com>
 <dyo5iygnln27eqo4wlgcwbuepzb55ks2ddlqg6ijyie5ugxmr5@b4mamkjocqj7>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dyo5iygnln27eqo4wlgcwbuepzb55ks2ddlqg6ijyie5ugxmr5@b4mamkjocqj7>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 10:18:33AM -0800, Shakeel Butt wrote:
> On Sat, Mar 01, 2025 at 01:25:03AM +0000, Yosry Ahmed wrote:
> > On Fri, Feb 28, 2025 at 05:06:23PM -0800, JP Kobryn wrote:
> [...]
> > > > 
> > > > We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
> > > > Otherwise we will call BPF rstat flush whenever any subsystem is
> > > > flushed.
> > > > 
> > > > I guess it's because BPF can now pass any subsystem to
> > > > cgroup_rstat_flush(), and we don't keep track. I think it would be
> > > > better if we do not allow BPF programs to select a css and always make
> > > > them flush the self css.
> > > > 
> > > > We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
> > > > in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().
> > > 
> > > I'm fine with this if others are in agreement. A similar concept was
> > > done in v1.
> > 
> > Let's wait for Shakeel to chime in here since he suggested removing this
> > hook, but I am not sure if he intended to actually do it or not. Better
> > not to waste effort if this will be gone soon anyway.
> > 
> 
> Yes, let's remove this unused hook. JP, can you please followup after
> this series with the removal/deprecation of this?

In this case I think it's fine for the purpose of this series to keep
bpf_rstat_flush() called if any css is being flushed to keep things
simple.

> One thing we might want to careful about is if in future someone to
> add this functionality again, that would not be a clean revert but
> what Yosry is asking for.

Not sure what you mean here, I am not asking for anything :P



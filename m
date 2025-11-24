Return-Path: <cgroups+bounces-12171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A7C7EF7A
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 05:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8F9A34516C
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741C296BAF;
	Mon, 24 Nov 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wy5F5wHs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E52339A8
	for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763960152; cv=none; b=uMTDzTojBR/AYqpMOJCjcOdNgKhwD6V+pDjd5VrUmuH/NSlj9zv8ev+ZKhibyWKstDixwS+VcOkkTD9LbT7lkOHzK+hdwawylV4BrHzxZpjrxJOB0BqHOfOOWOTYe1MwDa58cwzsW+Kai9qYQ/Wyxtu+2tbwii9nnSm4CxSyekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763960152; c=relaxed/simple;
	bh=g+MDlDSmvaXMF2x9vDPe8mIUdY31s+JVbH03cj92ER4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m14VZO9JIQIMA7RUWeM7UNZsZZzg7LaWS2fLjoS6xqhUCLWUSMs0kV2H/a1Uflr73F/HIw8TnfzdYTN16/1L8pQb0pv3HE6TFM3cU7sKzM5ES7KtyVLJN6CHRJVg4ohNWndZltI+gDVLTAj0Kp6M1A6/e3XFPuypYeQe2RulvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wy5F5wHs; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 23 Nov 2025 20:54:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763960147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxhlEdSEHdHOGPwX9Rd5ElFRPZ5WhOP119VyzjRw36w=;
	b=Wy5F5wHsWv8jgeYuZZp/jQmV4MijG1VKDd2BecJacYEMUoNGbe55ZvWXsVOfiJK376RLd2
	War2h4I8aGgacLjGDXn2OB23ycA6XrCb7GCQkNzUYX/eflbHf1saG5snkC9zIvdjhg0uSK
	f1qwQzAG7MMamYtF7gbDJuQNg+4MA1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Waiman Long <llong@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, cgroups@vger.kernel.org, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Add preemption protection to
 css_rstat_updated()
Message-ID: <fmey2ektwdk7l5aktjz3xb24x3pk3lxy3gfld7reazal6xa6u2@tmryedehqhql>
References: <20251121040655.89584-1-jiayuan.chen@linux.dev>
 <6cd2dc59-e647-411f-ba3e-2a741487abb8@redhat.com>
 <305559b6e8249a31ccbe1fe77fd3a3c041872c4b@linux.dev>
 <0bcbe776-de46-42eb-8d98-e4067052b1df@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcbe776-de46-42eb-8d98-e4067052b1df@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 21, 2025 at 10:47:47AM -0500, Waiman Long wrote:
> 
> On 11/21/25 1:21 AM, Jiayuan Chen wrote:
> > November 21, 2025 at 13:07, "Waiman Long" <llong@redhat.com mailto:llong@redhat.com?to=%22Waiman%20Long%22%20%3Cllong%40redhat.com%3E > wrote:
> > 
> > 
> > > On 11/20/25 11:06 PM, Jiayuan Chen wrote:
> > > 
> > > > BPF programs do not disable preemption, they only disable migration.
> > > >   Therefore, when running the cgroup_hierarchical_stats selftest, a
> > > >   warning [1] is generated.
> > > > 
> > > >   The css_rstat_updated() function is lockless and reentrant. However,
> > > >   as Tejun pointed out [2], preemption-related considerations need to
> > > >   be considered. Since css_rstat_updated() can be called from BPF where
> > > >   preemption is not disabled by its framework and it has already been
> > > >   exposed as a kfunc to BPF programs, introducing a new kfunc like bpf_xx
> > > >   will break existing uses. Thus, we directly make css_rstat_updated()
> > > >   preempt-safe here.
> > > > 
> > > My understand of Tejun's comment is to add bpf_preempt_disable() and bpf_preempt_enable() calls around the css_rstat_updated() call in the bpf program defined in tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c instead of adding that in the css_rstat_updated() function itself. But I may be wrong.
> > > 
> > > Cheers, Longman
> > > 
> > If that's really the case, then I'd rather add a new wrapper kfunc for BPF
> > to replace css_rstat_updated(). Otherwise, whether it gets triggered would
> > depend entirely on users behavior.
> > 
> > Right now, this WARNING is showing up in all BPF selftests. Although it's not
> > treated as an error that fails the tests,it's visible in the action runs:
> > https://github.com/kernel-patches/bpf/actions
> 
> All the existing callers of css_rstat_updated() except the bpf selftest has
> preemption disabled. So it doesn't make sense to impose a cost (though
> small) on kernel code that are in production kernel in order to make a
> selftest pass with no change.

+1. Please fix the bpf selftests to disable preemption before calling
this function.

For the long term, why not make the bpf verifier fails the bpf programs
if they don't disable preemption before calling such functions?


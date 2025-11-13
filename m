Return-Path: <cgroups+bounces-11921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86330C561E5
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 08:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86F0D346609
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3D2F7AAC;
	Thu, 13 Nov 2025 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zO7Kb6H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="raNwaiay"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0932ED5C;
	Thu, 13 Nov 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020440; cv=none; b=aEhEUoe9t22MYjT7b9yqGLwHjsdI6BO+hATiv66Bvu5Kp4Beryh366b2FzdeoJ3EfrAK+DT0Y6tFX9AWfJCuHcWauEUfds/WyfvGNxa0cpk9z10IuCrf6JFe+d0wx86FmkS09rhhBEhUNoFflxwmNBiJdVn9nWexxo4grrJFbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020440; c=relaxed/simple;
	bh=j9SVr6gZ60YqOjZOAhosgYpfqSz/7BFA8DxTHq+L4tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbIMTo9QGsX8QN+so1b7RhMrjb3/46w2uUAhu+weFNijPfdcVsjEg8zssT6zh/+AHD1fV9XPYKjOBShAodDRKy+MM393e3yKHKA2UNTE6GXq182gxf9FxMpv8P66SkxJ9dqoh9shdhVzSfv4PBTpQyaWqL818sYPmREq1iOprSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zO7Kb6H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=raNwaiay; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 08:53:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763020437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9YbaZNB6x8UhGDqOj74UHtc/rqj9lXFJRRsaQbnDCw=;
	b=2zO7Kb6HllX554b6pUsVqHO0rUe9ua4tWkp4cK9BO8vn8OK1s+tGBElX/Bhn3zidHXkfJ4
	xD+DpjpOY27DFfBLxMFbuaTKocuyNYs6YIBgQwFW3P65/mUluYGSjLWJTue1ZCRbbbgdJW
	TWjtGm7deXCaCm76ptuBIoFsgn2NG3MTxOBdWuVqjf9rA/g0z7XafOghOectSX81xOi8/E
	3W3YauTQarxXnCDCgDfK+JjIARy6y+7KWyP64qKPIRRrUrE2UqoLs4dnAHJJXgJo1j9YCk
	Tfu6ObBoO/FMK2s2AmWD3hE4B+kRwaCb6UOk7lTFZQWwwlYuJSFz53jLA39opA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763020437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9YbaZNB6x8UhGDqOj74UHtc/rqj9lXFJRRsaQbnDCw=;
	b=raNwaiay/WDYcuDyZjmAJKAG+em+dPgaUf56xUw++Lwr1hE6ua6GLEtchyivq9/pTJri/f
	4HrDxfMebv/0qoAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>, Pingfan Liu <piliu@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
Message-ID: <20251113075356.Ix4N-p8X@linutronix.de>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
 <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>

On 2025-11-12 13:21:12 [-0500], Waiman Long wrote:
> On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
> > On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
> > > The callback_lock is a spinlock_t which is acquired either to read
> > > a stable set of cpu or node masks or to modify those masks when
> > > cpuset_mutex is also acquired. Sometime it may need to go up the
> > > cgroup hierarchy while holding the lock to find the right set of masks
> > > to use. Assuming that the depth of the cgroup hierarch is finite and
> > > typically small, the lock hold time should be limited.
> > We can't assume that, can we?
> We can theoretically create a cgroup hierarchy with many levels, but no sane
> users will actually do that. If this is a concern to you, I can certainly
> drop this patch.

Someone will think this is sane and will wonder. We usually don't impose
limits but make sure things are preemptible so it does not matter.

> > > Some externally callable cpuset APIs like cpuset_cpus_allowed() and
> > cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
> > GFP_KERNEL shortly before invoking the function in question.
> The current callers of these APIs are fine. What I am talking is about new
> callers that may want to call them when holding a raw_spinlock_t.

No, please don't proactive do these changes like this which are not
fixes because something was/ is broken.

> > > cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
> > This I did not find. But I would ask to rework it somehow that we don't
> > need to use raw_spinlock_t as a hammer that solves it all.
> 
> OK.
> 
> Cheers,
> Longman

Sebastian


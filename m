Return-Path: <cgroups+bounces-5525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977D9C6A24
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C516C1F233EE
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F3187FFE;
	Wed, 13 Nov 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vR0Exdph";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYZRSO9B"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4118562F;
	Wed, 13 Nov 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483816; cv=none; b=G6SQgBJ4OAmUhoDIy2F0NenaD3LRjD6imHuRkE+NH3sMw24JaccZHE3ONPaH4lVFtH+UMjTkbm0tY3wF5SpCeDibq3Fq4T2bxp6pljXNS11/OS1usUhJeNzzcCweHLkpzH07Hb26Ifukl6ld5gbe85kcalnG9+CykM5gSFKpJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483816; c=relaxed/simple;
	bh=gOzxbja1h0Cm/H7HDPWdN71wH6R+7/1anE9j/1nrggE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEq0QWptndoEirHmAYeqm49eeHuU7+UNuFELQlSHQOVjU5zIsaeTsr6IB3WPGQpa9iRR7nzLPLgy9+P6516whwuJ903BfiyUXVHfN5pGt+aHY1hdec5sOe6JG/4dnqKldzGAPmAYac5DKY623y9MZWOd5bgykpW5bOXFJ9VYj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vR0Exdph; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYZRSO9B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 08:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731483812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2xBw8AhtgFav+/ydFIrYTIjPzumO/Kz5l3wKp5ysb4=;
	b=vR0Exdph5STsPXHLwsm+5yHFKhdxsjMunul6TtgnVsusyfgRmYm3aA9UbJqIwS2dPy1voR
	rk4G77/5na475MpCg6/I2UT8hLpyVzgrGbm5IBHK7ZhoSjy6/Ckf6R1pcISZYcpGiFU/IF
	n6kLLP8U/UA78Q/xufKzcfcH31Nj2JJQ2QYWxtICaITdAAieMCmhvaQSjvjDWz5G/RDVrY
	5EnjC8POMc4tdeLhDHF0xbaML5ZO3BVmTDS2kdCPGzTRl9fhZPkuD9HnVCL2VoM4783n12
	e7hTJa0tbcTsPbk5Mk1CWzfrCzsXjfmpnBaqV197xoN9+aNH7njklhqMvQT6MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731483812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2xBw8AhtgFav+/ydFIrYTIjPzumO/Kz5l3wKp5ysb4=;
	b=yYZRSO9BkmMhNqcDc/BkLydQH6hcGlV093QEGS/Wy9e4HPIc+3MBX9FfJW/abX2SmdT6iL
	8mSHPVkavcen82BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface
 for name lookups
Message-ID: <20241113074331.B48iqBgp@linutronix.de>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-3-bigeasy@linutronix.de>
 <ZzOlhANLYxFaIix2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzOlhANLYxFaIix2@slm.duckdns.org>

On 2024-11-12 08:59:16 [-1000], Tejun Heo wrote:
> Hello,

Hi,

> On Tue, Nov 12, 2024 at 04:52:39PM +0100, Sebastian Andrzej Siewior wrote:
> ...
> >  /**
> > - * pr_cont_kernfs_name - pr_cont name of a kernfs_node
> > + * pr_cont_kernfs_name_rcu - pr_cont name of a kernfs_node
> >   * @kn: kernfs_node of interest
> >   *
> > - * This function can be called from any context.
> > + * This function can be called from any context. The root node must be with
> > + * KERNFS_ROOT_SAME_PARENT.
> >   */
> > -void pr_cont_kernfs_name(struct kernfs_node *kn)
> > +void pr_cont_kernfs_name_rcu(struct kernfs_node *kn)
> 
> Having to split the interface all the way up isn't great. While there are
> also downsides, I wonder whether a better approach here is just making the
> backend function (kernfs_path_from_node()) automatically use RCU locking if
> the flag is set rather than propagating the difference by splitting the
> interface. The distinction doesn't mean anything to most users after all.

Indeed.

> Thanks.
> 

Sebastian


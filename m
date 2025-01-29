Return-Path: <cgroups+bounces-6373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10643A21EF1
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 15:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF27A2244
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32BA19DF60;
	Wed, 29 Jan 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYV60cgt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjXRex17"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8B2114;
	Wed, 29 Jan 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160499; cv=none; b=fC6ITnBLQHUqde6rDjWiqnwo/AJVdxRlMZrwtUl9dMEpC1z4pbR4HFNDOdnjPnRo+wB8FXfnCZqX6FWIySytHLt/6VPGK8nwyOOLNSK2/ab0R5zeXX3PgfSyFr3VJOIh/zNGkmGzJLJ+uesHg/+lP3g+yCGqGyv0iuaKP2nOhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160499; c=relaxed/simple;
	bh=RrEyFYnFPk6dH1vxpzdDHqwIn4xivJr+Pn4WbQ58yCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odewlW8kXoIShUXxT9jhvGDJQPyS3sSsydhO4jnKn1dM14kDZdZ4/ZIZzqRLJ/HE3954/itjwOURCUplwUK+Nv/rJDBCRjjLtqIxe/AHTfgiYJobJIDM5Q5jbWRoj5IZk/3iN36h7PWX5UCHTJbsMrRNa+Z2Rn6QIVIwFZGUyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYV60cgt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjXRex17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 15:21:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738160496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xf3JToPCV95tygJWLPVHCA8LnDbsKmY68/DAjDgIDj8=;
	b=cYV60cgteY5EOu75GkjoU7BRDOVXm5SXUMTw962t+UGj/Wz6sKv9diJ4/7CGMDBU48sqkK
	xZAPrzEscXZw/2Mb0IIuWUhmAtL1Ftm2HZ2CKbXDLpbe0+nZW+RoCVW9k4/VlAcBKiF+aJ
	VR4c6Vc8g4Gu/vLxmMQrEt9aOvy8QScK65c+CVlxwwTFIhTxEvhinmgy+MGrcw5bRLEy5V
	ltXTjLqMsosqX5LxClQ1VcQBLYffHYnWotwc8eXejORMQ80cJbWnMTNAzBfr1xvBIGf2w7
	DqgHFK0AbIAeBYZL/4Y5GBvmN7UY1Ompf/ljCx/ntTNw4o9yiX6lY7Wglynpog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738160496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xf3JToPCV95tygJWLPVHCA8LnDbsKmY68/DAjDgIDj8=;
	b=zjXRex17Cp5wD9smDv2z4XkwdZm+Xp/b4Qj5mEIxFsSJSjFd616IxiayDSclX8kGsrDkEK
	ZYGuNmGhSWww9tCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 6/6] kernfs: Use RCU to access kernfs_node::name.
Message-ID: <20250129142134.VTa3D3xT@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-7-bigeasy@linutronix.de>
 <Z5lAqVmFkMoFACae@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5lAqVmFkMoFACae@slm.duckdns.org>

On 2025-01-28 10:40:09 [-1000], Tejun Heo wrote:
> On Tue, Jan 28, 2025 at 09:42:26AM +0100, Sebastian Andrzej Siewior wrote:
> > Using RCU lifetime rules to access kernfs_node::name can avoid the
> > trouble kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
> > if the fs was created with KERNFS_ROOT_INVARIANT_PARENT. This is useful
> > as it allows to implement kernfs_path_from_node() only with RCU
> > protection and avoiding kernfs_rename_lock. The lock is only required if
> > the __parent node can be changed and the function requires an unchanged
> > hierarchy while it iterates from the node to its parent.
> 
> A short mention of how avoiding kernfs_rename_lock matters would be great -
> ie. where did this show up?

I extended it:
| Using RCU lifetime rules to access kernfs_node::name can avoid the
| trouble with kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
| if the fs was created with KERNFS_ROOT_INVARIANT_PARENT. This is usefull
| as it allows to implement kernfs_path_from_node() only with RCU
| protection and avoiding kernfs_rename_lock. The lock is only required if
| the __parent node can be changed and the function requires an unchanged
| hierarchy while it iterates from the node to its parent.
starting here->
| The change is needed to allow the lookup of the node's path
| (kernfs_path_from_node()) from context which runs always with disabled
| preemption and or interrutps even on PREEMPT_RT. The problem is that
| kernfs_rename_lock becomes a sleeping lock on PREEMPT_RT.

Sebastian


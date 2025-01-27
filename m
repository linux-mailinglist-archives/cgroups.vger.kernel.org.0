Return-Path: <cgroups+bounces-6332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D530DA1D27B
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 09:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F43B3A4FF4
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65EA1FC0E9;
	Mon, 27 Jan 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0lWQJj+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EefzurL9"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F98C11;
	Mon, 27 Jan 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737967371; cv=none; b=pZKHau+t6DdgEzXxxM3AWjwAhNFgtQ35J8ESjZ4cnumfZDd58189fc1lHEtTxnOPR9YZesExah/BKRARjwsTusujTTNChUb9oYTlGwUjDVpK1n5WC2el3ggzh4g6v1JReIDmnME1RmyraWX485oF2aiMYuMv2UbabFehB/GfSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737967371; c=relaxed/simple;
	bh=PHI5/nUAjSBckvWTaHEprVXa6IRTpNZ1WCDsW4lWNbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5MRuXjr8YqMPNRRBZQnosF/S7ZQzdfB9ogWZE5YWFAF2OON/fBnIEyFV1a+r3NJFA9f0CY7grS9Ibdp7rcOO5Npua4T+x9kA1Kf+inDeLvowI7TC9q8r8baqKjBN1O6SQpgg5mQQwsv02EinE/vuIthp2DbbwdL6sJ+kwK+wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0lWQJj+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EefzurL9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 09:42:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737967361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsZM7RL30tiHXSY3Sm/+buHB/ZIR6E53wZ1S84YBqfQ=;
	b=m0lWQJj+PTuE+WpoWlWpEvlN/xfCMGpzhxE15DXzdZIUupV7p0Cpa1utbmhsqyQeRA1vND
	yCHCcv9Wp9oOdgeI7Lb2zUQIt1/PIXVibLwLn4PzpDrHtuVptkT2mjz3kqvaqcdAVmuMAz
	pA+8K/RFarpfoRFeyqrgH8cE2SwTyEXXaRbRq1PwdHtq6Bha4EQOr211GDYB76LIs/o3xQ
	ap65cH/dDBBIySyKq4b2mnF8oJleBwGbuow3srBjZ9EB7/JM2y5Lqtnq7koKYubiwVUIIg
	DP1z3goEAkbYcJFyAaiNSzYI+be7+SXhAqthRs0mdsGjsKmadFz0wAVt0E4zuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737967361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsZM7RL30tiHXSY3Sm/+buHB/ZIR6E53wZ1S84YBqfQ=;
	b=EefzurL9cGU+vbaCgN+tn54mvhZrvLhhZEYCAHcpwbtO6qv2VAGV4+dfzxOqjiw5Pp4Svy
	/KZJ9JpkGhJKFZCg==
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
	tglx@linutronix.de
Subject: Re: [PATCH v4 2/6] kernfs: Acquire kernfs_rwsem in
 kernfs_get_parent_dentry().
Message-ID: <20250127084240.yVlHRIoh@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-3-bigeasy@linutronix.de>
 <Z5QeFgyBrxKxE-sg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5QeFgyBrxKxE-sg@slm.duckdns.org>

On 2025-01-24 13:11:18 [-1000], Tejun Heo wrote:
> On Fri, Jan 24, 2025 at 06:46:10PM +0100, Sebastian Andrzej Siewior wrote:
> > kernfs_get_parent_dentry() passes kernfs_node::parent to
> > kernfs_get_inode().
> > 
> > Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
> > replaced during the operation.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This looks fine but wouldn't it be better to use kernfs_rename_lock instead?

iget_locked() has wait_on_inode()/ alloc_inode() so this looks not
compatible with IRQ off.

> Acked-by: Tejun Heo <tj@kernel.org>

Sebastian


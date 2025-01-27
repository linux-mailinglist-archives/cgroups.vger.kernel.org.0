Return-Path: <cgroups+bounces-6333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248BA1D2DC
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 10:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D94169FC2
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A01FC7CE;
	Mon, 27 Jan 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTeaW4J1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHJBnT5/"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84302148314;
	Mon, 27 Jan 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968525; cv=none; b=iz1PkUykUjX6xTHfqegYbeJqhcGXvkpgoBYN4819VbvXlrQeJC1w7lC1VDj1ejAXTm1pb1AkIUzyNXAtiOXfZtht+9zJdMrG4yfWbngCsr/V8DhcyNs7DFVDsgE89ZS9qRhpPMVV42MSkLUb3tt0/DMUbey8fwJo1SOxSbC9dUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968525; c=relaxed/simple;
	bh=wGIAyUDlP68a9V8kGMEz/kb4QiQcc8B6lLNvp2oApoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWobJ7nDAzM13qY+7MqzpB4vUqIL3cM31Gg4aGjZ/elWxpLwykq/Mq8hLzK1Lmv17XGaTJkREWCNoIdoeflBR2ceEjF/PceEsWee1hucO4xyoTeWGsGLKaHFDBYt2T58hY7ueMSQUEEGmKOLe629tJAidNo2jTXvQPxqbUO3yUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTeaW4J1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHJBnT5/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 10:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737968521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35T26Wko58It2KcJdByAxgWpSWWt2OleR/28bTT7QAI=;
	b=hTeaW4J1pSelUkrNImhe97NXwVIBfBJNwMmTEDC0HJoQFRqUS61tHeFD+7DjwSpDUs/QrQ
	1uYJC4rq3fFVZUE20hL+3OLtfPRQwYp+KHT2u7k7m8bS7PjRLxML+j8P85C2KgVS0/OJDa
	kRJjnjd13fKr5/XOIa5C8fPy9/inN3QbU9yXJDE4UIbQ85Qhj2fCmqHoDyoYoUtiARCX5x
	vzF5Pe6YvedGUUQThc27ddttv1PhAC8b8fNfmsuqvlqV6TMvB6sfNESuWeJyJuS+rsKNzF
	4E1tJxTy5UqqTThpd4prKQZqFRIV/jdxYE3GcDwsBZDk3TbWRUSe5/340Xl+RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737968521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35T26Wko58It2KcJdByAxgWpSWWt2OleR/28bTT7QAI=;
	b=vHJBnT5/wsOrrUdIqCRk2xqVA9kZVJyWGxRlMJql901HZVKY6loBhnnHVkSZK9UlaCneKP
	mMbpvtSaHwbzGBCw==
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
Subject: Re: [PATCH v4 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem
 in kernfs_fop_readdir().
Message-ID: <20250127090200.lEQ2Igag@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-5-bigeasy@linutronix.de>
 <Z5QfFLaywTAdmHoh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5QfFLaywTAdmHoh@slm.duckdns.org>

On 2025-01-24 13:15:32 [-1000], Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 24, 2025 at 06:46:12PM +0100, Sebastian Andrzej Siewior wrote:
> ...
> > to avoid holding a global lock during a page fault. The lock drop is
> > wrong since the support of renames and not a big burden since the lock
> > is no longer global.
> 
> It's still a pretty big lock. Hopefully, at least name accesses can be
> converted to rcu protected ones later?

Not sure what you mean by "rcu protected ones". The name is already RCU
protected which is part of the problem :P
Assuming an upper length of name to be around 255 and
kernfs_fop_readdir() to be very early on the chain then we could copy
the name on stack within the RCU section and do this without
::kernfs_rwsem.

> > Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
> > userpace buffer.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.

Sebastian


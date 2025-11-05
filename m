Return-Path: <cgroups+bounces-11585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45EC343A4
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 08:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A284C3B18DB
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E77263F2D;
	Wed,  5 Nov 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cetZ937Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TpiwtHB4"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382762D29C7;
	Wed,  5 Nov 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327816; cv=none; b=V6cHAFspnDAUMKRwJUDEShZ0NnjXRkbGDSHvYgD4p60iBej1s7DvTp9rteTDbB74V4dCuQDZPlJxwdBy9faC5CL2ZF9xs8tYfUPo34iE/bwAb3pU97jdykI4ic8br3bv30Ljij4CUdMs4Hq+yCcpPCFWSi3AfdN001rABYaxxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327816; c=relaxed/simple;
	bh=chTw+LpiOGjYdo4Dxby9RmEuoAMPaIOeui44U2SXPjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMlWBZXT7Srffv2wJQ8pCIB0Xi6ZVoWxqGUvSnNTYYXcmFYyJnKPlyU5e+92Rs/5tqNQdh+RBTqa1On5OzYr8T+qx6yUm21ohLKog0+idYaQnaFvWzJ3zmEbPAWYnECNWsqRyz7dU4pDuVcb0wCWTwpYGMWkyHsZHNaseiPn6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cetZ937Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TpiwtHB4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 08:30:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762327811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFwDVirdylZN+Hz9nkWGRGtXI8gouerdCpyob/WuMPY=;
	b=cetZ937YrEk1ON6pjIZaO76yfbTHCEfY3gPXuH1Lf77FGtwS+YcEtUnSuW8QgDxuAV8vev
	kSIB1kqmRkBgz47jWTL6WjvdQbGbzZhuFuGcao/9162eIe6r4VwpKhaFFEvyuVdqOjwfIM
	iEeYDi+AwnA38HC13zUHL2o+U5wrqSFxmymW7i0xDS8Tw1B7H4dB5sAPIpJCowCEKxMcuk
	xqtd1G1WCzwGGwG0ji+AnNbFbSvG67OO4CZKQymUUUcN9aOOQYQ7iJ6W8O2HPWz3qJxV2h
	nQ70f9WQ8tgRLuRABd05QVEkfWMJuWiqZbUi1bg0PCepVdlkcZpwxfv+gTbusA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762327811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFwDVirdylZN+Hz9nkWGRGtXI8gouerdCpyob/WuMPY=;
	b=TpiwtHB4F5Cl5wZcA2JMv/0m9nBrt8ZqYA8ORwOzpivaS1pycfIcXe0giusrSUcIzhdBnT
	+xwZYIoXhyV9qADw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.19 1/2] cgroup: Convert css_set_lock from
 spinlock_t to raw_spinlock_t
Message-ID: <20251105073009.xNtOAM_u@linutronix.de>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>

On 2025-11-04 09:32:24 [-1000], Tejun Heo wrote:
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -208,9 +208,9 @@ static inline void put_css_set(struct cs
>  	if (refcount_dec_not_one(&cset->refcount))
>  		return;
>  
> -	spin_lock_irqsave(&css_set_lock, flags);
> +	raw_spin_lock_irqsave(&css_set_lock, flags);
>  	put_css_set_locked(cset);

This one has a kfree(link) and kfree takes spinlock_t so not working.

> -	spin_unlock_irqrestore(&css_set_lock, flags);
> +	raw_spin_unlock_irqrestore(&css_set_lock, flags);
>  }

>  /*
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1272,7 +1274,7 @@ static struct css_set *find_css_set(stru
>  	 * find_existing_css_set() */
>  	memcpy(cset->subsys, template, sizeof(cset->subsys));
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	/* Add reference counts and links from the new css_set. */
>  	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
>  		struct cgroup *c = link->cgrp;

I am also a bit worried about all these list iterations which happen
under the lock. There is no upper limit meaning the list can grow with
limits affecting the time the lock is held.

Sebastian


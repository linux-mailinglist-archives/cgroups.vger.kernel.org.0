Return-Path: <cgroups+bounces-6339-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C21A1DA60
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CEE1886D26
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD5145B3E;
	Mon, 27 Jan 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/1FTdke";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKmjTrp6"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05217C79;
	Mon, 27 Jan 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994664; cv=none; b=OqzZ3qqf2BmGk8aUHkLfTiQ8H9BM7eK229Vg7JznQas2iTcNVMktlRfh0Iw1azcdsK1QTwhN7RYzv7FpCT/ekdUWxkY9jdf6jjaB4DylMNvbppWWi0IHA3lCqAXmg2hB5meMTP83gk1a4VhDk8lpmnaf3sigivuFKNVkpDnHQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994664; c=relaxed/simple;
	bh=MjJIwhzLFBnsmSdJRy1FTFhf+7/5sKlAePOlkNvO8qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQki7ES3OZtvsUPjExEUw9DWH8lNiyjirIk0ZObO3i0nKMK19yYUDNvy+Gtls52pBEiOmN93uYxaAmZlzH5IY8l88Ok39srsfplnEK2H3rSqbfp0pUqQEtHEMYM3bJnbGxooVeFbKrOfql3wFfJw37XPjBTqbSyUJuD0gsq2b/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/1FTdke; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKmjTrp6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 17:17:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737994658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYntetX13SL2Hdh2wwZWAx+NC+Rq/z8cAG6n5aVCnoc=;
	b=t/1FTdkerD/lz95qvjFMRr1OwW5i3XkGAYG7dM+5qUqTXuigQM6NO8+YCAMCaAJecWV7Ij
	I9TzuXfx3+IFjHG9FKYVWzeo5xQD3dXW9en2RVcjwJXTaQhfbB6gVTAcDaZFkdW2npQIJq
	VMQktmJPu3bdfuwYgYYopmTRfzoIoixj452j1FmRxnqdFLTQT3ibHZ7A9ihsPjpclcFbFI
	P9ow/cdXjvMtcp61vKa+u8dIhCtpYc7CmpSUPrN6e5oh+u4k99JyyM5mo4lMi5rMR4D1+w
	kUL2E1w4d+sOUcSzuiktYWeadckXXT94S+N7ZMCann+YlqoSPanIhO58glGWMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737994658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYntetX13SL2Hdh2wwZWAx+NC+Rq/z8cAG6n5aVCnoc=;
	b=xKmjTrp6aNJtyEvOPPuh0+XglefAAi4+qEVQKvBgYtOLpmVQYh2lX/XVW1ob0vojy/WYho
	0QRN2lpnccgDWGBg==
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
Subject: Re: [PATCH v4 6/6] kernfs: Use RCU to access kernfs_node::name.
Message-ID: <20250127161736.6aq3z3KP@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-7-bigeasy@linutronix.de>
 <Z5QlHcCErrALjWfG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5QlHcCErrALjWfG@slm.duckdns.org>

On 2025-01-24 13:41:17 [-1000], Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 24, 2025 at 06:46:14PM +0100, Sebastian Andrzej Siewior wrote:
> > Using RCU lifetime rules to access kernfs_node::name can avoid the
> > trouble kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
> > if the fs was created with KERNFS_ROOT_INVARIANT_PARENT.
> 
> Maybe explain why we want to do this?
> 
> > +static inline const char *kernfs_rcu_get_name(const struct kernfs_node *kn)
> > +{
> > +	return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
> > +}
> 
> Can you drop "get" from the accessors? Other accessors don't have it and it
> gets confusing with reference counting operations.

Sure.

> Thanks.

Sebastian


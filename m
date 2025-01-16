Return-Path: <cgroups+bounces-6191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C6A13B01
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6CD16426D
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF81F37B0;
	Thu, 16 Jan 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCRf5AmW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLnWUoUT"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD8143736;
	Thu, 16 Jan 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034769; cv=none; b=Z6+Z0TPnNNkQ5V5jd6HIX1FOGkSCX3NxcnmeS810+WRZrDVGTQktkNC9X4hisGigIXo3nU5VRRbHuMM0nL9//mw+x3zxNytNcWp76nhDflIzjxBwpE2KsKFy4ZNukUIBuM7pq4ONOH4QEEf6B0BhOV3jGYW6cczXJbg9md4/quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034769; c=relaxed/simple;
	bh=YaOCWTi7Oo+i0S4haKVf8BamGh6GzNdiBfuLZLVmZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le9ZOwSAlwujE2SDLo9VChAKwtBnP+7kaloZhwxpQj8LG1WScrfblmw01qSsg//aNH3VJopLyA/PY4IFBVQ29bMv5ZQYrJ8D3wwzo3Brmas55oaNTjb6iy0+LWL/UarehQNzYE1+cpatynlQt1k9mnF5CzpkjgI4dCqI5ZPkgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCRf5AmW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLnWUoUT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 14:39:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737034765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGJ4KdM46X8mQsnAtylyjwp7hkOOM29WF2J7ugpYPTw=;
	b=UCRf5AmWJmHtwYuBHfX6Fdt/uqSaKZ7ZrLaq9c4kziDuBHRc40Q5x2enKaJSBMYWvjfZ7q
	bDb/od7eKfzhbQDRZmzIt4T0yaR9cti2LxQki4Zq+t6BhT1ir1LtfDaZ6r796zRCQP/1vu
	zQrR0RZWTP6yTT2hlMRfP8rdEeS2DoDLna+5SOoDmR0nScsvC/xan6Qq6SJ9CpLitPtU49
	6QqXM6ZZvwv6DJa28YVy65lGNDC0Cxuv/XtH/NpESJqEYxsBKdBr7dYqUSSHk0lnoPAAyG
	FXhBXI+ISYRIF1mth49yQYsr+GIeBn0TDkTpuIaVRQiW4u5MmMyoVideM9Hb/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737034765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGJ4KdM46X8mQsnAtylyjwp7hkOOM29WF2J7ugpYPTw=;
	b=mLnWUoUTul6iZ8xSF0/2BG6YWRKBQ5A95g4t87fuRYd5nZAZWZPvqtnrpt529crkWLDvNF
	qZy+3cVHyRS9MAAw==
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
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <20250116133924.XGY8rIaj@linutronix.de>
References: <20241121175250.EJbI7VMb@linutronix.de>
 <Z0-Eg0B09JQUZG2N@slm.duckdns.org>
 <20250116132745.dU941oor@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250116132745.dU941oor@linutronix.de>

On 2025-01-16 14:27:47 [+0100], To Tejun Heo wrote:
> > > @@ -557,16 +568,18 @@ void kernfs_put(struct kernfs_node *kn)
> > >  	if (!kn || !atomic_dec_and_test(&kn->count))
> > >  		return;
> > >  	root =3D kernfs_root(kn);
> > > +	guard(rcu)();
> > >   repeat:
> > >  	/*
> > >  	 * Moving/renaming is always done while holding reference.
> > >  	 * kn->parent won't change beneath us.
> > >  	 */
> > > -	parent =3D kn->parent;
> > > +	parent =3D rcu_dereference(kn->parent);
> >=20
> > I wonder whether it'd be better to encode the reference count rule (ie.=
 add
> > the condition kn->count =3D=3D 0 to deref_check) in the kn->parent deref
> > accessor. This function doesn't need RCU read lock and holding it makes=
 it
> > more confusing.
>=20
> You are saying that we don't need RCU here because if we drop the last
> reference then nobody can rename the node anymore and so parent can't
> change. That sounds right.
> What about using rcu_dereference_protected() instead? Using
> rcu_dereference(x, !atomic_read(&kn->count)) looks odd given that we
> established that the counter is 0. Therefore I would suggest
> rcu_access_pointer() but the reference drop might qualify as "locked".

Ehm or indeed rcu_access_pointer() given that _protected() requires a
second argument=E2=80=A6

Sebastian


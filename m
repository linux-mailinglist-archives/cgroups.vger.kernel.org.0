Return-Path: <cgroups+bounces-5682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728829D8BEF
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195A8B2A0C4
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D371AB530;
	Mon, 25 Nov 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dyocuffP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/0xor2NJ"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4E2500CC;
	Mon, 25 Nov 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557751; cv=none; b=OiOHlUQZA732WeJfVSVmz+UVgO4+eAFOsTaPdoBCD7AmSgtGTp/LNIh2/3cLiR6sNV9d5oc1t3RRB4V6rjOl+fD5ESLxTDcFV1exKHQQ16gOz8c+zawOW8M+kHQitqOvyQlqb/WM1Er7LlT+TsIn6vrk3eb6PF/3k5tFfbhx98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557751; c=relaxed/simple;
	bh=9VKKNEjHlF2o94k0k0Oz4s8JZIHtEBC3WinbOtGEQ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjk/+0WrUQ/1q1MOv6NltIshonK26IALmvocE5QYrqiB2+g/Kdn7DrCqCwZ4pVczEuqPZIj0P9YWRhyPdOYpMs7YCpoaP1KnzrbjZVdLdClxpif2h+MOrMx2yKXBOmsD9inchXMzvxuje1JoipIquiW3pphVMe//3e9PWyQpmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dyocuffP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/0xor2NJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Nov 2024 19:02:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732557747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PeCuNu5Q7SSew7/ncmoduVdWyBT3bz1efjn0q5wisI=;
	b=dyocuffPY2WjOfUBFyO62PUQZ97EgBAq7fWR73rNgF9jGio0ri4/qkvlrKiOqL6KNaXeQ5
	wTYAXGVsNZFePGGaZiKhG4clSqefQTTdE5pfsPmnjnjlwMXLDnVWEEQw5rOoX2iv5f+sb3
	xI0MAWoREFQ/vxqvd5F6uEdqQmO/dCbCUiBIYsbWZ8EKQejx+Q3ElpfS5dxJ4OGZ8wepv7
	o8EJy+87c1fZR/4JC75OEFVZuxQEEYRvjXcwD0rE9Eg7S8Up9CXbH6JZRzXDAAWr3CK9YK
	wtLQ9/c4DJHBNIS78P3x2nb3m9xR8/7ebwacWieY2euZr5Xgmhq3jy0yYiPaew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732557747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PeCuNu5Q7SSew7/ncmoduVdWyBT3bz1efjn0q5wisI=;
	b=/0xor2NJ6VCMir6pQ7pF6jdmsTWdhaIUmW4TKFyD82/E+/LMTytGU0PR6iwJRMovHQKv7K
	dXrMMfieaQzyz8Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] kernfs: Use RCU for kernfs_node::name and ::parent
 lookup.
Message-ID: <20241125180226.Qo_rHBoM@linutronix.de>
References: <20241121175250.EJbI7VMb@linutronix.de>
 <q77njpa2bvo52lvlu47fa7tlkqivqwf2mwudxycsxqhu2mf35s@ye4i3gsy4bl7>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <q77njpa2bvo52lvlu47fa7tlkqivqwf2mwudxycsxqhu2mf35s@ye4i3gsy4bl7>

On 2024-11-25 15:49:34 [+0100], Michal Koutn=C3=BD wrote:
> Hello.
Hi Michal,

> On Thu, Nov 21, 2024 at 06:52:50PM GMT, Sebastian Andrzej Siewior <bigeas=
y@linutronix.de> wrote:
>=20
> > - kernfs_rename_ns() is only using kernfs_rename_lock if the parents are
> >   different. All users users use either RCU or kernfs_rwsem.
> > - kernfs_fop_readdir() drops kernfs_root::kernfs_rwsem while holding a
> >   reference to name and invoking dir_emit(). This has been changed and
> >   lock is held.
> > - kernfs_notify_workfn() access kernfs_node::name without any
> >   protection. Added kernfs_root::kernfs_rwsem for the iteration.
> > - kernfs_get_parent_dentry() acquires now kernfs_root::kernfs_rwsem
> >   while accessing the parent node.
> > - kernfs_node_dentry() acquires now kernfs_root::kernfs_rwsem while
> >   parent is accessed and the name looked up.
>=20
> Why is the kernfs_root::kernfs_rwsem newly R-taken? Shouldn't be RCU
> read section sufficient for those users?

Those users. If I skip/ left something out, please poke.

kernfs_notify_workfn(). There is ilookup() -> wait_on_inode() which can
sleep.
kernfs_get_parent_dentry(). There is kernfs_get_inode() -> iget_locked()
which can sleep.
kernfs_node_dentry(). There is lookup_positive_unlocked() ->
lookup_one_unlocked() -> lookup_slow() which might sleep.

Assuming the parent can't vanish in these cases, name could during the
invocation. I can't keep the RCU read section open while there is a
sleep within the call chain. Therefore I added the lock so the
rcu_dereference.*() is quiet.

> (Perhaps it's related to second observation I have -- why there is
> sometimes kernfs_rcu_get_parent() whereas there are other call sites
> with mere rcu_dereference(kn->parent)?)

rcu_dereference() is used where I was sure that there is always a RCU
read section. I have kernfs_rcu_get_parent() when there is either a RCU
read section or the kernfs_rwsem (or just the lock).=20

Sebastian


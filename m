Return-Path: <cgroups+bounces-10520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F1BB4994
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71063A5F25
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9525A65A;
	Thu,  2 Oct 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m130edP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtkmpOzZ"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B5239E9A
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424115; cv=none; b=t6Ff543tsUqrr3JnI7QdzHfuQRMSxPywQ/CG9RIAiG9k8VxMWGbSIWL9bRS0xLWVL/otf8JasAXUlMm+dfM37F42FGLdAMGRgrPPS7VvqGw1IRvL9wIvTZrEgy3qm7LHUDrKWaoQ5ucPUnQxAxQQxyhZCAuHeTLa8xHXb5Y21QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424115; c=relaxed/simple;
	bh=zKVEHfikrBLsYfCRV7kwKngOq208ZexyOncJioCOxb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW5YpZJsNGqDXboSPzpBOsRuc/wRheqoUywvPGpEw/W1RbEeOfUccyXGvfuln49BPzvbD3el0IJCTj1MPKvbTjY0lojtdYmqeITXDQQ0QrEHXs3EKC+C2JdaAlMM3ml9ibXKOhfYaDUvYs4A7L8MX/nNpD0V/2DQXOTXSrCk5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m130edP2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtkmpOzZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Oct 2025 18:55:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759424111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qj8Bd2v5gYYTeD4stgWq8SynyYYD/pL4zBPibltlhRU=;
	b=m130edP2LZhDOUxLAk3l8qbOknqm1P0VaIEcUQaGTDBpZ5E8RBH5+YpyxqkHLcL8v6ihbj
	nswuC1OdhqqqnhEkHC6euQdcEjqum1bJfEWmDCM3bLcoDBdNW6i4aBEFrAIjEVwLeqR6FM
	aTsupBccXPf4dOGMWk88EKFmPSRX7R6eq+gu8BaaU/w2xzUxBSYrrtp/AqlwT5AhKjyhCC
	FB4M3PIL7xfkEUCkf2f/DD0p7Ou5WHFbRV7iBnZMqhPuuXuFOOoWpBrihDOeGZI4b4vB1u
	p3tSbbx06QJWqrchvX8wcJjbckpBcN6Y3BB+H2Ai98PsP+ejrBVMux/WLDK2vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759424111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qj8Bd2v5gYYTeD4stgWq8SynyYYD/pL4zBPibltlhRU=;
	b=OtkmpOzZJiHcQyAfqk0hmrKUOR8OFLeTCC9kQGFBmjnFbd+Gx6My0mDykIe7c4gWMKeCjl
	TNebwumTN1LNIFAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <20251002165510.KtY3IT--@linutronix.de>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
 <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>

On 2025-10-02 09:22:25 [-0700], Kuniyuki Iwashima wrote:
> On Thu, Oct 2, 2025 at 1:28=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
> >
> > Hello.
> >
> > Thanks for looking into this Kuniyuki.
> >
> > On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > The writer side is under spin_lock_irq(), but the section is still
> > > preemptible with CONFIG_PREEMPT_RT=3Dy.
> >
> > I see similar construction in other places, e.g.
> >         mems_allowed_seq in set_mems_allowed
>=20
> IIUC, local_irq_save() or local_irq_disable() is used
> for the writer of mems_allowed_seq, so there should
> be not preemptible.

That local_irq_disable() looks odd.
mems_allowed_seq is different, it is associated with
task_struct::alloc_lock. This lock is acquired by set_mems_allowed() so
it is enough. That local_irq_disable() is there because seqcount
read side can be used from softirq.

>=20
> >         period_seqcount in ioc_start_period
> >         pidmap_lock_seq in alloc_pid/pidfs_add_pid
>=20
> These two seem to have the same problem.

Nope. period_seqcount is a seqcount_spinlock_t. So is pidmap_lock_seq.

> > (where their outer lock becomes preemptible on PREEMPT_RT.)
> >
> > > Let's wrap the section with preempt_{disable,enable}_nested().
> >
> > Is it better to wrap them all (for CONFIG_PREEMPT_RT=3Dy) or should they
> > become seqlock_t on CONFIG_PREEMPT_RT=3Dy?
>=20
> I think wrapping them would be better as the wrapper is just
> an lockdep assertion when PREEMPT_RT=3Dn

Now that I swap in in everything.

If you have a "naked" seqcount_t then you need manually ensure that
there can be only one writer. And then need to disable preemption on top
of it in order to ensure that the writer makes always progress.

In the freezer case, may I suggest the following instead:

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 539c64eeef38f..933c4487a8462 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -435,7 +435,7 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
=20
 	/* Freeze time data consistency protection */
-	seqcount_t freeze_seq;
+	seqcount_spinlock_t freeze_seq;
=20
 	/*
 	 * Most recent time the cgroup was requested to freeze.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index eb9fc7ae65b08..c0215e7de3666 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5813,7 +5813,7 @@ static struct cgroup *cgroup_create(struct cgroup *pa=
rent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
-	seqcount_init(&cgrp->freezer.freeze_seq);
+	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be

While former works, too this is way nicer. Not sure if it compiles but
it should.

> Thanks!

Sebastian


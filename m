Return-Path: <cgroups+bounces-11958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B9C5E223
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7340F367E26
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBA32F77F;
	Fri, 14 Nov 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dJAh/Ae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyatNC89"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E015746E;
	Fri, 14 Nov 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134850; cv=none; b=rS7B9pDn2VIrpjoerl6QZR9vvmvAiFfTw5JEJ8pqj/K7dk0hXS08pux9tdbkaMSWRSLiv3X/xgpULn4pV+DUaGLJNMCcafvtbNJ44Sp5G9jwu4SeD3WEdRK5ZvHY6pUsP0CnAeOCk914b6L4w0kQLWZ8XOKgtzK0zSFtTJ5eheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134850; c=relaxed/simple;
	bh=J2tyUCneDZzkQdF5AvAGWRYdQ5JArliVe9FMcgcoieE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOzMCljf9seWvK1OP9LDRr0HQyxMmWAIdz4nJk4mrpbPAkAoBscLjjcXFTkCy9vXyrc0sgEfAqH5GLPyz/onSp+n9uKZ/Czoz6W0+38feoeoz17u+2fjPCF0nnFLiPJOmySHhKYNRsXFJRVndFTt0JYXDfnKoJRQtGpXT9y1yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3dJAh/Ae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyatNC89; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jO6apgBHrHsSf5QPy3p7M9NQE6+E5IimFLryM8DCZw=;
	b=3dJAh/AeQzSJ34ekc7f7hf77sskXKCRw8Q7RYnHrxJh2AG7wwX+R0HHZaoJ/QqxH5tGAmL
	KR66zoqqlfhwThbKlQIzzzh+ijJRC0Sny9sqPZxMOhJfRw+I59CYa1So7dZ0SiZ3jRHX55
	iV6w7KTJeM+nrtxyCYg4u9667RIC2tNVyWwbDrybmeK5rIAbltGfEoa4ElUUGKc9Ku9ktN
	khxhgiXWCQ9jL98bH8ovTwESGgfIr5GpK8IkknQ6hmNSQ7nUZKcHhsWiitWqwnz3/rNxaB
	QcNqr48iPrbWZpE0dEAkIBE6Hs1msvycCvOs+uD1TFMmXkB0oNToREZb0R9O0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jO6apgBHrHsSf5QPy3p7M9NQE6+E5IimFLryM8DCZw=;
	b=JyatNC89PkGRsU4ZrYypzViA22f5pLtKsJDqAksmvaseBpJUxj0hdHK6lQyrlC+pn92jIZ
	p2KPX0U+ZiaFMECg==
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
In-Reply-To: <aRSD-Fyy87qhCR6C@localhost.localdomain>
References: <20251105131726.46364-1-frederic@kernel.org>
 <5d3d80dd-00ca-464d-bebf-c0fd4836b947@redhat.com>
 <aRSD-Fyy87qhCR6C@localhost.localdomain>
Date: Fri, 14 Nov 2025 16:40:45 +0100
Message-ID: <87tsywbp1e.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12 2025 at 13:56, Frederic Weisbecker wrote:
> Le Mon, Nov 10, 2025 at 04:28:49PM -0500, Waiman Long a =C3=A9crit :
>> This function seems to mirror what is done in irq_thread_check_affinity()
>> when the affinity cpumask is available.=C2=A0 But if affinity isn't defi=
ned, it
>> will make this irq kthread immune from changes in the set of isolated CP=
Us.
>> Should we use IRQD_AFFINITY_SET flag to check if affinity has been set a=
nd
>> then set PF_NO_SETAFFINITY only in this case?
>
> So IIUC, the cpumask_available() failure can't really happen because an a=
llocation
> failure would make irq_alloc_descs() fail.

That's indeed a historical leftover.

> __irq_alloc_descs() -> alloc_descs() -> alloc_desc() -> init_desc() - > a=
lloc_mask()
>
> The error doesn't seem as well handled in early_irq_init() but the desc i=
s freed
> anyway if that happens.

Right, the insert should only happen when desc !=3D NULL. OTOH if it fails
at that stage the kernel won't get far anyway and definitely not to the
point where these cpumasks are checked :)

> So this is just a sanity check at best.

I think we can just remove it. It does not make sense at all.

Thanks,

        tglx


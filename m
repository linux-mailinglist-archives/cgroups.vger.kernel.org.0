Return-Path: <cgroups+bounces-5761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31289E3C57
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6798B281B56
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818251FC7EC;
	Wed,  4 Dec 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIyS2PcS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8iGz6n4"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE01F756C;
	Wed,  4 Dec 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321531; cv=none; b=hDCK+srstQ8GCRu/EAMMwGMrCu9PiyX2JpST65QOciH+Eg6EwSymQcyQ6PjxNuiGY9+4+oYRT6h9C5AGwr/3mEUQl/DELEJL6gCNyy1MMojPyFRZ0LHwI/BaSHxghZ7VwWX+VIPoXP5lB3MushrHmBveCaykCgcwGkm2PLa5sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321531; c=relaxed/simple;
	bh=3DT0UZH1VPZxYphESAnn43RiNwQrocDeEgh8vXUL/LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdl0gTQLBUJtz+VIV0D2lcObpfouyOF4OKmu0DLqqHEWpvJFFXBQQCKqRfMpivdkf7Vkq6AjMZptx19b+0eniMTdHdQaPrgp/m/flyyor3I5ZAudJt8LGqEnOxMvpKR9BwAYhPEldZwJgrI4Xj8/OnHH+YNb4rOp6mczdFPIl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIyS2PcS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8iGz6n4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733321527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBZxumzVqfbms8AJEOZ7oxvAy/UxoJZoiGlXqp2Tp88=;
	b=OIyS2PcSvtNoWPDvyfQB7fnN9CKR1IZ0P39lTtEgKOZ+2JisPrLxmVBCpE8tejLJN78xbx
	0ub3up9ALdQC8ST7dvzHdLyleCDIrdfMMNF+DGlZFU3c+Sx0XUbhTO02kfAY/ULMzXTW5h
	jVuZWqfNbe5cWTg27aAVy38qlsaZFXnXLBdJYW+9h9vVzzWcojj3tdI46sTWus3/Rp1wMR
	yOrbsnFUyubRitS8pMJ1OELpsmyi5mr7htdhqw1ks5vgvRfiLAoc/C7jaPj50ijWEe7B+M
	FO+g95YVXdTs8jZDs7xR9OSk7m4Vb6k77IIt1/rOHdWILNxKBA2utDWHcfpVuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733321528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBZxumzVqfbms8AJEOZ7oxvAy/UxoJZoiGlXqp2Tp88=;
	b=t8iGz6n4cL5/XLUWyrFxkPaGxCBC/F9hefCQxPOP7OLx+SC41rSqXmV7QHZIZQCVpk4rCf
	zCRonOuKu2TdAyDQ==
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: longman@redhat.com, ming.lei@redhat.com, pauld@redhat.com,
 juri.lelli@redhat.com, vschneid@redhat.com, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/4] genirq/cpuhotplug: Dynamically isolate CPUs
 from managed interrupts
In-Reply-To: <CADDUTFx3bS4bQ+6s2MSpAL=aN+5CP7V9i5vu-EnrfLrSYbQ_vg@mail.gmail.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
 <20241201124244.997754-3-costa.shul@redhat.com> <87zflfv7rh.ffs@tglx>
 <CADDUTFx3bS4bQ+6s2MSpAL=aN+5CP7V9i5vu-EnrfLrSYbQ_vg@mail.gmail.com>
Date: Wed, 04 Dec 2024 15:12:07 +0100
Message-ID: <8734j3sfk8.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 04 2024 at 15:56, Costa Shulyupin wrote:
> On Sun, 1 Dec 2024 at 15:43, Thomas Gleixner <tglx@linutronix.de> wrote:
> It is introduced by commit a46c27026da1 (blk-mq: don't schedule block
> kworker on isolated CPUs)
>
> I don't know what to do with the remaining drivers.

As long as that is not fixed, you obviously cannot change the semantics.

> I am exploring the possibility of improving CPU isolation from best-effort
> to guaranteed.

If all drivers are fixed then the interrupt enabled state itself becomes
irrelevant. If there is nothing which tickles them then they won't be
raised, no?

Thanks,

        tglx


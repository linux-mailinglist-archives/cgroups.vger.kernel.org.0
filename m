Return-Path: <cgroups+bounces-12161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FFC7B735
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 20:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2531C3A441E
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA72FD1B0;
	Fri, 21 Nov 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QvKmdfvZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLpYrvw/"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB72DC76F;
	Fri, 21 Nov 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752373; cv=none; b=ZQhft+K4E7kxVsPQabv0HHRlODWr5P8LufDSSKPxx3gZPhVfJiqBkbO5rE6FL54VD3x07JtE0Gq+gtOuBk9H9/LUy/9BDruJ+E7VrMg8s5lwhL+zy+MlhgMJiM0quEWNM68hc5lYSgxoTMmgz5MDyv56eVsYm+D1xj4P8tyqIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752373; c=relaxed/simple;
	bh=+VL7t5PaDFJ1KjgI1sjNHsN16vOrdUO1ILEyMR3VHQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CHvygU8jZlD7sytTzodkmnFZzeGhjubSfQWLNLJmazNLz1lTGIZyH30N3OM1mwuy+oUczpVmRKYbu05bpwBKH0L2nnSvgLPy5AvVT1K2DRHCUXngxRyRsobAOjn8K4HGgrSNIwUesO8Nx2Df3/fv3c05YC2L6yrA2wvZfx1iroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QvKmdfvZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLpYrvw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763752360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VL7t5PaDFJ1KjgI1sjNHsN16vOrdUO1ILEyMR3VHQU=;
	b=QvKmdfvZvucrQGG1SA5FIUxw+yTmKY+AuYJYPz7G+TDmgohsgX8NRI3H3fk5mtJsLoDrGE
	uRdzg/j+AHZMVhh2VUFFCmhPeO0KClDw21Fvsn1uaS/K0IIintY3TfBepTu0Ym+NUIfUkJ
	YA1BOb1sgmfuZqIYLopanyJx9b9lByW0RCtiAt6Tm9quv5+wMAmOFb+fa9n5XggXIgoeo2
	kFLbPvP6Hen3/pIOuw/avZtI+ObQAMKWLYlzKu8tUGid4sj1i2Cx61fKeONrZOQ3EM9Pvw
	TJi13g+oVy58qq4CWvD4Tc5tw2dR0H6wqDYPVkAiKt3VYl99L1n8RuGLx+gqAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763752360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VL7t5PaDFJ1KjgI1sjNHsN16vOrdUO1ILEyMR3VHQU=;
	b=yLpYrvw/s/GCLe33pN6AQrQ3qsrROW7rwO9Ln0AZBspOJKz16jMTL5ViWqNLvAIzH5XyWl
	JaRxywjJ0JnAPhCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3 v3] genirq: Prevent from early irq thread spurious
 wake-ups
In-Reply-To: <20251121143500.42111-2-frederic@kernel.org>
References: <20251121143500.42111-1-frederic@kernel.org>
 <20251121143500.42111-2-frederic@kernel.org>
Date: Fri, 21 Nov 2025 20:12:38 +0100
Message-ID: <878qfzjj2x.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 21 2025 at 15:34, Frederic Weisbecker wrote:
> During initialization, the IRQ thread is created before the IRQ get a
> chance to be enabled. But the IRQ enablement may happen before the first
> official kthread wake up point. As a result, the firing IRQ can perform
> an early wake-up of the IRQ thread before the first official kthread
> wake up point.
>
> Although this has happened to be harmless so far, this uncontrolled
> behaviour is a bug waiting to happen at some point in the future with
> the threaded handler accessing halfway initialized states.

No. At the point where the first wake up can happen, the state used by
the thread is completely initialized. That's right after setup_irq()
drops the descriptor lock. Even if the hardware raises it immediately on
starting the interrupt up, the handler is stuck on the descriptor lock,
which is not released before everything is ready.

That kthread_bind() issue is a special case as it makes the assumption
that the thread is still in that UNINTERRUPTIBLE state waiting for the
initial wake up. That assumption is only true, when the thread creator
guarantees that there is no wake up before kthread_bind() is invoked.

I'll rephrase that a bit. :)



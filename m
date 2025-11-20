Return-Path: <cgroups+bounces-12140-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E74C76011
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32A8D341519
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819634F499;
	Thu, 20 Nov 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vc6fHXbx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eg/T72Rv"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6822D1925;
	Thu, 20 Nov 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665752; cv=none; b=Lz9qTMYHcip0KhwHtMCG9OzRPNkJns2IjerlSEsnNFlmIqdM2D4JHeRjMdFni4CqHF8yq7RO/hBKnu/6CEpu5WCdMHH8asOAnK1hOgGK8lbO1p33CpFExlLVsrQ6f4i9344ABknomojapPR30RaqCyEZ0cyEXXkG68HDBgl3xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665752; c=relaxed/simple;
	bh=4uJHiSHEXgH9cvu4D3/DfbSwVc5WdG6gWvbdeT7Z1SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVDeAQrv/RpXK+w+TaCdRsBtA8dFIBgG35qwxMMYdX1ArnXAOYhV3RIgHobD1Rr6QFf0Bn5zq8wSiywV3XB3lqbwAHmUY+qQQIk2ZiV8tgLKaUN8tqmQ7L9Nsp0olEIRavev5WuvCaD9MYHi3iR4AXO3wtyPPEFJAzEbo5Ay2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vc6fHXbx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eg/T72Rv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763665741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fKFWL9Q/HA+9oORIS6KOICC2FtEWCBUCp5rgTxzVKM=;
	b=Vc6fHXbxMTEQ/6MqyPUN7ZGnOZCQdWtHUQtbYFuu4AAnDle//UgmIo7O9HKf6IjeLtowbT
	QsImBX7AKFJ2x1C9Cxu6NizccJ0+qAbTcuHsp2+veYDGEzHpfHN6wzdSmW0sdcN8ZgFTeq
	LABv+4DAZfMDZa6Vcu/xXkKOrBwLfOVFZn77mViHPyWgD1RVMd3l3MhwZGtugHnTAznFno
	0VzCzG5EFar4Y9nN22cjJfk8qG1YfaIWh+HDIa8khDzFGQ+yniPrrIz9m2pkMVPtlmLPCL
	Jlf3RMMjY3eTz+Ad3XND4eMvHnKzH43RYJOCOfsStIuuX+i5atUB17zT28vakw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763665741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fKFWL9Q/HA+9oORIS6KOICC2FtEWCBUCp5rgTxzVKM=;
	b=Eg/T72RvgJXvCkNsengrHPnoH6nPkU9bHisWSe+buMtAxEiGWLAkfGzoTgoiSgcGgH6nJo
	5l0tkXtqR+SxGjCw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, LKML
 <linux-kernel@vger.kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
In-Reply-To: <aR84qyZp3PyH5xFg@localhost.localdomain>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
 <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
 <aR8VoUxBncOu4H47@localhost.localdomain> <87tsyokaug.ffs@tglx>
 <aR84qyZp3PyH5xFg@localhost.localdomain>
Date: Thu, 20 Nov 2025 20:09:00 +0100
Message-ID: <87h5uojzcj.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20 2025 at 16:50, Frederic Weisbecker wrote:
> Le Thu, Nov 20, 2025 at 04:00:39PM +0100, Thomas Gleixner a =C3=A9crit :
>> +	if (!secondary)
>> +		t =3D kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-%s", irq, n=
ew->name);
>> +	else
>> +		t =3D kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-s-%s",
>> -		irq, new->name);
>
> Right I though about something like that, it involved:
>
> kthread_bind_mask(t, cpu_possible_mask);

That's way simpler and also solves the problem with the
kthread_create_on_cpu() name which Marek pointed out.

> Which do you prefer? Also do you prefer such a fixup or should I refactor=
 my
> patches you merged?

Can you split out the wakeup change into a separate patch
(Suggested-by-me) with it's own change log and fold the
kthread_bind_mask() + set(AFFINITY) bit into this one.

I just go and zap the existing commits (they are on top of the branch).

Thanks,

        tglx


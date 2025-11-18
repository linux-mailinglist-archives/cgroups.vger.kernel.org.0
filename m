Return-Path: <cgroups+bounces-12067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E3C6AFC6
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A62C4FA8BE
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A5B349AFD;
	Tue, 18 Nov 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEmaVb7N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8K1RkoY"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AD35FF65;
	Tue, 18 Nov 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486643; cv=none; b=Tw/AqD1xkKLu1WMgabM4/ypvc8UasxHhHl5pbptFAJ4h5pIUMiJhjjV7f/5+lu4D5el2foL4oPKQ5nEmHAkFlhDH8xok/cJexcw9RGIurcDlJtSZtlY5YdR3zMN1pGl2ochKsIjQ/RyLvHXuJ9MsLfvweufWIRUg6+mFcvGgyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486643; c=relaxed/simple;
	bh=deHv/2Idb2ZYGJ/gAfCrX0PR2y32B70ajUhwbWMWxl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecEYstpimEn+WVDy11FzJJcSEBzyMN/z5uW3X9Pm4JI6i77yA7PMKP8Hc7jDmSdDBzADJ1x6FcLKT0qCQTA/fm8eiMw/KoiNdjEASYsyI9E1K9sNujb9TMEgKkFfHTkA/6MDniarf3s2ydzuX/cHfQp4KY/X1BlE8Lcjhh6IRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEmaVb7N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8K1RkoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763486638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiFlYErq0mn3ZGIMf3dyy+VupuT+EztWQBm3dSc1cdc=;
	b=BEmaVb7NbH9bJ9ScKyttnLRgxiilhXmXwg07wXc4avzKhgvhHjAKEkqXh6P8NLCmwr8Aj1
	VHoCV+vCfMxkNVayHlbsu32zqmIhx5C37+qtJ6MXLRaX0XPDUFYT8okbp2nu49gRJfmVxt
	/TUyruTYuZgmNUqtTqjxRASqvERkEuUE1u51FSM+E/tZ1a2IeEwdWTxKOjU17rivQOL9hQ
	133OfhhJ6uKsoZAT8FjCreR9QcT8w/ZN52lDRNrgnP6ESRabmzgVHb3HARUf2irRG21oGM
	MFX56IAp31phYRWigHtqyROSDf+5zGr76U85h85ePnJllQAUuaZf64Qfn2GSVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763486638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiFlYErq0mn3ZGIMf3dyy+VupuT+EztWQBm3dSc1cdc=;
	b=H8K1RkoYvrLZW0Sn0840UkCbY/bH/zKPJZUMLmxdvcDCyNyB9lbLPnpmgQ+BMZiB/EJTvN
	V4Y9IPDnGEvlw3AA==
To: Waiman Long <llong@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
In-Reply-To: <f7794481-5a43-478e-99f2-ae6c45eccaa9@redhat.com>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <f7794481-5a43-478e-99f2-ae6c45eccaa9@redhat.com>
Date: Tue, 18 Nov 2025 18:23:57 +0100
Message-ID: <87h5urmez6.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 18 2025 at 11:27, Waiman Long wrote:
>> +static inline void irq_thread_set_affinity(struct task_struct *t,
>> +					   struct irq_desc *desc)
>> +{
>> +	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
>> +}
>
> According to irq_thread_check_affinity(), accessing the cpumask returned 
> from irq_data_get_effective_affinity_mask(&desc->irq_data) requires 
> taking desc->lock to ensure its stability. Do we need something similar 
> here? Other than that, it looks good to me.

That's during interrupt setup so it should be stable (famous last words)


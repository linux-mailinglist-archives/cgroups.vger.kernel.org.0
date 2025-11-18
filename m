Return-Path: <cgroups+bounces-12065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B59C0C6A40D
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A4BCC2C209
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3E13570B6;
	Tue, 18 Nov 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SIvNXbVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8wSD2ctN"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804426ED37;
	Tue, 18 Nov 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478884; cv=none; b=O8Aq0s8J7C+SV/64DhKxXpqrbNV2QpyD+AwlV/qlp9sPAD6QctjyZPhrCDkFPwAeoFUDX/rKDkh2ivsIDQW026Y4pUMLp8UFKnZhAnvOwPK0aoGiGKbzy6pGvHn6YV50Bqmn7rbrcaHP5ugsQKsSx0O8mWFihLPrNYWA9a1kw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478884; c=relaxed/simple;
	bh=mHtk5r+cwrbdmgGTg50jpEOAjrVwC0V8GXlv0zzAfxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVGAMtr6VeIh1tAzy/tMI5JM+9QDQWpAdckTNoEXpd8VtNwPfJ9PHJOn89TceRdaYZWyWadIGuFYSSn+QfHEE/BDHHOUBsaEh97lHIqrJ6eSbNdq9j2iCVeqtM5fr4BjOzhdtKy7OVOLPhFh5EAEj7I7Nhusur5LsfKcaJsKaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SIvNXbVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8wSD2ctN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763478881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWEftUVJa7wmo8ie7CrOai2fltElMmT1C3IMV9l+0tE=;
	b=SIvNXbVAmBl3IlxNKV2+Iw6vxECxkh4Y2S6SkAOnccU/VUhUMTakcgyEfzdtp8tRO9qo3u
	ChY0UXGwJUUx0kTxBpZuXsUiU5JcpVbiVciTb47n4cLq0AZfAuF2edJi6sop7hnzqAMbky
	8ecBp2t7znlwTPQ0hsytUqoZpQEOyAhCpZSAHlvXFf6h5+i3q3MQdu5GAMYzKwZsFwVBno
	9vVPLBtFXjtFbamBh/rRCrOsPMrE321wRoMhoGrX3kwHTqzhPZPuIoPO8/DY6cxWGqrU0O
	Y67aWvMPfL9haO6tiDubdjrTTQ+LgwmxhtB2izaVK9008d4ZGH0Vahi1y/J13w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763478881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWEftUVJa7wmo8ie7CrOai2fltElMmT1C3IMV9l+0tE=;
	b=8wSD2ctNZpVknzssHczw3VIbNAWgIXLp7I8cFU3JlgbS/UnEe+0qn8lmHyBbNUCy4I1DUX
	CxpBV3OiXbQ+g5Bw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>,
 Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] genirq: Fix IRQ threads VS cpuset
In-Reply-To: <20251118143052.68778-1-frederic@kernel.org>
References: <20251118143052.68778-1-frederic@kernel.org>
Date: Tue, 18 Nov 2025 16:14:40 +0100
Message-ID: <87seeb5q5b.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 18 2025 at 15:30, Frederic Weisbecker wrote:
> See here for previous patch:
>
> 	https://lore.kernel.org/lkml/20251105131726.46364-1-frederic@kernel.org/

It would be really useful if you would have 'PATCH V2' in the subject
lines of the series so it's easy distinguishable for humans and tools.

Thanks,

        tglx


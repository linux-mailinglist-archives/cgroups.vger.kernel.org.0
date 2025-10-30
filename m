Return-Path: <cgroups+bounces-11426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B0C1F302
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 10:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC24E8CD5
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB73340DB0;
	Thu, 30 Oct 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NyQmXPBW"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34B2EF646;
	Thu, 30 Oct 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815252; cv=none; b=OGtwmaS4rGrvaRSB4p8eDVZpqMbYGIIZvHYeXalSCiIq9woAknUMV9becgsw8z4zNC4poyPJNIDKe/F9JJbmXJJv9tgivGS7sGoLRZSZxC0gZ2LnL7tyiSZWmOHxjYEkadvKEfCGp4YfnpVcaWyJGTymscxMOkaExk2okdx2XQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815252; c=relaxed/simple;
	bh=l1viRMC/UmwSuDDuvBE2zGgXvumdL/Ls7gVexkoy3K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2xxlpBgSsowXMlmyxipY9/Ht1oAQrxo8Yux6K4OdReK55OJxB+xZqUZLadHoKEanFkx9QSWmgq9uBTD41KeUkHSTW2Xj3LVkst20KrjoC67XUjjiggMK7TgXWLqWoYih/pExB/ZNMMGyDvEFJPxRy1Fs2BV4zDP78KJHu2g3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NyQmXPBW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=c2jqJvelZ1hYmz7asbMfIdSEjayi1eF7SkgIc3nH9G8=; b=NyQmXPBWuzXksesCUhML6S47F7
	d4sh5asusrkHqeWZdIZBKm3lARUaHgSkqQ2jjpmoF5lHUEe/f4khSkrnTWJNRswo4N27Cufmc2KKy
	9oOTPwWHTIVdZOu+iMiPL/4MxAgcw7+ig4N5EKdrnZvZaarohqH3bCqC1qUUR1iIHUZ3vF5ydAzbw
	LGrOGZUZfaaEHEosbbBDZl7uPgkKsJaaCDV/Wx/MaQqEzfwE9dZ3oN+MCQekzSlz1tfpXZbLH05vc
	x4/b5LJsc3OYPsrJJHDb5SrqGber647sJbn3be3d6mYsGSs83updmcgM74m7qnSk9D/p7RMiUPKbK
	jFqxFuTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vENl3-00000008jZI-0NhC;
	Thu, 30 Oct 2025 08:11:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AE094300343; Thu, 30 Oct 2025 10:07:15 +0100 (CET)
Date: Thu, 30 Oct 2025 10:07:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Brown <broonie@kernel.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 07/14] sched: Fix do_set_cpus_allowed() locking
Message-ID: <20251030090715.GQ3245006@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.103475671@infradead.org>
 <29d7b92b-594e-4835-9dd3-3c9e2b02ada3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <29d7b92b-594e-4835-9dd3-3c9e2b02ada3@sirena.org.uk>

On Thu, Oct 30, 2025 at 12:12:01AM +0000, Mark Brown wrote:
> On Wed, Sep 10, 2025 at 05:44:16PM +0200, Peter Zijlstra wrote:
>=20
> > All callers of do_set_cpus_allowed() only take p->pi_lock, which is
> > not sufficient to actually change the cpumask. Again, this is mostly
> > ok in these cases, but it results in unnecessarily complicated
> > reasoning.
>=20
> We're seeing lockups on some arm64 platforms in -next with the LTP
> cpuhotplug02 test, the machine sits there repeatedly complaining that
> RCU is stalled on IPIs:

Did not this help?

  https://lkml.kernel.org/r/20251027110133.GI3245006@noisy.programming.kick=
s-ass.net


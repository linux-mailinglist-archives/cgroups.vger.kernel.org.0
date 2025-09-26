Return-Path: <cgroups+bounces-10466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADCBA3446
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 12:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617AC4E2814
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE032BD58C;
	Fri, 26 Sep 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2wfhmnm"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E529C323;
	Fri, 26 Sep 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880795; cv=none; b=hSa/zLD/NO2mu8kIp+n5z48IuEBKA44lBErsczjnJHANJWzSiDDzOuB5BITj+vYZZ0tQUwJneC9JBg13oEqTajwlv+eOiLzCICYWw+k3AM6yI4yG5DPFLo4TKoLXx8H+/irB4rMtegS3WewFVNvSzhCpB2MzQBpgg4IwJquWKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880795; c=relaxed/simple;
	bh=Vz2mRzmLO/vc87vmSaWw7k2AvWjaU3Y0LKHO/ukbElg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B31rMds51jY69bH7/GZGo5zZHEwjMENWH73We+KmbmvHjRQTjsEN1uC68KpYGT0HhSrzKiHtnnk3rafMsigy2/YUSa1eMxmdBaNGkcnlV8/DhlgRDaILT4W2SXt7bxoCd1JfP8LTTIVjdegXIlaSr089mLXyIOFDvuOYy30Q+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p2wfhmnm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vz2mRzmLO/vc87vmSaWw7k2AvWjaU3Y0LKHO/ukbElg=; b=p2wfhmnmUwJH3a//KTSKX6ed7U
	XUXJ6SoweUNbk8Xszb/f9eb98lU7jGGTEtmvAaJ2O/+1eukfXJ6YXKAhBpnTFgniOYSO25AQf3Ip2
	qs6PEbb2K7pKeXJar4K+MybCrKpin2+6wV4tYVXiWi0UH4rQtR8pY4e19NqaM58iTLPhnIeQY3sEr
	KdIzeM0Vhqe0SSItkOGcuGGT0nkblsOCHtgYyF2Y7ci0q6L2Hg+7M26WwrXUCCDfUt14f0CrIpxsA
	BMHxav0fS7cV9PXkLWd8A3n7uBUKxy0n0sK9rVGSZSeZTbit9gnJh+FM7EsGrVyw7A7xXeDPufc3J
	GJE4WxTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v25Ej-00000009d3f-3Smy;
	Fri, 26 Sep 2025 09:59:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C54B3002BF; Fri, 26 Sep 2025 11:59:34 +0200 (CEST)
Date: Fri, 26 Sep 2025 11:59:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <20250926095934.GD4067720@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNW3du48v3PvwPbq@slm.duckdns.org>

On Thu, Sep 25, 2025 at 11:43:18AM -1000, Tejun Heo wrote:

> Can you point me to the RT interaction issue?

https://lkml.kernel.org/r/fca528bb34394de3a7e87a873fadd9df@honor.com


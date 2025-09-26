Return-Path: <cgroups+bounces-10467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7CBA35FD
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D725C188C9A2
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD282F39A6;
	Fri, 26 Sep 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYQEGrxD"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180E2F3607;
	Fri, 26 Sep 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883002; cv=none; b=p6w3PLDvUDkLIkpXQx3KJLL6fo1QkzT2Gj3/x776E5DFs9PBXAIDtJ2SfNCA53RqM6wQrer7AeaXCbMYSFnEvNdLr7g6EdmyOxmHQIxvp5m1+GIvzIXTZnHsU8zHxaRtnbfzW+SOeQApTZgl0wEjCD8uySzZ+B55xLK0iJzT8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883002; c=relaxed/simple;
	bh=+yWmajeOY4iXOKiCMaYj+7IWbKZOIO8QpBCjTEtIN9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzUVzHdiOCrOiCAnIeupxHB6SKE7jtXRvTlMEpjxv7AXlhwjPGWyw5//u7s3p6R603v6stnaEcexL6Rn8qm2MbZIrTkxjg4KbKC2+TrxWvYLRdGtoeS7H8/eqVuyEwlA7heKJ7/rXGR0qoy9wJQi1peh+JKe840krS3b3L9I7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BYQEGrxD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+yWmajeOY4iXOKiCMaYj+7IWbKZOIO8QpBCjTEtIN9o=; b=BYQEGrxD39MaHfkivzwdPRT3mq
	R+moOsTsvPVLEaSmkW5TcYPVh0rH/CJrWhc4p+qz+MvS8rPvYsq4Jkh5MwpPdz7Fk3L8zYrwkBFaX
	qT4yQj2DfoaZGc9ewP6ICgHgEkhru4QkAf9o2GWd2n3WovXc65ChpU7CJQalvHQWDcfEJyzNJI+JA
	wmTWSEgZVefPA6RAjUsWt/bPByVSLYhNoMY3x5kRRpMF4a/q2ePeSNP/YGuQlxvIp23C3eu++vPi1
	wGFBlBOVoa9V63M/GIRgDSt2Gk0WnYPU5ghSMc2iMNzgiZIhG27JMi1TzXhOglUsAg1Ag0//WnMsQ
	JcWWp0dg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v25oS-00000009pqb-3I87;
	Fri, 26 Sep 2025 10:36:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 556533002BF; Fri, 26 Sep 2025 12:36:28 +0200 (CEST)
Date: Fri, 26 Sep 2025 12:36:28 +0200
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
Message-ID: <20250926103628.GE4067720@noisy.programming.kicks-ass.net>
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
> Yes, I was on a similar train of thought. The only reasonable way that I can
> think of for solving this for BPF managed tasks is giving each task its own
> inner sched lock, which makes sense as all sched operations (except for
> things like watchdog) are per-task and we don't really need wider scope
> locking.

Like I've said before; I really don't understand how that would be
helpful at all.

How can you migrate a task by holding a per-task lock?


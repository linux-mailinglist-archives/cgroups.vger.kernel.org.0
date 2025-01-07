Return-Path: <cgroups+bounces-6066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19388A04A5C
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 20:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E43A37F1
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF901F5415;
	Tue,  7 Jan 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EDPTF/yZ"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD31D8DFE;
	Tue,  7 Jan 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278874; cv=none; b=HXvBr6P+SPnxaiShskj9mSZJp2d6eKeb9RvUCJSL8DOZhM+V402hyIplUMUXcjBifgPBWgFABIgh5V77GrbAExwIOJ4qsNBOpwTCEYIAyrgQWgwNHbaJrENCpfx3S7/jw9S8YOp0SE2BeaOQVLupCcc95Ft/jZntguw6rlbI/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278874; c=relaxed/simple;
	bh=RWn9cauNPe+Adxo/IKxLpNzTuXAJGNIEjmLPVz+OfQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5/1sj0x8Cs/KQku9RuD3ruY7HI/Vx/kqQ3a0yNdR6/h5VAg3ggNi/kvUwmcjepLkaTSigAD8AagJzqUabsITTCte1uqf2+qWiGPtk8YYuMwErkknPOSIqsXNSnGIosfprMq3Z1YJUWKHu+gV9Q2uDOyQL6pvSRWVY9GEKNFRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EDPTF/yZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RWn9cauNPe+Adxo/IKxLpNzTuXAJGNIEjmLPVz+OfQQ=; b=EDPTF/yZ6ibD/xji+qPGwIegAe
	Kqps3MGIiO2jZZH2eJtYVlWc4vJ3o9UYfum/gZdNgQZ9zi69W7qcYhwexU/OKXF8SGB29jrq+PUTA
	e05p+e8XQVbDPmss4vkbj1aOH8TEjGIVXCkggS9qGGJkwJxefNX2D+YFHgX+s+T4ymfjPQY5F1rkF
	mAGJ76kND4nwIhhyWG5oi7ntcnNJeKgprp5M2laRBf7V26tm9XH9vjWgdtwn2HGzH0a0+oy8/3FVU
	OjyWRqxFwi2sSOjY3NjSHjOBWRUrFgslaoh0aBhP7tmh/f4oY+b+s4VLKd/+RZu7ph4vEU6RnQsLl
	23k2w0Sw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVFRq-00000008ffo-3JfG;
	Tue, 07 Jan 2025 19:41:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9279630057A; Tue,  7 Jan 2025 20:41:06 +0100 (CET)
Date: Tue, 7 Jan 2025 20:41:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [RFC PATCH 0/9] Add kernel cmdline option for rt_group_sched
Message-ID: <20250107194106.GB28303@noisy.programming.kicks-ass.net>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>

On Mon, Dec 16, 2024 at 09:12:56PM +0100, Michal Koutný wrote:
> Despite RT_GROUP_SCHED is only available on cgroup v1, there are still
> some users of this feature. General purpose distros (e.g. [1][2][3][4])
> cannot enable CONFIG_RT_GROUP_SCHED easily:

We all hate this thing and want it to go away. So not being able to use
it is a pro from where I'm at.

Sadly the replacement isn't there yet either, which makes it all really
difficult.


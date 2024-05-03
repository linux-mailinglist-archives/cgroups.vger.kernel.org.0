Return-Path: <cgroups+bounces-2773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8888BB233
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 20:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3948B1C22FB2
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A21586CC;
	Fri,  3 May 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oiMT1nYh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C261586C3
	for <cgroups@vger.kernel.org>; Fri,  3 May 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759889; cv=none; b=CZXVCATOvuoW448/BBNzV4DOhhW75vqBq18UM5e2oumwPNWyj1T8R+56LIKuT2otOyVa03TTByW+oNalJE1MLHpfxU8xf5Pf3Y9eTq8JmwevaatHvH8HMovPMYBKwvGXwJUGt2IckQmDQHftdifhA8mYJx7/vr8euLZEUFjmoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759889; c=relaxed/simple;
	bh=jGxTWoogKeVyYlJFXyLyWyKyLbBEDvZfmLstshTOD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLhPiVlZDTSUm1+UtelL1MpNoyL2NoW/jilsPVP6gI6T2j4Lci8ya4Y/txlrjCAqeABNXxtNK0h4mL6dq06RnG6fB0wLMvDlR9BBrXkS5tCxlGPD2OIbDtgTI0R1hYLu7ULd0KMjMn3ierMi0p26bINWCOHkghexqXIlByl2jDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oiMT1nYh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 11:11:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714759885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v43bZUtmgn/Fa1lECh+eb1qKS1YLdkiy2ArNZeurJLk=;
	b=oiMT1nYh62rxDYQnwrF57dx5GghIQOtDjIqKfWRkmQH3x2e7AosUA3Y7zwhMyvYdveFFQ/
	IzfGaEUD0xtJ3vsnWclQvbASZgdji3FWoQxrHEqqbYyDftzz5yNC6qwMtIxhkTSlDWBfHQ
	K2/tiY0enRpvq2UUgKQIf6jJuFDRqSA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <mw4bi6x5tx7rjgswp3ibd5wvnveqjlh3k3v6l3hor52pyejff2@x6ypubxztw4d>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <4m3x4rtztwxctwlq2pdorgbv2hblylnuc2haz7ni4ti52n57xi@utxkr5ripqp2>
 <c5a79618-8c64-4e7b-aeed-69aeecb1590d@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a79618-8c64-4e7b-aeed-69aeecb1590d@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 03, 2024 at 02:58:56PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 02/05/2024 21.44, Shakeel Butt wrote:
> > On Wed, May 01, 2024 at 07:22:26PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > [...]
> > > 
> > > More data, the histogram of time spend under the lock have some strange
> > > variation issues with a group in 4ms to 65ms area. Investigating what
> > > can be causeing this... which next step depend in these tracepoints.
> > > 
> > > @lock_cnt: 759146
> > > 
> > > @locked_ns:
> > > [1K, 2K)             499 |      |
> > > [2K, 4K)          206928
> > > |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > > [4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> > > [8K, 16K)          64453 |@@@@@@@@@@@@@@@@      |
> > > [16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> > > [32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@      |
> > > [64K, 128K)        38359 |@@@@@@@@@      |
> > > [128K, 256K)       46597 |@@@@@@@@@@@      |
> > > [256K, 512K)       32466 |@@@@@@@@      |
> > > [512K, 1M)          3945 |      |
> > > [1M, 2M)             642 |      |
> > > [2M, 4M)             750 |      |
> > > [4M, 8M)            1932 |      |
> > > [8M, 16M)           2114 |      |
> > > [16M, 32M)          1039 |      |
> > > [32M, 64M)           108 |      |
> > > 
> > 
> > Am I understanding correctly that 1K is 1 microsecond and 1M is 1
> > millisecond?
> 
> Correct.
> 
> > Is it possible to further divide this table into update
> > side and flush side?
> > 
> 
> This is *only* flush side.
> 
> You question indicate, that we are talking past each-other ;-)
> 
> Measurements above is with (recently) accepted tracepoints (e.g. not the
> proposed tracepoints in this patch).  I'm arguing with existing
> tracepoint that I'm seeing this data, and arguing I need per-CPU
> tracepoints to dig deeper into this (as proposed in this patch).

Ah my mistake, I just assumed that the data shown is with the given
patchset.

> 
> The "update side" can only be measured once we apply this patch.
> 
> This morning I got 6 prod machines booted with new kernels, that contain
> this proposed per-CPU lock tracepoint patch.  And 3 of these machines have
> the Mutex lock change also.  No data to share yet...
> 

Eagerly waiting for the results. Also I don't have any concerns with
these new traces.

> --Jesper


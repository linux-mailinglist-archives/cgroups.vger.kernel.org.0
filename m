Return-Path: <cgroups+bounces-3780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DAE937193
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 02:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EB11F21857
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E66137E;
	Fri, 19 Jul 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ad2SkKO7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0A10F1
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721349667; cv=none; b=t/foDaQAMVZpzfXAz+vZs3EBBszsRw01OpcsyNVGeckS6E0iG3GuCMssRQ1WNoa06gS78yBrCm+mtJqRCg+FlZjD/grNTRUuMhzZtUj5M4cMOgDkvsK7UxejpCeKtEgYrdvbg4NLM5ALsgjx1BpJuI3jA8mxOKZZYWZO2aoQOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721349667; c=relaxed/simple;
	bh=Dy76veaT8r+gPmGNRzlCXg1ZiBpKsOXKDrg8Eb7/qhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaKsOYroq6P4eRE5d7e9OQBrsF1t+qeOHxUnpEyywkUcWm8WNQAqKU8XiDOe3P9jqzglFilMD8n1iRg9ikQ3ItJiiPZMkRjAoB+T0sWLEkbpgs0A2w2yHDaXcs4h/sXsPtQWgdV3O0EH2J4w2oylJxF40CQOiAtlnIP2LSxOUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ad2SkKO7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721349663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qrSMnkpzFYj+5EVCkCG4KRZYIDNmGMzOcWNxn2WiHw=;
	b=Ad2SkKO70KGXQIEsX9jWjty3IeQRsSKTLMB7EQ0L2aVeL5+6PYyXlEEmvl8vBUVF2sVQeb
	Iufn63FaFjjDpyvIELUbpNT1aRSGcb/JCyHe29e3dKU1iSqzebUSCoa9YId061cm1bEbBx
	yzpffI9x9tMDUZ7CSTdb03bvzKbOqPM=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 17:40:53 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Jesper,

On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> 
[...]
> 
> 
> Looking at the production numbers for the time the lock is held for level 0:
> 
> @locked_time_level[0]:
> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> 

Is it possible to get the above histogram for other levels as well? I
know this is 12 numa node machine, how many total CPUs are there?

> The time is in nanosec, so M corresponds to ms (milliseconds).
> 
> With 36 flushes per second (as shown earlier) this is a flush every
> 27.7ms.  It is not unreasonable (from above data) that the flush time
> also spend 27ms, which means that we spend a full CPU second flushing.
> That is spending too much time flushing.

One idea to further reduce this time is more fine grained flush
skipping. At the moment we either skip the whole flush or not. How
about we make this decision per-cpu? We already have per-cpu updates
data and if it is less than MEMCG_CHARGE_BATCH, skip flush on that cpu.


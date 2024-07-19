Return-Path: <cgroups+bounces-3826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B585B937DE3
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 00:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DFA1F2151C
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 22:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFF147C76;
	Fri, 19 Jul 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hF5PjfvS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DE282F1
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721429282; cv=none; b=rARjwlwBlmOdsQMIGO/PjIS6ozBcUnbdCCAwqBFENC/ezOiwUDceTY9CIQRvMMfr9aiGTD4C5ipz0McXyxHbdMUuvdWzQdlB9ZePcX8ROLPsHSw7H+hDYwG5G2ho9eolN46j2FAytz2GRxvqsUGp3SotgMqhFbOORrtfCVVz3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721429282; c=relaxed/simple;
	bh=iVudnQOL5ncGdwnj2qPbZ+MU2mU9PMhwjYBgVJboddo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPCnOQzDsO4btQhAcCxOq8fplslQNkzCcb+AzRXV5Yh+uIRQPl6eTSMH7yk7iZ5sVf4CQ4pJ2QhnAybJDimF7ZrUO200+W1LNftx4Sg+RWUQteAWZeIesV2xxLk/K4Hf/tG9A5Pdm4ofSXjwOpftLyVOdtM+haBqR0wRhABuK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hF5PjfvS; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721429278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NitcJj0Pw/pNrSCo9KnhvfnaK2ycH5BWZYgqbEjFt1w=;
	b=hF5PjfvSwGfXSRC4xhB598MsbaYWkYhNznmKfJ16HTDAcK41Vuol0KZ9ogP4CtpUtVaXTz
	DSNzieLFFldV9VvdOtWcrrqYVFAgJL5jDDtBK8mJvm8xrAJ2p/hGb8q02LYmg1iY3qZABU
	+nlQR7SrrEXz5kkHCSyDtdrNbJMw1oQ=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jul 2024 15:47:52 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> 
> 
> On 19/07/2024 02.40, Shakeel Butt wrote:
> > Hi Jesper,
> > 
> > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> > > 
> > [...]
> > > 
> > > 
> > > Looking at the production numbers for the time the lock is held for level 0:
> > > 
> > > @locked_time_level[0]:
> > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> > > 
> > 
> > Is it possible to get the above histogram for other levels as well?
> 
> Data from other levels available in [1]:
>  [1]
> https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org/
> 
> IMHO the data shows we will get most out of skipping level-0 root-cgroup
> flushes.
> 

Thanks a lot of the data. Are all or most of these locked_time_level[0]
from kswapds? This just motivates me to strongly push the ratelimited
flush patch of mine (which would be orthogonal to your patch series).

Shakeel


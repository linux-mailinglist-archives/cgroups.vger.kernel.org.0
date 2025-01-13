Return-Path: <cgroups+bounces-6111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA2A0BFC0
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6E4168991
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAE1BBBE0;
	Mon, 13 Jan 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cM1+iUKM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139B1A4F22
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792747; cv=none; b=Nu9wwStYL3oSASpj0w3Qrv4VLzNsIgPWJrUWpUwXF2s8a+OTPun6oqyA7jNoFhUjtxf3D5yg+RX31xcg0OCLoSRaUi9fLn3rG2zgQ9NQT/25dQqZhqcDhcB07T5KmoPvX8yX9DQJQb2h2/Owte7WhyvAIfViczSC5QD6oCNq8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792747; c=relaxed/simple;
	bh=aNQ2KUk3H/2Tj+0kW73pS+nwuWjFxPD/oNY2Ec7Tt3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BprmG+KSGYMzyKcvbp07rKoWWxyGl17Ddk3Y3kwET/9yCPoB7/6S7xbGE2wIRLMplnwnC0P6vJeuqo6CRr8/0H3bMdnWUwUwvOxsf/ET8EXifMb5eL4By4YgxYm4WEb1MCTGqvVwid62Q2mk+Ly4r6pHpcgbcyxaL7pPlC06R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cM1+iUKM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Jan 2025 10:25:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736792738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+MaST8thgn46xOJAidrnY28Y7FV8o54uwUFMvYjaFE=;
	b=cM1+iUKM/dwf6RTL+pOQ0mU/1ZyAQ986iC8uqYVkpIe+oXeXaCATA6PYClV0tSMx5kpwm6
	3oAua3xdDxDKqWweLnFNv92uma02zBq8f/c80MlFqMRK4IyhFlS6WM+GX1lUfmQM/NTRw4
	eaMPMkSrFpJGfHYzVb+IjuUVDPffaT4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
Message-ID: <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutný wrote:
> Hello JP.
> 
> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gmail.com> wrote:
> > I've been experimenting with these changes to allow for separate
> > updating/flushing of cgroup stats per-subsystem.
> 
> Nice.
> 
> > I reached a point where this started to feel stable in my local testing, so I
> > wanted to share and get feedback on this approach.
> 
> The split is not straight-forwardly an improvement --

The major improvement in my opinion is the performance isolation for
stats readers i.e. cpu stats readers do not need to flush memory stats.

> there's at least
> higher memory footprint 

Yes this is indeed the case and JP, can you please give a ballmark on
the memory overhead?

> and flushing efffectiveness depends on how
> individual readers are correlated, 

Sorry I am confused by the above statement, can you please expand on
what you meant by it?

> OTOH writer correlation affects
> updaters when extending the update tree.

Here I am confused about the difference between writer and updater.

> So a workload dependent effect
> can go (in my theory) both sides.
> There are also in-kernel consumers of stats, namely memory controller
> that's been optimized over the years to balance the tradeoff between
> precision and latency.

In-kernel memcg stats readers will be unaffected most of the time with
this change. The only difference will be when they flush, they will only
flush memcg stats.

> 
> So do you have any measurements (or expectations) that show how readers
> or writers are affected?
> 

Here I am assuming you meant measurements in terms of cpu cost or do you
have something else in mind?


Thanks a lot Michal for taking a look.


Return-Path: <cgroups+bounces-6643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CAA4041D
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 01:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928AB189C16A
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B0381AA;
	Sat, 22 Feb 2025 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l2CxxsBf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF35949
	for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184150; cv=none; b=uGNmATdHbp6DAia/Ljwfa2HK+BLBaRNu6wARcbR/ILUFbV1b9ecY+RRe1x2kdNCv4OF33gi4W5jhJXRJ7FHJ8MhZNqyBJvg3MlBZpWaQaCyJGkUk5R5TAeCb9nGCjouRROKajed8CsDZo7G5G1crGJZV9xCzwMgG/iBLKl1BIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184150; c=relaxed/simple;
	bh=+XByTX0CsXxJpYxNKTtgO7WGR/bXZvK6x/uwUxV1ch4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJ9wxyNcF5KOwiSlrf00fSEPMMdDhXvO/HD0/eJCKp5pT38uRIxRpmLOY4UxYj6ZHndO1QSpf7/J2kl7U5w77R4rvSUgDRT3KptTVdkedl/6LPKvsOROOJ3bZsnGyEILBJMH+CaCyVJ16LCLmprmmJjeOcyCJYTWyMp2WdN59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l2CxxsBf; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 16:28:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740184146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y6iYz6qo6As2WbWhauY4s4USd3SkFNZj9yuf7cHP7k=;
	b=l2CxxsBfAll7US7dJzFobtnrbeFTCupZJvPpCBXGaebPlllXwvuaapqVQbrHhzVms0gKuE
	S9WwMUAJzy2Vse0L9PO0i2t3rw9NfpUzD3yAAEetJ8NjH0dLkxiIKncczwrefD86s6Ar8v
	7vDe3r6fSl7XaISLGekges4mzF42lhs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 11/11] cgroup: separate rstat list pointers from base
 stats
Message-ID: <igo3r67bmobbaipyxfd5ye6zkluwn34e4xtop2wkadsxl6p3wq@25c76ftplahs>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-12-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-12-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:48PM -0800, JP Kobryn wrote:
> A majority of the cgroup_rstat_cpu struct size is made up of the base stat
> entities. Since only the "self" subsystem state makes use of these, move
> them into a struct of their own. This allows for a new compact
> cgroup_rstat_cpu struct that the formal subsystems can make use of.
> Where applicable, decide on whether to allocate the compact or the full
> struct including the base stats.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

This looks good. Now there are two major asks and then minor comments on
some individual patches.

Two main asks are:
1. Experiment requested by Tejun.
2. BPF rstat using the base subsystem as requested by Yosry.

I would say send the v2 addressing these requests.


Return-Path: <cgroups+bounces-6734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2784A48BE3
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22661882F89
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B3229B07;
	Thu, 27 Feb 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gmLwKQqj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80A1B85DF
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696217; cv=none; b=sbZR75KuT9hJCYORsvLerCENuCRQaouwMXKvzI6ARdsXbdStullOWe4nTDv6tebZCFIj75c5Mrp/x26TljuVy2l0MlDExUZFuTxOKV9s7K9LfULlktyO6++9JspkjTYhLep1feEZsqUjGtv4Vi9NBLGP33OnI2LlC1jvRxNNTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696217; c=relaxed/simple;
	bh=rKVoTSAtol7b4eJw1/6wyAWVPjwz8nmRLSQ+q3mt8n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5HPzd84DY/XM7ZB8m0JlNtYKKDSwfuhxxyq5CfOkM7Esarx4C/UhnQo+PzjTT9dVt0sSWhgeRY/gTMDtCMs/YQMvy6Yj36pjx31w3X/OUUPUa1KkVrl9AT2OiEz0vso/EJh83YfK6r/JgyfMe6mVUYMeU+6avXALlHt0HYmQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gmLwKQqj; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 14:43:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740696211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URs3a90RZoxDVYTmfZjczkKABEzHifSbZDiB5wwZA54=;
	b=gmLwKQqjNujd/DNdAsOazMqy3K4RVqjo06zUnH8vQJMI0oDcdgJsSh69RS9tjBRKX2URXN
	E8L/wuUoRPMGm20MJ7YKpUctN3Wy3RwhP+2ntEh6OLznevRtKWBFBKMkayXJ/LbqA8YPF0
	RzTLctWss8eWVAVonftKoT437HamzsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, yosryahmed@google.com, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <r77izc52eaqwhzed5ptkpjwzbyeztwgyq4742qn55cwvggdpqt@kenzyspqitvo>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:40PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Each cgroup owns rstat pointers. This means that a tree of pending rstat
> updates can contain changes from different subsystems. Because of this
> arrangement, when one subsystem is flushed via the public api
> cgroup_rstat_flushed(), all other subsystems with pending updates will
> also be flushed. Remove the rstat pointers from the cgroup and instead
> give them to each cgroup_subsys_state. Separate rstat trees will now
> exist for each unique subsystem. This separation allows for subsystems
> to make updates and flushes without the side effects of other
> subsystems. i.e. flushing the cpu stats does not cause the memory stats
> to be flushed and vice versa. The change in pointer ownership from
> cgroup to cgroup_subsys_state allows for direct flushing of the css, so
> the rcu list management entities and operations previously tied to the
> cgroup which were used for managing a list of subsystem states with
> pending flushes are removed. In terms of client code, public api calls
> were changed to now accept a reference to the cgroup_subsys_state so
> that when flushing or updating, a specific subsystem is associated with
> the call.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

One nit: add couple of lines in commit message  on why removing the
padding from struct cgroup is fine. Most probably the reason to add the
padding is not valid anymore.


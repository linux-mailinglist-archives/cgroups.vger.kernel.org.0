Return-Path: <cgroups+bounces-8473-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B7AD3EC5
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A421760CE
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D142241132;
	Tue, 10 Jun 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qw7D7Vg9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAD239E60
	for <cgroups@vger.kernel.org>; Tue, 10 Jun 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572688; cv=none; b=jh+eBAqG25hQ/h3ycu02hDIPUhPkL0RcQtkJvtpzrccagXtSdHyakXBrqzKY8TDLcvAm7lYaofoN1aOzyrockoHP3ABhMUXRKzpmXX/mX8SOp1VtwR8KZTZsXV2jUsGE/x7PQiv/1MSxs6VsgioWmAyoNhKn4/zcl8zYeUvBXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572688; c=relaxed/simple;
	bh=nWR+zjPtA+scR6nE36SM9TrYXuWF2tOEpAjilOay5JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsfJd7Ujxy0KqUXwUSB5g9XvKYHEU5wKusQp8Tuvz4k/MS35KPKatY3KQIb1j86zHFlXQ5v9Dg7CDv/WzQfLgfq0vKqusLOsPW+k0GQ+t5W+aEHa72ENs8zhyhLylosjoJVvoK8oOBWyJrozsP9XOFjVIKNVOF4Px5yhHkZpG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qw7D7Vg9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 09:24:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749572674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuFb2et/mtRp7CBWSKuOANqFw+DLi3y5Z+GUeprREfY=;
	b=qw7D7Vg9FCBzL5DNdgf0SAddZHwqcdlH2ysFX5KYsKI1uXiuuQQhyhnzAF18T/aTf9Gs/r
	uHFsceSBut0aizru8xF5IcR3HOwa0GCbzz6z02T3zh2RO0aLkaL3OiMTxOpOXFNXo0SXVC
	wnpJ5SDuV/NxPK1lPUQitXLaZeRJfus=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
Message-ID: <7u4lmf3yd5jlit7qyudbeuhpxvvjrmfq7arfvsxpkqwahm4326@4fbxtdpikosd>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <rtgbcuvajr6oql5xfe5qp7cman2ucatnohux47upknwfoduc5q@63ywqn4tg3jr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rtgbcuvajr6oql5xfe5qp7cman2ucatnohux47upknwfoduc5q@63ywqn4tg3jr>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 12:53:11PM +0200, Michal Koutný wrote:
> On Mon, Jun 09, 2025 at 03:56:08PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > BPF programs can run in nmi context and may trigger memcg charged memory
> > allocation in such context. Recently linux added support to nmi safe
> > page allocation along with memcg charging of such allocations. However
> > the kmalloc/slab support and corresponding memcg charging is still
> > lacking,
> > 
> > To provide nmi safe support for memcg charging for kmalloc/slab
> > allocations, we need nmi safe memcg stats and for that we need nmi safe
> > css_rstat_updated() which adds the given cgroup state whose stats are
> > updated into the per-cpu per-ss update tree. This series took the aim to
> > make css_rstat_updated() nmi safe.
> 
> memcg charging relies on page counters and per-cpu stocks.
> css_rstat_updated() is "only" for statistics (which has admiteddly some
> in-kernel consumers but those are already affected by batching and
> flushing errors).
> 
> Have I missed some updates that make css_rstat_updated() calls critical
> for memcg charging? I'd find it useful to explain this aspect more in
> the cover letter.

For kernel memory, the charging and stats (MEMCG_KMEM,
NR_SLAB_RECLAIMABLE_B, NR_SLAB_UNRECLAIMABLE_B) updates happen together.
I will add a line or two in the next version.


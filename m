Return-Path: <cgroups+bounces-8410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0138ACB5E6
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E41E1BC751E
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17A223DD7;
	Mon,  2 Jun 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3ssEig6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971001EA65
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876093; cv=none; b=DsVyb6HCz4pEiDBEnUkcPn4hJNYPuXuQZFonLsi99hkCDTCsLthBsLw3c8AVvptAipg4TLXbiA77P3dFRGFeO37s77AyuyWZ4oKbXG+iDvWKCYppW9tg5gMX+8pw3PcQowSE+r8kBu1gp8AwSV15Rx0xVf5azUAwXf56m7fmbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876093; c=relaxed/simple;
	bh=iQwc17TdMV/yfeIRfr5oNdWRm+g0Uk/Vj0XMS797H90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsCXqgME6mmgD4jByq91gf76xxUHhc4PtGucwE4JCHcrsigLex81xl4MyYtGJeaR9t6+RxqE/Nz5c4+aMEDghxP5xomvKjJvt+aJUcFRkFJEIZFLBwtxEPcm/fa5FtBpVXvu/f73KysFtZu+AKbE1B8tRxEjgGfmzOIhanqkQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3ssEig6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 07:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748876088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jK+toVOslS/uORtFWGgTjBsPyxhbHB/QR1GNGAJP37E=;
	b=Q3ssEig6oHBpk/690cvZLo0Dzc77n6f2C/I9kPbIl8w4qQmSjZku6OPYh/eKRTO6LuKFiX
	153BJ6V9Hp/ZqIZUv6sMWElPKjoRBHBCocgoDNoPRS99cY3pzh8QM/Qz6JoT1XLG4N6gY9
	VT1HfGdAK9HfjfGcaNhlZy5e4A19ack=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v4 0/5] memcg: nmi-safe kmem charging
Message-ID: <y2eqzgsplnp2fuvlhwk3hogffgjh3d2caohxuwa4dgt7ecznhx@m57r5xhglzyb>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
 <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gqb34j7wrgetfuklvcjbdlcuteratvvnuow4ujs3dza22fdtwb@cobgv5fq6hb5>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 04:45:31PM +0200, Michal Koutný wrote:
> Hello Shakeel.
> 
> On Sun, May 18, 2025 at 11:31:37PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Users can attached their BPF programs at arbitrary execution points in
> > the kernel and such BPF programs may run in nmi context. In addition,
> > these programs can trigger memcg charged kernel allocations in the nmi
> > context. However memcg charging infra for kernel memory is not equipped
> > to handle nmi context for all architectures.
> 
> How much memory does this refer to? Is it unbound (in particular for
> non-privileged eBPF)? Or is it rather negligible? (I assume the former
> to make the series worth it.)
> 

It depends on the BPF program and thus can be arbitrarily large. So,
irrespective of privileged or non-privileged BPF programs, they can
allocate large amount of memory to maintain monitoring or debugging (or
for some other use-case) information.


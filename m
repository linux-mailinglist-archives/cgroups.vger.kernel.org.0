Return-Path: <cgroups+bounces-8692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C7AF9A39
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB701C43093
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FC2DEA6C;
	Fri,  4 Jul 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw6k+IFF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C62D8399;
	Fri,  4 Jul 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651890; cv=none; b=BaJRPQw9IXWxQ8JOPCd5uo8nrwACknovmVgIIe0lrGTOKftsuWtTuRpksfneymXYX8NhvYSxDj4936iXRrezhNThWwumvwOU5WtvxMHI3cB3QZwucDSEF2Csfo9AXhX82ldosIeFZXMO9KRns8jC2MjenYCf66MgkP2Uphsw9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651890; c=relaxed/simple;
	bh=tr+wbAgFMMkU5rZCZHsRAjTchq6ZtzoXQW5LRyTPGvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI8s1pdRyCdnKlNn6CApuzm3wLjF3yQV7ZIn3pB8HkTJOkcB3OpWMawpw4sddhAY/dS9PN52zJF0kCU6k2zLuOglpO4AOPO4qe7QFNFPiiSTx10S9zN+VR3klRgENCVTH/vzfnukDyeLqrKWxZCSuV4KfAMcUa//ovSrfa8IM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw6k+IFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468C1C4CEE3;
	Fri,  4 Jul 2025 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651890;
	bh=tr+wbAgFMMkU5rZCZHsRAjTchq6ZtzoXQW5LRyTPGvM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yw6k+IFFnAHfqtpRHCImiOKoRm2hDqelZ0bsPFKRSEvneE2ypZCxzBf0rNKuraWl2
	 9aINALeRHWfandEyfw7ah7vlG0hbeYy/NBST7OY4o3nz4S9yGydxVjjCc1tAEaDhRD
	 bJQxKS4NXStYtWI/F6Rz7sDfP7OxgGwR0rAVUUI/Qr1bgwjd5sc+1Zzx3zFv7FGzvu
	 zou5MbzSD90hz+VjAGHOdyLNjrLtTUwZB7wOOLyeL6xU0TkXYdH9PBNAJqsH9k22fh
	 3B78vQ6/EDX2QzlCYrzKdH4hVAJZPB0Dc3DSArfeQ/06nxv1Uqiomh/6LrLFCCY9gc
	 5UgRZ5N9f7npQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5367CE0DC6; Fri,  4 Jul 2025 10:58:09 -0700 (PDT)
Date: Fri, 4 Jul 2025 10:58:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <7222e3d3-95ac-448e-ae3d-26b47e29780e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
 <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
 <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>
 <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
 <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>
 <da934450-db48-4ef9-ac1b-6b3fbb412862@paulmck-laptop>
 <edyai2zhaommoe6bqj6tggpp3eu5c6b4trv77vqmktjczkzcrd@ad55qjptzkd6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edyai2zhaommoe6bqj6tggpp3eu5c6b4trv77vqmktjczkzcrd@ad55qjptzkd6>

On Fri, Jul 04, 2025 at 10:45:25AM -0700, Shakeel Butt wrote:
> On Thu, Jul 03, 2025 at 09:44:58PM -0700, Paul E. McKenney wrote:
> [...]
> > > 
> > > Thanks a lot Paul for the awesome explanation. Do you think keeping
> > > data_race() here would be harmful in a sense that it might cause
> > > confusion in future?
> > 
> > Yes, plus it might incorrectly suppress a KCSAN warning for a very
> > real bug.  So I strongly recommend removing the data_race() in this case.
> 
> I will remove data_race() tags but keep the comments and squash into the
> first one. I will keep your reviewed-by tag unless you disagree.

Works for me!

							Thanx, Paul


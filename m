Return-Path: <cgroups+bounces-6115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ECFA0C11F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F82167DF9
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53B1C5D5D;
	Mon, 13 Jan 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSnfPpqB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88B1C3C15
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795681; cv=none; b=F8sPgdYQnLpstu4LXe16/VAnof4LoEjYwbOccBe1bF1cfB1S/NOOM+lYhbcKg7RleZKeMYwXp1zK4x0XvKG+wjaUdU/2Y0eDDME4CU1Yw6j0i2lCyDg83KyuCzPbTSpeBbuMFVnrukFsRIvgu6qND02dZuZ41UJqe2EQ3gn98zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795681; c=relaxed/simple;
	bh=ZDz8xhoJDEcV/pEbTojpQdt7SMjp1CBNyqmLnqAfk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMwSX9p9mvASUbr/LiAX5UVjUob2Y5T32rQiSJvWkVw+NLS1JfD6zDwiOF/TpHS2TlVvrZiICaHhlWAY1UJUEcimWvYZemqsw5GFnR/X1E7jfW/ih0ARfmmhFwhBEFAUIg4zk6oYg0rFNlrvg9XCEWIGNcYsxOoUjwPWmwj3LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSnfPpqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D374C4CED6;
	Mon, 13 Jan 2025 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795681;
	bh=ZDz8xhoJDEcV/pEbTojpQdt7SMjp1CBNyqmLnqAfk5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSnfPpqBBEN3rEN1A/+yC3d5ItDgnfSuZGeOMifBO4t9J2fCQJutiFXnDn+DwNG5y
	 jQPsP3kXGhKVGKXUPHdLP1BlMqcOeHXoNQJeiUSTjK9Iz7VFoIJfYJOOTXIl6MhoPc
	 3CMlrK+tLpiBFlgaGaAaRLSpllZp0PzE63p2Q1e7g54Vp3q8UDIPobbLrAspYvf7qo
	 lLdyDKHyb/relZPz1oQW1vgliJvqA6ybbun9Hpp6MnrYUF+YQwBHs+3aFQRoexZGI4
	 EGsJfxNIwIKBFmDD9x3rjENyyVlbbN25BDOI6vCdy2yVlDQRXEs0xeA78EmHSVn8Cd
	 jATq15a1EAtLA==
Date: Mon, 13 Jan 2025 09:14:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, mhocko@kernel.org,
	hannes@cmpxchg.org, yosryahmed@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/9 v2] cgroup: separate per-subsystem rstat trees
Message-ID: <Z4VmIHRlwYczKFfe@slm.duckdns.org>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
 <Z3hf5wrRuw0KylTh@slm.duckdns.org>
 <zwdpnhzxebx64pbvd5wtwje6gixbu4lifw2qzrmnybledtform@cc6g4bznoz6v>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zwdpnhzxebx64pbvd5wtwje6gixbu4lifw2qzrmnybledtform@cc6g4bznoz6v>

Hello,

On Mon, Jan 13, 2025 at 10:39:02AM -0800, Shakeel Butt wrote:
...
> Here I think the supportive data we can show is the (1) non-memory stats
> readers not needing to spend time on memory stats flushing and (2) with
> per-subsystem update tree, have we increased the cost of update tree
> insertion in general?
> 
> Anything else you think will be needed?

Anything that shows:

1. It doesn't cause noticeable regressions for generic use cases.

2. It has noticeable benefits in the targeted use cases.

The above is a bit willy-nilly but 2 should be fairly straightforward. For
1, the main worry would be whether high(er) frequency monitoring using
something like systemd-cgtop or below becomes noticeably more expensive on a
large and busy system.

Thanks.

-- 
tejun


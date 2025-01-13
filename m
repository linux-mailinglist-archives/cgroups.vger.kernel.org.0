Return-Path: <cgroups+bounces-6113-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA0A0C09A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A6918881CF
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE71C5F0F;
	Mon, 13 Jan 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vFFqsvbG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A21C3039
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793554; cv=none; b=XrewjX8P3u1nPBWuueMUPlCADXRiV8FJfgGwu4ex6ZsYeNBnmJaujUML53wZ/yldIV3c0WdAtzgQRd1ZILtpTZTuuYyMlipnPLYx6SCnG1J6O5pKB5X7hifOGM0IUXjvigNBBbOsnIpBnf0pLLG0Okfwgn/zKzSCjArHY8XT2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793554; c=relaxed/simple;
	bh=wbQ3t7nKoKAGuq84eKntOyoq/qfcCq8bKOoo99GEtvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNuPGx/saHRxcwLOCEz2wmAAssJhDL2UZzk1o4fTZGOJbooWau84Ttra7E9GYsPyHrK/XuUS8magh7JjkHyjw0LaxXbh+SPQyfx5Vn8SQVQkY/FzlUZl7Rbx4MGYND5EMInSOPtfc7WM0oqOW2I36II7m2eBVm+12jp22ETVARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vFFqsvbG; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Jan 2025 10:39:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736793546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/UCRhXYVzb80u83dwZDEreXYoPVjDV1NMvAkaKNMOI=;
	b=vFFqsvbGctLEamklCXfzXi0+GDouo+92NWGi2b8zErWxR0JTEzlkaQvgD/hWRrk0o8TZZM
	cRW2g76edbLorBBqIvo8NPFVzl7bsaczsoDlKQpolsp6MaCBP7wdxJ5hk1JK5ZpMoW6PUl
	0EKtk1OV3l4VweZljPFExsy8+sxkF3s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: JP Kobryn <inwardvessel@gmail.com>, mhocko@kernel.org, 
	hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/9 v2] cgroup: separate per-subsystem rstat trees
Message-ID: <zwdpnhzxebx64pbvd5wtwje6gixbu4lifw2qzrmnybledtform@cc6g4bznoz6v>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
 <Z3hf5wrRuw0KylTh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3hf5wrRuw0KylTh@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 03, 2025 at 12:08:39PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 02, 2025 at 05:50:11PM -0800, JP Kobryn wrote:
> ...
> > I reached a point where this started to feel stable in my local testing, so I
> > wanted to share and get feedback on this approach.
> 
> The rationale for using one tree to track all subsystems was that if one
> subsys has been active (e.g. memory), it's likely that other subsyses have
> been active too (e.g. cpu) and thus we might as well flush the whole thing
> together. The approach can be useful for reducing the amount of work done
> when e.g. there are a lot of cgroups which are only active periodically but
> has drawbacks when one subsystem's stats are read a lot more actively than
> others as you pointed out.

I wanted to add two more points to above: (1) One subsystem (memory) has
in-kernel stats consumer with strict latency/performance requirement and
(2) the flush cost of memory stats have drastically increased due to
more than 100 stats it has to maintain.

> 
> Intuitions go only so far and it's difficult to judge whether splitting the
> trees would be a good idea without data. Can you please provide some
> numbers along with rationales for the test setups?

Here I think the supportive data we can show is the (1) non-memory stats
readers not needing to spend time on memory stats flushing and (2) with
per-subsystem update tree, have we increased the cost of update tree
insertion in general?

Anything else you think will be needed?

Thanks Tejun for taking a look.


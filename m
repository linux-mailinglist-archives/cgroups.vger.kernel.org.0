Return-Path: <cgroups+bounces-6005-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D29FB95D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 05:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C21A1884051
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 04:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E71487D1;
	Tue, 24 Dec 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1+PmMj9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D4EC0
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735016263; cv=none; b=oD2dmYuhQgi6AzdsZHWkIjpq5wnZn/Q6pgnXEjsm2jg5HCHZ00j3G3TIxhToUmqqUN4VVamFw9lzapThmT6Z1sJnqocOXGiyYEc8Y4lX4QNVncDm+FIvuxjmvkwxavlEXYopxbsikYT2qxA01q1KNoZRqR7GKCNuDxIYfJkFd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735016263; c=relaxed/simple;
	bh=SsC8UqEKSdK59Hd0Lj49jVTJpH62h1/GNNAOMBO7cZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghtH1KygDEWFNYHeS1gLfhUjHyXTvhug0tEYi4DHi3JvdKXEr+dYaQzWxPlJflNs2A912IDKNi8PkDg5Wmm3h1FTqxMGHWhklKkT5qek/Ldpmwf5AHlMIGWijAIthrF9lxlXuZ2Vov3nOE+Atf2GLmzeiuwVg1OEOcCYG2Y+YCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1+PmMj9; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Dec 2024 20:57:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735016257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OUPhD9D/XyaTnxrbpjtqlaOp9Yy/bl11ikmJGQUgW9E=;
	b=r1+PmMj9ijyIFFN98Gy8llgZxZSsycRqn7QkP1tGUzMrETvxv6D53K3tVmDlRiU7BRpPl+
	NftWsY8e5sALp7yQer5UMoXOnK6+PepC7Klo/CjhjUH7DUWk7BDU6+/jGYmBKhoPXLnK3f
	pJqGkQbz0B05xCwFNRtI5QYVDLMCjS4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
Message-ID: <gtooi3esj6cnav5xcefvgek647ndziiqkqzbll3x6gwojhzzy3@yumg4ias3v2b>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Thanks JP for the awesome work. Please CC Tejun and Michal in the
followup revisions.

On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn wrote:
> I've been experimenting with these changes to allow for separate
> updating/flushing of cgroup stats per-subsystem. The idea was instead of having
> a single per-cpu rstat tree for managing stats across all subsystems, we could
> maybe split up the rstat trees into separate trees for each subsystem. So each
> cpu would have individual trees for each subsystem. It would allow subsystems
> to update and flush their stats without having any contention with others, i.e.
> the io subsystem would not have to wait for an in progress memory subsystem
> flush to finish. The core change is moving the rstat entities off of the cgroup
> struct and onto the cgroup_subsystem_state struct. Every patch revolves around
> that concept.
> 
> I reached a point where this started to feel stable in my local testing, so I
> wanted to share and get feedback on this approach.

For the cover letter, please start with describing the problem you are
trying to solve and then possibly give an overview of the solution you
are proposing.


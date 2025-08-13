Return-Path: <cgroups+bounces-9137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100CB2520C
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93F7168401
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE91303C92;
	Wed, 13 Aug 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ii8UnpkR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522B303CA6
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105559; cv=none; b=mp41KVqm0sX7MM8ME4+DU8LVP+LNBFlfG+xkpZ+ci7DaOTiPPbnsPRmm5Gv1yvup6lImrmBIXmbveNH1zfc5O0l4eAgaOthDeosZoBl3CK19dPpH6iCSLsbq9HNc9bFJMXEVIR638IEW0uzo9UJk5P1jA9WVAzOvhUh9vZNsHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105559; c=relaxed/simple;
	bh=tlmB5ALZT6K1dJVjXBcEODJRpdYWGeYicDb71U/5IAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj0Y/H52drFo8NNxp7Y83zTB62GF48sGmML47d2LdLqNNSZ7QnfS43dGaT68Pq+hRc8+vS7Qb5Unm3DqD53DKAOaVBk7oQgXHsQIRu4i5sh4Cj3vn1Gl8VGNZwbU8FYqEEZPeBlcPEbcp5bOvVzHa3n5vL1qDMCv8SWK7gdmA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ii8UnpkR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Aug 2025 10:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755105548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1FMi5Yjh1vUlhiqB6XzBhiLfGu5kDDG1EY0MWpuA5g=;
	b=Ii8UnpkRn8GihHXCP3Zq/SnAvVnE3OovoucrWBxYKSrTGYHiRfkf7u46SHtP2x/y6SCoro
	BozREqc2qerr7Q53CpI5AuORNpsev64h/KoMeh2oV7YBavBw/Kz5ZKYVLvJgrWZ0RXtEuK
	7F9Xcs4/yQq3uyzkP/U8Sms1fCzUvgU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
Message-ID: <hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
References: <87tt2b6zgs.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2b6zgs.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
> space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> other entities as well.
> 
> This results in a unconditional mem_cgroup_handle_over_high() call for
> every invocation of resume_user_mode_work(), which is a pointless
> exercise as most of the time there is no reclaim work to do.
> 
> Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
> quite frequently and the empty calls show up in exit path profiling.
> 
> Optimize this by doing a quick check of the reclaim condition before
> invoking it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Since this is seen in profiling data and it is simple enough, I think it
is worth backporting to stable trees as well.

In the followup cleanup, we can remove the (!nr_pages) check inside
__mem_cgroup_handle_over_high() as well.



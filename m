Return-Path: <cgroups+bounces-8061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126FAADB90
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA543BDCFC
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5B1F5834;
	Wed,  7 May 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYHZgKr6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54160157A72
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610728; cv=none; b=KRjE+asZgJVXLIg3n7K/5yQlmDwMRXh3eB3PsfpDVsrjIrHYWPNY46OqtxssEyE9HBjoJLTXiiFhlYvT7paG5S03//ElRl6A6N4zRER7b18IKx1CtBaqijo5WzwgkULjf/W8xlPJOiGbDDTOhbERK0v4vI1H7V6t3bH8YxAZFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610728; c=relaxed/simple;
	bh=YjajqRRZeePhATubqyje9sKAOFGtyTFKjGhYi25L+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk1uajLEL/x+KEXBuk7HR/2LY5nLDSaFnNiw6LaGkWNkSn0nzZqDiTRksAV4VyCPTdv9soJFnFGGYIvVEvmgkG8WXdIcGFNaWsWJ/pPTn9nLO6Mz27k8vxin6fd3w9DkNf6QjIRFD84yPfAobOnCXCTpTqDBCTJAvKnhvrquKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYHZgKr6; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 May 2025 09:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746610724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NFJGp1RVClSap0AYnwWSAeFb8sS4M8MlcNAXXd2fIRw=;
	b=HYHZgKr6fw2U7WWF8/GIHd7+PmX+DNR8Q+7Gj1KhiyGsEl349NvOrqHaVTFqCP4Cc2jq3D
	2ue5UHAsGEhuonEqMjkPSAeDU6ergJDIETm0YnQFN+MoMCjqkB5rJVFOFu9bO79TlyHu5r
	DAidx/TT6gD3KJpPBtl7bJRKmKpvEFQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 4/5] cgroup: helper for checking rstat participation
 of css
Message-ID: <aBsqH3uV9f3ZLSfP@google.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-5-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503001222.146355-5-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 05:12:21PM -0700, JP Kobryn wrote:
> There are a few places where a conditional check is performed to validate a
> given css on its rstat participation. This new helper tries to make the
> code more readable where this check is performed.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  kernel/cgroup/rstat.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index e1e9dd7de705..15bc7ab458dc 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -14,6 +14,17 @@ static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
>  
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>  
> +/*
> + * Determines whether a given css can participate in rstat.
> + * css's that are cgroup::self use rstat for base stats.
> + * Other css's associated with a subsystem use rstat when they
> + * define the ss->css_rstat_flush callback.
> + */
> +static inline bool is_rstat_css(struct cgroup_subsys_state *css)

css_uses_rstat() is probably a better name.


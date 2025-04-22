Return-Path: <cgroups+bounces-7715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DFA968F5
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC201189C902
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D527CB06;
	Tue, 22 Apr 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SamnuCE5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37F221289
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324396; cv=none; b=OusPNq8oHQcYxU3l89fox2RypGZzMIioJ+SaPLoCKpjyuHAHqLQ/49vlQJF/QFdztcg/o4d6BNAThrXa3g5gHM9bSLnXemPRvrU6I6Q2zUg9qchi7f1NaWvXY/SwHXvg1xrKcvRuU5D6WCtFfN5RW9ZQ4M1sjPgyCsp6Ss0P2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324396; c=relaxed/simple;
	bh=WsJLZ4Bv2O0zLqGe9n6k0wHZjTKwMMz/IOgYuODd7PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlkXEkNrstigVIbGYlXsRs+NWd0z5c6sKxZdkITB4z44ePo9KSIcNNBwJElZVy29oLG4/zbcJatcLgSCj+w0Bi9ABzVc1M7LMgrTMNqtlylR6uNCKfJf9d/dVs1T/o0pgbqjBE+lLeG9wIqCtmic/fyV9XwPusaRQ31a8YJDy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SamnuCE5; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 05:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745324391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZN/S6ZEB/OJYdPCK1ALmUFr/Qw2WKTr4CjCWyb5ueo=;
	b=SamnuCE5AuaQnwULf2yCoQOuPi5KT+58AIilu9BDwGpQgfJ8of6sSMt63BbR2mOP8hwKlP
	oikgToX4eQLP2r6vfizd/ix9guTNj2D4w2Ywf22405kpgqgJFvyHHrL336FlwpzJdjxgB9
	NvqGw1nr3R7kyNpuU09WrxwIXnruKuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] cgroup: add helper for checking when css is
 cgroup::self
Message-ID: <aAeJZO_Y3_IeDvwy@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-3-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:47PM -0700, JP Kobryn wrote:
> The cgroup struct has a css field called "self". The main difference
> between this css and the others found in the cgroup::subsys array is that
> cgroup::self has a NULL subsystem pointer. There are several places where
> checks are performed to determine whether the css in question is
> cgroup::self or not. Instead of accessing css->ss directly, introduce a
> helper function that shows the intent and use where applicable.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/cgroup.h | 5 +++++
>  kernel/cgroup/cgroup.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 28e999f2c642..7c120efd5e49 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -347,6 +347,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>  	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
>  }
>  
> +static inline bool css_is_cgroup(struct cgroup_subsys_state *css)

I think css_is_self() or css_is_cgroup_self() may be clearer given that
we are basically checking if css is the same as css->cgroup->self. As I
write this out, I am wondering why don't we check css ==
css->cgroup->self instead (and perhaps add a WARN to make sure css->ss
is NULL as expected)?

This seems clearer to me unless I am missing something.

> +{
> +	return css->ss == NULL;
> +}
> +
>  static inline void cgroup_get(struct cgroup *cgrp)
>  {
>  	css_get(&cgrp->self);
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 77349d07b117..00eb882dc6e7 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1719,7 +1719,7 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
>  
>  	css->flags &= ~CSS_VISIBLE;
>  
> -	if (!css->ss) {
> +	if (css_is_cgroup(css)) {
>  		if (cgroup_on_dfl(cgrp)) {
>  			cgroup_addrm_files(css, cgrp,
>  					   cgroup_base_files, false);
> @@ -1751,7 +1751,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
>  	if (css->flags & CSS_VISIBLE)
>  		return 0;
>  
> -	if (!css->ss) {
> +	if (css_is_cgroup(css)) {
>  		if (cgroup_on_dfl(cgrp)) {
>  			ret = cgroup_addrm_files(css, cgrp,
>  						 cgroup_base_files, true);
> -- 
> 2.47.1
> 
> 


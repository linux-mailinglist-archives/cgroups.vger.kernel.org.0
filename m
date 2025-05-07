Return-Path: <cgroups+bounces-8058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACEAADAAB
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5254E4954
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74122D4D7;
	Wed,  7 May 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dljyweor"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B522AE4E
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608584; cv=none; b=SduebIAH/RmfGmNbsVZCqeXH7HB9d7vfv0wEWFPpLmYJrbY+mimzJfulP0N6i8Q54L50HUU54e+Ep0Le18igtLqTxYzzsQ4jmfkBPW+FzKWeCu7cNB8G1usLEQHuBL/rTNJgAyorqQQkBWI1l6i/o/sQkU3ZMwhZikr9JMb9+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608584; c=relaxed/simple;
	bh=93Ziety+qfDd2LoxbIwSHUHFWQlG9cVYOiUDxqhvL0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWJsGgBoxs3+bbSHkdZ0ybIpvPpNU97BBy2jAIM7MtGhztQoCkxL2VCR2fWW+FnptQUcvTANSo3r/SgsAL1VsbOFwp9irXfvxw0sQecE5E8LhHm8v/K3mdIJWAVSlm8sBtW1rnJVtIZ55efkj2V7Swo3yldDNZjavFs6074p4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dljyweor; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 May 2025 09:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746608578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+y1XaeJDOit7AyGV+nMns1m2raZLQt+o4kfDqKhM/eU=;
	b=DljyweoroIotsDR8lGb4KqsS2vdmPe9ZIuETt6fV/1dHx+3oAufPawn3ifZnYgwCpGvPbr
	8fzJ9mdtt/PJzXCx/TERsm8rbmic8FdXi/P9udLSfl9vFaWzfbT8P5XJgI2mxuqf5Xhigt
	oUlo/eNfPBat3chJsDP9P0CGx3XAd9Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 1/5] cgroup: use helper for distingushing css in
 callbacks
Message-ID: <aBshvNRl6fCGKVmS@google.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503001222.146355-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 02, 2025 at 05:12:18PM -0700, JP Kobryn wrote:
> The callbacks used for cleaning up css's check whether the css is
> associated with a subsystem or not. Instead of just checking the ss
> pointer, use the helper functions to better show the intention.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

I still think this should be renamed and potentially reimplemented to
(also?) check css->cgroup->self, but anyway:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  kernel/cgroup/cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 7471811a00de..125240f8318c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5406,7 +5406,7 @@ static void css_free_rwork_fn(struct work_struct *work)
>  
>  	percpu_ref_exit(&css->refcnt);
>  
> -	if (ss) {
> +	if (!css_is_cgroup(css)) {
>  		/* css free path */
>  		struct cgroup_subsys_state *parent = css->parent;
>  		int id = css->id;
> @@ -5460,7 +5460,7 @@ static void css_release_work_fn(struct work_struct *work)
>  	css->flags |= CSS_RELEASED;
>  	list_del_rcu(&css->sibling);
>  
> -	if (ss) {
> +	if (!css_is_cgroup(css)) {
>  		struct cgroup *parent_cgrp;
>  
>  		/* css release path */
> -- 
> 2.47.1
> 
> 


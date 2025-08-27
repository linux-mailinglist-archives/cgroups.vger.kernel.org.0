Return-Path: <cgroups+bounces-9443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776BB387BD
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A323A9F2D
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0523C4F1;
	Wed, 27 Aug 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjJ9xvvq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB22116E9
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311947; cv=none; b=QbxbsEFDO1tmrZpQxOXSLRY7evfi4MbYUekTNKlsw1kWMJmsTqZJ+9t7LysHzZmHUtDLiS8ecGZINgi15uhrh8/vig44yKxErY83yVoTMHqxXiqnSV6QAszRVE+/RDqM9l1mP8Nc8/4Xze20TYzwfm9u7xOuYjvL02ElgA8Jxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311947; c=relaxed/simple;
	bh=gUhEN5tEu43m9pD4c2NTudOZiEOt6pOHbaOxrqZLM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGbx4BOe0q9W7vsqxztSErdn1/gCAf1YJslkCiU6nVYbxJHxDfvMrHaPIi4p+xzocvDBg3/aC/Tv9H4BN+fwD9yovkV6YH8Cka8vNI+haB/OFEoLALcyV2kzg3Ki9Wjx3OU+styTrEwYo6sDXaW8r0h/uy7pia6h07qc5iVcQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjJ9xvvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518C9C4CEEB;
	Wed, 27 Aug 2025 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756311947;
	bh=gUhEN5tEu43m9pD4c2NTudOZiEOt6pOHbaOxrqZLM0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjJ9xvvqWUAkSFGEZk8Qpb8Z4fK1Qez66zMB16FAR3EZRXnPfFN+/M2VtQB7EJWKd
	 ZBVYQPaWkqpX3gtXw9Bgsu9dhQuBucLWt6n/PIsjvGhd9exmyGw9JMcLpwiuwsTTf5
	 Bu5SdCVAsmndsNVwXIys2J9gOTGHw/+zCtzQHhH7L8SAspXOz73z3ExXCNV410mU0r
	 GMTmGzLJypWrwJKdaohy/mMOjdMrzTX56Ky9OFHzGGwc0BRTyqBE2HSyks7YIUxz/M
	 lZ4wKql2/5whmPBdC5zYVbDo7ytdAUcJoVecvnDsm/kln+NS+b0awHkz4Wy1SSyTDf
	 6XtAohwc0RssA==
Date: Wed, 27 Aug 2025 06:25:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, jack@suse.cz
Subject: Re: [PATCH v2] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aK8xilDSEaRB3mjj@slm.duckdns.org>
References: <20250826121618.3594169-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826121618.3594169-1-sunjunchao@bytedance.com>

Hello,

On Tue, Aug 26, 2025 at 08:16:18PM +0800, Julian Sun wrote:
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 785173aa0739..f6dd771df369 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
>   */
>  #define MEMCG_CGWB_FRN_CNT	4
>  
> +struct cgwb_frn_wq_entry {
> +	struct wb_completion *done;
> +	struct wait_queue_entry wq_entry;
> +};

Why not embed wb_completion in the sturct? Also, can you name it
cgwb_frn_wait instead?

>  struct memcg_cgwb_frn {
>  	u64 bdi_id;			/* bdi->id of the foreign inode */
>  	int memcg_id;			/* memcg->css.id of foreign inode */
>  	u64 at;				/* jiffies_64 at the time of dirtying */
> -	struct wb_completion done;	/* tracks in-flight foreign writebacks */
> +	struct wb_completion *done;	/* tracks in-flight foreign writebacks */
> +	struct cgwb_frn_wq_entry *frn_wq; /* used to free resources when release memcg */

And the field just "wait". I know wq is used as an abbreviation for waitq
but it conflicts with workqueue and waitq / wait names seem clearer.

> +static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
> +					int flags, void *key)
> +{
> +	struct cgwb_frn_wq_entry *frn_wq_entry = container_of(wq_entry,
> +							struct cgwb_frn_wq_entry, wq_entry);
> +
> +	list_del_init_careful(&wq_entry->entry);

Why list_del_init_careful() instead of just list_del()?

> +	kfree(frn_wq_entry->done);
> +	kfree(frn_wq_entry);

If done is embedded, this will become one free, right?

Thanks.

-- 
tejun


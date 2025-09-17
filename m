Return-Path: <cgroups+bounces-10214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E4B81580
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F423B17B2
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3B23E354;
	Wed, 17 Sep 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcTTOeFX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245A34BA33
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133877; cv=none; b=VEgwOurtWOUSdm974ySquL7FFH1Jcxz2TX7hNhmIcR8fHrVBLm6M/hkAQmHiYZY0AnPVcJFe3QuyqIClRgM8R5bNC5T7Qhr8r29O3Y5v9KlRtYl626QU3kfEJMo6Ea0/nLrbvUg7dHZzf0rm/Y58Z3lR4pI4VswayvDM4N6gz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133877; c=relaxed/simple;
	bh=qc2L6Az/Nqo9MlJoX5qAK3vvs94xYepHejoFP3CW/EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7iH+1zEd4DKRyslGxhSbUsn9D9GSo5GfFLr6CqaC/VqwtKNtPxkDqGJysdj2tnb8bnM5eBX1XYpTL3p6znfWKsAiLgv8/PCLc4IW31k1qC4h0ShZO+o00h2VSRWtwK4z9V9cURvhbiTiFW5ERGDCHkpUZZXHYVQyE9jKXpX7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcTTOeFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61E1C4CEE7;
	Wed, 17 Sep 2025 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133876;
	bh=qc2L6Az/Nqo9MlJoX5qAK3vvs94xYepHejoFP3CW/EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcTTOeFXPkJ39QfkZjd1hm+LU1GcwQTEzQRlYvljHLGSvvaSE6LpZD9kBUr5g3flM
	 3X/tSCXRL2zXvypjdD1V/1mrxWnRn87z4HzsOwZXJqCQQtWGEmOW9hATdqPVmS5JZ6
	 i1VTt0G4xQh3KBdIDm5nim6cpH+fhAXccliVaZaQEQGeuUt2O4WfdC9+7/Hoj1Ei0E
	 5wGisV00xMrac9Q/f3OSpzddKDtpLIIRfEa9ZM8B5ibZk5pYBR+39HyX6ZecM9j5Vg
	 UD0n2+fANWqpqOu754kjZMRglvxPp3c2TbqscV8BfSEGs9HNzIxSbU6YbmhIMhtuWY
	 UMXzyZa9gPgBw==
Date: Wed, 17 Sep 2025 08:31:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	muchun.song@linux.dev, venkat88@linux.ibm.com
Subject: Re: [PATCH v5] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aMr-chVzDBfU7BvF@slm.duckdns.org>
References: <20250917150125.331701-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917150125.331701-1-sunjunchao@bytedance.com>

Hello,

A couple minor points:

> +struct cgwb_frn_wait {
> +	struct wb_completion done;
> +	struct wait_queue_entry wq_entry;
> +};

Can you add a comment on top of cgwb_frn_wait to explain how it's used and
why?

> @@ -3912,8 +3940,21 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	int __maybe_unused i;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> -		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +	spin_lock(&memcg_cgwb_frn_waitq.lock);
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		struct cgwb_frn_wait *wait = memcg->cgwb_frn[i].wait;
> +
> +		/*
> +		 * Not necessary to wait for wb completion which might cause task hung,
> +		 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
> +		 */
> +		__add_wait_queue_entry_tail(wait->done.waitq, &wait->wq_entry);
> +		if (atomic_dec_and_test(&wait->done.cnt)) {
> +			list_del(&wait->wq_entry.entry);

__remove_wait_queue()?

Looks good to me otherwise. Can you please cc Andrew Morton and memcg
maintainers on the next post?

Thanks.

-- 
tejun


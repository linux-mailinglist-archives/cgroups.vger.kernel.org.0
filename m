Return-Path: <cgroups+bounces-7436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB872A81462
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 20:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954844C220D
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976223C8C3;
	Tue,  8 Apr 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="qyeKAMjP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C9237163
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136234; cv=none; b=pff8W8OXk73sNiq8Hb2j+O/AnVtIX+jdSD9xsv43XL0HJe8jLejqUCiwP0VIlnHXjDdJWz6yybTYKsvZzdCWFcESUjOpn0ecu++DTlhXzmhrYfcW4Uhx9MXCVVs5x3yeqVi1P0w+KHFitWh/JkcUtJC7e0uuTfvdy6P5YYlCcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136234; c=relaxed/simple;
	bh=ydoM4qAHsauaE2BUGJHhRcKs6UHNR6BdfdHPHQA0l28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk4SBIpZt0kJYKDkcLNceUpvT4TbdMWcBHqklFXbFUqEsuld0bo6IcKYWN/G1iO6bYou9gVKjqdBfusf04JaPVMh/6FCHsU2StJdODSj6KyLKuSIzvMJoKeJAg1EB7X1AAyWdgWhZdVLr7w6tWIwkyRrUPfj13/DpL5dqX89a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=qyeKAMjP; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecf0e07954so79986286d6.1
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744136230; x=1744741030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrHRR9y6PG02gx4V+fHyD3RAGrPoiHPM2zS7NCT7idM=;
        b=qyeKAMjPriSVS2tSfcyEXmV8elom2Or1W7p901YhMUzf1FCnvD2i7i/Fwti/9LFxAo
         Jm9oh8a9MW9xAnbxzk1P+uc36RGH384lSAqw7fRSYrs9f8l1XHwKdEKswsqCvC9dVYum
         KUVoJY1p05f6yeWmYp6PqjhSc/VjU1mxqDc7lKiEfsgwiD2Ih/qKj51ZJhhbiZwxuTkf
         j7bLRQkBetKwHAYhqn3xhbSdi8FXWXrUabq2SjeyqTA+aFBPajtw8N5Tj4kpxxWtSaTn
         1u7PPN9uRM16JGk2wqvbkCXD5/kp9pcnzBIqEVuDbZeNWpXXYWHgUJp7a2KkID0TEiqr
         M/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744136230; x=1744741030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrHRR9y6PG02gx4V+fHyD3RAGrPoiHPM2zS7NCT7idM=;
        b=xGA+AUKgEmjptjmT2n6jGkAOVZp5dwhm0S7UepmwKnvExddhPP+FUbWkyjZUCVzbaK
         kYmv5LlqTjqZS6XEpJK1Ix5mDMRCNaBII2jCUsWCGYQv+fhw2gcf5MPW5xGb51IXOlR+
         EjYM39EisngjuYfOAXLm/+8Tn6vEtLRaMCDs855kBNcOEMbJGjBzteMdc9gTnUhyE5ON
         IEeaiTA3FVuOBTsuL/1r7wJ48H7oMe5Ga5IA3PH4xm0WXBc6EZSyA2kIEc+KE0pQQp/a
         EDGEFinF+00FIow+NHLh4wykv4l75PmvRYY28eZRBuCCW4b6uDwcFiHheWwflnFmGpaJ
         vcOA==
X-Forwarded-Encrypted: i=1; AJvYcCUURX1BFp9poA7hckJA7ClRtF+Mv4l+50X7HC4jI8sNxiU5Qe+RmIu2HVOPyqblpGB9pbteJp0q@vger.kernel.org
X-Gm-Message-State: AOJu0YzivmrBt5HVcW0f8uEKd3JYy+pyO9fqN98leiLu02BA3YWyOBcW
	YpBLUcQCOaenzYFrysqMzsx/1OrQp95cxdr+pirx65pZtiy0cyBx5aXUCLjemyg=
X-Gm-Gg: ASbGncv0BSuQ0D/dpnvMLDnK0ZX2vgAbPXzm60zfpPThb4fF7UIo+V+2pcBD0vXk4iS
	vZXtdcMz/OxvRqIPalIz2TP3VKA5kRA18rnt2lETXcAZbKlw/90JFkyXNRgegHc4jFKKSzVlL7y
	2GyCYDol5DgLxDPi9hXaQMkMJFzqhC8l/ACVOAIvW096TZc3ekZEqhdKYNYOf21dMlFp3dEIrQC
	XPQGjSTij5TS8PTfND71/bthkHmRADZMXBTcwzrmQsoTH0yw3ZczBdlrHxxtb4FLUaHZ7kzkoJ9
	X0N9pB8iYyBerkHTYETfqRPEyIEqfQKou8ghDNI88wc=
X-Google-Smtp-Source: AGHT+IGetL0w8Iqx6ksx4UMXO4UBW+UpVV0Mr2wV49qnLQpAF+xnj3dG0U6YvK047fPnsSyEL3Dviw==
X-Received: by 2002:a05:6214:1c46:b0:6ea:face:e33f with SMTP id 6a1803df08f44-6f0dbb80e6bmr4085246d6.3.1744136230650;
        Tue, 08 Apr 2025 11:17:10 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6ef0efc0d42sm77385086d6.13.2025.04.08.11.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:17:09 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:17:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: Re: [RFC PATCH] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <20250408181705.GE816@cmpxchg.org>
References: <20250320210919.439964-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320210919.439964-1-gourry@gourry.net>

On Thu, Mar 20, 2025 at 05:09:19PM -0400, Gregory Price wrote:
> @@ -4296,3 +4296,13 @@ void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
>  	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
>  		   nodemask_pr_args(&task->mems_allowed));
>  }
> +
> +bool memcg_mems_allowed(struct mem_cgroup *memcg, int nid)

This should probably be

	cgroup_mems_allowed(struct cgroup *, int)

and then have a

	mem_cgroup_mems_allowed(struct mem_cgroup *, int)

that does the e_css translation, with the necessary dummy functions to
work with all CONFIG combinations.

> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +
> +	css = cgroup_get_e_css(memcg->css.cgroup, &cpuset_cgrp_subsys);
> +	cs = css ? container_of(css, struct cpuset, css) : NULL;
> +	return cs ? node_isset(nid, cs->effective_mems) : true;

You need a css_put() to drop the ref from cgroup_get_e_css(), but
otherwise accessing css should be safe this way.

AFAICS you need callback_lock to query cs->effective_mems.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2b2ab386cab5..04152ea1c03d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -342,16 +342,22 @@ static void flush_reclaim_state(struct scan_control *sc)
>  	}
>  }
>  
> -static bool can_demote(int nid, struct scan_control *sc)
> +static bool can_demote(int nid, struct scan_control *sc,
> +		       struct mem_cgroup *memcg)
>  {
> +	int demotion_nid;
> +
>  	if (!numa_demotion_enabled)
>  		return false;
>  	if (sc && sc->no_demotion)
>  		return false;
> -	if (next_demotion_node(nid) == NUMA_NO_NODE)
> +
> +	demotion_nid = next_demotion_node(nid);
> +	if (demotion_nid == NUMA_NO_NODE)
>  		return false;
>  
> -	return true;
> +	/* If demotion node isn't in mems_allowed, fall back */
> +	return memcg ? memcg_mems_allowed(memcg, demotion_nid) : true;
>  }
>  
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> @@ -376,7 +382,7 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>  	 *
>  	 * Can it be reclaimed from this node via demotion?
>  	 */
> -	return can_demote(nid, sc);
> +	return can_demote(nid, sc, NULL);

This has appropriate memcg context from get_scan_count(), use that.

> @@ -2654,7 +2662,7 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>  		return true;
>  
>  	/* Also valuable if anon pages can be demoted: */
> -	return can_demote(pgdat->node_id, sc);
> +	return can_demote(pgdat->node_id, sc, NULL);

Make this take an lruvec, then pass lruvec_memcg() to can_demote().

shrink_lruvec() already has the lruvec.

kswapd_age_node() has to do the test from inside the memcg loop, since
demotion and thus aging now very much depends on each cgroup's policy.

>  }
>  
>  #ifdef CONFIG_LRU_GEN
> @@ -2732,7 +2740,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>  	if (!sc->may_swap)
>  		return 0;
>  
> -	if (!can_demote(pgdat->node_id, sc) &&
> +	if (!can_demote(pgdat->node_id, sc, NULL) &&
>  	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>  		return 0;

MGLRU, so grain of salt, but that memcg looks appropriate for passing.

> @@ -4695,7 +4703,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>  	if (list_empty(&list))
>  		return scanned;
>  retry:
> -	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
> +	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false, NULL);

This also seems to have appropriate lruvec/memcg context.


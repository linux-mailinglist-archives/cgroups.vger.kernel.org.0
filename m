Return-Path: <cgroups+bounces-6623-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711FA3E208
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 18:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993D51880226
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0B225795;
	Thu, 20 Feb 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EVsc3N7a"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201B22257D
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071214; cv=none; b=LK/i1KhlELbxXBpvMNBUZ8imO9CSRQLBuZDxUskiy6BZKHlSSthM32uea9HjyVbknOTJDKwOpcnwlzud3RlwxX03m5Gmet3TQfMiavVG+hkg3R8iiXPtriAJKXW8Sx+YHOKPhi89VovuGyZqIiA+vkRP1Bl7rLe5VZfs46S0480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071214; c=relaxed/simple;
	bh=QwFELQ1FFVe05nVDqmbbjjqF9znyGaS+mLcfWWF6IAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R92I5tk/15WzIGPm2Tjrg/wJRtvmvA7IfCQnwe93HRrR6+gkANzE6b0PDp+hJDuAVRmKRx+QkJKMWRTwmT6OlnAk0IW/tchT8uLJ8OhsYj7OSuxuEz824nosVoEvHVR3Iu0NkgrUTL9jRamz+xHzhcCm7SgabiWZfb2R9bThchM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EVsc3N7a; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 09:06:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740071208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeOiPofC0Wf/SoLeRvk4/6gQcNmvxbVkQrbXQBS3smY=;
	b=EVsc3N7aYu9iU1Oyhu84fxdNxh8mv871Ivx9S+7vP1nspverlLlZ2e4pSU4aZJinqyHLAB
	XZTRzgfLdiGJ/p1KBG8N8g4XdPJSU7P/N8R3Dl4gY3xNxCcSRqHBJAIY7E71sC/1KWCps4
	bvpYsGH4q4L13aO6gxVdEtlikRt3I6c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 03/11] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <yz6jmggzhbejzybcign2k3mfxvkx5zb6fxlacscrprbjsoplki@6x5dtnmzks7u>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-4-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:40PM -0800, JP Kobryn wrote:
[...]
> @@ -3240,6 +3234,12 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
>  				css = css_create(dsct, ss);
>  				if (IS_ERR(css))
>  					return PTR_ERR(css);

Since rstat is part of css, why not cgroup_rstat_init() inside
css_create()?

> +
> +				if (css->ss && css->ss->css_rstat_flush) {
> +					ret = cgroup_rstat_init(css);
> +					if (ret)
> +						goto err_out;
> +				}
>  			}
>  
>  			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
> @@ -3253,6 +3253,21 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
>  	}
>  
>  	return 0;

Why not the following cleanup in css_kill()? If you handle it in
css_kill(), you don't need this special handling.

> +
> +err_out:
> +	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
> +		for_each_subsys(ss, ssid) {
> +			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
> +
> +			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
> +				continue;
> +
> +			if (css && css->ss && css->ss->css_rstat_flush)
> +				cgroup_rstat_exit(css);
> +		}
> +	}
> +
> +	return ret;
>  }


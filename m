Return-Path: <cgroups+bounces-14989-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDUxE8v4wGkwPAQAu9opvQ
	(envelope-from <cgroups+bounces-14989-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:24:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F02EE3D6
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E837030089AA
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65097361DD9;
	Mon, 23 Mar 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZ0s0zSz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9FYhFWW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDC36E498
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254276; cv=none; b=MmNMM6wXqxUrwKH5hPKWpVJt15+j6/nUv+Tr8SIixWoFM+bzQ5eKGR73BnGeehvDADEDllCZovhu0QSNDMzPZ0Qqn2E6AMXqczLnqhkC+dVTnaaQIHlRsC0C1a9FNeQEZq8++hpOuVVD4M0wA7ONJLuad2wUA/72eCiLjgQSXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254276; c=relaxed/simple;
	bh=df45W3b6valvoQMlkMLb0VHRpJX8Uz+L2ySSMYD4XXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGEQlCV1pCIh6gIfu13NTVLVqQzJIOcbtlpt/Z+3qYQz24RbMq/+gRK4IpJHp1ewJRz20oCJvKtgDtXfg2gvvPIQ66JZc2Msi2m58MY1lh2N8NNEkdd4cLNQmQyvaphMQ9KAi1TvcVf2A7uxjsG/OOaKLi1rMRaTPuWLdXXUsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZ0s0zSz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9FYhFWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774254274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4FYRZcJce0iqsefU7RH85JSFRG+Uej7mvnkE77jdLA=;
	b=FZ0s0zSzjhycAk8kyZrLZC2TO/LH71l2dtiXEGb3Ypr/stFphelQoZ3f0ZqaxsCQwMGTL6
	dEhQwwU4DzWM//2p8BNVroVMKFNVn6KZxNUjLxHtuGXBAAQKgq9KTM15RCD5/RprJg3eAO
	Kvocrrf+nfc1dNLJyVLq4Md4A3MBmAU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-fiYj3cgnOGye6Ydss-6O1Q-1; Mon, 23 Mar 2026 04:24:32 -0400
X-MC-Unique: fiYj3cgnOGye6Ydss-6O1Q-1
X-Mimecast-MFC-AGG-ID: fiYj3cgnOGye6Ydss-6O1Q_1774254271
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b05d170cadso38905465ad.0
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774254271; x=1774859071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4FYRZcJce0iqsefU7RH85JSFRG+Uej7mvnkE77jdLA=;
        b=c9FYhFWWRi2AaYoVWUfTGwqs/GLD2qRipVQK3OCa2/MIGQQWusjRbYuR5XdMYueUjV
         UwvMsWav3yfYMo4N03Q7rqcoCqKwGImrHzb9pK0x1mYPewE8x2p85YOFWnLU3NIP/177
         KD1NW2Buqb9i8ymifPtr/2KXuAYlBLatqKJt8VAgINXQNVPSYXx8jof/otWW9bwtEJ/C
         YyNuAlOotLCl+Sxq929n0Wg4xeqKJrvilfiB2CQObpvZbikBm38kI72TzdiVOGhH2FLa
         xZWakjeO8zKWgb32e/Lh3EQni1WKxq/xUeaIhhb0ev/XOWneML6vPxi+VB+aAlKgyTWi
         ATcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774254271; x=1774859071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4FYRZcJce0iqsefU7RH85JSFRG+Uej7mvnkE77jdLA=;
        b=HicgqptCp3zouhMMJYZnfB/wgdLHivYfiTHwC/xUiuYVXcrKShlqVks/Dh8V7cA9qn
         RlY+DBm7mUoyrRznoAsvEz95JOLMZPLKthw48agIQkurG8M8k0jkHqtrCbRVlZpVVh+s
         Aa4rOwgfxf9zQTn2HYoAPBazmWxXoXcV2fM6dAkOcJmkmTdeBHxRHiRVqErg2t1YtDse
         q+apiBNkeric8GosFQEasG9wrqTdOqcFo54Qx+CE5W1ZX8ax5f3LKrp84s1DK2xA3iT6
         lD1+G9pm82ieGHtE9uRyez62J4n72WWMThCs5SknDUxwfkkQGk4g8+OtGoAFAxMIlMko
         SPZw==
X-Forwarded-Encrypted: i=1; AJvYcCXF9OcdijbqtIFXxy3A9GbjzvTBVHyJYHN/pX5kATBag/EncGPMwpvfb0BirZ2Cab0jTESxezuq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEJ0yTzyhHhtH821EAYi026vDtKRZ5JErzJJJ7p2QBZQSqHJf
	QyleTsdzxqN90mgGypfG0aT3NGDEAmC1o89M9f0Sc5585ArRg+V6uP7XuLgy5NP0CoxTZw2GeTq
	ADz5qaabyuVuruS3RFVuKiEUzm7hDSHv5zbSeVY+hL3lbIh9USZUyiIWgztk=
X-Gm-Gg: ATEYQzwwSRYbehm79rsRvSOUr+nWTdHX2DAKmklk060ff11XYsMdA7Mcl9lrSKja75o
	2jBV5OOSfLKAM7FpYws/qYk85IxznnRZAMnR7axcTbDz/qFT1egUrfdCwL42LyYCKfzMJBu2/y7
	+7/aumaJ9+rADpQXH/A0QJRWU1davl/NVTf+isWdogDV7ApUBALpig6o0WrDDvgFnCQ4MEN0j8j
	/iRt9ObMrUsNGeXKGM2rFHseVBxADt52PZFgd+P4JUKOuyA18hd2sOxwXxIMwkOyP5GZwZyp6iS
	ZtVH2/UWSy3/Xj5yalq3GwVSFXLrFaLZpE3xe1lFyXeEeG6nCSPR4xYDLmkha+SVJ8UFHDOT4Xy
	GbDG7tRJxoM3JL79TBQ==
X-Received: by 2002:a17:902:ccd2:b0:2b0:5682:6973 with SMTP id d9443c01a7336-2b08273d0d4mr101278445ad.19.1774254271392;
        Mon, 23 Mar 2026 01:24:31 -0700 (PDT)
X-Received: by 2002:a17:902:ccd2:b0:2b0:5682:6973 with SMTP id d9443c01a7336-2b08273d0d4mr101278345ad.19.1774254270964;
        Mon, 23 Mar 2026 01:24:30 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365a62bsm136181655ad.46.2026.03.23.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:24:30 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:24:28 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 5/7] selftests: memcg: Reduce the expected swap.peak
 with larger page size
Message-ID: <acD4vGZKveXJ4GuW@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-6-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-6-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14989-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC2F02EE3D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:39PM -0400, Waiman Long wrote:
> When running the test_memcg_swap_max_peak test which sets swap.max
> to 30M on an arm64 system with 64k page size, the test failed as the
> swap.peak could only reach up only to 27,328,512 bytes (about 25.45
> MB which is lower than the expected 29M) before the allocating task
> got oom-killed.
> 
> It is likely due to the fact that it takes longer to write out a larger
> page to swap and hence a lower swap.peak is being reached. Setting
> memory.high to 29M to throttle memory allocation when nearing memory.max
> helps, but it still could only reach up to 29,032,448 bytes (about
> 27.04M). As a result, we have to reduce the expected swap.peak with
> larger page size. Now swap.peak is expected to reach only 27M with 64k
> page, 29M with 4k page and 28M with 16k page.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 26 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index c078fc458def..3832ded1e47b 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1032,6 +1032,7 @@ static int test_memcg_swap_max_peak(const char *root)
>  	char *memcg;
>  	long max, peak;
>  	struct stat ss;
> +	long swap_peak;
>  	int swap_peak_fd = -1, mem_peak_fd = -1;
>  
>  	/* any non-empty string resets */
> @@ -1119,6 +1120,23 @@ static int test_memcg_swap_max_peak(const char *root)
>  	if (cg_write(memcg, "memory.max", "30M"))
>  		goto cleanup;
>  
> +	/*
> +	 * The swap.peak that can be reached will depend on the system page
> +	 * size. With larger page size (e.g. 64k), it takes more time to write
> +	 * the anonymous memory page to swap and so the peak reached will be
> +	 * lower before the memory allocation process get oom-killed. One way
> +	 * to allow the swap.peak to go higher is to throttle memory allocation
> +	 * by setting memory.high to, say, 29M to give more time to swap out the
> +	 * memory before oom-kill. This is still not enough for it to reach
> +	 * 29M reachable with 4k page. So we still need to reduce the expected
> +	 * swap.peak accordingly.
> +	 */
> +	swap_peak = (page_size == KB(4)) ? MB(29) :
> +		   ((page_size <= KB(16)) ? MB(28) : MB(27));

Or, go with a dynamic adjustment based on page size?

    swap_peak = MB(29) - ilog2(page_size / KB(4)) * MB(1);

-- 
Regards,
Li Wang



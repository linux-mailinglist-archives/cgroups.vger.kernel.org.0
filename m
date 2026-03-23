Return-Path: <cgroups+bounces-14987-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MpmGZL0wGkwPAQAu9opvQ
	(envelope-from <cgroups+bounces-14987-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:06:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9492EE0F5
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 09:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AECA13031314
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47275361DA7;
	Mon, 23 Mar 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIW+EtBq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="izw/pqxL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E092FFDDE
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252916; cv=none; b=kBqZ7vfwVuU7ERr9WoegYyBxmYzZeSh5og6L3dYYOfvA4gp1vq15YZOlp+2SDQbLmd4Me0L8qYEda1mFz+ZKNKLxdleKZdFmNI3S2Kn7lHbwuyreJqRfu33rsHiseP1RLPTfjbjN4fFu4wsUkOI72l3KWzrmW0a3oeAa/mWmWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252916; c=relaxed/simple;
	bh=kAtaH+mqS1nASzQ56xfnzIyJ9ONmFmkFr7Aq2kvL10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1b9+LwH7IDenpUyL68nHqNQ+5KlRDugjaAq2M2DJ/Qz3D+X4TN/ElkCE9w3eAziXZKSxx+dEI+PGmJbwnjaGjnk2gk+NWTZ/N4TOIcJapUwpBvHeLP2fdBg8pm3841eZ/ZkgwhqjY98jiLgxZIqo9JtaZBarLJFFeIzki6mbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIW+EtBq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=izw/pqxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774252913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ro+dI1rVslz2A4EMJRdKgBDV6ykDd3GWRMG35AhNJtw=;
	b=RIW+EtBqhku9DQZkq7sxmaUWq6wOqlucTEJ4m+aE03CWIx0moH/D2aC0sal54Omdg5Yaqk
	GHM0wFTkePEBXDd7JqyO6WRC91eGSrhQkQ6R1FCqj3wSXSxCbbl+vjAwrTi3OFqUcXzyq8
	COzLzPgO7ZV5H7sCGaib5htCegOpaqA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-KXq1BmlPNfuA7oRUPDJ2nw-1; Mon, 23 Mar 2026 04:01:52 -0400
X-MC-Unique: KXq1BmlPNfuA7oRUPDJ2nw-1
X-Mimecast-MFC-AGG-ID: KXq1BmlPNfuA7oRUPDJ2nw_1774252910
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a61300179so2186549b3a.0
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774252910; x=1774857710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ro+dI1rVslz2A4EMJRdKgBDV6ykDd3GWRMG35AhNJtw=;
        b=izw/pqxLV/e1+/7NXdPWtAFdB7NU4MkctC60dyu8YyKSfNUwqQXQn/nfy2JQVQTqYU
         LS/Ztp9Q6zd3LbmA4FLDYBhCaEfuwgUQjFhBJ9nEFdjFCUBbKLTK4/YhKhmBj07A7QeN
         fClITUD7uOFA8jNZJTW3RBf1ZLK/93dJUbR/xz7d+lt+H8YEjuUqqXYcDC6rhadt5Bj2
         WM9qKeRPdr/qg9lJZHjv/gyYxMB7pofm5H+UtfIVsV6yzmT11MQjJ4MjNkrbUNNlPxdw
         ZIHC6V4bD44355c7EcLcYZcijZf/eL2dJjXE3/9Naq6yKc9JThBP2kCYMDg5OqqHLDV9
         A1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774252910; x=1774857710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro+dI1rVslz2A4EMJRdKgBDV6ykDd3GWRMG35AhNJtw=;
        b=fmSwx+3TrAOv59nSUj2Oo0UzBYEJpLBQBEN0p0dc6J87IHwp91neAWELIlu0Kjbxuc
         T8kF3NM6KL7AJoXxwUyc4h/m53SNh3LRasPowbAwQFfj5WcCSmnsoNKH38TFfSfIQRoe
         QqyaZKUN3uDrPvrQfaUf4FMheyDuDg9sps9Ji/Pllw44l0dsxa0lI4VdURAgiXnIIX2o
         JE7Orlz3GxGzibPW9YRntZY0DWBaRwfXvJkSZieOuArazldDPy3TiaYxjsvmnE9TwGTS
         P0tu3Npm8g2n/A5MY9Ol4S64M2b1aiF0sPP8/eo226fS3OpxW6E4MgymPN1sp+CvAFgC
         zYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVVralFtwZi3ZoChmWJrSFPtrnwcgXbAjQLn0RhBf0CoITA3C5+4uaCGwPQqbUZLkn7Drog0fEb@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyAPTdR1x8zRyfgeEr9PboTuRJdw9O5SN5Y56nH0IP1CueYoC
	yMQ7/DAPmleIiAvOcjkCPwvihUMHZVN6VI+S5gn29U4vSY7PFHOkt+t2yDIuc5AknxXHFftKOs1
	3L5KQqInDSLAzEh1YDSA6upqHBN8gcUlnHRlbc4LNJY0PtOh4qILZXkcR+Po=
X-Gm-Gg: ATEYQzximwF+MMCXGQUDSm9gBdgXwZclieoyUQZo1VOF1zT2Jjzz8VZJ7frOmYLNXv+
	inFcIgeeDU1+bAKYeLJdQHylcH5qWtcsR1VYuNBHb4D/halQqlZtLQ10VYF/hfu9zZufSCl5keV
	JcJh9bYQbrp2kmmYPcLqbGOH+cu6KVQ8ziML41hHem2ikyaXqnEZTh/zKMB+TM/mmPXHLkuw/24
	CX/9s29tY4DdPNqvGTUHSL3GppZkMWqrX6o2mwgbFsph9xpnJV/HH5ESi0yTnTYRLpVAAYD5HZR
	SdbWtXzeAJUCK3SaJmypnrvEL02Y4B4nZ6t3RiICnddRpgKuP4yErrzh04OWjMuoqYiRwtBT3sq
	Or3sjNszQBs0L4FyS6Q==
X-Received: by 2002:a05:6a00:228e:b0:827:26b0:58d6 with SMTP id d2e1a72fcca58-82a8c334b58mr9632674b3a.47.1774252910120;
        Mon, 23 Mar 2026 01:01:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:228e:b0:827:26b0:58d6 with SMTP id d2e1a72fcca58-82a8c334b58mr9632636b3a.47.1774252909675;
        Mon, 23 Mar 2026 01:01:49 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409bf65sm8649474b3a.34.2026.03.23.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:01:49 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:01:46 +0800
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
Subject: Re: [PATCH v2 4/7] selftests: memcg: Increase error tolerance in
 accordance with page size
Message-ID: <acDzaouBPCIpB7Ij@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-5-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14987-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD9492EE0F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:38PM -0400, Waiman Long wrote:
> It was found that some of the tests in test_memcontrol can fail more
> readily if system page size is larger than 4k. It is because the
> actual memory.current value deviates more from the expected value with
> larger page size. This is likely due to the fact there may be up to
> MEMCG_CHARGE_BATCH pages of charge hidden in each one of the percpu
> memcg_stock.
> 
> To avoid this failure, the error tolerance is now increased in accordance
> to the current system page size value. The page size scale factor is
> set to 2 for 64k page and 1 for 16k page.
> 
> Changes are made in alloc_pagecache_max_30M(), test_memcg_protection()
> and alloc_anon_50M_check_swap() to increase the error tolerance for
> memory.current for larger page size. The current set of values are
> chosen to ensure that the relevant test_memcontrol tests no longer
> have any test failure in a 100 repeated run of test_memcontrol with a
> 4k/16k/64k page size kernels on an arm64 system.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  .../cgroup/lib/include/cgroup_util.h          |  3 ++-
>  .../selftests/cgroup/test_memcontrol.c        | 23 ++++++++++++++-----
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> index 77f386dab5e8..2293e770e9b4 100644
> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> @@ -6,7 +6,8 @@
>  #define PAGE_SIZE 4096
>  #endif
>  
> -#define MB(x) (x << 20)
> +#define KB(x) ((x) << 10)
> +#define MB(x) ((x) << 20)
>  
>  #define USEC_PER_SEC	1000000L
>  #define NSEC_PER_SEC	1000000000L
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index babbfad10aaf..c078fc458def 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -26,6 +26,7 @@
>  static bool has_localevents;
>  static bool has_recursiveprot;
>  static int page_size;
> +static int pscale_factor;	/* Page size scale factor */
>  
>  int get_temp_fd(void)
>  {
> @@ -571,16 +572,17 @@ static int test_memcg_protection(const char *root, bool min)
>  	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
>  		goto cleanup;
>  
> -	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
> +	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50),
> +				       3 + (min ? 0 : 4) * pscale_factor))
>  		goto cleanup;
>  
>  	for (i = 0; i < ARRAY_SIZE(children); i++)
>  		c[i] = cg_read_long(children[i], "memory.current");
>  
> -	if (!values_close(c[0], MB(29), 15))
> +	if (!values_close(c[0], MB(29), 15 + 3 * pscale_factor))
>  		goto cleanup;
>  
> -	if (!values_close(c[1], MB(21), 20))
> +	if (!values_close(c[1], MB(21), 20 + pscale_factor))
>  		goto cleanup;
>  
>  	if (c[3] != 0)
> @@ -596,7 +598,8 @@ static int test_memcg_protection(const char *root, bool min)
>  	}
>  
>  	current = min ? MB(50) : MB(30);
> -	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
> +	if (!values_close(cg_read_long(parent[1], "memory.current"), current,
> +				       9 + (min ? 0 : 6) * pscale_factor))
>  		goto cleanup;
>  
>  	if (!reclaim_until(children[0], MB(10)))
> @@ -684,7 +687,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
>  		goto cleanup;
>  
>  	current = cg_read_long(cgroup, "memory.current");
> -	if (!values_close(current, MB(30), 5))
> +	if (!values_close(current, MB(30), 5 + (pscale_factor ? 2 : 0)))
>  		goto cleanup;
>  
>  	ret = 0;
> @@ -1004,7 +1007,7 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
>  		*ptr = 0;
>  
>  	mem_current = cg_read_long(cgroup, "memory.current");
> -	if (!mem_current || !values_close(mem_current, mem_max, 3))
> +	if (!mem_current || !values_close(mem_current, mem_max, 6 + pscale_factor))
>  		goto cleanup;
>  
>  	swap_current = cg_read_long(cgroup, "memory.swap.current");
> @@ -1684,6 +1687,14 @@ int main(int argc, char **argv)
>  	if (page_size <= 0)
>  		page_size = PAGE_SIZE;
>  
> +	/*
> +	 * It is found that the actual memory.current value can deviate more
> +	 * from the expected value with larger page size. So error tolerance
> +	 * will have to be increased a bit more for larger page size.
> +	 */
> +	if (page_size > KB(4))
> +		pscale_factor = (page_size >= KB(64)) ? 2 : 1;

This is a good improment but I still think the pscale_factor adjustments
are a bit fragile, each call site needs its own hand-tuned formula, and only
three page sizes (4K/16K/64K) are handled. If a new page size shows up,
every call site needs revisiting.

How about centralizing the page size adjustment inside values_close()
itself? Something like:

    static inline int values_close(long a, long b, int err)
    {
          ssize_t page_adjusted_err = ffs(page_size >> 13) + err;
    
          return 100 * labs(a - b) <= (a + b) * page_adjusted_err;
    }

This adds one extra percent of tolerance per doubling above 4K, scales
continuously for any power-of-two page size, and also fixes an integer
truncation issue in the original: (a + b) / 100 * err loses precision
when (a + b) < 100.

With this, the callers wouldn't need any changes at all.

This method is inspired from LTP:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/memcontrol_common.h#L27

-- 
Regards,
Li Wang



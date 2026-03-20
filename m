Return-Path: <cgroups+bounces-14937-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDcEFlMkvWmr6wIAu9opvQ
	(envelope-from <cgroups+bounces-14937-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 11:41:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22872D8E17
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 11:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80122305B4A0
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D339182B;
	Fri, 20 Mar 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+YvyVpd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzzrDqSk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8915394496
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003209; cv=none; b=FEAO+stKFy1odXCh5hUCC2SZaT+vB7Fv0LJ8OmNppqBK8eFjx8yAYuWT9NGZiJqdwascsYwTgUyY767uQ0Pbrcpqu7xba0o2GGqHWJydkGRizW+uo41auMAZEe9wybrJlFD2HwVcOWguKpJOdYPu8VB01XYaHAiKRU2lFb3BP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003209; c=relaxed/simple;
	bh=KhvGOABQwXa6rkGgYv9t6dQ9Z9yU5u0qnrdOnEi/t5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaqBJQE0lBGRdslhQvGYUqUbseYMZsdWeIZB185c3tsgufNAK51ozQoEKFH+VHMnF6Q+Cex7I1nWpGsb9ppS3eLKivnP3iNWFEbwkH2ojOp+m3G4n8SlMXCYq0bmF2BSX0afF2gh+b0HiLKDkROg+XiC/WMLvYeRhOc4fBvXqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+YvyVpd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzzrDqSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774003206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3EfRhA4fDW6Hdtad/Pghe6EEW3AEZgUxlL1m715MFE=;
	b=D+YvyVpdufFFkX3ltikMY5kAMBAl1Wh+fvQAjfIu0FAgK7HidVcs+hyvRXBwXuwP0kGV3P
	iJsxFocHZTCqWOHq2QIyEKAjKMehCRzGm4PSQ64en6c6cYWBqb8Hwp0mM8YRzKeU4f9J8C
	oZInWDSYedWr1F9fO9UaFkxyu3P53tI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-5iHrHEOzMZqgj7OFMlLisw-1; Fri, 20 Mar 2026 06:40:05 -0400
X-MC-Unique: 5iHrHEOzMZqgj7OFMlLisw-1
X-Mimecast-MFC-AGG-ID: 5iHrHEOzMZqgj7OFMlLisw_1774003204
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b079b4a8c3so130677725ad.3
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774003204; x=1774608004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3EfRhA4fDW6Hdtad/Pghe6EEW3AEZgUxlL1m715MFE=;
        b=fzzrDqSkjELU5PHPyBu/7lBkssFHWKqVhJRRrdqG/uS8LQDXLY0ozJrx3OdPrm95ig
         zT6GQTpASawFTTkFXCrHDZQYe+wgS5i4w7/5q9ePvGM2bYbr6AvmWbY2Oo9VEKNOt4Qq
         HhohRP0x75kO7shcP88mqJt5lNrLtV8Yr6gtnGqaui3H1tcqoaQW01cmxwMsIT+dCC8U
         mMhJSV2/ycf/bTNKWfstAHu5B40tCYlVhQRZYH8fuURdiBQGlWIeGPdcZFaWAYU9Zdlf
         7UcXAlh+l1dviri9Gvz1DRmZZ2lUmzeVWl1mVmigWt5csSFanHLakNFa+hLTn8AuOdYc
         r9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774003204; x=1774608004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3EfRhA4fDW6Hdtad/Pghe6EEW3AEZgUxlL1m715MFE=;
        b=rkSiy/i8E4Pmz3BsLjqqQrBi4xAnjEWSDmEhXQVD7FITRKReL/NExGAxItimuxsSk6
         G5Hl0J2Jj7KMC0xTR6NTzvmkkf1zkAk+jyGHpnHJzM0Qmes2G1v+Itp4e8Td044NSYpo
         naAWA361dVMkdZWHY6S/SgW45i9AW4+f0eNuAXmfhI4Jg/uiGlSnzBVLD7rLLoXBe6ZV
         eF7Me/e3VuH7ORl4anams0qbUR9MMEk1F+MWD/p5Gp81m/IHVe9HXb87BcaB3V5lsyZq
         j8BFprWdeiINxDpevu9u9DlnJWrEjXru2d1lRLdGL9VdhEP1Ca3vf4CeMgx2/AWe1MWZ
         QozA==
X-Forwarded-Encrypted: i=1; AJvYcCVUJxmyA++FxNTt5NN6vfI0CHIMX1p+z8LuO23RojGeLrqkfbx07uLsdQoskQyMOW0YTUpbyrd6@vger.kernel.org
X-Gm-Message-State: AOJu0YxULAy9sBme9+ehogOwkLoCi3Uo3BHnWbUEQXccMKci032WAsYd
	U4EV05vheNiQQy1NTggKPqSp1tiAGngY85J1P9+7OqZxsW/z9vPwO3ZTwvNpDe9SBsZl/G9onxc
	laoV3YCKHNsM6UNnCOt3ZOxZNzeXLkdA6GB4hiDH1GLKW988AzZ/0WmDjpEw=
X-Gm-Gg: ATEYQzy28b+sImEwpiJK0t9q1C5LvSearsza6UxO8O2hbdlWvL4bFU3LFeDs3JWmgRy
	J8NoBfLeQXyPEFumaAPe6R3ytHcvdjRydsbl/QidZt1OdS7aYINrGDWDTHJq8uLruvGX1WnOrwR
	b7QSw+CWGB3PXM+DVfb35/HZ1uLrhZnIAMTz2KQaUvSfuO6noBuWkWyzy6k6bG64gxOf95JfZyC
	T/0wLMlu+vpvVmjCEX3IS7rUlRamOn+Cn78tGyocxlsZMjbOt5dOtzBjb20qTDzqrTNyfqPnXBo
	teADFBgNgC5xiU9KKiQSKp24F5Gz85HHlao0fRb7nDN7IAgl1QLa3G3r27hRwNHwWMPAkQ+aH8w
	i8zYvXP9dtOhyJfcBxg==
X-Received: by 2002:a17:903:acb:b0:2b0:44da:6245 with SMTP id d9443c01a7336-2b082797679mr24677845ad.31.1774003204408;
        Fri, 20 Mar 2026 03:40:04 -0700 (PDT)
X-Received: by 2002:a17:903:acb:b0:2b0:44da:6245 with SMTP id d9443c01a7336-2b082797679mr24677495ad.31.1774003203994;
        Fri, 20 Mar 2026 03:40:03 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083679867sm23410205ad.65.2026.03.20.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:40:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:40:00 +0800
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
Subject: Re: [PATCH 1/7] memcg: Scale up vmstats flush threshold with
 log2(nums_possible_cpus)
Message-ID: <ab0kAE7mJkEL9kWb@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319173752.1472864-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319173752.1472864-2-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14937-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D22872D8E17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 01:37:46PM -0400, Waiman Long wrote:
> The vmstats flush threshold currently increases linearly with the
> number of online CPUs. As the number of CPUs increases over time, it
> will become increasingly difficult to meet the threshold and update the
> vmstats data in a timely manner. These days, systems with hundreds of
> CPUs or even thousands of them are becoming more common.
> 
> For example, the test_memcg_sock test of test_memcontrol always fails
> when running on an arm64 system with 128 CPUs. It is because the
> threshold is now 64*128 = 8192. With 4k page size, it needs changes in
> 32 MB of memory. It will be even worse with larger page size like 64k.
> 
> To make the output of memory.stat more correct, it is better to
> scale up the threshold logarithmically instead of linearly with the
> number of CPUs. With the log2 scale, we can use the possibly larger
> num_possible_cpus() instead of num_online_cpus() which may change at
> run time.
> 
> Although there is supposed to be a periodic and asynchronous flush of
> vmstats every 2 seconds, the actual time lag between succesive runs
> can actually vary quite a bit. In fact, I have seen time lags of up
> to 10s of seconds in some cases. So we couldn't too rely on the hope
> that there will be an asynchronous vmstats flush every 2 seconds. This
> may be something we need to look into.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 772bac21d155..8d4ede72f05c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -548,20 +548,20 @@ struct memcg_vmstats {
>   *    rstat update tree grow unbounded.
>   *
>   * 2) Flush the stats synchronously on reader side only when there are more than
> - *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimization
> - *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpus) but
> - *    only for 2 seconds due to (1).
> + *    (MEMCG_CHARGE_BATCH * (ilog2(nr_cpus) + 1)) update events. Though this
> + *    optimization will let stats be out of sync by up to that amount but only
> + *    for 2 seconds due to (1).
>   */
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>  static u64 flush_last_time;
> +static int vmstats_flush_threshold __ro_after_init;
>  
>  #define FLUSH_TIME (2UL*HZ)
>  
>  static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>  {
> -	return atomic_read(&vmstats->stats_updates) >
> -		MEMCG_CHARGE_BATCH * num_online_cpus();
> +	return atomic_read(&vmstats->stats_updates) > vmstats_flush_threshold;
>  }
>  
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
> @@ -5191,6 +5191,13 @@ int __init mem_cgroup_init(void)
>  
>  	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
>  				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
> +	/*
> +	 * Logarithmically scale up vmstats flush threshold with the number
> +	 * of CPUs.
> +	 * N.B. ilog2(1) = 0.
> +	 */
> +	vmstats_flush_threshold = MEMCG_CHARGE_BATCH *
> +				  (ilog2(num_possible_cpus()) + 1);

Changing the threashold from linearly to logarithmically looks smarter,
but my concern is that, on large systems (hundreds/thousands of CPUs),
the threshold drops dramatically.

For example, 1024 CPUs it goes from 65536 (256MB) to only 704 (2.7MB),
that's almost 100x. Could this potentially raise a performance issue
as frequently read 'memory.stat' on a heavily loaded system?

Maybe go with MEMCG_CHARGE_BATCH * int_sqrt(num_possible_cpus()),
which sits between linear and log2?

-- 
Regards,
Li Wang



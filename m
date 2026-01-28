Return-Path: <cgroups+bounces-13493-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BNqE159emlN7AEAu9opvQ
	(envelope-from <cgroups+bounces-13493-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 22:19:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B98A90F2
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 22:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF0EE300BE99
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D234D903;
	Wed, 28 Jan 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H6/Pt2QS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF533033F4
	for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635140; cv=none; b=MBBhpt2xpLOvPVPQ9L7bSZnGJ5vQYEQr5RSBKnb1gGPkYvalEHgT3M+CyGqb7JG5sDY8avHIWlYhdU7rF4h0Nt6saM8K+a/HYooBCP0rRb8FLy7rDQEQGiRT8VdkQn1Vaf/Fd5Y00tzOHMJiv7PgQm5flBWMO37DSjMJ/3S2oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635140; c=relaxed/simple;
	bh=R26B82zxPcid0PkRJfA5J9VLBvvgfckzt4BZtC2Buu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8mhpO8z7RGO2w3CE4MtTMkLgMlmEx/8y1C+4URgiqew7RhQ2ojh4qo+OHJ6SB52b4L8X8gaD5uCOXTqR7NzXXvJSrYXWNxRzrNqT8eE/d4aHaBf693I9hUyN21NCX+S4hs/eYNPAbD2yu51K/OG5jM3s+6jBNgJgDYFXh2a8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H6/Pt2QS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso2245955e9.2
        for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635136; x=1770239936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=H6/Pt2QSJL40tHRjCnqTJlyeIJBSCnr6XIoN79q068X0MJU9XhocPvQi3HFIkZymOP
         p8kxmgBVkKuyGCdOTB6i9edsgCbEngNrTzpB+fJmWfV0QD5weM0n/jRnTPjP7dR8i0fd
         XPcJli/57tpaiplIsRRfu/P7GpWnWHZ7UOuoOtvXdjd8lOWeFXblOPmGyTJgQGpUDdVX
         TjBp17TAhFz4dhaYtX7FHH3TO+d7uWcui8ah2wAxjnHEdJf2DAaU243XGNDazfe4iT80
         ZPl523HaMWYMdHiUL4T38lxBoNV59O7P5kaPK3MmoGwSuq7gWlGhXbmGHaRcqptdF3co
         lYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635136; x=1770239936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=LwCSVmykszueJggNjSwB8daV2Qs2FO+XeMd5d8EE0py4K/6uKg4k90idtwQdtZ36ji
         ocgnwlsw3N1UqXEVBHdEg1rYIlgiz3E/3RzVqLCy/wVyzoMm7XcHnk6GY/enfzNOIMvi
         /me1n2nMTfewIGntjnZJtHLQAaXIg7+k4fzipDNXswoJZZaikpbHIf4E28bqhsntzDaM
         oHWrTcGc2fH67kFPKoriug/Zun7T4B9lgfkTEpzeuPlLYd8kgRIzZT9SEVecn4rEZaRP
         lG5lNxgylyr96VG7mJN3W6FZNZCMBt/DNjIIbmVSMnbGCbRPqqNq6oYYvdb3h6vXRjbP
         oSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXina3AybQlFc4n5lLdZ6YC213Rdjvhx6JiDplHkUvMi1j7vxW2GQyjcaVMdJEDD1dhwjCVQucQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+q9hri1y1HHG/64xj/Xh688N26tRAyE5KKBOAbtIlsAbhx0r
	FedYnFyzrGW6+pto8+iu/qTOHbyzSwWBSkWV5iD5R/7MyeiYRm71SL6Nen9wAT+k1sE=
X-Gm-Gg: AZuq6aLJmBuyolcesYToH0XMMSooSaoq7iw6qNu/vz8B58bRuSulrgQrDYsfMHIS37V
	6TT5qNyhAyQkvsZQd5KwLmh4Nz9i14djDOpM5O9capyB8RAJ+wRVCb3Ywregt2tg9CLiDi6SnXQ
	U1Kz0UdNvm3FrxbEoDvgRb+8zH4adYTH552AMJRX4IvTy/WcFpJs0KJIqoimMX63c5eexl5aNXy
	Xtg6sDyIztaCzwmc0Ql/bgUBETAFytUJNZqvTojCKlr6qs7+JC6PKJo6V+vtIHxFPyxSoXYxVBT
	KMz+AUvu6kNmzb6ZpS3EIE3eswd/IgxPF9r3QLP5uBtAZFssExxS2QrZCIRFy3T1BDUq0svlAXl
	YyqbOpyd9+bjfDKWFe7K9Ra8URRj2/H9GgNTAvP4EHbzUqZ6dtVGzBgjAaizZqa2Lttk8s3vn2b
	j6BPvvu0lqSE/0TjumWOIsbbjn
X-Received: by 2002:a05:600c:3e16:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-48069c10f78mr74663935e9.8.1769635136165;
        Wed, 28 Jan 2026 13:18:56 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d78cb6csm3510525e9.2.2026.01.28.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:55 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXp9Pp4YvlbJumeY@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-5-frederic@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13493-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75B98A90F2
X-Rspamd-Action: no action

On Sun 25-01-26 23:45:11, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against vmstat workqueue to make sure
> that no asynchronous vmstat work is pending or executing on a newly made
> isolated CPU, target and queue a vmstat work under the same RCU read
> side critical section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmstat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..ed19c0d42de6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
>  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
>  		 * for all isolated CPUs to avoid interference with the isolated workload.
>  		 */
> -		if (cpu_is_isolated(cpu))
> -			continue;
> +		scoped_guard(rcu) {
> +			if (cpu_is_isolated(cpu))
> +				continue;
>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}
> -- 
> 2.51.1
> 

-- 
Michal Hocko
SUSE Labs


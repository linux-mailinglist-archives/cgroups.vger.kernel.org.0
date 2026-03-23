Return-Path: <cgroups+bounces-14996-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPXXKXA2wWm7RQQAu9opvQ
	(envelope-from <cgroups+bounces-14996-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 13:47:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA22F22E8
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B43301A9F2
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822BA3A963C;
	Mon, 23 Mar 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpDFlzck";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="au8/bzNr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A473286415
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270011; cv=none; b=R81hanFR8nFLV78iM6xpGC2EJK0y8N/Bgr+zPLJhb8MxamPgZrsuO55mrsHspupODSrkLx7itnyv+BWDDoWyZDd4J6c800r8oQyc4hBMn7iTyt1/hMc8vfv2+u9nJ4PgzAfTKY72Qiyam7OAmqyWhDD4yfCDUFX0hP5ppQgFYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270011; c=relaxed/simple;
	bh=XnysLVfVXj++X3qYmTmEaUUk366ZaIjwcFzBQj0b448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVwKKWORVH8Zt+f5xgpb0nqp3JaugjkRzB8OATSn6LAvn33Nb9Tjil4F4WvdOLfHBZac7BqARIMKM/HVR8otKf4dS4h7I0BoxZQDMQgTfW6a91qTV1dnj1yL62szDw1xmXb5AAcBwB6bYPDglqtR3we5dMoGOkO9HkTGTjSgLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpDFlzck; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=au8/bzNr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774270008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zj+HJ3NHVe31Ua9iuOX+I5shCryiTmPAEr1rzKm60IA=;
	b=GpDFlzckhDJYw0kBL7A5QlcyrB+YaOEYEswf4or1TWT+mxM8Web6z5Ujr0Qd92gyknZ9uy
	JalQM7zO4Atj76iqh6i63K8qTZAgBrbMYzjuNNbdV92RX6dHOYBGPkJRFKrm7Lf2Rd65jZ
	QHCUQEFJ8jZ6Q8iraZROCmTJLmqG6VM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-bcqsPBKRMCSdOQKc1CiYbg-1; Mon, 23 Mar 2026 08:46:47 -0400
X-MC-Unique: bcqsPBKRMCSdOQKc1CiYbg-1
X-Mimecast-MFC-AGG-ID: bcqsPBKRMCSdOQKc1CiYbg_1774270006
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1960269a12.2
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774270006; x=1774874806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zj+HJ3NHVe31Ua9iuOX+I5shCryiTmPAEr1rzKm60IA=;
        b=au8/bzNrqamLX3SGu2LgcicHx8MX+vBqijgNMz9k00Lv/5bZSzH3aIuq0FPRJ6sbmp
         P1mkb95uCowdmCVSuuXs5caqXysmcw/as/dt7odJszh3MXwU0rk6G2L88G6yaBY8G50b
         Bzw4Eb7+ZOG/c9qL1U3sUNm3pVtJdxOv5jpr2FUYQu2VigeNoF5EhMZFgkabW9vASATq
         eV35XobF3NjFxA6a0djNtjZdAiZewqSr1ZydQGRFbUw4F+2v+SyyC4BNhz7wPKILKzM+
         mA0GcVQgz8k5J89Nzx1Af5yDEa4MRpzi+ALLu6v4Hv5Evn8wyCtcMQ0+VIOAfkeLUEe4
         h/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270006; x=1774874806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj+HJ3NHVe31Ua9iuOX+I5shCryiTmPAEr1rzKm60IA=;
        b=nPjmwEG4+o/ybwj4DSHVKGEAlvIj5s7lDwJtQhZNgMtCKlYDB5UyOM7vE17bCGS2cm
         Z04tweDQHYwEWmbkDX138tcRztXJ33D1XFwJly2LVUBQqouTtzjJ2gpSUUEVuVa+Xkk3
         /FTZp7XDxYuh92kjjA/GItcsvHGHYGuEUMG7YhsgJPEg2jdlAiSbZ9Hb+Co9Uo9NP/NN
         7cnv8C5P3JXBA9VlSZMdRzC5s8cfsHmCy4INS8cPy7asmDZttF8Lv8cCQXGLhXydqgsr
         T5bd195e+gDVX1PEDjx/Qc1+JtSw7QwZdQSwjDa+agjgnZGt2NaYres8ubnfsxfFOB3D
         1exA==
X-Forwarded-Encrypted: i=1; AJvYcCXFLC7k5nqZjlC152HwhF/tqy3dlOM3Cgj245moqGyBggjrJ5LcNVt4YU2XPShbtgIZgGy0rrAw@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcVrYR2o/IYpal4EpS2zSasL1sSOOptELFeTAGSqVah+8Mcze
	2D5h5m+RbnYL0gK+dv5BW5i2l24C9oG2NG39eHEZ0ABWeifClu0JLYW/6Np/vW0fgrUypVH3y8O
	ShdjhM9/UuGmfxmPPcTwQvz1s3/37fdhMPu5iUfCuWYu8d26P3NZMvSOKqyg=
X-Gm-Gg: ATEYQzzDRMvvmcKyDOpvne1vos6BuGRxSaMmzWXJcZPF9hY0ze3nVTQrp+L55B+Ymkl
	cww/6+BYn3OXic00UhvasH1b/ba4kN+s8s+ONPcCttNFHxInvCUfU0QEKLvZuc7cCZOC9h7k2OT
	X7LT5ZsVe9PLF6YxdvR+1oRdu6+c4f1xJC5iTJMfQQrlaaJMWZs4KcsXbDacE5qNjp5dOQ7SbwO
	uEWzg1vXWdYlP4d97cFWrd1HZcaP7GuZ9ST3y2mlctdF1tsNZ3911lfEVxVkWuszeMNdlOSYOwa
	PhPIwLqbwwVS1pQ2XTvoNThLoeuPw/c831QgTTKfnOVV9PXxmPsdOFrxUrKugjmFEkWHZylObJe
	BDimFMhtpbye6Q6g3bQ==
X-Received: by 2002:a05:6a00:2d1d:b0:829:7efc:fe20 with SMTP id d2e1a72fcca58-82a8c325f74mr10131679b3a.40.1774270006191;
        Mon, 23 Mar 2026 05:46:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d1d:b0:829:7efc:fe20 with SMTP id d2e1a72fcca58-82a8c325f74mr10131638b3a.40.1774270005733;
        Mon, 23 Mar 2026 05:46:45 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa5a9bsm9609699b3a.8.2026.03.23.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:46:44 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:46:42 +0800
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
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with
 int_sqrt(nr_cpus+2)
Message-ID: <acE2MoIZ0pl7U7PX@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-2-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14996-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 87FA22F22E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:35PM -0400, Waiman Long wrote:
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
> To make the output of memory.stat more correct, it is better to scale
> up the threshold slower than linearly with the number of CPUs. The
> int_sqrt() function is a good compromise as suggested by Li Wang [1].
> An extra 2 is added to make sure that we will double the threshold for
> a 2-core system. The increase will be slower after that.
> 
> With the int_sqrt() scale, we can use the possibly larger
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
> [1] https://lore.kernel.org/lkml/ab0kAE7mJkEL9kWb@redhat.com/
> 
> Suggested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 772bac21d155..cc1fc0f5aeea 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -548,20 +548,20 @@ struct memcg_vmstats {
>   *    rstat update tree grow unbounded.
>   *
>   * 2) Flush the stats synchronously on reader side only when there are more than
> - *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimization
> - *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpus) but
> - *    only for 2 seconds due to (1).
> + *    (MEMCG_CHARGE_BATCH * int_sqrt(nr_cpus+2)) update events. Though this
> + *    optimization will let stats be out of sync by up to that amount. This is
> + *    supposed to last for up to 2 seconds due to (1).
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
> @@ -5191,6 +5191,14 @@ int __init mem_cgroup_init(void)
>  
>  	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
>  				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
> +	/*
> +	 * Scale up vmstats flush threshold with int_sqrt(nr_cpus+2). The extra
> +	 * 2 constant is to make sure that the threshold is double for a 2-core
> +	 * system. After that, it will increase by MEMCG_CHARGE_BATCH when the
> +	 * number of the CPUs reaches the next (2^n - 2) value.
> +	 */
> +	vmstats_flush_threshold = MEMCG_CHARGE_BATCH *
> +				  (int_sqrt(num_possible_cpus() + 2));
>  
>  	return 0;
>  }

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang



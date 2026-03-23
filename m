Return-Path: <cgroups+bounces-14997-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CMsAYg4wWm7RQQAu9opvQ
	(envelope-from <cgroups+bounces-14997-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 13:56:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E342F24ED
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 13:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628813037427
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB33A9627;
	Mon, 23 Mar 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnYGIcN7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECtEj5Zr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A63A3E7D
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270048; cv=none; b=CZc/FGLwYdPagj+rs7UHQyH8OGzQGc2iw2oGxtASBcdTbZoPuj4e3Ot/uwUDXb51QI2vu7UspXRwHtRo4CaPNjvMlAHo/0hSfmoaL4WfA/9jB3ig9yGpiBh3byZfD/9fZsiltxGTSwzBYv1xVq7ur8gdX3CFo3/TiT57P9K2tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270048; c=relaxed/simple;
	bh=MM2fN5GdnEJYHW9MITbLdhoSmIAOoGWsDFQGNHwaPQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbX/JLQ1PEbxD/sSIb0cAXOO8DbceUjoFkoZzUs+MRS4n8uFGTkUUZZGS3dWQhz6mHAopTZsDTNsyQaR0/MXlUqEXwMH6VfDNpN5fRV09CFLxLCT/5xHCmCgKBw5y1gQzN4HUizth7rzF1x8ePykgCUHyuxPd1mqz/ucmk7Fdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnYGIcN7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECtEj5Zr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774270045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0u4DoGQ4lmcA23oqYqC/015Lk/NUWNVl1j8NoB4BI6w=;
	b=bnYGIcN7gtT92p2SQKDP4JjCTxItSkv8rsPEdyM9/rh0xqVQLRqYE5E/Msn2WHU7z6cpIz
	uVSa9IWVx9k+4wHIoiFUGx3MD8n3SC4HWLF8MlapSEuj0PjxuWHp6PuHy3dMZ4rqBlFeFa
	UZuR2meNwEbtqeEuQSLxjx422bZqB7E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-lPnrOD_8MJOJXP0WL9Mqow-1; Mon, 23 Mar 2026 08:47:24 -0400
X-MC-Unique: lPnrOD_8MJOJXP0WL9Mqow-1
X-Mimecast-MFC-AGG-ID: lPnrOD_8MJOJXP0WL9Mqow_1774270044
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35be4ea8292so1693415a91.1
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774270043; x=1774874843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u4DoGQ4lmcA23oqYqC/015Lk/NUWNVl1j8NoB4BI6w=;
        b=ECtEj5ZrLYPHGLb6FNYy9GQIJRSsJu5atQ1K12zR7GX7bOnCb+g4jMlBiXd7zydgRN
         nNzoY3ryQ8bhyU1CB6eEeFGSPCUiHSyMo795XhY0xWZ/E0Svf3PiE79piQRxC3ofmD4y
         N3fS3N2yWs3lzonczkFCt+xkJWbF7TVtBTsglAwYjIy6MSl49SfFXosXCgV7I3Cd8fUE
         ah+DJCn1V8rw8tuhbzV0pPW4ArWpOf6+CcdVk/EyLajoc3ZTKzwnqKp83PcMe4VapQDM
         1xUEUvvID7LGdm5BGflR7LODM1VWJzuUPZmXahDypSrNKuyKYb7GauMw1XEm8Y1l4SLc
         5LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270043; x=1774874843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u4DoGQ4lmcA23oqYqC/015Lk/NUWNVl1j8NoB4BI6w=;
        b=BS8Do3/DKqCpW136N2U9mCJVTsUZAlPJ/ByR8tk3X9ghAPK55TkaWmm9iKxKIMAA6c
         bG2Q8pjWcBT+IIdUOzDk4ahrQEELgi2SFB8wjjT70Mj4ccFV3qiMgh5mXlKUlqV2H0lK
         uZ8+7zgkzRKL7JHzgGWrMWgrNzoZXmqr5N7Q5sbr/2GPn1g63U/1fk1ojkqTZyI/lQKh
         7C8aqipEPoVgHmSAmChnRDPG36m2SLQL4rqm3TXmD3Wfnjsh5yJ/AmEKO9FREuis97Nr
         e0J2x+PCbUMtowv2Bm1VlbeGOnCAKnymHua4nK0vZAVzUKefZWY5/bkevHW7TEe1PUg7
         hdlg==
X-Forwarded-Encrypted: i=1; AJvYcCWkabmPshMUndXCKBX35FgauPHhdVYV4spyFzeiR9vSVF/+pEoPo4ahHHY9lhsgIPFizRZI2FNe@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9iPDXVrkVnxqOzCzRAOj0wko+nrCeYnsP6I0K9C+cq2y1E4E
	UzGOJG3iWOvOn3dSbaEu3qa1fhZqRhJLBr5TTBwWcQm5U/43AKSHGVVqB92eMMngu0Jw1fOoiQT
	8LTB5K8m8Neo/QenhwVLkemE24i0q/5WMtM6cfkwWt1CQ/VmgLL7bMuu3HvA=
X-Gm-Gg: ATEYQzwkQIYpDeg0LUWiB4j+58yL20ETsDxDQYgPsCe8Bky6pN0P8nQg7n8JuFizNNZ
	obhkt+gPbnbcm4R0RTuHw9R/C0ZH/pNHBy0cLImvS48ivXBP+ynX61v2CrGTlr9m0oFIKzezpA8
	u+PaKKN/st0BBRk1lyBH05M+jyv5Tebl2rxkIDG43lHY1Sao2GLXvFUq7LsIe7RgZeuwKF7mP1m
	BIRV0P29UzBOTdil7XvZtvbwSr6UH2SJ5vW1m5GCyn5vjSTa1+McUgB+MaYgRw2gxOAi1Ttky4m
	FmDfS/lFCYFsTI8rtYayJKWMxLQEk258Km2LIooV+2DZVX87/NwulzyAukg8gdyUS7T1q0ZDL6T
	HKRk5yKv5wCYPlwG1rg==
X-Received: by 2002:a17:90a:1c0f:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35be4d8bc7fmr3116814a91.14.1774270043236;
        Mon, 23 Mar 2026 05:47:23 -0700 (PDT)
X-Received: by 2002:a17:90a:1c0f:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35be4d8bc7fmr3116793a91.14.1774270042836;
        Mon, 23 Mar 2026 05:47:22 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366b9aesm141494025ad.58.2026.03.23.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:47:22 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:47:20 +0800
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
Subject: Re: [PATCH v2 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with
 increase in PAGE_SIZE
Message-ID: <acE2WDuto9cdp5Lx@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204241.1613861-3-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14997-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 57E342F24ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:42:36PM -0400, Waiman Long wrote:
> For a system with 4k page size, each percpu memcg_stock can hide up
> to 256 kbytes of memory with the current MEMCG_CHARGE_BATCH value of
> 64. For another system with 64k page size, that becomes 4 Mbytes. This
> hidden charges will affect the accurary of the memory.current value.
> 
> This MEMCG_CHARGE_BATCH value also controls how often should the
> memcg vmstat values need flushing. As a result, the values reported
> in memory.stat cgroup control files are less indicative of the actual
> memory consumption of a particular memory cgroup when the page size
> increases from 4k.
> 
> This problem can be illustrated by running the test_memcontrol
> selftest. Running a 4k page size kernel on a 128-core arm64 system,
> the test_memcg_current_peak test which allocates a 50M anonymous memory
> passed. With a 64k page size kernel on the same system, however, the
> same test failed because the "anon" attribute of memory.stat file might
> report a size of 0 depending on the number of CPUs the system has.
> 
> To solve this inaccurate memory stats problem, we need to scale down
> the amount of memory that can be hidden by reducing MEMCG_CHARGE_BATCH
> when the page size increases. The same user application will likely
> consume more memory on systems with larger page size and it is also
> less efficient if we scale down MEMCG_CHARGE_BATCH by too much.  So I
> believe a good compromise is to scale down MEMCG_CHARGE_BATCH by 2 for
> 16k page size and by 4 with 64k page size.
> 
> With that change, the test_memcg_current_peak test passed again with
> the modified 64k page size kernel.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/memcontrol.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 70b685a85bf4..748cfd75d998 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -328,8 +328,14 @@ struct mem_cgroup {
>   * size of first charge trial.
>   * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
>   * workload.
> + *
> + * There are 3 common base page sizes - 4k, 16k & 64k. In order to limit the
> + * amount of memory that can be hidden in each percpu memcg_stock for a given
> + * memcg, we scale down MEMCG_CHARGE_BATCH by 2 for 16k and 4 for 64k.
>   */
> -#define MEMCG_CHARGE_BATCH 64U
> +#define MEMCG_CHARGE_BATCH_BASE  64U
> +#define MEMCG_CHARGE_BATCH_SHIFT ((PAGE_SHIFT <= 16) ? (PAGE_SHIFT - 12)/2 : 2)
> +#define MEMCG_CHARGE_BATCH	 (MEMCG_CHARGE_BATCH_BASE >> MEMCG_CHARGE_BATCH_SHIFT)
>  
>  extern struct mem_cgroup *root_mem_cgroup;

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang



Return-Path: <cgroups+bounces-13458-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCNCFSead2n0iwEAu9opvQ
	(envelope-from <cgroups+bounces-13458-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 17:45:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4498ADBA
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F13A3086900
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5C3446BC;
	Mon, 26 Jan 2026 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WW/xyn0r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8433B6FD
	for <cgroups@vger.kernel.org>; Mon, 26 Jan 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445704; cv=none; b=X0SQ/wFvf9obP5u6na9N0qe1hAVCh/HGLkA/xFbiIf4y72iGq3SL1WLvIffCEnHYLW1V2ZjUqXPtluBvWMPnsKs8/h27xXt6SF2nHjOwxFxdvSmOoqobOsz1fV6s2u1sobT9Fp52GVKvgSMr9TY9bFxwsk1LFo5G21VPzhDN6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445704; c=relaxed/simple;
	bh=8yoM3+JoKX/J9QDS4HwajBIfb+G9TUqyNd63YSi5fTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOzXyw9PQyzQ4Oi8v/SsG21JbGYPSLfukx/qqeQR9rfWglR6rXYZZ2sWmL0xsBCgyUcaA26qMirNN31iREIDPPc1GtGEKAmZeyqvY7+b7t4uGRjWGjS6oWm4nAd9goEU7Gc3+YwLzdadGQom4L5/E1qG39xOeq2KCgATX21iJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WW/xyn0r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314f52so2724093f8f.0
        for <cgroups@vger.kernel.org>; Mon, 26 Jan 2026 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769445700; x=1770050500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=WW/xyn0r2OskO1/gzWNoULgDe2kdC0eHk8bhHWXchpqj6zBf/26ldY8HjHl/v+zfKq
         0qzUPWlXUqmkd09XTetXlHKx+7HC6pXXogPKuOmnKvpxpo8uT1gS2ldSwn0+aY6O3zXv
         h4u28Zn2G+3wOJKfpnm0NJLdQ9RlpUGvGRv+J9GzTaSPIcAl7PT+NbuvAF13p7AvUCps
         HQUsFJA9gGnmG+46x+XVjR+e/k9QQB5OdIVD1VfeWImnSfxGSdfEeYyD+7A84RHrUs6Y
         +XsYMZpdegAEXSTsvZ0x4GU1LO33SWaRjXInzhh+Aa6FFN1CV/9RrMu25lmu96Z4WiHq
         WHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445700; x=1770050500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=iVDpAloVXalEcm+WtJ8SXY+F/z6BaO6VP/W1Z8s/Y6K8HXzsyKmcD4L9mnAX+qeJcX
         yOWopfRQ7LU3bCsSY7OwkPU5ThfnAlTck+9G2gVTQW9haC/kdNT0zoxEh8YPd1Ikjn2j
         L4EbN+vEU0UISv0CGcRNP87aSAlopgmW6W0TVGZSRe4+et1+96XFyOGOcQJY4TrjF6Ad
         /kEd7BThAEC27nZD8qbixuHYZYKc2e50ZMHLZDJ1b3PH6GGk7i+VqHECOxBBDczFWiPQ
         9gCkLbkJDjHIxjB3Uu5LWHtwZaaL/BJxB3GJEzqdU3FdIrKz62pcfd6RvLufarAkfeKd
         GaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCULujNZpDssWpG1fjw2gAW8qJJiR81/d1+tYBW9Ad9HcvsT+BL45fPSMsiW05g+mUmjTSgd+BDn@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzFyuiwJytMPHgv25W0PnHdGLzy8HgUGLWNTl4UkMXIx7f3LC
	UE23GfTImPWeaNfEzbctb/iBBTIqFGWhT8YUvP8VK9m2BCz4puFldWSzVBfgbpQVkdo=
X-Gm-Gg: AZuq6aJgIR1fB0u1TnjmxLC4AqlQV54FaiCAI73dF0oqDfPGtRUOXv4HK7WHO+xJPD7
	aYNSGXHpfxLc0rFmhPKRDxjqoYCi7mT7dHBqPsylpOYjH3sbWfViOW4ppIZeZtB1f16BKWS96QM
	oLlmRFzs+5NG+kNi/Tsv/29gjgJ4HYgi6Jjq4pjgVcVTr8mKUPyIfVCEsAu3Evr8/chifpDkJw9
	kFTKuE5bLo/M91t9TE4+1Ix6jjvdUcdKXQIv2LBIl5LbJ9ibSPb6pqcWhfJs2U4WtXOAPsfbo5n
	EvUqJ59IvjwUOnmjn/4gSagryhjUH9DX0YzbKuq3XC0iB2bmvaDMLpSsS79/sjJHVa7XXc/97ud
	nn1Z7LvUeCxSrFMTV+kXOoybq1X0sV1XGKitu2LXlLVeif81a/1fDwusu+vIp50fF5kA98+OE6G
	nHy2AebuQbAzm4SJaxTfBSy/WC
X-Received: by 2002:a05:6000:4212:b0:435:95ce:84cd with SMTP id ffacd0b85a97d-435ca39bd3emr10384617f8f.54.1769445699664;
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74b15sm31194587f8f.35.2026.01.26.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Date: Mon, 26 Jan 2026 17:41:38 +0100
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
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXeZQoSHJ9QX7B6W@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-4-frederic@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13458-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB4498ADBA
X-Rspamd-Action: no action

On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against memcg workqueue to make sure
> that no asynchronous draining is pending or executing on a newly made
> isolated CPU, target and queue a drain work under the same RCU critical
> section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  mm/memcontrol.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..2289a0299331 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> +static void schedule_drain_work(int cpu, struct work_struct *work)
> +{
> +	/*
> +	 * Protect housekeeping cpumask read and work enqueue together
> +	 * in the same RCU critical section so that later cpuset isolated
> +	 * partition update only need to wait for an RCU GP and flush the
> +	 * pending work on newly isolated CPUs.
> +	 */
> +	guard(rcu)();
> +	if (!cpu_is_isolated(cpu))
> +		schedule_work_on(cpu, work);

Shouldn't this in the guarded rcu section?
-- 
Michal Hocko
SUSE Labs


Return-Path: <cgroups+bounces-17630-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJ2tBxG7T2qjnQIAu9opvQ
	(envelope-from <cgroups+bounces-17630-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:15:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A006E732B2A
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:15:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b="M/V57GL2";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17630-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17630-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB6E6314B9C5
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF1339708;
	Thu,  9 Jul 2026 15:04:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C01331EC4
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 15:04:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609468; cv=none; b=MiVwXAECTPg4B3WpUpCuHw4m9bwTVDpK7AJg1mG4YfOQxAza64XtqgAqgumIGPrWcpi1U50UBCqGnPHdEoiUhAtqBDyGbJnSyohOL+X6Uxz0+7/Rs6QDzaNPCiP9zjdMKovW5XGD7/GtqKgk7OB+SiRmnIY0N5A4sN5ozxexPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609468; c=relaxed/simple;
	bh=CLG1b+QXiyTp9wRZepf5NQ7+h52yfCipkiE9EHYeuBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paNDCoNHZLWmOX92LGMSr9+gx5eAzMVYo8ym3jVQRN8/M6/rExMWAfX2Un17P4G2R2ET3p0WF7Rij2ltfmhz5hPqLNj5OPY/FgO+ZAx5Thl3Srn6j1O1EujjDuoEDcXuU/flCq4e1oLL8J6ldHbNv0x46fNbJNnoTSJYSc2R520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=M/V57GL2; arc=none smtp.client-ip=209.85.161.43
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a324d200c2so1286828eaf.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783609466; x=1784214266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C2q8Czx79ilwPj1ckt21CqhzkvzJ8d/ykcAORqubNh4=;
        b=M/V57GL2f7nBlpgKWU0ZBRQ2aSGTh/Wq0CCPAGIBBfT/DJwxmqaxxar4XOeVKIIEGm
         FRHRrSgk/Igd8mLs/RV5LJqVAGIwesaJTt6FawBfAEzo3Ae44XS9O3YGf8Y/C1vENIcM
         4uAP5ZhvhGAttZJhd1awAb77E8oKYBTYg5lakpt9vkBJSfQ162BSGXOS9LvXMMNTdG4N
         Y1BYNFGXl4GHT9rLcwz/Wujr8hx5c88J3ALqbwxBBFC/PQvzIXTOLCUC8rhsj7x0dADX
         7dBGKOiM6rAF2n5tGRhSiVu8B6v1PTNOymfNqXw6P+72oTT1X3i+LywWyu+G/3irsycj
         apKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609466; x=1784214266;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2q8Czx79ilwPj1ckt21CqhzkvzJ8d/ykcAORqubNh4=;
        b=hDQAFhavWlufanfi80a6utLsWF+asX1Atc8D3BwiSkziFSyjuMuLo2shXJbUecMDMq
         QAoVydsU4xqmSprjxzwnuWFVt2vnJkx0zSGil8naC8T0IE2yupyPeQ0YiPEZNsNVBgKc
         k8GFSxp7VJcc2Cp0DJIBP+r+XxOmctpCr4WTODaMzIkjeT4Fw+BsO+MNDYV91/13qm3Y
         XC2GgARfoHd7l6uarA7oNmOkuLGlFc+oO0hx40rcQ5PTv8hNDZIQ21rFzEitB2HCOiLZ
         tHretEGFN4JB3pcxlgVzVo3qxhGCLFU6k9w/CXddSwsnLgoGN2RIJGVSReaJMYGVM55w
         DfTg==
X-Forwarded-Encrypted: i=1; AFNElJ/+VU/0RBMz0RPNyQC92ulrbFGXnfk7/2SKrFGWOxBrgRYCAIsRiz9UyCNXBbDXCgS4WfiXBu55@vger.kernel.org
X-Gm-Message-State: AOJu0YzID7SskSarMEIIiPcS7iedX2PM+u4bBr02U9yG8TRoNtBLt2D8
	MeQuiTs0BwqH/L2do/GJlaR0uup6J31TIkNWl8AZv76o8fD1gW969D4n/g/GfpdWhBE=
X-Gm-Gg: AfdE7ckSHqQ+wNpHY5FvjFF4QY3dn/5rEqbwVd/PQrHB8LX5H0HkzSi6Ex6BeTidoFu
	orWbotLl6HrEFCMpiPJcJBG/ISioWabr7sMk2ZZWidNWuvnRXcprmCn0e3VEiXYjFeC3ZgkMOhR
	W1KCjEZbF1JmD+5hnNNgSKS9SPoQK+DxW8l1QKkePVZTIvNibSVQOh7gR2FIV5lH57h24TDBBMi
	c+Uo5/wu3KTt2BVJH5vkVhJzZv+T/MK+p/YZ7SqnexEbfnsn5ZLjApcAR+Qo3kvmKdatmcsItw9
	LWTkOXK8IILcrA2FiszDdfABz2IA+Hq6JSlmIZDojdwrl+zlIV3k+P6dTFXyAB6CNs59npVi1ds
	xsV0a7FOLUp+IoLNwz/+YyiDUJgisAOAut26pfaAIL7bIj6HYUk4iTA0AWjQmzWAi9/YflxCJO9
	M41QIs2z0VLPk=
X-Received: by 2002:a05:6820:2007:b0:6a1:189a:daf1 with SMTP id 006d021491bc7-6a36d85f68amr6255352eaf.4.1783609466197;
        Thu, 09 Jul 2026 08:04:26 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbd6c9sm1674520885a.33.2026.07.09.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:04:25 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:04:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [RFC PATCH v2 2/3] mm: distinguish large folio swap allocation
 failures
Message-ID: <ak-4d67hVnC2_BBH@cmpxchg.org>
References: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
 <20260709145124.764807-3-xueyuan.chen21@gmail.com>
 <ak-3r4i2qdejYzSP@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-3r4i2qdejYzSP@cmpxchg.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17630-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,vger.kernel.org,kernel.org,xiaomi.com,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:xueyuan.chen21@gmail.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:from_mime,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A006E732B2A

On Thu, Jul 09, 2026 at 11:01:12AM -0400, Johannes Weiner wrote:
> On Thu, Jul 09, 2026 at 10:51:23PM +0800, Xueyuan Chen wrote:
> > @@ -5550,10 +5558,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
> >  
> >  	if (mem_cgroup_disabled() || do_memsw_account())
> >  		return nr_swap_pages;
> > -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
> > -		nr_swap_pages = min_t(long, nr_swap_pages,
> > -				      READ_ONCE(memcg->swap.max) -
> > -				      page_counter_read(&memcg->swap));
> > +	nr_swap_pages = min(nr_swap_pages, page_counter_margin(&memcg->swap));
> 
> This hunk is unrelated to this patch. Don't mix refactor work with new
> functionality. Make the previous patch a pure refactor job (where you
> add page_counter_margin() and use it here ^), like I had proposed.

I also liked my version of mem_cgroup_get_nr_swap_pages() a bit
better. Please just use my patch, keep the From: and you can add

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>


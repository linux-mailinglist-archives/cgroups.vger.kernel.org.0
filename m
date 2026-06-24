Return-Path: <cgroups+bounces-17245-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8gGaKiv4O2qxgwgAu9opvQ
	(envelope-from <cgroups+bounces-17245-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:30:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AA6BFAA8
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DCIjiiPi;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17245-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17245-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0328B3004DBB
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942513D9DD7;
	Wed, 24 Jun 2026 15:23:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201473D9DBF
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 15:23:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314616; cv=none; b=sFA55wbZDTI9lObszUHVCxRNIDpsBpR2IDzF11ekNAxNFOYHi1MGmYoH5PGgnKFg5HrHukZ29ZJ1m5zCRcECQvpGD94h0fl2gIGDfyib2aem8Un5L1agl4uxYhmtBOySZudV4a6C9Xd1vg2g1zLdBWfHnK97zZNEmM8+6828WcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314616; c=relaxed/simple;
	bh=TDpKuBop+fiDvr98096WtJv0rwGE5xpN35yQ6puN03M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZVuk+uhh+V64i9Pj5OsIyX3vLxR4Z12xJN/hkI5ZR7VHpPX5oVTQDYY6iOAxg8+GFKtLClqSE/+zqfekqhsaYwjSxtE0+d8tgY3emfiFiqhb4KmkUXsNfJW+B5dR/VCvPJmNfKigqQw82BVpN/7MBMUjb7fnlVhRr2QUX9wnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCIjiiPi; arc=none smtp.client-ip=209.85.167.175
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-49190e20a0cso93672b6e.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782314614; x=1782919414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU7DP8gS2bWrp9HjVS61UBsZ2iorph10vTjTK+XSa98=;
        b=DCIjiiPiiq8I9VLSjmy0J/lauUNSR+7BCyM3dEgtX1WGdKOVxqa6kIahC1c1XB5FnY
         5ACz3vqt+gReplGlKbQq4pQ1beUeYxzPg4pZg1j1edXUF6BUceqwW+jMMGmSwIdecQDe
         /F1Pc7XWOlTQonoDRAbSbO71T7yo7ECV3eIVGBWGyVAhIXEPtKaXmWH1Ny5sIshrF1d7
         LY58CRhYuu0ZHMk7A0UFrzT3gOY9PyApyFRitRMoCvTYsHN0xoDUX0ZIPrZ6aaQn0uO0
         d6STZ6Xc/qgjooyw+Z9rVFhE15aVKypqsn+OL4/GnZQGaUwcIkO5dsHo/alptWOukqHD
         ckqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782314614; x=1782919414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU7DP8gS2bWrp9HjVS61UBsZ2iorph10vTjTK+XSa98=;
        b=QW3B0CiDG9mM1S6tR/ssV6N4qeHhHY9Mrn316hFctYK8OSIMgY8frEt+MZ5PeCxzlI
         5mlXfAxFzgeaRuHxdsXmAYWCLcLYlgk5Jf4ulvGK4ktuw/TsDi0Zn2ARDibPI/tmgBJK
         n3bVGHrcxcK/EIrNJMwdBBf1yAr05/4lwqsSKecff99zZ0iDTMmAXhFYaKt+R24L1yrT
         C2C5aOv2lueeNSh2s9SAfWJOA3SULlTQLo8YsFiNoITIIF5GEBbrODVnAkodU8zuwoM6
         PJx6Z8HZ4u14q41FcvWQWraBmR6Oe79+79RqdiiNuoymHJChB99TD20/zposwbF73k/P
         EGMg==
X-Forwarded-Encrypted: i=1; AFNElJ+MlY2rd0ylvj374Dqlk9T2i/x0nLaf75TkkpA/v28F4PFIwI64VbumpDmGSs/o7ekN+xl5iDKa@vger.kernel.org
X-Gm-Message-State: AOJu0YyusNmtATIc2d5BkWXW67l7NbDOdG0guN9hAOs6lna4OAppCgJc
	NBiKdqi4W1MdNJ11WKBYUNsGqsRYG0Ble0Ps+WOoSYo7mRuIi8D7/VAe
X-Gm-Gg: AfdE7ckJ8mBUAWUIpnEl4Dl4ov7rD3gL92bV7go8hqLqrRkDPzu7f+dJHnQhXfLlPI7
	na59nWP4QDQMuEgtAFApGfyKQTNrnYpkHRzQHIkctXMM/Ys3fF30yUzH9U9T+1qFYMfpn3eRwlP
	vDUe2IxZ1twt2Kasc+foS+zdKBgEbLmaNHhFLDBgF1KSJpqpnV6UJ8OrcHWLzVUZJ48u55i/9Sy
	tM+M6k6PEp2mkmUfNjmypSnPHq4O+IyrzUC7E6Z0414ysp0k76ER0ybf8p9QbPqUTwkoxE2g6FB
	M41o6GbR/9jv5Q1tWm9Oja+EnMWfhrLRzcoX106IHMZIE4LywC2KLIE7W/XD1adzH9FqQcoyo6Q
	kfFi7LQGKh0E3FKqB3rLOH4aA0qOOsmfiDz6HK7/WNQPqHIAem/8XyIO4i88qyVg0b+7O/Kj9S6
	7jfipE2PHHS8NFOnv7AVLRRhfYMRoRKYcQTSB5YS03WCM=
X-Received: by 2002:a05:6808:c185:b0:464:5f3:ed1 with SMTP id 5614622812f47-48f29793dc2mr5618299b6e.26.1782314613671;
        Wed, 24 Jun 2026 08:23:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aebb9f1d7sm9220420b6e.4.2026.06.24.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:23:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock
Date: Wed, 24 Jun 2026 08:23:29 -0700
Message-ID: <20260624152331.2228828-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624144348.4117578-1-usama.arif@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17245-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A8AA6BFAA8

On Wed, 24 Jun 2026 07:43:47 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> On Tue, 23 Jun 2026 11:01:22 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Hello Usama!!

Thank you for reviewing the patch : -)

[...snip...]

> > @@ -2595,7 +2596,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
> >  static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  			    unsigned int nr_pages)
> >  {
> > -	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
> >  	int nr_retries = MAX_RECLAIM_RETRIES;
> >  	struct mem_cgroup *mem_over_limit;
> >  	struct page_counter *counter;
> > @@ -2606,36 +2606,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	bool raised_max_event = false;
> >  	unsigned long pflags;
> >  	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> > +	unsigned long nr_charged = 0;
> >  
> >  retry:
> > -	if (consume_stock(memcg, nr_pages))
> > -		return 0;
> > -
> > -	if (!allow_spinning)
> > -		/* Avoid the refill and flush of the older stock */
> > -		batch = nr_pages;
> > -
> >  	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
> >  	if (do_memsw_account() &&
> > -	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
> > +	    !page_counter_try_charge_stock(&memcg->memsw, nr_pages,
> > +					   &counter, NULL)) {
> >  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> >  		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
> >  		goto reclaim;
> >  	}
> >  
> > -	if (page_counter_try_charge(&memcg->memory, batch, &counter))
> > -		goto done_restock;
> > +	if (page_counter_try_charge_stock(&memcg->memory, nr_pages,
> > +					  &counter, &nr_charged)) {
> > +		if (!nr_charged)
> > +			return 0;
> > +		goto handle_high;
> > +	}
> >  
> >  	if (do_memsw_account())
> > -		page_counter_uncharge(&memcg->memsw, batch);
> > +		page_counter_uncharge(&memcg->memsw, nr_pages);
> 
> This needs a transactional rollback. page_counter_try_charge_stock() can
> succeed by consuming memsw stock and charging 0 new pages, but the
> memory-failure path unconditionally uncharges nr_pages from memsw.
> That turns a failed allocation into a real memsw usage decrement.

Hmmmmmmmmmm....... I'm not sure.

At this point in the code, we are either (1) using cgroup v1 with memsw
and charged successfully, or (2) not using cgroup v1 with memsw. So I'm
not sure if this really is unconditional, we're just distinguishing
between cases (1) and (2) by checking if we're using cgroupv1.

Or is your concern with taking a charge via stock, but uncharging with
a hierarchical page_counter walk? If so, I think there's a case to be
made here with just simply returning the stock. I just wanted to keep
it consistent with the original memcontrol code, which only used
stock to fulfill charges, not uncharges, since this could make the
stock grow without bound.

What do you think? Thanks again for reviewing Usama, I hope you have a
great day!!!
Joshua


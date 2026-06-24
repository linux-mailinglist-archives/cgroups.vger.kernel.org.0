Return-Path: <cgroups+bounces-17251-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLMWGtEgPGoIkQgAu9opvQ
	(envelope-from <cgroups+bounces-17251-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:24:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D16996C0B82
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bjERdRTm;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17251-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17251-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3245301026B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6A32B108;
	Wed, 24 Jun 2026 18:24:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EC2EEE9B
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 18:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325447; cv=none; b=VjJnEGZQWyIPKlvUSrpCay/MJy/bFILUjvRQB91lN0VSk5Ug1CzVZBh5HKLrQjMVEk5c0iVREhDXJG7IiVuUyh5x/gyZpw74LxWjcOJOLN2r+MylASTp09h1tHzQjX3K/xaV1LriJxkiGt76l8VDmB3hsAYGGbC3SNOr8s/4ThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325447; c=relaxed/simple;
	bh=uHdiXSn8cjy3mkD+G0U0UxMKN2AyKB6KfcMTyvdtR6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6zFXi2qT5aZ9Rkt4pb9muErXCg7D/L2pfIlA2KX53j2YEHd2lgiA/2U9ChUFmdn9x+sjB0dFEneZsbZe3g5tP8Fp0v+tyGx2AwjkbF/GhuuXoaezXx2eP9HDEb0AkyBxckWpzmhHfYcZtvdvdQ39/eWJa+/jHb4JeprkI6rIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjERdRTm; arc=none smtp.client-ip=209.85.210.47
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6d991991dso1109353a34.3
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325444; x=1782930244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP6al2QbtqiBNwNbl9L6yaRaxgcZf//eTD2veoNh+pw=;
        b=bjERdRTmOJi4yO6bEGmWDIFZMz1tj2BgJ57bMuE1XH6QmQVV+Ow11QB+O3BsnmyeBk
         UWlUhQVNMgNVl6UxS+ihWvAD69R0bDkBaU734InRfXxKi9jzLnxMIYdwgbH6NXS4Cp08
         9s3tD2tv+G0twnclp5rWGab/idiMCK+7m689IE2vFZ/WnCaFhrOUWlf3GPquZBlKedsx
         8INdWs/hao2fqGU+RLNwYlsgAiZolzqRCIbt6UHr4YRQN/ZonB20gihZ4dUbnIKtdb4Q
         HQ6/1DgmrhbT+0wT2/mmocyudjNbD2SH3juguOpDCHmPlViLjExx77t7fFp+U90eyw8P
         DA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325444; x=1782930244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FP6al2QbtqiBNwNbl9L6yaRaxgcZf//eTD2veoNh+pw=;
        b=W6HSLEtiC9bp+dbWzMuWIXQBPWumzJH6tdfr6+3y+3fw9OjM36TNuqoiw45xux/66A
         lGZuZ8qXk7UbtAnnc76Rax9lnzHW7XB0sN3QozD3C49RMdzOLPwMHpTe++aWthtxrn9x
         CfXwpBkw4M5AH9y2K4DjhGcsEVO2PKO0t7LbyZWCwbEYJgXDaAbcPiv7nyMaNN87PeGl
         ONsZUF+HSE+6VHCVWZeBU6A/S//gW6gyOv6svYz4ql1V/6HmlvCr8+TqJotuba/55tfh
         IkqC+QyEX/U98kt2Jr3E0TIGldwuuVXQZZjaZZ28OLLjlSoFDcTYgz5GFC3yUAtOGqe+
         jylg==
X-Forwarded-Encrypted: i=1; AFNElJ/OvDyNLQ6ZcgsyivTGKI+qgU3F+Aupe/NTHpj/6/7NIS4qIdBWUsYlE1TcDLwmNegy9uMx4cn/@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXsKeC3jF6QrlOPNIW2smZ3KENHPB1WDPYH/Q9+YzE45ZUkYY
	TXlFSqZjyTYrdZHH8/g1SRpxrwfR6xD1YBsH4kF7HEphnaw7+pmywS1e
X-Gm-Gg: AfdE7cnZuxBV4rU3gLeFv5+PiaFYF5y/4xj64jAsHC+OCNrn8+vT2rXYUw+GAYMt+3b
	zS1J8QH63vV9l43isJ9fdCUxUn1WXbmCzEuak41yQQtl05eOJSee+7E/uO4fyy7LAu5smVVMoxH
	Jod1Dy6kqdSI/JAmYxib4huNFe4MSDioyuy5foKz6mOKB2xxjVrtFAGniH/DpPOCUpfbqpULmGo
	A3lfZwadKJMrtq2Jqtx+0yHnCZQDteNrGDIB6wMamrS5XUdSJp7K0fT4OEZzCqUYY2GJynJhjfv
	E+DPqAFNcZ+ZXYspPa+L6k7tpQW7OmsIQiWDB2vbDZYf74kox/gCd8/8DbY8pfMGNLg8UlBIm+P
	8EOZatJ/gCb2F7U4vgc61iHJDNLLJMXRIgpXitc+sPEakLhPCZP5TBLzxep977sMM/NcZ+Mj0K/
	LixzrCbtSbuC4+Rcbov9kXsiLKWvIgPkkItswHox3jmsE=
X-Received: by 2002:a05:6830:4409:b0:7de:5612:d420 with SMTP id 46e09a7af769-7e986c7513bmr4005787a34.18.1782325444557;
        Wed, 24 Jun 2026 11:24:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442e98e9sm11837257a34.25.2026.06.24.11.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:24:04 -0700 (PDT)
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
Date: Wed, 24 Jun 2026 11:24:01 -0700
Message-ID: <20260624182402.962094-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <120367a5-0a3c-40ba-a821-f46f8494ef85@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17251-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D16996C0B82

On Wed, 24 Jun 2026 17:43:56 +0100 Usama Arif <usama.arif@linux.dev> wrote:

> 
> 
> On 24/06/2026 16:23, Joshua Hahn wrote:
> > On Wed, 24 Jun 2026 07:43:47 -0700 Usama Arif <usama.arif@linux.dev> wrote:
> > 
> >> On Tue, 23 Jun 2026 11:01:22 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> > Hello Usama!!
> > 
> > Thank you for reviewing the patch : -)
> > 
> > [...snip...]
> > 
> >>> @@ -2595,7 +2596,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
> >>>  static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >>>  			    unsigned int nr_pages)
> >>>  {
> >>> -	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
> >>>  	int nr_retries = MAX_RECLAIM_RETRIES;
> >>>  	struct mem_cgroup *mem_over_limit;
> >>>  	struct page_counter *counter;
> >>> @@ -2606,36 +2606,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >>>  	bool raised_max_event = false;
> >>>  	unsigned long pflags;
> >>>  	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> >>> +	unsigned long nr_charged = 0;
> >>>  
> >>>  retry:
> >>> -	if (consume_stock(memcg, nr_pages))
> >>> -		return 0;
> >>> -
> >>> -	if (!allow_spinning)
> >>> -		/* Avoid the refill and flush of the older stock */
> >>> -		batch = nr_pages;
> >>> -
> >>>  	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
> >>>  	if (do_memsw_account() &&
> >>> -	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
> >>> +	    !page_counter_try_charge_stock(&memcg->memsw, nr_pages,
> >>> +					   &counter, NULL)) {
> >>>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> >>>  		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
> >>>  		goto reclaim;
> >>>  	}
> >>>  
> >>> -	if (page_counter_try_charge(&memcg->memory, batch, &counter))
> >>> -		goto done_restock;
> >>> +	if (page_counter_try_charge_stock(&memcg->memory, nr_pages,
> >>> +					  &counter, &nr_charged)) {
> >>> +		if (!nr_charged)
> >>> +			return 0;
> >>> +		goto handle_high;
> >>> +	}
> >>>  
> >>>  	if (do_memsw_account())
> >>> -		page_counter_uncharge(&memcg->memsw, batch);
> >>> +		page_counter_uncharge(&memcg->memsw, nr_pages);
> >>
> >> This needs a transactional rollback. page_counter_try_charge_stock() can
> >> succeed by consuming memsw stock and charging 0 new pages, but the
> >> memory-failure path unconditionally uncharges nr_pages from memsw.
> >> That turns a failed allocation into a real memsw usage decrement.
> > 
> > Hmmmmmmmmmm....... I'm not sure.
> > 
> > At this point in the code, we are either (1) using cgroup v1 with memsw
> > and charged successfully, or (2) not using cgroup v1 with memsw. So I'm
> > not sure if this really is unconditional, we're just distinguishing
> > between cases (1) and (2) by checking if we're using cgroupv1.
> > 
> > Or is your concern with taking a charge via stock, but uncharging with
> > a hierarchical page_counter walk?
> 
> This was my concern. But I re-read the page_counter stock invariant,
> and the stock-hit case is not an undercount? Consuming stock transfers
> already-charged credit to the pending allocation; if the later memory charge
> fails, page_counter_uncharge() discards that consumed credit from the
> hierarchy. That should keeps usage equal to real charges plus remaining stock?

Yes, stock-hit case just does some math without doing any actual
charging. It's stuff that was pre-charged before, so we're not doing
any undercounting or leaking any charges.

What do you mean by "consumed credit"? From what I can see
page_counter_uncharge --> page_counter_cancel subtracts from
counter->usage, which should be the real charge + hierarchy walk.

Am I missing something :p please feel free to let me know!
Joshua


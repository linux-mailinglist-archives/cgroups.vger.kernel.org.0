Return-Path: <cgroups+bounces-16325-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIe7H0r+FWobgwcAu9opvQ
	(envelope-from <cgroups+bounces-16325-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 22:10:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8245DC3AB
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27BC53016D01
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B73B7B8C;
	Tue, 26 May 2026 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="csCuCVQd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10E347BD4
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826246; cv=none; b=QUJ4w3zxRczjbJQDP5bivIl8H+BGN+SQLkr+99eeBV7EkMFkw/taCnZ5QI2agCzJsvb8LpEVGLnpFxgxKBXKLLPm8GNfhrJjbSNsn/0Hgc0cm8PATSPNJZWik4+wnFakuRwBsyt+Bi11gVyPsEhvuFP8Ur4MKrdmoTX90SkEnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826246; c=relaxed/simple;
	bh=YMLsVDxtr2b9s0yBcpbvn4Q16I3m7NzRBDVWT0LcopM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkQNWDuTJhBOtekGsj9uFTxiPMhthOTdIZUR+3hDgafdrkRoj36iNNooYI5Na0S5Ni4AOR43uQ5xcTtp/57G03bGjvOeYPmO5mpstGbvHlouglcHO6ClCmVpDVXjXddqM5zwYdmqrk9WuI2VFqXOMPS5uFYRnX9GkC9kfjv7sxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=csCuCVQd; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914b5f85129so406002085a.3
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779826242; x=1780431042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tFZxDP5yKXP0UhVdj6/0NYHpVXbpIOmDxHnncGDOQE=;
        b=csCuCVQdZ/p9e5RXWPNQy8wc3L0nZjXLDs9OM2xI4PHNFvl/pon53CM9LC7FsFPHji
         bzvlRyCByOKnh9FIEGMFEEsCc8AfELrHar3+Z+DPME/RMsNLGC6CIDQTpmPSlAL/ggDP
         +YtPH1dUQPoFUBrHbLweUndNNbCFQYQ3r57gU0rI1D6CLL0jEBJHznfRMypZ5M4EkGzS
         lIA3LaaZfC54PHdA9nT2Ej+cYJHgCOpwM4I1sXqypzkGHsehru5fbI6Ka8dNMsgPn+Ca
         JSx0+3KZhYsfcbFjlK5/ezFvqfLdM3D6YzN76d+L8ybkeownFFbOOAb1ya52OTz3565U
         NPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826242; x=1780431042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tFZxDP5yKXP0UhVdj6/0NYHpVXbpIOmDxHnncGDOQE=;
        b=jlBT9G7takwZ1hJAQh5OIQbZEosPTICdrFOEMeLrARw3si3enlYS1KPidOPxGTDtiC
         y387qXf856Yt91AgxiaKP7Fxvo6uYdx1UyRM7CxBzWECVHJRYYQL4C/uRfHd1s2TxsrP
         dUFLO62mfblPX7Kc352FtKSGlHyD2Rq24w2gkHfIyK9mVrgioKQl9e8nksDvvadFfI2j
         PEjibBSvX3SaKWt3afDZvpz+WafYh8sEi8vskH4jOjpDpnp758/dmuc69A9HOQ7msITI
         cLJKd/g+70dRyJ8/BktFFbQpS6XC3iQkGbwlUsz3rbCPBD2B+mA/Rq4paB1MYXaI/NyT
         rrLw==
X-Forwarded-Encrypted: i=1; AFNElJ/auENTehYzWrQ5fCi/APyPh7hnIivqZFjcHOiRAQ413hv/0LJV71cjElClRYaBelOCEfo2ZP+0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RjRSNWkix11Vnfs6fUz5+kO/Fd3a7kvpmDa8pDKWN6F6PPKF
	HGa56w1bP14N9lt4keDSjWe23hR9JW/kUxKI3EqasI0L0qnptGZDaH1O/tfCX8JDX9g=
X-Gm-Gg: Acq92OG7KmRdo2cH502mZnhbSNSj+N4NRkBrBgZjSUYXO/UMKEos9+Qx8JTRDclZSSE
	U+NnGQC+FywPXPrQZwOJdPVbmxwW0pXq7t8C/L6s2AcDK8/3Mkwr2UT8aOf6xc79F5gIP1fHrOc
	Ya8xN1smpD0eRCnMaErZ9v8GyLrVd5+YCcj2Oe+zL55zcAQuTgNiVnPgeZIUDe2fyl2nrL0NcW3
	WxfyTRglHwMZdwJFXnKAdiA8VPN3JV5wRa6McIZMQwWa4NCvpJ7tqVNL00AjOSepTA3KI2X4pA9
	89LmJyruDCOgNOZdlLl8mnaJE0q3Kf59j13pNthLlga1/MHoJpqQhDb1j53qnoDVBTSRJfQj9dx
	I+gwlgPA4b4uR6wic5roKVNdvuwgyl58xdC1MXC8nnRdK85J9/+24RLGhdZjhM2fN+CwSpAsuI8
	9FOUf1tv1gT4Rh017myYBjVQ==
X-Received: by 2002:a05:620a:4083:b0:914:afb8:795e with SMTP id af79cd13be357-914b48e7e4emr2837476385a.19.1779826241715;
        Tue, 26 May 2026 13:10:41 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8810a50sm310312585a.41.2026.05.26.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:10:40 -0700 (PDT)
Date: Tue, 26 May 2026 16:10:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] mm: switch deferred split shrinker to list_lru
Message-ID: <ahX-PHlOwAn5whdi@cmpxchg.org>
References: <20260521150330.1955924-9-hannes@cmpxchg.org>
 <20260526120923.2331056-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526120923.2331056-1-usama.arif@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16325-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 0C8245DC3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:09:22AM -0700, Usama Arif wrote:
> On Thu, 21 May 2026 11:02:14 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > @@ -4446,36 +4377,20 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >  				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >  			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> >  			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
> > -
> >  		}
> >  	} else {
> >  		/* partially mapped folios cannot become non-partially mapped */
> >  		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
> >  	}
> > -	if (list_empty(&folio->_deferred_list)) {
> > -		struct mem_cgroup *memcg;
> > -
> > -		memcg = folio_split_queue_memcg(folio, ds_queue);
> > -		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
> > -		ds_queue->split_queue_len++;
> > -		if (memcg)
> > -			set_shrinker_bit(memcg, folio_nid(folio),
> > -					 shrinker_id(deferred_split_shrinker));
> > -	}
> > -	split_queue_unlock_irqrestore(ds_queue, flags);
> > +	__list_lru_add(&deferred_split_lru, lru, &folio->_deferred_list, nid, memcg);
> > +	list_lru_unlock_irqrestore(lru, &flags);
> > +	rcu_read_unlock();
> 
> Can the shrinker bit end up on the wrong memcg here?
> 
> deferred_split_folio() takes the lock via list_lru_lock_irqsave() with
> the original folio_memcg() of the folio. If that memcg is dying and
> already reparented, lock_list_lru_of_memcg() walks up parent_mem_cgroup()
> until it finds a live sublist and locks it (lru), but the memcg local
> variable still points at the dying child.
> 
> __list_lru_add() then calls set_shrinker_bit(memcg, ...) with the
> original (dying / reparented) memcg, not the parent that actually owns
> the locked sublist where the folio was queued.

I think you're right. Good catch.

This looks like an existing list_lru issue, actually. Even before,
list_lru_add() would call lock_list_lru_of_memcg() which might do the
hierarchy walk. But then set_shrinker_bit() on the passed in memcg.

I'll fix this in list_lru first. It's a likely backport
candidate. Then rebase my patches on top.

> > @@ -1301,6 +1301,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> >  	if (result != SCAN_SUCCEED)
> >  		goto out_nolock;
> >  
> > +	if (folio_memcg_alloc_deferred(folio))
> > +		goto out_nolock;
> > +
> 
> Over here, you will end up reporting success on allocation failure.
> 
> Maybe set result to SCAN_ALLOC_HUGE_PAGE_FAIL?

Good point. Sashiko pointed that out as well. I have a follow-up fix.

Thanks for taking a look.


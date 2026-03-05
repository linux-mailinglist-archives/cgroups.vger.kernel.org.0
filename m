Return-Path: <cgroups+bounces-14670-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG1TB6GBqWkd9gAAu9opvQ
	(envelope-from <cgroups+bounces-14670-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:14:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CB2127F1
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC28131343C1
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A439B4A9;
	Thu,  5 Mar 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="PNkyumOx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C261B4257
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716161; cv=none; b=NLwxQTMJOAxuct06/tO8oxtuk4zt+WtSV69I0vcHCgZ6fiwEf1nlg40T/ebFNXR2JFgn0ZUjBgLU6RsTEZqKIewIoqe61/iarxITXwjvKHX/5hoqU9F5NijOQI7X3MX5AMiLacIuoIAx8uhSuDXZjgfRflHjjEvz3DWWICxDkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716161; c=relaxed/simple;
	bh=8T9epKh2buznNrrWhPOPl+MXk6VUa5xnuTzDvWpucb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9BYpPT78m7AWZHbTQqzN2qzigXDaNIqvgtoBjEZBZ4rNKLQEuBbwpci4MBGzPPrUzPofQ2qA6L+lo17jnpZw7PCxsPjeK70sZswaExcjhopsnc6OsJdoeS45LyBwHZSkKcBRWgjB7Qrm1P0+OErxXdO566ssB8vGDhe3vV3AVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=PNkyumOx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899fb030812so61895156d6.2
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2026 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772716157; x=1773320957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCwW07BC85VhkN6p7jwWc7fFxc9d+eDY6Cs2s6mDKrE=;
        b=PNkyumOx2oJKa5/3dNeu2XPv4rdjL4aykMZbNtv7dcZFV7rlXoUBo3qxRwQQAR3Ei9
         weBun5PF+cwQBkgNLHvOH0v3xP/UFv4Z2DjiUduBeJz/Mzdlv1oyb5xxJqWQdGfOjUuw
         efbX9+//D946pbrF9htHbWegTS7ii7cSvtmG2lyzeupmHyLzd8esngiuvOEk7itSE1WR
         dTfXYnomEiNZqvRAeBh8KqjmERQjhlGlPzF34YwgthJybTm3qFWCJ17kPga+uFP3YopL
         mUEOwtvrTmPj1zGaQ6cBZn08FYov/9y5LXGqZE3qpYYdt0mdb0cfGf8GWmXTKQPfh02D
         uqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716157; x=1773320957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCwW07BC85VhkN6p7jwWc7fFxc9d+eDY6Cs2s6mDKrE=;
        b=mRhMA4VcLoG3jGtj8/IsZU4yEJkip+fkS8cSxLmYomqffAwA9iXaLNqcnQlsZtrJrD
         bW5YQLbLEn1zbgVTEW66EnMJ8qq3oA5yOs9/Fby8BrQ26nKNrj/soBx7eQZCrMqwGRGK
         hSvsh8hyuytF9sA/SJuWKrH0mIzzEWYk8z7Wg7SSvA9a2oRLtQ3kFyy2teb6DXUA/jnK
         dzd4tRRLmCY3t7EYFPz7IprhSRT1lGHv3HeH97vm7hkfEj15P9SPzGueAhpxFpT+2oNe
         9K5ZMTnp7AnnbnPl8+qqxi99lDUP9bFuJX+f7vK6CsbhkHYWArpSEfXbKDYDKZL6qszf
         abvg==
X-Forwarded-Encrypted: i=1; AJvYcCWANd5gOYTmSGJsWYIvlyfc9CZBl9MMBgcRwfOVw8AAmrme03RuCmiGRpzI7MgyJYReXhWoPIiF@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaDYoZBu320e4b4NKHXuCXLbCMe8oZ1vd1lKtxF2vMWv65z42
	D932vMjZeik81rMRnjR9N/krAA2cqi588OKDd+ghELylFPBf8KuLoHKrUdbXBQh2oP4=
X-Gm-Gg: ATEYQzwjRl+yORmknR+y5caDxQMbcmI6IRE01YB9ytdzihSOjie1SoNBbxrMXjG9Fmq
	Esn0N9L9zkYzohBk/g+hGIC1w3IJk5IoR/nPcuCSdWnd2Q8aJiXzVwr3Q98CfEZ4sTkCFau8bsl
	b48LDHsHhYEn1u7N4x92PwVTS1C9k1z4YJotAKxicHWGhzNjJ3wuYcrUh0KNbrqAdw/Zjs80HTT
	aJI4WcjI8yWng1KyvX4mzQmhakJ3sJLUZjDz7ZS8FJ0M0NvQwUZ/P9fZbe9zUsC8JaExmXj0mE/
	Nq/coxfKNmk1+hOhnV1a+K5zNvs0lmjFDOLYzmQltAXbwS39J7am+Xfn0zxwX+OPBHQ5EDoNkFd
	m3gcEXQPKK5FAANAkp9uzsWoIh6uwqN8uUioz6xYAzpIwbDGsqbsEFAyIVFY+fCUEZx/xwVcXzk
	rIQ6f6zM6Bvs4vGjzJxOBMeA==
X-Received: by 2002:a05:6214:2a86:b0:899:d6d2:4b96 with SMTP id 6a1803df08f44-89a19d19be3mr78504446d6.34.1772716157355;
        Thu, 05 Mar 2026 05:09:17 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e608cfc6sm122095406d6.14.2026.03.05.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:09:16 -0800 (PST)
Date: Thu, 5 Mar 2026 08:09:15 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <jweiner@meta.com>
Subject: Re: [PATCH 1/5] mm: memcg: factor out trylock_stock() and
 unlock_stock()
Message-ID: <aamAe7h618G40h65@cmpxchg.org>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-2-hannes@cmpxchg.org>
 <e30308d3-b70a-40f9-9c4a-b3a777bbe45a@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30308d3-b70a-40f9-9c4a-b3a777bbe45a@kernel.org>
X-Rspamd-Queue-Id: 611CB2127F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14670-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:23:54AM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/2/26 20:50, Johannes Weiner wrote:
> > From: Johannes Weiner <jweiner@meta.com>
> > 
> > Consolidate the local lock acquisition and the local stock
> > lookup. This allows subsequent patches to use !!stock as an easy way
> > to disambiguate the locked vs. contended cases through the callstack.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

> nit:
> 
> > ---
> >  mm/memcontrol.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 753d76e96cc6..a975ab3aee10 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3208,6 +3208,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
> >  	obj_cgroup_put(objcg);
> >  }
> >  
> > +static struct obj_stock_pcp *trylock_stock(void)
> > +{
> > +	if (local_trylock(&obj_stock.lock))
> > +		return this_cpu_ptr(&obj_stock);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void unlock_stock(struct obj_stock_pcp *stock)
> > +{
> > +	local_unlock(&obj_stock.lock);
> > +}
> 
> Could have added inline's there. The compiler heuristics can be sometimes
> unpredictable.

Oops, I almost missed that, but that sounds good to me.

Andrew, would you mind folding this in?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36612175e98e..178be98f2e49 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3160,7 +3160,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
-static struct obj_stock_pcp *trylock_stock(void)
+static inline struct obj_stock_pcp *trylock_stock(void)
 {
 	if (local_trylock(&obj_stock.lock))
 		return this_cpu_ptr(&obj_stock);
@@ -3168,7 +3168,7 @@ static struct obj_stock_pcp *trylock_stock(void)
 	return NULL;
 }
 
-static void unlock_stock(struct obj_stock_pcp *stock)
+static inline void unlock_stock(struct obj_stock_pcp *stock)
 {
 	if (stock)
 		local_unlock(&obj_stock.lock);


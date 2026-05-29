Return-Path: <cgroups+bounces-16436-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFl5NBWZGWqGxwgAu9opvQ
	(envelope-from <cgroups+bounces-16436-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:48:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7426030EF
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA42A301FD61
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690E330B09;
	Fri, 29 May 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="nbQINirj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E422425B
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062130; cv=none; b=Uwa895fVlgV4odWQHfPRhFB93a/ENJGeLWOW+QpS0rAcUPLtFRdxI5+MnLdY/bYJ0KnrFjFlHzfh+liEyJmgJPjAO7aUlJcOEJxrRh8kMl3//xNBJizIPNgQcI2B/M3leEa9y/DopAd2MPtU8NHIpFnunr52NdaKlyCiOaZVeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062130; c=relaxed/simple;
	bh=7FQy1qlhL+joqSWk3OaqyFYPhh8jfv0FC6KwZ1gYfF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ery71tDLwp77k2EB5GKYkgvb4yCTYGLNNgyM27sk2xF+4DQJsctE16x8lvwy87qynmvm38bSBzDzPCkGyxQ9fL4ZGgu+mELI0Jz5lzNmA/6J7JPz56WJqfQP8syKz40Z8PRdymVw4xRGCH8AAakcW4dO+fbOvPnXjuaeWhhMMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=nbQINirj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90fe17c157aso1473021385a.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1780062127; x=1780666927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpbakxeVUDkW3G1QkEPqtCqf9wGLZXcu/9D8TGYnFkc=;
        b=nbQINirjU2OkleMLIq16EL9/y30sgCL5X3VgE/4LFGXOb5Bme77iR1jlROA5NcsLDH
         WKGyVm7UPZK6kH2HNoUBypAWNid54hiWfLQBeVcwR+iWZPvO8jG7AwwCU7HJEmeUIS3n
         oxVGNUsVjLV3jkKfAm42fmR++qGlzYMKKnvvONq6HSkivdW+G8+wqJ36fBuFDmXKYKTR
         DVJxmfW6IByplPGuFZA3u1lQXg/9+6bs23HXU5Nh1gVuMrodJdWt5omgGdusA6YjfJDk
         UwpHjkS3MiS3bnj16lu0OiyqCayRr2Xk9ir8c2iMJPqSwh5p23D3+4zc4opns77uobA7
         uChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062127; x=1780666927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpbakxeVUDkW3G1QkEPqtCqf9wGLZXcu/9D8TGYnFkc=;
        b=IT2QqEZDnZdweHrkIYlaD1KFEx2/PLboyNyByL0iEElN1TJzUShOrrw2YXv2yqXk5U
         pds2RaXaCH3yNuQQvDbdMnW8NPoICEVI8P+pG/0tecih8j77uz1KgLq888CHyUnhAExI
         qK1DqfIF1aJAUA/ZIVsEtL8ZCQ/V6LPcpgr6+SHfik3sUXHbIYg364gM4I4NedgCdlaE
         CKdROvPFB2ZDuIzr4zWuZ1NZ5mhoTX3ZX7ZvzQIZJ9WuqNZ0CwyMqRuyA8pegiWdYg0c
         0yfJl0C3wwalpqdZzyQJWZrO4PaWdKPA55wqc1Q8O4zmPVs2J+BwKYmWqZGVQFYKgK1A
         o24Q==
X-Forwarded-Encrypted: i=1; AFNElJ/k7BXn4ZAtJgE4z2FDEEhLUavnvvKk73yEbFsDP8ZJpl92Ev3FS2YsVQo4po6Ip6G1ieqIUEBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEnYiwdsRlwhcRXSgecEIc/mBXWfSJoznTPeW8ewVADtQQxKY
	q11ZCrOtpZlm0jJ9kfqMxo36HEz6Pj4HofO3pEiT3WPfBFsFwD/IV6SZOx/6hw+R8EY=
X-Gm-Gg: Acq92OGoeKjoll7B+F1kywBFjk+sZWfBiQH3aaRNnvm8vabHdVLc9tW0oe+5ys3PN0v
	osTjvzmKNOp2q9w1J9krnePmlF88ocyG+epiLAD0X/tUvKAxc5wJI76XNT4uSlcaLY2uBfChN4L
	ZQP9gxRrmww2VxYZvUEEffdrOXHC8lyJghHbx9Nn4xqaEK3yTtmwS1KrfRq70EqoKp68ApExmxZ
	6+LsEDYcXZXl0VwnGJsv7cZfA20IVwLD3mfucSWZkxBh2nahPXvmmytGPsuwVf2lvMot9cza+O/
	j40ZbUOTY/a5SF47KDyW3UYdyUxbkERoEZUBrqH/j6iAHRqAD7OhbV1f2sFEL+8HhtdAdVdq2O3
	rYlbhCeGF+7UNvJIBx80gHoranA77Yf3gkOMXTq/PIfQShKXl9x+/ZbtSTim9Yi3PvFFUdiqQEE
	J+w/sAELAqSbNaEA8k82ZzgwanjMo6trmr462gc8wlaMc=
X-Received: by 2002:a05:620a:6f0d:b0:900:8024:4f9f with SMTP id af79cd13be357-9152ff63cfcmr375008985a.60.1780062126522;
        Fri, 29 May 2026 06:42:06 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265d794sm185888785a.47.2026.05.29.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:42:05 -0700 (PDT)
Date: Fri, 29 May 2026 09:42:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Wei Yang <richard.weiyang@gmail.com>
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
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] mm: list_lru: deduplicate lock_list_lru()
Message-ID: <ahmXqjQ0Vz4pb4u1@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-6-hannes@cmpxchg.org>
 <20260529095628.nagjdy3f24z6qjtk@master>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529095628.nagjdy3f24z6qjtk@master>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16436-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,infradead.org:email]
X-Rspamd-Queue-Id: 2D7426030EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:56:28AM +0000, Wei Yang wrote:
> On Wed, May 27, 2026 at 04:45:12PM -0400, Johannes Weiner wrote:
> >The MEMCG and !MEMCG paths have the same pattern. Share the code.
> >
> >Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> >Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> >---
> > mm/list_lru.c | 21 +++++++++------------
> > 1 file changed, 9 insertions(+), 12 deletions(-)
> >
> >diff --git a/mm/list_lru.c b/mm/list_lru.c
> >index 7d0523e44010..fdb3fe2ea64f 100644
> >--- a/mm/list_lru.c
> >+++ b/mm/list_lru.c
> >@@ -15,6 +15,14 @@
> > #include "slab.h"
> > #include "internal.h"
> 
> Hi, Johannes
> 
> One very tiny nit below.
> 
> > 
> >+static inline void lock_list_lru(struct list_lru_one *l, bool irq)
> 
> Here we use @irq.
> 
> >+{
> >+	if (irq)
> >+		spin_lock_irq(&l->lock);
> >+	else
> >+		spin_lock(&l->lock);
> >+}
> >+
> > static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
> 
> Here we use @irq_off.
> 
> Do you think it would be nicer to unify the parameter name?

Yes, I think it would be nicer.

Note that I inherited this - we had irq on the lock and irq_off on the
unlock before already. I didn't want to mix even more yak shaving prep
patches into this series.

Mind sending a follow-up patch on top of mm-unstable?


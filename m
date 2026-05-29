Return-Path: <cgroups+bounces-16421-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO+FLO1iGWrDvwgAu9opvQ
	(envelope-from <cgroups+bounces-16421-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:57:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A060054C
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5718F3065BFC
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94C3446DE;
	Fri, 29 May 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVQAw4GH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5C3546FB
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048592; cv=none; b=nYgQNlSE6fYzTB8eCTWh74chJcIXnKRUeCwmXJtTB0AizSzm6ofwbQr0cJ1moBRtiMljN7wKx8pS88zIMsbF6tMS0FYVzho+1nnq0Shoxanw7DdDyhCHAV1fl5B4RF/Mfhm1dgByRsCYzRlBxWqTCHUlwyJjQ2QDBEH9HOqed9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048592; c=relaxed/simple;
	bh=b4SlGHyKejpjGEPSSsF9TtxkNCBpxGUf0lpztK/k6FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXQEVd15U/C8s4GB7R4MM5qExBkmJ1O6AKFZJbovj4ZCe0MzCVNKlVGZ2vL0N24s73cUfX1E2THGoIa5GcONmM57T3LuSVKz8s01EJZudj3+vXaorZXOx1JaKmG5AbHd7ocy4kiBnzh/0mg92FkoBSImDm5iOscyF3UfhizO8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVQAw4GH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so357078f8f.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780048590; x=1780653390; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlBVL2w9TAGD5JVBams2MPk6DO1Ps9XKY2pj6ZAb950=;
        b=jVQAw4GHq19+XzXlvAaw6dL6k9Ehf2rQF0oT2xRU6PzGVvpUeYKgHIARgCND67ZZEK
         6ln6r9u73kj364EMV3Ljd4ODIc4HM13izpThsm9GpwlkfGsofCVgWUyRW8kh/Jr54gYz
         hL0o7wkWyl6qDtiHlvmjutstqBRW9CNpW1CnEvw+zJcZGbzf9O9dzzvGqnBE2Zdvvx3b
         mWQCWRhGkGmbnFumNnYBObFF/baRlOUZyo9dliNPUIqPIzvN9zRoeyZqGpYRM+SiGriu
         4vvlGMItgXHxbFr1HK8ZuiW+hQ3dTEUrfNrrPdh61Y7qTD6Sp72lt+1Q/fVXtMPgUQu8
         esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048590; x=1780653390;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlBVL2w9TAGD5JVBams2MPk6DO1Ps9XKY2pj6ZAb950=;
        b=KkEOdfjxSiQ6ACiCdmGZlMWmAB1ZCScY/aBojUjgDKvPV3T0Oz2AJJzEXtilKu9Yl5
         Gk9p5t4NDuVz/sMNxzPRgXcvaiyo2Rz5zw3u1sRBA96IG77Zazux8pQDHYarUzNshu/j
         Qqt3KTBJR3mhg10lTvYJgXbn52RiHcRmW9LTgaJNv3+Bt9XnrKx3XHrQyS0K/FI/NFEZ
         DZHwYwPQ4WPVUqwusJQkFYvqi+wZZKVsEXjxG0MZpoR5dNGt+sIVaz184fYzh6Rkk7Es
         TEFf8eTgbbFcy9+f4JidgrWJqSzSTqBVuB5V5owbvuic0dGvH9Roe6N3njGjwTZ8fWc/
         dYdA==
X-Forwarded-Encrypted: i=1; AFNElJ9JYrXQfb5FdR2ieBHGuJiJHDidfy+4Jl5hFRPO05bPmNZspDpjictDuzpRhllOX5sU89jnSqqM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqvp1mUPMYLtSFR4ckA6zJfC+nckYRnc4NQT5n6UwCp7W4wcK+
	hYcsSq6ECltoXwYjT4RV6KU9cOJvrJyvNYCioNdM4FQZzsVSFAk0O9De
X-Gm-Gg: Acq92OH6hsLy9CzCKks9xQKgJrd+0CGBUeCsJtEe7Ag0EWOobGop/eYR26c5XabpRzL
	aqC+IcZAoA8GRkvyaZHBQO0t2KEaQIzYq8yNNwVqC2i2oVw98sATjaeZvseSyTjt4RnXsnjYsLW
	tLYA2oFIRNZ6GomEmaOysUCgJvCN5Gbg1+SBg0k3KZK/577uyNzl9d2S2prgk+leWL6HApFP7uO
	CvGmRmiYEpWMNaus54tez/tGJMM+5dqg43DXHpVAisBv5eXjN/gqc9LuIcH5qf/OdUQ90yzDfSK
	9CyJDgh0Nf2ja5IOz+vXpLvIEqFb3bhN7Dg+R8n4KjZbji8X+7PIUaAjZL4Yy5n9dkgSk1g/S/v
	UtQkBeIX9Sy/dGexrLGrdh3zAEQ56MBN06m/FvuhivjlkAVBmb/vWA337NwPKzN7rD7BNFuRQ3v
	fN3wRn9t3rC76GPYh+uUB9rbfa/Q80mDil
X-Received: by 2002:a05:600c:c168:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-4909c07267dmr43425645e9.5.1780048589855;
        Fri, 29 May 2026 02:56:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm11200965e9.6.2026.05.29.02.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2026 02:56:29 -0700 (PDT)
Date: Fri, 29 May 2026 09:56:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <20260529095628.nagjdy3f24z6qjtk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527204757.2544958-6-hannes@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,infradead.org:email,cmpxchg.org:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-16421-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 4E0A060054C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:45:12PM -0400, Johannes Weiner wrote:
>The MEMCG and !MEMCG paths have the same pattern. Share the code.
>
>Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
>---
> mm/list_lru.c | 21 +++++++++------------
> 1 file changed, 9 insertions(+), 12 deletions(-)
>
>diff --git a/mm/list_lru.c b/mm/list_lru.c
>index 7d0523e44010..fdb3fe2ea64f 100644
>--- a/mm/list_lru.c
>+++ b/mm/list_lru.c
>@@ -15,6 +15,14 @@
> #include "slab.h"
> #include "internal.h"

Hi, Johannes

One very tiny nit below.

> 
>+static inline void lock_list_lru(struct list_lru_one *l, bool irq)

Here we use @irq.

>+{
>+	if (irq)
>+		spin_lock_irq(&l->lock);
>+	else
>+		spin_lock(&l->lock);
>+}
>+
> static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)

Here we use @irq_off.

Do you think it would be nicer to unify the parameter name?

Also the name in callsite and the argument annotation. Would it be cleaner
readers?

-- 
Wei Yang
Help you, Help me


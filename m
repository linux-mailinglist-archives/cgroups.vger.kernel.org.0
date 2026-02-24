Return-Path: <cgroups+bounces-14215-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOVAKjiLnWnBQQQAu9opvQ
	(envelope-from <cgroups+bounces-14215-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 12:27:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC518642F
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 12:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 653F8305D241
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E637C113;
	Tue, 24 Feb 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aquLdW0A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3537C0ED
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932432; cv=none; b=laVaAU8gyXkeMPqhHmCWg1nk2ST144sMX9vSbUieC08njo8qr8EZlJJG5pVAQj6Qc31JSqDJfC0J+abBKxL0QlHSlMLXV3M8reiE3a3wfJ+P9qV6wsTE8nEwU2ayWpj1/h6mSXETfMpavkGNCPmMgMuoJcjCc4hQgapMMrXBgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932432; c=relaxed/simple;
	bh=ng+Nx/b9d4V+N+mQqs1YRMrAFYLDaza0plzDmLxFyOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nig/dzbzCNbZ/FMyxgrFz2NetPv/IDe9OvRiiZO3ep+znA+UvlICbJ4aWLNfrqXaYHvzvoqSzqicwoleTdT4Qejq5AY9IU+YkS7l1vXoWGNuDzMYmNEODM5IQlZCSgfloZmUWnRBkLat8RLaEn9oD9/KrzfpHUfTXHENpf7f1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aquLdW0A; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4398c7083d7so76642f8f.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 03:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771932429; x=1772537229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4wckwVW0b3X1g/PGVWHQbxmb/kww/W4UTrCJT/v/yM=;
        b=aquLdW0ABgx1qBmyGtZ8RNmdOCrqEtvKdmJpPtWhb1n4uGm6XfRU6gf3Bt95Tnopr5
         QNVvfA8kyC8F/+szeJF2ovRtz4F9NGzB5UfwUHcykUA4WD29k7WfPuNmf/no7QEUWnND
         NRyhm5tYIh2KaT6cYehjbtoBNpgZoJ9tUPCjrrz/hwcm5ITx9SngdQJ4gGzZGQ/ehUQn
         6lcYtoiJOQwuH0/JcdPd4Fhxb/pHfFvdgtOdGBDgQaFVMhLBocHUBOTD0y+osecuI+TE
         PiqLZ9sYe3P4AsGydkheXoLd8Eez0GbPd6e3coeztfGPWV3Ge7sJQqBq1GXrgcylney7
         tmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932429; x=1772537229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4wckwVW0b3X1g/PGVWHQbxmb/kww/W4UTrCJT/v/yM=;
        b=qfhTfAimDyesRC3OZnje6VLDa90TIhhWp1f79ahZgj6geZlfp4w2uLuXZanonWBunP
         VA8COmy+oqx2uXQOTwt/FtX1/cfPfnmEiEYO/2F3W+jFbyyiceuDhatStUBL9ZB0Gqtx
         Ne8Sw0qpRDLC/I/gj09aYSbqF0SoV8t0svOtqKtwRZl6X+gsl4ldp+K5fpyMVpjH8qzS
         gGcZs36Hbm3/Fn4c1yljKGgdT9NOb0XrUqrLRVn8KxTZOobrAND0y+YkJemewg2sEWt0
         2hxfWB4+CG6HYC3h+1SiEa55o5GeklQmuiobDVJDOFDfwuYFg2wJLLGFOzwrcntYw5Ax
         5c2w==
X-Forwarded-Encrypted: i=1; AJvYcCWqvCiigcW4CJJavxW1S5gg8NaHnnPFwOEn3twrUCU8Va/idQgBisy6V3Q7hBB+O7j8fzOWO4ro@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdDalG6k96znTYpGB24eicsR/RX6kTusI+KrienRW/R1vvfwW
	ymqtmMygzsKmMiD7zYyrgHSW2GBYTp6hy3RcS4DqRLGmOSjnSCp8DCQVNzMLW4lCBOo=
X-Gm-Gg: ATEYQzyzI5b45J/xPuqHB8PaLh+8adocC+DyXsQ5aoU12c1PvjMm+TTfgxcVkW1Nj7z
	ZQhg568Jom8AubpUoyyaqoEgOeycHZ7YPTudYk8Sc77U2tbMLeMZIH0DBLd/YrQo8cW1wDiNNKS
	JTFhNwU01RWHRG1D9o+IXk0kmIALWKbieWZiiXTkOUuJv3u6Mx+0GsY2uScQkwCQqGl0+ODLVFN
	pGMk41sA3gyV5/v/7ueDjSwZ4HFDEt7UIREaTsaH8NDnbfDUgOQIGapRew4SOY1TT4zTP3CdNHs
	jPw1+tQkGXSBh+7yKpSv4ZsHPtAOe4SsrzvmCOY1Zs1vZMAj16K33du8E3dnsjb2zghOdbTa4Hl
	+hZVcR7alDn2sEHo+u5rFJZBsjQtwJB7TTu1AdPBW7yKSUHVV5xueZ+gRth2RaEso1JP/YrIRKK
	jBspq7H0Ih2bvK9E6vxy/fhLhpdaozzXo=
X-Received: by 2002:a05:6000:26cb:b0:439:872f:b496 with SMTP id ffacd0b85a97d-439872fb5b4mr2656294f8f.59.1771932429230;
        Tue, 24 Feb 2026 03:27:09 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm27358404f8f.32.2026.02.24.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:27:08 -0800 (PST)
Date: Tue, 24 Feb 2026 12:27:07 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Johannes Weiner <hannes@cmpxchg.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Message-ID: <aZ2LC0KPF0xsAwAL@tiehlicka>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14215-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 54CC518642F
X-Rspamd-Action: no action

On Mon 23-02-26 14:38:23, Joshua Hahn wrote:
> Memory cgroups provide an interface that allow multiple workloads on a
> host to co-exist, and establish both weak and strong memory isolation
> guarantees. For large servers and small embedded systems alike, memcgs
> provide an effective way to provide a baseline quality of service for
> protected workloads.
> 
> This works, because for the most part, all memory is equal (except for
> zram / zswap). Restricting a cgroup's memory footprint restricts how
> much it can hurt other workloads competing for memory. Likewise, setting
> memory.low or memory.min limits can provide weak and strong guarantees
> to the performance of a cgroup.
> 
> However, on systems with tiered memory (e.g. CXL / compressed memory),
> the quality of service guarantees that memcg limits enforced become less
> effective, as memcg has no awareness of the physical location of its
> charged memory. In other words, a workload that is well-behaved within
> its memcg limits may still be hurting the performance of other
> well-behaving workloads on the system by hogging more than its
> "fair share" of toptier memory.

This assumes that the active workingset size of all workloads doesn't
fit into the top tier right? Otherwise promotions would make sure to
that we have the most active memory in the top tier. Is this typical in
real life configurations?

Or do you intend to limit memory consumption on particular tier even
without an external pressure?

> Introduce tier-aware memcg limits, which scale memory.low/high to
> reflect the ratio of toptier:total memory the cgroup has access.
> 
> Take the following scenario as an example:
> On a host with 3:1 toptier:lowtier, say 150G toptier, and 50Glowtier,
> setting a cgroup's limits to:
> 	memory.min:  15G
> 	memory.low:  20G
> 	memory.high: 40G
> 	memory.max:  50G
> 
> Will be enforced at the toptier as:
> 	memory.min:          15G
> 	memory.toptier_low:  15G (20 * 150/200)
> 	memory.toptier_high: 30G (40 * 150/200)
> 	memory.max:          50G

Let's spend some more time with the interface first. You seem to be
focusing only on the top tier with this interface, right? Is this really the
right way to go long term? What makes you believe that we do not really
hit the same issue with other tiers as well? Also do we want/need to
duplicate all the limits for each/top tier? What is the reasoning for
the switch to be runtime sysctl rather than boot-time or cgroup mount
option?

I will likely have more questions but these are immediate ones after
reading the cover. Please note I haven't really looked at the
implementation yet. I really want to understand usecases and interface
first.
-- 
Michal Hocko
SUSE Labs


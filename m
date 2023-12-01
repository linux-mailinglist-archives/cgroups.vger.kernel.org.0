Return-Path: <cgroups+bounces-765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F848010BC
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAF5281B8C
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FBF4D59B;
	Fri,  1 Dec 2023 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nCVmDprT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79A2133
	for <cgroups@vger.kernel.org>; Fri,  1 Dec 2023 09:09:57 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a9be1407aso3235096d6.0
        for <cgroups@vger.kernel.org>; Fri, 01 Dec 2023 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701450597; x=1702055397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHSBlrWKXm1wAl594fX7qblvpqL30ZdbgTyCgGt+Df8=;
        b=nCVmDprTxS0ZF+WtC5Pq/FiUtgi4HPiOKYuOq2vWTzMYbvdNkl4JEHP7OtLBdPXo7T
         iilMMPXDJLV8dsPsIDuI42FKpzZ56yq1Kagf9BurUQhXV1WnXkCXp2rDqGPAZMihvSNF
         DuEAYAcKdtP0+nqyVOlQ+zYeiFmudCDUkZQd6Ohm0t0NG3OnXX+DOvKhe/Htq61GHj14
         OiJK38WTkXvCcJMhBVYRte4rN1kcvcRGnzRaEqgIwck4Vjg+OIzV2OU5pNOG2WO3vO9y
         rhl76JxPT9wpyUzVzZDN3SYnqLg3qM15F4YMGlGzatq7EwNCwfAd66z+i3pJkBdFK8sO
         eKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450597; x=1702055397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHSBlrWKXm1wAl594fX7qblvpqL30ZdbgTyCgGt+Df8=;
        b=oc7nyKSUDGffAQnz/CyiiC3STDl1j30JNV/xymiABRAFEhJnquICFvCSNOwr1Vid3r
         oedUEgdT2bQYBqib3Ou0xIuPX2iMGa0YfDdZMuQi21BFTuHN4zlWlUd2bVKu42dwgy4l
         5jn83gGYA/s1zOl8JGdTkUuk52THxJJ7W45EOgbLhAtlkRicokDBboHPJrnT9kQSbG2u
         lCgkngE4cHDz2CmP89/ELjWt4Q+NE/mMRaSc6s77aLjLpMn6NwTMzki1gBwrGc20UGYM
         utr7DBm6PaRQI1MjieDS384R5DoE+XWEpyIXmUv6dfgrbwMMH7PzLYCgKCRU3z/jp8x6
         nnOQ==
X-Gm-Message-State: AOJu0YyJ1f922yuXL3Jd/NY27Q4sdSEy0dIXpWlOEY6DSuIHK0MpFqsg
	2G4FBBt7jrHIn5PLiNSHFtT38g==
X-Google-Smtp-Source: AGHT+IHqQfbSInVj9aP1pUXmAYQeii4YG2nj7kgSlMdhi5m0/8lKOirnLYXwBxYrgyzVTwed0GPvbA==
X-Received: by 2002:a0c:e90e:0:b0:67a:fd5:24a9 with SMTP id a14-20020a0ce90e000000b0067a0fd524a9mr30266352qvo.19.1701450596905;
        Fri, 01 Dec 2023 09:09:56 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id du5-20020a05621409a500b0067aa28ac616sm255221qvb.113.2023.12.01.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:09:56 -0800 (PST)
Date: Fri, 1 Dec 2023 12:09:55 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231201170955.GA694615@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmoTa7MlD7h9FYm@tiehlicka>

On Fri, Dec 01, 2023 at 10:33:01AM +0100, Michal Hocko wrote:
> On Thu 30-11-23 11:56:42, Johannes Weiner wrote:
> [...]
> > So I wouldn't say it's merely a reclaim hint. It controls a very
> > concrete and influential factor in VM decision making. And since the
> > global swappiness is long-established ABI, I don't expect its meaning
> > to change significantly any time soon.
> 
> As I've said I am more worried about potential future changes which
> would modify existing, reduce or add more corner cases which would be
> seen as a change of behavior from the user space POV. That means that we
> would have to be really explicit about the fact that the reclaim is free
> to override the swappiness provided by user. So essentially a best
> effort interface without any actual guarantees. That surely makes it
> harder to use. Is it still useable?

But it's not free to override the setting as it pleases. I wrote a
detailed list of the current exceptions, and why the user wouldn't
have strong expectations of swappiness being respected in those
cases. Having reasonable limitations is not the same as everything
being up for grabs.

Again, the swappiness setting is ABI, and people would definitely
complain if we ignored their request in an unexpected situation and
regressed their workloads.

I'm not against documenting the exceptions and limitations. Not just
for proactive reclaim, but for swappiness in general. But I don't
think it's fair to say that there are NO rules and NO userspace
contract around this parameter (and I'm the one who wrote most of the
balancing code that implements the swappiness control).

So considering what swappiness DOES provide, and the definition and
behavior to which we're tied by ABI rules, yes I do think it's useful
to control this from the proactive reclaim context. In fact, we know
it's useful, because we've been doing it for a while in production now
- just in a hacky way, and this patch is merely making it less hacky.

> Btw. IIRC these concerns were part of the reason why memcg v2 doesn't
> have swappiness interface. If we decide to export swappiness via
> memory.reclaim interface does it mean we will do so on per-memcg level
> as well?

Well I'm the person who wrote the initial cgroup2 memory interface,
and I left it out because there was no clear usecase for why you'd
want to tweak it on a per-container basis.

But Dan did bring up a new and very concrete usecase: controlling for
write endurance. And it's not just a theoretical one, but a proven
real world application.

As far as adding a static memory.swappiness goes, I wouldn't add it
just because, but wait for a concrete usecase for that specifically. I
don't think Dan's rationale extends to it. But if a usecase comes up
and is convincing, I wouldn't be opposed to it.


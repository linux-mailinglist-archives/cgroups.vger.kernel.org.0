Return-Path: <cgroups+bounces-15492-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yETqF5Du6mn6FwAAu9opvQ
	(envelope-from <cgroups+bounces-15492-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:16:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6FB459B24
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 637E230046B6
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC841308F38;
	Fri, 24 Apr 2026 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2+UmzKi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCE16A956
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004170; cv=pass; b=nhkAz3OWJ5+foTW24uZdIvOwtTSwyhjMMru41VghIZB6wi32TZ1DrO+wF15KbemfMdIzmDOlqeESzGSOK0mM9+6E+gubxtATZrMEAGsvc4R+vAIP8r4GdE7y5JG2L2u0IR/Pm9HrYDrL5Q4T5RTtbqEBtNhIK7MIg3D52QHIsFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004170; c=relaxed/simple;
	bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBIBQ4dxD1kMk5eraFY0HcKAcQjOpGcueYRjHYiHX/4xOHZ0IYBOoYCvj8MX76MPulbOtOQKQgUAb5772vtu1T/r1lKQqoG8Q6KE5GRtQMQMJ0l4tULfGMLALEzFr1s/T+csVG8zgqWlzPsdNu72/gUc8QcWLMQzzr8NpuXidWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2+UmzKi; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so9451218a12.3
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 21:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777004167; cv=none;
        d=google.com; s=arc-20240605;
        b=keYWYXwdkG6GN5Zm8PEbqlFO+ebzV/ud79T1p5DnRAvZqkpkhjLR3UbpLg94YjuN9+
         gC4+b+vA4eo1+JmLFZUIyzMQi83XfDEJvrKsCmkz8Vni8clnKbKscsiK5X6Ss2XV00PP
         LSJlikd7v6NuhrJqaOWv4Q9AizVpacSfMhPMb+ibyz5WIgpvUGTc1g0m6qb6CNhRZLVB
         o6TgTSSPMwlcd6qOYwVE4E2djL+7m+cAxkPWDQ3C2WFK/wAF6OXn2Yy66q5MoYQfDW0f
         1Km0+DskhDhxDwZSjXyOy9yZTpEfr2YdMsyiMrLwHvheRU4Z6R6a1oifEPb7pUgdLWgE
         MvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        fh=6tpxKX10D/UqTziN2VDKpaMAhhI2vnaoV5AvPxYZO6Q=;
        b=SKxD3O+8yEP+g88y0STrPMk+KzGriXRTLanLmAXQqvHc3013puOXUhwP/Do7fxQwIr
         t5HpofB+5dlvzph5eQATPSW0elmEoCUmZkU1Bvnrq3Vbp37YUAmNJC+JRyVx2meuI9ST
         6T8Oo86nnfO4RjNxYCfsbzW8Hi6rjUHrf6UmNg8AhZYB3GUGDhieMT7zZiXqj1TNMQ8K
         Hi2pajvZACYQsDad3uFc2oRAO4/pAIaE5wSFUwDixsDU3b3CXe8nyFwjg/XE3TeYQI8y
         Y3GDyGp4K7KjopffIR5q9Oo/iTvl61LBm+Z2KO4frKLKVmLVZhvRk43SgEjhqSB/0f8+
         hedQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777004167; x=1777608967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        b=L2+UmzKioJNWV4vcQdznhpNv6iXWw4TRAlZWZLKNBsyaKBGbr0xuXS5Vk55tbhYEAn
         aZeKgu/iO6Y18b+HXWgRVm9ZC2vlW6fuJrhXL6xnR6JM+0K+rlDbbL4nyZv4JYYDZHBw
         KqCMsXg+oj573jfNyXEEvWjgFD8+vGc9bTEH5f/LiYkGJl2RnpBSPSyBNr0pob4lLxOw
         wxZzH4jXgEp8zWVVCdFarGOp4qj04NVMyEaDzGLYaEIZphQZCYCYHqrjAXTC/Hy9ZgEl
         +1CzJNMeFY3wJdVSv5fxydgbFegktRBK9pTvuwO3rgzHcon9BMncI1e8qJaqTxtsOVj9
         Lcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777004167; x=1777608967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        b=GCZMzZAZ0NLKchEBeP5+80aFs3fG0DB3fSvYrHyPoFlvjTYdzvqJIExzEth9QyCGNJ
         q9u8+fbl0x5NGKqfam2m4E5mooTOmA1J0hNghsW5TRyT42BwyX2EPitBX6Tx+ID5SIVC
         5wKlFyQjQJ3r09GVFyoK0JvE+XI8QTt8HcRcnpxUAC8KZHO//ucw6U66Q3JASfLmKMZh
         k7nsEPmLlV0fGoLt2Twill3iRAbDqVEhRdgtlbxht7gNyee8O8NzallurY499g9apmKR
         I8KymRO1b6eMTM8MGB2IDy2WEJ5Fz9Kan4Qu/YRnJb/SZHOIxxvZocxulC2v6kIic81k
         Qexw==
X-Forwarded-Encrypted: i=1; AFNElJ/I2RE0h5GrkFlvvzaIQEKGgJ4m8NIkSCBl2Uar0ZvDwwx6Xdb6rKBtWVooT50ZmYlUS1qdrGbj@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5sjaNUjrWPEndyUskrqWeYVbCv1GC/3GPVIJ16DEWzTn4o6/
	Zsy/KBfWH4BkKw22FcfCQFfaeibB4VmfVkpLWD5pi4Gqnv+ZrRuhFAUMXBDRBywGs+mnZLXVJTH
	Xk4dGp08p0Qmbl/z4FJNthoXFvUjZKEM=
X-Gm-Gg: AeBDiesPKjjM5iYaTYkbhI6FX9ltl3Xi52incE3ao5xgvMT0KVdDsqC0vLJbtjJckJB
	apk+qVyXRpSQFe+iIDbPk/mzcP1OPN9GaY3RMbfcYpbKxCDKoREIGdiOb/t/knMLSS8KlUi018c
	OhyVuTzWiCymt65jMVY1wC1WtAvwxBbvXmyq60tiMFJjtlNR2IigFaj0n6PrFAmc9VkOVXWws45
	FPoHqE2CLbvtNMlcf2Qs48kLswp1bT316n1330ho6rMAlqmX7N8XVPcr/T1FQeWcJhM8Y5MB92f
	MznQapfhnswAPYIZdERZwcMLYVCzTYOm+F7d17tqg5mOJoa6v4y7tw+JaNUa
X-Received: by 2002:a05:6402:e9c:b0:672:8f26:8a9a with SMTP id
 4fb4d7f45d1cf-672bfd980ccmr11896233a12.8.1777004167137; Thu, 23 Apr 2026
 21:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
In-Reply-To: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Apr 2026 12:15:30 +0800
X-Gm-Features: AQROBzDNkzH6IklDt1vdQEkd4AMoZMIvTXZzrHzuAO6eatZU4lRXpIb_XntAKmY
Message-ID: <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B6FB459B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15492-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > Using a swapfile does have its benefits, though. For example, the
> > virtual layer could act as an ordinary tier following YoungJun's
> > design:
> > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@=
lge.com/
>
> Hmm I didn't look too closely at this but I don't understand how
> making it a swapfile helps with tiering? If anything, I think it makes
> tiering more difficult. For tiering to work, we need an
> abstraction/redirection layer, such that we don't need to update the
> page tables (or shmem pagecache) if we demote/promote pages. That is
> exactly the use case for a virtual swap layer. The page tables point
> at a virtual swap ID and the backend could change transparently (e.g.
> for zswap writeback, or tiering).
>
> If we make the virtual layer a swapfile, how do we demote/promote
> without updating page tables?
>
> IOW, I think the whole reason we want a virtual layer is to separate
> the backends, which would facilitate tiering. If the virtual layer is
> itself a swapfile, wouldn't it become one of the tiers?

That's exactly what I hoped, virtual layer being part of the tier.
Tier could be set up per task / cgroup. So is the virtual tier.

A standalone implementation of the virtual layer is more heavy than
being a swapfile. Actually I think at this point, it is the word
"swapfile" is misleading now. We may rename it to "swap mapping" or
something. A swap mapping could be physical or virtual. Virtual
mapping can realloc from physical ones (redirect), and swapoff of
physical ones just read its data into virtual mapping's swap cache.

I think it's actually functionally very similar to Nhat's design
already from a high level, the only difference is we don't need
standalone infra for virtual parts.

For swapoff or migration you don't need to touch the page table, same
as in this series, just update the virtual swap mapping to be cached
or update the entry, it's identical to what this series is doing.


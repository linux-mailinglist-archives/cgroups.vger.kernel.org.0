Return-Path: <cgroups+bounces-15507-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNJ6NlLB62lLRAAAu9opvQ
	(envelope-from <cgroups+bounces-15507-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 21:15:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC9462BF4
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008D4300D946
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61753FA5D9;
	Fri, 24 Apr 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4+4pap+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678463FA5CC
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057952; cv=none; b=NVqG+qqZrMNbC9fsEzTdsCMb0SuiLN2jJlgzHmnLT4MeBgxiB47P56LGIAtAGyNkEki2KD0WLCbUVmBbj7usw6mZQLnsNQMD5WtK5R8vi5s5btkTc+29TwjfSyvNalMRt7/5Tl7bbhDalbkYRhNGs3hNcfKt/rR1qjiyKQU8WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057952; c=relaxed/simple;
	bh=KmheunmqoD7qmRe40GYg7//W4Bdndm96gaU0yeszTyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHgM2zJkOuOq/TIglw3BEIXei4gEkNexU2tV/mx1lT5xpqjPeAOTDGmlZwiXWFpg09ld4GBsoHLqylkcDs1UODWyRebI6naFyGWCyBSEnhHmd3nHhrzvUpMpxCVJEFSxxxxkp9CpOlkE20SLsfkSsgbL95M8lIiHRI2DZdbLIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4+4pap+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00E2C2BCB9
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777057952;
	bh=KmheunmqoD7qmRe40GYg7//W4Bdndm96gaU0yeszTyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F4+4pap+k3NIvaz6hOcr8KAuk8o0/EVvhqo4GgLnYt4BOdbudhQeKo+DhA3LVYZ0U
	 53CelfISuIniJTrTNv6cNQ5ZXr/Wp77zjcX7b5+kyn++e6zEqJGtFh3sCIg5Py/Qsi
	 u71Pg+hSzpYFk8vz8xSTB3Vf6ldBJ7g2tupkcswSnTvRQKE2FrZQxaICyR99vnSKz8
	 bQZaUnsOJo+OXUKq4PfUOMrhjGspdLlVNQQV9S1bTEAorfLN40qh8td6gnbBdFGcpj
	 D+0pICd++/uLneWVDqspEPTbB34/6nBZrQTmj1pUqtAXbTLjlunKGB9FjbcgECLZ8q
	 lQ22mh7HzmjeQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso10281681a12.3
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 12:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/RXeFGEYMfN4hWsmeGgM6zz67GJLF4DYbF8tEbuIqbyMVzCizR9A+e8qqo+vmAZaxUFBP+xRNG@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTv4BE/fazzzIN4tpEWAVcnhS5APZF676Oyln73ypzFhMLXCE
	YUQK32JhUH8vyFKeR5UwG3w5ee5+6n1H3hYZyH1KY3IST92hATpvdvc/ESzE468rLpnpeCq28z2
	somyEtV/Ey0yItyfAdCmPLxDkzImmU5o=
X-Received: by 2002:a17:907:61a5:b0:b8e:796a:fd5d with SMTP id
 a640c23a62f3a-ba41b3dee51mr1299551766b.39.1777057950683; Fri, 24 Apr 2026
 12:12:30 -0700 (PDT)
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
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
 <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com> <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
In-Reply-To: <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Apr 2026 12:12:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
X-Gm-Features: AQROBzC1SEAi52wg78oFj6rZAsnu9X4A0he_tCTRosEu2pR3Wwk9OtpK8VSGi4U
Message-ID: <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
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
X-Rspamd-Queue-Id: 7BFC9462BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15507-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

> > > > IOW, I think the whole reason we want a virtual layer is to separate
> > > > the backends, which would facilitate tiering. If the virtual layer is
> > > > itself a swapfile, wouldn't it become one of the tiers?
> > >
> > > That's exactly what I hoped, virtual layer being part of the tier.
> > > Tier could be set up per task / cgroup. So is the virtual tier.
> >
> > Just to clarify. I don't think virtual swap should be one of the
> > tiers. I think it should be the mechanism through which we implement
> > tiering (see above). I am not sure if that's what you meant.
>
> YoungJun's swap tier have been working pretty well without the virtual part:
> https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.com/

Does this do promotion/demotion of swap entries?

> > > A standalone implementation of the virtual layer is more heavy than
> > > being a swapfile. Actually I think at this point, it is the word
> > > "swapfile" is misleading now. We may rename it to "swap mapping" or
> > > something. A swap mapping could be physical or virtual. Virtual
> > > mapping can realloc from physical ones (redirect), and swapoff of
> > > physical ones just read its data into virtual mapping's swap cache.
> >
> > I don't understand this part, please clarify. In my mind, all
> > references to swap entries from outside backend code should refer to a
> > virtual swap ID, which could be pointing to physical swap or zswap or
> > something else.
>
> For example just reserve a type (e.g. type 0) as the virtual type?
> (type is really a bad naming though).
>
> The that swap file (or swap mapping) will be
>
> I was trying that based on this:
> https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d19815@tencent.com/
>
> It seems to work and the only thing we need is actually just something
> like this one in VSS:
> https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gmail.com/
>
> This part:
> + /* fall back to physical swap device */
> + if (!vswap_alloc_swap_slot(folio)) {
>
> We do a folio_realloc_swap if folio->swap have type 0.
>
> Which means, if there is no virtual device / mapping / file / space
> (I'm not sure how to name it at this point :) ), the ordinary swap
> routine is just still there untouched.
>
> If there is one, and it's being used, then, it is still the ordinary
> swap routine, just do an extra allocation (and the extra allocation
> strictly follows YoungJun's tier rule), which is same with VSS, but
> everything is reused. From a user or high level interface perspective,
> this can be designed with no difference as VSS. Just with a few
> bonuses: being per memcg / task / runtime optional, zero overhead if
> not enabled, and reusing all the infra.
>
> BTW this deferred allocation (in VSS or dynamic swap mapping, similar
> thing) is actually a bit concerning to me as well. It changes the
> common swapout routine and maybe worth reconsideration (e.g.
> activate_locked_split and mTHP stats is now ignored?), being optional
> for now also seems safer.

I am not sure if I understand you correctly. I think what you're proposing is:

- Page tables either point directly to a swap slot, or to a virtual swap entry.
- By default, page tables just point to swap slots maintaining current behavior.
- If we have multiple backends (e.g. zswap or tiering), we use virtual
swap entry instead.
- The physical swapfile has clusters and swap tables (status quo).
- Virtual swap is implemented with clusters and swap tables in a
virtual space, and each table entry points to an underlying swap slot
or zswap entry.
- If a page table has a physical swap slot, and we need to do tiering,
we basically "make it virtual" by making the swap table of the
physical swapfile point at a virtual swap entry? or another physical
swapfile? Not sure.

In this design we have swap tables in both the virtual swap space as
well as the physical swapfile, right? How does this work? Where does
the metadata/swapcache live?

I am not sure if I got it right, I am a bit confused.

>
> > I *think* what you're saying is that we should make that optional, but
> > I don't see how this would work. If a page table is pointing at a swap
> > slot in a swapfile, we cannot do tiering or zswap writeback or
> > anything dynamic without updating page tables. So even if the system
> > starts off with one swapfile, we cannot assume we won't add more and
> > set up tiering (or enable zswap) after that, right?
> >
> > I guess we'll keep the swap table in the swapfile and then we'll have
> > it point to a different backend, but I really don't like this design.
> > It's unnecessarily complicated in my opinion. Page tables will either
> > refer to a virtual swap ID or a physical swap slot.
>
> Or in another word, they are all just swap entries, and the swap layer
> handles things internally.
>
> > I think we can simply have swap tables representing the virtual swap
> > space and pointing at the backend directly, whether or not we have
> > zswap or tiering set up or not. Is the overhead really that bad?
>
> Right... I mean with two layers you will likely have >16 bytes
> overhead, and double lookup.

Why >16 bytes? Do we need anything extra other than the reverse
mapping? Also why do we need a double lookup?

> And I have been thinking about cutting
> down the memory usage to 3 bytes. And you can't make the lower /
> physical layer just a bitmap if you want a reverse mapping, and so far
> many things do require that. If we make the reverse mapping optional
> it might be more complicated than the thing we discussed.
>
> I don't think the thing I described above is that complicated reading
> all the code and solutions so far. Maybe some better abstraction can
> help?

I don't think I quite understand it yet, maybe I am the problem :)

>
> I've seen some vendors doing swap using UFFD just to cut down the
> overhead or having a highly customized backend solution for swap, so I
> was hoping the kernel part could be as minimal as possible.

Interesting.


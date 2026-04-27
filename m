Return-Path: <cgroups+bounces-15515-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CLWIoOq72kCDwEAu9opvQ
	(envelope-from <cgroups+bounces-15515-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:27:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65404788DA
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2277A30B51F7
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65F3DCD84;
	Mon, 27 Apr 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxtXtoW9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44F3E92AF
	for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314201; cv=none; b=nvLkycsjWfU5Op+49+tH2sr2e13R2K2DrL6/gJyfl1140NHK8OehCHn/4LqO32FjYD1PKIU+9AZpegWGwFyqn0acwIDYvjIpJGzxMGTdyqJkqUerqcMUy+YZmrVSByu00CIkSpXRGSR/YspRnvdiOPFJS4VhHYQjBUrmKRG3tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314201; c=relaxed/simple;
	bh=7e7Tf2MGPPvF7IQtCfLfncjsVrLZZIHywY4b/DUulQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0lvd+ZLDbjerq7LDwvRksWEYt0grVNkhBlRiiQ0oyms2CWPh8ziEB5nzzWvVGJtW8BpIJueKnpeyyMG4XVsbDIjs2E03flkkAYaJ84+8ROdffGHryFuBhKuM9hSjIpCz2cVjr47uZ1kv44zRzwmvf6CDKA5aWh2ohUwyT3DMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxtXtoW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F74C32782
	for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777314201;
	bh=7e7Tf2MGPPvF7IQtCfLfncjsVrLZZIHywY4b/DUulQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AxtXtoW91Szs1ppf6YGfwYILqEnqNth9WCmpuZQNj+WzMjxYOBk7QwDAhz5wXitVh
	 GIJWN65tEr5z7Rhs3yVwPrmHtxOk0jGUEGxOzHF7dKLLi3fyNFBH9BhQ9qhasVS8Ov
	 Yw/L3ly9WTIehMz5N26+6UUt8f1MqAwBtpOZW8XqeotLPH7v5XDxczg7HjMSvSYPnz
	 oe13yt1zt2PIamae0azrqg8NnTtIGoUVubvm+A/shtxSo5YpdQ3pnhAICf+sMObQ/2
	 WIM7KNQ1LS27df/0Co9YDsl6DAxCHX3uNRIHOgkhBmhQKbjugIW9jzLHTKzD/8qF3L
	 Wg8qXelz6C3yA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bab8ae52954so926805666b.1
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 11:23:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Ez6vbOCjOstQzsBWun07C4F9AybTalNzPDKxW+5KAV4mHaBYUbck0YkRW007e/eS/XCuWh5cf@vger.kernel.org
X-Gm-Message-State: AOJu0YyptCcnJM9+V1wQUUgL6rr7gXoM0Kp/L8CpvOHroAfz+iVsaTay
	S/VU9YTnRi0q3rjfkxHEKztQmrBOzgRW/q3zIUSLMUnE3j4PPKKNyyguSSvcAvYGaLvSfb0dVL6
	PkU8iNMWdvZ9Qrjd1sFzMPWs+KykQVZI=
X-Received: by 2002:a17:907:8b95:b0:ba8:8c8c:1c5d with SMTP id
 a640c23a62f3a-bb7fd089780mr894166b.47.1777314199304; Mon, 27 Apr 2026
 11:23:19 -0700 (PDT)
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
 <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
 <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
 <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com> <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
In-Reply-To: <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 11:23:07 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
X-Gm-Features: AVHnY4JSrF4JaGtUa9RGykJDx4LJmM53x95FeUNsFKceHbvA9vScOToLoywkb9c
Message-ID: <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E65404788DA
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
	TAGGED_FROM(0.00)[bounces-15515-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 12:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote
> > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.par=
k@lge.com/
> >
> > Does this do promotion/demotion of swap entries?
>
> Not yet, let's do things step by step.
>
> > > For example just reserve a type (e.g. type 0) as the virtual type?
> > > (type is really a bad naming though).
> > >
> > > The that swap file (or swap mapping) will be
> > >
> > > I was trying that based on this:
> > > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d=
19815@tencent.com/
> > >
> > > It seems to work and the only thing we need is actually just somethin=
g
> > > like this one in VSS:
> > > https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gma=
il.com/
> > >
> > > This part:
> > > + /* fall back to physical swap device */
> > > + if (!vswap_alloc_swap_slot(folio)) {
> > >
> > > We do a folio_realloc_swap if folio->swap have type 0.
> > >
> > > Which means, if there is no virtual device / mapping / file / space
> > > (I'm not sure how to name it at this point :) ), the ordinary swap
> > > routine is just still there untouched.
> > >
> > > If there is one, and it's being used, then, it is still the ordinary
> > > swap routine, just do an extra allocation (and the extra allocation
> > > strictly follows YoungJun's tier rule), which is same with VSS, but
> > > everything is reused. From a user or high level interface perspective=
,
> > > this can be designed with no difference as VSS. Just with a few
> > > bonuses: being per memcg / task / runtime optional, zero overhead if
> > > not enabled, and reusing all the infra.
> > >
> > > BTW this deferred allocation (in VSS or dynamic swap mapping, similar
> > > thing) is actually a bit concerning to me as well. It changes the
> > > common swapout routine and maybe worth reconsideration (e.g.
> > > activate_locked_split and mTHP stats is now ignored?), being optional
> > > for now also seems safer.
> >
> > I am not sure if I understand you correctly. I think what you're propos=
ing is:
> >
> > - Page tables either point directly to a swap slot, or to a virtual swa=
p entry.
> > - By default, page tables just point to swap slots maintaining current =
behavior.
>
> I mean, they are all swap entries, nothing special from the page table
> side. Swap subsystems handle things internally.
>
> > - If we have multiple backends (e.g. zswap or tiering), we use virtual
> > swap entry instead.
>
> Actually that can just follow the swap priority, or tier rule. Even if
> virtual mapping exists, it can be bypassed. e.g. you have a large NBD
> and don't care about either fragmentation or compression for offline
> workload cgroups, then why use a virtual layer for them which could
> double the kmem usage or spend more CPU? Setup is a different issue
> which can be discussed.
>
> > - The physical swapfile has clusters and swap tables (status quo).
> > - Virtual swap is implemented with clusters and swap tables in a
> > virtual space, and each table entry points to an underlying swap slot
> > or zswap entry.
> > - If a page table has a physical swap slot, and we need to do tiering,
> > we basically "make it virtual" by making the swap table of the
> > physical swapfile point at a virtual swap entry? or another physical
> > swapfile? Not sure.
>
> They are still ordinary swap entries, nothing special. The virtual
> space is also just a ordinary swap file (or swap mapping), which is
> easy to do:
> https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d1981=
5@tencent.com/
>
> Then its virtual_table will have a different set of swap entries. (I
> left that part undone though).
>
> > > Right... I mean with two layers you will likely have >16 bytes
> > > overhead, and double lookup.
> >
> > Why >16 bytes? Do we need anything extra other than the reverse
> > mapping? Also why do we need a double lookup?
>
> You will have to store at least the following info: memcg (2 bytes),
> shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
> bytes, since you have to address a full virtual swap space). And some
> type info is also needed. Part of them can be shrinked but still,
> scientifically, merging two layers into one is considered a kind of
> optimization.
>
> You need lookup the virtual layer, then the lower layer for many
> decision making, is was discussed before to introduce more cache bit
> or things like that and I think that is getting over complex, reminds
> me of the slot cache or HAS_CACHE thing...:
> https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyz=
VOKE14-O+Dw@mail.gmail.com/

I think that's where the disconnect is. You are considering these two
separate layers, each with its own metadata. The metadata should only
live in one place.

If we only have swap tables in the virtual swap layer (with the
metadata), backends do not have to carry the metadata. In this case,
backends should only have a reverse mapping (if needed), and some
internal data structure (e.g. bitmaps) to track usage.

This is difficult to achieve if the virtual swap layer is optional,
because then the metadata can live in different places. This is why I
think we should have a virtual swap layer that all swap entries go
through and all metadata live in (where today's swap tables would
live). Backends then only carry backend-specific data (e.g.
compression handles for zswap, slots bitmap of swapfiles, etc). In
this world I *think* the reverse mapping could end up being optional,
depending on what we need it for.


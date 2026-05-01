Return-Path: <cgroups+bounces-15577-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE4fBti19GmvDwIAu9opvQ
	(envelope-from <cgroups+bounces-15577-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 16:16:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344E4AD28C
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 174F2301A2BF
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2026 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A23C2775;
	Fri,  1 May 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUHr5zHT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BC1CEAC2
	for <cgroups@vger.kernel.org>; Fri,  1 May 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645012; cv=pass; b=m1jJYYYWt50PXqcW4c4DxzXIr9ZQ5Sh1R492LFpDxMUiKxw4z645BvNnXGXblmJJhJL/lLT8sI6P1e+uFrdhZSugoOZfyWsZqYCKYQb1x3niyHzrRxglTmJKGHyW3t7VKuNLBCTiSYuhQzYgO2kkFap1TQJ5BrUrHyNILh2Awic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645012; c=relaxed/simple;
	bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYSEnYUiOuTz0jQR/r4Ez2yMGtT7jEZCHIMTJ9q2oiBtHD8tPUGFtL7huZSpSPKptKI1kFFZhZ4f9FN0fQfO0/gne3jEiB1h/zg0nJQan9oYNq3FAWjvw23TX8OTzad3YgKqmrdD1p+5yrkr6Q0s4mkItoTv60asueOk5yf03hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUHr5zHT; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso20412765e9.0
        for <cgroups@vger.kernel.org>; Fri, 01 May 2026 07:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777645009; cv=none;
        d=google.com; s=arc-20240605;
        b=dehp7DwcpKGzm5pN8B847eAnDqoTAI9jrLj+ylpED16b/I0BfrrWAFflYQQCRC+U9r
         1qfNAFFnuJtJMUCq1LZKbEaU9sgvCAWrPv5mKYzxxfFPmPyDF7ImLngJJr1jNMAkUph9
         o0doM06Q+JL3WdVOyq3/yDKa5iEYANVIfyAkjFXq9EhHTmCMWAvZrRIuGoe/xErl+wR7
         CbJJQewHbH/eiWVrfMMPiEZ+GBtmwga1nK5bfW0/qVVYptAtFkUq9/Gpk3LcGU2xKZII
         85yh/02awYM9jDDyyq1AxbEeIE05dsFU+X2pME5HvSWsjzv5rvc095oW1oX1/mjfYfxA
         qYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        fh=PIYosV/m6bPUKg9sG+ZXu4GcnZF9Pvjw3kPq5lhqV74=;
        b=Z+PlBYiJi8gMoEZuvHM2ZFI5NNZPaht5j0WPX/EoDErf3X6+RorhEuzvJxa/S59SC5
         4m8dCDOXWU+dzT3GAm9bbNZY47GpTQRQtAUKMPacFWrmqnlgwg2jmz3tuTacicBgHOky
         Ptd+CWVsJlifdfuwePOcePzyVFKCKW5XUvrABpLkgTqedBI4y8BiBGWDfYam9L+rD0FA
         rpq9olQFbhDcanTkbs1my+qLTS9Bzx7UKywhLyHMhHqRhHA1cKd5MEsR6T4nyVJNcZph
         UpFqOpaRO6oyf08g4s+47oF7K3EeJ+rM99CUUIr55vTKXAKmJEt8N/sAyqdMdMV9Oyd3
         EFUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777645009; x=1778249809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        b=SUHr5zHTioHWahgwan9GjDdTjIpEOJfXlegsgWiG+x648RiTFOPf+YH7NwTnR/rrbV
         sjr7ZEBa3N8bY1Y1RLNK8WfdyZYnqP6THZKCnSbyIsqqFV6uUwlEOWOldHfCxjepREhJ
         OZcnMP0XYRvTCkBBdbII0NQ4lNtY8MN2KatqvkcVs8LilFnP0J3zYgGY+1JrYN571KtK
         2s64MdhdgH6eZGmAFJXTBQcojzDW9fqFGoS1IfIQAWvy5c9NJFvpJuoaz/6AA4Vnc9er
         BOWlCVv8UZFuEH7snsDNZMpn/BR835poTuN5grlb+kOk9bN7hFlRg44V4hbBKQQ3lYVA
         SiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645009; x=1778249809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        b=sEQQA4UtnIzg9VUVwJFiH83+SbPDyOhaO48BRIpMY77WiIVvntSdU7d9rTY76gCu/m
         TiAPD8DT65pRezfMocchJpB3JnhH7XEB50Ny3gnwc6OuHG9VtkYdwcAENJdB7wGq773w
         Wh3xHboslzQm/9+dshwyPbeBU3T6oP9wx/Gwup0wUMhvTM0L6vjBkAPsDufhF46IiVHm
         Z6HDuOkp24cyKWYt027zB1bejEE7S7RW8n/wyXV2kgPLq5XvMUdQVGlMsCxPAZ4fIj7j
         DH2SKBvNMztSUjRLxg3UOJbj6P5QYvv5+twQ69VLO/9+8T6VnrtwzdojSymWyQAKGiFK
         wMeg==
X-Forwarded-Encrypted: i=1; AFNElJ/bECJCreqGal/sBFPo/MKTqujJLZsrBQJMgw7RGLWwAk723osCkXiQzTLTqG27w6TSiKBiw8PY@vger.kernel.org
X-Gm-Message-State: AOJu0YzACAE0nLLy33j7fwVRdIhBgwTuXq3b5Gu/8GOiVIb0BFwPBypH
	NgQyqj5w2KGYsxU85+BZpTIrJuhRWPWqhO1rYi1z7p7IjlhDjikmaHobgHy7kNW9k5hQp6F20ph
	EKjj5Mc7Z3Duhl+5KPqjSTYo9MjKUqLg=
X-Gm-Gg: AeBDietgLeAZmmvSxmgb0X4UWcfAGyEuT3sn9apaZiWlsedLtYHsdgjL8fKLab1mBIH
	vFr8K3HKeRyFAxfm13hOBUAh0nZmoeKKkvH545kURcEmf8a5VmLHL4r6vkxDTeD/57ZdjhBSBWQ
	mpBWt8eXRG5w1DWnnv/4RKj2Y5Lf15Q+14JzAbzZXTo/PONI3SBHbb6IkKxsXfAaKjdXKvUfzeI
	FjvaReeXCNcqgMNJ7+KS6dh96+Vuo3w/RZNqQrCazTvwY59jgXvtQ0LBP4PnHeg4/+24BBBEphq
	POFpCfkKgo3FChzjlV+DZBby/fiU9lQGbJRcg9Z+tJjtd5YTWC4qrdadk6sw39+avA==
X-Received: by 2002:a05:600c:4a9f:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48a95627aa2mr9093625e9.24.1777645009250; Fri, 01 May 2026
 07:16:49 -0700 (PDT)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 1 May 2026 15:16:36 +0100
X-Gm-Features: AVHnY4JpHB4eIrG5SgzyWnvdTJaCS5EqLLry8xKYoE_XxqUlALfldRFV_NWt4b0
Message-ID: <CAKEwX=NR5dkKduTPwDHWiSMFwJ9ZmvindFvUNbPgQu690W_m+A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	Alistair Popple <apopple@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Byungchul Park <byungchul@sk.com>, 
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
X-Rspamd-Queue-Id: 7344E4AD28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15577-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,linux-foundation.org,nvidia.com,google.com,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ieee.org:url]

On Fri, Apr 24, 2026 at 8:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
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

I assume NBD =3D=3D network block device here?

If you use a NBD, I think vswap overhead is not going to be the
bottleneck here :)

And, what about reliability. Say you allocate a slot on the NBD, unmap
the page from the PTEs, then proceed to swap_writeout(). What if the
NBD device is no longer available? What if IO fails? If you already
encode the physical swap slot location in the PTEs, then it's very
expensive to correct this mistake. Whereas with vswap, you can fall
back to another device if you so choose, and all it takes is just a
simple backend change at the vswap layer.

Another issue with the current physical swapfile allocator is that
induces physical contiguity where it's absolutely not needed. I don't
know if this is the case with an NBD, but for flash device for e.g,
obviously contiguity makes thing more efficient, but it would be nice
if we can fallback to discontiguous swapout as a fallback.

I feel like NBD is an argument FOR virtualization, not against.

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

Optimization is always a worthwhile pursuit of course. But you have to
gauge it with what we can buy with a more flexbility design, which
might end up buying us more performance win down the line

In the immediate term, vswap buys you a dynamic compressed layer +
maintain the ability to write back.

Looking a bit longer term, I don't think you can do the following
without a layer of indirection here:

1. Compressed writeback.

2. Discontiguous swapouts. I think we need this as a fallback for THP
swapping (see [1] for the discussion).

3. Mixed backend swapin.

4. Optimizing swap IO - if sequential patterns matter for example, you
need the ability to delay or change backend allocation. The current
model is way too inflexible to allow for that.

5. Adding new swap backends. We want to decouple what the MM subsystem
needs (which is minimally captured in the virtual layer), with what
the backend itself wants.

Youngjun's paper is a case study for what you can buy with virtualization:

[1]: https://lore.kernel.org/all/6869b7f0-84e1-fb93-03f1-9442cdfe476b@googl=
e.com/
[2]: https://ieeexplore.ieee.org/document/8662047

>
> You need lookup the virtual layer, then the lower layer for many
> decision making, is was discussed before to introduce more cache bit
> or things like that and I think that is getting over complex, reminds
> me of the slot cache or HAS_CACHE thing...:
> https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyz=
VOKE14-O+Dw@mail.gmail.com/
>
> > I don't think I quite understand it yet, maybe I am the problem :)
>
> Haha, not at all! Blame me for the poor explanation. To be honest, the
> design is still evolving and there are definitely details that need to
> be improved. It's hard to discuss these abstractions purely in theory,
> so it's probably best just keep the works moving forward in a clean
> way, and make things simpler and better be opt-in first.


Return-Path: <cgroups+bounces-15508-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNLBH//J62nVRQAAu9opvQ
	(envelope-from <cgroups+bounces-15508-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 21:52:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095294630A3
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68683019526
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80093FADF5;
	Fri, 24 Apr 2026 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8DP27ri"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE63FAE09
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060340; cv=pass; b=mwquMDd694w1bH1Jgc980gdzbs8SmSa/yRKFv00wgj6COD/Zy73cnD2yAg63xxZnttSTS6LyvLu1PMzVizBY4CTVN+DxZKU0Ow9/OHBwoXuEpvHchESGjIraffQ9voBB6fHPVZ6tTgkyIyyCq0JwuQSdutYux5rGlW9al35tgtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060340; c=relaxed/simple;
	bh=wE/7ErAGo72joNqsxPMrNEQEyJ7t+edUI6j7ULKzBaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYUpQ7sHNDtbSrT/kXvuq2xAr84QZbfK3wvA/ACGRwQ7vZ4tKeSWiWntUpm0qedyJoWT7aZVO11AKC9lpAOGHRmZZyuk1B/4ER1Rslc4ld8qRLKXVPxZSyBk+pYyKDtpDRqdM7QjKLKObikIJzKkbveKmazcgl3Rd3DFGNvgK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8DP27ri; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so9771561a12.0
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 12:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777060327; cv=none;
        d=google.com; s=arc-20240605;
        b=Vc8Q1gXjU/lP1M7BrEdyNSAQ4/BGamBqd6bEEAwiiZ8QcdjGhYyUQWI+xa0yXKs2fX
         RrQjZA4vYN9MZbIC+02TNEc8GaYPgt+RMACS40JixexND/Si3hyWWNDlqMA3Bc1/fV/O
         qevQsplPdfThx9EFAQ6+wgqV+DzdirX7E/ki8D1T6EgSk1SULXheGcvZtPn75V9JnGc9
         1HNHJ9ViI4L4qs0E23nrARTAO7uVU/uwG8ux8xoCDPLh1hoApOerWwhI1i8dnEXI29ps
         o8UiU2iH6hh3T+1uuwFbPpCn37a7hbE9BEKMLNq3RjrWnr/hzC8m3TvF1BLJ19oJnlVw
         BN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wE/7ErAGo72joNqsxPMrNEQEyJ7t+edUI6j7ULKzBaM=;
        fh=IxghVHJ9e4fedRhJh5oIpPTQcqS40oHH5zMttWQq43Q=;
        b=OXQ8jBNcwLdpsjHcWnTi8QC0BvZ2xAjsKY+32+AbVn9Dd/gmwuDA4eUxEiMOiXFoOk
         Ikbm/pngPsxwHlVDTN2NSaeDR7Td9UCB1D2M2V6b6iUOwlb91Rw96cMZgc9pjJiWgj/r
         3sihbZdUlEmRRQiVV9+J4/dEAKp35pynMjGO/ULMJFB/Z65BM4mdKd3m/t+DH8BvS4qb
         CHV+spVojY39YPsDtDESrZay5aReFCyqXfLVrNVtqPJIkjulvoSzqhKImz63Jj9sgS5a
         WNswZyY30S8awG56dId5QyoHfky2HuGbu/CxaERgEMnhhEHYbp7aMiSoaoJ1xx8GyX9g
         S2fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060327; x=1777665127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE/7ErAGo72joNqsxPMrNEQEyJ7t+edUI6j7ULKzBaM=;
        b=P8DP27riXPbV32Oz8Ko4j9Ee73SVG6wBWOCcDL7dVsYxi/Mk2R+1ikwDZUE9wRnYXj
         MaEX31iCZztxlp3HjqViGs2/AFYQPpy3rfDnvCePd9Ty/UZ/KBd+3SxTGDpNhn6qPW0E
         ojgS7m4EhAoBjEyZ4SimQ9dLkLA13F/96EWtIkn7EKiaO5PnI4BHFt2idi4UrAvCuTlF
         f4mudn26z/DUyeXlW5WSX/ZUT30lNdU9COrB9yrgd59BWpnf63FKaLCLDHDytbr24OpW
         d89crHgsj7iMsQQ3umdTDsnKqtZWljzQU7IyrO8sXEXeQFpy3ab+LBBsRmb1eVr/4PSS
         xS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060327; x=1777665127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wE/7ErAGo72joNqsxPMrNEQEyJ7t+edUI6j7ULKzBaM=;
        b=EIyNOKGbeQ5IEDueboDcOvh+wKEELhZg7RO7k6uyjZvG/MStJfSgQpBm6HBb+BEyOJ
         YeV+PDzMO2AcCOXvG0JwCYjOiIQ4sL/ycmU2+YRXcIhI26mK1HCHdOSiz3iiMcusUFkK
         WqDYQtmJRm/C0/K6GFh5wg8YiNNM/2Vzl4plTwupywkDdfodoscwqAJMWai4+qfkq2LH
         Woj8j29V6Bc3fel3KLHa4OlK76UkpgN0sTr+dCaDMwKtipz1hWrySc47eKTfr7DGfMnI
         QFUjv3sN9K8kHUTWt4vF1c2xKLEzs6ioHLY5PzDKJt79prn5kdznOxruomW3AP5fWUXc
         OEYg==
X-Forwarded-Encrypted: i=1; AFNElJ+cGF2hELH9rbv0+gjPjbV3qz47hMt9EAdH1bRUpZGh3fyCQcz2elmBIAr19cGQ+FvMT5s8G+3A@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBaI3oIj3e/eWpoE98lvW0y/jZLcJY05QSiHiHoFFb59LIJHG
	5Gaogc1D4c28IRXzyTA8HT1+x4F64LNcO60zXaaWbZHYnJ5llqmkHuuEiQW1ggU3CuRv58IV7/k
	gv8qcSbtbEAdu0l0UikgO23wPz8VzpyE=
X-Gm-Gg: AeBDieuLeSvEFPCt0/ySph49ulmKd/DRDkzBjDhmXiLQQVGGRGAoQ7LwGzpL0p2IMGT
	guKg2keLBEqSFbERnQ5J/NZWLXzWhZu5bhn99iWoItczc3zH7z2GGES8BR5qD/KPzb/QBMmJgAc
	vJDlgB7OWcZ3DoE3A1bVVbbh2byN17evsw7nR0JuCIKLa8ylf+fsRlX5Dw5qnAf/LhMi6n/c26q
	E1IwRZN3e/ohGUflChvoOehys35/R1wMJsfF3flDfOgGJhPnIzcriW39rGjRANUOxm6VXBQ+30k
	84cRIRsRNL5U7e7FkmzsOsVNTsVl4AOlj93f0ftf7x2z1VI8Td0=
X-Received: by 2002:a05:6402:24a2:b0:670:8d90:e861 with SMTP id
 4fb4d7f45d1cf-672bfd82177mr15503860a12.6.1777060326795; Fri, 24 Apr 2026
 12:52:06 -0700 (PDT)
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
 <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com> <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
In-Reply-To: <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 03:51:29 +0800
X-Gm-Features: AQROBzCsso3pTVLRZNMTqiOUBfD8dT5yym5C4wDmzSyyd7Bc0ZTx2dDcUA3zHto
Message-ID: <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
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
X-Rspamd-Queue-Id: 095294630A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-15508-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e
> > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@=
lge.com/
>
> Does this do promotion/demotion of swap entries?

Not yet, let's do things step by step.

> > For example just reserve a type (e.g. type 0) as the virtual type?
> > (type is really a bad naming though).
> >
> > The that swap file (or swap mapping) will be
> >
> > I was trying that based on this:
> > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d19=
815@tencent.com/
> >
> > It seems to work and the only thing we need is actually just something
> > like this one in VSS:
> > https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gmail=
.com/
> >
> > This part:
> > + /* fall back to physical swap device */
> > + if (!vswap_alloc_swap_slot(folio)) {
> >
> > We do a folio_realloc_swap if folio->swap have type 0.
> >
> > Which means, if there is no virtual device / mapping / file / space
> > (I'm not sure how to name it at this point :) ), the ordinary swap
> > routine is just still there untouched.
> >
> > If there is one, and it's being used, then, it is still the ordinary
> > swap routine, just do an extra allocation (and the extra allocation
> > strictly follows YoungJun's tier rule), which is same with VSS, but
> > everything is reused. From a user or high level interface perspective,
> > this can be designed with no difference as VSS. Just with a few
> > bonuses: being per memcg / task / runtime optional, zero overhead if
> > not enabled, and reusing all the infra.
> >
> > BTW this deferred allocation (in VSS or dynamic swap mapping, similar
> > thing) is actually a bit concerning to me as well. It changes the
> > common swapout routine and maybe worth reconsideration (e.g.
> > activate_locked_split and mTHP stats is now ignored?), being optional
> > for now also seems safer.
>
> I am not sure if I understand you correctly. I think what you're proposin=
g is:
>
> - Page tables either point directly to a swap slot, or to a virtual swap =
entry.
> - By default, page tables just point to swap slots maintaining current be=
havior.

I mean, they are all swap entries, nothing special from the page table
side. Swap subsystems handle things internally.

> - If we have multiple backends (e.g. zswap or tiering), we use virtual
> swap entry instead.

Actually that can just follow the swap priority, or tier rule. Even if
virtual mapping exists, it can be bypassed. e.g. you have a large NBD
and don't care about either fragmentation or compression for offline
workload cgroups, then why use a virtual layer for them which could
double the kmem usage or spend more CPU? Setup is a different issue
which can be discussed.

> - The physical swapfile has clusters and swap tables (status quo).
> - Virtual swap is implemented with clusters and swap tables in a
> virtual space, and each table entry points to an underlying swap slot
> or zswap entry.
> - If a page table has a physical swap slot, and we need to do tiering,
> we basically "make it virtual" by making the swap table of the
> physical swapfile point at a virtual swap entry? or another physical
> swapfile? Not sure.

They are still ordinary swap entries, nothing special. The virtual
space is also just a ordinary swap file (or swap mapping), which is
easy to do:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d19815@=
tencent.com/

Then its virtual_table will have a different set of swap entries. (I
left that part undone though).

> > Right... I mean with two layers you will likely have >16 bytes
> > overhead, and double lookup.
>
> Why >16 bytes? Do we need anything extra other than the reverse
> mapping? Also why do we need a double lookup?

You will have to store at least the following info: memcg (2 bytes),
shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
bytes, since you have to address a full virtual swap space). And some
type info is also needed. Part of them can be shrinked but still,
scientifically, merging two layers into one is considered a kind of
optimization.

You need lookup the virtual layer, then the lower layer for many
decision making, is was discussed before to introduce more cache bit
or things like that and I think that is getting over complex, reminds
me of the slot cache or HAS_CACHE thing...:
https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyzVO=
KE14-O+Dw@mail.gmail.com/

> I don't think I quite understand it yet, maybe I am the problem :)

Haha, not at all! Blame me for the poor explanation. To be honest, the
design is still evolving and there are definitely details that need to
be improved. It's hard to discuss these abstractions purely in theory,
so it's probably best just keep the works moving forward in a clean
way, and make things simpler and better be opt-in first.


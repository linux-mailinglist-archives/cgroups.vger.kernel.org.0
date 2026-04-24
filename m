Return-Path: <cgroups+bounces-15503-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBIOJJyx62mRQQAAu9opvQ
	(envelope-from <cgroups+bounces-15503-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:08:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238D46247F
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03B293006938
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821A3EDABB;
	Fri, 24 Apr 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AksPa0TK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CC3EDAA9
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054098; cv=none; b=MSrmwTCRYPINNeD9aTI6du2X5yKMvLOzOCnGGVIiX6X8bQd6YqEs+GDdXCY53LPdCeHZl5uZHzDefAJbJ4yEswOiW3Ji8xcjkO/0xktCsN9tWC3GZXKhGBjzY/jxttJyd1iMaSqRrgf9lgNaCvnRACgoHtgj+CMs7Zi/vBqwhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054098; c=relaxed/simple;
	bh=55X1Ukfwu/jt9RcvEySRhlxyGt44Y5O6N4aHBq/JXP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvqd4oWkuHQ0QmnNwjV+uVPA5JVQ+t15QGv2xodyRQMD4LSs312O/TGGUtJdmR0JqVwiNfvrt3y40ssLWCDci8+NLS3fNA4yAuUsgRuyFF58zfpRvlPRY1yUkAj3u8yauP5A8MdjhwcwNnV2hJmGnCJk8/EFWGrvZ2kAnyYux2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AksPa0TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E8FC2BCB6
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054098;
	bh=55X1Ukfwu/jt9RcvEySRhlxyGt44Y5O6N4aHBq/JXP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AksPa0TK94G95mOVyxizQ6IJd/DC7Jh74PX7tJ5S9e10bVvw4lPROnSbfV7XwnIie
	 VpjKcYg08Y9LX5ZGOIzhgl7wspRdAlNTNKAbAv1dUWik9h1S3NcaYhWLYvMB7FJOI0
	 55aM/60AHenFDCAIyQLxtHJLnPVCBPJEDxWwePDlENj4E8kpvYl/jJr1jORPHPc8Gr
	 Dkgt+CeX8jwe2++pz7a4ytorIAhsEQtcjyi6f3CoQVq+KaJdqJT6jNMEObEYAcgkf+
	 ktnwfrNU+pR+AIi0sjSeriXwtlXh2HAlcBpC2SV6PAKE+h0PMMmcK/eGNqQJ69pmmY
	 10d+fap16Zfxw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1104114066b.1
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 11:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Psz01FEaufM3/V7hV+RYR2u7NY0oX/e7gNexGKmf7HV7xDsdstjo2uQa6IRz2nz6MIH6WizJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YyJI8hmaMQNFgCmDu4MgXwkuFq7XT32IZgw/EexBiSuyoTP/F2U
	VvwyRw+AAdtYyDiFx1cB3erffkiJCH1dAV0WvnBvnoqWl15R888ydQhZbgG8dj+K05d/bxZ43kg
	ryEvGJ2RgTQl4QuRZ4sfWky24MP85grM=
X-Received: by 2002:a17:907:3c8a:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-ba82ebde295mr1194657766b.23.1777054096988; Fri, 24 Apr 2026
 11:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com> <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
In-Reply-To: <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Apr 2026 11:08:05 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
X-Gm-Features: AQROBzDr9_UVPkP7ii9e54NOgh6DRtA53gr5DNXjoPLdfydsZ8BCWlPjRr_6fms
Message-ID: <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
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
X-Rspamd-Queue-Id: 9238D46247F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15503-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > Using a swapfile does have its benefits, though. For example, the
> > > virtual layer could act as an ordinary tier following YoungJun's
> > > design:
> > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.par=
k@lge.com/
> >
> > Hmm I didn't look too closely at this but I don't understand how
> > making it a swapfile helps with tiering? If anything, I think it makes
> > tiering more difficult. For tiering to work, we need an
> > abstraction/redirection layer, such that we don't need to update the
> > page tables (or shmem pagecache) if we demote/promote pages. That is
> > exactly the use case for a virtual swap layer. The page tables point
> > at a virtual swap ID and the backend could change transparently (e.g.
> > for zswap writeback, or tiering).
> >
> > If we make the virtual layer a swapfile, how do we demote/promote
> > without updating page tables?
> >
> > IOW, I think the whole reason we want a virtual layer is to separate
> > the backends, which would facilitate tiering. If the virtual layer is
> > itself a swapfile, wouldn't it become one of the tiers?
>
> That's exactly what I hoped, virtual layer being part of the tier.
> Tier could be set up per task / cgroup. So is the virtual tier.

Just to clarify. I don't think virtual swap should be one of the
tiers. I think it should be the mechanism through which we implement
tiering (see above). I am not sure if that's what you meant.

>
> A standalone implementation of the virtual layer is more heavy than
> being a swapfile. Actually I think at this point, it is the word
> "swapfile" is misleading now. We may rename it to "swap mapping" or
> something. A swap mapping could be physical or virtual. Virtual
> mapping can realloc from physical ones (redirect), and swapoff of
> physical ones just read its data into virtual mapping's swap cache.

I don't understand this part, please clarify. In my mind, all
references to swap entries from outside backend code should refer to a
virtual swap ID, which could be pointing to physical swap or zswap or
something else.

I *think* what you're saying is that we should make that optional, but
I don't see how this would work. If a page table is pointing at a swap
slot in a swapfile, we cannot do tiering or zswap writeback or
anything dynamic without updating page tables. So even if the system
starts off with one swapfile, we cannot assume we won't add more and
set up tiering (or enable zswap) after that, right?

I guess we'll keep the swap table in the swapfile and then we'll have
it point to a different backend, but I really don't like this design.
It's unnecessarily complicated in my opinion. Page tables will either
refer to a virtual swap ID or a physical swap slot.

I think we can simply have swap tables representing the virtual swap
space and pointing at the backend directly, whether or not we have
zswap or tiering set up or not. Is the overhead really that bad?


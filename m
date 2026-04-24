Return-Path: <cgroups+bounces-15506-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPTJGm+962nBQwAAu9opvQ
	(envelope-from <cgroups+bounces-15506-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:58:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC94629E8
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8823007E13
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C733F7AA4;
	Fri, 24 Apr 2026 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCo859/T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E03F788F
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057128; cv=pass; b=rpvpf8bt5VczSneiHWZm7Wzqs8rc1sujLlfK+/4OaQ1MK7XZMlDCNHevWfRoF6+tKNxmAMc1wJuh4jmrZ0S+PuXRNACDF06joD8qcp9WaV6k6wi91LYzppyrICIBM/wSvKJVRx/HSHCs7A+q8queL7TOrAh/OwHdgrvDL590SJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057128; c=relaxed/simple;
	bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVRit6ly4kqBGa0lbqsImY1LF4/C38LPIDdwfaWyIyyEvnhDsjkPqbahq71V0MNXpTll2z1jZSwVbApkl/fn4cZJY58/3K35n49F28ZjQjQn1pQq49/VGveCyu/jIG6951VG7jjVusB/ckUHiYULQH3D8E1U3VxfQwPXgkUyON4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCo859/T; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba6b39871a3so967726366b.0
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 11:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777057124; cv=none;
        d=google.com; s=arc-20240605;
        b=U4J7rafC3iMbJ1isjzg9GjGeHILlkDoi+GHha3DPsZH+MPsnXHNIbqEyn/nLyuhaCZ
         /Lc+HE8l7T0ZL2dDqC+t1DAStjk8mvCmCwC/CBAFmKFJqbJQvEIGvfk4ngqgV7uJKgz6
         Bjdzy2RtS03GiZgsxC+qJImRq/qegxXcwIq5W75/0oFUG27xJmFDdGVR1B+x5+xKvZPs
         NgMlGp13A3He1KeiZt8H9RHL/1EVmTAu1KFuNykImwX83K6Bb54sp2pYbdZWAuQ/3CPk
         571+8gzVPPm1pnm3UtS4YlBvTjSIVodPYzIZCwi8ILoSTLQ/IfgjqcbkQTbJcdrCPY54
         xkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        fh=D+BC5g1K5/MEsXnLpJZmejagJDn57hu538haOsFBLeY=;
        b=Fpi/8CukG21KN5jXi/AGytFzU+OtzHBet++jkQa2iXTG9c667FsFJxNUzKN3iyonRe
         2fQxeas4OkHxaYICMC5JOVKfUjCdC72IXMw2SMHlL4TPbppVq1bGmqROa5qCUPcm6W8f
         mM8q1YjbtGS3uT6o9/U1YgbdjA9WNgzaS+E1tTqSrCaJtYbCbzQhXhlghEt6a3nsgIyT
         RF2y2GzH0CcCtJfTZhbYS3NM1v4wEsf3nO1rv8kLfLg11nqHalupGK4vu2ErgIK0bM5x
         DVucvN6O+3hDQPCsP/MSSZKd/FVEDzOQ9ODaIhwWugVTKLV/Sb+Nlc6TheqLBbyeECKL
         8yHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057124; x=1777661924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        b=iCo859/T5ds85sLELgY5369MrC+xE6q6KwtoDJvqmpHWp5krA9ok9kra+L/VVWkTd+
         tbmonnQpA6mB9dZUUMnfTM7AzawvaMA25e7jhxrcpojIonHim5HjaTxBIW05fcHh68KL
         GWj1tr/5RvjCdpvKOr5R1ABkgCUjaKvszC0pmTvVd2UVTeVpCVdOUq5d1Je+x3S8z5sj
         Gf81N9+UzKQjdjhi9gRLm3pVm5N6SxeX3zhDVdH06uFfryy59F68weDZ9zsLrQJQr97S
         JtiWjiik1nuvJ3efIHegf4ifZUB2lpgzywohR2ymN8gVt6Vmtj46sCPSJk2/GxIinbfZ
         tP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057124; x=1777661924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        b=CUNuybMwbkLdwFZDVsoEkCZJeSV7r+mYaAkeZkFDtt1P10h669SfrQxjbSf/0msK2M
         IzEhxl93teAEgkEY1MYto82hWz4AUlyjKpyke6lVg1/xoxqdFj0VHKI8Ptn3IKsU4BoB
         gxVAEMKmAbImAt2kPiXhO5x/IlMceNvMlyzZJ2reWdtb4FGYylFDVABzL37HwUBHu+h0
         6f2xM7Wqnii7l0ojrrgIiPw7fQKHCqXqnVUIb1nPLH2/1suvAAcrOMrzSUDot0j692jG
         pvq87OA26MfKH+QjAF5S0J5LT9Poydxllifo3+bQNUITBN9Bc7VbkscvCAmPL3Cce3bP
         piBg==
X-Forwarded-Encrypted: i=1; AFNElJ+HQPO7WukeW0TSJeqlbV7zafurB7hgcu1467flhaEUHVSgRGe3q7CpPsuKLMj2+BdeXB6tSuz9@vger.kernel.org
X-Gm-Message-State: AOJu0YzVl70mZxY2NwRdzos2yxdQPy3nI/ziEiDZzKWdDMb/x3tuXgJ5
	18BFfiLAbDuXKZkc2l5rr3cl6ouJ8v7G4CU8APPWyISQsU7kB22yGOq3XgNSkTQwaGptB6USgpw
	6Pc4i+Yaxt51QpCTzWtRsZG7VhO9F1Sw=
X-Gm-Gg: AeBDietRSYrbHG7DR73KnV4sISwm9+UZGGQ/GJxlBkp0gnleh0yB03pvhY5xfZBjB0w
	6W8nTz9k/AEXT39rA0iVcQOPKd18I2QqCxN9BXCLMJ8zBS0ZA020u6mxRmID+wa4ja+iCDiPaoh
	GUdfVO1WmnYYo1rk3Lw1/+xqyiwxvkQ8PuDKflx5BRtxyDJr4lycM6vvBlgIiXZmlwFodwetc+3
	JKEzjmi8RYv9G864M2+j+WQfPESdyo9OSgJyNih7vlH7/4d5/zDg7jxfIMlOvmliAv/U7gRXPjN
	XWSKzvEv/8sSnIJ8EZ5zXNyq6t3Qh0Qss5KZBr/RL81SQVXu5Yo=
X-Received: by 2002:a17:907:7209:b0:baa:67b9:57a0 with SMTP id
 a640c23a62f3a-baa67b95a5fmr713004866b.3.1777057123475; Fri, 24 Apr 2026
 11:58:43 -0700 (PDT)
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
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com> <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
In-Reply-To: <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 02:58:06 +0800
X-Gm-Features: AQROBzAaIu04DPxOg3P-cwpIEdvMhxhii3pwiMT8HK0UdOYxD8nmrK7NsGSDAaE
Message-ID: <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
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
X-Rspamd-Queue-Id: C1DC94629E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-15506-lists,cgroups=lfdr.de];
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

On Sat, Apr 25, 2026 at 2:08=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > Using a swapfile does have its benefits, though. For example, the
> > > > virtual layer could act as an ordinary tier following YoungJun's
> > > > design:
> > > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.p=
ark@lge.com/
> > >
> > > Hmm I didn't look too closely at this but I don't understand how
> > > making it a swapfile helps with tiering? If anything, I think it make=
s
> > > tiering more difficult. For tiering to work, we need an
> > > abstraction/redirection layer, such that we don't need to update the
> > > page tables (or shmem pagecache) if we demote/promote pages. That is
> > > exactly the use case for a virtual swap layer. The page tables point
> > > at a virtual swap ID and the backend could change transparently (e.g.
> > > for zswap writeback, or tiering).
> > >
> > > If we make the virtual layer a swapfile, how do we demote/promote
> > > without updating page tables?
> > >
> > > IOW, I think the whole reason we want a virtual layer is to separate
> > > the backends, which would facilitate tiering. If the virtual layer is
> > > itself a swapfile, wouldn't it become one of the tiers?
> >
> > That's exactly what I hoped, virtual layer being part of the tier.
> > Tier could be set up per task / cgroup. So is the virtual tier.
>
> Just to clarify. I don't think virtual swap should be one of the
> tiers. I think it should be the mechanism through which we implement
> tiering (see above). I am not sure if that's what you meant.

YoungJun's swap tier have been working pretty well without the virtual part=
:
https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.=
com/

> >
> > A standalone implementation of the virtual layer is more heavy than
> > being a swapfile. Actually I think at this point, it is the word
> > "swapfile" is misleading now. We may rename it to "swap mapping" or
> > something. A swap mapping could be physical or virtual. Virtual
> > mapping can realloc from physical ones (redirect), and swapoff of
> > physical ones just read its data into virtual mapping's swap cache.
>
> I don't understand this part, please clarify. In my mind, all
> references to swap entries from outside backend code should refer to a
> virtual swap ID, which could be pointing to physical swap or zswap or
> something else.

For example just reserve a type (e.g. type 0) as the virtual type?
(type is really a bad naming though).

The that swap file (or swap mapping) will be

I was trying that based on this:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d19815@=
tencent.com/

It seems to work and the only thing we need is actually just something
like this one in VSS:
https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gmail.com=
/

This part:
+ /* fall back to physical swap device */
+ if (!vswap_alloc_swap_slot(folio)) {

We do a folio_realloc_swap if folio->swap have type 0.

Which means, if there is no virtual device / mapping / file / space
(I'm not sure how to name it at this point :) ), the ordinary swap
routine is just still there untouched.

If there is one, and it's being used, then, it is still the ordinary
swap routine, just do an extra allocation (and the extra allocation
strictly follows YoungJun's tier rule), which is same with VSS, but
everything is reused. From a user or high level interface perspective,
this can be designed with no difference as VSS. Just with a few
bonuses: being per memcg / task / runtime optional, zero overhead if
not enabled, and reusing all the infra.

BTW this deferred allocation (in VSS or dynamic swap mapping, similar
thing) is actually a bit concerning to me as well. It changes the
common swapout routine and maybe worth reconsideration (e.g.
activate_locked_split and mTHP stats is now ignored?), being optional
for now also seems safer.

> I *think* what you're saying is that we should make that optional, but
> I don't see how this would work. If a page table is pointing at a swap
> slot in a swapfile, we cannot do tiering or zswap writeback or
> anything dynamic without updating page tables. So even if the system
> starts off with one swapfile, we cannot assume we won't add more and
> set up tiering (or enable zswap) after that, right?
>
> I guess we'll keep the swap table in the swapfile and then we'll have
> it point to a different backend, but I really don't like this design.
> It's unnecessarily complicated in my opinion. Page tables will either
> refer to a virtual swap ID or a physical swap slot.

Or in another word, they are all just swap entries, and the swap layer
handles things internally.

> I think we can simply have swap tables representing the virtual swap
> space and pointing at the backend directly, whether or not we have
> zswap or tiering set up or not. Is the overhead really that bad?

Right... I mean with two layers you will likely have >16 bytes
overhead, and double lookup. And I have been thinking about cutting
down the memory usage to 3 bytes. And you can't make the lower /
physical layer just a bitmap if you want a reverse mapping, and so far
many things do require that. If we make the reverse mapping optional
it might be more complicated than the thing we discussed.

I don't think the thing I described above is that complicated reading
all the code and solutions so far. Maybe some better abstraction can
help?

I've seen some vendors doing swap using UFFD just to cut down the
overhead or having a highly customized backend solution for swap, so I
was hoping the kernel part could be as minimal as possible.


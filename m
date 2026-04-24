Return-Path: <cgroups+bounces-15501-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKhIMBWp62l9QAAAu9opvQ
	(envelope-from <cgroups+bounces-15501-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 19:32:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F0461FF2
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 832EB3026891
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3A3EC2E3;
	Fri, 24 Apr 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPy2owZ6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6737268D
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051739; cv=pass; b=ex+5yiyYkkhgmPvq+DEkFU3QEsTimMrDflUGFYVUq2jWASTAajW+PIXv8ifZpttCBEoV9K/4R6v6yRysb/zXTWLA7wAMiflkoNjAu60cRzMaLiD8788YyYeVG2VBYLE9wSA3R4u3aF2WBDs8VCXTcGLY+RGW2cmhpgVkNXs4hAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051739; c=relaxed/simple;
	bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2aPq/9/oGefbWKM9+B0Vr7in7mv9Pe7iOIfkfZY/ZOmpVxatBNk2jvMxtggEgNIuOjS/Wb3XAq463ws8/5+A79BMcUiQjK/IkFug+8ecXEViYoZKm6WnilHMhGNF7hB5BjKefhBiiCGLI6mt7+/OD+6pCnR8jopDZPvE7geRKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPy2owZ6; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so6690379f8f.2
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 10:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777051732; cv=none;
        d=google.com; s=arc-20240605;
        b=RUv2jNRgj+XbP6y1rQUBxvnQFLXarUf2cOMxo8A4AAh0EChr1eydpMkD+xwKnwjhNv
         TK9MK7lnyjeEZ/tB9vfTHdtl28aLL7kDrMzWizaSbINXKpPXRqaBAFyYcc11U/CCfsiF
         o5zzFrEnydaVnzSLcFOVdn3bMH4irZcNLOH7rKndhw4YeHq0c1iM63M5eOVD+e7Q/e+d
         rXC75PnCWQQo0wccNenpScYJ+bKYytzi/n009DiCFkXDioR0k7hq6LBoeLfOwrQ6cSv1
         ntQ8ydWwLtpFZnmVr2O2bAfmxJp6rplk3Ck0W4HZUgTCFRtEUQfPvevnQUicITpXneF+
         gK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        fh=uDGmyaM4fYqnR59k8iwjQ2LFUoOlAi7gY/101mpyB14=;
        b=b6v4tRLAOswg6IKccDSl1qHzUv8lJjwmg4r8qLxQTPZTw7eRAVE7lUGjAn9Ik0Le5O
         CbIS98IrI+2Fkx3xYmWqgcHATg8zn6uUDnKGdxfZKACRKr8uchshxNFqMtPFEtCMq7eo
         ASPXRhsjPbNkx1X63F6D7nEmytAeQQiX0ujFx7MfbkobpMWIDMKgr/RRn5f7IBQEbQmk
         /xxemCkCrtH41EOkYCfnza2QJdrStdfHl96/JLUtWsQHDlLzANzxOIcga/W5QcXU68mj
         rWwvUBFSuCCmzScZlSqxPfkzvcBnqe4y/QFaAgkDLes57bwMpFg+rsllPFmv/w2GWiBn
         ZfsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777051732; x=1777656532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        b=cPy2owZ6YtII4s7HU+IzjLj3EwJfYey6j78hics1B9AV8z2NtwxZF6WRXlZWPQi509
         oxpTfU/Oh021kKW910cbUrVZ1UYiMuTMjpF/VHk6Q3fpYBGpuFWdwgnOxjEefp3ZICjP
         m72RiE+KG1/hmCqKkRQeF1qCNQ+T3TTXN1+O1vYTSAstcl/lgNVbJ5Zj1vwXtAtHCyb9
         CV/+hfqtVHPioT6FppX7v/+6cCcSiBsJQ6E3PXhEWNmYKEGw/jx2HEwuoxfCU5dYb/jA
         9Exi0dBvcqln8yNMB8bJTz05lQ+52ELWeFcyPNnVDFD0z5u+2Q/flQcdyYahS84Kasg8
         LmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777051732; x=1777656532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        b=UUE4SzmNW9quH6GNzyITI2RrzpKRgLS4idusmt9NKsVvAijTWHqe+Drl+VZeERhkDZ
         t+HVC8RuWfcZfSm3XoaVzYzJIk4gMsapMugOcKJbxq6lYMOK/vEBOa2lkRpKe4HAfoJ1
         Z4NCS40V2NfgaLs8Tec03fETtMkV9/M7M/jnFRS0qZNmqX8hDD0YyTlGk/McaLi45Tax
         jHWn2+QYI3uey+XXMSunosbPNbnMG5gaG8agTpjYYou13CS/iWUZHeUd9lCgMRZ/jiLi
         Cav2KqpeOq4V3iICMb9WZ/9Kj28j4hhBgectkqVNB+UAy8m2dErmj4N2Z8S9Bv9BH7N+
         QunA==
X-Forwarded-Encrypted: i=1; AFNElJ8pzw6v1qJ6bQbhbWIE4tsJMO1YT806SsayiC6oah1ZCaiVp4zeO+zg/DCHZU8SP54q5H/9NBjw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0/dCE62s/zuYxNmI+p0TpRrxxGJzylh3Dfvc4kZQe7Segz+Q
	ofnbAh8SnImdYMup1yIYHMb0b8278TksZkAhqRdBgp3C5/wnbKjyZ+zIXqzwzDjbnerurEY1wUg
	S1PkcA1jkmotmQ9XADLk9g5niSRb9i98=
X-Gm-Gg: AeBDietQYuS5NTKQGlhgkCP48tORtnUMsrfivYkK508JM9uEmYYnXzGLXdJuCxOtjCI
	4HfqbgwCAoGkEWMTpUtYxgVZM6FG8RpkHtip6O7wtT3JhcDp298Jf6AXy7sVLJbRnfuqamPzsNO
	ouwUfoVj8dMkHo2bzh3iXRfdV23lRsnz4foBWWGJVzbXVie21lhmBbVK6f+082Wpn372+rv+ht0
	4tD77qQ612iVI1irrrAHhnEbnUU+L+p+A5gqm3iVbbb0QPzuJEGPSwwAGzzGx4KOlANcvohMB8F
	kKgNIgK0TIFPO5Y6ePwFcxAUhHSR1g0d7L/rjwEuFn3YJnx7KSMHOXL3HRHHaP8M/Q==
X-Received: by 2002:a5d:5f96:0:b0:43d:7d24:b4ff with SMTP id
 ffacd0b85a97d-43fe3e0ae9dmr49334811f8f.40.1777051731295; Fri, 24 Apr 2026
 10:28:51 -0700 (PDT)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 24 Apr 2026 10:28:39 -0700
X-Gm-Features: AQROBzCRP5S3HopOvqFdpMFjj9C-mi3ioQAh-7_Tr6thiAF3WyHAmOj6A97QdRo
Message-ID: <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
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
X-Rspamd-Queue-Id: 7A4F0461FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15501-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,linux-foundation.org,nvidia.com,google.com,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:

My apologies for delayed response - I'm cleaning things up, and
fighting with some memsw issue. I changed the semantic of the
memory.swap counter a bit, but that makes it diverge operationally
from memsw. Need to be careful not double charging or double
uncharging here.

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
>
> A standalone implementation of the virtual layer is more heavy than
> being a swapfile. Actually I think at this point, it is the word
> "swapfile" is misleading now. We may rename it to "swap mapping" or
> something. A swap mapping could be physical or virtual. Virtual
> mapping can realloc from physical ones (redirect), and swapoff of
> physical ones just read its data into virtual mapping's swap cache.
>
> I think it's actually functionally very similar to Nhat's design
> already from a high level, the only difference is we don't need
> standalone infra for virtual parts.

Well yeah, great minds think alike ;)

As you have noticed, I have also converged towards a lot of your
metadata design and operational arrangement.

Case in point is the delaying of cgroup check merging with swap
freeing - I did not notice that patch you had in your series, but I
realized I had to do it as well after studying the regression for
awhile.

(I did think about proposing that outside of the vswap series, but I
was thinking it would not be a problem at all with the current code.
But in hindsight, since you're also merging swap cgroup with swap
table, it will have a similar implications, albeit less expensive due
to no xarray indirection).

Hopefully we can iron out the rest of the differences. I have a couple
more use cases in mind (compressed writeback from zswap, discontiguous
fallback for swapout, etc.), but without virtualization they seem like
a deadend :(

And Gregory's cram stuff too - I think it's not undoable without
vswap, but it's just a lot hairier :(

>
> For swapoff or migration you don't need to touch the page table, same
> as in this series, just update the virtual swap mapping to be cached
> or update the entry, it's identical to what this series is doing.

Yeah the swapoff is no big deal.


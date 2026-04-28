Return-Path: <cgroups+bounces-15547-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEcrNgdJ8WnAfgEAu9opvQ
	(envelope-from <cgroups+bounces-15547-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 01:55:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919948D9D9
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A8D30455E7
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 23:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A138F259;
	Tue, 28 Apr 2026 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugdfpoNq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887826E142
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420445; cv=none; b=bh9WpBaLVh3VNa3pqT0h63u6xwP7YZQbOx/Htjrtu2lrveiN66BLYqXNoVkYAJWYO2DZo7Lja8ZVFuOLpQftHh578pQKsr/mrFsL47pG34R3e3GagpXS+iMzHKKUQD+aroQ/shPD6yTO6hCBNCV1jzGwhCX/vrJcTCF1VGhxAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420445; c=relaxed/simple;
	bh=37JhNmJzLxzap3D9TGVaMRWJYU2uCyuE/O0k9zslYYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZUyKoAaQtF0zcRd4Jv5dS27R+7WvJKSbc/2Cg/JWA4K+WRznDBeIpWsQwXzBKFs+w9LGC18bLobu/txe/qGYIFEYGSg+HYArEJQ8I348Wi8gBB4wIbDFLDmECuYc6LuqagJ05IXEZQFqleIRu/AxbMfV0C0gLuKOXUTjH8ktPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugdfpoNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672D3C2BCF6
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777420445;
	bh=37JhNmJzLxzap3D9TGVaMRWJYU2uCyuE/O0k9zslYYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ugdfpoNqOxbSflGH83HEj52AT2Fep+UNVIsD4PhSmXBQTbP3M/4uB6Go72MTQGv4h
	 j70Qn+P4YNeYQG/6+5HL8LpruMB6KwXegfRwRIf4d85rcmEHkPSy0EQRaKxjIRVszM
	 /r7Dkl+6AwjKsRvVUtb+hrTkzuGjH7hV8s9hOsiXt6Orrx17jyd9vA4f/WIqX4haCQ
	 81eC41EaeLSKBvDi/lfU8Tm+/ktz8b5eEq0amXD1f00vSgY7gRMO8JIlx1iThxcgFG
	 fUm8GM8l27nvmoYyFqxs9ZxN2qQvRj26t6IDlEFzFCYcmKCxRDosH3UWv8LR3pmtlo
	 ner8WLqIuIOVA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba6b39871a3so61957666b.0
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 16:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/9sEW5UrFAAjgwhL+RiiOoU4HgBwIpep6lsoEiBFwuruoGupUap7qkqEyr5XOwVA+9Eehl0sMd@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyoKK9G112pqd7VGDUSqY1ej3cMhTIsqH6wT6JUW+e575Z/oe
	1pXulIowFfnv+OKm+Rx+O2AN3PEJ3jfZFHyw3yWxQ7Lcb77uqQNtaGzPUrFxBg1Mgrq5of4rAiL
	TXA4cxXqHgXFO0P6QjWFz8n5IxhOKx9I=
X-Received: by 2002:a17:906:d54f:b0:bac:6585:b02b with SMTP id
 a640c23a62f3a-bb957dc60abmr42485366b.9.1777420443800; Tue, 28 Apr 2026
 16:54:03 -0700 (PDT)
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
 <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
 <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
 <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com> <CAMgjq7BZpU5K1xHyFiqpsjeFe6CZUouGY_gOGMwbkM2Duq-vGg@mail.gmail.com>
In-Reply-To: <CAMgjq7BZpU5K1xHyFiqpsjeFe6CZUouGY_gOGMwbkM2Duq-vGg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 28 Apr 2026 16:53:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPtPjzzrYh+SQXtuz4AMPU2p4UsUpJiH+zzfgtbJk_3Og@mail.gmail.com>
X-Gm-Features: AVHnY4J58WjJG7OMVYnI-DgVQj_F4MJqBKFiql4nFlYgXLXGGwlZGWPk6tWBkMc
Message-ID: <CAO9r8zPtPjzzrYh+SQXtuz4AMPU2p4UsUpJiH+zzfgtbJk_3Og@mail.gmail.com>
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
X-Rspamd-Queue-Id: 7919948D9D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-15547-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 11:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Tue, Apr 28, 2026 at 2:23=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Fri, Apr 24, 2026 at 12:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org=
> wrote
> > > > Why >16 bytes? Do we need anything extra other than the reverse
> > > > mapping? Also why do we need a double lookup?
> > >
> > > You will have to store at least the following info: memcg (2 bytes),
> > > shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
> > > bytes, since you have to address a full virtual swap space). And some
> > > type info is also needed. Part of them can be shrinked but still,
> > > scientifically, merging two layers into one is considered a kind of
> > > optimization.
> > >
> > > You need lookup the virtual layer, then the lower layer for many
> > > decision making, is was discussed before to introduce more cache bit
> > > or things like that and I think that is getting over complex, reminds
> > > me of the slot cache or HAS_CACHE thing...:
> > > https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8=
fcyzVOKE14-O+Dw@mail.gmail.com/
> >
> > I think that's where the disconnect is. You are considering these two
> > separate layers, each with its own metadata. The metadata should only
> > live in one place.
> >
> > If we only have swap tables in the virtual swap layer (with the
> > metadata), backends do not have to carry the metadata. In this case,
> > backends should only have a reverse mapping (if needed), and some
> > internal data structure (e.g. bitmaps) to track usage.
>
> Ah, you are right. This is currently an intermediate state, that
> problem might be gone if we unified everything.
>
> > This is difficult to achieve if the virtual swap layer is optional,
> > because then the metadata can live in different places. This is why I
>
> But that's not difficult to achieve at all with an optional layer, and
> actually will be achieved naturally without any design change with the
> RFC I posted. Swap count / cgroup / shadow all stay in the top layer,
> lower layer is "reverse map" only (the undone part though, it will
> require to move the cluster cache from global to device level, which
> is also required for YoungJun's tier or any functional tiering to
> work, we may run into more and more detail issue like this).

But then you have to deal with the swap entries in the page tables
potentially being virtual swap entries or physical swap slots, and
IIUC in your design, those physica swap slots could end up actually
having a redirection to another swap entry like virtual ones (e.g. if
we start with one tier then add another tier at runtime). Right?

>
> Might even be easier that way, it's pretty close to the unified states I =
think.
>


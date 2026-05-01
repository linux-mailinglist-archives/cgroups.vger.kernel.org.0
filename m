Return-Path: <cgroups+bounces-15576-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPO4M8+t9GlJDgIAu9opvQ
	(envelope-from <cgroups+bounces-15576-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 15:42:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA04ACD4E
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAC623009CEE
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2026 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CD3B388D;
	Fri,  1 May 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQkkL8Sz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316B3B38A1
	for <cgroups@vger.kernel.org>; Fri,  1 May 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642954; cv=pass; b=H4FsD5wqtnem4g4ImZoL/oKqk+uVSLTiQc2Re3dk53tQV2PjOWkJLFT9SGKjWS823cC00XQKdwZDePETUVvnit9mHLW8SK5q6NdQNMGgPBToBRhgRr5t1cJwkGzFyn6D1AwvbWHEyKESPMCZSdJRyFtEnK+R3J/vXAiP7Itms/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642954; c=relaxed/simple;
	bh=PSwDs4IODrQC7D3GuTnZravigu9zrkmXFt0co3vc4fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8NeHpgmThacrhe7MmipathUVfvDeCQr7K8a0JgHW6oTJ33iketxWGOdpPIQE94PfC31wzGGafIwz8pIaaP0J4QpEORun4EtbZ3llcTMrdpH1bwZcIBHwjca/Y68FLRhw1ubWh92naHElJhH7MlhdtWTu32uFI6xP8dMfhtZi34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQkkL8Sz; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so22548615e9.3
        for <cgroups@vger.kernel.org>; Fri, 01 May 2026 06:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642950; cv=none;
        d=google.com; s=arc-20240605;
        b=U02ZFYM2DNbt8O2UITFYrCa6DBPsgyCHzuB5/wnDWiiqCTSX8EPQOh0ouZak3VLERR
         wikHL8czheMj7z7d2Jg1rn3lPqR1gE5JuYJO5tZ1qGIA16VlNNu/cpIVYH6WQKZ+rhdS
         QY4Dldxt2Nbq+p0v3vf5XIgGGCYaah4MApMScQmlvughSMAtUd3MVF80iJwq2kmJOaXg
         QvJZSakDA4q3zXHmw2XjRauzV+eX30avhMtX/LNMYsJf06P+BUwXoA/glMrBok4NNNv4
         8KWFteRiJ4C9md7k4YW106sWpXaxYN7whmAyZkaxN3TkuqzB7/pqyUaaxPgGBTm/+VEf
         oJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PSwDs4IODrQC7D3GuTnZravigu9zrkmXFt0co3vc4fo=;
        fh=KXO0bOyhmJSSNFOUc2AlJbgfzmnXyO/h7O0zdxLTD/4=;
        b=Zmd7jZwnSCKFagyWFtFvMmX2C15oUCU8qWuPcTQQQR+/5GfWLv53QImtaH/CuBmH5b
         2s0XJHxkSvCqQ/iUTqFrDEDoB1+n3+oglT1JWxOImY/Wob+Tu2sRAYbNC5ndANLsn/Dz
         3dgcYgeOzjzXeEsa0H/827Om6jSq4hKaT/E1MmKIszRQeL6Z7dcit87tp5CjfqDoJMPD
         zWHk0hjCgAgDoncC4QBAHQKdjItqjRHcaf4ub5ITeLPN5y4ZuhzLr3UkVurr4NN+mkfT
         jA82iuDBi3NEtQbncDslFLr5Vs6oO+QvC6GvMPj12IuL5zDnyMpoB/fDN6VUhXzxOk1p
         hyiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777642950; x=1778247750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSwDs4IODrQC7D3GuTnZravigu9zrkmXFt0co3vc4fo=;
        b=mQkkL8Szauzxoexgx5ZwnfhukBU+NJR0nUJtrcYhQQKsGpmRMxzppL2qtvQu+yoUEx
         dJ70u88jps0Zm/abP+ldfYKoXxGO7Xh15Ot2q1u3zUfnZTQqnkQ71xwJ2zUTMMMqoqkG
         S5Fw5+ozkBsz/GpKPYf0/BrBSrBsaQn/gTMJMamUF1bImIfChhuP8eAkQG+F39Pzww6q
         opyvrnQ2LOWLpmtUh7DSCnL2AAVSldEBQs1IUiWYRLooAfv6mN5CB+FP0RJWn0OAlqaz
         6LwQG2p00HsWTd0y8WbIVVsLENUsROEK2sMExyQC08kggxFADSBUV0m+zLBaLWRzEawe
         d02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777642950; x=1778247750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PSwDs4IODrQC7D3GuTnZravigu9zrkmXFt0co3vc4fo=;
        b=Kbe7AIlOSu/7HX1TGOYdmk6kPyZ9SeOc44w8gV7zV0BYob6zomAYslfXJJq4yQvj8D
         PX9q/IJfPr5k1zIlOdNR5XE94BPCRXaiUaaMl5l9dZR29Xkl/9uR/RR7l3BRaZYWtklh
         gvQAojBzsIkqrKGBKRcrYL2IWCxm2PEGmBSOI1C/E/D24CVjYVpHZ5VZQkEHWU1JyL4Z
         7ZRfmqS88qZEMTuX2sckBNbXOO8JtXbKp6UDaBm4Yt+zPvS1sVgRNfPUmJiSls+Tz4RK
         3bW2MieE47WZjeGUbXIrkyqf7297/uyymqoD4NCdoixmogqN8zEoLJazA3Ts/VD9bSu7
         LyVw==
X-Forwarded-Encrypted: i=1; AFNElJ/PNge2+bTeVLZQKiDYkbHMNeOUL4GprYRvz7EGX5X37g68xdGoUb4BGT4iNkIE5CCGLmH1honS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLdnclRTZRZ5tVrJDflNlbFQxDgo6VqJAbTy80qlSpSVzX9zv
	E54ThT3P8JUPH7eCqgYhkB1gn/J5VMhZzxjkysTjVL2Mv6yEN+SI5+oKCRraCS4QDX+cbzZkPa+
	Czc2eoabJoUHL4oq5J3t1B25aFcVb7NY=
X-Gm-Gg: AeBDieviKiKFOOk3PSNKhlc/KsxZtPrGtZ4/Ao5UftUJBegsfcYBRdJE9h2EuLdbabi
	wrC46yclIxoXki0N/tazP97pRenCW7O0z3zx0ZodCDiUDSFNsI8Dyx4YZNGBI0m0md0CadQAFMO
	9JuT4jwM2co1AnpaZ7U1shZQc11YuaaHmTb7dZe0bTtcVtbz46l48tiIouDL8DjazZdtW9/6vSq
	ku4c+t4IHTBhxRzBzGyVf04shm0RpQ7VhqVb9i4ME7JCPv3FFqKlAknyOgR4Leg+q9FyGGw3CQ8
	KvjZCCHKABZdkkVBYXFBvRIdMzwxS4pH4mxnVG54O0yoAEpNVmxUbrUx8iGMKXhVYg==
X-Received: by 2002:a05:600c:470b:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48a8eba3a20mr47321765e9.26.1777642950197; Fri, 01 May 2026
 06:42:30 -0700 (PDT)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 1 May 2026 14:42:17 +0100
X-Gm-Features: AVHnY4IotFE7AB5jv9yFrevYlVwuS810ESNP8MQdhCBVqE2Ni9WDWtp9VtEH_ac
Message-ID: <CAKEwX=Mg8AWVoiKZixokg4NCOn2-aamtRAaNO4_GGU_h+mbpkQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 73DA04ACD4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15576-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 7:46=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
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

What do you mean here?

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
>
> Might even be easier that way, it's pretty close to the unified states I =
think.

I feel like you're moving towards the other direction, no? Seems like
you are unifying swap metadata, which is good (vswap will also want to
do this), but the problem is, the lower layer will have to allocate
memory for these metadata too...

Say vswap is optional and runtime enabled. How do you structure a
physical swap device's metadata? Some of the slots might be directly
mapped to PTEs, some might back vswap slots. These two cases require a
two completely different set of metadata: the former needs reference
count, swap cache, swap cgroup etc., whereas the latter only needs
reverse mapping...

I don't think we should mix vswap and non vswap slots in the same
type/address space.


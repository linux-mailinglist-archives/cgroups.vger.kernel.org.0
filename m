Return-Path: <cgroups+bounces-17053-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jt/oC8jeMmp86QUAu9opvQ
	(envelope-from <cgroups+bounces-17053-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 19:52:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 256EC69BCFD
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 19:52:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lD4AVVjk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17053-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17053-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C354D303255B
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87C376BC5;
	Wed, 17 Jun 2026 17:51:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E83769EB
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 17:51:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718665; cv=pass; b=iKQGIiV4DSYru7ryUa7zfdO7JjPUe/371oeVlcSsRUXroChhpwf8k10DLVS3fSWIa+JEVJExUlyFU/3pqUwc56VDJ5qmQHPTPtiDEyYtAd7x0bAhcnrDgZg13xSecFY9KSklvdtde4C6O8cvRawYNGCLBlXsw1SHXzs/Z9p1U6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718665; c=relaxed/simple;
	bh=jOM/jJ2iXUgt4DqJKgXMwQblQKeV1NUFBIcrNTs4F4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elm7h5XQfIcZI3gujrvCMGzEyi7ZtEXtF0PNoAbDDSpdg4k+9jOysPGlB6Wyu9+j+iFC8vm5Vuyu/CBQYuvF8aagDmiI00pg8Uy0LfWb+ay4xgj0YurglAj5ntnv8/67f//W/BoB2J5PE3nYuZj7lB2jTB69H0naJTwC7dypCSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD4AVVjk; arc=pass smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46066e640easo62475f8f.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 10:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781718663; cv=none;
        d=google.com; s=arc-20240605;
        b=U0SpHpnM6Kg51P8RbWRwvl7K4LLgtf6YVKt9WWC/aMPa2YjIa88d+zpALkDogPWrRm
         4vVkmDiYQzeuMg3Kml2JS5Ay4MuQIcTCYKgr0fLpZw4VlZNVGCoN+nLDCT13+gl4AYFG
         SNA4IBsEHUVVmHdo9v9odSKg3twiwm1UEO6B75KdHACr0aWwYIXzJFmUYI7ccedFtbay
         tah2EWApe3/STDqU7xgiyD/SWeid/Sf58yz1icVdFc7oy368yCOfLiG8y8QVCEEcUE5V
         anHxtTMkB+EGsicV2bFYLusyCxpG/BHruzZ1PIKTZrzV/BZ5S/WEY11CgbL1J3OX0PcS
         Lmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5M46FUNO5/BKeHWB2nQReT0UM4b5206qQCZ+wsNihY=;
        fh=KffNOJWyNxlmec+oEQnzyDq+6KZyRccnY4CW6JDMVMs=;
        b=USK+Nr6/m25dOCWkm928wzLBN7p6Wi4mUnykzRD2BGsPl5bus56AZbtEzx6fK11HeA
         DvLRHdIN87TVndKnc+sG3eM3aRb3NmbwT+JEEBm5ssS1FrDo77tNWaZxo9BUbPzld5x0
         AQxpb+/ZtsFIfZr7U/81dovbqIbeN1MA5h7ndzdi2Pez5OVUJkyEjl0pv7DLl3Re0fSA
         o3S5SUXxIczmyR9M2euIliQxp5YEjI9WaZ4r+cwdSioP6nt2VcEp88IavtkOlfMhRi82
         uSoQ9EUvjpvuUhoxpTh9e93AaeQCt6aAlaMVtcuQoXaa8bfDse48rKhMnYYfpTmpmH85
         gRmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781718663; x=1782323463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5M46FUNO5/BKeHWB2nQReT0UM4b5206qQCZ+wsNihY=;
        b=lD4AVVjkUtdvt34W5FRfhFV4+4XNHTENZDMHgH3z0JU5pEfPIL+aG+w7mc5sRX9rVQ
         3UkOdR2ML9rFiEVtXAYpMdnImFv18zhk6o8vZ9QjONRiENUK/WWDRjzOlMqn1PI8AzHI
         ZdDy2Kloyj3JQYyODwlU37OkW7IxI1lPaEZDHZe9WzwACFUgxlSIIwCVQMFmFv/GRsNC
         j1dQRKECqZOownOIvuas+4/LkcRr/EwwbvhcFHX1hlg/338v5sIOvI3MtJT0vkDy/yUS
         GjLGz88oSEx127OI7nD03imDDwbPsyC/NbPVeZ3hlgNc4ghfl1UpCUOTipGKmqlLl3el
         C68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718663; x=1782323463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5M46FUNO5/BKeHWB2nQReT0UM4b5206qQCZ+wsNihY=;
        b=H8n249/ccNjK8w88b0Z+ZDeWakaLq6fKtIKyCBJN96PKNjMwxWTAGDrn9LMcpaoDMH
         +gIzTb8bNkx0VyMmSlOVjNMShMQWlAOP9LHpubtr+t4jZhOr5ANdTBYcSTACY/Tkeifm
         tzOgvXgIbqN4lhAleVHvU6D35lftzWReKt26OZxIuEUQywBxicCrJciYOIKsww/zhRvM
         GanYckv76M0kG2FSeF4hMJO9+8lt49GzgCVBlTnVaMuwzOHoFFx+ICLe7EpAtfZdsvnx
         Jgfz3jrRC4Yfzr/jn+RyoAeGDAVMLUrcZ2Wz46x6B/BhUtM/De1npp04JiFN+vwaXs6K
         zEKw==
X-Forwarded-Encrypted: i=1; AFNElJ/1BTmG1sGBd2fuz3dqVO+mtXuZVxWYxd3zMNYEFs28WPk+KQv+QU6IsSNNtdKIBcbM+Ev2FpPO@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvz4/lodkfIzdngbYnd8RdPKaBzTaCmajM1FCdrL7SLxlvxtX
	nD9+Wg99VjlRwi83gY9Lp9aPzSbHSXUtMqJsF6fOYv6aSpmmnfZYUCnw/mL2KdoTziL/+npgLaA
	BltwumwRtmwoYDmukJyYIkMO5dXkGpm4=
X-Gm-Gg: AfdE7claRV6wXODLptAuPtQdLL9b0dess/YRa7CSwoQm0N+7sa4oVNvNfKTczao5/Zq
	34kuh/5nusk8MvCQisBZlvRL88ADIZ2zszfbicaf+jby7/tqNxzYv0q+FffHYcDbcD0eRbgKWWG
	MjuQFgtwrBgUD4HV4wbitHeMVaR5AfQFwi9bes+s1Fmk+w/JBem2tIOov3NQcqYttzgvrRXfokL
	mU/RP5Z+nMnaf/jLUpWyEsQwI0c5XMY/5ZwDSfs18WRXYsgLOwJYyGhL3oMT3cJ0PfNj6kO/Rnj
	zVM9VMMgUUT5JPcC+wJEDZjyb3V1bSV5atp620nFsQ==
X-Received: by 2002:a5d:6f03:0:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-46235e9ac2bmr8193407f8f.4.1781718662538; Wed, 17 Jun 2026
 10:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617053447.2831896-1-youngjun.park@lge.com>
In-Reply-To: <20260617053447.2831896-1-youngjun.park@lge.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jun 2026 13:50:49 -0400
X-Gm-Features: AVVi8CdnA42VDDU-EPXTa97wiw6DuLQNhC24odjJipl6r3Yjtt7VVim8JDQ6fKY
Message-ID: <CAKEwX=NfSy0XiD_UMsDOHGCwpE7sYmBmhV4Y9vk_cbnnr6J6PQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, yosry@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17053-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 256EC69BCFD

On Wed, Jun 17, 2026 at 1:34=E2=80=AFAM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> This is the v8 series of the swap tier patchset.
>
> Great thanks to Shakeel Butt and Yosry for the reviews and discussions [1=
].
> The main change in this version is the interface change to use
> memory.swap.tiers.max with '0' (disable) and 'max' (enable) values.
> This mechanism was suggested by Shakeel and Yosry

I like this interface too :)

>
> This change allows for future extensions to control swap
> between tiers and aligns better with existing memcg interfaces.
> Even with this memcg interface change, only patch #3 needed updates.
> Internally, patch #3 still uses the existing mask processing method
> (which is implementation-efficient), so only the user-facing interface
> was modified.
>
> We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel for =
their
> valuable feedback.
>
> Here is a brief summary of our tentative conclusions. Please correct me
> if anything is misrepresented (details in references):
>
> * Zswap tiering [2]:
>   Tiering applies only to the vswap + zswap combo. Zswap itself will
>   not be tiered, as the current architecture requires a physical device
>   for zswap allocation.

I think Yosry wants zswap as a tier, right?

Just that without vswap, maybe don't allow it to be an tier of itself?

> * Vswap tiering [3]:
>   Vswap should be handled transparently to the user. Vswap itself will
>   not be tiered. But, someday supported if there is strong and real useca=
se.
> * Relationship with zswap.writeback [4]:
>   If zswap tiering is introduced, it could replace the zswap-only tier.
>   However, since zswap cannot be tiered independently, it is still
>   needed for non-vswap cases. Separately, the internal logic could
>   potentially be integrated into the tiering logic.
> * Tier demotion [5]:
>   A separate interface like memory.swap.tiers.demotion might be needed.
>   For now, we only support 0/max to enable/disable tiers. In the future,
>   we could introduce an "auto" mode to automatically scale the limit
>   based on swapfile size and memory.swap.max, similar to the direction
>   memory tiering is heading in.
>
> I plan to apply the swap tier infrastructure and the first use case
> (cgroup-based swap control) first, and continue following up on the
> discussions above.
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Swap Tiers group swap devices into performance classes (e.g. NVMe,
> HDD, Network) and allow per-memcg selection of which tiers to use.
> This mechanism was suggested by Chris Li.
>
>
> #2: Inter-tier promotion and demotion:
>   Promotion and demotion apply between tiers, not within a single
>   tier. The current interface defines only tier assignment; it does
>   not yet define when or how pages move between tiers. Two triggering
>   models are possible:
>
>   (a) User-triggered: userspace explicitly initiates migration between
>       tiers (e.g. via a new interface or existing move_pages semantics).
>   (b) Kernel-triggered: the kernel moves pages between tiers at
>       appropriate points such as reclaim or refault.

We'll likely need some kernel-triggered mechanism, or we'd have LRU inversi=
on :)

Cold pages will fill up fast tiers first, and more recent/warm pages
will land on slow tiers...

We'll also need to enforce isolation/fairness to make sure no wordload
hoard the fast tiers too (but that probably requires demotion
support).

>
> #3: Per-VMA, per-process swap and BPF:
>   Not just for memcg based swap, possible to extend Per-VMA or per-proces=
s
>   swap. Or we can use it as BPF program.
>
> #4: Zswap and vswap tiering:
>   Tiering applies to the vswap + zswap combination.
>
> #5: Vswap on/off control:
>   Currently not supported. If a strong use case arises where vswap needs
>   to be controlled by memcg, the tier interface could be used for it.

+1.

Also, per-si/per-tier per-CPU allocation caching? :) Kairui already
has a patch for it, IIUC, but if not it's pretty critical I'd say.

BTW, can we add some selftests, to make sure the new interface works
as expected, and to have example programs for new users to model their
scripts after? :)


Return-Path: <cgroups+bounces-9770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C57B46D18
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6484D17B9D0
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4C2ED848;
	Sat,  6 Sep 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgAXVKHZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774472EB85A
	for <cgroups@vger.kernel.org>; Sat,  6 Sep 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163419; cv=none; b=u0P+8QtaiKxo1VPINXZb29JvbyY23ghUrLZIEss+ciwRVIcUcroHykfUocpuCUQZxvwHbfP5w0L9iARzSlSC38B/JNaj0Z9bE3Lzk3LplMCpPzS7gZm5nEJBCRm7wnnBhlCF2dd52skAgONC4wXI2116iothSkM+02vSu/6Ckgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163419; c=relaxed/simple;
	bh=2+CbUHoB1zKzsjwROR9vhcpkdWtjxfGZ7lHc4QKUz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkApFlOvcTcw0Z2jQpmSrm0pwk9kYTFPz9w0r/xWWAbH53sn8MCMDYcusaDGWp5TBlGHU9OhB27WEztfa1g609NTNhp00OCaoEIwCGPmuVYX6YJo+h4BIRUbpqbXCAkllRJiPHQcYhgS5bsMZDA4Vi4DWAokzEZL1GBFVpb9zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgAXVKHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066C7C116D0
	for <cgroups@vger.kernel.org>; Sat,  6 Sep 2025 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757163419;
	bh=2+CbUHoB1zKzsjwROR9vhcpkdWtjxfGZ7lHc4QKUz2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HgAXVKHZI2uQF5R5wdjGujNMhMGfRg2iGUWbfmM+FkTMVXbRJ4vsjRJ94XBuNJJzt
	 jaZvmDbb9OAQxcLsrG+19FSXf+gAtVQzrc0+qUYDwew78EtlHNOXmLSeFQHHZLdfI+
	 8PLrGgzZ0xibG6Zni2Xg4XgIOUTUdBdd4pgcHHRlV1GAcM5ZMW5OWDexMTvFtIHemX
	 BdGPz0/MstRjr5mJFnOPBvH1CYURfKIBxbvSCindkzzGouVNxg54TiNaUEPF6ZzPBr
	 LDAeFbRK+qQeQhY5Qa48ss9xtl6jlY7cP5uDMnhxCeygScKUeYDeF2j33g5ZYTWP4D
	 IEXJfJDAovdSA==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so48185e9.0
        for <cgroups@vger.kernel.org>; Sat, 06 Sep 2025 05:56:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDpYmlGmc1fBIawqfQxT1t5ZJFAnozWOfUc50nzcsqsS/+GzVOqm5RdYwS1grim6q2Sq8iTAaB@vger.kernel.org
X-Gm-Message-State: AOJu0YzBl9lme238a140PFE1RuDkOAvWxQX69IOClizMV7NnfAG78hDp
	q7w6zeqI5zF83fLLCu/ouPWae0p5zKHrR4Ussw471BnBC4sq5wP/vyDjaZGZoI/nYaFuBe8hkz5
	T+g3JO3t8s+ixr1D7pQYaXu1PM1b8katyq5FYzSMO
X-Google-Smtp-Source: AGHT+IEfNnKp45M5qcJUuL7/qRCjDosf5G04QAshQBHa3kDT57AM/PVPd+iJmcobbRI9DLXVVHkKzrE+E8Z9vBogcHs=
X-Received: by 2002:a05:600c:4f50:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45dddad796amr1216725e9.6.1757163417539; Sat, 06 Sep 2025
 05:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330> <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330> <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 05:56:46 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNW2kmxKYRE9t8WvSOad9JkLYt0WSAcFOQ9r9=2=XGc9Q@mail.gmail.com>
X-Gm-Features: AS18NWCEh99GxS8T81OQ6NK4C2x78uuoL8QD9vp2Gdy4X-qQSM3YgnmgvY2sedw
Message-ID: <CAF8kJuNW2kmxKYRE9t8WvSOad9JkLYt0WSAcFOQ9r9=2=XGc9Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: YoungJun Park <youngjun.park@lge.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:45=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
> >   - Mask computation: precompute at interface write-time vs runtime
> >     recomputation. (TBD; preference?)
>
> Let's start with runtime. We can have a runtime and cached with
> generation numbers on the toplevel. Any change will reset the top
> level general number then the next lookup will drop the cache value
> and re-evaluate.

Scratch that cache value idea. I found the run time evaluation can be
very simple and elegant.
Each memcg just needs to store the tier onoff value for the local
swap.tiers operation. Also a mask to indicate which of those tiers
present.
e.g. bits 0-1: default, on bit 0 and off bit 1
       bits 2-3: zswap, on bit 2 and off bit3
       bits 4-6: first custom tier
       ...

The evaluation of the current tier "memcg" to the parent with the
default tier shortcut can be:

        onoff =3D memcg->tiers_onoff;
        mask =3D memcg->tiers_mask;

        for (p =3D memcg->parent; p && !has_default(onoff); p =3D p->parent=
) {
                merge =3D mask | p->tiers_mask;
                new =3D merge ^ mask;
                onoff |=3D p->tiers_onoff & new;
                mask =3D merge;
        }
        if (onoff & DEFAULT_OFF) {
                // default off, look for the on tiers to turn on
        } else {
                // default on, look for the off tiers to turn off
        }

It is an all bit operation that does not need caching at all. This can
take advantage of the short cut of the default tier. If the default
tier overwrite exists, no need to search the parent further.

Chris


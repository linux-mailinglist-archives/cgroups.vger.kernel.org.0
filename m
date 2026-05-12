Return-Path: <cgroups+bounces-15843-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCHTC5P5AmokzQEAu9opvQ
	(envelope-from <cgroups+bounces-15843-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:57:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7451E274
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F21E23018319
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE64BCADE;
	Tue, 12 May 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzpLM1Ir"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B174B8DFB
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579755; cv=pass; b=s29iogIls4Kagd82jX3MWTLkO3T8n+aE8+gq6AxOSIOAXzEBgN+MJRvKz7XPVMfEGQERLVREOUTCV9Z4UOMX1xdy0Drp/Y8aoGBLkUiniopie7Xmw3oxOoQf7V5Y/Wr8fuRens2Yi0YtPt9s0pTrkaTndP4Nnu1YP0m1dXln3tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579755; c=relaxed/simple;
	bh=zPcL/MutD2/lLMYB30otertVa4RgHwlHM1Myqydlu+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY28CuGBXAtoR9Owpod37jO5vyxmTIs+SEm5/oV+eNJPDeqwpyBtf/i7SkYYZkYGlmTCY4pyYoXkKGAETDxXSbG3MzVGkYwU8ejQ/gDU8KjTTbqCHxNV+QrjPRzwZH4RTvgHkmDot/jrIS9uQQyV7yKtrbh5KbIMqn7ym7h5hgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzpLM1Ir; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso8173375a12.1
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 02:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579752; cv=none;
        d=google.com; s=arc-20240605;
        b=A4kSpzTYi3u6W7NxWb3wNxHZf7ZaI/SC+pr6sqbW0cNS4jkN3HN8fb3L0zpwxPi3se
         ETwmogNz0ycjLrVSCQgeRgm4Ay/R+FvIJ39NmCDs2dhH075UirDyf+1ngtA2wqfuCITU
         c/kn/gVlJuBMIFsta/fF49BemSXN2Vb29hUHdd59p28hW7F/S7S0RDbmk2CTC3+E58U/
         GcW9V9eptnRckuy0dNXA0kJZFD+MpWWABOXRnXajJLsRdQvcSbizj0nLSJYZYZRmspI6
         aXazFw8i9ImGclZ1ZD8BtgxnfawK5qQ4dIT+PpcJE/e1vA5aTnWFaYwujUliywBxKWNA
         NpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZz2gwZyFbKND0yBkZDP9VGhlp4RSoQid3s+abYi6/4=;
        fh=w7/Ax9L1dtZpg2iRRhSNzbHlGJAroRcek7Lp/SBeVIw=;
        b=UcmCkZ4RGwg/o8bPk0GZnNR/fjfrUDkio51VTciMMmmOnxTYRv+ow12tWj4TvW5tI6
         aFgE1qYgMSFY8gZEzWLm6kCGDt1BIuVQH6/f1BGKNMMREYx8zk+Sbb4eczM6x+N7a4C0
         8KM0mxBN0pX/zqP8//XJKszGg0A1jtMBM6b2QJ1idomXDuPoQej8eCFRInKCF8tduW49
         vM5R/tKEWHMOj6vx4V/lSpFSu3h0B/6nqhnq+cZjD6j/R201jHVkbIsjMVHjw/VGkHQx
         mtNQ7GBWLynbGEH7XCMHNrL6NfQT2uxdPTzxb6uooi4gTipVP4XnGtgWJdBopN9/eyVv
         c6mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778579752; x=1779184552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZz2gwZyFbKND0yBkZDP9VGhlp4RSoQid3s+abYi6/4=;
        b=WzpLM1IrhkE3e/mi/vB50mIA6EmLwz58sJF+kmxrRI3Z2YmMoC66Nt1C8FsPLxDwYH
         5ozpZl/uJWPh5AAj95Usn5xagJ6/T7swfoPjhhERg1BEVAMbUJtrwSakd3gBwZD0i4Hp
         F/dpL2M35Ff0Ot0CnBaxBeYEFkwD7I0pcJzysP6mHNiyop0KPbeTLXnK5zhPGga3PNEx
         75Ed9qlglaQr7fkDXJMT+QfjLDFzvvJ/hTYCALJtYT/FM7ptA9JMVKSAArzPj4BjdRVb
         sKt7LiC2UqbFPmmwoPubNtwNCprlrhDIvtq7q4+tyDLzH4yhx3D7AhHgb5PiJfi+QwdK
         gJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579752; x=1779184552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZz2gwZyFbKND0yBkZDP9VGhlp4RSoQid3s+abYi6/4=;
        b=oAK6NaZQT/DFXI9/71iTb618JYVf9yVq+9FSPTqttF8kuNJ6q6yKLBS1mexupsAsOS
         jp3E0CTG5rJRwES70saFqnfqrEFApieBOq1s789zicdikVRCisC+jclw4Lgdwuz0HHic
         1vCdSoqqLz+4iec8FUNIedEXM0YO7Ok73/tjaq3gKUrr4dtXjP0s8JGhXNf3WuveDTl2
         7JIZ3CudlOHzg4J/jaROnOUIE0QscGjJyBr4uze7ttQIIyAFQihMFn9DQ4twnP7jLDzC
         ti78zTaaQ99wg8Grbg26yOaQTdTyVqMeSNS1ddUtTSylUcUCcHVwmmSiq1p+AeBcGWpR
         1uEA==
X-Forwarded-Encrypted: i=1; AFNElJ/zRrTUO7bQXzF7NdJQaFxcvoGWFcomqPpUT+dze3tS1sUg4mb7aLrwdVzb0Czc9bhslfwORkoa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0wRkKZyqaQOV3Tr/ZLitKBZZXGahtTOoW0gvwaAadZAmG3pt
	O0lhC7Gla4O0TzNGnrXvHWipcd8W3gsLyXiZ4eSbn+F/mwHPobxK6+6r2HT7IP/IXe8dD/syn44
	f8Wr6AhajyWDqkD+/hVl7Ieg7LT12G1E=
X-Gm-Gg: Acq92OER4nOYCJZfuROG7JjGt1UNiW+bBg2znqcTXSRWpYDVNGHg7zfmChEA7pkCrEO
	3WeRYIkGvvxUPXZrzgErcXj1COIWM+WCLvvTxHDgI5L52hEY3DfUz+7dkH0x/POq6leEzDiOSd6
	+lUtmckGmeGV+5uunK1OJUAine6q2Mr5Y9mFDH0aAoQStW9fqZGyIrqsybwNbRpxKXhpIqJab8o
	3EmXFGmYYKdmQk+Ejr4C0Tn31HjEwphGUztOxivf+tErR4xcRpif9+p/H99l0P6bOeC+ZIkILC5
	vt1a6bDQML5AjdR0Pj+lAGQWEA9K+TwcVhB8sS0S
X-Received: by 2002:a05:6402:c45:b0:677:1ce0:c08d with SMTP id
 4fb4d7f45d1cf-680cf83d375mr1265634a12.18.1778579751409; Tue, 12 May 2026
 02:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com> <19f31906-d8fb-489b-8e2a-c4414c99f338@linux.alibaba.com>
In-Reply-To: <19f31906-d8fb-489b-8e2a-c4414c99f338@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 12 May 2026 17:55:14 +0800
X-Gm-Features: AVHnY4Kx5IWu0o7HIeraLeLyWHYiLcIgyJrwH0dsgu48foM5j58dRwqAWziHzSc
Message-ID: <CAMgjq7CFwVkxST=Ya-B7tHEsbtYnRzf_tMXN3ctm3NALvW1LoA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] mm, swap: add support for stable large
 allocation in swap cache directly
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EF7451E274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15843-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,tencent.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:49=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 4/21/26 2:16 PM, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > +/**
> > + * swap_cache_alloc_folio - Allocate folio for swapped out slot in swa=
p cache.
> > + * @targ_entry: swap entry indicating the target slot
> > + * @gfp: memory allocation flags
> > + * @orders: allocation orders
> > + * @vmf: fault information
> > + * @mpol: NUMA memory allocation policy to be applied
> > + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> > + *
> > + * Allocate a folio in the swap cache for one swap slot, typically bef=
ore
> > + * doing IO (e.g. swap in or zswap writeback). The swap slot indicated=
 by
> > + * @targ_entry must have a non-zero swap count (swapped out).
> > + *
> > + * Context: Caller must protect the swap device with reference count o=
r locks.
> > + * Return: Returns the folio if allocation succeeded and folio is adde=
d to
> > + * swap cache. Returns error code if allocation failed due to race.
> > + */
> > +struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp=
,
> > +                                  unsigned long orders, struct vm_faul=
t *vmf,
> > +                                  struct mempolicy *mpol, pgoff_t ilx)
> > +{
> > +     int order, err;
> > +     struct folio *ret;
> > +     struct swap_cluster_info *ci;
> > +
> > +     /* Always allow order 0 so swap won't fail under pressure. */
> > +     order =3D orders ? highest_order(orders |=3D BIT(0)) : 0;
>
> This seems a bit odd here. In THP/mTHP operations, it's usually the
> callers' responsibility to determine the allowable orders. So I think we
> should not implicitly set order 0 here. Instead, we should let callers
> explicitly set it. What do you think?

Totally agree. I hesitated between these two designs.

And Usama also needed this because some callers (PMD swapin) don't
want the fallback.

I'll let the caller explicitly pass in the allowable order in v4.

Thanks for the review!


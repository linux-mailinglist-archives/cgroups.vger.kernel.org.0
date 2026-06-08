Return-Path: <cgroups+bounces-16736-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UmalLA3zJmoNogIAu9opvQ
	(envelope-from <cgroups+bounces-16736-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 18:51:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E81658EEF
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 18:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JtHmSKsX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16736-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16736-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E69EE30D22E4
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237537C10A;
	Mon,  8 Jun 2026 16:23:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CC3C76BB
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 16:23:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935807; cv=pass; b=mWXQlKw4JHXCqrsGNQr82RDpVRNPm3LTUEVooxwKVsqup6ljMipOJy4V1fo2aeTbAaF1I3mNJ7rokLKSjIm/q3IYWZnZ2h+NMa/gW6EU937If3g741c1AWQaxvyqFgle+qIYPTji6a5fVH7OEkBUriRdQQ/AYt8TMn+NfqGpd4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935807; c=relaxed/simple;
	bh=msHcKQxLBsII2jE8+s87uUuYhtqoC8UsJJE4Ma2eSao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTjtolO4od6yXGb4DxHCmVEtOUWp+4OQB+CnpyIIQY75YGZdvI1VuPncWc2jJRi6PQB9V0oaseBBwgTAjJHynV7VqkQxrNta6ax2FcPthuWmcBTz5fwZ84tT7HfNpkXpu35dpyQMfhZLOTFkQr2JKlL8+P6hwDGe5v9pHHNAyqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtHmSKsX; arc=pass smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2312407f8f.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 09:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935804; cv=none;
        d=google.com; s=arc-20240605;
        b=VnmQiG+98UfZ/nrqoFjDVCvNk3cclOAaqYHvpti5PdH5gkRbCVeWez87bSNUubes2C
         dWJpQhFQ4y+iiSVbs8jjcViEQ7EuKghNgvRSUiETEnicZd94jQDyGVb+ZBjTmTwfgVQ3
         sGpdcYUIVTqbBfpKR9+pC2lOqQi+YfkQfiVKJ/1FHJd2m9w9GcSvhq7haTcU7ysGTgtv
         4glxgvHEDKyNikcPoCiggMr4jCo8Z2JT6SPkL427bFelDH5uYW+dUukVKWK20/Aszwjv
         KRkQ3MO7iSE5NBZ/uZ923+T+TTPWrw+3TJddYX1f24p8s4tfErWTCWjyu+X73v97BZyo
         NgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPv+U/wIjO6pXhd0p8FcM6eyTjtkG314lWJDeM8Dul8=;
        fh=SEq0unx3PcRtYIPK8W92SNjreXPHDN6UU/KjJDHSR2o=;
        b=hwqpiKMwhI9dFvrDAycxNejIPYyds2bzz35k/8LOguhuAb7ohfDgQwu4lTms8GZ+6z
         OTMLfzChZzLqbfPc3a+j1bx7y6qGVB5c+zNAuXcbNmE+X1qG2L3jmYFuZ/FvyRPh2RUu
         w3ui/BkwQvwD4OUx4Y9rQBj+Ml5H4fMsLrMW8gOPMSkfvaQuKbXsQxQ7I0IzunnemCry
         zg4TKrN7N0jZDZFJYRHy9Ul3VOamK8nlxWOyw8W+VMD0Q2yW2n1gD8Op+bSJ/TWSgYy7
         PcCgIwGPWYjSUy4Qz4DsFx8eBnJBimeAErkP/kY33qwtaz5Pv+ZKAUxZAwJ6OwGCoV0u
         18Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780935804; x=1781540604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPv+U/wIjO6pXhd0p8FcM6eyTjtkG314lWJDeM8Dul8=;
        b=JtHmSKsXJkKirWcUHlx0Tx0KRB2JjH5avxG1Bs1/edk/J79tVdOFOeyaqGBvjIwwXe
         Ju3X44Ls090yo1QbQRBJCZhQNq544qC7JFUtXlnYjAnp75Ct8moSHVjudaUUfALTbAZs
         PAastllztlVcP5kam3ivPBdUzKeYMiPiWOcNsJEJUVd+33QyZxPY1GyCwauII1bfcVhr
         HPHIaTKiuc+pHKphcrqE1goroh+MzhmiOGs0HwZwC5oSxX3Z4e7hV8J3GOU2u/JYPH1T
         yTEWHdjg+64jalGalQNE4I6NZCjmkIsPJU0P4H/SmcjFTao0aZNt6wYoGW1whrovuhzq
         1/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935804; x=1781540604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPv+U/wIjO6pXhd0p8FcM6eyTjtkG314lWJDeM8Dul8=;
        b=gzYtRW5Hb35D4wvwkhTyAvUlDjH/dIXQFSlNByvng9p13nMcYqjCki7D5QZS5E2z4q
         RVavb5t7LIOUGh9lZLnTVAn6mLupxx7k+Md5HPqIuDo2H9Ec/OaYOKsjioQCjpltxXYd
         P71JM0Qs/YqywJqz2Vj7dRTXuhnkGy+/kcKn5ZNLgNYiXWQaTxBbZciUiXMkHGY7QOUU
         kKyQTQJVBgGTtTKGQ4+App0ImWNIrEF/v2R9Tou4jksLJCTbONxCuLtl9Aw0p1wZrsyB
         IhuBWSpRomRhaC8A+rS5d0BX5eZwf2lctt9xoEMyChVvlI7aVyzjk7lbMj9YRahflS3T
         vyjw==
X-Forwarded-Encrypted: i=1; AFNElJ/WvutFCFHdnLqH07por5MFl9YePO1S6CNtree4wl4bdHiDWfnpWDJpqQ+iuV0eroC4LoRLF1BY@vger.kernel.org
X-Gm-Message-State: AOJu0Yztuju+VC7EnWaHRd6LR617KAWGQ52gbzS1HtEcFg2ZmDmvCQAO
	hjYK4frSchw2MBsT/B2MkoFqYIP71VeeYAgZAoFFl6fX2h54Sl8cTDRJiFqjMIKUB/40Ac4shE+
	oO2b48Oh/FvqjcDPgBROOqxInMDqEAzM=
X-Gm-Gg: Acq92OGqYoCTieIMXdDEbRZ9YG5Wpn9xhNRZMiVxhWGH9z+5PXrndQgAD/SjAqQJitI
	1CiJ7scjqyd/3jw6hu4kdb/e9oo+caiaCRKrJFCCVuKg/mVR07TDvQyO0JWWOhkjtwB/vOrY2cB
	cVz0m0cB7cDhibuzit5V8yH1IODX7/uZKQzVZQhp1jBA0tzf7skupnRcpcGELZMOUZCLmtuuugw
	zaiOsGKj5A+hFrDSS8wUFedhpoBZRGZfOGuLiwHuN7XhvyDVL0VXq/vgwG0t5QWvPcmiW/RfEm2
	SVv9Fc8ZNdki1JIJRqH6Ms3B7NsXebqVKfvbu0L2uAPh4Vr2pHmfFFt0emec
X-Received: by 2002:a05:600c:3f1b:b0:490:bcf6:46bf with SMTP id
 5b1f17b1804b1-490c2599fecmr275598275e9.9.1780935803894; Mon, 08 Jun 2026
 09:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com> <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com> <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com> <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com> <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com> <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
In-Reply-To: <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 8 Jun 2026 09:23:11 -0700
X-Gm-Features: AVVi8CcQa0JXhG_fDPPqHmrr3OFhGwIKj95CSTSdP9Q_mQuoQWpHKZOKlZLp87U
Message-ID: <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16736-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0E81658EEF

On Mon, Jun 8, 2026 at 5:50=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
> On 2026/6/5 01:23, Nhat Pham wrote:
> >
>
> Thanks for the suggestion!
>
> I ran some tests and found that neither the per-memcg cursor nor
> different batch sizes have a significant impact on proactive writeback
> performance. However, exactly as we suspected, without the per-memcg
> cursor, the writeback distribution among child memcgs is highly unfair.
>
> Test Setup:
>
>    zswap config: 18G capacity, LZ4 compression.
>    cgroup hierarchy: 1 parent test memcg with 10 child memcgs.
>    Allocation: Allocated 1600MB of anonymous pages in each child memcg.
> To ensure compressibility, the first half of each page was filled with
> random data and the second half with zeros.
>    Force to zswap: Ran echo "1600M" > memory.reclaim on each child memcg
> to squeeze all their memory into zswap.
>    Trigger writeback: Ran echo "<size> zswap_writeback_only" >
> memory.reclaim on the parent cgroup 200 times, with a 2-second interval
> between each run.
>    Metric: Monitored the zswpwb_proactive metric in memory.stat to
> observe the writeback volume.
>    **Note**: The size here refers to the uncompressed memory size. Also,
> since the second-chance algorithm would cause many writebacks to fall
> short of the target size, I **bypassed** it during these tests to avoid
> interference.
>
> Without cursor (size: 1M, batch: 32)
>    child        wb_pages        wb_MB     share%
>    child0           6368        24.88      12.50
>    child1           6368        24.88      12.50
>    child2           6368        24.88      12.50
>    child3           6368        24.88      12.50
>    child4           6368        24.88      12.50
>    child5           6368        24.88      12.50
>    child6           6368        24.88      12.50
>    child7           6368        24.88      12.50
>    child8              0         0.00       0.00
>    child9              0         0.00       0.00
> Without cursor (size: 1M, batch: 128)
>    child        wb_pages        wb_MB     share%
>    child0          25472        99.50      50.00
>    child1          25472        99.50      50.00
>    child2              0         0.00       0.00
>    child3              0         0.00       0.00
>    child4              0         0.00       0.00
>    child5              0         0.00       0.00
>    child6              0         0.00       0.00
>    child7              0         0.00       0.00
>    child8              0         0.00       0.00
>    child9              0         0.00       0.00
> Without cursor (size: 6M, batch: 128)
>    child        wb_pages        wb_MB     share%
>    child0          51200       200.00      16.67
>    child1          51200       200.00      16.67
>    child2          25600       100.00       8.33
>    child3          25600       100.00       8.33
>    child4          25600       100.00       8.33
>    child5          25600       100.00       8.33
>    child6          25600       100.00       8.33
>    child7          25600       100.00       8.33
>    child8          25600       100.00       8.33
>    child9          25600       100.00       8.33
>
>
> With cursor (size: 1M, batch: 32)
>    child        wb_pages        wb_MB     share%
>    child0           5120        20.00      10.00
>    child1           5120        20.00      10.00
>    child2           5120        20.00      10.00
>    child3           5120        20.00      10.00
>    child4           5120        20.00      10.00
>    child5           5120        20.00      10.00
>    child6           5120        20.00      10.00
>    child7           5120        20.00      10.00
>    child8           5120        20.00      10.00
>    child9           5120        20.00      10.00
> With cursor (size: 1M, batch: 128)
>    child        wb_pages        wb_MB     share%
>    child0           5120        20.00      10.00
>    child1           5120        20.00      10.00
>    child2           5120        20.00      10.00
>    child3           5120        20.00      10.00
>    child4           5120        20.00      10.00
>    child5           5120        20.00      10.00
>    child6           5120        20.00      10.00
>    child7           5120        20.00      10.00
>    child8           5120        20.00      10.00
>    child9           5120        20.00      10.00
>

Yeah OTOH, we don't really make fairness an API contract here. When
you set up a proactive reclaim scheme, if you decide to target a
cgroup (and not its children separately), everything underneath it is
fair game to the kernel in any split that we fancy. If you want true
fairness or a desired split, you have to treat them as independent
memory domains and set up proactive reclaim to hit each child cgroup
separately (i.e one "echo > memory.reclaim" for each of them). This is
necessary for example if each child represents a separate, isolated
service/container/tenant. And maybe this is actually what you really
want - hit the ancestor cgroup very lightly for the stuff it owns, but
then dedidcate most of the reclaim effort at the leaf cgroups
independently?

But OTOH, this does seem like a recipe for inefficient reclaim. We
might exhaust hotter memory of a cgroup while sparing colder memory of
another cgroup... But maybe if they're all cold anyway, then who
cares, and eventually you'll get to the cold stuff of other child?

Yosry, what's the concern here? Is it space overhead, or overall code
complexity?


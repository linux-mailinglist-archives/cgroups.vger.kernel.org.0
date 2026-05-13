Return-Path: <cgroups+bounces-15918-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JP1MsrpBGrOQQIAu9opvQ
	(envelope-from <cgroups+bounces-15918-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:14:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAB753AE91
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4133086FA7
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0E395AC3;
	Wed, 13 May 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh89k2rL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5B3955F7
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706613; cv=pass; b=i8l8PAgiIJao4UFCACB354bLYGN10l4nZLb7AIYR6ykAXjrsTpyOl9oaRTbGRXQvoZs5PCtgkmP/+tc0/T9UEa7k6SDuGp79/S2faYbkRPaJrzrtKZW6XJbph/FGhqEAp1An6dpYTHVi4JgDhXT+9fIUpp2rdSF3/me7i6C+VEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706613; c=relaxed/simple;
	bh=yw9HWAanvQGxxotRyCikt0YifQqq9eeU+f4Jwn4SlFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onF+/6c6LCtiQF8J0QUyGh2pLGjwjboLJTBPKlA9YWeo5i5/W8TURH0nNy7s2UXTgDCRV6xlZ20zvKMCqJKI1CPem/XSaZelxIEArM04/CtrUSs6Kv17vG/c6NnTvyx86bv+tDn2yTlyHvIDvV/oKuFVe5gfJsjh3hbrNUolDmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh89k2rL; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso5871780f8f.2
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 14:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778706609; cv=none;
        d=google.com; s=arc-20240605;
        b=kUBfDQlnHmTxGQcGw9mT13CaL3gCJ7xpkTqRcvHyM7GFM9hOezxyUWoyrLUT+Hp9+P
         7uaurS3xu+fDJWkqrycHWvpWXNKHDS8KzCPwETsXN/he6Bl2QDscjoruzRHGOlRBquHF
         mOH3Z2QnqX3sMSXWCYCT2vjs14Z+rvgvSQIKojHIrl5ZzcwiVT3qbEIO2He7ePolpznR
         adJP6u7kw5InySO0V1Y0+6xizH5QmuFzyHo+JcogwcnaxSj0/LGiziMA13tnyxcAigSA
         i2zvz25skAeeYJc9UrEGR8cruP+KtOyC3DkpHYy/kDV/q2gWnnx5ATR3zrDwgQdYAqSD
         agZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yw9HWAanvQGxxotRyCikt0YifQqq9eeU+f4Jwn4SlFY=;
        fh=BPnQOst02rIRi3/wwxZnkyr8Ynpl/rrd1rk6wuV4gZI=;
        b=gKD7nkRgvF0cIZzzRhNN4h9tyvzxSO3gorGPMGhxg20NNZZ2v9hlaMODGm6A1L4903
         BgiFmFVQ1dL8Qdd5h7V4n+ilHmB28uHzIZp1ZNnXzu804uuGpYlgRlwqB2VwD28GEvxN
         MQ/wp7XUEV/I9iJ7s5s++VI3Dnc2KqwkWjokCZQiWGvQu8QqBCQKTagVj4IZAk5wynhD
         I3NUBRRyV+fZxJcl9wi8gTpnjd6zoLHjibQxJ4ZHNdCCP1+srnvvYrksWfYxLLZBl4yW
         pbJn4FXfNeQJATXwpzMdCu9Ls8bGfl0xTso56SjT+vGlJqOJHFQ/g0DZ7Khz5ptwLf79
         S/7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706609; x=1779311409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw9HWAanvQGxxotRyCikt0YifQqq9eeU+f4Jwn4SlFY=;
        b=fh89k2rLRZeBfT5zgfJb4tdJLmGNspF3JBgLkcQpaE1xUA7DLq4JhpGe9SKBtnntPk
         W7bjxuMVKUgm7SquiUj4h61maOaaPTEF4SL0sArrqPGxufBPBzNxEmLuQihIDB0/uYiJ
         NJ1n5a+ptg1cGA9jSPjXj7m0Vig4nMOkyMzPuuUZ8d/McqqzXsDczF6DTmV01uZLjzwy
         KgcvCloG0Y7v6dm7B1BaJqvMrBJkpM/1eCT3je9O/DOC1OGmoOCha0l8oqKVjhZdJiQ5
         ZiLINdp/Jzh+5cUR+A422uMlXsMfly//YA6X47oEwng/sBoLDUTGqcXXu8VuSj7I3Xtb
         fKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706609; x=1779311409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yw9HWAanvQGxxotRyCikt0YifQqq9eeU+f4Jwn4SlFY=;
        b=qjQE2pHxBE/W7K5fWWhkBZ8y09I2oRhaoKPq7o3fFLWz4xHrayYg1ILk0tt/yJD0k3
         ubad9uVRiornQ9wU7Z/S8GvYjq552k8xokI5pTxXTlpVbgWcXwwNIiWAuUWCfVCUGRMF
         MxfxQbKC2U+gRV7X/A5vu/3dx8MfM54MQiUl/ZWMmW3EpgFYPHFOVrIU1MLQn7CsKGIs
         AHHFhBciMD6w2Iv1MnUc6pv9jzNGYTMsadxx3tg/vUZtYI7DzZ5f3kisJK+WjVlIi1l1
         D3Zsb191E+aimEla4yOVYzx0792FjOmrBjD6mBmRkPcF2280QlJ0z8eDMop5vivuzggQ
         Zd2A==
X-Forwarded-Encrypted: i=1; AFNElJ/HLdKNYFWtGGO9p7o6kwn7tT4LX5mInjzdLhaTaC9FPtsBoRuR2sqo6JZml0jHWxMRrWlTujXI@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxgL5PH/S+uPL0SlELvd8mBKq3v6ijP54vX8GZynJx4Q1frwL
	kxXU5DKZvG/rRUO5ZXgaQHqbfBEjIhuuJ2NAk+gWSTZ6OaKtqsKPpykZ5N7jsi8pulTYdVuFbR+
	tgXB1ovOPr3EDGd8OZLQJlTH2OBgIdV4=
X-Gm-Gg: Acq92OEh0bIHtMGlNk2YAV3lyurRabXt1FD4UFOjXGC8Im5rbY7SeX19vzBB4pxAOs+
	3SxdMWfsvYxGSaaa6wJgdZmiMvt1zcO2RC+lAHLlX76UyqtdojVmqxs/jXjXLxPqAQgIyTrjDbs
	90r/d2IS3cdymQ3mRSD3V+mKbjovSmuCduNDkYEE8dC1TS1mIfEZJY6aBeAXL7K9e3QPVh8KUq/
	o7qTbcrbVthu8oTEYA1CapBiIsrquHQ+C721wYLuZsbR+F4IMBflmxDdT0xIRt9PgvTR2qbtY6O
	tzZf+SmFRcP+Qhk4KCLyj+UF681YylSx8P+WMoA=
X-Received: by 2002:a05:6000:471e:b0:45d:3cbf:bdda with SMTP id
 ffacd0b85a97d-45d3cbfbe3amr3759439f8f.20.1778706609173; Wed, 13 May 2026
 14:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com> <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
 <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com> <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
 <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
In-Reply-To: <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 May 2026 14:09:58 -0700
X-Gm-Features: AVHnY4IP8DEacwhsvW6UMiUvn20aGQIjyCPvbowN-gskCg9d2oQuJyw6uFZbOMY
Message-ID: <CAKEwX=M=6AQVYA7ROM0YOP7irpxbdMrEOAHKGKYo0Qgr+-uhSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2FAB753AE91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15918-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email,cmu.edu:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 1:04=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/5/12 23:47, Nhat Pham wrote:
> > On Tue, May 12, 2026 at 2:32=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 2026/5/12 03:57, Yosry Ahmed wrote:
> >>> On Mon, May 11, 2026 at 12:49=E2=80=AFPM Nhat Pham <nphamcs@gmail.com=
> wrote:
> >>>>
> >>>> On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail=
.com> wrote:
> >>>>>
> >>>>> From: Hao Jia <jiahao1@lixiang.com>
> >>>>>
> >>>>> Zswap currently writes back pages to backing swap devices reactivel=
y,
> >>>>> triggered either by memory pressure via the shrinker or by the pool
> >>>>> reaching its size limit. This reactive approach offers no precise
> >>>>> control over when writeback happens, which can disturb latency-sens=
itive
> >>>>> workloads, and it cannot direct writeback at a specific memory cgro=
up.
> >>>>> However, there are scenarios where users might want to proactively
> >>>>> write back cold pages from zswap to the backing swap device, for
> >>>>> example, to free up memory for other applications or to prepare for
> >>>>> upcoming memory-intensive workloads.
> >>>>>
> >>>>> Therefore, implement a proactive writeback mechanism for zswap by
> >>>>> adding a new cgroup interface file memory.zswap.proactive_writeback
> >>>>> within the memory controller.
> >>>>
> >>
> >> Thanks Nhat, Yosry =E2=80=94 let me address both comments together.
> >>
> >>>>
> >>>> We already have memory.reclaim, no? Would that not work to create
> >>>> headroom generally for your use case? Is there a reason why we are
> >>>> treating zswap memory as special here?
> >>>
> >>
> >> Apologies for the lack of detailed explanation in the patch descriptio=
n,
> >> which led to the confusion.
> >>
> >> While we are already utilizing memory.reclaim, it does not fully addre=
ss
> >> our requirements.
> >>
> >> Our deployment runs a userspace proactive reclaimer that drives
> >> memory.reclaim based on the system's runtime state (memory/CPU/IO
> >> pressure, refault rate, ...) and workload-specific
> >> policy. That first stage compresses cold anon pages into zswap. Entrie=
s
> >> that then remain in zswap past a policy-defined age threshold are
> >> considered "twice cold", and the reclaimer wants
> >> to write them back to the backing swap device at a moment of its own
> >> choosing, to further reclaim the DRAM still held by the compressed dat=
a.
> >>
> >> This is the "second-level offloading" pattern described in Meta's TMO
> >> paper [1]. zswap proactive writeback is what this series introduces to
> >> address that second-level offloading stage.
> >>
> >> [1] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf
> >
> > Yeah that's what we've been trying to work on as well :) We are
> > working on a couple of improvements to the mechanism side of this path
> > (cc Alex) - hopefully it will help your use case too!
> >
> > Anyway, back to my original inquiry: I understand your use case. It's
> > pretty similar to our goal. What I'm not getting is why is
> > memory.reclaim (which you already use) not sufficient for zswap ->
> > disk swap offloading too?
> >
> > Zswap objects are organized into LRU and exposed to the shrinker
> > interface. Echo-ing to memory.reclaim should also offload some zswap
> > entries, correct? Are there still cold zswap entries that escape this,
> > somehow?
> >
>
> Yes, the memory.reclaim path does drive some zswap writeback, but
> it is not enough for our case.
>
> 1. For a memcg that has reached steady state (a common case being
> when memory.current is below the policy target), the userspace
> reclaimer may not invoke memory.reclaim on it for a long time,
> and so no second-level offloading happens through
> memory.reclaim. In this state we want
> memory.zswap.proactive_writeback to write back entries that
> have sat in zswap past an age threshold, to further reclaim
> the DRAM still held by the compressed data.
>
> 2. Even when memory.reclaim is running, the fraction of zswap
> residency that ends up reaching the backing swap device is
> still very small for many of our workloads, and the userspace
> reclaimer has no way to participate in or control the
> granularity of zswap writeback. So in our deployment we prefer
> to leave the zswap shrinker disabled, decouple LRU -> zswap
> from zswap -> swap, and use a dedicated proactive-writeback
> interface that lifts the writeback policy into userspace where
> it can evolve independently of the kernel.

I see. It's interesting - we've been dealing with the opposite
problems (reclaiming too much from zswap) that it's refreshing to see
the other end of the spectrum :) We should invest more into this to
see why we are not reclaiming enough, but I see the value of adding a
knob to hit zswap exclusively.

Regarding age-based reclaim, I agree with Yosry here. Let us try to
land an interface to do targeted reclaim on compressed memory first. I
do see the value of age information: with it, you can track zswap
entries ages and the distribution of refault ages, and only reclaim
the tail. However, I wonder if you can just build a system that adapt
the reclaim request size based on PSI, refault rate etc. similar to
how you're adjusting memory.reclaim on uncompressed memories with a
senpai-like system. Something along the line of - if we are swapping
in too much from disk (or if IO pressure is high), back off, and if
not, stealing a bit more from zswap pool (perhaps with a bigger step
size), etc. Is there a reason why zswap cannot adopt a similar
strategy?


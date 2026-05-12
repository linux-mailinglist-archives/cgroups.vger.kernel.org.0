Return-Path: <cgroups+bounces-15850-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKRXNFVNA2r63gEAu9opvQ
	(envelope-from <cgroups+bounces-15850-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 17:55:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA81524249
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93273301C8B4
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C63C4B9F;
	Tue, 12 May 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eriWQtJY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7836404B
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600884; cv=pass; b=Q6C1aQ5R1+Qu3f5uW8CPWr8Q2TyIaqO/TO/CoLs+0CwsGJxnFCLC/698DUgf8F8c9JNwbRpDW6UCiwN/IIXX0szlhfWb9cxCNeax7jQJ062hTguEU8gK4W5qwCs8S8C0Sv4+2LWLuaLD3V7FfpwoOzFHjqGsogXx4TpmQgRToIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600884; c=relaxed/simple;
	bh=B6amhBSyF7iVuaDtigX7s8Kmefjc7nih3jCvVr8zMNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoZIfttiKz0usRgtlLZr5VB38y6ThWkTEUhFDehd0COdO+TgB8rmvarF4LXGvauitdhAok8x2eb3nZko0m6S36924O0L0Dk720JLKX9iZztZhQOivj+q/yztRQovM8pS1XvGOolS3BPJsLguTUbymyA6Q37lu0LsQXtA6Y1MnPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eriWQtJY; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso53142105e9.2
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 08:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600880; cv=none;
        d=google.com; s=arc-20240605;
        b=OxyMVd/6uH0HYPMe2dzbxqNOqHj6IEIHozjGiaYV7qGH4Qxnm5n4hazlT9QBbcsmmV
         muvNF+F5+y1Rigra8VFP5gIs9AH0do1GWhlVWN0EWkSemLz/6txSXaffB5QhdRjkEcJd
         jVjzn956HDHqiIAgsXDUbKNyVBzij7h+jTGoN4l/MjlG3Q/OeGMBDM028Ticr4JniD0+
         +mocMZmeghfRStl2pjq2soxCwsTyNbiwNC80dEbMXbOHr1ixO2te4lb+oP6waQgxYPIC
         N/GJuctAppdyahvMsdpyj9vyLuaH2shDQ0Q0B3WZ02jaXQ3sF3JlIidZ9yhRpVKWzojT
         GdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvUvOiFnKHM0REYpmaWk5d+F2+5GIifwAyYSC+4XUic=;
        fh=8shJITB48zOEvA5ZBGB8tjNJAMq8dUkMz2kdynW9Vnk=;
        b=ht/W8btHZllFdT7n1onzSl9wvibNijHV7v82xUiHJ+bqxSJA2suB30/5Fp1U4jlljX
         Ruqrojbeq+w8Q9/Hf0L652IaKoa4fT091WF18rAWDJtxEzlAi2XMGB9pJSMCbNWs9/kJ
         nfc9vHnVopzF+h+8DpxP3cD1/ALdTEzx9vxEvNQGIbPKMCfc0XAV1CLNuZ/H98zOkY2r
         BzIatwcOANCStuFOmaPwf1aYYEAP07fSlf0Zg0Irf3n2Vt+GUo9dZ1gWpdbjD6le1IGQ
         YnlonSbV9IO+wV0vmna3IpsqRVt3eQfCqU0pBYGT0TB54seOc4PjTSaIz6FxMc3XFCIO
         wCzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600880; x=1779205680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvUvOiFnKHM0REYpmaWk5d+F2+5GIifwAyYSC+4XUic=;
        b=eriWQtJYL7/aTBCvW0VRXFTefI0roq6fsreKMn7E2uFXWreXSb7v27ELgolV5AlR/u
         CPNmbOh2KOu/d5ZHI3FS3lMIQV21aHt7m50Uiojy2gepasbkoOilQZ4+bj4KKyYdBF6Y
         1hkkTIyLKfBAIb0X9Ub7qGIOFwTye0GmhcI/WyY8ozx/lzMNLnezhsDsj6lrEGXTT8nJ
         kcJ+wovv/EwokIpWX3wrdNt+kyi9mr9xfHV/yyU0LAWQUXDD3w8t4oflU3BLSqJ2SJgo
         9+1mohZeGaelpwZiHWuAXsZssk7KdhM/kRqSnMC9tkzaGKqvTrPAsY0q1oQCeQhHv3Sd
         5ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600880; x=1779205680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvUvOiFnKHM0REYpmaWk5d+F2+5GIifwAyYSC+4XUic=;
        b=ND+PVrPBO/mRP/UTB49zE4RygYOkXmrwvt2PhHv8lDfDFFKiCwx1l5htqawHk7rlEy
         ayn6RztqNinvr316NyWzJrd6qEE0SY1LkrH1m6N/ri4Fi8cHX/gOBpJ8ncQUt271zfOR
         Gd3aFBBvbboTSwQjCGcPvlM4D5TPVXMjZwBwYJGASZwB4O/Bmgcqg6gjLMrqVcdLtriH
         Ezbt5dIskQBccqzy3v6+LGROrDbXpxN2aLoNdP/7s6hphZl6gcI6bkof0+ZWNer2utjq
         uP+DGZmjO2i1s9cZMQFHDd4KlIGve4e4at7op/KRDFD14VoufGWm9LHqR7Ussi/xwZD7
         j7VQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dFH6Vr/7//X2M71PRJFhqQ46p9MC3R6q2wEe67RAWKrnVj1zUSTxwkGFK/vzvae2Q5ylEM13m@vger.kernel.org
X-Gm-Message-State: AOJu0YycOb+G+BEWYkfQth/F+DpUijLXGQbPmdeW1d+uHTiN6qZ4rK+j
	zPN7BN7mu/EB8ywQ+VTqIk+b4TQdaT9kr34Z8q/7XLIaU1ZUD6sOHVWPZbTaiju+luoeVf4EHGV
	K7KHMe8xEFt4SrUel84t9R9fyVnYtQEw=
X-Gm-Gg: Acq92OHnicBF+tIX1cUVuISVbJy5/HCmXMXPT3b1V0ydPNZtlViMKDwQ6LlHLoRwyRe
	qjz5Tbv6FMSyyTYBE23UWUUTEzqsguLvW40cgccZRWAXnXpCc1oy6aUX+i8xHqUWY7AeCziJ2XQ
	bQ+yuhYtZnPYqAPi0KApOHATYqSfbQIs793sAcfCG/XilwH3J8046A25t4ElXMV1AKgR5U5TIK6
	9jCr0zpOCYFsIflos5eBeUsnCNVAdDrRzGfeUoMcgUruYHpwo5L6nxqVxFkGCEYz9Sl6ixCnMku
	q6aCYcj3zZcuMCWF1uyQoolEI9hHq8SAMPKeXKI=
X-Received: by 2002:a05:600c:3e19:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48e8fe721afmr50364255e9.15.1778600879485; Tue, 12 May 2026
 08:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com> <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com> <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com>
In-Reply-To: <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 12 May 2026 08:47:47 -0700
X-Gm-Features: AVHnY4JskTf23tSbnnLn2V95OlEo1bjSAHzhtTqVEIKfyAdTp_H0_7MV48nFSA8
Message-ID: <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
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
X-Rspamd-Queue-Id: CFA81524249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15850-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lixiang.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:32=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/5/12 03:57, Yosry Ahmed wrote:
> > On Mon, May 11, 2026 at 12:49=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> >>
> >> On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.c=
om> wrote:
> >>>
> >>> From: Hao Jia <jiahao1@lixiang.com>
> >>>
> >>> Zswap currently writes back pages to backing swap devices reactively,
> >>> triggered either by memory pressure via the shrinker or by the pool
> >>> reaching its size limit. This reactive approach offers no precise
> >>> control over when writeback happens, which can disturb latency-sensit=
ive
> >>> workloads, and it cannot direct writeback at a specific memory cgroup=
.
> >>> However, there are scenarios where users might want to proactively
> >>> write back cold pages from zswap to the backing swap device, for
> >>> example, to free up memory for other applications or to prepare for
> >>> upcoming memory-intensive workloads.
> >>>
> >>> Therefore, implement a proactive writeback mechanism for zswap by
> >>> adding a new cgroup interface file memory.zswap.proactive_writeback
> >>> within the memory controller.
> >>
>
> Thanks Nhat, Yosry =E2=80=94 let me address both comments together.
>
> >>
> >> We already have memory.reclaim, no? Would that not work to create
> >> headroom generally for your use case? Is there a reason why we are
> >> treating zswap memory as special here?
> >
>
> Apologies for the lack of detailed explanation in the patch description,
> which led to the confusion.
>
> While we are already utilizing memory.reclaim, it does not fully address
> our requirements.
>
> Our deployment runs a userspace proactive reclaimer that drives
> memory.reclaim based on the system's runtime state (memory/CPU/IO
> pressure, refault rate, ...) and workload-specific
> policy. That first stage compresses cold anon pages into zswap. Entries
> that then remain in zswap past a policy-defined age threshold are
> considered "twice cold", and the reclaimer wants
> to write them back to the backing swap device at a moment of its own
> choosing, to further reclaim the DRAM still held by the compressed data.
>
> This is the "second-level offloading" pattern described in Meta's TMO
> paper [1]. zswap proactive writeback is what this series introduces to
> address that second-level offloading stage.
>
> [1] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf

Yeah that's what we've been trying to work on as well :) We are
working on a couple of improvements to the mechanism side of this path
(cc Alex) - hopefully it will help your use case too!

Anyway, back to my original inquiry: I understand your use case. It's
pretty similar to our goal. What I'm not getting is why is
memory.reclaim (which you already use) not sufficient for zswap ->
disk swap offloading too?

Zswap objects are organized into LRU and exposed to the shrinker
interface. Echo-ing to memory.reclaim should also offload some zswap
entries, correct? Are there still cold zswap entries that escape this,
somehow?

Furthermore, we already have a way to detect the "twice cold" entries
you mentioned: the referenced bit. This is analogous to the way we
treat uncompressed pages.

>
>
> > +1, why do we need to specifically proactively reclaim the compressed m=
emory?
> >
> > Also, if we do need to minimize the compressed memory and force higher
> > writeback rates, we can do so with memory.zswap.max, right?
>
> Here are a few reasons why memory.zswap.max is not enough:
>
> 1. Writing memory.zswap.max itself does not trigger any writeback
> immediately. For a memcg that has reached steady state (on which the
> userspace reclaimer is no longer invoking
> memory.reclaim), after enough time has passed, the reclaimer has no good
> way to trigger proactive writeback for second-level offloading by
> lowering memory.zswap.max, because in steady
> state nothing drives the zswap_store() -> shrink_memcg() path. The
> userspace reclaimer still has no control over when proactive writeback
> happens.
>
> 2. memory.zswap.max currently triggers zswap writeback via zswap_store()
> -> shrink_memcg(), and each over-limit event can write back at most
> NR_NODES entries. If zswap residency is far
> above memory.zswap.max, converging to the target size requires at least
> O(over-limit pages / NR_NODES) zswap_store() events, with no batching =E2=
=80=94
> proactive writeback therefore has
> significant latency.
>
> 3. memory.zswap.max is a stateful interface. If the userspace reclaimer
> crashes for any reason mid-operation, it may leave memory.zswap.max at
> some set value, putting the application in a
>   persistently throttled bad state.
>
> 4. Once the userspace reclaimer has lowered memory.zswap.max, if the
> workload is rapidly expanding and triggers memory reclaim via
> memory.high / kswapd / etc., the actual amount written
> back can exceed what was intended.

One more reason: IIRC, when you set memory.zswap.max to a value other
than 0 max, every zswap store incurs a pretty expensive check
(obj_cgroup_may_zswap), which does a force flush
(__mem_cgroup_flush_stats). That was pretty expensive last time some
of our internal services played with it. So yeah, it's not ideal...

(if you're using this, might wanna profile this as well).

>
> Thanks,
> Hao


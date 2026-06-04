Return-Path: <cgroups+bounces-16650-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kWyVIeu3IWqaMQEAu9opvQ
	(envelope-from <cgroups+bounces-16650-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 19:37:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1B642571
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 19:37:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=K8xCd26f;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16650-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16650-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 298FD30295BE
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01714C6F1C;
	Thu,  4 Jun 2026 17:23:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B34C6F1B
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 17:23:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593831; cv=pass; b=uTtXE5FVHzjfxr7b/VwyuEjIiSJy/iIHjZqOw2Vlq1Pvf2AYb11oaF+f1ANeNSboIF3bKULuz15MglcPKxorHTqlOk67t78hzlA7CKYv+VO5cY63apyAPJPZ6Gu409urQY2ybpbY+95i59PM6eXk/z/Z+sCp4yNZrkF4IHL6pQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593831; c=relaxed/simple;
	bh=WgIKM3EBxa7eVRr1Qp+EPGWEolxCAu6y4pk0+g25Gr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma650Fpj6ivsqFcgEQNNCt7CGgIwrcycj9zHcQyEA1VZ/oChoDMBEpfhJqAZZnrA9/8OXXAwTR/uL5RYtRZTfNW13Gcscf176aY8qc4ss1EEWksPkbRgXcY7wotYbPHDpI77w3tz7bCncpFpBmQ//0Mm84iGxWXuL2ndrFh4/os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8xCd26f; arc=pass smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so801380f8f.2
        for <cgroups@vger.kernel.org>; Thu, 04 Jun 2026 10:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780593828; cv=none;
        d=google.com; s=arc-20240605;
        b=QfHnUz6UWYeS0nS6+CoAQRutneOp3OqNbPgpqwS7wdzJ2wm0kwO0mDnlESRKaqqF7c
         T1IR+LuqTz6KAEj8eaOaLlP2RDadbB3dGW7G4Rd3X9aqCiYxoZE44YfX8fyNK6DZ2Zfr
         0cOv9HzEhVSG3b/9Qw4HWVqbFQJE3oxeFAtdJSiedGfLGbI6scS5z2BlhpGZG9Wy3J9r
         Gse/AbDqIit2SnKIhnZkppjN1Vvypbj/hgj7LKhoTBSxxUKm39tKSAGPY49Lubxe1B3e
         SeoO/+MST9RzfCRGrWs1xrjhpjiuJwh1EjUAcqMr2OHVhiJrHo/gWuxElEeq9SW8PuhE
         I3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rB/IXV+OMc2A+R0X4txGzVE+20Yu2JeN9gbqIkZf1A=;
        fh=e0ebJTuuVjyfnIgw2QbfWkVUWogYQvvw1kXpbDt30fU=;
        b=eRmCtmPLRTNF9dLf6pnnVsUw64DYXGJJFp32e0LVa1rE0bzst453/6H2tEr/57FPbY
         RDxqmlX4E2CF4dEn8j7DYelfq8wLjrLMP8DnPeoJjvhlLH6N/Z+w7Zk491Y1SsPXPEaf
         sq56yTiiVs/Gst+yHemDBDw24GHGsZVLOCN9r3x9J9Sl8USjz6kFqFpK/0iXk3ZBnazk
         AQ0N5GulDV3cCtZ1ExCNEfvHwxwQkOGXrkw/yoGEyBB8Fyr1YK1tSC0a277eU4r1PiUY
         0ymaufrR41dzmgwTmcAFWOSw1sXwWpURHpzqXNLInD3/uENQY7X6OzakEu+QOozxZJLx
         +PaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593828; x=1781198628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rB/IXV+OMc2A+R0X4txGzVE+20Yu2JeN9gbqIkZf1A=;
        b=K8xCd26f2jR2srH2WJ5ijXhlT8cgZ6PqnPdioj0r+nI/S0Qr48jEUxIOGJIjpbV+0X
         K47vwwIgo00nOo8RbqyBIdnLUG0MZv+UIRtELeJnHtrdmvVk6FnWR71PRGfzobV+GBGN
         1X+YCQuRNbEi6RUDSZIpOun2lkHfac6THvsUgEZW74pS60qnqikFM1fvZcEoDnn9MPlZ
         +gMGdfS4jhtzb9JzaWkATdTwLJeV9FncYCWX2kZMRtGxuV3uemghesicJMane/whLYRw
         R7C7lQwZNRaxLHwgQ2PyjuMyJc38nfO0zT81SZSmeuxw+XCPwHUZ9d3OA58eNQM1aT4Z
         g+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593828; x=1781198628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rB/IXV+OMc2A+R0X4txGzVE+20Yu2JeN9gbqIkZf1A=;
        b=V0KR53gQzcObax5jFXIyZuJUrzFZ7ueH91BIU7EdZ43sCHwpQ1kC7SAy9DdPP7TOWs
         qMlzEeMGVr/P99biQfvOge48/lVdZPeKtJProKYOrJdZdbJjOxJcw3rTZWfso1rVDpGf
         2nW0p2R0N/OGJ7yc1fFWrpOIacZ9OA7sx1NbAJ4AFQG66rGfN5Ur8rdb0IB3RDDHTm9I
         UiGiJop7VS6mw7TIgWMbT4xYC501MHOA6Uabw63uo/LqZGbAM8pgm3f/VoAEn33eArU8
         DMepR8b2GQleWT8kBS2mnhQAxmwYtZx4pMqhTQ47lk0xruRLrI8O6JePC3xkH4bjvVqm
         v2bA==
X-Forwarded-Encrypted: i=1; AFNElJ+s/Eejt3pTJGGU1+9H9pT8Jpghw/Ni1IhwRGcRInE4hU1CX67BT67EUSdHtySS/a8fPRm1/vtN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZR6CFJ0M1Zi5VbJzF/YVUDfzMcfILuqic/VFuWTlB/XFF65I
	CE3RL+axw32ZicSXOpUnLzO8DPmSyuFPqjjXDtydMMwl0tq9aCfLOnGJVCazHH5UYZ1aut2xkRx
	tsQfs+rXDW97VCiLwo/OjFkgTpp8mujA=
X-Gm-Gg: Acq92OH1q8L8xFGW3oiAPY+wRWeMOckSUkgq2LMEm71CLL6GT7V+nVxRNYpl4GQb6wc
	mH3P7Axz/H/X3lKEfMJ774aZPvV1RS3WNJhoa4/M7yKCz5i7TLl4r6Jtik2UrPc/NhFCNVSIXSd
	xJhS73jydU3MZpgyrDVcrIVvIPLQZ/gOQ19aEVsH8EllkFH7BNFhMgoqF8OIqOuB3xERrDNw9Vh
	ofILBQjq5b7lqeZ9xQVsT0dsYXmYxN3iAyjWDCnqW7KQuvVjEoEhrFTADyawOZG9nisqFG+It5D
	7Snq2QtwGeotkHKbVZKAq7rLlZ21Ub+aEFcl7zkmRJ6a5E0ZDQ==
X-Received: by 2002:a5d:604b:0:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-460302e6f06mr103580f8f.9.1780593827921; Thu, 04 Jun 2026
 10:23:47 -0700 (PDT)
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
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
In-Reply-To: <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 4 Jun 2026 10:23:36 -0700
X-Gm-Features: AVVi8Cflh7M61FcoQfkq5TRPiQaxI_Tappj1TjJNCo92lEJSIG0y-zr5pc0cdEk
Message-ID: <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16650-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFD1B642571

On Thu, Jun 4, 2026 at 6:06=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
>
>
>
> On 2026/6/4 13:34, Yosry Ahmed wrote:
> >>>> For instance, suppose a parent memcg has two children, memcg1 and me=
mcg2,
> >>>> each with 200MB of zswap (100MB inactive). Triggering proactive writ=
eback on
> >>>> the parent memcg will exhaust memcg1's inactive zswap pages. After t=
hat,
> >>>> even though memcg2 still has plenty of inactive zswap pages, it will
> >>>> continue to write back memcg1's active zswap pages. Writing back act=
ive
> >>>> zswap pages causes the user-space agent to prematurely abort the wri=
teback
> >>>> because it detects that certain memcg metrics have exceeded predefin=
ed
> >>>> thresholds.
> >>>
> >>> This will only happen if the reclaim size is smaller than the batch
> >>> size, right? Otherwise the kernel should reclaim more or less equally
> >>> from both memcgs?
> >>>
> >>
> >> I gave it some thought. Not using a cursor could lead to unfairness
> >> issues with certain writeback sizes:
> >>
> >>    - If the writeback size is an odd multiple of WB_BATCH (e.g.,
> >> triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the
> >> writeback ratio might end up being 2:1.
> >>    - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is
> >> triggered, it might repeatedly write back from only the first 2 child
> >> cgroups.
> >>
> >> Although setting a smaller WB_BATCH might mitigate this unfairness, it
> >> could hurt writeback efficiency. Let's just use per-memcg cursors to
> >> completely fix these corner cases.
> >
> > Exactly, the batch size should be small enough that any unfairness is
> > not a problem. I would honestly just do batching without a per-memcg
> > cursor, unless we have numbers to prove that the efficiency is
> > affected when we use a small batch size. Let's only introduce
> > complexity when needed please.

I'm impartial towards the complexity of per-memcg cursor. I don't
think it's that big of a deal, but only if it's warranted.

Hao, if you're convinced that doing small batch is not efficient,
could you run some experiments to show the improvement bigger batchign
and fairness? Maybe implement a small batch, no-memcg cursor first.
Then implement a patch on top of it to add per-memcg cursor, and show
how much performance win we can get from that patch on top of the
patch series?

FWIW, zswap writeback right now is not that batch-efficient :) There
is no IO batching, or batched lock operations (we drop the lock
whenever we attempt to writeback a page), etc. Might be a good avenue
to optimize.


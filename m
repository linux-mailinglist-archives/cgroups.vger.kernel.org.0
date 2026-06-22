Return-Path: <cgroups+bounces-17155-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y9IWMOqyOWrrwQcAu9opvQ
	(envelope-from <cgroups+bounces-17155-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:10:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639776B2945
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:10:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L42WL6BK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17155-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17155-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F353012C4C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16737B40B;
	Mon, 22 Jun 2026 22:10:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569F379980
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 22:10:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166242; cv=none; b=bNlDtbCdq7mARFfk5mVQGm14BJeRvQ7t7V8mqqk8y6edzzZnA1DQ9fFM+Ef0lnuiPcU0YOii8aQJQNlGUlVsOrofpS9S5A8aJed11FR7ppeX9aDxEjj7sw5/GILJCzQPQ0A8VHG9rjL9JnbpjYBJvQvSsm+IijTUvm2oxV3Ml+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166242; c=relaxed/simple;
	bh=PX27CGIChTktajqQRqdehsvfssAJs/ydFa86KHvUuzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYr3iQIM58G5CsJ3c5MkXT78DsE/CqXyctF7NV/aNYREjayuqvddm1qBIxl2sry5qpkd7KF1KbbyWj1A3MR0mlZmeTcTwJ8TQ8IMNIkMb1ZNr5T7GF4EnFjtyJ/7rwLbl40pCsL7r3QOYmTJmaygdpF5hVGQlqBoOov5+DqDlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L42WL6BK; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a0eb989530so1203961eaf.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782166239; x=1782771039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lWcRJ9xv3vj+kuUslXqTMu2ZS1PDN9hlN/ZqmuvJzU=;
        b=L42WL6BKh/4Ouo6mVBE+q0FXy32aKOMBm2W9GqLrNtjrUgJgD7fOSbQd1W4VBBGbiS
         HOfNPGt83JHLSau6DbQRQ72uq2vfSxzeEzJOetnXKNbNNKwl44rVgRuIRQq3uIdru3vE
         BW3ywQy0nq7hn8mdiVmT9oxH6q31n1eEo5BzE1K9nwuOvfkTtfECdp4riuduJkh6Dd42
         0/UScIbelH/UX0ajgGV1XjzbnBVSRw+RiyyAzyYZ/beVx3gSW3ZcwzjAN7zEFHBnoTwB
         GXk3plMLm6zP9GGAk05JFmtaoH8UcC5iRJZVmuLICKv09jNtlhZyN3Iuc6iv84vLcHYC
         sbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166239; x=1782771039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lWcRJ9xv3vj+kuUslXqTMu2ZS1PDN9hlN/ZqmuvJzU=;
        b=beLF8G+lM3Ps9G9QaVTVmuk/Hx8/fvrJJnCrFO+a3/3FxkqQIr+lEW/5VrUkY1SYY9
         bHNYz8upaqlBJZorf0sa4Lns55UgSjx/eSwSHNU6eUeeBn6SE4oyvJEirbSrZ9qlinl/
         UkvXcz2elIgwJpucqsD87rxCRdPRKMBdupA6FmIvRd//rwSWqefMtatVmkinYxFk5GbT
         SHZLCqkp11HFQYjLS90iNfjhkLBJnoD0ms2kzajjjPJLHQO1YUWy8Cg+yuLtW26tHTr9
         NJriCmzZNdzEvkJR0Z9kVU2UrLemO6lTeWfmfs9FdBEL2cyPZt7s1gZQ2hZYsTF/l+4D
         IFXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7Lsnx7zi/rFEnB5OaLznUigRZKgQVjPnwLW/63JrT5uJHMilDtg9W3AfMKGjUBKbsyDJeNV/O@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBpSnn5YnDCGGi8IdJcrQV1Dk67/zMCemRWAM4gVSkLBSc2LQ
	OI9vabTDiNEoxUDG2HGIP+R5tkqd0QO0n4KOVpW4iY5k9Fm2DufowR47
X-Gm-Gg: AfdE7cnGY4cgfXAxhhUaRpnZQCtBypjzD6WxiFQhHP34Mqs3BlDcebwVnP5UmMCHl3u
	EbCbcZ1psYAG8qukBUYjMCLq/nFp2zdp35X8jWlEfai7h+l/rc/z8IadEDKSMToYM5M1RW8zzyo
	suw+Dt7NrgGXwUd4Xxre/Dh0Yl80BOcro/RwK4z//XtB7nznZAHVdVdXDrJCZg6HGmJPCZ/5iGz
	1VESY3kRYdMDZEYtLOnUMSutA9HQspO4h3R3YKC4TnbkuZ286E04DnBg3DIaWhTFbU621BVMeGl
	11nI6IYSs496Zda88LZxDSJpLNrZ8DoPsN3QPFKjNrhCc7XBCsJ7qpp8VUPL0hvw1XNmNJCSGVW
	oGhI2rJwYJbSz2vqMvGzUL79n4KgqOQ+IS5nFZEWK02EUUssxYo2a+3u0nFtmU4lM17plF99Gzw
	2P18cU++GbaHEDzy8PhCAIACji9tT0kUn6mgPqhBF0nOv52nZ6rSx2VQ==
X-Received: by 2002:a05:6820:c85:b0:6a0:f323:e967 with SMTP id 006d021491bc7-6a0f323ea6fmr9372385eaf.55.1782166239358;
        Mon, 22 Jun 2026 15:10:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f77720sm5727019eaf.6.2026.06.22.15.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:10:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Youngjun Park <her0gyugyu@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
Date: Mon, 22 Jun 2026 15:10:34 -0700
Message-ID: <20260622221037.255359-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO9r8zNjyW1rh26vv2vavCM_2-r70EuynU+-7XdEmrBdLL=TkQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17155-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639776B2945

On Mon, 22 Jun 2026 14:21:30 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Sat, Jun 20, 2026 at 11:17 AM Youngjun Park <her0gyugyu@gmail.com> wrote:
> >
> > Introduce memory.swap.tiers.max, a flat-keyed file listing each
> > tier defined in /sys/kernel/mm/swap/tiers with its state, "max"
> > (allowed, the default) or "0" (disabled).  A tier is one bit in the
> > cgroup's tier mask, so writing "<tier> max" or "<tier> 0" sets or
> > clears that bit.
> >
> > Since the current use case lacks amount control, it only supports
> > "max" (on) and "0" (off). Therefore, it does not track per-tier swap
> > usage, relying instead on a fast runtime bitmask check.
> >
> > We maintain both `mask` and `effective_mask`. The `effective_mask` is
> > strictly bounded by the parent (e.g., if a parent is "0", the child's
> > effective state is "0" even if its `mask` is "max"). Maintaining this
> > separately avoids costly cgroup tree traversals to check ancestors at
> > runtime.
> >
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  20 +++++
> >  Documentation/mm/swap-tier.rst          |   9 +++
> >  include/linux/memcontrol.h              |   5 ++
> >  mm/memcontrol.c                         |  67 ++++++++++++++++
> >  mm/swap_state.c                         |   5 +-
> >  mm/swap_tier.c                          | 102 +++++++++++++++++++++++-
> >  mm/swap_tier.h                          |  57 +++++++++++--
> >  7 files changed, 255 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 6efd0095ed99..4843ffcfd110 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1850,6 +1850,26 @@ The following nested keys are defined.
> >         Swap usage hard limit.  If a cgroup's swap usage reaches this
> >         limit, anonymous memory of the cgroup will not be swapped out.
> >
> > +  memory.swap.tiers.max
> > +       A read-write flat-keyed file which exists on non-root
> > +       cgroups.  The default is "max" for every tier.

Hi Yosry,

Sorry, I feel like I'm joining the party late. Apologies if I'm missing
some context or repeating a discussion that's already been had.
Please let me know if that is the case.

One quick tangent:
I was chatting with Nhat last week about swap tiers and its relation to
memory tiering. Nhat brought up a good point, which is that while both
swap tiers and memory tiers provide a clear hierarchy of performance,
only memory tiering allows for movement between the tiers.
AFAICT, swap tiering does not allow for direct migration from a higher
tier swap backend to a lower tier swap backend if the higher tier
backend runs out of memory.

In that sense, I'm not entirely sure if we need to enforce similar
semantics across swap tiering and memory tiering; it seems like there
are some fundamental differences anyways to how we treat these tiers.

> I wonder what should the default behavior be if memory.swap.max is set
> to a value other than "max". Should the limits in
> memory.swap.tiers.max auto-scale or remain as "max"? We probably want
> to keep the behavior consistent with memory tiering.
> 
> Shakeel/Joshua, WDYT?

I think that the motivation behind these tiers is different for swap
and memory. Tiered memory limits is motivated by preventing one
workload from conusming all of a valuable resource, while swap tiers
seems more to do with excluding certain workloads from using performant
tiers and ensuring other workloads stay on those performant tiers.

IOW memory tiers exist for fairness, but it seems like swap tiers exist
for workload performance tiering. But maybe there's a usecase out there
that would want fairness to apply in the swap tiers as well that I am
not seeing.

If that is the case, I think auto-scaling makes sense but can be a bit
tricky, since there is no universal tiered ratio; each workload will
have different tiers it can swap to, so they will all have to calculate
their own ratios. Tiered memory limits escapes this difficulty since we
assume all memory can be placed on all tiers, so we have a system-wide
ratio : -)

Let me know what you think! Have a great day :D
Joshua


Return-Path: <cgroups+bounces-17159-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tq0PKBzDOWpyxAcAu9opvQ
	(envelope-from <cgroups+bounces-17159-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:19:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041506B2CD8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=n0hNcIjU;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17159-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17159-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17BE30242BE
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DA363C7F;
	Mon, 22 Jun 2026 23:19:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D43EEB3
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 23:19:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170393; cv=none; b=C0Qy+7+DLRwJbg41/ZF/bgQvwEkck94AjGIUdSZ7IbhpIVn/C+3jm+ExA3GIdwvsp7IQnskW3ZP4CsYl5ENWm0oRnbk5Zor4R2NKzq34JI/jsCmSsBsdTGWlEoAR5qr9gCew12rK73rWtFZKTRW7ms1sQE8hbqLtra6VOm/hT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170393; c=relaxed/simple;
	bh=Xlw43IzFtb/tFwtGy/6ziKdecpraNqKX+Avh7kTsw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onNIXyQZ0MfkfVx2n0li7msE7g5GHIraapCPWGQ10fKa/0/F1lSJ1zPFc9SYFgqSfYIY8odD1PY2N4aYSyrj62VYcr1nXAZuPFD/JhKPsfcOsd4R0NF+fYnqcbJfyI/IysAk8GBWSoNDWxsFymYY/NZZWvJvOvEglK/o9IdOn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0hNcIjU; arc=none smtp.client-ip=209.85.167.177
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-487167d083bso2826033b6e.3
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782170391; x=1782775191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoK1Vry3ZA37o4N+PhVs+8t5kaUWOE3Fz+zyZS4k++4=;
        b=n0hNcIjU1B55QsN2INYUU7h1Y+BbVdsDyRdvYFudarhNRBsY2Gno2bUBL5DCg2pvK8
         MaBkfb1iz7C0SrJzb6wzTW/olUT6ME972o7uRzf9jILlPdz41Op327vrpYzRdCTg5VkE
         4mUk9v8XzfJwCW6zqo/PNuDIiLChBGQeuxQlBVUURVd1EtzoeWOmRNDVAfSJMW6ufrIx
         QS2PXQCUod7gjbJd2A2epe+s5fzOk1g9N5fRBL8nvCPNKGe1hrRG986VEg2H8L9mBRqT
         6KXpzRVyJfu1rKvODrRZbrrZVjZxreAGXeZI5LILKsEQOAEW6CN/01Qqtbly9rZ4Ls0U
         qAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170391; x=1782775191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoK1Vry3ZA37o4N+PhVs+8t5kaUWOE3Fz+zyZS4k++4=;
        b=eHP8UqywJhXpLpy7cCpKgPtDAd9vti5wXcLwCUSQ6/IP+Euz63wuAfQFrDsfpTH7mC
         WfV7trLmRlabGoVc6Oy4OaKQ14xZkrloQm70ZWHIcdyEamLbaOHQROrx/AqQzNcy3k8c
         MNfkeaxl4zXWLptg8a0Gijgtik40Xet+xT9ugcTAXgJxvmDuJFiws596hfEzuRuHuKTq
         bWbD3d77LMdsaYHD4+C/6l9q3mZDgY+eZuTfSJPupVAQExL5zBAHA5cMF3t+9RdlZ5pQ
         hXcjt8uiDYpONcIeE+D6VCeB3geyOAYPmhXFFYsyZAKeHYS+idDevSuVHpXuhhSGRT9Y
         mDiA==
X-Forwarded-Encrypted: i=1; AFNElJ/Lpy40Vei1dtA9REB7kUybWO33NLBRzfHHHAcOklHzBkXIH2SKfzEWO4qmTsiNcCB6ud2PjCft@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkP7xGuhif/zJt/9dWZmY7IE1XTey3Utn7jgGhKRMU9vDR/f9
	ZrvQqq5P/bMUnWotUOOg7bwPbKbiVMJw9j+0PtY7+8YARolrii8SJz8g
X-Gm-Gg: AfdE7cmu1pkAKsCYq7vXS+JxTN804tOI/WhXCO74hIRe/mcpb+MTODO5odFEVMsJGR/
	rVqOEG4un4OfmTJwx/9Xwobq2KDwlFiC6vO5oq9o/eAUX/2qiVi1JsI7Z3enTCIFUbim2MXd+2a
	5XBkhGmDuP9uqbR1MRDb5n1T5yhq9/RaICn5vUGPN3O7EK+Maioj2PumKXNoSl4oReAgLzLQdHF
	EtjiXzm3+cKiEWj9BLfLb7r8v48AeZBzJPlF6VG8ICL2pnGZsb2UqtGn0SlCvxFdIwzuV0oHZKn
	4hX/YAhpYugpDQqdqBZ9uxnv+fmdiIsm3tBoqy0Mj3Y29+FbZksws5wyQ3T35dr5LRP8aUkix8D
	c+9xqxOGcY5pPet6Erc8/igrRL3d7pHjbUtw+9qOvZ9lecU69weMh3t6mcJ5pmszK8HkuXDIBas
	jcKrfD872eFFkaEbe00h8H+uLEPPDXm+V9Zizhqg4eGg==
X-Received: by 2002:a05:6808:191c:b0:487:4c11:7a17 with SMTP id 5614622812f47-4896acb178emr14254437b6e.36.1782170390846;
        Mon, 22 Jun 2026 16:19:50 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0e5e53sm5453907b6e.8.2026.06.22.16.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:19:50 -0700 (PDT)
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
Date: Mon, 22 Jun 2026 16:19:47 -0700
Message-ID: <20260622231948.1002174-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO9r8zP6zDshSGU4chaHiPocahQZpiK5Z-eP9VKH+2_xjNM+4g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17159-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lge.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 041506B2CD8

On Mon, 22 Jun 2026 15:26:17 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Mon, Jun 22, 2026 at 3:10 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Mon, 22 Jun 2026 14:21:30 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > > On Sat, Jun 20, 2026 at 11:17 AM Youngjun Park <her0gyugyu@gmail.com> wrote:
> > > >
> > > > Introduce memory.swap.tiers.max, a flat-keyed file listing each
> > > > tier defined in /sys/kernel/mm/swap/tiers with its state, "max"
> > > > (allowed, the default) or "0" (disabled).  A tier is one bit in the
> > > > cgroup's tier mask, so writing "<tier> max" or "<tier> 0" sets or
> > > > clears that bit.
> > > >
> > > > Since the current use case lacks amount control, it only supports
> > > > "max" (on) and "0" (off). Therefore, it does not track per-tier swap
> > > > usage, relying instead on a fast runtime bitmask check.
> > > >
> > > > We maintain both `mask` and `effective_mask`. The `effective_mask` is
> > > > strictly bounded by the parent (e.g., if a parent is "0", the child's
> > > > effective state is "0" even if its `mask` is "max"). Maintaining this
> > > > separately avoids costly cgroup tree traversals to check ancestors at
> > > > runtime.
> > > >
> > > > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst |  20 +++++
> > > >  Documentation/mm/swap-tier.rst          |   9 +++
> > > >  include/linux/memcontrol.h              |   5 ++
> > > >  mm/memcontrol.c                         |  67 ++++++++++++++++
> > > >  mm/swap_state.c                         |   5 +-
> > > >  mm/swap_tier.c                          | 102 +++++++++++++++++++++++-
> > > >  mm/swap_tier.h                          |  57 +++++++++++--
> > > >  7 files changed, 255 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > index 6efd0095ed99..4843ffcfd110 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1850,6 +1850,26 @@ The following nested keys are defined.
> > > >         Swap usage hard limit.  If a cgroup's swap usage reaches this
> > > >         limit, anonymous memory of the cgroup will not be swapped out.
> > > >
> > > > +  memory.swap.tiers.max
> > > > +       A read-write flat-keyed file which exists on non-root
> > > > +       cgroups.  The default is "max" for every tier.
> >
> > Hi Yosry,
> >
> > Sorry, I feel like I'm joining the party late. Apologies if I'm missing
> > some context or repeating a discussion that's already been had.
> > Please let me know if that is the case.
> >
> > One quick tangent:
> > I was chatting with Nhat last week about swap tiers and its relation to
> > memory tiering. Nhat brought up a good point, which is that while both
> > swap tiers and memory tiers provide a clear hierarchy of performance,
> > only memory tiering allows for movement between the tiers.
> > AFAICT, swap tiering does not allow for direct migration from a higher
> > tier swap backend to a lower tier swap backend if the higher tier
> > backend runs out of memory.
> >
> > In that sense, I'm not entirely sure if we need to enforce similar
> > semantics across swap tiering and memory tiering; it seems like there
> > are some fundamental differences anyways to how we treat these tiers.
> >
> > > I wonder what should the default behavior be if memory.swap.max is set
> > > to a value other than "max". Should the limits in
> > > memory.swap.tiers.max auto-scale or remain as "max"? We probably want
> > > to keep the behavior consistent with memory tiering.
> > >
> > > Shakeel/Joshua, WDYT?
> >
> > I think that the motivation behind these tiers is different for swap
> > and memory. Tiered memory limits is motivated by preventing one
> > workload from conusming all of a valuable resource, while swap tiers
> > seems more to do with excluding certain workloads from using performant
> > tiers and ensuring other workloads stay on those performant tiers.
> >
> > IOW memory tiers exist for fairness, but it seems like swap tiers exist
> > for workload performance tiering. But maybe there's a usecase out there
> > that would want fairness to apply in the swap tiers as well that I am
> > not seeing.
> 
> I am not sure what use cases exist, but I think it's possible we end
> up wanting to enforce fairness for swap tiers as well. Maybe not as
> aggressively as memory (e.g. to avoid wearing out SSDs), but maybe at
> least proactively through userspace?
> 
> At the end of the day, faster swap tiers are also valuable resources
> that we probably don't want a few workloads to hog. I also think the
> interfaces being consistent makes everyone's lives easier, even if
> it's a bit of an overkill for swap tiers.

I see, thank you for the explanation. That makes sense to me.

> > If that is the case, I think auto-scaling makes sense but can be a bit
> > tricky, since there is no universal tiered ratio; each workload will
> > have different tiers it can swap to, so they will all have to calculate
> > their own ratios. Tiered memory limits escapes this difficulty since we
> > assume all memory can be placed on all tiers, so we have a system-wide
> > ratio : -)
> 
> Hmm I don't follow. It's also possible (maybe not initially) that a
> memcg cannot use specific memory tiers, right? I am not sure what the
> difference is.

You're right, I was speaking more to the current state of memory tiers.
The majority of the feedack I received was that we already have too
many memcg knobs, so I just opted to make tiered memcg limits a
cgroup mount, with no ability for individual memcgs to tune their
limits or opt-in/out.

What do you think Yosry? Would it make sense for us to be able to 
tune these values? Personally I think it makes sense but just wanted to
make the basic features merged before I went to push for making those
knobs tunable.

If we want to make the tuning the same across swap & memory we should
probably align on the file names and how we interact with them.

Thanks,
Joshua


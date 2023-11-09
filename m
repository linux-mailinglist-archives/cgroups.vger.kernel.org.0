Return-Path: <cgroups+bounces-266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED457E63F7
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 07:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5751C209A6
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7E111C;
	Thu,  9 Nov 2023 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEun+iTg"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDD2582
	for <cgroups@vger.kernel.org>; Thu,  9 Nov 2023 06:37:13 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9612685
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 22:37:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc411be7e5so87135ad.1
        for <cgroups@vger.kernel.org>; Wed, 08 Nov 2023 22:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699511832; x=1700116632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxlrRZY9oH7YHuU4myXTI016nFwsBkve7ko66/h6F4c=;
        b=FEun+iTg+aPhq00WNs+fy/AufwquLcEvG4NReso7nxcKa0tT2FFsLALuQedotDO5zO
         6O3As/Xdpfp+nb3Pw0Ja63Z+IvKTBTMtTfmvE2lhgwM06mMTqi8x02tlFJV2yV1nwLqw
         CFZQQxDkrLYkEQKAXfaoJTSyeVGGGekcy06PVWmYKFwiqo07k8KhivonMZIevh5YS8JK
         Yz7civ+ja9OZqDB73rbXuDuiQvAAvBfgwBRn5koUSXQT0+/VBhF1vgHbr7dVikHOqc/u
         qocu+404N7wcYO5WUlg9noz1ZJfu2xcFo+jACVmNIT5HYkBM2b6iR8be/Ld27V+TmP6p
         ltIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511832; x=1700116632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxlrRZY9oH7YHuU4myXTI016nFwsBkve7ko66/h6F4c=;
        b=pEdfN2U525eCLXn64GMGICz46StYj21YwkBlyHgvBuIn5GxGSEuGfXHltDGoIegswC
         IKL3WBL24TLWDlQdrhPvD9I2E8xP8FNVNQ7PEBXiWkuwz6RW8BCS96jlO7IjwToEv7S9
         KGwUROJz0W6JxL6As3ALKqxi/dmYNe/QNA2Diaw/xmWEAvdpduORpf2lorf5Rdv5J8Ml
         zam7TY6dxWk5SRXn3zzoG4+RrWTRcCE6yD1iygcTi2ApKCjTfcDza6ofholm542HMdnd
         W1m4TFMp66uMU3Hq/2JiIyAggkJOZsk6oj8FNSwm1/gWww56K3Ur3Chr4uL5YtC+M/JY
         0/Tw==
X-Gm-Message-State: AOJu0YykMXbeXkJz2x89BRyMm1AnKVgjnWO1QwfaKU7gVxmqHgTvJDuc
	O5qvAzRDzFVFHOq7MCx4Jcpbsi/SgopQT5Q0zyVaHg==
X-Google-Smtp-Source: AGHT+IGGYvUujjdjMkJajUdyu44vBZUqjUps1Ija86z4tiQSb6gKgfA25DLHsrWcPvImiBqHroYNmzmTf5CnUUtxbEE=
X-Received: by 2002:a17:902:c146:b0:1cc:4624:48e with SMTP id
 6-20020a170902c14600b001cc4624048emr162419plj.24.1699511832355; Wed, 08 Nov
 2023 22:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org> <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car> <t4vlvq3f5owdqr76ut3f5yk35jwyy76pvq4ji7zze5aimgh3uu@c2b5mmr4eytv>
In-Reply-To: <t4vlvq3f5owdqr76ut3f5yk35jwyy76pvq4ji7zze5aimgh3uu@c2b5mmr4eytv>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 8 Nov 2023 22:37:00 -0800
Message-ID: <CALvZod4yTfqk9u6AmTyk9HZyGQOh0GTLLN6f0gHWy3WNKCm-vw@mail.gmail.com>
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was Re:
 folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
To: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Christoph Lameter <cl@linux.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:33=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 07-11-23 10:05:24, Roman Gushchin wrote:
> > On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > > Right.. Well lets add the cgoup folks to this.
> >
> > Hello!
> >
> > I think it's the best thing we can do now. Thoughts?
> >
> > >From 5ed3e88f4f052b6ce8dbec0545dfc80eb7534a1a Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Date: Tue, 7 Nov 2023 09:18:02 -0800
> > Subject: [PATCH] mm: kmem: drop __GFP_NOFAIL when allocating objcg vect=
ors
> >
> > Objcg vectors attached to slab pages to store slab object ownership
> > information are allocated using gfp flags for the original slab
> > allocation. Depending on slab page order and the size of slab objects,
> > objcg vector can take several pages.
> >
> > If the original allocation was done with the __GFP_NOFAIL flag, it
> > triggered a warning in the page allocation code. Indeed, order > 1
> > pages should not been allocated with the __GFP_NOFAIL flag.
> >
> > Fix this by simple dropping the __GFP_NOFAIL flag when allocating
> > the objcg vector. It effectively allows to skip the accounting of a
> > single slab object under a heavy memory pressure.
>
> It would be really good to describe what happens if the memcg metadata
> allocation fails. AFAICS both callers of memcg_alloc_slab_cgroups -
> memcg_slab_post_alloc_hook and account_slab will simply skip the
> accounting which is rather curious but probably tolerable (does this
> allow to runaway from memcg limits). If that is intended then it should
> be documented so that new users do not get it wrong. We do not want to
> error ever propagate down to the allocator caller which doesn't expect
> it.

The memcg metadata allocation failure is a situation kind of similar
to how we used to have per-memcg kmem caches for accounting slab
memory. The first allocation from a memcg triggers kmem cache creation
and lets the allocation pass through.

>
> Btw. if the large allocation is really necessary, which hasn't been
> explained so far AFAIK, would vmalloc fallback be an option?
>

For this specific scenario, large allocation is kind of unexpected,
like a large (multi-order) slab having tiny objects. Roman, do you
know the slab settings where this failure occurs?

Anyways, I think kvmalloc is a better option. Most of the time we
should have order 0 allocation here and for weird settings we fallback
to vmalloc.


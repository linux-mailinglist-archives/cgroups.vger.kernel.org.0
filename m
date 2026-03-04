Return-Path: <cgroups+bounces-14607-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLUuEqRfqGmduAAAu9opvQ
	(envelope-from <cgroups+bounces-14607-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:36:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 007582046CC
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4647430FBAAB
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8636654B;
	Wed,  4 Mar 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqnYuybe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DC35DA56
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641695; cv=pass; b=CI7V/9xX70mtfJ5NZwolM1o433anmiCCV2RmvpcRSIZ5if3f2VqMKdIHZtgIpa11GSJamZaVZK+diAWfZ0UP7sT7s58UDHuxTqRn25XlDPfZ3TEefXHjkSwauKBPW1a4YEGBOiyvTl8k6zualXNXvJQ4CU8jWvtZj18/dUTYndc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641695; c=relaxed/simple;
	bh=yJ0ynbJ6r8EFydCJQWsGo3GZPmA/7FuKz++4nRErQew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+PdPRBJR1xVo6i6mQQG8/zzJ0doKbhXNHMUSDCAyUHpZcQAeceV73/yRup3WzxwSwOepT26wCb8W7dN9BouDt8oWSqNacdhwSKXiPloi78UvaouTWcmkfZuc05cygeMuVimjptVe4QFR8/stX+lvhQ8wxHbD5nG/klSmkV/340=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqnYuybe; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b2965d4bso3458547f8f.2
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 08:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772641692; cv=none;
        d=google.com; s=arc-20240605;
        b=cSHYGHGCOp/JCQN27MTCxBt9gFgXfCWNOWRoVtyvhBN1soUJXvl5Lnxt6zJ2zenRwj
         /eC87acInirDSRzMRmMwZXGhHijOzERs7w36u2aK4PJ+BOEZxy7ucpI/f9o45c73ufmv
         zBR6uYvVO/4IbPAsFUKCvLHILuhtfv5kyDML4hFEt5fpxeb/iMM/HeYBCVwLKTYhm5SB
         u36iu7xL5O0vr0RO1Mgm81Ua3bEy9XTMcdeKixqr2saRb7SLYgKAsFRNyAZ3FceId+VT
         exK3YSHYsMopjCN7dPDBUAlpJ2eZ1P3yGVUSpmyfR8AvlY4SrGDDzoCKAoyno1/uMI+9
         yQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdrH1d30bQdn/vAx3ufQokRMQ3BuuJO2abIxKj8RN5w=;
        fh=Rnazs2UOxTWZ1MJRl9S3XEW8cJ1tskyCCEyJb6CZ29E=;
        b=fR51sD+y2omD0fboKI1r1gQNKjlRe44j0N0D2FNKNQf+WH35DF1wbYlYdZwNI48wq/
         r6PvGxuxriZEF0ZEmUyE4nLgBiIE/9H9yPU4HODCWlFixKzVmcDAuIwziTkuQiDUqUc6
         iaCciTSWT354hDeNzTAZ0KO9oe4E1xY6gPZZXa8+c5EzBBytYoTTMTQmnedmRRR6NaAa
         v4wJ/K/UG2dXDrbjFcjlD1tXcDUo3G90XZw52/2fhHhJeILLrm3GgE2WKgcuifg4FV2J
         hKGaDy5QGMaP88T8wpLrr3LnrNKsDG9U5bBZ0TwZuX5GBhwASSQpoeulhhervU+sCCB6
         q5cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772641692; x=1773246492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdrH1d30bQdn/vAx3ufQokRMQ3BuuJO2abIxKj8RN5w=;
        b=gqnYuybeD6Gfv3m9AWmVGrHdv+TvsaiHdih2iTytdLF/ToaIw/AICCfKvvORSPfJKW
         bmt7qZkQi1GyjWgZpIaKF/CvXZpI0nYuQgiexhqT3xW0hprOhPUsy89aNy11azCGmEDC
         cF/g9eBZBUzfYJEXxERF29KzDGMsfe4FGSq7fKrHXReQ3K031fuaUmkCLboOoktTtgtK
         tRBI/5lU7Ibs1AZvnn8p+/je9DJ1YCm+OKQnMMmZD21yETYNLlexHMh4WZZMxIok8PYT
         C2VMvD1sfw4rHAU/6eaMrm0Zcct4qgubCHci1oAqCzU8kYE5m4LHC6Ab94FweJxKaoWz
         b+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641692; x=1773246492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdrH1d30bQdn/vAx3ufQokRMQ3BuuJO2abIxKj8RN5w=;
        b=NtG1Bc7UeHw1pWorzHEv0Xp8XWH50Q+OoHZRtLVyyvFDvTSvEtaOOOE+lnr37HuhwX
         2DAiEam5iC84IA6t5gzMz516NScU5nbjdRLV3lMoR2lhBQbCQhfKa8pNUcg1UDcla932
         X4udEIUIndBTMTwgfp6Bec8gXgudTiHj0iorWYXgxHbqP6HNiXehosdrnn15lKStP1Bu
         3HtbiNDTE6C+z6toGx+/NyDvFs9CXvy0ET1vin4rUuEnnYdcXhFYGb1N6LQd7j3YlNQa
         9Uv1p1nOCB63mJMbUX2tJflSl1wqQmN5W3HAOkBKP4P3o+lfOoQ72FcODjUYtWoKHfeX
         aw+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFg3LsX9HZo60VzBuo8+q2e+b0v6AiM0TKgNx3DTvrRAUCcnc2dXormDzzHY3c10ScHB5DZaq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQ87R5rbXZYg/qnLIhK6xYvdfUGJ+TfzcbPp6ZSAXh2+2xj7k
	N+853+YchP46l0TKZhAHg/zFlcNDdqIFdiY4Dm3Df7Py1vOm2pbGwfY6wglTF+FaWugBXiEVnRF
	ZQiTrGlzj0BhLBAUbS3cdPQU+BY7URaw=
X-Gm-Gg: ATEYQzy6N/CeBNp8HvSN4F5vfkZx2t+eFTMxev3yA2Jb80deRVvZhvFAGw1tX3x9UC8
	SF3tPFiK6XKZ1AuUE7uhlUWDuVs1AxjnbYkvhWniInT/sxGCUCbr1GZfA0RZlY4rkugjgi/PIXF
	eE9cbuJafDMvHb/6cwRejbwahzTgcTzdQtxgquFpt6iwwtIMW6aqyU7L0TTDIIiBCv2MuZGL1jO
	/+2hhrhcG0UtxffIsJg89Sa+1zLCuZRMJCctUtMl59IyY9ct7LoEFOJWgSzayanAB87ZhZXS0tF
	0qveWNSJaoEf1FGnfa5DLJUMqfShXC2MIjdn620=
X-Received: by 2002:a05:6000:2902:b0:439:c5cf:fc68 with SMTP id
 ffacd0b85a97d-439c7f91d78mr5207728f8f.1.1772641691795; Wed, 04 Mar 2026
 08:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
 <20260304151120.3512645-1-joshua.hahnjy@gmail.com> <CAO9r8zOJ5bkJzptM7+8V2G00dHuycAEAF4CDcaR1YMk0kWyktA@mail.gmail.com>
In-Reply-To: <CAO9r8zOJ5bkJzptM7+8V2G00dHuycAEAF4CDcaR1YMk0kWyktA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 4 Mar 2026 08:27:59 -0800
X-Gm-Features: AaiRm52zyzsQi8r-nj2jrSJ8eXqkhJNQwWcx0gNagqCtRndwiPZHFx6CGeUvqPM
Message-ID: <CAKEwX=ObFWm6cKbi4hL8JLDKui3MsRu-JpEFohBdkqHFY9tVfA@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
To: Yosry Ahmed <yosry@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 007582046CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14607-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,chromium.org,cmpxchg.org,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 7:47=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> On Wed, Mar 4, 2026 at 7:11=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
> >
> > On Tue, 3 Mar 2026 15:53:31 -0800 Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > > index 067215a6ddcc..88c7cd399261 100644
> > > > --- a/mm/zsmalloc.c
> > > > +++ b/mm/zsmalloc.c
> > > > @@ -963,6 +963,44 @@ static bool alloc_zspage_objcgs(struct size_cl=
ass *class, gfp_t gfp,
> > > >         return true;
> > > >  }
> > > >
> > > > +static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgro=
up *objcg,
> > > > +                           int size, unsigned long offset)
> > > > +{
> > > > +       struct mem_cgroup *memcg;
> > > > +
> > > > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > +               return;
> > > > +
> > > > +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> > > > +
> > > > +       /* PF_MEMALLOC context, charging must succeed */
> > > > +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> > > > +               VM_WARN_ON_ONCE(1);
> > > > +
> > > > +       rcu_read_lock();
> > > > +       memcg =3D obj_cgroup_memcg(objcg);
> > > > +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> > > > +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> >
> > Hello Yosry, I hope you are doing well!
> > Thank you for your feedback : -)
> >
> > > Zsmalloc should not be updating zswap stats (e.g. in case zram starts
> > > supporting memcg charging).  How about moving the stat updates to
> > > zswap?
> >
> > Yeah... I think this was also a big point of concern for me. While read=
ing
> > the code, I was really amazed by how clean the logical divide between
> > zsmalloc and zswap / zram were, and I wanted to preserve it as much as
> > possible.
> >
> > There are a few problems, though. Probably the biggest is that migratio=
n
> > of zpdescs and compressed objects within them are invisible to zswap.
> > Of course, this is by design, but this leads to two problems.
> >
> > zswap's ignorance of compressed objects' movements across physical node=
s
> > makes it impossible to accurately charge and uncharge from the correct
> > memcg-lruvec.
> >
> > Conversely, zsmalloc's ignorance of memcg association makes it impossib=
le
> > to correctly restrict cpusets.mems during migration.
> >
> > So the clean logical divide makes a lot of sense for separating the
> > high-level cgroup association, compression, etc. from the physical
> > location of the memory and migration / zpdesc compaction, but it would
> > appear that this comes at a cost of oversimplifying the logic and missi=
ng
> > out on accurate memory charging and a unified source of truth for the
> > counters.
> >
> > The last thing I wanted to note was that I agree that zsmalloc doing
> > explicit zswap stat updates feels a bit awkward. The reason I chose to =
do
> > this right now is because when enlightening zsmalloc about the compress=
ed
> > objs' objcgs, zswap is the only one that does this memory accounting.
> > So having an objcg is a bit of a proxy to understand that the consumer
> > is zswap (as opposed to zram). Of course, if zram starts to do memcg
> > accounting as well, we'll have to start doing some other checks to
> > see if the compresed object should be accounted as zram or zswap.
> >
> > OK. That's all the defense I have for my design : -) Now for thinking
> > about other designs:
> >
> > I also explored whether it makes sense to make zsmalloc call a hook int=
o
> > zswap code during and after migrations. The problem is that there isn't
> > a good way to do the compressed object --> zswap entry lookup, and this
> > still doesn't solve the issue of zsmalloc migrating compressed objects
> > without checking whether that object can live on another node.
> >
> > Maybe one possible approach is to turn the array of objcgs into an arra=
y
> > of backpointers from compressed objects to their corresponding zswap_en=
tries?
> > One concern is that this does add 8 bytes of additional overhead per
> > zswap entry, and I'm not sure that this is acceptable. I'll keep thinki=
ng
> > on whether there's a creative way to save some memory here, though...
> >
> > Of course the other concern is what this will look like for zram users.
> > I guess it can be done similarly to what is done here, and only allocat=
e
> > the array of pointers when called in from zswap.
> >
> > Anyways, thank you for bringing this up. What do you think about the
> > options we have here? I hope that I've motivated why we want
> > per-memcg-lruvec accounting as well. Please let me know if there is any=
thing
> > I can provide additional context for : -)
>
> Thanks for the detailed elaboration.
>
> AFAICT the only zswap-specific part is the actual stat indexes, what
> if these are parameterized at the zsmalloc pool level? AFAICT zswap
> and zram will never share a pool.

TBH, if we were to start from scratch, these should be zsmalloc
counters not zswap counters. Only zsmalloc knows about the memory
placement and real memory consumption (i.e taking into account
intra-slot wasted space) - this information is abstracted away from
all of the callers. And if/when zram supports cgroup tracking, memory
used by zswap and memory used by zram is indistinguishable, no?

Anyway, Joshua, do you think this is doable? Seems promising to me,
but idk if it will be clean to implement or not.


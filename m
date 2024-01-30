Return-Path: <cgroups+bounces-1282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F23842E48
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 21:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485B81F25815
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49012762E2;
	Tue, 30 Jan 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RS1pqNAk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BE762C4
	for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648307; cv=none; b=sPcdsfLaEKbzcp365Z2QP+K83ZGAJSjUSdYyiMR8eqEQ5793OjhgFkttRFgtncJ46mgs5yA/Cc3ijsEVUCRWLc+pNBbwNXWm33FES64kzBxosY+lrTLCBkvgIGycVhjXsr8q05m9MeEluSIOQm3YnLC1xbaHr3qttQ7aNP0XBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648307; c=relaxed/simple;
	bh=QIixj73cYx88+TJmwwR9jJ+8HbVMWGwyXbuflZP21QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma3zkd2NRqNd+kX/5oTcrq2rJ9Y4+HOWFhTGnRiez8caM/EaEp9STYnCQzzprSgRT/sN33ldszq8fqbCpg84+97IQU++qzeA77CaofRjLjEyoT74vpa3AeHyA7K2VOEwUaKuJGeW0JySiUaXFPXIQD3HktKkLiIAtWJv1Q7h2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RS1pqNAk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604058c081eso2945167b3.3
        for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 12:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706648304; x=1707253104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cPbys/Y5hoKUbO/5yIH1p7bI18xQRJxP7D74jhJ/rQ=;
        b=RS1pqNAk+rmC8EMxBOHuSyPJyCQG9F38bEp3aug27DHth0Fp6DLc+kjEz45AQ0oJAy
         jGIeN+/Pkad0h+m3+8uSLxjpXp3Hn5Yus7njklHXmujnlpSSipnoj0I0gvPy52AXG051
         FviOZGwHtfA9JxF+YeLlmOdnQcaZIsj+Woqg997zN+68Atc44b7Xn/U0BOn3fwmO9anU
         rdlm2XaLVxS7h8bXO/R2aXE5J48B9RGfz9UVOb5n8F/fkr+ngl0FnQsFVM/ZW1ErpKyD
         5DVRoCBmBN/lb0HAUrFANIghkHPX2V0bnQUSZ9q3Tqh7wYWlfCU0MVM3Nt5SLz9gxkMd
         v5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648304; x=1707253104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cPbys/Y5hoKUbO/5yIH1p7bI18xQRJxP7D74jhJ/rQ=;
        b=Pta3Q1M8oGlTuu+72tC5UvDDUBmV0E1Gv4bp9HWelhHknDs2pOd2rT8AM9HaWxOZ0A
         o3qMX+vAw1COhl/iFL34YFoOpU966+rFZtDrGJjHdp1QHsESJuSyNK1C6bgPfhGgIdUb
         92rCmSfPQg0BMUMEnYRnOodosK6E5LLlkIR2MdYSb2+fgKCh7Uejla2/ZkW9eey6QoIO
         lVrWRD9lDIotMVx67NKHSRvSwqGVSKnCCm+DqS1pNn58DOFv9R4H3XMZ+2RDqix8EihA
         qyVqfoOhv+ZWwwuXaWLkn5h7lmUyi0T6PhQXHQjfz/bnpoDpJZG8es9b4WtrIj/D75dg
         mB9g==
X-Gm-Message-State: AOJu0YzM/P7y02B0giIzfm/ZeLFDSLWsggJCsAoK9gsDeAjmyGMXyhYi
	f3cQ7TeA7Sr8Rx5L2flL0djF6OCEIRb5RaetFfv4vXQ0I3a+6Ly2Z6eoCxV+CWFmDf1vd1pwkef
	wo/afWujVEofxK76bubvuEBIpnlzapUDVUUrS
X-Google-Smtp-Source: AGHT+IE2HSc4egvJdx2fjxCwain/Mb1dWxlw/tR7nJqrykL1PcU09AhpKomms3ZlsclC9yTo3KpawTUHPHE75lC+v+o=
X-Received: by 2002:a25:b206:0:b0:dc2:6496:f41d with SMTP id
 i6-20020a25b206000000b00dc26496f41dmr426963ybj.41.1706648304224; Tue, 30 Jan
 2024 12:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org> <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
 <20240126163401.GJ1567330@cmpxchg.org> <CABdmKX0pbOn+PDYQwQC=FA6gThSG0H59+ja52vAEPq80jbaWGA@mail.gmail.com>
In-Reply-To: <CABdmKX0pbOn+PDYQwQC=FA6gThSG0H59+ja52vAEPq80jbaWGA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Jan 2024 12:58:12 -0800
Message-ID: <CABdmKX3Jv1O-ppJAS-oi96Mcc6E3xsD-rwoeNU=jKU9wNDODVA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, yuzhao@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:41=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Fri, Jan 26, 2024 at 8:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Wed, Jan 24, 2024 at 09:46:23AM -0800, T.J. Mercier wrote:
> > > In the meantime, instead of a revert how about changing the batch siz=
e
> > > geometrically instead of the SWAP_CLUSTER_MAX constant:
> > >
> > >                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > > -                                       min(nr_to_reclaim -
> > > nr_reclaimed, SWAP_CLUSTER_MAX),
> > > +                                       (nr_to_reclaim - nr_reclaimed=
)/2,
> > >                                         GFP_KERNEL, reclaim_options);
> > >
> > > I think that should address the overreclaim concern (it was mentioned
> > > that the upper bound of overreclaim was 2 * request), and this should
> > > also increase the reclaim rate for root reclaim with MGLRU closer to
> > > what it was before.
> >
> > Hahaha. Would /4 work for you?
> >
> > I genuinely think the idea is worth a shot. /4 would give us a bit
> > more margin for error, since the bailout/fairness cutoffs have changed
> > back and forth over time. And it should still give you a reasonable
> > convergence on MGLRU.
> >
> > try_to_free_reclaim_pages() already does max(nr_to_reclaim,
> > SWAP_CLUSTER_MAX) which will avoid the painful final approach loops
> > the integer division would produce on its own.
> >
> > Please add a comment mentioning the compromise between the two reclaim
> > implementations though.
>
> I'll try it out and get back to you. :)

Right, so (nr_to_reclaim - nr_reclaimed)/4 looks pretty good to me:

root - full reclaim       pages/sec   time (sec)
pre-0388536ac291      :    68047        10.46
post-0388536ac291     :    13742        inf
(reclaim-reclaimed)/4 :    67352        10.51

/uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
pre-0388536ac291      :    258822       1.12            107.8
post-0388536ac291     :    105174       2.49            3.5
(reclaim-reclaimed)/4 :    233396       1.12            -7.4

/uid_0 - full reclaim     pages/sec   time (sec)
pre-0388536ac291      :    72334        7.09
post-0388536ac291     :    38105        14.45
(reclaim-reclaimed)/4 :    72914        6.96

So I'll put up a new patch.


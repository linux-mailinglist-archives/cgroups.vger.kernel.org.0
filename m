Return-Path: <cgroups+bounces-1240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB1C83DEF7
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82416B2660E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D31DA32;
	Fri, 26 Jan 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCq9PkGj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317691D69B
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287304; cv=none; b=AXxsYJC5My1aPJoMJZfNGuQYBDK+zekPXjc2GMJeLQjYcMPe9xf6PFoRbb0bCdBY5y5w8ahJw3GKPFyLHpcfwYVFx+Q+vUhOaXoeo6wXPJIFBWzUJr5Atc+DWMxqame1JTA+3JJm4PjNO2rAIXrhny3N1T7KrU7zHPuzSQlO3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287304; c=relaxed/simple;
	bh=69gsL0OazHJAPXCEVAJAYe2yesHQ1YtIkKVXb7xrT4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxF6Z49hQrs5Iv4k5MLyXOg0AWc7MEIbIEJBME+Y4vu8ETGjKpJiKfChJeh1YBsm6p/3C9CHJ/dAET74w9QxrqBL+8KmSh/IguUhB8HeYtuCQxiV0jxVfirJQJCHp0Y4oRkw/KmpFGcYEkWwhmTRgPkQcKoIE/+3xGICynmKu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCq9PkGj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc227feab99so521186276.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706287302; x=1706892102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oryyg75klGqA4c3apBpnR1ovRqyGDKB5CpwGsZyDxr4=;
        b=sCq9PkGjLR8w5mC7vzHLzZqWS1jRm5UDvlc9Zl9eqdpsIwbsxrhay84h/srCTZQkez
         YQiXDh96vMgySkEzk1A2DJS6FSmJhwC5ocsg/vutPDsDW6kj78S33CKSjc1A2pglf4Fm
         9baE4EHhTkYDEDV2TtzXs4HLPDLBRQ1c4Y0qlTq2yKZXK2N/uVuXeUuQoNvpv+ygx/Lm
         uXGBxooaSq1ecnRLW1ocdMyMc670ykM6Frp31yfq0nxWAEKwHFSHoLd8HFa6lhiapjom
         VB3NNtUFK29hYWPBbu6DeAH7H7VjPRE1nW00wvTaQc5xFByQvD0C7GqhRAWsoJlCBfBb
         vKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706287302; x=1706892102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oryyg75klGqA4c3apBpnR1ovRqyGDKB5CpwGsZyDxr4=;
        b=rnPWVqnDpdeMw/HnONTB14LMRpzzfhjG1fgaNcubt+Wq/sMfBkJj1+1NOhkWC0D1Bh
         BeXdiDfgvl3Bg+FvtfBBbqVvtIaanTrDGInUiCRIr0CnTwb5iKujyxaUkuc+h5K0gfGI
         ZcKVWh7xR1l2HtmsixKmY783Jq3u0OtvxZ+xQ2YjYANVJZx+6HhwoYIMcbFEwZ0PIjHu
         AkABpDPg0zX6xGrILu7zXjKl68g03zf47iNgPKHoGAGA34nnDt4z8zxmtP5xr4dxQthe
         Qb26P5SIopMq6aMUVS6A2wEysnmI1eZnz4cojTVF2E+3AB+5Vd5FmxWfX/aL62F2xSZS
         PYuw==
X-Gm-Message-State: AOJu0YyeT7fqLKuhcdeYyDBWk0nUGR2ouOQV9g05d/tIhsFAajJuQWzd
	Az0/K8k8xJQXmTdFJL1k4eAJ+/IeGAUHGcZIYW9YNCl+npUYXMYKHI4XXSTdNdx28Y1wILfyZeH
	l9WzcNvK6vrUHrvE45opWb589HMs61rBzn89w
X-Google-Smtp-Source: AGHT+IHlL3lRZ3693oRm2DTYAb3WlqyjvsqHux+vxRZ0MhY/FsDlrt71zkSB4qTCKBm0KEQPMczNr3AHBnKfBmpXr+s=
X-Received: by 2002:a25:ab11:0:b0:dbe:a3b0:6e4d with SMTP id
 u17-20020a25ab11000000b00dbea3b06e4dmr111085ybi.100.1706287301973; Fri, 26
 Jan 2024 08:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org> <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
 <20240126163401.GJ1567330@cmpxchg.org>
In-Reply-To: <20240126163401.GJ1567330@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 26 Jan 2024 08:41:30 -0800
Message-ID: <CABdmKX0pbOn+PDYQwQC=FA6gThSG0H59+ja52vAEPq80jbaWGA@mail.gmail.com>
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

On Fri, Jan 26, 2024 at 8:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jan 24, 2024 at 09:46:23AM -0800, T.J. Mercier wrote:
> > In the meantime, instead of a revert how about changing the batch size
> > geometrically instead of the SWAP_CLUSTER_MAX constant:
> >
> >                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > -                                       min(nr_to_reclaim -
> > nr_reclaimed, SWAP_CLUSTER_MAX),
> > +                                       (nr_to_reclaim - nr_reclaimed)/=
2,
> >                                         GFP_KERNEL, reclaim_options);
> >
> > I think that should address the overreclaim concern (it was mentioned
> > that the upper bound of overreclaim was 2 * request), and this should
> > also increase the reclaim rate for root reclaim with MGLRU closer to
> > what it was before.
>
> Hahaha. Would /4 work for you?
>
> I genuinely think the idea is worth a shot. /4 would give us a bit
> more margin for error, since the bailout/fairness cutoffs have changed
> back and forth over time. And it should still give you a reasonable
> convergence on MGLRU.
>
> try_to_free_reclaim_pages() already does max(nr_to_reclaim,
> SWAP_CLUSTER_MAX) which will avoid the painful final approach loops
> the integer division would produce on its own.
>
> Please add a comment mentioning the compromise between the two reclaim
> implementations though.

I'll try it out and get back to you. :)


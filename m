Return-Path: <cgroups+bounces-5474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D849C0EDB
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 20:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974521C21289
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7A216449;
	Thu,  7 Nov 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzvTlQ9B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A36125D6;
	Thu,  7 Nov 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007722; cv=none; b=YxVoDtcJNmFfe6wuWH4AU3xtUEBPcSrSnMNC4qUUF1MH2T2LSzRqLPDh8Jo/ttugV8oQDk1oM2dVUboRzK4LVYMRCkR1InztRRCQmvUTPgjRH/yOcA/f+H9O5z8msu3PE6ogYiviDFnuASZIgzGR71GqOX6RBZOECxma4Y187hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007722; c=relaxed/simple;
	bh=LhUW1qBK3bVsZnlMNdOmNM6+f22QnlYWMg/BBwDWV60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TocBSaJNFY48Aiyc1v1GTWYiCqDOT209Mz/FOFbwZsz7JINcLeZGRQOG11EdYCwWKbWf2IMtK9WU9EqYM9ubZbolUTUNwj7RToOaLODm8xxU6WlLe5pyFe2/5KXzLQjLcSnL7CErJiPDgGgkOD+Hzn45ZVqaGn0M6i4Mhbgdpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzvTlQ9B; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43158625112so11868555e9.3;
        Thu, 07 Nov 2024 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007719; x=1731612519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqzsUCGDO+jg/s9B70UzanNwP0hhELN8h8dHEbpK3IA=;
        b=bzvTlQ9BE8C9ctVS7mW0YKnfYUkLeEfp2szBFIZumcfjQOrUsLEhRgJwr9gmxWVByA
         xLfqZLDtClzwJqpGuT495mJ9+ZkW93c/sk5dPoQfXYvGyeoTQQa6jTl86lIIWkJ5Mw6y
         DPvNui7R/QWi8KSxYk+ReR03S9Gd6kDcexsxys73ys+PmCVlXmL0pRXojQFCtReXvDjG
         YJatBUYCqFGl2eOAkDIYN7shKXfbPT2KwKmuqTazNDjF1H5ws7PDq/htZP18LynlcLOm
         tAjiYx4PWHgsQ8+bIJaaH8e7ZzlPKihbU77zFzEdUBv/3wKWiVocFC7kSclEp61mL2No
         athA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007719; x=1731612519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqzsUCGDO+jg/s9B70UzanNwP0hhELN8h8dHEbpK3IA=;
        b=J7L+Ke12wejJzFTh5Armq+GRShm8LBST9s0sh6fsdAZCzrD3OE0e4XcrtM6ti6lH/4
         HQad7wvObeTj7qNLJO9btX6Lw4lz7laL21jd3n7B2Sb/e0DmbCmDBXnKIQMCB7xqBuAb
         96fNsank82TgtJwjjZsMiYv2DBIMWDaSqtWYDFgVN3jLxE29nQPC4lkscRiOHYJtiw80
         Yy2uh51LWEVxe9IyELncmkNWuv2+cAAOqYhpnNBjLXEhn4Qt+WRp8jdgnnewzL6v90Tg
         McS8KMV3qZQ0l479kkOxknDVGSNv/cx1CRWcasllmA26RcPWrvNMVKBaUUDh/psj7A2/
         0L3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA4ulgVk5KbiBTLdKvOY94sGmqu09BoeA3ziN7KuwrWkkU2GS7OwAcbIRAXtkVrN7rNfKYctkS7KQo0HFL@vger.kernel.org, AJvYcCVgBNMwaUcSBjIzQvV/vfBt8MRL/477HhHNw/iKFhCkpeUTAE8oAniP1NiDGrG9B8yYecdSnlw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkQ2Ht+Pw/4Nl1zVKo+Jjq3pyd1OSQLMJNBszgBFY/xMWVlQA
	FDsS2FOCVPW0FEk53tV3OdjpqRqmttsA31kVcfCWfgI+QtbcWNfvstYZjfOsUxvbUtCrwZ91gJt
	iBMC0zom8wEqQfA38jxZNhQ0YFxQ=
X-Google-Smtp-Source: AGHT+IHvz4PUBjFI5RZsML4byKhmEa850ScdyNzRykPiHerz1pgz+in3a3wL6okFWf/GX+CWkoHGsVw9VWhRO8oHDcc=
X-Received: by 2002:a5d:64c5:0:b0:37d:3650:fae5 with SMTP id
 ffacd0b85a97d-381f1885e0cmr206174f8f.52.1731007718522; Thu, 07 Nov 2024
 11:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-3-joshua.hahnjy@gmail.com> <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
 <CAN+CAwNSMXP-Z5PVL_Q129nN-aP80XB0Y-Sm+C-XdHBinvWoxw@mail.gmail.com> <sb56cs5tsnuwkfkfxvp34o2rt5r4z6b5l4jukrst2htvpvb62l@axbbmg4lpf5l>
In-Reply-To: <sb56cs5tsnuwkfkfxvp34o2rt5r4z6b5l4jukrst2htvpvb62l@axbbmg4lpf5l>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 7 Nov 2024 14:28:27 -0500
Message-ID: <CAN+CAwOWCxOTaTzAgotHAQPvp4VBgaAVwwXUPfhmmsXCCR_2Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg
 try-commit-cancel charging
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:58=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Thu, Nov 07, 2024 at 01:27:53PM -0500, Joshua Hahn wrote:
> > On Wed, Nov 6, 2024 at 6:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > Please cleanup mem_cgroup_cancel_charge() and mem_cgroup_commit_charg=
e()
> > > as well as there will be no users after this patch.
> > >
> >
> > Hi Shakeel,
> >
> > Thank you for your feedback. Unfortunately, it seems like even after th=
is
> > patch removes the references from hugetlb.c, there are still some
> > references from other files.
> >
> > mem_cgroup_cancel_charge:
> >   - memcontrol-v1.c~__mem_cgroup_clear_mc(void)
>
> __mem_cgroup_clear_mc() is gone. No more reference to
> mem_cgroup_cancel_charge after your patch.

Ah I see, sorry for the confusion. I was looking at 6.12-rc6,
but I see now your "fully deprecate charge moving" patch.
I'll remove it completely in that case.

Thank you for your help!
Joshua


Return-Path: <cgroups+bounces-4316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F9953DEF
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 01:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B04E281CCB
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E0155747;
	Thu, 15 Aug 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZtND6sZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5291547FF;
	Thu, 15 Aug 2024 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764724; cv=none; b=MkJnbo3NKfzHySvEwddy+51h7+KG7PkDl+rUJEHTt7uwObWLwYR6pGyoRHykmSGCfXDbN8qG/GxsaFP4cfYBdGzcTrL9KCJjbaKSvk3V+pTuL9lVSu/18zGCT65XVXPaMf8yL8aZnEpAKc8A8+Qp9aNSZSP9QDTp14/877VgqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764724; c=relaxed/simple;
	bh=yQigOF5eQGL7Ydd8DtIlEXS/h+1Roi9GzWdfft2iRF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+3XwGs21dRSaYy1jI6XXikE2KX1LxwyczDz5fcPiHcJoC91UPNRuI+f8ELDtG+bJo+tuERjADiz2i6hKssjhzeDlqLb6n9GCPkR7TLagUmVKEMrdTCjXCSuE4tntF1/bALgNoff8aX3FWRAvb+HK94cENaZ8ZNp7xzlaDK6SA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZtND6sZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so7017276d6.1;
        Thu, 15 Aug 2024 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723764721; x=1724369521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQigOF5eQGL7Ydd8DtIlEXS/h+1Roi9GzWdfft2iRF0=;
        b=lZtND6sZ/QeF78Qy7TIHkNv+l6iVigQdRKqtL7RQ/sh/PYYGzsDhxXC+LmJ/2f086W
         aM8I86pzJXeJoF6thNQOhvuomZxAnyAG+PFzqlopdz2nogUE6+v8m8LL33UICvaMFhQe
         lg+5Q8ycPxHEcdsG2mH0vs6C7PBPnGpST7ZgV+V1TwP7opPL7cegub0gK3jxbKbDocKd
         yYw35M9KYjMVZ5h25YJiDw7VnRdcNSaZ+gWlF+DAuWuSRUo4IzdUXuhDdwvcDOftZG5s
         BI0VjWlo7l0UzcwXFACwiCgjGmzjVSmr43wtDHfu9pWGA7qQNcgPPpbt/8DkaTgjTNom
         TmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723764721; x=1724369521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQigOF5eQGL7Ydd8DtIlEXS/h+1Roi9GzWdfft2iRF0=;
        b=Iq78rhP9B0HigbH2Hmc9R2Eu7YegmOPPHKx9GlJcgkJ7MWakkUHUrkk4oc7BLQtqic
         5p5jX7cDX1n5HRRIhFdgboTngtM6zB5zf+SoFFQTjz28u6F8oqUXwFrmRHZMHq47g6Qi
         RX2gOgCHzx4Ts/CVjDwgTEf6+r1ZcHkSaiNiJ0FuRRCI0gkducAHlQn3Re/Gc2ai0iZP
         NXGhn9E2C9VkwXfkFSz/AQddaANTHL6JoycVoHqPry3nqRliKrthztaZObdEXX2bW9to
         eqakmo3qGHJBKeIAWTb/7LykN284ZFEiVeuX0zhqCx28nLOrlUrPNyxPxHSB9LGci0qX
         T20w==
X-Forwarded-Encrypted: i=1; AJvYcCVyaakwf46VR7KEBzyOAZWo9dmXRRTq2V2R4E7EDNFkKkfaPrR1g2mOxFi4PIJKhAqGBBRWz3ri09Sm5/lrHNUKFiB2rB8K+vxbyi8i82Ggq8/UR/V9HljZ/C1cbJfgxQqiXZecCQ==
X-Gm-Message-State: AOJu0YwQT0MNUDamXgQh3fYFBT6wub5HGdc/4+Af0PZC1Cycq8UMQ5z+
	sGX51WFLeTpAXBoNRxDx8I1VHKCHmYK3lrkpvQZomrfidqWBzCwvcNt8za3xe8/u6Ep4INW7SJq
	Dcaw9en7G1C7P1E4rKbpQX+5M3a4=
X-Google-Smtp-Source: AGHT+IHU6G58rVKMj+aRmyqqW7vPgGFeK5cKETFFid5YSn9XIvkoyYNQs0na099XvSqN8a5PMEzJyhX64q6lif3Ag+c=
X-Received: by 2002:a05:6214:5d01:b0:6bf:60b8:d4d7 with SMTP id
 6a1803df08f44-6bf7d545f64mr12246996d6.15.1723764721380; Thu, 15 Aug 2024
 16:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
 <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org> <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 15 Aug 2024 16:31:50 -0700
Message-ID: <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Yuan <me@yhndnzj.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 3:10=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 15, 2024 at 3:08=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > > > Yeah, I thought about the other way around and reached the same
> > > > conclusion.
> > > > And there's permission boundary in the mix too - if root disables z=
swap
> > > > writeback for its cgroup, the subcgroups, which could possibly be o=
wned
> > > > by other users, should not be able to reenable this.
> > >
> > > Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> > > doesn't affect our use case AFAICS, and the code looks solid to me,
> > > so:
> > >
> > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >
> > But you'd still like an update to Documentation/admin-guide/cgroup-v2.r=
st?
>
>
> Yeah I'd rather see a v2 with updated docs, and hopefully a selftest
> if the existing tests problem is resolved.

Ah yeah, I was thinking this could be done in a follow-up patch.

But yes, please - documentation. Preferably everything together as v2.

>
> Also, do we want a Fixes tag and to backport this so that current
> users get the new behavior ASAP?

Hmm, I wonder if it's more confusing for users to change the behavior
in older kernels.

(OTOH, if this already is what people expect, then yeah it's a good
idea to backport).


Return-Path: <cgroups+bounces-9444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755FB387FC
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4323C5E59D7
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1D2773F6;
	Wed, 27 Aug 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bs4uAocf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF457171CD
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313243; cv=none; b=oEZmydB5rhNtBAVlgGROh+7FvLtDz8p1uBC0Kx+wg1CR7bpkHCrKna2bJHdFgS4bI+ADzYqAMJOB29aX+2PA+wdLUS/UHkxfdsLIhK73mklv6FKwmcGGqYZqun7a1+/w3K7Ua1s2/fRD+x1GAcby5Oh2a1nyJEcDsdojvrQSUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313243; c=relaxed/simple;
	bh=MWmTeQR4bRkxHedYFzG0tC+FqBXa444JTd7bPbzjQuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHa4L4xNcEPBf19N5GrkfnwFp1cbuE4wksmKi49eUs7eYI9F4oVUmu/SnV25I10m0tWjOBT0Ntes5bcRrstZraI1zbaSx1yHaZYH3ARJgm0TwK9RUwB08fKppodhFGlcx5kdRx6fvzDV5wAtLm59Pm9ca8IulJ8fWt8/kWdJKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bs4uAocf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60157747so31257b3.0
        for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756313240; x=1756918040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFx44C3vvYAz2/lccGCqIrxYWdr0NAByaOrZje54PSU=;
        b=bs4uAocfeybNmAVDAHtZ+7mm1KsMP7GddPsWIP+sQFw/kmiprI8Adq83P6UbbR6XZp
         Fws4f6rf7bPJJXWmQEHzwKinlO2M3EDr9idgLxb1OdX1IuKYjwQzSJPEdKol3Q8Hirtf
         u/ZIm1TJoqaJPCboPlKkT0hgdXhbLwPV9sPfttPjJQ+Qr1oReoPGEN2/qg32wUFodTHT
         Qwc67xD04OXHqX1ylAjBf6+aeyTie0aPVLwYiFoFiPRtH4US903iBnbP+ECXuqCyh8Ld
         8FmFFbY+AzenAe+uV97ipBIcqGlweI2cW7XzcmX46MGNN0B/6Qud/eFJA5mYc7naCGf8
         M1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313240; x=1756918040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFx44C3vvYAz2/lccGCqIrxYWdr0NAByaOrZje54PSU=;
        b=uN8vl7m9+v79nA9d8djN3KlH7Mk+oBsgShMTff5lFvRT8iTwx55lpza+N5VppNd6a+
         bs7uPfOLuUT2pVorlSHFOFGi43Q9xe1iQ5QCHU4jgRWaianWCzzalAtW+MMEQxaa/gIv
         KRNzERyaySgju3+9qSGVBBHFOmVGIMeRnxOcdblKAey32xvBYR0HbDuDlIWhYDIX9n+f
         uHIseKITubXwUQZm8dRwIlKAtoDh6nLiCZXyXt/+xJQv49np5Umhka/Ro0rF2sVjE7Dw
         CoCei+q3nvjrcNR2O4zMcv7sGnZ8Y0gHjdpo4hSMSrXq4i6JNitcd/MBI4HCeHJDiHjJ
         B7dg==
X-Gm-Message-State: AOJu0YyGTPBbtDBQ2ljvkObAPrYvoksHgo7A7aRbhaRgU0Sx+Yeed5ul
	0sTicyzt/7/otwChywHxlf4o2bGsP/SUqQZ4z4pc2vK/IGhJPrMwS/oyyrggtcqcdNpWSoFg4JK
	1TqxM6UCHWAKir2tsOsPEJd4G/vO6e6V4nBR14VvhsQ==
X-Gm-Gg: ASbGncsFl4eFanKjKVxPRpuSRkuPgFGDple+kbr5tdpnS13E0e63s9cfN3rmS5JmpDV
	N0cRaC5uAkqeQ++Pb5QCCFVkwRaVaSRJUUWbKaL7fICVvSJUY5twH02yB3YC3IOu+1jX9XRm8wp
	VtQqVkPgFIgy8othaBCfeN51c7G+NQ7JAtIOHlnrZxUl/H8ly0lBE4pKn5cjon2wJqoQ/eP3KMA
	T57RNmN
X-Google-Smtp-Source: AGHT+IGIDLPPvvGPZSkU0yF1OlwVp8wo5TpW96HY5AFkJVH60zz8xFo64ZIU2PS+GFi0if9nTHq0FFg5B2nbtrfvmnY=
X-Received: by 2002:a05:690c:60c6:b0:721:3157:fe98 with SMTP id
 00721157ae682-72131580029mr85929007b3.23.1756313240178; Wed, 27 Aug 2025
 09:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826121618.3594169-1-sunjunchao@bytedance.com> <aK8xilDSEaRB3mjj@slm.duckdns.org>
In-Reply-To: <aK8xilDSEaRB3mjj@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 28 Aug 2025 00:47:09 +0800
X-Gm-Features: Ac12FXyPuppi4FaYe2QZD17lqpKjInxiPaB0BJGOE1U29q5b-AHy7UZmtW1lgyQ
Message-ID: <CAHSKhte2u+Af-_p4ezdGBk_R4f9EtHE7nzpys685kE2oOwY=Aw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 28, 2025 at 12:25=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 26, 2025 at 08:16:18PM +0800, Julian Sun wrote:
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 785173aa0739..f6dd771df369 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
> >   */
> >  #define MEMCG_CGWB_FRN_CNT   4
> >
> > +struct cgwb_frn_wq_entry {
> > +     struct wb_completion *done;
> > +     struct wait_queue_entry wq_entry;
> > +};
>
> Why not embed wb_completion in the sturct? Also, can you name it
> cgwb_frn_wait instead?

Sure, will update it in next version.
>
> >  struct memcg_cgwb_frn {
> >       u64 bdi_id;                     /* bdi->id of the foreign inode *=
/
> >       int memcg_id;                   /* memcg->css.id of foreign inode=
 */
> >       u64 at;                         /* jiffies_64 at the time of dirt=
ying */
> > -     struct wb_completion done;      /* tracks in-flight foreign write=
backs */
> > +     struct wb_completion *done;     /* tracks in-flight foreign write=
backs */
> > +     struct cgwb_frn_wq_entry *frn_wq; /* used to free resources when =
release memcg */
>
> And the field just "wait". I know wq is used as an abbreviation for waitq
> but it conflicts with workqueue and waitq / wait names seem clearer.

Reasonable. Will update it in next version.
>
> > +static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_en=
try, unsigned int mode,
> > +                                     int flags, void *key)
> > +{
> > +     struct cgwb_frn_wq_entry *frn_wq_entry =3D container_of(wq_entry,
> > +                                                     struct cgwb_frn_w=
q_entry, wq_entry);
> > +
> > +     list_del_init_careful(&wq_entry->entry);
>
> Why list_del_init_careful() instead of just list_del()?
>
> > +     kfree(frn_wq_entry->done);
> > +     kfree(frn_wq_entry);
>
> If done is embedded, this will become one free, right?

Yes, this makes it look clearer. Thank you for your review.
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>


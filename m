Return-Path: <cgroups+bounces-7021-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E295A5E522
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D9D1762DD
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44D1EC017;
	Wed, 12 Mar 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+OB2tca"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3581D5147
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810532; cv=none; b=RENX3MZo+D7zJyO8G1Qfuiucn6hBsq+YF0jaQ5vDsNLxi3xxH9Q/J/MyfHpVap/4jyw68JzrTofLmzfNkk1mRO9SNrouaZsr+EKEzGEEfy6jTkqw/9gLR9K5IRcGi7hHBWl2VFvlEHQLQ0jQlwSVN/dE6RMwYb4t4Us0Z1kW8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810532; c=relaxed/simple;
	bh=AW1UNFDZG15j41J3sF+UBm0LublPLpiYaZymjtd3AYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVVchLoIoXd/gTIw8fXi5chKuJSBaXcWbZ+L8+pL6Lujdwq2asJ3YrR5zAZo4d4Cjr2yqzSiwcg3pa1ke9ifVriVIZJMGjvzoiugmkfk79dXX6dgloWn+eZ5MsJe1pRPHbkjDvJ+COb2mkyi7EYhmbOb6uZkYJ/CYTrMda8rOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+OB2tca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
	b=I+OB2tcafrTm1EtZUBRIZsSkBqirfWVNHAF9xymnrUXHxaoGvBhm2vSiOlDI4X3eoU433m
	aFrFRROvAhK98gIB9jhswH2mKRTimmjX+B6etVt3vwZmOQoe2lE72Y5/QCFb5KH1WG5NPI
	YaGHiccqhhHvGu/wjQR4dAo/kISMZcQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-FKbcv88gPi2LKYKPMfw2PA-1; Wed, 12 Mar 2025 16:15:28 -0400
X-MC-Unique: FKbcv88gPi2LKYKPMfw2PA-1
X-Mimecast-MFC-AGG-ID: FKbcv88gPi2LKYKPMfw2PA_1741810527
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e54cb50c3baso529292276.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810527; x=1742415327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
        b=I9u437n1d7K1oIpjSxDVhzES9MRAgrkMnhc7/t9vPr4xKj2IoStPPtZJgxU3hxlRLs
         /6+q71zjcJjqcvtE7qzbTlS+Aw6adjOFdsghSh6oG53JBqG6AB+ok9+Xgw9Rv05Fm2+y
         NvGm1L4shhBqXNplzv97JbKwRXd1j4LihV1nnw6IUGOgcLakv9tUVV5E5Fw8wJFw0g1+
         TbfTftwtPgAPRlju4HmG2KoOC/TeA04+gdWDJO6MCgMDQx5s6eXEzIzepl1D79XUv8kR
         mquEB9x+BNIHrhWz3W1iuDIVe4esFPCx/Yg+u8yN+GEAM/YRXo1nu8MZ3+5nquxcztBs
         suNw==
X-Forwarded-Encrypted: i=1; AJvYcCVLY2kFQXrwcJch/+O2kLK2bdLwOyoEwf/VltIpHacxVH6U5lOnuY4j0CVCOXutIW0H7n4s8lFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1T5LHyehSlbL6sMXuLPqQrou95G4hPArLmKG/VmlHTM/j/6H
	zXpbDS4cjAcAq8MUXQSDYuMmEd2ryX/idSkZiuRCAO0fpmPAIWsJhKvpHy3E2j04Gj77KYFU5qh
	iY7j1OMXZ99kdGQIydDFewOMeAH3QcmnlZwI5TqH8sPj0nHJqI7b1+/N3ioxPyyi6EdnWrj1ARK
	rGxf73yq4qUNY8LRwgDUSALPE0RBrOu9IaQph4hs2S
X-Gm-Gg: ASbGnctpnwvNZJ2iLcc6PDByr7Jx18pgW9jQeDVKyq7Pw27thrJJ08DB5k/noHbSKnJ
	CEx9SEQNG0dFrNMPDCcOaG28kVF1jBtWbUeNgSoE3f2rjb5QXH7VI/mHCyxhpwbjGJyCyVhnJwX
	Z9G/xOvZDHFYQ=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id 3f1490d57ef6-e63dd280e5amr1426503276.6.1741810527120;
        Wed, 12 Mar 2025 13:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRjCueQJTtD1Yip12lTSRS0J2WXsza8uUs7pkqkkc4WEhTu9c6Jn8ZqT/i5u+iVlL2g8+CwS2JOOpWtSQA1o0=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id
 3f1490d57ef6-e63dd280e5amr1426459276.6.1741810526854; Wed, 12 Mar 2025
 13:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
In-Reply-To: <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:14:59 -0600
X-Gm-Features: AQ5f1Joh0g4Z83aGfjvoE-bfcrPmBotalHWvxVjzooJnUWJwOvfHN9lhNGt-h0o
Message-ID: <CAA1CXcCG6pdVaU7PGks2n3SdRjT1xxpP=yfsF3Mt-J4eCcshiw@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, david@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, 
	yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:56PM -0600, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  fs/proc/meminfo.c      | 2 ++
> >  include/linux/mmzone.h | 1 +
> >  mm/memcontrol.c        | 1 +
> >  mm/show_mem.c          | 4 +++-
> >  mm/vmstat.c            | 1 +
> >  5 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 8ba9b1472390..83be312159c9 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, vo=
id *v)
> >       show_val_kb(m, "Unaccepted:     ",
> >                   global_zone_page_state(NR_UNACCEPTED));
> >  #endif
> > +     show_val_kb(m, "Balloon:        ",
> > +                 global_node_page_state(NR_BALLOON_PAGES));
> >
> >       hugetlb_report_meminfo(m);
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 9540b41894da..71d3ff19267a 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -223,6 +223,7 @@ enum node_stat_item {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       NR_HUGETLB,
> >  #endif
> > +     NR_BALLOON_PAGES,
> >       NR_VM_NODE_STAT_ITEMS
> >  };
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4de6acb9b8ec..182b44646bfa 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1377,6 +1377,7 @@ static const struct memory_stat memory_stats[] =
=3D {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       { "hugetlb",                    NR_HUGETLB                      }=
,
> >  #endif
> > +     { "nr_balloon_pages",           NR_BALLOON_PAGES                }=
,
>
> Please remove the above counter from memcontrol.c as I don't think this
> memory is accounted towards memcg.

Fixed-- Thank you!
>



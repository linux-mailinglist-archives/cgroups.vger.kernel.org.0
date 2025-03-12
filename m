Return-Path: <cgroups+bounces-7020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6274A5E513
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E0F7A38E2
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251441EB9E1;
	Wed, 12 Mar 2025 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlpGPeub"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574771ADC6C
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810300; cv=none; b=R+PZLqKnnM3cvJLhQr4UR+3jhIYbV+u48o1ccHontez4ZnXxF4UJCrJID9iARlqIXKvcEbZEaj6E60M4hTH5AS0zKlNRANN/qhx6pzWrGxvek1NvsCS7sOWtKVpdXQPl/9KgJETrMPepQfTWzR6HcxgO4SIV21/9mNUWBYZjiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810300; c=relaxed/simple;
	bh=nUvK5QSlWouoKts1hziqxpMybmXDATURg6I3GYwAYvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tF+IqXVE/61SL1EQrBxjUOh0qUITmmhv/01CbSfyk5LfAKxob3dk74hpQE6LssQS8BAY300eqvjmdlPZTqronIyTvhYsd9qjPpJUw3S3dQF6f94kT4zAEe5qiwpUyhImZ8xOKfNCE1ZJETeXBCX3/2Oqm4lBmD7iaL+3CCpfSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlpGPeub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
	b=RlpGPeubXh2/Btu0Ntl/+N0pDf75cmtkmxzBO+JfX7L6tqqwVC1CE7FsgRIf4631OMwLQI
	tTPYuYk+sa8NVB9D3UXS58RJD/ZzrR15lR9yaCNSvW1PvVALBuwDLwihAFP3BJTMD+A5fA
	fVDVEG8wzfSgB7GBclHDtvj+rMqDPWI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-6gKK74oyOQmKvW5-ifvuTw-1; Wed, 12 Mar 2025 16:11:37 -0400
X-MC-Unique: 6gKK74oyOQmKvW5-ifvuTw-1
X-Mimecast-MFC-AGG-ID: 6gKK74oyOQmKvW5-ifvuTw_1741810296
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6fd541f4b43so2845897b3.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810296; x=1742415096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
        b=XNvKxEcE/Hngs/aZ7xhgbJkpg6SmliIM3ZeYbjNpU74RdnqcWtXTo/IL2FmWtwzzkZ
         2nocawOPkV5kGCWJ3MCLKc3Xz1H4uU2wyV3HijA+HgX6WWGYF2VD6iD7F/tqp48+bF+G
         Q4ak9UM9RfdjIjGJMyZfoco6aDMQVuofZCkqBSYI10vTwgvLcg8FFfk2mGbdvLEpSagk
         pa3SUz9cMYWGH0VIGoIuyDDVQISLEx1PNpE6DYSyC8G5Rh8CXCyghrWpZf30MkkRtLC0
         cYkwpzkhvUAkDuQksW9wBMy2ol8ZFa+Uk+La68vQJFVGewNP6vl28NfEwTO09PMLBBAc
         3/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFlBxkUkySiwOt67rrNiNtKIZBxDZItityEVnp0aw8cuGLi8KfFEbjsp9luKp1SOO8A+lbvbmB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyam92OSZyUiIlYkoMMfS3EdawKA1eTA+zmlzjCr5MNPz5la4dI
	c+o4pfqMP93XDRom8bEsH2ZKvFC5/GB6y70h/MEwAiV5aBR5VrUsdzw7/SjLRR+KZHqNp/brMFf
	dlTcHS6hl0zz8CG+z2ripgzxUx5VKjlDAgYExNHmO1WwsmKIXbb2ZOvs9y7jdNXKgd/yHBVy0hH
	PuJAOxyxWSmlsFukQSVVkBoi6s7uXABw==
X-Gm-Gg: ASbGncsKIoGZamwJyX8iqbBC8SOfaY/JBqa2wcuCnxZBmLKP0QpKLWtyPTdY4F32gM6
	e+3LzIXOK+gBorfbpT41HKdaFGOUxja6L3jeouphtUawRuJH8jNp2PpHtEzay97IWR09zcoTm7m
	0FPnhDJ5uoB4U=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id 3f1490d57ef6-e6371cf7f99mr23022190276.19.1741810296464;
        Wed, 12 Mar 2025 13:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILEwS4y4Eu7CtZytQ1AMLlSYSOVDPPOZAL/URaaVOd4HXzYxT1BzN9xV4mLg1LOlVPDho5H2JPLVwRxAT/sw=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id
 3f1490d57ef6-e6371cf7f99mr23022141276.19.1741810296082; Wed, 12 Mar 2025
 13:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250312025607-mutt-send-email-mst@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:11:09 -0600
X-Gm-Features: AQ5f1JpCzw-OMEiWJ5oWmnRpNTzG9s0Jia2dTAgWmtQzoaspW3JJPq9uXITvZCU
Message-ID: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:57=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > Update the NR_BALLOON_PAGES counter when pages are added to or
> > removed from the VMware balloon.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  drivers/misc/vmw_balloon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index c817d8c21641..2c70b08c6fb3 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballo=
on *b,
> >
> >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT=
_ALLOC,
> >                                                ctl->page_size);
> > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_=
PAGES,
> > +                             vmballoon_page_in_frames(ctl->page_size))=
;
>
>
> same issue as virtio I think - this counts frames not pages.
I agree with the viritio issue since PAGE_SIZE can be larger than
VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
for each page. I fixed that one, thanks!

For the Vmware one, the code is littered with mentions of counting in
4k or 2M but as far as I can tell from looking at the code it actually
operates in PAGE_SIZE or PMD size chunks and this count would be
correct.
Perhaps I am missing something though.

>
> >               }
> >
> >               if (page) {
> > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list=
_head *page_list,
> >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> >               list_del(&page->lru);
> >               __free_pages(page, vmballoon_page_order(page_size));
> > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > +                     -vmballoon_page_in_frames(page_size));
> >       }
> >
> >       if (n_pages)
> > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b=
)
> >
> >               /* Update the balloon size */
> >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > -
>
>
> unrelated change
Fixed, Thanks for reviewing!
>
> >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> >                                           ctl.page_size);
> >
> > --
> > 2.48.1
>



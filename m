Return-Path: <cgroups+bounces-7049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B30A5FDFA
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A0819C566C
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA214386D;
	Thu, 13 Mar 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTQ6A8nm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9D1684B4
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887382; cv=none; b=owa4/kvo9voHLgXLZGO0I2eM9zfB+GaTwT9qubzqq0nFPr6ufU5W7ckPK0rX/gUOe6mFBd4fEhhVTfVywqBp3mzJdv/6BquW9rlRLOgFczTx8F+vErXXlwILaTH1yieTwO45W7z5v9bGsP9y0IhNP7wObW1qbdNwCWGiM/Mm6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887382; c=relaxed/simple;
	bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYr/lnv/Q4DVCPJux0nSi9jmcgMzX+zoUvrHNUOKm0stjhKYbHkEbNnRttM8WQ3eex1EkV/ykBNj5Baw+kanrb/3o5mvbbKhmRQM4aa/UHQvNQZrXLSYKdnHrY9nGejHBniWkBKrBP0tu7Zkj8/UeF9LobxNtRJAqsX3cMppWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTQ6A8nm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741887379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
	b=eTQ6A8nmI7dVD7E6N4IgfYSqM/PuLRRlGKIyGAvEZ4vecoNWmCkq17DPCdZFAN8HFZCFBw
	jmSH5Q2IeM8gq0W1h7l6yVZQuJyW6p2MHKekpZ+6NvBsb/pNnNDzk8wTUJ2nWnhH3LVORA
	LVOK9YMBv1NHxH4jYXmjNDZDFqQvdbo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ZBaSI267P96LKdzhEf20mQ-1; Thu, 13 Mar 2025 13:36:17 -0400
X-MC-Unique: ZBaSI267P96LKdzhEf20mQ-1
X-Mimecast-MFC-AGG-ID: ZBaSI267P96LKdzhEf20mQ_1741887377
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e586f6c6289so1948392276.1
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887377; x=1742492177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74LdO3L2papOXx6onu8X7dux3CgaxYMbpnbfEZf5vfs=;
        b=TPBoYHopDA2+RCseyMlzCGejpkPEzKAW3eJS1+RHEYBMZmoCpAtcUF79x9NhrQyMkF
         22CAhRPkR/DDIzMf4CbCRtTkZqJ7Tck/DYndeNt1Za3VB7VFXst0gCWyeR5xaIaGxGeL
         DApRYAIaIagm7dcvYD8TcD1d1b3ymVNNotEh3QlywcZ+K7ZXxNMZuIwmuKB9I6zEAEYQ
         tEtwpk1lDuZe7L60al2LZcxeiM7w0gsHTYqLv3LQ4Lj75PvqPbNSDRI+8yxN0LNKPVBE
         yu1CUOtw+qCFVqJTEJxI2OQMjkWBTpdxjx01ym5ucWpZ8HFOYE4W5DFbGugAzkVeO8P4
         oKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtsMUG/AeqB6fq23hBHlJRLrcViijypQ+Zl18L0QNcatrwyP4GpesljpaakSurAeVRcSzX8SGd@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxCQoMmKX4IdLeGFy6Hzn+vtMaI4DSVKDlOHy8lsVh78lMY/D
	7pBQQpsvxY834eI8BWAUEbLB17Xv9RBsm3Laq9x0JAFLW2uCZ5EQSwMfL4jUB/T23W76cagBnby
	v7Nmnkb0tRyLksmY8ss+CpeoXz2M/xyi4LbGzU1O74S7GRN9v8db8aXftWePLAGRyPtuiVpu94o
	TwjnYnZXSHxHv7+cEz91t/nxl25EMREg==
X-Gm-Gg: ASbGncs3B+lVAnI9UxIpFfk/labh7SSXrrxuVX/k7m4dKEgdm/+x/ZIKsCt62rpS/8M
	vfdL0pFunq8nuHeh5U1KOrqxHZt2/8Tpq0FhG2ka8PLZ34ksKz0V5mrCstjXVKWYMZP/FjeXo9+
	eZ+twIIFYMcw==
X-Received: by 2002:a05:6902:11cc:b0:e5d:d6b8:231d with SMTP id 3f1490d57ef6-e63f3c1ab89mr394099276.46.1741887377134;
        Thu, 13 Mar 2025 10:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESNapqN0/McTxEgf1yThn7lvo6wBYo3eRd0NunIcEjHGxMwrpjR53TwIJsg0lBT1jUk9YB7r7WxOStKAHssG0=
X-Received: by 2002:a05:6902:11cc:b0:e5d:d6b8:231d with SMTP id
 3f1490d57ef6-e63f3c1ab89mr394058276.46.1741887376762; Thu, 13 Mar 2025
 10:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com> <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
 <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
In-Reply-To: <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 13 Mar 2025 11:35:49 -0600
X-Gm-Features: AQ5f1JrzcM5gNtNPl-Fo_pToh0DelHZYtUioYU9wKMINK1ALGT_dvw_uu_EmSak
Message-ID: <CAA1CXcBsnbj1toxZNbks+NxrR_R_xuUb76X4ANin551Fi0WROA@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: David Hildenbrand <david@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:22=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.03.25 00:04, Nico Pache wrote:
> > On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 12.03.25 01:06, Nico Pache wrote:
> >>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers =
and
> >>> expose it through /proc/meminfo and other memory reporting interfaces=
.
> >>
> >> In balloon_page_enqueue_one(), we perform a
> >>
> >> __count_vm_event(BALLOON_INFLATE)
> >>
> >> and in balloon_page_list_dequeue
> >>
> >> __count_vm_event(BALLOON_DEFLATE);
> >>
> >>
> >> Should we maybe simply do the per-node accounting similarly there?
> >
> > I think the issue is that some balloon drivers use the
> > balloon_compaction interface while others use their own.
> >
> > This would require unifying all the drivers under a single api which
> > may be tricky if they all have different behavior
>
> Why would that be required? Simply implement it in the balloon
> compaction logic, and in addition separately in the ones that don't
> implement it.

Ah ok that makes sense!

>
> That's the same as how we handle PageOffline today.
>
> In summary, we have
>
> virtio-balloon: balloon compaction
> hv-balloon: no balloon compaction
> xen-balloon: no balloon compaction
> vmx-balloon: balloon compaction
> pseries-cmm: balloon compaction

I'm having a hard time verifying this... it looks like only
vmx-balloon uses the balloon_compaction balloon_page_list_enqueue
function that calls balloon_page_enqueue_one.

>
> So you'd handle 3 balloon drivers in one go.
>
> (this series didn't touch pseries-cmm)
Ah I didn't realize that was a balloon driver. Ill add that one to the todo=
.
>
> --
> Cheers,
>
> David / dhildenb
>



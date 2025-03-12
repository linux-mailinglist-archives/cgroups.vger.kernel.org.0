Return-Path: <cgroups+bounces-7028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE3A5E7FE
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 00:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC97AC112
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C81F1317;
	Wed, 12 Mar 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkSg+QGF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628C1F12E0
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820685; cv=none; b=YVdA6yCHqIlptnBboCLlPExfk3IgztriQNrAbpsvtZa2RkRTAgEtl/n4idQSjZKtKRYVvUfCGdr6P9VMw0/gZKfp5Y+S1paBQ3cAFUv40Eeu56mNDtJRs5SE93bSkE5pQwDSVt8d87KGgfb6cV82jAdFR+a5DLtcw/4+6WhiFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820685; c=relaxed/simple;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvWwKxCQ8afnJdpRsPqh6ZD1LTIanM6bzPVMXDyUAIXNnm/5HPACLc+U3bzxcq+jzqGSL23VlMdo2wyKMok0BXjZ2c097XN6ZbxHVqLYeYl9w9HPz5ngWqH/2rg1kDYt1iRnF4GzrAs0PUq7Eq8G2cdQEHub1NNOzCWPKo5KS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkSg+QGF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741820683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	b=SkSg+QGFRLUKfmI+2WwJR39m3CSbr/s5PCGziKzNjyTvxarNWkg/nrCo1JoitRJGUio/sF
	WHWRGEaa+AIAFElTz+8bJcClh+lFYBJD2L8bZaF+M8c48bjPD3daYvNHqtChK+/2+mE09O
	hzKI71y+bSoJVuEsRtacrMdb9HU4cQc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-9EaiD7zxPQ-lpVFyE4Mplg-1; Wed, 12 Mar 2025 19:04:41 -0400
X-MC-Unique: 9EaiD7zxPQ-lpVFyE4Mplg-1
X-Mimecast-MFC-AGG-ID: 9EaiD7zxPQ-lpVFyE4Mplg_1741820681
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6fef9684dfdso4930377b3.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 16:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820681; x=1742425481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
        b=djy7LmLcFkjYTozcrWBcke6vv+MInfaM6ng2nTAz652z9N6RaYy9O9bEdz6/VTlig7
         Kx95WO2vyanYbf3O5YjnHrBQATl0WEuuEAY1MEaP9JNWoorlTjCunA0IFfyg1hvbEJql
         +A1Ht7KmbOI6sH3TwGpjlzqFT1Oy0OM/YExBS5xwN7qJWrF/2vV0WsogUwuONoUAzS3t
         etS4QTLU+MoPS//FUMWH2l3bKddFw2FjVBH8CWNY/Cl565v4BpzJVRxAUL+SaE/WMdr6
         KmDYRgdXlg7CiC2CWJje8kFIERjfEHRB0IivW2R5Ehw4ZP9aYq+RvZnGQumBBiY1ZFgQ
         0J4A==
X-Forwarded-Encrypted: i=1; AJvYcCUfDxSKze72p2F21uzn8dgOgRwSE+6X6WF9LZ53KTAn/5j3QMadoqbjR1q7f5o7sX3YEhWcB3Qh@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYS6g1P/SFhAPhph/REA5GNUBXIvFJtcHUA/go91cx70ZWcHy
	F6YMJwQWId7pTGiV+bn7qKYlzLc2090xodf2DedWowJleZ+hbj9u0/03y47+EBGHliPUvghIcTN
	xDxz3t6ajJgiJLFdE3JUV/ULBfpX3JqFSkAdn3RhW6Hsah9t9I8z9U63zAgVFVSQigFlt9vPcVY
	+Ot3B0UZNx1jJqpf4VVUqUChc9oNwgkg==
X-Gm-Gg: ASbGncvowgWQ5l3PfMpg68clwab17GkGnLSVvkwNElMXvOZZHK6o/kPGrE3l2PuvXL4
	CxliixCd9DO7eBj7y+UDWzr234d5WzieXeu5UKaygqQSZ0qKwJko5K7SqWLd51+vapbeeQkJP9a
	d22iJOYpiEITY=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id 3f1490d57ef6-e6365bca293mr20489055276.41.1741820681004;
        Wed, 12 Mar 2025 16:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE29IOsL3if064ONRlZf/bCswPuk7JbIN/+ScTtHA6PhUNFhrt31PPwWl6SfPGyM46nmrjRUH8DQbWz44H/+M=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id
 3f1490d57ef6-e6365bca293mr20489001276.41.1741820680678; Wed, 12 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 17:04:14 -0600
X-Gm-Features: AQ5f1JrCck7ZrLXTjsNL6uP-21nbhhEyl_MT0WXZGBOwpNadq0-oKKZGcnVqKd4
Message-ID: <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
>
> In balloon_page_enqueue_one(), we perform a
>
> __count_vm_event(BALLOON_INFLATE)
>
> and in balloon_page_list_dequeue
>
> __count_vm_event(BALLOON_DEFLATE);
>
>
> Should we maybe simply do the per-node accounting similarly there?

I think the issue is that some balloon drivers use the
balloon_compaction interface while others use their own.

This would require unifying all the drivers under a single api which
may be tricky if they all have different behavior
>
> --
> Cheers,
>
> David / dhildenb
>



Return-Path: <cgroups+bounces-5699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D69DACB5
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE370B21B45
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0A201034;
	Wed, 27 Nov 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNi5VHcC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730291EF09B
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729662; cv=none; b=JF/rKoOXLV7hjdMJH64qUKROAyJd4Xgs1Us2kHfE86IMXP8TFyg6tZJ1gAkgdJ6FRks1e6p2qA+yonNFhedgZF1n7HByu5jnF6Pdpa8BSORYKCBrn5Gj3VjqBkbarm5IRQQ8QFDmAaCC1FLy/y2WqOJrKveQ3olON0sI5iRBGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729662; c=relaxed/simple;
	bh=3cPCxD7H2a8Lh6owvh2XlsPsMo9YKelKbnsLwpIFa20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyFpaB7go8yBUv0Peq+IGpNBe4UPyZNYDzORLtJ7KN5pF3vRWYYUYjz2ctzhMlOwzwQnjtBWkyleVDZD+GbjZeM5gv2VTJgcbinQOumJXXRvjzMLt3HkT+Lw2xqAMYZH4ArVu/jgNdLmSPwidPI8FHrSyXpyYvuwnaMXQFvELfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNi5VHcC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-211eb2be4a8so196565ad.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732729660; x=1733334460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=dNi5VHcCyV7ERuNgBI9bzi17ZRrzpewNYowpO8dKTLsdR+6X5q9QkNG0rlEOgAKOr5
         KMWabk/IvN/QuVVx4qV7wDIkhx2sj14afbAO3k0av0nua/bOtoeXJoSvhrZdV/4+Kpd+
         Yql6s2IFMuyXQ7PglAFw6daN75n/XgkGIsIUWZKJEZG21jfFD015O2+yEKmtHm5db4OH
         oNc7OA1i+H2OXfAljcOSslYF14wayjkOM9TD9uXjwF4HnAI42jSCXv8PgY+BvjZ0aSIs
         AgMduWhbmVKOzM1nUn++ZLx+y4jhKpFa6FkSjx9bNZWrB3j6cZQUCKdZD4Ef6wHp2iZt
         xyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729660; x=1733334460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=KEX4QGb+fsTxwrBecb3s9qticf5WJDIWXzSRU2Nfe3ANbJHnu90kMafiyZkHMmG1BY
         qdasIR94nj9cXDWWMKAPS+b+V6RQxHCnZjcD5jKDQVf5tZ5PhSz2vy4Q+EZc7y3WVLD3
         bh8qy74tsc6K6SK0WHO7OertebOHMBiXdPZgmCXWBQPqV1wdtqpMpgpPYZhrg8oJqvAH
         X4cq6+qPxkE8SL34rnuQtMw9S1+htzmxrITG4ZgF8QQjwmc66Vk3hKEXkve9hxM8loVU
         w7ch6rzJW2PL5wfPcqZ52HbyAlAi52kN5kO3MtQHvfz9Q1ohUq8O40QF4W3Dii37g1UK
         XyQw==
X-Forwarded-Encrypted: i=1; AJvYcCUvWMTwddwOrcURSt3591jmQaoupEzvsjIa62R1pbRWvXakJ0alX/zpO3+lMk7C5rIPDAzTO8w9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3eOjCZCaA0Vw9K5lhJcZ2oCgLuKU+QLz+50BR9NQLDsdt+ox
	enZCLiKgajIYMZkMBqbCm3zt7zfGGhlXjUN9ax5yFDVYm5Zdx+7BeAFxEf87FE2iwrhwGkXodvA
	kYHhLQWDZvOSWO/32vl0ADqRh1EknG1Fi+BkE
X-Gm-Gg: ASbGnct7pyr07fkWYwejO7vLc6pWKjABM9VR3O4Qdz3kFdiDmhyJ7aq8ihDB/jMd+uJ
	otsRLgPqs+zCR1Pef+rV2mQHXdwjwJ1ZOvOFm4R+zIWr6BFBEFP4IipIMSsVi8U4EuQ==
X-Google-Smtp-Source: AGHT+IEWj4m7+heIVmeyDopSriS2JGtzJfSKycg033XDM9P61gMKjT+xPWPfu26TGwPqoI2Oh8nkmAXZluulyXqzu48=
X-Received: by 2002:a17:903:440d:b0:20c:8a97:1fd with SMTP id
 d9443c01a7336-2150640abb9mr2258805ad.19.1732729659360; Wed, 27 Nov 2024
 09:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-2-yuanchu@google.com>
 <Z0aeXrpY-deSfO8v@casper.infradead.org>
In-Reply-To: <Z0aeXrpY-deSfO8v@casper.infradead.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 09:47:22 -0800
Message-ID: <CAJj2-QEq5xj7JHNS_QaxWXq0e2KDMX2OSw5rGfYeGC4+X9gx8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm: aggregate workingset information into histograms
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 26, 2024 at 06:57:20PM -0800, Yuanchu Xie wrote:
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 64c2eb0b160e..bbd3c1501bac 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
> >  /*
> >   * in mm/vmscan.c:
> >   */
> > +struct scan_control;
> > +bool isolate_lru_page(struct page *page);
>
> Is this a mismerge?  It doesn't exist any more.
Yes this is a mismerge. I'll fix it in the next version.


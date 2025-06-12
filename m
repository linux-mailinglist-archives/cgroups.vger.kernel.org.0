Return-Path: <cgroups+bounces-8507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E385AD78FF
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D60189493D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED182BEC31;
	Thu, 12 Jun 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPs34fLD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570B2BDC13;
	Thu, 12 Jun 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749328; cv=none; b=bsy09k9mhWlsG6P0B/MqvZk89TKBVtSLXnIwopgHY6W9IlqZ+i6K39Ojfm2zCPuK5XLx8AtJDCJexRfxVgyaiFESo6rxH7Bm8uvuyIk8v9mGQF9QEgaU/VKd0nIrz5bWFnxwogPli47tJpR1Tuq1pagnyMJPibTNkISmdFjpz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749328; c=relaxed/simple;
	bh=cVzggo6fwLrjSrHwgdYTjOmIIJBC25mHFWhaLr0wgiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGp5p4hFNTO4pcw5WJZAiCWz0ZXOkt01gXbsAUnCwmhza6tDSP7F6qeW7eL62p85kJhrhBvr4cXn6t9aJsieUMf6El8V9nwPpHQRF5xD0mV+fTk2TdNv8JOhLy5kwykTUAJu5NSpYH19Ax5p6cYFjbeAaoJXKoieKyns+YxROpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPs34fLD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so13182356d6.1;
        Thu, 12 Jun 2025 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749749325; x=1750354125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVzggo6fwLrjSrHwgdYTjOmIIJBC25mHFWhaLr0wgiM=;
        b=HPs34fLDKSMvYESblLH9V3YVsR/e8F98chIh2PgE5PC4u5s1pkJf3oznZu1+PkFb+x
         Uu0dftyeVSLS4O7Q6xYf0XY6aWCr+bt9Kru75wWs2zOLcSHRPO4g7Qx53VL/c1g6IEIL
         ISrLrWKk3yTFPnA51TH4U5I9KNCv7lRvsf60Sh1xjZcS5vQYv2Pi7EH7qny82eFKnJye
         WZ2mJIL01dgCscDhTSqLHXtC4vS2AxfqBoGxOQLMfdxRVtsCQxsQeJtDHcw87uV5LjNp
         2npYbXPIJvx5pJxF4GR//TXgVY2hgjz+r1Nye8RLDfwADRIcOCEqEtCH7/HAdfCN/kq8
         zX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749325; x=1750354125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVzggo6fwLrjSrHwgdYTjOmIIJBC25mHFWhaLr0wgiM=;
        b=baZHbcWlCGIeJyDRXZeasHn+OQOthPwtWY/fbPv4JhuL66nEEa2r2dOJSe5nYnr5ty
         J5e3IdqCS/3QGaxP+1rJ31t1HJKRAkInh3qf5ZHymdVzrNE6gKp8hmgnUoMSfy3Tz+Ca
         ZASeqKzW8ei/ZYIfAzjxHUjA45aM0Ql0w7s9KkxdizQ56nkV5uTSuXL+4PSyFmtaEtVh
         wLSmRJ8NCZz+sH/eW22jvwPhfYkeEQDnv8t2PBH1fdwXV1qclDCBACrwKhTMJli+rLuE
         2mWdrc0JY/5bP+ViCLtI/QU9v2S/cbwIsRrXJKrJWLRT94MC6aAguK7R/jzZVw7EE6sE
         3QOw==
X-Forwarded-Encrypted: i=1; AJvYcCWE5FH30lj65lXp9mridrqUJ97It1x/wLh7WpVAuKe48gu9V7HHUe/PVgHwUfuqN1hH1n07RwewYq+wcjH2@vger.kernel.org, AJvYcCWzRRoHiS4gaJLx1NxB4U+j7B0O+bHJ5og06Y5y8BRa5BjCoHs+fwi3aVtM6NHaboWyDXHRAI4I@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcTfB+RsTOLR3hK8VnkkLfk65tKgRElBkrJ1BCeyW0ySA379t
	RNIhXMLQMIdP87iBbiJfHgqLRDxJ0KNXWNy5W5fgY78rwYrOEJGTDWgV4sC8v13BStiKjTekQ1H
	Og8qX9p+J6nI0LHBybis5sE3jmpw+RMI=
X-Gm-Gg: ASbGncuiBJqG/VkaDxvXu13dKTdp6xPCCZ+y4xCJ4RpjnhwOzR6Zt1agmFNQDIb9oYq
	0Hdj+vcf+3bVYuWdYu6M0LG3vKzSnFTPdxD7RmxwTH6EarGZczuVO84xB+zJ0VZIaM6+hHn4c7A
	9ZD5enHmpqAc8Zba3jpEHXsXOwHxxcnB28vZbaBIUqqBCSMPVhhQ1RFTaGXBk=
X-Google-Smtp-Source: AGHT+IEXdxdD53pTjTM8GX7O6wNncG5C9alVq4mW+efekyq5EYpQPguf/NrZNanJT1ZnJiDheX47I0CCs9OiXFq+bqQ=
X-Received: by 2002:ad4:4eee:0:b0:6fb:1db:e9e7 with SMTP id
 6a1803df08f44-6fb3460dcb6mr74029396d6.10.1749749324580; Thu, 12 Jun 2025
 10:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com> <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
In-Reply-To: <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Jun 2025 10:28:33 -0700
X-Gm-Features: AX0GCFuF9SfcQkfWFU5D6MhImUNQ-lwvv6Y8pN7241v7yDw3O3b564ehqU6vmjs
Message-ID: <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: Kairui Song <ryncsn@gmail.com>
Cc: youngjun.park@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com> wrote:
> >
> > From: "youngjun.park" <youngjun.park@lge.com>
> >
>
> Hi, Youngjun,
>
> Thanks for sharing this series.
>
> > This patch implements swap device selection and swap on/off propagation
> > when a cgroup-specific swap priority is set.
> >
> > There is one workaround to this implementation as follows.
> > Current per-cpu swap cluster enforces swap device selection based solel=
y
> > on CPU locality, overriding the swap cgroup's configured priorities.
>
> I've been thinking about this, we can switch to a per-cgroup-per-cpu
> next cluster selector, the problem with current code is that swap

What about per-cpu-per-order-per-swap-device :-? Number of swap
devices is gonna be smaller than number of cgroups, right?

At swap slot allocation time, we check the folio's swap device
priority list, then pump that all the way to the swap allocator.

swap allocator, given a priority list, for each priority level, try to
allocate from that level first. It will get a cluster (either locally
cached or a new one) from swap devices in that priority level, before
moving on to the next priority level.


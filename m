Return-Path: <cgroups+bounces-5653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EE9D412A
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 18:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC34CB36867
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66DA155352;
	Wed, 20 Nov 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JTrwn96T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E0148FE8
	for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120855; cv=none; b=gtQd1jYMWXs3SzLdubu0uewu4inmsu8GP09F4x8v05LTEpPcMaVrwONjyMTyynBFSL8aDgd2aJMBXpPzIQrKHo77Kd90khO4SIikbsaVoUKNPYhM07IMSWrVw22vtXYQMt+pXV0OoGfeN1f2uv1b9sLvREqZZKY7BjrkHkQIbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120855; c=relaxed/simple;
	bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxaSuuJzYvJxzoOILpNdy3fXRn3WMnC391qZiwJ0fazFYLADsKm5tJd8/7e3pBiMf1Nz1A22Aqq2rE8HtzInE2ngJ+3ApVvv+VQz2Qgv9wSrcEJdp3avcRiSqVGPn9N0D2FiY3dL06PX/U1WicCoxIWjU1C3JfcbNeqi0iNjUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JTrwn96T; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46101120e70so50846381cf.1
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732120853; x=1732725653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
        b=JTrwn96Ttky/UoBX+bQss/opbVOE+0VBNtYL4bVIeXW+wg8JYOmBiPNo9gEK2/ZQy4
         QuRqprRu+sLYER/ohrktYDHWPUGiptJlWDJYvptSr/o0Bqji5LAqFyJ1O6A4M3FX4tXZ
         wNiJltpw/yKf+bwS2YqY4jMAZ9KBykaAvU494brqAhXl1ach53sq/HAPysVm7MvjZi2p
         KKYvg0zzJwIXh7W+56f5OHo9Hi4Wf7k24gDq0uZyPTZX1WUwrFJbM58O3xIi7q5efido
         ukigsILg7vq01mp4uxGAWMBxjNX9AoPY9I11fwRYK/HBqTQQCzhrWTl0AbktuXRTuUeV
         b7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120853; x=1732725653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFK5EvqBZ+FjmE22hL4UUAySxH2UgWn1OIf3kinQ/4M=;
        b=nl8O5lT9LYyiBHNwx3phtmfvg9WzJPHM7YAPAGIyFA4R5npBNxmAKoUlJzLwzhLXBx
         b9sT4Mr4kKJuFCl4uLgo2qWuZox2LW4sikyMOFJKhhp8SM0ux1zLKMQ9a/as/LuX7J+g
         Voz5Zfk2xOl5qB2BWQMFqR7NMlcu9waSqT/vc9Hdz12YKk/NtIJrzsOv3o+o+ISPeuQF
         YSfHuuHe09/2OOuL/drOAukIyvF8iidQ9arIVUiVS7YiKrBtkC5ItF2CZ3dfekAFjcd3
         qcHyCUSbZyyTc4vopa+A0mZ8XCdjv8fQZzuiFI+M/oGJ60LMZZCFq/8tuEM6Evg5Htv/
         3L/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdOkQHL5HP09CEReDpdXZ+4cyTAbJfrsB9xR2K1LHZ8E9d/MUyXUKYFAPaC4JZES4Nj9e2tYZx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo52wVzuVijFC5MlNM+wr5kwcrAB9NT7brdB0EYxlNNl76/DWP
	En+TCnmSuLcADExwUiFFPwKUoXdrX7UZSrg6CG6BWX0f1RhwXJSEJ2GwOoDMrz8KKY5qL7D/eRy
	mdV5zyulyarw9osXlfM6Q+Mk+3FMY3dYpGGUeyg==
X-Google-Smtp-Source: AGHT+IGVXXSe3/jOn7/F0+v6GfoX8kW0XiYKv4M7VEKR+QzShMxf6KNfCHMwiuPpKZqaaCv3T5XpK+zCdLzMyTPmntk=
X-Received: by 2002:a05:622a:5496:b0:464:b81c:316e with SMTP id
 d75a77b69052e-464b82b74c4mr29186591cf.6.1732120852696; Wed, 20 Nov 2024
 08:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <87wmgxvs81.fsf@linux.intel.com>
In-Reply-To: <87wmgxvs81.fsf@linux.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Nov 2024 11:40:15 -0500
Message-ID: <CA+CK2bDTKXuTHq7EOvErWFRe9XRGq9UF5L-LmzX3jhWd40_KbQ@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com, 
	peterx@redhat.com, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 10:29=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > Page Detective is a new kernel debugging tool that provides detailed
> > information about the usage and mapping of physical memory pages.
> >
> > It is often known that a particular page is corrupted, but it is hard t=
o
> > extract more information about such a page from live system. Examples
> > are:
> >
> > - Checksum failure during live migration
> > - Filesystem journal failure
> > - dump_page warnings on the console log
> > - Unexcpected segfaults
> >
> > Page Detective helps to extract more information from the kernel, so it
> > can be used by developers to root cause the associated problem.
> >
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> A lot of all that is already covered in /proc/kpage{flags,cgroup,count)
> Also we already have /proc/pid/pagemap to resolve virtual addresses.
>
> At a minimum you need to discuss why these existing mechanisms are not
> suitable for you and how your new one is better.

Hi Andi,

Thanks for your feedback! I will extend the cover letter in the next
version to address your comment about comparing with the existing
methods.

We periodically receive rare reports of page corruptions detected
through various methods (journaling, live migrations, crashes, etc.)
from userland. To effectively root cause these corruptions, we need to
automatically and quickly gather comprehensive data about the affected
pages from the kernel.

This includes:

- Obtain all metadata associated with a page.
- Quickly identify all user processes mapping a given page.
- Determine if and where the kernel maps the page, which is also
important given the opportunity to remove guest memory from the kernel
direct map (as discussed at LPC'24).

We also plan to extend this functionality to include KVM and IOMMU
page tables in the future.
<pagemap> provides an interface to traversing through user page
tables, but the other information cannot be extracted using the
existing interfaces.

To ensure data integrity, even when dealing with potential memory
corruptions, Page Detective minimizes reliance on kernel data
structures. Instead, it leverages direct access to hardware structures
like page tables, providing a more reliable view of page mappings.

> If something particular is missing perhaps the existing mechanisms
> can be extended?
> Outputting in the dmesg seems rather clumpsy for a production mechanism.

I am going to change the output to a file in the next version.

> I personally would just use live crash or live gdb on /proc/kcore to get
> extra information, although I can see that might have races.

For security reasons crash is currently not available on our
production fleet machines as it potentially provides access to all
kernel memory.

Thank you,
Pasha


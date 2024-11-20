Return-Path: <cgroups+bounces-5656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569F9D41AB
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6978B2A09A
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7F1B6CEE;
	Wed, 20 Nov 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="yQ66ORCi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620C1474B8
	for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124857; cv=none; b=XdSf2+/URvubJCVmanr3zyRWKi59eu1kC0amTnWNHriECZOko/9/v/KZcmtICyQLitctEPsjFl3hva4zjFSRwb+Yn6FtuRk1rxp1klphv6sX8J136wZwiJORQorFt3k6QSMhjsRr4b7tOVyUt05njD4MvisYrF/9h2yvsp2WNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124857; c=relaxed/simple;
	bh=u99IqIWwuXfqqVllQi6t586j+rI6T6G2LFrOGmNlgvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh2bMQB+TNWsg69GsNCc9n/823OB4CkVnHoiYdnF5F2BCVrTvOFH3t0ySudNUcGSY6loScOt0Jv/DJTfWR6YISUcA37tcrSDgOKxwpHdDfS8Be0TwiCRes7uuon3atdajyMo/ppCRKY5IPUV76kkKATNl/nol60iCbqFDMjNZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=yQ66ORCi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4609e784352so264661cf.0
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732124855; x=1732729655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UaFYnoy6vIIc+NNFw3dXMBs61SIsGb7xxVzTfcYyYis=;
        b=yQ66ORCidijal9Md6ogoyqmn3A3Oo02nTqw9YZoP1pMTj67QBkOagb/7QIwqVq/FDl
         MTGYXWOYMINrjMsrCaGEcKSSVb9iHwZCSYLpByfDPoX6TAsL87/Qu8axmWRQ9hzx4v+u
         71413HHBBRPeaALZVrrEi+iny+36Go0ea47b42TdwgFN0fJ81kUmJ59z0Lw23WIAGqUZ
         d/o8oapSH39LwlOlHCBmv9h3ONJ7lbQJTjsj4kA7hCYxmFGcGlfcai3ROa1yyjSouf0y
         bHbKuL9+ANMzFi+1lzqDObF4WQfKQwAh7hgMiW2DJdKyYHNNJcpD8wHceRLhbdyJxNpd
         QKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732124855; x=1732729655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaFYnoy6vIIc+NNFw3dXMBs61SIsGb7xxVzTfcYyYis=;
        b=mxpGDpfsG6q8ymYXJTpgpU9y+AiUKXfIeE+1mj5VGGOWAeajvB0O7Wm0DNWF0/vcKa
         4/OGIXaC9vOV5XiHW7ML0u6DbZAvdA5S1drzB8Dtu8AM856hGv+UOfZUxJhuTGdHs/tO
         ZoWaQi+Fdd73oM+1QzWrZKu9+TB1P/W+Uym4PIKrtXFEj3JuLRRuYxaN4wcfxqAoePGA
         TCLFSiDFNulGvms6GIy3YgAU+wRlrNJGbG+Js+Uza+Hl2X+86sX1lczwu4irNjGXrLYI
         i49lDu/B8iIqzBbnwb4DVbHGMSZ1zprai2Zx586bOuLHsxe3kX4E8L9YNzuaj1dkeoS5
         ZjEw==
X-Forwarded-Encrypted: i=1; AJvYcCWL6zNIwWo3O04OQclUtuB+N6SLXrW3FJ/JIOve3GX/ypyH76Quo+9Zn5miT61TorkbRGCwnKte@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiJ2LxN8WQTvgn7b4fVprGyKGxylHGiTquN8tzURZAOYWnR5w
	cugDMLi8MIODnkouwfgE4exjRDwGM5MzUZMjziRFwswitsgII45J5QnsdMWNDtZpOLcY+sASg58
	LR7j//x6CRa+sudBggTZ5ZL021BZyyLTCMTC1MA==
X-Google-Smtp-Source: AGHT+IETZYeQkb0s7u5Wf9yV4Cku4EiSNu5qCpIOez8ZpXMAHom6F/sK07PgTzdhYiGYrI8j7GVXlIMLnKbJrLP6RZU=
X-Received: by 2002:a05:622a:2d5:b0:460:ebb5:5fe5 with SMTP id
 d75a77b69052e-464782a740bmr36717931cf.10.1732124854779; Wed, 20 Nov 2024
 09:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com> <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
 <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
 <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com> <CAJD7tkaYuJpxijOp6se+mWHO6djaz_7KaoXjf=Rdo6nJubwB2w@mail.gmail.com>
In-Reply-To: <CAJD7tkaYuJpxijOp6se+mWHO6djaz_7KaoXjf=Rdo6nJubwB2w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Nov 2024 12:46:57 -0500
Message-ID: <CA+CK2bB9P0gVFVETh_zBfhnShYTJK8EX-vNfVjFY7QEKi_Gpmg@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"

> >         /* Use static buffer, for the caller is holding oom_lock. */
> >         static char buf[PAGE_SIZE];
> >         ....
> >         seq_buf_init(&s, buf, sizeof(buf));
> >         memory_stat_format(memcg, &s);
> >         seq_buf_do_printk(&s, KERN_INFO);
> > }
> >
> > This is a callosal stack allocation, given that our fleet only has 8K
> > stacks. :-)
>
> That's a static allocation though :)

Ah right, did not notice it was static (and ignored the comment)

Pasha


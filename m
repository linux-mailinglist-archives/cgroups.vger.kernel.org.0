Return-Path: <cgroups+bounces-5631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D89D1B1C
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20607B218AB
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDB1E882A;
	Mon, 18 Nov 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YulGoWQn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DC1E5711
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968839; cv=none; b=bPE6B/bTN+BpYMmYFTc9eujbBGkxAzM0Is2L8ICpty3RQd5sBigUgN8XEx5lhKOyMMQdwca9uXdTOYz0+Ut0j6FCBmkdQx+a+zV3GKDEM4kHxR9mSVaR6I7s2EoPyaiPQS4Nvb07+ZomlNqOhWB9B4tyYajp4XL+DTwfnOq/jU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968839; c=relaxed/simple;
	bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2F3BWakb6OUuGf0ZIMkHviGjIqRBxQH9RGvTKfOFhE5XeN7PoFzbm3pXly1K/UMpd0S7m5WPGXhS4opl5f2xZEBIxAwxDpUh8ooRR2NT5+erPsah3todEZ/sJLUOQi7WTKVPjHBLlP8kNM2vHGNyrr2BjFW3CxSwElU9cQhjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YulGoWQn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609b968452so32819061cf.3
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731968837; x=1732573637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
        b=YulGoWQn5V95Hr3GXX0a47ucZAzvekLRFK2k3z9O8NbgJUuKRTUV8+xqUEdMQxUBaY
         C5JXglBWXhMbUaZuqzxXecsIC4Jt1AOa99aPFa5AZ0t+FL0zlhgIhmuIne1Zn91EqAQG
         0hDKd3WlSNXN7L3SGwwbjZwRnvYlMQx7s7FWiITa4aGIyf/80pH65xO/1LtsJcAGpDX8
         BWTnX/Spi7bDhX5s5ljb9xVd6xcEpb0PHgM61bv5/9rdebsE1z3xlNhkbKY9i1ZCYpjL
         XsxLssZkg7bphL/DyOxeEjd9v+7ur9lbIYt8ivA6DqpU3Hqa0Njx+IHxlxJgfet6DMR6
         0qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968837; x=1732573637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
        b=ULzZey19tHumvnlyxDvjkEA5yyCVpPJRAlhfZEK7zXuTpZo/gFAbJhSqEn8HZViqIg
         B0GFCFY1NhcN80p7d99JOqayx2QYuO1J/LpDkBV4uPnnvYuRBwEjjV+IKNjUi+xa+nYI
         iZdf9NJBpm/auwdqdD0dlOwjxqh8cIqRuWQGBMmsZ3QkMHYvUcT/Xhc7z9gsHGlXxqfc
         S++Lgr5DDqJdbdvlWtqd80NK5G+RjxGyJZcHQkN5iMJkc+AmDP08EvSozZ+by2+J8BtL
         WpMjeqJIB5Ml/8DQhARDZ5Pz6X/ZEuzxDrI3yzQfGuBfHIahrB0ApDFX9BHY2PmEqrr5
         GAew==
X-Forwarded-Encrypted: i=1; AJvYcCU/qvr2g9f/zBWh8ZOqmtWCDEkDAdjYygCATs6GGgXfGQMuXsghOlxMoB5Gd8Og3uchZ7fbHnvu@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiEKL5obFOMMnWOIGWogeNo5qSwABLxOVuifzSTpRztUditTX
	J0Ew7IIEAa1XWR10H/OBldPAL30ErXUtucHSsUVRmhfhiD4lHcWCAjcu0QiiHZo6QiL0qgkAZla
	tyFkJuSmynF8kA6PcGFMk3ASIJdC5E7/Aeoju8w==
X-Google-Smtp-Source: AGHT+IHqiNZSSuRgMIGzeQbAsyUzuR5eC/kcwrOx7kFHxfRG4MSHz3HHm0p1YAsqzGlVtXTmEOgHQPQhoyYoLazVVIo=
X-Received: by 2002:a05:622a:2a1a:b0:461:41cb:823c with SMTP id
 d75a77b69052e-46363b72104mr162429471cf.0.1731968837193; Mon, 18 Nov 2024
 14:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-2-pasha.tatashin@soleen.com> <8871d4b3-0cd8-4499-afe6-38a9c3426527@lucifer.local>
 <CA+CK2bBqi7+RExARBq5m91kaxC+w+nLYnLf4wyM_MJjaxr2rAw@mail.gmail.com> <ZzunOu4TcHcJIOht@casper.infradead.org>
In-Reply-To: <ZzunOu4TcHcJIOht@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 17:26:40 -0500
Message-ID: <CA+CK2bAhB5KXnm8WSXe2SocMj1zyQnswQ0a=4AgDawcCcisSxg@mail.gmail.com>
Subject: Re: [RFCv1 1/6] mm: Make get_vma_name() function public
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org, 
	ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:44=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 18, 2024 at 03:40:57PM -0500, Pasha Tatashin wrote:
> > > You're putting something in an mm/ C-file and the header in fs.h? Eh?
> >
> > This is done so we do not have to include struct path into vma.h. fs.h
> > already has some vma functions like: vma_is_dax() and vma_is_fsdax().
>
> Yes, but DAX is a monumental layering violation, not something to be
> emulated.

Fair enough, but I do not like adding "struct path" dependency to
vma.h, is there a better place to put it?

Pasha


Return-Path: <cgroups+bounces-4870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C69774AB
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC77B21F1F
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C719F41A;
	Thu, 12 Sep 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDWFgz9v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1918891D;
	Thu, 12 Sep 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182261; cv=none; b=N9TCMmDdSz7+eO/MhVqfP+LYVxswecZ7GWT2cwnuITZWjqyBK5mZgkgyphn6uul8eSycBc7OH31soiq2Czaj2TsR27kvLFdywXrLU9L44SV+uoONJhN9a1yn2TjBfMsuz0FX1uIFEVWFcFCAG3GdqIv4/KhLs4Na9/ISrBQvYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182261; c=relaxed/simple;
	bh=TbW3PVVOenw1xoeKf0LmKcMMzULyit6y23Gk7zGQuJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuqEIVA1qGL/iO6wOoQ/rIVa1Rm1SI3iF1tE4G6ucG9PMDFd4yrA/r50DohvaFzm+eOvgcu5PaYrBR3QrGy9+NaaZZV79Lf87l0va3p3GTUppJ92MsmNWokC9ULiWQ2ID1qkiIHVCoHtMYekQ1wFDISt1dMwiIeWTeyTnkrlbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDWFgz9v; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso2696926d6.0;
        Thu, 12 Sep 2024 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726182259; x=1726787059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbW3PVVOenw1xoeKf0LmKcMMzULyit6y23Gk7zGQuJo=;
        b=VDWFgz9vUmVZIr/DYp+JngYsfFNQSc/BCmHBI2J/MpHV9QlfyPjJ4JKWknDLgYF0OX
         U9GiuJAyNbBSbkTlB2mXCkl8oT5CWMQE0K6TuNK7NHJAaA6UnZ+sdtVxeOdCj9isSQkH
         YsXcIgVc5iVawArNWbqVdfxdu2h8eagSnvFFA/zJ473kntXxZwG7TUCvaUflUpvmxcv6
         QoduEH2bV5iBbUq1Gta6Gii3YgrrYu0Ucej44fOM00pj4ClyTcp6YCT4FQRGeSQWfjfS
         X4LyN6rHq0FccYU7WW7QHLw6IQtaBz/5izK2sFzFGjgMzKb2r4n3F1AUwGM/kWz/BJ8l
         hvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182259; x=1726787059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbW3PVVOenw1xoeKf0LmKcMMzULyit6y23Gk7zGQuJo=;
        b=fuyexWO+Yt0h7yeZSYPMLXnSslcpdwl0Az3JBjpamxuzRLU4q6U3+qb4h/x6pCPKWj
         r+O01qfoY7hKgpAhnv6sJF2OarPnlQwKJNfmoHUkPjjoVRjNb3kpyPnSV21HZgix47++
         feDHJ5r/Uh/HGftTvLYPZUQ63gD/WMwmXqQGC4a95MTm7pM/+uuIVFceL37yMq/KbYh6
         1TSjMrY0esq41gUEJr50jQLFvYmGOTZMtOa2I/SEBIY9YUxLmVUqzRnOz8oZdNSolQzW
         ZJEw3SNI6l8KVMy5khI+wdCNfgNAxLVgU14SkGZdlAeGnWNnidcR4VAQM5njuSbfe7yH
         b76g==
X-Forwarded-Encrypted: i=1; AJvYcCXCCAKg51qZa6NT0RJEwUg7Le27I2tPsWLiM4CZ3MTFaXV/gGVx70yEoRTnHaKZPYwhAnqbVscj@vger.kernel.org, AJvYcCXWso5uN9eOVk1cXDfGfJT69wiwe4ROBfoSUF9GqRO8vreNma2WGHrGca8LAukRr5HIyAruwuW6nREfeN4g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+cJhl8yL7xq1F6+E5qVC11EQ/WN3Yg2gU3wHtDrZoIW65GHG
	vs3hFzI3yZx7YfhcxfTnywb4P/OdGO2ijPsov9XkPp3qGELy/gBZ4NfghXHQV28I/PXr5k6MzA/
	e8lBU8iUWq7TZRXbf6zP+AHJHy6Y=
X-Google-Smtp-Source: AGHT+IEBoIFqglXjOGxm1oG8UaGjX9AjpAULwz49PK4uRew9iXsgCf1fkjksL4FHBlMw9CU99BPhXya3XqchHbXUek4=
X-Received: by 2002:a05:6214:4a02:b0:6c5:688a:63c4 with SMTP id
 6a1803df08f44-6c57e0d898fmr11578736d6.51.1726182258573; Thu, 12 Sep 2024
 16:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
 <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
 <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com>
 <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com> <CAJD7tkYhOphYbNnwkZfJykii7kAR6PRvZ0pv7R=zhG0vCjxh4A@mail.gmail.com>
In-Reply-To: <CAJD7tkYhOphYbNnwkZfJykii7kAR6PRvZ0pv7R=zhG0vCjxh4A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Sep 2024 16:04:07 -0700
Message-ID: <CAKEwX=NQmNpFNf=8OLSWVp-JsRPgo90n4DR68k0Y6+nFUfXw4Q@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:51=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Do you mean per-lruvec or per-memcg?

Ah yeah ignore that part. I was originally thinking of adding a
per-lruvec zswap atomic counter just to fix zswap shrinker, but now
we'll need 2 atomic counters per-memcg to replace MEMCG_ZSWAP_B and
MEMCG_ZSWAPPED. The zswap_shrinker_count() will also use these two new
counters too. My apologies for the confusions...


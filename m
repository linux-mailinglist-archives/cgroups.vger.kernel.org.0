Return-Path: <cgroups+bounces-1784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456D85EDA5
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 01:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A4CB20B9D
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 00:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9610AD5C;
	Thu, 22 Feb 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="V4v3q5zW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DA5660
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560550; cv=none; b=Ypsap6bNJ3DP1r6zJIvKP94ztqzsVs50NXrDVfg0BWDfY6WrBuGxqZ+j5DDEOlqoF6anIkWXuu4ZwNl35LZ0yRkyFlN6oK+Dq+WsumC+bVOzEyQHMqC3i2gFRYRzcvMKzsoYrulHDOT60cHQROEqgK7EGl/LIQh5Yp+1PzsE0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560550; c=relaxed/simple;
	bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEx7aiD864CqywevAYXtKgTc2jr/XXZ42P1XYqpiF1jiSLr67GDHsS2fvQTTintSmoDuUK2ZpWNj6V8vWVgqa59mqkhHHfKV+JD9Z8+X7GCMpRaIRWFWTLpz8GqElo3NWY/aUZDPd8l57fmg1E2L5wDSO4v1uEWgSp/olMNuwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=V4v3q5zW; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so4605059241.1
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560547; x=1709165347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=V4v3q5zWy6TRguaajZ4nQ7fJK1qziegRcyc2f4uuaXkZgb4nKEsRZW5usZn2/WC6UG
         2HWxXkyggg+HnHBE4LSYDAV3qlSVSEAJ7vgj3MpYcNlVANNi82gJyKs3TGO95H7vQQs3
         P+mjK3bnK/Tsa/y3lgPnoCSvSJbs2j87+GMbVDg3j9OYX0gZdOAxTTKJHTxjoXOw0Gwx
         0DKKNqPgam6bcmtKcoMyNXiATqMuN8yiT32970gwjqs7o9zipOX4DhXrYhTml3lKxizt
         +ishB81w04QpeSmjviwcPT5P0aChisMAKE13nexWROtuY9dinTAdSxKj6PHKgtTQO6OK
         fdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560547; x=1709165347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=p/9wBFQwkgtHdx4NoUkeuwkO1X9gu2KjWkddcbeGfHYR+AZO7fI5LhONFotrtZ28rx
         JuddE62sYRpwqyKDjAliQQQI00GWNSko3HGMUKeqU0O2sLQk2Q/PxhAcs6hG02/YZdeh
         MGZXq13K8VzqmsiY7vwXSH1UsxRsf2cojGgIwkCXOoW1cIUqSrVeG35HTcOSeWf7ZgRw
         DSpep42m+559rbLm1EJjj3tse3HvA4atJTXCijLtgwTr9MGR4I+n13wQtr0lfHgmeyqW
         R4U9o8E0llp33hgBtV5bCPe8RXrhVepGWxkSpNjMYG4gPjuMHZSHSfslci2dsHwhcBT5
         m24g==
X-Forwarded-Encrypted: i=1; AJvYcCX+GYXs21B+tRJei77RIHlRUUc5f/97zHHwe9GWKUPUNfWpmla5ruI2At2tBLHJfD0UoseAxADSQlfbZFysVOo/VUiV+bcVIA==
X-Gm-Message-State: AOJu0Yw3BQdmpIkJ/f2LillJo4MEaoyNepJxQ2rPfHCfmLb/B+rfUgdN
	XBwqA/XMMBL+Qd4ACpiTPUg5Qid55sGMjQp9I7FTsGixxhN2Iz+9blktYapz5FEKQcma1eY/6S1
	+cVeVDygmxiUG8VtkB2CPCJ1/tK6dvcNCAWC+0w==
X-Google-Smtp-Source: AGHT+IE8YdNcoy9yHPyWH3FSVi3grCuLLJ8fT8RNUBKoMQxE9UzcTUruywG2qiU3pKHX1/up6wOF6uOUyIuOPTAbvgM=
X-Received: by 2002:a05:6102:953:b0:470:605a:6a4 with SMTP id
 a19-20020a056102095300b00470605a06a4mr10156813vsi.21.1708560547208; Wed, 21
 Feb 2024 16:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-9-surenb@google.com>
In-Reply-To: <20240221194052.927623-9-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:08:30 -0500
Message-ID: <CA+CK2bD-AvHR45zWrLOGA7Y=HQeFf=Ty4vCB5bWxbX7XyMsYRw@mail.gmail.com>
Subject: Re: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


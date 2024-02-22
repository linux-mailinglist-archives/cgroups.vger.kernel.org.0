Return-Path: <cgroups+bounces-1785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207F85EDAC
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A0284A19
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266A8C0B;
	Thu, 22 Feb 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="WMqOTNgo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9588628
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560638; cv=none; b=piMNXiVzU4N6qReDBDM0+7Q7jWaJCZMiOCdMREo1LGjbGu669J0NKxAcMTK9418rsouuS89sApAdYKN0DcgUywmPNfiatJK1av5hdRnrfHosOO9sV+AEREwO/zJ/DXpTGgZY9e4MqUfebESbOgPn+OqYl1yGW6cu8TNtkvfsZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560638; c=relaxed/simple;
	bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IC84L/v9BSJQgRdyMGOToOKqoZNf2eNk0hMuyAWgGM6RG/Uk6cAuuKYZm/BGuYVG4VPbxiDrsV8Q+v1ZBpjSspkCAWEQ7CL1k19u2/Fkai4xEKz1MoOamnQn4bX4XrKE3owRVVDxfhH0UzSNN3yG2Arthl7EHoSThrM9QSEA++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=WMqOTNgo; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so3085925241.0
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560635; x=1709165435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=WMqOTNgoyIMy5Skhg570/S9RfKRo+GGYJCSxO9Wx46wIXQMWTS2sf3E2BFDb9cb/Mi
         SqSc2RwztXYNSaB38gztWThpj5wG20etefD5/vzwCIiRM3djvQYDKyWZLyyB9HFAM9wd
         GMQZLr7NXKp6GOaIasT2JvwkONeaUgvXWnQcOrKHk1+ub3kdjAL8tbRRBT8znhaL2iy2
         quvghVEXB/K/qztLQ/o/HGZdmDIRYb4aRqmqlbUHD9a4EgJ8wr5jPA/6XG4Eo8myvR/W
         T/TCrdyLnp6jiwDXmMDE+CSg3Midm+48pxiNe04wJ4IpdOsHW8Q9uLnJqcwi+xwQqlmf
         Orvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560635; x=1709165435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=a5vNORCtZOTIt/q17l4rUKzUVZwHptiXm0P1Up9WqIdAp1ERNzPh8Cz0EE3sf5b5GF
         97WKvo3uqDtbsthffqxgPqg/gcWVRbo9SsaHWwE6MrrK0hGgdNVi4kVGF1iedKMz2hmA
         HaNJrbKQj5YaR55959QxQSBX9LwlsgSTl84HgvL/yUL/FWC88XIH5Bos0gfbLsO1VeOG
         zuEUoFYQzB4oiZSpQKSPQ9p/sENC3PlRH/i/Bz/+5x3uO+Z/slhm5uHrKzOffsXKLWbb
         2gGId76KZXaTU1DHBvPEPTxBnHVfn3XhOc8QE8Z4gXKGJRgrvXfS1TWOZQNWozTlgKh+
         AcIg==
X-Forwarded-Encrypted: i=1; AJvYcCWtzE4RCAGidj0NDoD4HNBbuMgE7vtzVjD90uahdHInY5oIOBClbWcISlRv0b6F9xNRtc//aKl8b1BUs001MW95wWzNed5WSg==
X-Gm-Message-State: AOJu0Yy4UL0fhUzJ8NWWcHpYxlGYW4/aNmRk+2jBS1dBd+JsnISfPyD4
	FmQrk4hUGBLEI8mCryBWlxBKFbfSwcWLU3E8J51UwTBpw7D1sgWpMBwJlPWH0MSqp3mdfAGQQkM
	K12w37OUBryMoIQepAqJueXoyhLqJivs4+Kqiig==
X-Google-Smtp-Source: AGHT+IGvkzT3uz6qELPJtraK+YKtQ9uJucd+Pri79etJZSzYbQUZmm3eTGpEAZMzRr8Ip545g98kCtUJT9vyheZUmog=
X-Received: by 2002:a67:f54a:0:b0:470:3ade:af52 with SMTP id
 z10-20020a67f54a000000b004703adeaf52mr11439980vsn.6.1708560634875; Wed, 21
 Feb 2024 16:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-10-surenb@google.com>
In-Reply-To: <20240221194052.927623-10-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:09:58 -0500
Message-ID: <CA+CK2bDWkrNapWD7pv47XQo8PD4qJ3O=U99pL3o72KCnrzpsXQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
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
> Slab extension objects can't be allocated before slab infrastructure is
> initialized. Some caches, like kmem_cache and kmem_cache_node, are create=
d
> before slab infrastructure is initialized. Objects from these caches can'=
t
> have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> caches and avoid creating extensions for objects allocated from these
> slabs.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


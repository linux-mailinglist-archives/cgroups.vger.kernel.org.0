Return-Path: <cgroups+bounces-4539-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A6962EDF
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376D9285AFC
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7291A706A;
	Wed, 28 Aug 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIKa0x+x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60119D8A4
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867369; cv=none; b=pYrZRIbvtTNtbWPTkudiI2LBELJCAyHT5f9DqOa9Z6FofyZnpa05MRJaxV52Z7BKan9ia/ZfExlKyVQPz6N73FQIzoBFAAlMLW9N+AJ/oOCYLkKCtHbxPVhT6X0axHNMc/eXhGgN6zS1xUADMxDk8pWFKpadzlRcUiK0CH8W5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867369; c=relaxed/simple;
	bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0F1iztnJTvBihGOSBX6QKIXmKGB+xJN9rvkn91eRsaUt/18HIAHcDXIKSZksoE2J6MTvrGT6G6Dc06gFLXPTPeXgxDRENCmel4OrvF1G1l8qMveGJ6lyF+7LREWril1GBKT4Jtmo78skBUbm0o//0JaC0ZmBe/GUXQs3IJBGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIKa0x+x; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4518d9fa2f4so29001cf.0
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867367; x=1725472167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
        b=kIKa0x+xqtwD5EL7eUVlv3OVYMfSxfIdH9fac+x+FhYW+BuaLhvIEm4vz2Sipdp5ql
         hS9UE8NXU2DeNhibSrhsMajF1R3rsNbUblKIDI3nYGTwuIRGIHENOVv+yf+5vMiiDjIZ
         OAIl344Hao9zg/Syou0c0AwuldfVRLjgz0edROAtxP8OnvJfMKoEgupoWglugqi4dC0m
         cZVZrgu1iyLZTScZ2mFTEF7kYpCC/U9CSjAcX4O3rYNMMdCI3tepmfzZNjwHupSE2KW2
         o0XyEe2kTEoH9gKFcoRm+ng9IsqkgOqv7Dn2ujoouoHb7xNPYRawAGw0+azH+1CQpO6o
         VGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867367; x=1725472167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
        b=AMCAzgYg1ZQjXcacSm0BqWZHax5GSPkFhm42cqGWqkx3SN7Qkq4fC2FqMn0p0dPngm
         PgXjRvwbkRMuIQrYUcKI+34MPC9UK6oj9jyXOjz/1AY3oHWlE9Owl690lMQtJtOxc7ON
         F5rGwB1JZITp+j++fDNs2nUFlUEpGCo1cFsQBOfCgcLsPKxZMa1MvfIMawWN6VSd0b+s
         IHChYuPs3fStGZ1ilbSt/R08vf8SvybxRdYVxJ9a/iYM1mMUCYbZVOZu8Gx7Qhtk4Xta
         A/G6xKLRHd0e5MSkb23nM91IQussFA3y/ip00DlAEWekx7SF8+v0bnQmw5m830QYChgH
         hRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfhB5AJqkn3m/qOfolixNew5G4xxS3vstJe1sf0dqpDllpioB9gyO8qKTBq5UQeoeAPNaKLKPe@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqgHH9fLhgIOlbxSydBx7JQRvM1KlifHFXoVs1NpgLPt3TsLP
	wzW6QSyWU6zFYGfPVhDJpKW+H6Hm1cwb+7nxiNfTS+nyVyzSEKqbwWAPlp24LwkPtxKnUxrgIfA
	QpPm/0RaloeDXmYyLZrfuJ1adPWwwrOE3Wx8y
X-Google-Smtp-Source: AGHT+IEYwBGfTFm2L33SK9fmz4kJbVLbv8hDQ2e+YiLDLKjI0fPHMvWbn4/4Yh3eoZmDzBbd9BzfQBf8B2iidi0ERBQ=
X-Received: by 2002:a05:622a:450a:b0:456:7ed1:c1cc with SMTP id
 d75a77b69052e-4567fcbf264mr58971cf.26.1724867366963; Wed, 28 Aug 2024
 10:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-4-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-4-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:12 -0700
Message-ID: <CABdmKX1PhoEHuVWAZGcF175-7fhxptY57feg0M8RK4hcePFXfw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 3/5] mm: increment gen # before restarting traversal
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> The generation number in struct mem_cgroup_reclaim_iter should be
> incremented on every round-trip. Currently, it is possible for a
> concurrent reclaimer to jump in at the end of the hierarchy, causing a
> traversal restart (resetting the iteration position) without
> incrementing the generation number.
>
> By resetting the position without incrementing the generation, it's
> possible for another ongoing mem_cgroup_iter() thread to walk the tree
> twice.
>
> Move the traversal restart such that the generation number is
> incremented before the restart.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


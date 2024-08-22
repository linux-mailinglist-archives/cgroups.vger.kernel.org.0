Return-Path: <cgroups+bounces-4413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9795BDB8
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF22B223FC
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636831CF283;
	Thu, 22 Aug 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGdogpHO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEE6F2F3
	for <cgroups@vger.kernel.org>; Thu, 22 Aug 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348980; cv=none; b=BVWQQeWJFZOPQcoTQERKrHVdKx3EgGBsh3OPuiRf73ze2MRPq+Ukzfu7bva2RbAYXFbNB0ZCPDoSXwdIT/5aOM9i4eTQTJmgNOg/quegb+z7Z7AaufrZTksR5mk3USwnhxYnqu7NROL2zA8yUuL+Y9xRnbfFJ25OPP9q04mTs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348980; c=relaxed/simple;
	bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAPvt0yxCri/+ZGmTYHHxzboOfD4Ww5GL4OReP2I6NdAUOd1brjnuEcKLCoAzuM0T/yn+VbXCa9gKMcC8dWM6G0MGJgD8qZbBN6AtamPP1RCJlYzA75mVZ3IxJAd4va5+S8ASTlb8RJpglxXA4y0Q3dJqWi6G+oalBPZfjBYOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGdogpHO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so151106466b.1
        for <cgroups@vger.kernel.org>; Thu, 22 Aug 2024 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724348977; x=1724953777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
        b=IGdogpHOjb5NzWbAEk3r9CZ7gj4xodI3StlT0ZC2Qz83u6oLAwEVZ3WtsQInH1jd8j
         U3rGz7VqEuGAzWn0WsDHuZ3YCgt9kNgeBf3sqcHOMES6GBnk8IsGRdPRqr0dgB4TRozC
         4iTiqZ+OTKhregxpggNrLfHTlfdqh1KcT6w0/4E/fGShSugr76WI/VoH0g4DziVxwELn
         APbJx6vawZoD1ysLfp9nXa+72FbFvg0YFeXVyFVbCg6C4lh6L3i5hgN8UxUGfExqlvgH
         cpyBk86yFRiH6tnTmGOC2pfeBivalnwKsll11x1qQZVeuPFxAvJHxRsb4jVeh44F8J9a
         Rwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348977; x=1724953777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DCNjjCKoSP4eyvhwLdjPqdqgDhehWVQKDeRIGJ9azU=;
        b=QgbamyKTBLc1dYXJI/8Rugta2/dYdQBDrpER72GRuQ4VdzQOFLjG/sGFPjMWNh2GgT
         ObpP8AXLPyLA22bmLpXyVHTSo7jYJqcRBxZHAvSJEtLgnLVWsxQM4oRWJJdsY8CxfTnP
         SzgiiHpievj1kqfhw3/s8NajGs7rz+ucSKzT+vOmVK6iywNu0TSiFTJuweBacAfdZfZx
         cw+fJiO7t8y5uRvc8DBxQMvHrtfkZgz7VDmvURCGWeonaDVbXKV7dtrtiiRXjhj849H4
         /i4FePXOVk1dBt+ozXgc5UuGZvZ7bgS7NBAmN4F5pAVDgw8ytK2kR6vQV2GnSK/wp/AE
         V2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUp1hZ6wjnpUNOT4csxmoMXiVMzJ7gMdIp3GEbf8A8orLWHkfPhEoa5la+ExsoGDPnz3YJiwz06@vger.kernel.org
X-Gm-Message-State: AOJu0YwOedXmWkXq92xz9oNCRkCLatSIBOMCJ7oUyLd+g9o0gz/fDAVg
	N2o/CRy+nw0n+t1CVGBYNyO36Vs3HbIHPL7Wy/nfXw7ugnwCAEJgZ21BsCkTn4mdoSaY6aOXMEB
	/QOs6x8whCU7TOCWrk29nNN/qSk7G1vTyCn5L
X-Google-Smtp-Source: AGHT+IE4IQPc9rbpt76DXkp3o0GnQk0sV4FVm/dLBBD+l2uTlPMrcgrYLjxXm0Xi/oBVM9Rz3LssTdd79gSz+FmJjI8=
X-Received: by 2002:a17:907:944c:b0:a7a:a89e:e230 with SMTP id
 a640c23a62f3a-a866f3600b7mr421320966b.30.1724348976225; Thu, 22 Aug 2024
 10:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com> <zsj4ilkso7p43qexiumk42bkzuqt5bxi3u5pys5arfpjodqszd@4jomnqwf4vim>
In-Reply-To: <zsj4ilkso7p43qexiumk42bkzuqt5bxi3u5pys5arfpjodqszd@4jomnqwf4vim>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 22 Aug 2024 10:49:00 -0700
Message-ID: <CAJD7tkZ28FSKOmA4dzVdTzR05_Qge9EcYGZzwMNgP7EHJOJHWQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:14=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Aug 14, 2024 at 01:22:01PM GMT, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > Anyway, both use cases make sense to me, disabling writeback
> > system-wide or in an entire subtree, and disabling writeback on the
> > root and then selectively enabling it. I am slightly inclined to the
> > first one (what this patch does).
> >
> > Considering the hierarchical cgroup knobs work, we usually use the
> > most restrictive limit among the ancestors. I guess it ultimately
> > depends on how we define "most restrictive". Disabling writeback is
> > restrictive in the sense that you don't have access to free some zswap
> > space to reclaim more memory. OTOH, disabling writeback also means
> > that your zswapped memory won't go to disk under memory pressure, so
> > in that sense it would be restrictive to force writeback :)
> >
> > Usually, the "default" is the non-restrictive thing, and then you can
> > set restrictions that apply to all children (e.g. no limits are set by
> > default). Since writeback is enabled by default, it seems like the
> > restriction would be disabling writeback. Hence, it would make sense
> > to inherit zswap disabling (i.e. only writeback if all ancestors allow
> > it, like this patch does).
> >
> > What we do today dismisses inheritance completely, so it seems to me
> > like it should be changed anyway.
>
> I subscribe to inheritance (at cgroup creation) not proving well (in
> general). Here's the case of expecting hierarchical semantic of the
> attribute.
>
> With this change -- is there any point in keeping the inheritance
> around? (Simply default to enabled.)

Agreed, please feel free to include a patch in your next version that
does that, and add "Fixes" tags and Cc:stable so that the changes are
backported and users get these changes ASAP.


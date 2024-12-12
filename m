Return-Path: <cgroups+bounces-5867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5529EFAA1
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BD828341B
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF822541B;
	Thu, 12 Dec 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LctDjE9p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB0223C7A;
	Thu, 12 Dec 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027098; cv=none; b=Hc8teiiv6gDLnExK2ZVlH8DWtJGUa3WdfKGRJqmcRBYargA6wHuAkamq5511vdqC952LC9j8XSCnevuPSwiw1E67fbO13YSh21ivCYnXKGElQ5HvVhn4TPPbpE4PQ6mxTIHnjeBwKcXSiqXEmgitqQcc5XCDi57KuIDKo2rg9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027098; c=relaxed/simple;
	bh=fmL3IjdHxzakIx4CxIGIr9XO6NTz4sWtktTZlSVEfDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9MroimIHoWPKnhoS7ivq3itzsReSL8MSJ7k8yYiQ/SIMYphWxg6wQUSEujalvMbTr+FdDOl7h6XT0V+r718JGXXZ35fPA5oUerF8fXd/v/KossnXtoqNoxtzvSAmoNuUZjOxWrjVnyYtN1dowzIHCl6LvOIeWZ+ZwlcNsbdDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LctDjE9p; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8f544d227so5458046d6.1;
        Thu, 12 Dec 2024 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734027093; x=1734631893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmL3IjdHxzakIx4CxIGIr9XO6NTz4sWtktTZlSVEfDA=;
        b=LctDjE9pjflGBSxQIJWdGBo+dYKcL6mW/voj/14wv3C5ywtsNTBytJ8IvbQkkPcGGz
         gR0Xmp9t3QcKp5JZtNVZuaauIw87ZPersxdaRbaoLZW4GyANq2kTDgfHPSHphhcc9a3S
         xqhdN6gqnlS58ZgKaGXzY8bMAhKCXFIHM0+irKDxpRQhAPvRmogjulhJRUEUi5e5vAIQ
         nBevbgY8pWj8U+ynMbAqkzC3fESwM+Snd9lwrt1WmOHmb995hgIF+z/Lub93QQrZfhye
         0nfN6xX9NWvmfnPORt29MKOwejGj8Hl2zzYIaXmd0YqIVKl6dYZBtBahxb3WDKlhY0Gr
         haLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027093; x=1734631893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmL3IjdHxzakIx4CxIGIr9XO6NTz4sWtktTZlSVEfDA=;
        b=Sre7dBkeNV1tAt2OaTzO0K8HKhlHB3nNArNQycxC+CPM9KmvMt5Dt19GyALV+sMzD7
         ZKXop3j63f4ZC6nXnQhbPrGBZ925lvpEooUkD5XwblyvKrrIZywxjiar4E8zmk4Yyr9D
         qMbVZf5ZKrfgv53idrefjXa/TXltls1ljVuN4dYe5N79q+k7vA34P1TLB9emAJ1Fz3UD
         0t+7FPDWaXXhEwPsBfv7DsvML0my82Ls395Vu4TtNYfo1xpEKzxO40fM6RfUrOZX6e1U
         wKYMRR2sj/txFXpVF73w+56x6fVc9dqIv730bz07vPhVu6tEh3V35Dw2yurhJycI+yHj
         huog==
X-Forwarded-Encrypted: i=1; AJvYcCVOxy4pLL7cJCFG4mW6Cie5dLyJnU0w0iIbGwFARD4Nm9pzibis+yaQPkvzU/f8/Oihv5kg48kierY96eow@vger.kernel.org, AJvYcCWlUJ1ZpcNiB3xAU+/h/z5PUOCChtDOXIEuNRuAF8rREYYhOo9XnlXhMgRbxiRLrETlUO44JAH8@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAh/1qx1nZ66yX0bk3Td6NdU3nGgj+FZIq5V9mXuARauSywdl
	enfGjjqYUgddWlNSTvk7hCCiWWigQXB9QGY0QyoOOcDu++Jq0IDemM5N686s6Whx5mCMTUFSkUI
	iWLRSgNhGSYv7M/5Ykq039+74T1Q=
X-Gm-Gg: ASbGncsx0Es050L7+5ouFYjm4BtOUXiW/ZQjqva7F9i+1wVu51sMZjD5jDE+DPBq8fq
	/A9hrC8gIguSIW/9BLxYFtwL1Ma6XMrXTMFVi20SYvq+oufXQPqsw3A==
X-Google-Smtp-Source: AGHT+IGdSVDteaH2QQbaWou/DQ1MrAOaTamUlb5Me1k16b6VG4xFSaTPJKAjeBQlXrI/yb9wHqeA55Hx8Uz5Hkk9GWo=
X-Received: by 2002:a05:6214:2584:b0:6d4:2910:7f12 with SMTP id
 6a1803df08f44-6db0f827c69mr21459886d6.41.1734027093508; Thu, 12 Dec 2024
 10:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212115754.38f798b3@fangorn> <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
In-Reply-To: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Dec 2024 10:11:22 -0800
Message-ID: <CAKEwX=NyWC6UkC2DAPqi16kwTG3tgspQZmuGmcE928ghyiDeDg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Rik van Riel <riel@surriel.com>, Balbir Singh <balbirs@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, hakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:07=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Dec 12, 2024 at 8:58=E2=80=AFAM Rik van Riel <riel@surriel.com> w=
rote:
>
> I still think maybe this needs to be fixed on the memcg side, at least
> by not making exiting tasks try really hard to reclaim memory to the
> point where this becomes a problem. IIUC there could be other reasons
> why reclaim may take too long, but maybe not as pathological as this
> case to be fair. I will let the memcg maintainers chime in for this.

FWIW, we did have some internal discussions regarding this. We think
that for now, this is a good-enough stopgap solution - it remains to
be seen whether other more "permanent fixes" are needed, or will not
also regress other scenarios. And they are definitely more complicated
than the solution Rik is proposing here :)

>
> If there's a fundamental reason why this cannot be fixed on the memcg
> side, I don't object to this change.
>
> Nhat, any objections on your end? I think your fleet workloads were
> the first users of this interface. Does this break their expectations?

I had similar concerns as yours, so we rolled the solution to the
hosts in trouble. AFAICS:

1. It allowed the pathological workload to make forward progress with
the exiting procedure.

2. The other workloads (who also have memory.zswap.writeback disabled)
did not observe any regression.


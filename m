Return-Path: <cgroups+bounces-1243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB4683E394
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34F81F27184
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589924204;
	Fri, 26 Jan 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlL8imhS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E723249EC
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302956; cv=none; b=oDoGj29oxm0R5hfvMmEwQiAl3pRcZBRdf8gHK8T5/EcHIh7QPP9feq1DLuadr90UK/vCk3VT0lETssA1H+g0sHi+Mw19ItO7fUYU+uYZ1IG728nahjBy8AXQqrUcQ4iU8CUAuhljNUuoxJ40mPz0ADdPWVKpR6YpwlZb5nwI6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302956; c=relaxed/simple;
	bh=NhbVdYdf9iXK0nhJbVHWyWMtXRTj04J6yLcrgUAT+JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk6QTbfxEWNlvuRvdLPSXobfemeq8au9wjXYrZ+6X7NjYxlJcGy6lMQnI9xW5D8SSbhIemdERuoDS4hQGE7tLnaTLHxXgM+rD5+Xlnma3RnbDO3zgnvv34A3G0EUUUgku0DVru5wvxhTwghOCSWzXLJGOEqdfwqZhnTkiXLj9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlL8imhS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5ce88b51cso41805ad.0
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706302955; x=1706907755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhbVdYdf9iXK0nhJbVHWyWMtXRTj04J6yLcrgUAT+JA=;
        b=BlL8imhStvGLGGjFAbA3iU/YdGZ7TgalIHKFwL7nRIJONUyeocsxI1yilh2/Ie78J9
         mqxxAF0UXl0cr4tRza1rPI746IWo2LcBruq+WfoAGlAA3Kf3vrn2jVTetVLQyy1DHA1f
         9DUB3ZNp6DyvaQ0w1UlhPuk4Ro4JlnozpgDX7RZCaqp+0TscT/Q/yWVpIlDNN4Z9jcQC
         EGPO0jOMR9ODPzBSLSnOggr01DhrEJ0wQAniSyhnA0C9Da58duHR0d4rhBr8YO947/76
         VZTB/pEhusHa6oy9fgMOXECWfCf55y4+sRclAue6Db0D5OzXBu2kQkHCeECe4iW6ksVw
         bc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302955; x=1706907755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhbVdYdf9iXK0nhJbVHWyWMtXRTj04J6yLcrgUAT+JA=;
        b=QnlmiJpDDvGhqBpUC10Lc5+gacEKWBrTjLzlLe2eUqg3XalUH2n0I9861tc1SnODaz
         WWJRZ+w47G+BCPE1ZmjorX/gn/RPC3m0i/2Mukzj2gMVchAh1U900UCitFZ34FKNNmDW
         3ozIPuwOe3jAdgWGsUp+e1cHI56IkIOKvgQ2B5T8QlphRmpP1MGQ0tcjOmX9pu0qaffm
         MOLjJMAayU8LUNrD4cHLm9QhFs/wpAjqgMNo6Z8fMmRkmtbhCu2pCJY+f0cIUG2kzvyq
         p+2PRc+KeR9ypw/4/YdFdnQEcN1Dx6x/gst8cG+teKos6s9rBLAGl6h1xaeziFp52dtH
         8Ckw==
X-Gm-Message-State: AOJu0YzN0b8mlYnjBBLjHaMF3l9HZfwg1ULpXHNPE07Ef1fpJA5g5AU8
	qo+X9ph/ApxgdYyI2tI7wSVvjGRq+bE/wHbmRSceTiT2hjuapqAugy51iMH1XlIOFxJD5+Xss2i
	DTD3RCKTgjGKWX4Cm+TsGYBp/8vAwgyQXFp7D
X-Google-Smtp-Source: AGHT+IEHXifKfydOBlCtNuN8Oq2e9oDoysKPEPKuvtnmdtJeP83zNTX6sEG9mhcN/FZmToVFalnIx8RawAX1m1VVAv0=
X-Received: by 2002:a17:902:d485:b0:1d7:3ad7:f23e with SMTP id
 c5-20020a170902d48500b001d73ad7f23emr294723plg.4.1706302954390; Fri, 26 Jan
 2024 13:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126203353.1163059-1-tjmercier@google.com>
In-Reply-To: <20240126203353.1163059-1-tjmercier@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 26 Jan 2024 13:02:22 -0800
Message-ID: <CALvZod5_vZJFc0i0nGuEj3xt=9p9Jny682LRyb5oQpHvVk_ewg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: Don't periodically flush stats when memcg is disabled
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:34=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> The root memcg is onlined even when memcg is disabled. When it's onlined
> a 2 second periodic stat flush is started, but no stat flushing is
> required when memcg is disabled because there can be no child memcgs.
> Most calls to flush memcg stats are avoided when memcg is disabled as a
> result of the mem_cgroup_disabled check [1] added in [2], but the

Remove [1] reference and instead of [2] add the actual commit reference.

> periodic flushing started in mem_cgroup_css_online is not. Skip it.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/mm/memcontrol.c?h=3Dv6.8-rc1#n753
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7d7ef0a4686abe43cd76a141b340a348f45ecdf2
>
> Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> Reported-by: Minchan Kim <minchan@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>


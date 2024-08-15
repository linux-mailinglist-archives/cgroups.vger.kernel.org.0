Return-Path: <cgroups+bounces-4288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784739526C4
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 02:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349D62823B8
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1A2CA2;
	Thu, 15 Aug 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVWRG3yI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC4A5F;
	Thu, 15 Aug 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681188; cv=none; b=tq1J8TAX9CntuWiNZMfvpC1utDzOnd7KrsV2hu6xWtVGQSXkTT7dZGNuQKIYwW10Lo6gvbu91zGIDgVzx39a5NwTMnucCvMIb05BI33xSNob6KCpiSS87UbEy5xj29SQs8mSigwBLvFFv3eNhUhTepnZBRRUlUnrJ9SK14VMjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681188; c=relaxed/simple;
	bh=eznOTm3ynozSHweI22j7wx8lPoMoW2ORyhMLp+FxYpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipO1peVNzV6Ir0Pbx5hK89fivLFiVjy4mxvhpb8xmQxXit7wraKrA5l29ROzu9h1bMVrw6vQy0YLTpxXakNM+ddzTnfi0wkGvpwfTYKYzvQAYwAexrJDSsn2hLISPADN0OB4IRjQ35kti43VxMAiJdLmIFLwCw5asM30OL6zx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVWRG3yI; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f8dbdbba98so240890e0c.0;
        Wed, 14 Aug 2024 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723681186; x=1724285986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eznOTm3ynozSHweI22j7wx8lPoMoW2ORyhMLp+FxYpo=;
        b=eVWRG3yIrWqngqzFXGVLsETI9WnTwsMfsHkjfmY3pomUnGs68OAgVv4Xw6YrGPiY0e
         hb9gIDonjrJfHC0dLbs6KQcpw+Cta2iLwW6pb9LUH2UtgiiwvRvLXqHcn8kutp97IJNd
         vOjMaC71s/8rE9oPz8EBYZo5W8MDbfx3a+uIwhPuhcQLxLQA49Ru1rKM4gcdNpBabmlx
         M/2n0PUlPSRJNTud22AZINxFcxC5ei5MrCOsITHMeO5LfgWL5HugIOmYeETmHinSx3rV
         jnK6GPfLHI7n3poq6Ubxl9m3M8y+pY03iMRSm6/ZH1+VftsYUScXN0wh++K8L1FBYoe8
         pilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681186; x=1724285986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eznOTm3ynozSHweI22j7wx8lPoMoW2ORyhMLp+FxYpo=;
        b=EPCm7sJwbUa6KQHIeMf7nVLoNtGeYWdqWYTyyN94AK4/M/BZzrNFiZ2Er8yoVNs/Iy
         hh1ZNbm/l3VDdOjpuX1j8cruQRsx+APr+UygpAmfjQi8DqIOmAG94QUrhWZlzzEa/I+Y
         ErnnuP3tgZoewerpd2I48o60GE/4pKku2y3gzhpRcBJcP4cxFSyloj3wrMn+7MK7PtQv
         mLHtfxv40nu3Y0m6KQ4Ed5a8idcztkxJtGrchv5Z+qXIpxsE/JyIWFwWHfCUzWRckF5i
         rY/PsRe+8LaH4q2YGd1xBEimkgpRJeVfiwGVcUo2xYkxAZTOyrZ5HpkScQec/z4cgCL0
         Twtw==
X-Forwarded-Encrypted: i=1; AJvYcCWWvh7ea+JhVDBsoc2DXI57ZkFeRDrvjkB+oZrSGKezvlkGIrZm17nw3Zg6nttj8cETh7UCVa8kEpRtri0mayFBCOVuA9rz+o0Fm3YBqnQFjMFWQjuF73mQuv+vxiusfDzNSpvR6Q==
X-Gm-Message-State: AOJu0YwaG1XzoeOsmTGz9LnHbcekFvR8mnA/6OUFdFJKUyMCWbDMgBLM
	19rxe71MuJ4DSpxPGBePqCN7eUhMRKR7NlPCvCu9ZE/RiObgluJpXgseE/I9xvC+SttA1CIOf0i
	IF5442W/i6hBv1BA5M8cF8KdLkDc=
X-Google-Smtp-Source: AGHT+IHC6q+8vQy0L7kN0debqc07t8H13UbGw4odWWG2AjlPQsS0oDHBMV/8hDeHk29hOt8ZwkFOb8wdu9WGpTExY+c=
X-Received: by 2002:a05:6122:7ca:b0:4f5:d98:5ec3 with SMTP id
 71dfb90a1353d-4fc590af5b7mr1020468e0c.6.1723681186046; Wed, 14 Aug 2024
 17:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
 <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org> <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
 <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
 <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7> <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com>
In-Reply-To: <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 14 Aug 2024 17:19:35 -0700
Message-ID: <CAKEwX=M7sWx94nJ0zK-46Xn8ZZHhcHQtb37qR0Jxit+8sAaQWg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
>
> We can also use such atomic counters in obj_cgroup_may_zswap() and
> eliminate the rstat flush there as well. Same for zswap_current_read()
> probably.

zswap/zswapped are subtree-cumulative counters. Would that be a problem?

>
> Most in-kernel flushers really only need a few stats, so I am
> wondering if it's better to incrementally move these ones outside of
> the rstat framework and completely eliminate in-kernel flushers. For
> instance, MGLRU does not require the flush that reclaim does as
> Shakeel pointed out.
>
> This will solve so many scalability problems that all of us have
> observed at some point or another and tried to optimize. I believe
> using rstat for userspace reads was the original intention anyway.

But yeah, the fewer in-kernel flushers we have, the fewer
scalability/lock contention issues there will be. Not an expert in
this area, but sounds like a worthwhile direction to pursue.


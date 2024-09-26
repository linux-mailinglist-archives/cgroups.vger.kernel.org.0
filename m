Return-Path: <cgroups+bounces-4960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8000987B84
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 01:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4011F23CD6
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 23:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9141B0108;
	Thu, 26 Sep 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGCRrHpX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35999282FA;
	Thu, 26 Sep 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392392; cv=none; b=tHLtEmzzURQ/Q13iXmBIImK1ZQxkbtJ/ZyDGFZbw9kwfkTu6BJTYvtZgaPlnWHgsaHe+Hh3D9cCwsa/YNnqCyOSz+pnAHI+pDXAtIJ+7yUs4O8+FHEgVBUAn+GyYMDH1trJYI4b7MsYB8EXO+1dh6ldkxvITFufMEZrDjP6/cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392392; c=relaxed/simple;
	bh=+QnUsmj6HlQHE3dHsolrlcWBEAVey350DkJs28RZJuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1gYMEGCIxr+I0Hg+sxYRi1npLhIj45Wzxv1iZ6//CBxYz30lRzMnozpwkSCkVoGpQ7gWAkP2XwXan9TbFd2NQHPwRaGOkUa5eeiZrcN4c28iUOYOFWRvkDtW9a4yNlydQGsfdXYgZNSrRMJm/qBqfEXetgTomqv2l0yxrtMOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGCRrHpX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c582ca168fso10550946d6.2;
        Thu, 26 Sep 2024 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727392389; x=1727997189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QnUsmj6HlQHE3dHsolrlcWBEAVey350DkJs28RZJuU=;
        b=DGCRrHpX/dxM8pNJx/t49nKffKYWLDlVXp6n4kef6vS3Mya1OeFo3iw+dEmGaenA4x
         I+tWS4lF8YW6tvj2m+zgHtdkH0tpdqf652djgk3ID+WPuAUWHm/PqgkJdAGRkExiYm3c
         IwUmjmIC7NXmr51x3ztqTP9vYxYyKSmOU4ylOkiGmc3MT/Ul2ENoQ6emQMF8kqegEAOZ
         594tPZF8Vohu30F7ljHjIX7MTKe/M9ZFiEHGPX5szzoHmq4l5DYde+HBm44wM1KX3vdo
         LU+stbQZR9FYBCas9dszTx4smfn7+tLHKJUM4ZWaiF1Za14qGW9F5fZHtmbQsDmGEw5J
         tVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727392389; x=1727997189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QnUsmj6HlQHE3dHsolrlcWBEAVey350DkJs28RZJuU=;
        b=OEDptL44vB32VnryjKrxN9CHi358d3LPzP+f83OxDKIyY0n5gcxgXIe3MBl1mWHUXG
         g0Bx9hXKdwQoyCSTjmIlqrJ8ZLQcQPSatmNPf9eTejNFfOj8bWWggBeZ1I+ozyKDFZev
         7LMPwJbA3Hqc6ctDLADrlfSI2lup0MveVw44i3M88CW55YutW2d3AVrf1lnPerZn+ibf
         ov2RW9US8mgkOE9BC38np15g6irpnV89lzH8QsB95iV9miQgzto2V6eqN3THAt4RKE/i
         oKVt4OfLIdkrpBEeqTRqCtMhOjKccVa6vheGPIM3+AvD7ahtEFWlbb2kD4yVH1u2VS7F
         9OFw==
X-Forwarded-Encrypted: i=1; AJvYcCWyZuo3rcty8vp1aq91nwNJZ2mIVr8CgrO11gbLznFjG/cbkzUOUppfzNxyGNGYHcDWAUvaH+1p@vger.kernel.org, AJvYcCXtrZtdBte+oXAVfEEe1jrsem0O8ChW+F8zhrzxFlqhZ5mozv3a7HU8A4euJ3NmQiUYpiEedmWwevn7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfb9ZKrSqrLxK0hTGx0yPOg0Y5Z38xybRtTT78vMuHy7qWbEbo
	RxxmV0Hf/YymLNt5RWERKVUX2X5QnSDObnpQQtLzTXfTO7zPd/ejJwmVa9dBdzvBfU+pgQ/iSbe
	jvIO6ombZwGKziSK6LtbQYxBtVfk=
X-Google-Smtp-Source: AGHT+IFwc4f5kyKAfJNVropwB7Maj3cXwYzRuG9QJBw+rGCgZmFQaltgr3CCdn3mYqSHswUhEmCCe+GqKdUxQ6zosuw=
X-Received: by 2002:a05:6214:3187:b0:6cb:3643:3370 with SMTP id
 6a1803df08f44-6cb3b5e8b2cmr27343926d6.23.1727392389141; Thu, 26 Sep 2024
 16:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926225531.700742-1-intelfx@intelfx.name>
In-Reply-To: <20240926225531.700742-1-intelfx@intelfx.name>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 26 Sep 2024 16:12:58 -0700
Message-ID: <CAKEwX=MmCKrOkvDO5Yc_M8EB+k5U9AZ3boEiu4u2HUb7p0z+Kw@mail.gmail.com>
Subject: Re: [PATCH] zswap: improve memory.zswap.writeback inheritance
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-kernel@vger.kernel.org, Mike Yuan <me@yhndnzj.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:55=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> Improve the inheritance behavior of the `memory.zswap.writeback` cgroup
> attribute introduced during the 6.11 cycle. Specifically, in 6.11 we
> walk the parent cgroups until we find a _disabled_ writeback, which does
> not allow the user to selectively enable zswap writeback while having it
> disabled by default.

Is there an actual need for this? This is a theoretical use case I
thought of (and raised), but I don't think anybody actually wants
this...?

Besides, most people who want this can just:

1. Enable zswap writeback on root cgroup (and all non-leaf cgroups).

2. Disable zswap writeback on leaf cgroups on creation by default.

3. Selectively enable zswap writeback for the leaf cgroups.

All of this is quite doable in userspace. It's not even _that_ racy -
just do this before adding tasks etc. to the cgroup?


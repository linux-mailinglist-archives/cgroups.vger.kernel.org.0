Return-Path: <cgroups+bounces-5521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D29C65D7
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 01:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24212285CBC
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB92F36;
	Wed, 13 Nov 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEZjXrJm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE123A6
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457194; cv=none; b=jvGrGqGv7QYWUCq+uOWRmKd3VtdfmP5ElxOJ4Bt4g8Ql/xis5BLGuQqDa26g0bGrz6pKNc+F/gAplMf914qcILeawG/taSP8/Tz/tNAqCbxMcJKn2mFZ/YTXyPiFcIBKCt9GvkZ3WkJ8CILWWNYqSg8MvWMhZiLYJ1uH/nsoUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457194; c=relaxed/simple;
	bh=n6LGoLV9gZFPi/bSk5JT9WySVlojUnnNnhNZN+c71UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM1oFb/OfSIh2rdLUPpyXkv90TKdTDBrzwkBnY38VaSvUhXPj39TUM7sth6tXbjUoAT9s7+vJRxvdRkMt3LaX1jhCihitfkOd2Q88fEmOlmPDIhMen1vrxfzXYFz7jIFNil21JiHV5y22B61O1WcHHdtCiJnqALXIylQbUiv9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEZjXrJm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea1407e978so56456967b3.1
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2024 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731457192; x=1732061992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syV3yYdAawmGgH9foa1REVrhWT3O13PH4ob3NUaHMYI=;
        b=WEZjXrJmasmG+Xim+xhluljaLNlk/2CJxwGIuvY/n1kkM9flzH5GO6ty+Yt3Mdo/Yy
         hhjCKF4qAwPqVwmsfdrux+sNlUHWmX/zyoYq+xf3rqx0vRIn6+1VcpHtyM+z/vmZq4s4
         DDpDZByrXOOdTfubWotfPLW11qFGJK2tVh0zbnRzSWBX0RUPVRfKeKLcIGXoFsnw4LRM
         FszoMG1gJRas7vXpNT0PKfTbWPft/OXVhq+UT4PYm7YnNozdT56XFpg28lYM/91nokCg
         QWh/fPN6z9WQ4lyR1g5dqwmgFfzNcVbRshue0Iqh3J+drV9WvEnAth7Kvye1UedxS99y
         KiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457192; x=1732061992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syV3yYdAawmGgH9foa1REVrhWT3O13PH4ob3NUaHMYI=;
        b=xMjaPnJJhlqrjFqkSgSE4aqoVGjj72BF68SneM7E3lOCPkU3o+cRR2gC5LHj9oo5yj
         r+V3UMYAsil9lz8UA78/tko/pf4sCyXVjjbLCWWu5Cs29xSl8aw1u1KRma3KyF3nyaMF
         pInFu+F+19b7kv3rONrfJQJ4A71P6BkihN4V2Uv8B9Pj0KCbceqHrYXY5cqsYRZI8ASJ
         wMxPxZSQYJX809Njiapo8/cryAseelWmRr7+p+Im57GF1FH8ixzplEzJ47alLFINaA1k
         FSM5XJ8VMAWVw++LXVRgT8G6BakMh1EJr6J+Fo47PzYUKrFQ/BFe8rS85yXDImv2iAWj
         3C7A==
X-Forwarded-Encrypted: i=1; AJvYcCWS46I/rstkWCgKnSACnug+99xpcjIXHofR8nDC+sE5xAJrQRdyPiFqaHGlo6bEOoZmdYE9qy6a@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmSWB3aR9sNWLIttp9ZNAEpj1Y9KLYPPTvb7GczAEblAClL7Z
	VakdfK+BOBmZipL9O51m0Y4pROrcy38ukdBDghreYCbHUVpTdFdEm2Awz1QkW0rDBgqpItdSraC
	pBxNZXKuUxP7yz7ygmk2uvEtfQ4qNUq80MU/k
X-Google-Smtp-Source: AGHT+IGixxxDoJV0YMo0rwsoyhEldF96phuEv/rTRk4BAVR+x+HH2OZUws6MZb7CLu9ro/nwBiDd24leVC52cMq5E3U=
X-Received: by 2002:a05:690c:744a:b0:6e3:1ce7:addd with SMTP id
 00721157ae682-6eaddfc5cbcmr187848187b3.37.1731457191802; Tue, 12 Nov 2024
 16:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031224551.1736113-1-kinseyho@google.com> <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
In-Reply-To: <20241031160604.bcd5740390f05a01409b64f3@linux-foundation.org>
From: Kinsey Ho <kinseyho@google.com>
Date: Tue, 12 Nov 2024 16:19:41 -0800
Message-ID: <CAF6N3nXPw8qv-Rmg6CX1afpkc7DmTQEL06LeDvY=Hcj0AnVx_w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 0/2] Track pages allocated for struct
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>, Sourav Panda <souravpanda@google.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for the review and comments!

On Fri, Nov 1, 2024 at 6:57=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> hm.
>
> On Thu, 31 Oct 2024 22:45:49 +0000 Kinsey Ho <kinseyho@google.com> wrote:
>
> > We noticed high overhead for pages allocated for struct swap_cgroup in
> > our fleet.
>
> This is scanty.  Please describe the problem further.

In our fleet, we had machines with multiple large swap files
configured, and we noticed that we hadn't accounted for the overhead
from the pages allocated for struct swap_cgroup. In some cases, we saw
a couple GiB of overhead from these pages, so this patchset's goal is
to expose this overhead value for easier detection.

> And: "the existing use case" is OK with a global counter, but what about
> future use cases?
>
> And: what are the future use cases?

As global counting already exists with memmap/memmap_boot pages, the
introduction of a generic global counter interface was just to try and
aggregate the global counting code when introducing another use case.
However, since the value of pages allocated for swap_cgroup can be
derived from /proc/swaps, it doesn't seem warranted that a new entry
be added to vmstat. We've decided to drop this patchset. Thanks again!


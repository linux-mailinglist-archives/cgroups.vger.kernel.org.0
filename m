Return-Path: <cgroups+bounces-944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACA811980
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 17:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9178281AE9
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715224B5C;
	Wed, 13 Dec 2023 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF7mb5WI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CBAC
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 08:31:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-552231d9c1dso1119649a12.0
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702485097; x=1703089897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvHJ0z24yDBLH5ChK6i87dshEacgvg+vBs2gjaCwRnQ=;
        b=BF7mb5WIanen9cgY2ta05QujVVJjxb5e0Mi2sDtiCvYm6L8Xc7ox2BFgsA2AjiPZPW
         y6JjHUPjuofMN35/ddPXjSzm2VQnzJtLfIf7/J3uJot69pt9GJnKaf4xIrrQAp5rOFq4
         wizV07a87fLhLgUo9gKGqySAHFVYoaffyKsZHfdB+dI4gdnUHZITvKGiLXf2hQhktYEE
         LnIXl0fxsDf4rPZU51ecE8KjNMTAyR/FHRS3RIBU4y8JSRQ5PzQE0Mq6knbtPh8rfi2x
         /6vIQbvTucsXjWd5sIHwTvIr5syznJqbPsYM/wThlXV2gnSg6ztwwSbpXCHhd9SnLini
         qOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485097; x=1703089897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvHJ0z24yDBLH5ChK6i87dshEacgvg+vBs2gjaCwRnQ=;
        b=qb2cS1hE6+ciIgbjZNjX8Y0KKEP0RPGTvY7MWrvUpZJd35KF0Ox6BCTt+a89El41FH
         zP8AeuWnS5mnfKr5l1N7XyyoGcS0sv8rpSOv80dFqpfRVh1HEFZ73yoXVZdc0KiNmtXJ
         eEhdqEdXVnlfPcfyBpoFNgCYA/g7IsJHp/2D+LgeshUEcDaXedapzi9BNLD9L9gfjPug
         gH3bLcKRnId4fKLeEtGDvHSav9EhAViJDtIb0JbKFPKYetxkTwRN91jo4V0lhFzzXci2
         ovtHubkwSMXLcokkjP/blZPR9P2a5sd+BkEo45d4lRy96FKEtRT90WvgYSzzN+1zwKZF
         3ksA==
X-Gm-Message-State: AOJu0YxSGIK5YnsNjrcYXZ9WVmopXdjMI0qjxVRpDqhHs5J6phYCMXC8
	o3CPsm3RT7UjGMi1rG86R/gk3IL66Cg2LqyIHlB90A==
X-Google-Smtp-Source: AGHT+IGoQhgQhqCoHUeW9X0vV2ZDD9hgbqpFaW5uYHpMo8yALDWbSlq0ea0S1odZVzXp3mV+23C/+m2URiXRYMbQIig=
X-Received: by 2002:a17:906:749e:b0:a22:fbdf:867c with SMTP id
 e30-20020a170906749e00b00a22fbdf867cmr647419ejl.128.1702485097270; Wed, 13
 Dec 2023 08:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org> <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org> <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org>
In-Reply-To: <ZXnbZlrOmrapIpb4@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 08:31:00 -0800
Message-ID: <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > I doubt an extra compound_head() will matter in that path, but if you
> > feel strongly about it that's okay. It's a nice cleanup that's all.
>
> i don't even understand why you think it's a nice cleanup.

free_pages_prepare() is directly calling __memcg_kmem_uncharge_page()
instead of memcg_kmem_uncharge_page(), and open-coding checks that
already exist in both of them to avoid the unnecessary function call
if possible. I think this should be the job of
memcg_kmem_uncharge_page(), but it's currently missing the
PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).

So I think moving that check to the wrapper allows
free_pages_prepare() to call memcg_kmem_uncharge_page() and without
worrying about those memcg-specific checks.


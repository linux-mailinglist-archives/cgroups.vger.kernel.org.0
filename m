Return-Path: <cgroups+bounces-1501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987AD852B0D
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 09:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389D81F21F06
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80B17C62;
	Tue, 13 Feb 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1xv54YP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D720DF8
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812719; cv=none; b=peboEl+i501kNAisgCStbYjMPM2X7GRCgz4X2xTDygn3iU1jA/S5qX0MjiX+ZLDXeBlNigODFqEpWNaCtmLtVjBMpmOvjZO/Jr3z6lBt2iUzpb9yZ0+ylaNs/O030GeJJghDWqIpm0iigNn9yNEP/iNa3cx394cuHoY3yo2Vv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812719; c=relaxed/simple;
	bh=DK6mlQkynMPzOyZm3n/CXJ9ZPl09j2J6eJlH3PufCCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZEzOm5/5fPA7mqwnGv/IVNr+doGwTXx2C/IR95m6CsihCNTJQ0NEnXfbIEwp2oJmrHn/x0esZKfu0YnEHUGvu8Fl/+UvB8wtAHqBidzG2BjFkjdlJC47GL+TWyly+VKEAhRNov7VXB0lJxWvWFF1wZTK4QQlVyV8dAfD5uJSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1xv54YP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ce44c5ac0so121576166b.1
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 00:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812715; x=1708417515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B05LEYyR3ICjwHDeiWKyMo5pzjYfYHSKORFyqZMjQsw=;
        b=x1xv54YP95vma4V6igUvg9Jsnf9pJ9DScD9ZGP/rY5NgGc8NILvME0r2RUFM8T3JmZ
         IcN0fC3VdOmCBMxtaPrVRP4WJfek/OiNymCmJbcIm0d95OnMsqKMuIrvcOoQR8fY7cCN
         isPq/GnH7tnctozPfi039HOeVzVXXMhnzEhtj2eXO0gpa54iB1CVoyPgUGMY8pwj5NBX
         YXOHDyqM1YQ7eTpITcH0In+b06H50Bq2oBOMzeNbl0Yjk0hXEFT+tr+0nXKgl7xflGYC
         FVuiNDy47T61B5TfEHxgDjlPBOB8EQ+Bdu1sWKaLE6F9h5d9i+m39stoAGhfPhlody6K
         f8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812715; x=1708417515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B05LEYyR3ICjwHDeiWKyMo5pzjYfYHSKORFyqZMjQsw=;
        b=RI9i4RmjluJcn+DmuVsVCVDJE1LKkU7l61xUXcynC56IT7KEeWw1B7Qf4g/CM4wF8u
         gcMuOJNN2PNE0TR8hjhyUOhXOnFrwOVf4cuUUKHPArj9YALqasCR+pKsWOHeBqT82kji
         29+C/TN3/JWXtruZZljJxZhDeAGhLhJZp2LOWaPeakufQ6tmp+kIIU8jc6wMV/uY4mlH
         NcVgv4kyhW5Y+nzeKi7ibLVW+jslCNCZvPo4tpYa27Z8lGtSXRcWmSh/aZJBEW2PqbHQ
         JLwuQdqTegLH+whnSz+Xxl75Na6JXH6uopUC1snqEeRjPgn8FpaQ36lnPD2hVIG/BCPA
         IQQw==
X-Gm-Message-State: AOJu0Yz8q8mx7+ji2iIAw47VB1ZUXAzFyC+X8smSTJt09crldfNeUlHd
	fTN+gx0ygNAdNnBakhjiej9rcBOqQqdGGOIC5N14XITsE7O3H434hd4J/9/ZrqZAlAvkH1FXLxz
	zkf7WowCf2qwVCShjLkn6VdZ3qSmytCbZFs/G
X-Google-Smtp-Source: AGHT+IFGO1SpbJUhvgx/bE9EiAh12keH5uH/8QOlUwjYPTDiGVD/Dov7JnNtDm3nRybHnAZ0gi+JxDOMMoe4IiWjklk=
X-Received: by 2002:a17:906:46d2:b0:a3c:bf99:123c with SMTP id
 k18-20020a17090646d200b00a3cbf99123cmr2982211ejs.23.1707812714876; Tue, 13
 Feb 2024 00:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 13 Feb 2024 00:24:38 -0800
Message-ID: <CAJD7tkbQmTQJU4-L_CD=aG-k5uLSWL=W=M7NKM2OgawS8xCiVg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Jonas_Sch=C3=A4fer?= <jonas@wielicki.name>, 
	Narcis Garcia <debianlists@actiu.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:16=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=3D1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.
>
> Only warn when disabling is requested, and clarify the warning.
>
> Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=3D0 mode")
> Cc: stable@vger.kernel.org
> Reported-by: "Jonas Sch=C3=A4fer" <jonas@wielicki.name>
> Reported-by: Narcis Garcia <debianlists@actiu.net>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ed40f9d3a27..107ec5d36819 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7971,9 +7971,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
>
>  static int __init setup_swap_account(char *s)
>  {
> -       pr_warn_once("The swapaccount=3D commandline option is deprecated=
. "
> -                    "Please report your usecase to linux-mm@kvack.org if=
 you "
> -                    "depend on this functionality.\n");
> +       bool res;
> +
> +       if (!kstrtobool(s, &res) && !res)
> +               pr_warn_once("The swapaccount=3D0 commdandline option is =
deprecated "
> +                            "in favor of configuring swap control via cg=
roupfs. "
> +                            "Please report your usecase to linux-mm@kvac=
k.org if you "
> +                            "depend on this functionality.\n");

This line is surely getting long, but I see other similar instances so
I guess that's okay.

>         return 1;
>  }
>  __setup("swapaccount=3D", setup_swap_account);
> --
> 2.43.0
>


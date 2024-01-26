Return-Path: <cgroups+bounces-1241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018983E0F2
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFFD1F256CF
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0862032B;
	Fri, 26 Jan 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQzRmUMH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD71EB5F
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291878; cv=none; b=M/zW8ItdVVS7PKuGeMEMjKocuguYTNoVFw4k+S0z0XOHR2STzkBc3uXY0khxJBpiP6Vo2jAV9awlj0RfcGJ4HWo7l+lU4nlMjHN7B8Gp5RpZ6JxA4Tq1LZfmH4TAEGzW076MnRQRWlva9gGkRSUkGOGyIPqJgqVsbj2iweK95oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291878; c=relaxed/simple;
	bh=E2crcOhNuaAqz+519T8FP2B1tpezaQuLnzXkeaqN7e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXX6mvQ9C3t3xjg9OSN9O/dzkMDwLwo5dIHDWx44QyyG/vjKQRHuDVHHzGNXzxqTuUudJKg4/7f0xJpLNz4S53OwGbxE1d8bZ1/NR/XfsSfCbXaIro9PzUd6tC8OK5ehAsxYnNkgRbY2gkhOHD98W6VSpAW84RT7mTQfSlqQwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQzRmUMH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d5ce88b51cso4485ad.0
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706291877; x=1706896677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An5Hm7PqB36GYWYpMgbnDAdbOLaXHBXx69L25Wdp8OQ=;
        b=mQzRmUMH1/L2OPmjxgbUZF8HmG8oBdqS9h4JWYUA60H+3AzXXgv6CeVQeUykAeB5dY
         qZx48+tDK/YEyr2M3WctXFJnUAModdr93d/JYzcvuOvwPojjPVSFc4lecpDOQ+3+HGbi
         VVaVIH4cC29s8T8Uo+qNh4rPtDM1jRcKGapN8kj3Lol8cdMV/rcb1g+Qfo48Z3/R23US
         66ZaLEoikokA87Zez6Ehj5zAxLs2PN20jqPe760WI9sYV+TmQza3FhC0FIxBTfL4Tron
         jabZ/psEIcB29okvjkAnfZaDFd4OuoTaDyjXGzBegx5Uupbo6R6CvoWvjyk4DMswDQ0Y
         3vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706291877; x=1706896677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An5Hm7PqB36GYWYpMgbnDAdbOLaXHBXx69L25Wdp8OQ=;
        b=IZ46H0cn6l6g8h42Rnn/trBbk15IX4Lr0KlrHPZLM7XrJcjq5jR/mO4U7krVkbpdTl
         G2Uzd16AEixIVFW6z8HeRwPLAeItaiTUmq0jtNkae+vi/Ci5an2TqL0dG+EOrjH6DpYn
         znEEP9BKZ8DAji8JZuNml13DR1eou+utTH2EkcUjLMDe5rSu4bjpjrYhRRohzpLxn/C4
         jLt5fa2zvGPplaaq8lr/ZXjPpkPheBUZjE1ETbi9HwSJeBVK+d0/u4Q0gpN6WShJ258+
         7T2sgpIzJheWPRbMxDtNB6ETQKYn4Tm5I1QJ+rpKAfF/Utw60X2uwUq6ROK9CrsrGLpy
         tzvA==
X-Gm-Message-State: AOJu0Yx+cMnof0UQ/nhgmSVB7UbNuiEjumMYDncUGzBbFM06xplfYmWu
	5qZvJJZT68FuTjtAJbO4rJxi/7CFgOJZYyYxZSP3nhTofXS55EG1ebKhjfU7DKKImgw42EZtlY1
	3wJG2iqSFhLt6jajcmduuuOQpUTAAnh5+dAbM
X-Google-Smtp-Source: AGHT+IFXRj+csJ6WWjoc12LPjq8yTNSOtDUZOmR3AGCJSqLnCqa9bT3+zM7+a/oG/d8Ehsl8CuzJR6UKPY5YCCGYbF8=
X-Received: by 2002:a17:903:950:b0:1d7:2f82:83f5 with SMTP id
 ma16-20020a170903095000b001d72f8283f5mr217419plb.7.1706291876425; Fri, 26 Jan
 2024 09:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111181219.3462852-1-willy@infradead.org>
In-Reply-To: <20240111181219.3462852-1-willy@infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 26 Jan 2024 09:57:44 -0800
Message-ID: <CALvZod7xmPf8brk9HsYK0KW=bemiTounovWV8BCtD4CgTkd0kw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Convert memcontrol charge moving to use folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:12=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> No part of these patches should change behaviour; all the called function=
s
> already convert from page to folio, so this ought to simply be a reductio=
n
> in the number of calls to compound_head().
>
> Matthew Wilcox (Oracle) (4):
>   memcg: Convert mem_cgroup_move_charge_pte_range() to use a folio
>   memcg: Return the folio in union mc_target
>   memcg: Use a folio in get_mctgt_type
>   memcg: Use a folio in get_mctgt_type_thp
>
>  mm/memcontrol.c | 88 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 42 deletions(-)
>

For the series:

Acked-by: Shakeel Butt <shakeelb@google.com>


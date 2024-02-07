Return-Path: <cgroups+bounces-1401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61D84D371
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1455D1C21EE9
	for <lists+cgroups@lfdr.de>; Wed,  7 Feb 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B45127B67;
	Wed,  7 Feb 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="gZLbPrCv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FE127B53
	for <cgroups@vger.kernel.org>; Wed,  7 Feb 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340000; cv=none; b=kc01QwUfVPeUq2n80vPhFfiomyvgcsQTMS71RZJc5B79unvbhbY6VErC2MvuhT3XqkWzEJmNenJejkoUBEvnUVfN0TEnxnKFLZLQ4OwJmeq/3Ho7B+d6YPTq1wdnhwbAYTntTgB4sfXPcQk6P4vvjwKprEuUcxacSZaRrSSM4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340000; c=relaxed/simple;
	bh=kfCF66+nsP3XZFTo8GwalkScCc4V7eApC34k00p2TZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7xvouS0VUlA5HasOMom+VciLNEQz+0U/+DtWqQzwmC54QuZy50u7OeNVUXwsNKl54jNSrrZvLbFrY6L17QF1yfnCY6cwjvDrWIho/EeVQzccRCbo+zH/HT6W7RdonNdnjrJCusK8p++xMocBNyE/CAeY4zxlKnRfZlL3tastyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=gZLbPrCv; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb9b28acb4so838213b6e.2
        for <cgroups@vger.kernel.org>; Wed, 07 Feb 2024 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1707339998; x=1707944798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NchtCtztTYgLVk31R6XXB+U98ZPDL1AD+o55ip7WTnY=;
        b=gZLbPrCvgHu/1S3PNVV7VNGkZK4GUtWwndnwsnVg0IYtf+6D/5cc6xtcFuI/D18KRK
         iS1RHfHBuTqtWF13P5KSgR9ktQZn99sBhWXuUNm09XW3154ruHUltQCUL+0KONTyXs+B
         AHO0iupgzeJ4GLmlqVH8ptQ43rxdOql2bwNWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339998; x=1707944798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NchtCtztTYgLVk31R6XXB+U98ZPDL1AD+o55ip7WTnY=;
        b=H8fVMSwRY3nraYC6JaQ9gzlCZkOzFUCh9FjuwUbH/wtl98/Vi9Bja59esqhlcs6Io4
         dFZ7cBAWw9PpIL7lBb9QtoUsMxb0C7y5PkV9TLRe+de3Vu+AB32jIBpGI+Q/Tp4Nz16d
         9N2y4V5nMoWmXXbwi3Z92GDNxNyjbCv2qpsc4xW7SV3dJLXVVWaOUhSiJPCMUXYimqhp
         fj7fwjyjjg17enhntf/NYTuc9dLTcrYEHe+NOhFd8UTyKLuPG+E7zBCVh9HjVIBxLRVU
         rFCb7P0M3kTHiXIbwiVznFWE3WXBnz9I6nozIWYLhnGj+u/95WvnIpO2wDtS7UTkKjgf
         41pQ==
X-Gm-Message-State: AOJu0Yx8Ksf1pulyAwTQMYYtI8790dOVWJs6TglJvgAEhrHVLlZRH9cf
	+5e4Ydi5LMtnMrj3sKvjARfG5vcJXuIqq7b/R6z8rjsF10apwKFSf/GhK4HWKSbYwlHV0lBuHTU
	ZveKJTjWkJ8gDbFgPsf+lv1UPSFgF6eg7pcH7iw==
X-Google-Smtp-Source: AGHT+IFHJ8RzBy8kDruajhclKaKc5G+oGuGhBt6+ikiR1rVtLI1ZIksnvJc+jThp9pyXy+1XUd/hTd9KJKxiBGbCd0Y=
X-Received: by 2002:a05:6358:d09b:b0:179:1f6:4775 with SMTP id
 jc27-20020a056358d09b00b0017901f64775mr3847995rwb.31.1707339997647; Wed, 07
 Feb 2024 13:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204194156.2411672-1-davidf@vimeo.com>
In-Reply-To: <20231204194156.2411672-1-davidf@vimeo.com>
From: David Finkel <davidf@vimeo.com>
Date: Wed, 7 Feb 2024 16:06:26 -0500
Message-ID: <CAFUnj5PjgQM8G=s2TxJS73_GnytOACog8PFuzASgYNfLH2Uo-w@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Muchun Song <muchun.song@linux.dev>
Cc: core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Did I miss a reviewer on this change?

I've clearly missed the window for 6.8, but it would be nice to get
this into a staging branch for 6.9.

(I can definitely rebase and re-mail if necessary)

Thanks,
David Finkel


On Mon, Dec 4, 2023 at 2:42=E2=80=AFPM David Finkel <davidf@vimeo.com> wrot=
e:
>
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms.
>
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
>
> This change copies the cgroup v1 behavior so any write to the
> memory.peak and memory.swap.peak pseudo-files reset the high watermark
> to the current usage.
>
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
>
> Signed-off-by: David Finkel <davidf@vimeo.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
>  mm/memcontrol.c                               | 23 ++++++
>  .../selftests/cgroup/test_memcontrol.c        | 72 ++++++++++++++++---
>  3 files changed, 99 insertions(+), 16 deletions(-)


--=20
David Finkel
Senior Principal Software Engineer, Core Services


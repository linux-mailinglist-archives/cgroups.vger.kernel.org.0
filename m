Return-Path: <cgroups+bounces-5892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617F9F1BDB
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 02:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AE0188A987
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1410940;
	Sat, 14 Dec 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrC9J6Zu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB75D529;
	Sat, 14 Dec 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139750; cv=none; b=baFXA9Wuhj8H7feKiIWKoq25CDt2gLujaa09cDTR3shZWwrKKeBg+DeKbNZ/MS+YYBccy2oJaXSfrL/u8gxWhFhHBGB0SuBlrFrejta0dbCj025TaEpPo8Hhse7KrKToDarNwpqCn693HROeb3HIzUJAqzvF/Ak+WlWKBNqeI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139750; c=relaxed/simple;
	bh=vVAJG9syhr12rxWNm3fuV8weZg9JIYCn4ySR7qnbiaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtUwUc80YhNhxABwrBe8pe+/kvn7i+GNvgZryTDv71+F20P3LMe+/PJlqy+hSPPDAZX/Z/LmHVame8+yedyNGoFwGtOxnB3ZrH4wRgJsFu0VgeLsSrsGwowERwPraFWCXkLGLhiAaToC9d035tudEhxpPHGyU+Dr1CndbgY9v0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrC9J6Zu; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dccd252f30so2558756d6.0;
        Fri, 13 Dec 2024 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734139747; x=1734744547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVAJG9syhr12rxWNm3fuV8weZg9JIYCn4ySR7qnbiaw=;
        b=UrC9J6ZuHcbr0GpcZV7T65h+JODfhG6LRPSGwzXcAT5a7VkFU92waFTVN71LYDsyKr
         qhIlGeHSrabsl1mUroJTGkJR27EoHGh2axy6N+880GRBIkQ4QEmfT6UP5VcpfphcVuhS
         PypB7u1XwECL3Et1a9sh7ZwYxXlwc338etEJikf97jwF0oiEMKx/MJpQPaBLxVu4wwwf
         dTnNVlPtLnXp2iWM0YSB9PlHj7VINxYWP+/XA2yy7x1pB2pieKyf3tWt2VHbPuTGy5dd
         QOVtPZ253/CzqQK1HJTbuBnJNArzjKEIgHiLOrNbLa1JI4ZbZupLplRxa4VS3zxX06q8
         yr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734139747; x=1734744547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVAJG9syhr12rxWNm3fuV8weZg9JIYCn4ySR7qnbiaw=;
        b=CaSzXdiZMj05cKI7Mo4yuPlvzA6jp4wgBdE8y30GrL9kvfb5GYIeDdbD0I2568QyTu
         t7AwOaVLslKZDZ/em/fKedNg1sLrTft7hgCag3mG3UzsZl8H3Kb9WHA97TRFDi4FOhmt
         DoTZnUUk0VNwr0cooBzlwxLn5CmDYapS36vRfbdamdGrN3S0uiUPi/zkVR5h6yqN7WRL
         W6nFWyfvRvWIvM7l2DBeuAUHH4hnJ4DqQcbwq1AK+yG8L6tUUUBmYXmdanzRDTfHN22n
         Q3usXDks7cMUJr6UMpe5HKUkUbsBfAIR8H508L4iHBqsZT68W2pLrksKbvA9k0pVKeH+
         JE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8f9h51JKUAgPqRuc43rWopj65kOAtX0Ucn58Ntk3exz90uZtGWy16mqs3cIsXP82mrQ8BlC2++lrmNcKJ@vger.kernel.org, AJvYcCWli1eGe2YpvraSYDDmy40LZFbLWhSVW5byL3HIpIsItsddzEtZWdQ2LcYragYVwFNKkwY654xu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzajv+GXq8Fv8o+g3cVZKFI4tb4J1Xom3r6mvd7muqky3wUwgVj
	gwDbhgSnaFz9wUZZ2ATVfrzLe7T6ou64S0qV034Q2FHh5mpQUVX8TPARKFSORdrUr+US/CETEuW
	54icCVeBdElDKTcndwOF6gcEjjrI=
X-Gm-Gg: ASbGncuBoNegBkCkB520YLbtUzAl4626YBWooYxMPUbAVuu2Vno8atLLImACWbMagZV
	k4us1sr5vs3Dpi9a/nuY4WTpyJ8kid3rW0TroIfg8dmExuP0s8/Fh
X-Google-Smtp-Source: AGHT+IFop/B49xJob0yTKWaxWZwzZX4K1rQCDUsZXhIyVoxAwHJLe4JFZQPnFuo3pRMZFIbSjgT09/+rmGaWLPwrDdI=
X-Received: by 2002:a05:6214:4002:b0:6d4:3593:2def with SMTP id
 6a1803df08f44-6dc8ca3e6f1mr89817696d6.5.1734139747204; Fri, 13 Dec 2024
 17:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com> <20241211203951.764733-2-joshua.hahnjy@gmail.com>
In-Reply-To: <20241211203951.764733-2-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 13 Dec 2024 17:28:56 -0800
Message-ID: <CAKEwX=MGJ2cwazqJcYF33thZUih6_tFDMbQJcvB0=7EAKY8E_w@mail.gmail.com>
Subject: Re: [v3 PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	sj@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:40=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>

LGTM FWIW :)
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


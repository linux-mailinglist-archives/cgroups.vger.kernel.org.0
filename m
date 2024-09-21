Return-Path: <cgroups+bounces-4927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C397DC06
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1563B1C21137
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB677152196;
	Sat, 21 Sep 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKa8NzbE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D7134C4;
	Sat, 21 Sep 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726905075; cv=none; b=gn8Z5ZrYXqbTeulWZMxLJnSeDwKkHxjOSYEQP2W8C9/7JsRhZcHANMjpPV+BZVuJIL2DjRUz4jq7L2UtiqTqpdGup58aiyrwQAQ+s9WJKWiLJcPXiAPkj7IFvZETCOWwnOMJph4DP8BlYdvdGk3aQmjPdoegrNXMDDz2k8Df+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726905075; c=relaxed/simple;
	bh=3dkVH2QbyIm7oZjw/33FsvLGZQhFnfzR0P63G8YGECk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzNcLgIliMUtAGyz9MmXn1Y75vbyPN8ximpN5H+M9NKok28FRmLr5h8nAxKJVap20jcPKSY30o7so2U9Dfo/a195ZWW2DB1fVjzhqHcAzp8Tz+ktHXLbAswb/X6NzJMYpe2KwwjQ4Bigv/zSr+QdGKOINTlNiqyjTZkRaRwwGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKa8NzbE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d91eef2eso1768062b3a.1;
        Sat, 21 Sep 2024 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726905073; x=1727509873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sBaYPDTXxYwaESqW8DBuiZi7wSnkr5v5D0zlShXrWOo=;
        b=jKa8NzbEN8DaoZzDYyobjeX2VEc27QYMwBneGbJJFtaJujoiaGsNO4TsDaUOl1jO0E
         Si+hQVNvdr+Jjb2qvoyk8qMCakdMLPMBZBzONGbvWLtVSZ2mB3Kv5d/2oSTZpfgjaO/c
         RYYLronAohvVol0SyBhMrj9aorboJU4bJvX9ClGPvTdG8vO9gIx5nY07MYIctJDo2OeU
         O7MYI6oyt2mkmeT2U2qyhImHEmu71ow1blfy3hnCejAcQwTyGvRdp5s/rFWTMK60uvKJ
         vYl0/rvykoJJoKqtyS1vgc2p7xRswepCn2Swxn/+l3d6X8JthpW1kduBFqg4O1cXfify
         6uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726905073; x=1727509873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBaYPDTXxYwaESqW8DBuiZi7wSnkr5v5D0zlShXrWOo=;
        b=hZBjsDScnVGYIOQvNLU6zmqvUC3QIWjQZNU2Bi2opBBCLy6lAzr6QSHzRWcP6hWkDP
         kzU5EiPnhPYEcRIAMt3EecktdH3nQkcxOtjCQ4JtJOlGrra5m2cnXBc1rejqLoL/PpQP
         o16nDWGMhdMAORHDvbkJ3wgT1Ddoe29hgiTTiUQRQKaCllX+q/wO4WE3MC9btXtN6t8O
         YFTyNOWuct6uCQa0eUcu1A+VBIQYnnXNsOfJbnNWKXVdwYezV1UNfgdvLJ1TpZSe+RYi
         vOY3hM1eFuy98W/+MZzKBcR1qm9teCHHdwHTnN1eqAsx1Ge5lBo39ABVdUg7G785l61l
         ujQw==
X-Forwarded-Encrypted: i=1; AJvYcCVTJmZliQTEHS1laR/wAkAmfZTeoTPZ9Gn7xhwGwtt/0mJFADQ5JdRBkw3QT5Eqwa0IjFxXvML7@vger.kernel.org, AJvYcCWh6cMXuU1UYHWRvb8o5bM4U+drkhAZUi7GuESE2d6QIeE/22JaFFWd5NL04org/UfDQ0y6iQXGiSJluU1D@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAahregUiuTfZcweKNc+0bVo8smia00JAaPRxDO14MKwdEZTw
	Lq8g3iuSr3ko15UcFUUVhJByK/1vIch0/Dt3GJ/E4k10tzo1eFLnDHAmvww3Pnge+PbmtQyMnEj
	ULuRsO6SopBWpIr/HAuDPetZ/u4Q=
X-Google-Smtp-Source: AGHT+IGZwn+VHNRYjAYnGmPX5f/AYK0jICvMvI2FP0cILSB0OBhtqtYl0eEoesDVuPDwaZJvKMba0MvbHNyHr+foQC8=
X-Received: by 2002:a05:6a00:660e:b0:717:98e7:3d0 with SMTP id
 d2e1a72fcca58-7198e14025dmr12457725b3a.0.1726905073361; Sat, 21 Sep 2024
 00:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240913084453.3605621-1-jingxiangzeng.cas@gmail.com>
 <20240916004134.0ef2f50862b59079e1ac2928@linux-foundation.org>
In-Reply-To: <20240916004134.0ef2f50862b59079e1ac2928@linux-foundation.org>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Sat, 21 Sep 2024 15:51:01 +0800
Message-ID: <CAJqJ8iiVPhhyH1avxGujpYoCuh-0nQwBf3g6JPbg8ouqYgjW+w@mail.gmail.com>
Subject: Re: [PATCH V2] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 15:41, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Sep 2024 16:44:53 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:
>
> > From: Jingxiang Zeng <linuszeng@tencent.com>
> >
> > In proactive memory reclamation scenarios, it is necessary to estimate the
> > pswpin and pswpout metrics of the cgroup to determine whether to continue
> > reclaiming anonymous pages in the current batch.  This patch will collect
> > these metrics and expose them.
> >
>
> Please explain the differences between v1 and v2:

Currently, the PSWPIN and PSWPOUT fields are only used in proactive memory
reclamation scenarios, but memory.reclaim is only exposed in cgroup v2, so
here we simply delete these fields in cgroup v1.
>
> --- a/mm/memcontrol-v1.c~mm-memcontrol-add-per-memcg-pgpgin-pswpin-counter-v2
> +++ a/mm/memcontrol-v1.c
> @@ -2729,8 +2729,6 @@ static const char *const memcg1_stat_nam
>  static const unsigned int memcg1_events[] = {
>         PGPGIN,
>         PGPGOUT,
> -       PSWPIN,
> -       PSWPOUT,
>         PGFAULT,
>         PGMAJFAULT,
>  };
> _
>


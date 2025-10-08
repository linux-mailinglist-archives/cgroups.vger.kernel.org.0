Return-Path: <cgroups+bounces-10609-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBABC5EB5
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F1E407015
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960924DCE2;
	Wed,  8 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geQ2wtZ8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560E19E7F7
	for <cgroups@vger.kernel.org>; Wed,  8 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938399; cv=none; b=hIHMaGxxchrtnldNHidwDkPEKX5uNO3N9EjM5lpKpCfO6uaKHjcBxrR2AOz0X2INn6D2VuYYML8sL31WKpFCRDtZGA7YskaZ/8+qBKP/7TfTQ3x8H0cW5xRC1uhDK5RCjUjtgLQntPiihT26qLEcxiNBwXqe1zJaGmjsnoBa/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938399; c=relaxed/simple;
	bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/lXDJkGNuoZaNPaxeD/885C5sYU95Eek30pIPD9skwIAGGPfIlDVUX7QOCRvNoQeLkJ+mB4TgoTy+rhtaaOTqdSAQeRz5vbmGgqgw41zE/LpPu08VoUwFZjU06zVUWLzv5HTkIh9oApwkilhi31QCPlvTDGB1zF+jjzJbxNyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geQ2wtZ8; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9379a062ca8so277189839f.2
        for <cgroups@vger.kernel.org>; Wed, 08 Oct 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938397; x=1760543197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
        b=geQ2wtZ8KJ9YITT/cEuGV+iC6GYlyag18v1TitMfkDN6Vaubsqrt64/zOOh3J0QzJJ
         byOT0AYzdXsWOPkrjbiHLSq/1WYwJrRPjMtNiAlDdmQsNOlklt3ib8w3vUPpsrjaYC9L
         c1yhqCLy+da15g4SnNAheHs0+L9zov4yK/g5cZpbiK4xulcqi5xwKAIq9Kc+FWXKzGri
         ZIerPtpEt4Mrj1yIj1MpDjbt3P3bDmd6drVktxd9vG551XznbAKtanafEy7YzdajiI3T
         kC3Oi7cKz5MUx4tDv99y1Dw14i7JJkcEQ3cp+sbeUDth5fmW8R4hA6qJtHwr+OIP+1V+
         ybyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938397; x=1760543197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
        b=dys6DgJlW8KQWnZ5/pUgbSctj8LCEzmpG7u2aBJOVx3hF6RC2OOCcig6MHkQtbZENo
         dEP8w5kHi8COslPVvE9PkwIGMM2CIrHvhiFkJvMT2vzwWw4OUE2troTS33/bAAyhLhm2
         G2eDa1cCcKH5uYrEE+EoEnQRGwodei2TLg8nfyA+VnXY9vr2UCM2CqDHN8U7qtecK/CB
         a9p9qV4vKDALBTLP5B2nhgKu5wrseVIf0kRp7YmXfBYCDPmgC0of+yI7KiwPhDh9zGqX
         0zVV4Si6uNQDyeq8T0nNq5z+PeGplDlQ1xTmJ7O+IS57k+U7mzaKdOllxBXYh/UMiEyI
         rWOg==
X-Forwarded-Encrypted: i=1; AJvYcCXedCu0pqatvvg5UlqD0LjwRlLmf25uEbUn959804I/pgunR4aTF7Y2e+fj3N2SKO7R+QtRPMu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0JcWOQQ0jisEProt6H/QHk5TK31LoMMqNL/vPVi79j3wCkX1
	mBxaRansYvug8tJ2oEjjuRZ60eBnZxHYXKKg1Ed4IE4+gQjHSyV/29KAl649UmI/PqMU3xo+/IW
	omlzB2mfBd1xqcC+jlpwNi4smastU0KM=
X-Gm-Gg: ASbGnctBOsK7DVPH24B64cJX/bVsHsaSbXUu6vH7leSgKaltBu5KmYn/dzz6jaZBIF0
	tY90brPhqIUpddGLyBoxuSxxt6wb7hENgKqMhukTI58JllgSkpvbdnyGtlM9zmZXpqPMdtY0sMe
	G/4G7ICXrD5sG2c47O7obvciYEJL1xfphPZLeIZZkiqMTYvEvsdmOuOAJTWTnFBGgQoUfxw9ja8
	fuwzJXlsSz44Z7k9fcWMEaUnM7z
X-Google-Smtp-Source: AGHT+IGYka6zTA7SFt5YtxUw1vvapwQ7jyiIHuZuDS5NfBTlBB/gXvXX1CBMTIglIFvrBhIAspJhAwA0nexvYHYEYgI=
X-Received: by 2002:a05:6602:26c3:b0:92d:99d5:6a00 with SMTP id
 ca18e2360f4ac-93bd1960533mr454130339f.9.1759938396522; Wed, 08 Oct 2025
 08:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003203851.43128-1-sj@kernel.org> <20251003203851.43128-3-sj@kernel.org>
In-Reply-To: <20251003203851.43128-3-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Oct 2025 08:46:25 -0700
X-Gm-Features: AS18NWB7B1gBQLMeSyYiISK3rWj8HDsB0McGNEALt0lUkrKO71NOSeQ_6dlZKw8
Message-ID: <CAKEwX=Pbg=O5MpZk9s8pCZo807ZmGn8N3WoALykbz68=ggb1mw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, cgroups@vger.kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> As the subject says.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>


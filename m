Return-Path: <cgroups+bounces-4541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD7962EE5
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DE1285B96
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419B1A76B9;
	Wed, 28 Aug 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/CqHwv5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958A1A76A9
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867381; cv=none; b=XQvDhkGbQf+QacOwm2aCjd9y6bCHaQekMva3pUSKaQg8+xGqxgQNEGE+jIqYAYycjRj8EL1873PtxmjhLpY/GQSCW+kXHErzL4Yff3hBhHOUtRQalJYQQvVdZLO2MHkGAezBl+CBqblL5pnnSdf2Lj1o6YT688qca9DEKjHw52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867381; c=relaxed/simple;
	bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvyvnNmx5zmFawEqbUoIVXyre0ciriiKMR5+CJT07Mgs5ua3l0OcQUHbsMvcabybgKx6mIW3/XjHwQFxIJQAzTBjuLhnaMLVuAB8XiOxIwPewPthQbe3fouZNsu4alAMeKj92MmmN7FgY6xfJU281JjnZDXRZH4QSJVfdiyFIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/CqHwv5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4567fe32141so3731cf.0
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867379; x=1725472179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
        b=D/CqHwv5uhyfmEGFK4XYZScKucS4zob6THJFqlLp8KFLn+z3e8NazklJLRTGVEDZ9l
         /7WvgGOLozoIbIazms/ij6bqz7sIdHY/U94/+a/c3ulKN8Xg1QHpNcH9sItKtO/t1VPO
         Ey9TSCPNtvJUG5XAZy8uIweOpD7V5YDaDNtL2blNRP46g3EolKN8szMJWeJQi0gMbwEJ
         81rnWzRlodrF2l+1/EocQJTZAK0Eku22PmnDZwanjRFlIJNdZoB/s0ao0TuZGLBGtTzg
         hALZK8N9DOsx0phbXERUcYbPM2y6atMjO3bTyTyVu1qZphPv7LciVCH2+K1YJvaD1qOZ
         0xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867379; x=1725472179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB0gYDlrNJiZM9gMOPtX9bPUIJv5wG4yrnIl4zbzdR8=;
        b=s2Qi57I62eM0updx+ajTy4bycXsTnlBvuFT674fUYhTvXy4ZbaSW3/fI7c1xt4tiip
         QWgm6Eowx9x+ahNa/mVv1Mp3X2eHCFFdXiG8wuYnQ+qnHHQEfrRayIM4mOwr7tHxi++P
         O0yhDlZwRnnmQoNGItlZ0HJYGVcDE4CLUEPSPgDflnmhAPUGpmhCOgKihtbjUtMx8ru2
         39Grv/J/vlude788TvzTS+cOx+t7LFQgOQ8dWzXt/D3XHDlm5ybnOLhPHbwCwqCr9wk2
         XefrfplF8lfOEDW531Sy2+6hLQrg/qRfgisQzWWbhS7OPWQ8JKHyczTZGfw8JzicHA9A
         ltpw==
X-Forwarded-Encrypted: i=1; AJvYcCUU38ivpsDp9IWMaJN3AZiWofZGyStkgHYYEku3szyRutFvoYbp38zlp34kcy1kZ2MGDsfFps6Q@vger.kernel.org
X-Gm-Message-State: AOJu0YynoiDb5k4TUjhgRxX4O8iJet1KuZsGl/jn9POWorcoJ/BsJQ1s
	Ve329B4c2T380RvuyZNqhCDToFVyT7GWoyMge4efOB2zdzhjRkZ6VIYlWBhdnIN+82RIc9TnUNl
	nVWwPpRCYsO1Hmcay1hRA/Rp+YluGw5bWSMuX
X-Google-Smtp-Source: AGHT+IEKMHHGJtLqzfE5OLqcqKU8/kPCWNZdnQNkYHAgAgw0nhFgAtmur8/MwM72yoqZWIkF41V9O79fVwQTWov+owQ=
X-Received: by 2002:a05:622a:390:b0:44f:cb30:8b71 with SMTP id
 d75a77b69052e-4566e2acf5bmr3573481cf.25.1724867378580; Wed, 28 Aug 2024
 10:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-6-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-6-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:26 -0700
Message-ID: <CABdmKX2GbvqtB2dED7hNKYtMLwu=akanYUVN3DS3Vtgbcde8bw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 5/5] mm: clean up mem_cgroup_iter()
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> A clean up to make variable names more clear and to improve code
> readability.
>
> No functional change.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


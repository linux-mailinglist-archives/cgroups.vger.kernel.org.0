Return-Path: <cgroups+bounces-2755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949788BA3F8
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 01:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDB2853E9
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 23:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416F20322;
	Thu,  2 May 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YboFN7Ve"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A657C96;
	Thu,  2 May 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692541; cv=none; b=hVlMvftEh73peMXYPTyitKbVZRjXsEwVw4BdhpquBylA98vTNCp7PNMstmCyjdSMw+eL9Q8JGgZVyQQ0j9+MDcv4mtvei1EkuDxmU7JEY6LLbwEImZUm1SwsVeizStAh80juhxravx5pXLbyBJ3SXQRZBH57OfzwQ2OzLfa8LL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692541; c=relaxed/simple;
	bh=/eKRH3akLZj+V2vv959Y9O15AqI+kn+kxxDaTeQ19dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9GIGWuQbnezzQ0KiMKidkEuk65MT5PsDZPXXAIXzdzXs09L2H0c7cjuUDmEqHnAjAemMuW0EC7G8MbOUiTjDcNBLDj49iXULZL7NNknBCR9d81tlr362M7/q5/xq1lgvYVjx/EUUg0MtFsDXHhDgsfm+UnD1X7r2a5GEDW0/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YboFN7Ve; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47ef7e85cf0so142427137.1;
        Thu, 02 May 2024 16:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692539; x=1715297339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+N7g2LBW/IB22E2qHNEVIcw2Pw/ONc9/v5J07ZgvL0=;
        b=YboFN7VeFytKBzvYlml5WtAOaBX7nsQR4AogCm9zYcYiDt2cJe2N68wSQoYE2dru4G
         +1D38q76+n9bOfV5DCojI0zaF9ZtU4q3fpIJ46d+GM87i9AWp6LkQFO5AJwZuSbcR/F+
         FdHydh01lSkeC63BweszhT/Pj3JyF54wh0DLNtusxwdcSKELUGh3Inu7mmsZQC/u0g0Z
         Wboe8BWcl0lyVHDeqSd6/zJAeT46ddTIOqxe/TPIsaoJirb/jCe2niInv5cvbUA8XBJ1
         LNMZ741aiBnCoYvdXSbx1UTeq0M6Ao72xTF6Y0Qf0x2JHD7tMslokO2yuiElSoymyVlS
         lIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692539; x=1715297339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+N7g2LBW/IB22E2qHNEVIcw2Pw/ONc9/v5J07ZgvL0=;
        b=XNK9w7bLVf2+ey2DXcnvaiCLxbxlf1FBHE4yzz6CVen1kdhlsAT4eemGX/N9hRfLBJ
         HMMAzaZqIHanC6w2jizJQjXyp7+zNNfgqd/n+raUlOoVmxFLYzup1w/QN7YhKPDRvp1l
         1rf+VaDU9vL5QPfetn3sHMjbiXQrBtDyERDkbY8FBSW6CwG02TVqFSGyyjCOh8sWZe+4
         hIxZjm8SsR0GJ1jLqze0C1kUdNpqV75Xy8bFmijT3F/2QhrYNt09arMe6jEIcWmGfAeW
         EDsDlcHzjv/0BNc0ck0CjFZNHPURxCrlu6ehRZlm8OyUPMSpjVJhoM5ExYv2Oawq7HbD
         ljTg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/YFS7I9SMeuXTJPTfPP/4+wKcMx4/8JLP//15no8Z4mvZ66EPpbN3VXtaTudO97KVnFqrMYpZ+oSLVOdywRZnxLnilRNLpTFwtSjwDx0z8YcZBJyO4pFi4ec4rmJrfdiI7JTpyMR/gpikdmXcFL8NmiVePW9eVOguYyU43KfeA==
X-Gm-Message-State: AOJu0YzeYTYtEFFL42kCXBmWzX5lTVMDvnoXOx0qGP6Dz9BiGkwIRp2h
	goXP3L2TV6PDJr5y/akLD1T/3yWawGv7TRb6N58ho6cM2Kq5HY+kKPIQcAze6Xszz4iKBxD5mT1
	AjPqVXORb1fUN+Gjage3C6EiYiBU=
X-Google-Smtp-Source: AGHT+IE7gIdmklsBuT97sdlWGZJ9767szbCMEvMzfEJsTje6wDqcsvrqvqKPpnFKgGnVtuMvDfjj2C4QN/obWjQ3RZY=
X-Received: by 2002:a67:c993:0:b0:47e:eeaa:90af with SMTP id
 y19-20020a67c993000000b0047eeeaa90afmr1184573vsk.34.1714692539069; Thu, 02
 May 2024 16:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502185307.3942173-1-usamaarif642@gmail.com> <20240502185307.3942173-2-usamaarif642@gmail.com>
In-Reply-To: <20240502185307.3942173-2-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 2 May 2024 16:28:46 -0700
Message-ID: <CAKEwX=OUf6Rd2aEwcEYdO_D3ALrSMCTdO4fdpiqhO-F-ygyLfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cgroup: Add documentation for missing zswap memory.stat
To: Usama Arif <usamaarif642@gmail.com>
Cc: hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, corbet@lwn.net, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:53=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> This includes zswpin, zswpout and zswpwb.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 17e6e9565156..eaf9e66e472a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1572,6 +1572,15 @@ PAGE_SIZE multiple when read back.
>           pglazyfreed (npn)
>                 Amount of reclaimed lazyfree pages
>
> +         zswpin
> +               Number of pages moved in to memory from zswap.

nit: into?

> +
> +         zswpout
> +               Number of pages moved out of memory to zswap.
> +
> +         zswpwb
> +               Number of pages written from zswap to swap.
> +
>           thp_fault_alloc (npn)
>                 Number of transparent hugepages which were allocated to s=
atisfy
>                 a page fault. This counter is not present when CONFIG_TRA=
NSPARENT_HUGEPAGE
> --
> 2.43.0
>

That very small nit aside, LGTM. Thanks for completing the documentation.
Acked-by: Nhat Pham <nphamcs@gmail.com>


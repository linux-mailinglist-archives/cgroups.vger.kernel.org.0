Return-Path: <cgroups+bounces-6121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE250A103D5
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1001889748
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBFB22DC5A;
	Tue, 14 Jan 2025 10:17:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40F1ADC6C;
	Tue, 14 Jan 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849819; cv=none; b=HPmeGobethOZ++L8tMSsn3kyPHclw/MDfVquXR31S3qlBCdf5Btnc9JbRS6BEqcdSGwUWfBsmWcTOGYG36+19iTcAO5ClVtU05tJQErVXrshQTRnfWBLR09Yf79byxcZROHjQLV3SLuftc0WpP9n7DLj0qs1NXK9wC9LQDliv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849819; c=relaxed/simple;
	bh=IOqJJGEL9bS1QalbqKXWapNvBmu91JMW7AWQR+y/gEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqZZ+yxaOA1WbCAmABPezYm1NCnNzW+3BGzdnvKXaou9+l1FgYJVUisyw/jDfPQ5kHQ8kejFijZYKMk9nSTIGaMaxN/PdHVg5EHivx9/dKmf72rpaJDWeqdxfj/nurBVfu7BMCMeiz0YwEz6EqCKpLjYaTdArTB8MetU77yVZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85bb13573fbso1486118241.1;
        Tue, 14 Jan 2025 02:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849816; x=1737454616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QraKM6d9Y9J5up/W2kzOhUKdMGrM/JRFuxxdQhypIOc=;
        b=tAHAcmck6Hio8qR2ROghwaG8JukiTTPpO0L0V+cwv1B0MeSOfGTOXL8VMrfB5iAYuz
         Rv3xXrrLJtXpS7KcDYMOfe+p877rFLHyymZgzQ3SAyDTAM/dpZJH7pUAvcCIG2yHZbSs
         VEJjNOuGXfKrlvy05CS+6QCVAotTKnPvWnmTizuVZ2tvJrkHqKJX3ep8voWQ3DS/aTn5
         GJlB7UA3f0hJt85+gPA20HhgHT3WDDoHtsF9/qBgnBPTfSr2NxmTLMSXyeYiLwUOd0gi
         dyVWxDwW91CqdlYW5sPqz3RPcK5ZbJ6KMllv33hMppCFVS7fDNUEHM5aYicqrUk9XqbC
         Lh6A==
X-Forwarded-Encrypted: i=1; AJvYcCXcJRwHUWjqjwkMo12jCpzol57Wr0IrY3edW3qkCPYwmVByR92UnNsZLePAojlgRfeJk4FpZX/j@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTYzAAf7h5x0x++FUwHc7QDmUl+ZEznilPg3e2aN3O4d4FMPy
	+K3gUdtvZSkRQb0ZMN4PiMMA6pk+fs5ZxPI4Rfk0Nntoc55ifEKHyZVbJpcK
X-Gm-Gg: ASbGncvxCXBJY9zspg3WihMIxrq8Xr+Mj++KrCQTCAdV30irboJUsGUIvD6Za2rVvy3
	zkdtjug1rwBBrvYyBJ7tx6AlNRNYogzjFBJpdnBqA7s5GWq0TuJqxbNRWrQWJEilMLs1/9XdJvy
	YzsfQLKOq8hoqfYybMHETFRXE2sdi1GfDxe0Zyp9VdBOmZv+v1YP3haMPAHXMZ00yE6ardyXOsH
	Yex6Va/hTNcxRFoqxr6nbMiYewMGTqcFWffORWS/7k6JllK4IPlPQ7h8cU4HJkLkU998wL4qJe8
	TePRq43VeDW3+2wIxX4=
X-Google-Smtp-Source: AGHT+IH+Y+Wi6KjJpFTgYdEFc4vAM8t+DMKMb+GIMq1exKBh7I0dLBFRs6Zcf7El3SXye46Z7w/HXQ==
X-Received: by 2002:a05:6102:5088:b0:4b6:1991:4f4f with SMTP id ada2fe7eead31-4b61991542cmr16674131137.17.1736849815736;
        Tue, 14 Jan 2025 02:16:55 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623134c6b9sm5244086241.1.2025.01.14.02.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:16:55 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4b24d969db1so1447122137.0;
        Tue, 14 Jan 2025 02:16:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWU1GU3bc+qq5jD2/qNSoJx5pgi4OYU2k51fA/I6kx18CSvHzOg4dUcTpmeTzESfKDG5wSWwovT@vger.kernel.org
X-Received: by 2002:a67:bc13:0:b0:4b2:48cc:5c5a with SMTP id
 ada2fe7eead31-4b3d0fc71c8mr16262110137.15.1736849815073; Tue, 14 Jan 2025
 02:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204134410.1161769-2-dev@lankhorst.se> <20241204143112.1250983-1-dev@lankhorst.se>
In-Reply-To: <20241204143112.1250983-1-dev@lankhorst.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jan 2025 11:16:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUmPfahsnZwx2iB5yfh8rjjW25LNcnYujNBgcKotUXBNg@mail.gmail.com>
X-Gm-Features: AbW1kvYN2hMkKdNHoOg7qKlEDQuu9LKu80dYH1lZ12dEe-3ZNi_7PkuNI0fGm04
Message-ID: <CAMuHMdUmPfahsnZwx2iB5yfh8rjjW25LNcnYujNBgcKotUXBNg@mail.gmail.com>
Subject: Re: [PATCH v2.1 1/1] kernel/cgroup: Add "dmem" memory accounting cgroup
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, 
	Maxime Ripard <mripard@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maarten,

On Wed, Dec 4, 2024 at 3:32=E2=80=AFPM Maarten Lankhorst <dev@lankhorst.se>=
 wrote:
> This code is based on the RDMA and misc cgroup initially, but now
> uses page_counter. It uses the same min/low/max semantics as the memory
> cgroup as a result.
>
> There's a small mismatch as TTM uses u64, and page_counter long pages.
> In practice it's not a problem. 32-bits systems don't really come with
> >=3D4GB cards and as long as we're consistently wrong with units, it's
> fine. The device page size may not be in the same units as kernel page
> size, and each region might also have a different page size (VRAM vs GART
> for example).
>
> The interface is simple:
> - Call dmem_cgroup_register_region()
> - Use dmem_cgroup_try_charge to check if you can allocate a chunk of memo=
ry,
>   use dmem_cgroup__uncharge when freeing it. This may return an error cod=
e,
>   or -EAGAIN when the cgroup limit is reached. In that case a reference
>   to the limiting pool is returned.
> - The limiting cs can be used as compare function for
>   dmem_cgroup_state_evict_valuable.
> - After having evicted enough, drop reference to limiting cs with
>   dmem_cgroup_pool_state_put.
>
> This API allows you to limit device resources with cgroups.
> You can see the supported cards in /sys/fs/cgroup/dmem.capacity
> You need to echo +dmem to cgroup.subtree_control, and then you can
> partition device memory.
>
> Co-developed-by: Friedrich Vock <friedrich.vock@gmx.de>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Thanks for your patch, which is now commit b168ed458ddecc17
("kernel/cgroup: Add "dmem" memory accounting cgroup") in drm/drm-next.

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1128,6 +1128,7 @@ config CGROUP_PIDS
>
>  config CGROUP_RDMA
>         bool "RDMA controller"
> +       select PAGE_COUNTER

This change looks unrelated?

Oh, reading your response to the build error, this should have been below?

>         help
>           Provides enforcement of RDMA resources defined by IB stack.
>           It is fairly easy for consumers to exhaust RDMA resources, whic=
h
> @@ -1136,6 +1137,15 @@ config CGROUP_RDMA
>           Attaching processes with active RDMA resources to the cgroup
>           hierarchy is allowed even if can cross the hierarchy's limit.
>
> +config CGROUP_DMEM
> +       bool "Device memory controller (DMEM)"
> +       help
> +         The DMEM controller allows compatible devices to restrict devic=
e
> +         memory usage based on the cgroup hierarchy.
> +
> +         As an example, it allows you to restrict VRAM usage for applica=
tions
> +         in the DRM subsystem.
> +

Do you envision other users than DRM?
Perhaps this should depend on DRM for now?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


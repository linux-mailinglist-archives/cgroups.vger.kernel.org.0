Return-Path: <cgroups+bounces-831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED6806331
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 01:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A19B2117A
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 00:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2242361;
	Wed,  6 Dec 2023 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrJybr/C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22218F;
	Tue,  5 Dec 2023 16:08:27 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4b2c0ba26f1so217728e0c.0;
        Tue, 05 Dec 2023 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701821307; x=1702426107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZmoOpShnlOr1bQVRrl+GknWd+PtQJEUK3TXoeEYCts=;
        b=LrJybr/CBMhzbHfZld0/dVZM5b0i8Yv1hjr8wNJ48/rdGbwhNSSNscCxDZPWjsLL5S
         1zrT/Ig/Fx+vPSMqtbb3WXAf9hmWWNuBe5jhG9SYXG6LdM7aV4kd4VmlJk1DeMmnbsgw
         NlkHas/Ekjq64iwIPCEQYIJfqoZvl/vLXTfBqKu7b/iHjCn/8GPZOESayR1tilvL0DLC
         +YnkIVmC10bJ9MUY17pzOGnJ2tqaGt5J26OIpCJTmB9MDOxq3EYa0DjJfnWDxfgdP/29
         YAOHXw1vAz9Cdf8t3U9f5CiHK1Gh6tDMSZgo5YPRBwgQHyNOnfiskG/1BcRKn7uxPRpW
         j99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701821307; x=1702426107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZmoOpShnlOr1bQVRrl+GknWd+PtQJEUK3TXoeEYCts=;
        b=VFBqNWKIc+YjQDsIxtmtYjZSJQn6YCZXgND32owQ7kS8HwYDDELvbOU/piQEVo825n
         LKjqtIJPQKZlEFYRehmRWuZ8iVGmFM+XhoIw9dP+u12slnl58g5GykK2wQVhbXlOLkOD
         4oBJ7yMNwUVsBnQq33xME6gsTmWPD0zD570idHFm+XY+auXb6xk54LKq5hipqrHGtfQ8
         KohXwfCuA04dhC6yejsqA7ZFxvwByKlb5MXglKQzlV5/2PY6NCicETEWXaCGLs44JzNu
         Eob5N8/9mx82irqDiS5yq/1IP+GnBuePawGZqNVX+mMUYuEImg61ZqxjX9VVXxRGyEJp
         LzoA==
X-Gm-Message-State: AOJu0YySxV6VrkygQfSf0t8SjhaHMJmTiOlD+s9pK0gQZnlrZ1Br3gHT
	bkNNl417t9wm8H59eGpZTKYgm3/YESeUwrH4TQ0=
X-Google-Smtp-Source: AGHT+IHe47styOpdF2IwNLQKmxh275Vb5ERuMYIfHI30HlMr+3ER7uJ9XJJ7Bag/XCKqrpbPzhICRkVEtagiFq7m0LE=
X-Received: by 2002:a05:6122:3187:b0:49d:20fb:c899 with SMTP id
 ch7-20020a056122318700b0049d20fbc899mr2686639vkb.4.1701821306644; Tue, 05 Dec
 2023 16:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-2-9c9c70177183@suse.cz> <ZW6j6aTpuJF0keS7@localhost.localdomain>
 <93a8a67c-9cb7-0d36-6b14-ce15a30bea3f@suse.cz>
In-Reply-To: <93a8a67c-9cb7-0d36-6b14-ce15a30bea3f@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 6 Dec 2023 09:08:16 +0900
Message-ID: <CAB=+i9Q_FWy3CvJAJPx_ZGncezSOLSST9BX_dZ901=8oemrSUA@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:14=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 12/5/23 05:15, Hyeonggon Yoo wrote:
> > On Mon, Nov 20, 2023 at 07:34:13PM +0100, Vlastimil Babka wrote:
> >
> > Looks good to me,
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> Thanks.
>
> > Nit:
> >
> > - Some arch configs enables DEBUG_SLAB
> > - Some documentations refers to {DEBUG_,}SLAB config (i.e. "enable
> > DEBUG_SLAB for debugging", or "use SLUB instead of SLAB for reducing OS
> > jitter", ... etc)
> > - fs/orangefs/orangefs-kernel.h uses #if (defined CONFIG_DEBUG_SLAB)
> >
> > $ git grep DEBUG_SLAB arch/
> > arch/arm/configs/ep93xx_defconfig:CONFIG_DEBUG_SLAB=3Dy
> > arch/arm/configs/tegra_defconfig:CONFIG_DEBUG_SLAB=3Dy
> > arch/microblaze/configs/mmu_defconfig:CONFIG_DEBUG_SLAB=3Dy
> >
> > $ git grep SLAB Documentation/
> >
> > [... some unrelated lines removed ...]
>
> Yep, I've wrote in the cover letter that to keep the series reasonable an=
d
> limit Ccing other subsystems on some patches, not everything is cleaned u=
p
> thoroughly

Ah, I see, Okay.

>  and is left for further work (some already started coming in
> from others) that can be submitted to relevant subsystems.

I'll focus more on correctness rather than doing further work while reviewi=
ng.

> > Documentation/admin-guide/cgroup-v1/cpusets.rst:PFA_SPREAD_SLAB, and ap=
propriately marked slab caches will allocate
> > Documentation/admin-guide/cgroup-v1/memory.rst:  pages allocated by the=
 SLAB or SLUB allocator are tracked. A copy
> > Documentation/admin-guide/kernel-per-CPU-kthreads.rst:          CONFIG_=
SLAB=3Dy, thus avoiding the slab allocator's periodic
> > Documentation/admin-guide/mm/pagemap.rst:   The page is managed by the =
SLAB/SLUB kernel memory allocator.
> > Documentation/dev-tools/kasan.rst:For slab, both software KASAN modes s=
upport SLUB and SLAB allocators, while
> > Documentation/dev-tools/kfence.rst:of the sample interval, the next all=
ocation through the main allocator (SLAB or
> > Documentation/mm/slub.rst:The basic philosophy of SLUB is very differen=
t from SLAB. SLAB
> > Documentation/mm/slub.rst:                      Sorry SLAB legacy issue=
s)
> > Documentation/process/4.Coding.rst: - DEBUG_SLAB can find a variety of =
memory allocation and use errors; it
> > Documentation/process/submit-checklist.rst:    ``CONFIG_DEBUG_SLAB``, `=
`CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> > Documentation/scsi/ChangeLog.lpfc:        CONFIG_DEBUG_SLAB set).
> > Documentation/translations/it_IT/process/4.Coding.rst: - DEBUG_SLAB pu=
=C3=B2 trovare svariati errori di uso e di allocazione di memoria;
> > Documentation/translations/it_IT/process/submit-checklist.rst:    ``CON=
FIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> > Documentation/translations/ja_JP/SubmitChecklist:12: CONFIG_PREEMPT, CO=
NFIG_DEBUG_PREEMPT, CONFIG_DEBUG_SLAB,
> > Documentation/translations/zh_CN/dev-tools/kasan.rst:=E5=AF=B9=E4=BA=8E=
slab=EF=BC=8C=E4=B8=A4=E7=A7=8D=E8=BD=AF=E4=BB=B6KASAN=E6=A8=A1=E5=BC=8F=E9=
=83=BD=E6=94=AF=E6=8C=81SLUB=E5=92=8CSLAB=E5=88=86=E9=85=8D=E5=99=A8=EF=BC=
=8C=E8=80=8C=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84
> > Documentation/translations/zh_CN/process/4.Coding.rst: - DEBUG_SLAB =E5=
=8F=AF=E4=BB=A5=E5=8F=91=E7=8E=B0=E5=90=84=E7=A7=8D=E5=86=85=E5=AD=98=E5=88=
=86=E9=85=8D=E5=92=8C=E4=BD=BF=E7=94=A8=E9=94=99=E8=AF=AF=EF=BC=9B=E5=AE=83=
=E5=BA=94=E8=AF=A5=E7=94=A8=E4=BA=8E=E5=A4=A7=E5=A4=9A=E6=95=B0=E5=BC=80=E5=
=8F=91=E5=86=85=E6=A0=B8=E3=80=82
> > Documentation/translations/zh_CN/process/submit-checklist.rst:    ``CON=
FIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> > Documentation/translations/zh_TW/dev-tools/kasan.rst:=E5=B0=8D=E6=96=BC=
slab=EF=BC=8C=E5=85=A9=E7=A8=AE=E8=BB=9F=E4=BB=B6KASAN=E6=A8=A1=E5=BC=8F=E9=
=83=BD=E6=94=AF=E6=8C=81SLUB=E5=92=8CSLAB=E5=88=86=E9=85=8D=E5=99=A8=EF=BC=
=8C=E8=80=8C=E5=9F=BA=E6=96=BC=E7=A1=AC=E4=BB=B6=E6=A8=99=E7=B1=A4=E7=9A=84
> > Documentation/translations/zh_TW/process/4.Coding.rst: - DEBUG_SLAB =E5=
=8F=AF=E4=BB=A5=E7=99=BC=E7=8F=BE=E5=90=84=E7=A8=AE=E5=85=A7=E5=AD=98=E5=88=
=86=E9=85=8D=E5=92=8C=E4=BD=BF=E7=94=A8=E9=8C=AF=E8=AA=A4=EF=BC=9B=E5=AE=83=
=E6=87=89=E8=A9=B2=E7=94=A8=E6=96=BC=E5=A4=A7=E5=A4=9A=E6=95=B8=E9=96=8B=E7=
=99=BC=E5=85=A7=E6=A0=B8=E3=80=82
> > Documentation/translations/zh_TW/process/submit-checklist.rst:    ``CON=
FIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
> >
> > --
> > Hyeonggon
>


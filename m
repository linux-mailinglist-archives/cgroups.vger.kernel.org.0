Return-Path: <cgroups+bounces-2359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3489AD1D
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E512F1C20BD7
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241294F1E0;
	Sat,  6 Apr 2024 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArScyxrv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C293D0C5
	for <cgroups@vger.kernel.org>; Sat,  6 Apr 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439775; cv=none; b=ra2/Cs48e3S5AlujSEu9P5zh7i1izf7cQz3+WcAjVTWrotB4XKqYGlP//acimaXnmrItbs+PdFhCWd1p45xagqXDa4ZxtBYvlXm2bCT4tWFLMeaaT061UgWplOkhu7p5Xb0PBNNSALWeTx5olGL85R6x1P41nkjhXK8kPWnez+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439775; c=relaxed/simple;
	bh=fYYeF3MecFw24NiAZ+QMoa0g1C92UzUGo1u5gHhYFXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhFx+aT0CnkxoOqLL2zydty5hKzSLB4CJf8gLF1iw+4yHNT2wI+OmDl0m8e5nOu54B0REYgt78AGeKkHIo6uEibLQfEyaGVfXPa02rdccEw2cFA702B5Warko5K+c6ggKCctJVCEPjs2/pav5gpF3KUc/qFyrqay9qkKX+CI07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArScyxrv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3aeef1385so2183598b6e.3
        for <cgroups@vger.kernel.org>; Sat, 06 Apr 2024 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712439773; x=1713044573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1G9gUrNc9dGzPe7AYM33DPZfjgc9cVYEl/DEKm89Aw=;
        b=ArScyxrvfDWduVY/F8RejzGRYbuEijxm5/8n92WYtfUl5vp1jQ1vsGr/rGbZpBlBxZ
         J6kz1YqYIYQ7RCwWhEdKndv6GK/Crx44nF8gZ8xxlCc2q0y8GqRWWgkmTg7YZNDcMdxQ
         0ckBbVjtgW6qTsxXOKggz9Csb/hW8tx8TEtd8Dws8cG8nErJ5gqkA0pTuYO8yqlVRwOw
         sqI6UmpY9+CLGPZyCdpTpNkWiJTP4ee0wzqhNPR7KWylbD7V+uyqn01BShAUoRiCQ/qO
         ui8N+sVN/ptI7J/TNHBcshtflTCbc2H1dw+T81NJOB5eP3I4kRgTWlAlyRZF+a8VyDd/
         AESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712439773; x=1713044573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1G9gUrNc9dGzPe7AYM33DPZfjgc9cVYEl/DEKm89Aw=;
        b=tpFiby/P7Idurk6AwqW6VcdZVVeAiIfLL9Kvw0tZyaYEvyy7bjXDI2z62D36hJt/LY
         3LxQDz7g7d2VP/k4njydPY3e/hkZ20sj5fsxjj3Z9wz0jjcF74OW7HDH6PELw3ISU8u2
         5trX9bvBqQ58vIqcI3Cue2CY03kKy3H6JSndW+i0TXEJdsjRSu/XvJY+25/6u73IbUtJ
         7E+d4suyVRrxtrnTAww2j2yhq+WaPqNO/pUhUFgACq/xbdPOTMRqOtwkVMDfKjarHFbV
         K9SHlv3yBSKKy2g6sRVxerVJnVdODDMyN19hBRndMTtlXSNDFDMuz8cahRYOxv2rwUVb
         onAw==
X-Forwarded-Encrypted: i=1; AJvYcCV/i2m+uxq2JVHKQjlwWlm4h7Lcqq1CLjPrUxerLTt5KT1XdNSDgk5l6+nsOKdnuqtsvEj7fW8YZY1wCrtgKOpaHEQpho3KDw==
X-Gm-Message-State: AOJu0YxyUG9JKCQsrTxCCrfyZ+5GC/R0PGLvEd/ebdrzzD48EOCOz0lp
	g08/UnzffqJj65c8Fc2UNE1mJf16HPyzoUXBCDJYajfnVsT7ON6QrtVxhscbOQdrr7/iqtATn0u
	rBOjQ494gY5loD6JxNbXfms5rVnxDscqx8Mkd
X-Google-Smtp-Source: AGHT+IEy/KQG2Rqx5HErdblj8QUCCqwueXsecSytEtIs4U2W0lIYmqOxwok485xQsC2WwPFvE/PMCfWXWAWd2KQRtS8=
X-Received: by 2002:a05:6808:3084:b0:3c3:dcfc:f694 with SMTP id
 bl4-20020a056808308400b003c3dcfcf694mr5989197oib.47.1712439773006; Sat, 06
 Apr 2024 14:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
 <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com>
 <41328d5a-3e41-4936-bcb7-c0a85e6ce332@gmail.com> <CAJuCfpERj52X8DB64b=6+9WLcnuEBkpjnfgYBgvPs0Rq7kxOkw@mail.gmail.com>
 <3d496797-4173-43de-b597-af3668fd0eca@gmail.com>
In-Reply-To: <3d496797-4173-43de-b597-af3668fd0eca@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 6 Apr 2024 14:42:40 -0700
Message-ID: <CAJuCfpHXr=183+4AJPC_TwrLsNOn0BZ1jSXipoP0LE+hd7Ehfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:38=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
>
>
> On 2024-04-05 17:20, Suren Baghdasaryan wrote:
> > On Fri, Apr 5, 2024 at 7:30=E2=80=AFAM Klara Modin <klarasmodin@gmail.c=
om> wrote:
> >>
> >> On 2024-04-05 16:14, Suren Baghdasaryan wrote:
> >>> On Fri, Apr 5, 2024 at 6:37=E2=80=AFAM Klara Modin <klarasmodin@gmail=
.com> wrote:
> >>>> If I enable this, I consistently get percpu allocation failures. I c=
an
> >>>> occasionally reproduce it in qemu. I've attached the logs and my con=
fig,
> >>>> please let me know if there's anything else that could be relevant.
> >>>
> >>> Thanks for the report!
> >>> In debug_alloc_profiling.log I see:
> >>>
> >>> [    7.445127] percpu: limit reached, disable warning
> >>>
> >>> That's probably the reason. I'll take a closer look at the cause of
> >>> that and how we can fix it.
> >>
> >> Thanks!
> >
> > In the build that produced debug_alloc_profiling.log I think we are
> > consuming all the per-cpu memory reserved for the modules. Could you
> > please try this change and see if that fixes the issue:
> >
> >   include/linux/percpu.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index a790afba9386..03053de557cf 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -17,7 +17,7 @@
> >   /* enough to cover all DEFINE_PER_CPUs in modules */
> >   #ifdef CONFIG_MODULES
> >   #ifdef CONFIG_MEM_ALLOC_PROFILING
> > -#define PERCPU_MODULE_RESERVE (8 << 12)
> > +#define PERCPU_MODULE_RESERVE (8 << 13)
> >   #else
> >   #define PERCPU_MODULE_RESERVE (8 << 10)
> >   #endif
> >
>
> Yeah, that patch fixes the issue for me.
>
> Thanks,
> Tested-by: Klara Modin

Official fix is posted at
https://lore.kernel.org/all/20240406214044.1114406-1-surenb@google.com/
Thanks,
Suren.


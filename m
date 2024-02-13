Return-Path: <cgroups+bounces-1490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2885256A
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 02:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6854D1F24F28
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B08BED;
	Tue, 13 Feb 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KZxAHv+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA48C01
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784430; cv=none; b=DVeu2PR6dSJpVd2tqWzXzgb1W7DzKHxv/flmKipI2t+ZR9tnquWODWXH5y7L+WSaHSyDTiypSuqNdIfPoNVG0k94jOFdqpnqTBwlOBqyrn1LVT5q3Tl2xzXBeswmFSpKjii1kZPMyrg8/reinmvPFEb8XB+yOGJI2UjzNaB41yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784430; c=relaxed/simple;
	bh=YxAXOy4o6OGYWuF03b59iNwixPAeZRO5FzV/qbzpd2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIq/5M9/B7/CJ69fSjM5UaHkqim8WWDDPjDvfSe6muZoimmO6Is0ISjROs8dDyq8gk1JU7ueHinVFuJoDkNEXISVkGzbrgxHXNtmNnHZ176v92IwzROA+A/8WIO0ydqy3ZFwCUPYGGaQvcJSgbEYbxnJC66VxfPLtmn2pKLBNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KZxAHv+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso911866276.3
        for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 16:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707784427; x=1708389227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zKsIvn4BR7Vnfqbap08Xbsf16NSeakKE4Kz9sErxMk=;
        b=0KZxAHv+0YkH6zj3t3zX+Xo9vEIewUaum4FfVunEy8hYAf1oeVsLdImyq+/+GND5m1
         0YbFCmxBlnfhvKtlGGRTbv+SA8e3uq8bZgwTJcbgizI5ExCQvlzVLgAZy8NyY2SprsKg
         Kh3f44QZmIuDvyA31c7M6Mj1s/7oW9mJtXU0bc63BVCEU7PiJcgbQPSQ/vv8DbxLyUVv
         hyytuipsHNU4IXRMIC5RYo1rziokTgYok3jz2vZkmQ6gWfj/L6pJfbJmtU683hXFrceg
         eGUjpvL4gL/U8GPNiMT83LlCZMWFAZ7ZxvDJvLd6/QT4weW1Yj9kAZu1vZlxT+lsGgV1
         0VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784427; x=1708389227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zKsIvn4BR7Vnfqbap08Xbsf16NSeakKE4Kz9sErxMk=;
        b=FV5aJPnnH+Vf7zg7TLnrCAIZJYU97mBbMlJocLHA4ZglRq05E8L+14ASC7ydca5+08
         9KmqBEv+fTqxvPmyAXMTIhxkY52EN5J3+eSMf2iJd/Cscfgjzve2N6OcrON0lEBqwTSD
         g+Jjg8Q8BTFjGW1eMHYNDzpPT4K4sx3HXTfV+AnQnAKhOI3K3JnXRxQkFQQiJuqfP6uj
         +rZpyReT7Bd/Y/ZU6ceUnKYMaYtyn5NlEyf2fiDdu8xkiAqNSBao4OwphzmLDTbzE4gu
         +F2d936R6mdkQA5qxwdWACSgyXCaXTDIWbDg8Iv4wFH1UFzJdC+NbFUfSq/cS7T4u8gQ
         teuw==
X-Forwarded-Encrypted: i=1; AJvYcCVvzOBbTJXYOxEs1MCraF7zmT7/is0hRHH0IQiJlqfZlNKNQKUju494XFxVt3dpLmSMT1FDBmlfT1i3XQtYS47Z2Jwv+PF/dA==
X-Gm-Message-State: AOJu0YzycynTympsAPTLgKeKArP729yIe71T8CbNcXyt0ghxpoA5BoOP
	u2oD96embXqOeTMrwK1ZeJXgWwEp824PKCFKHx1jwgsRbC9pdM6rpgg9y4xw4XLM79zJcw6pfCW
	haJ59dLvZ1vIiCI2XPwkg+IH71Stu4y9ofGA6
X-Google-Smtp-Source: AGHT+IGBDTumArIlZgvzmWVR8GYKMRxNMBDeFHhDCQ0WU+YPU8v4cT6TjkFsT6OjBf2VIiSLkGOXD/+qxH3EvaRmjhU=
X-Received: by 2002:a25:6dc1:0:b0:dcc:693e:b396 with SMTP id
 i184-20020a256dc1000000b00dcc693eb396mr465601ybc.2.1707784427206; Mon, 12 Feb
 2024 16:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-36-surenb@google.com>
 <202402121443.C131BA80@keescook>
In-Reply-To: <202402121443.C131BA80@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:33:34 -0800
Message-ID: <CAJuCfpEkC9FXACy02PM6GTF_XHQ0XEN6UVpFzGxYNnPcFv8irw@mail.gmail.com>
Subject: Re: [PATCH v3 35/35] MAINTAINERS: Add entries for code tagging and
 memory allocation profiling
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:43=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:21PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > The new code & libraries added are being maintained - mark them as such=
.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 73d898383e51..6da139418775 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5210,6 +5210,13 @@ S:     Supported
> >  F:   Documentation/process/code-of-conduct-interpretation.rst
> >  F:   Documentation/process/code-of-conduct.rst
> >
> > +CODE TAGGING
> > +M:   Suren Baghdasaryan <surenb@google.com>
> > +M:   Kent Overstreet <kent.overstreet@linux.dev>
> > +S:   Maintained
> > +F:   include/linux/codetag.h
> > +F:   lib/codetag.c
> > +
> >  COMEDI DRIVERS
> >  M:   Ian Abbott <abbotti@mev.co.uk>
> >  M:   H Hartley Sweeten <hsweeten@visionengravers.com>
> > @@ -14056,6 +14063,15 @@ F:   mm/memblock.c
> >  F:   mm/mm_init.c
> >  F:   tools/testing/memblock/
> >
> > +MEMORY ALLOCATION PROFILING
> > +M:   Suren Baghdasaryan <surenb@google.com>
> > +M:   Kent Overstreet <kent.overstreet@linux.dev>
> > +S:   Maintained
> > +F:   include/linux/alloc_tag.h
> > +F:   include/linux/codetag_ctx.h
> > +F:   lib/alloc_tag.c
> > +F:   lib/pgalloc_tag.c
>
> Any mailing list to aim at? linux-mm maybe?

Good point. Will add. Thanks!

>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>
> > +
> >  MEMORY CONTROLLER DRIVERS
> >  M:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >  L:   linux-kernel@vger.kernel.org
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >
>
> --
> Kees Cook


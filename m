Return-Path: <cgroups+bounces-1491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1C852574
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037241F24F9B
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257CA17548;
	Tue, 13 Feb 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms1aUX/u"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F2AD24
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784499; cv=none; b=Us32uroW66v0o65KQBQftujtXZxFGdpLWfRNG9L6MvHC6pWoerv45iyLwnONsMdxmuotag8wVtXFZ59yKrZ3NKCGjy6HFPEOYxjb1ME7hZC8ucQwnxgklsFJfu/UrMmyTCtS3TRgbYw6WVwmYAYhOFlwGGVe98vFPzZOF2c+kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784499; c=relaxed/simple;
	bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRyU5OfegVYEnw9ZOr2wyMKZLsz0q6+9dzSc13DfqAOKoLoCWeQ27iPS8rL3fp1aUUBuIARllk/TUcVj1SY0vqW71NcXebR6V0mZzqoekpnQUiAP2oGkw/XVL2k8Nl8Aqlx26Cfg5uuZg34/T2vQime0uMDATPt3rwTAiyHL+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ms1aUX/u; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso3743503276.1
        for <cgroups@vger.kernel.org>; Mon, 12 Feb 2024 16:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707784495; x=1708389295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=ms1aUX/uHe/bOSB9ADzyvPOqoUS4sMi2M2opxDzAExtTMUaUMBsxUXU/+IDeAq8TOQ
         Zt+d4vX/Dy5rWvlo0PlLR++slAyxGVX/rNBlzI3cZWAvKs+Lp5gpnQg+8aPril7OL4JV
         +NzvDsLHi18Cxttijh6lIjaaebgaVxApRPWlvQPYHSCySBsKr8vuZbu6a8SnOLouxLU1
         YpaTl5yaxwwZK3KJuNQ1b7tjQK2g6a/dFcginWYe2p2O9hnQegD50C3rQiFSINKGGQpJ
         +NubCjjAZ/d6/gCzMTdoEvG0hATxHtssDQIlpCEoqa++J5nowadTkZGotpE6uokNO1q9
         zRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784495; x=1708389295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=wQ7QpYPL8d0T6X/wf2xiSpLjNYHBgjpUBpsiw4RE0wMkb6leB+tHCZR8WfwMTpB4fo
         h38hMpIpD9zCBrNT6SedLFFcGEGv7TV4GWZDVuXijY6I4ZY6yGoORCj6+hUX6Y8Hqu6E
         972XB8DmE22hiQNSYQizUFrt33h7dj4K9UrbGARQu1HF5AxEoRREOH1sk7dwcBqzsh0f
         3oBmyYV30sOjogD0X6UEMEjY4c7ShMaRLPrHb3ANCDXUgmtFnLU533HyB6+IxdliZ76/
         ASwKtdGEc86iVdg+8Il4zGjrewUDqqF/5FYWZ4HAb92TEOfRw888BL2X9kcov1vtCzxm
         R4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVSYmDm8rZY00SJ29r/H7UQocc0WTETh6g2WsPiUJ7q25zpKtKI9V36PNOiNNRGPIFbw1hF7UdFZb85KCL4HfD4aUf3yVx7dg==
X-Gm-Message-State: AOJu0Yy6wYPUC88v6q09nR8zuG4ca//zrceDzwKMvitFzfMWJOfSne5z
	VxsdMvtPnXXWSQZjt423GPyO+zQoY0rn3KXd5yeK4qHaAT9Al7X7mCts0bGCNR2lGOfthERJ0Pk
	bnsDx4CCCLA4Oanbg+r9NP5wTc8oiiZ9TB/6J
X-Google-Smtp-Source: AGHT+IFjB55gPzAJ3uayg/3DbZropi86YtyNQzi/ARRSHghfRy48VLa7tw6T2sjep0csYIBMYiEo+U9Z3yu21UMYcUw=
X-Received: by 2002:a25:b389:0:b0:dcb:ca7e:7e6f with SMTP id
 m9-20020a25b389000000b00dcbca7e7e6fmr1832315ybj.55.1707784495521; Mon, 12 Feb
 2024 16:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-24-surenb@google.com>
 <202402121631.5954CFB@keescook>
In-Reply-To: <202402121631.5954CFB@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:34:44 -0800
Message-ID: <CAJuCfpHf+EUPL7ObG7ghVhQShcJJSwMjNcUAzeg-x1BoS5OeEw@mail.gmail.com>
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

On Mon, Feb 12, 2024 at 4:31=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > It seems we need to be more forceful with the compiler on this one.
>
> Sure, but why?

IIRC Kent saw a case when it was not inlined for some reason... Kent,
do you recall this?

>
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook


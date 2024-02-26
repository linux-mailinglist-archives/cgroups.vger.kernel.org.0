Return-Path: <cgroups+bounces-1845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE144867E09
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68889290F1C
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF781332A9;
	Mon, 26 Feb 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3QY+iEO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF27130E3E
	for <cgroups@vger.kernel.org>; Mon, 26 Feb 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967612; cv=none; b=Q7OY7t7GZ9bXXwUfJE21+Tu0s22jC3uS6YbGqglQw0B1HlSQmD99ympr6vAmzv3FSukVNRKrDW/Jo1+x/8N16dVDsbTe5SimGBGGPBRfVy7rjkKlD4rTEnzmrWWAzFIjtn0mPIYPA2/CRCxXgJ3N72v3xxj9C7Cwyr5SW0T8FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967612; c=relaxed/simple;
	bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeJRAn6LiJP0y1GurzXmzwVexY/Y4r7PD91HHAUb5AnJVLhQ48rjeDjOdI3fmVS3ONgNczYvfBPThz9EjGEk75TxVTM5rzUY38LcTi4136Po+ILOrslY7sfa8gPz1WEI8rU9q/Vg3G0sG4LSAiXnprSCbe/8tS2qoiu4xRNML2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3QY+iEO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3396010276.1
        for <cgroups@vger.kernel.org>; Mon, 26 Feb 2024 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708967610; x=1709572410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=x3QY+iEODlMdg8czW7XhedvboPNeVcoYoyNeOe71MxCosr5hg28Phdw7bmEEylx1Gy
         G+BePA8tNeyjx7qRnqGNnBcdDPiV7YHYLkjmA4LaYuFcOHDmiTcj3tpGzf4it3xXQjlH
         MgCZTSacF3PyjoTaVGiY8DvOPonLtUxyTeKsAFV7Dd+UG2YO2pNbb6fJkOSBTwQw9iYW
         HZ+fJwG+/qfcaPjTWYK0kswZMXZtUk2eYuYAmPOsvkWTR+V9aX2VPcrBlGmcgPGoc9qj
         Zex6tsndDYQuvxdtT6SumCWCyy6kgTxdEQiT117gPjYgG+eFsN26fW4ZRgvJPbPmynaA
         56mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967610; x=1709572410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=tahKTKC6cbCK0/2IsIQe9/DaUgMGF9L9v1hU8INCkfjw72YbFWmQLWaLWBQhmSrxEW
         UAn/zcMqa+FTFIu371Wl3PTP9X7jK3Y609a8TGyF0lQTveRBXaFuM96hSbFXFgKTuCnR
         SAAZsK5bZTDbJzV+K/pFu8n0SZI9KuYXEDKUYNso5B+5Ej1usE8lY1RvcH2JjHlioxs+
         tdK6U+fCWKtYPKZkKWv6ig86Tw0BDLRpoPEyLKnvr/ylW4TBWMlZsksHzKc5a0uIee35
         a+rKbhw79nRHfixAebGT5fR3Q0BbpJRQOoChoGSZps8qPgPZFMpzVak/oTzqrfcux17Z
         LNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSEUV/cW6xbvWgvmM2C9Q9lMH8uXwaYeWOI3OCoASYlDbEDWkphtc1zWTR53bNAlu/jzXQTNOREUGDKoU7UVQnvWuu81453Q==
X-Gm-Message-State: AOJu0YwTTORaJ/MvVSLqpJX+EWEdjG7GrLJXdF1OtXzrv1/5RgI2oaLe
	ubLVQDrutNCI19Z0HD/k0wwfpif0sfAhdFkUlDThGz/Kuz2Ods1UinBC6kXBx/NbIO/Wtc05j96
	BHOuGiywVmnGiMsc2TtrXYzAaCjZcbREM2LWy
X-Google-Smtp-Source: AGHT+IE/7/pQws6CVfL30UNt1mkliSDpCczaElkub3hA0YpEAm7Kcwht1trOE3ZU3RPvAg7BLiFgI/3lAi1UqBVzgIg=
X-Received: by 2002:a05:6902:210e:b0:dcd:1f17:aaea with SMTP id
 dk14-20020a056902210e00b00dcd1f17aaeamr6639276ybb.26.1708967608014; Mon, 26
 Feb 2024 09:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
In-Reply-To: <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:13:17 -0800
Message-ID: <CAJuCfpE6sJa2oHE2HrXAYuMeHd8JWd0deWa062teUs3bBRi2PA@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not freed
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Skip freeing module's data section if there are non-zero allocation tag=
s
> > because otherwise, once these allocations are freed, the access to thei=
r
> > code tag would cause UAF.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I know that module unloading was never considered really supported etc.
> But should we printk something so the admin knows why it didn't unload, a=
nd
> can go check those outstanding allocations?

Yes, that sounds reasonable. I'll add a pr_warn() in the next version.
Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>


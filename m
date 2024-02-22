Return-Path: <cgroups+bounces-1795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA985F524
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD281C243B1
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981139AC3;
	Thu, 22 Feb 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl7s6ciS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AB22EEF
	for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596012; cv=none; b=XoWwxmsD0pEWuS/iBasksdhudZz5W8epDBY7A+ADCg27YnjBxyz+8GF8qOsLo5WkBNiiJP79lkA/Bh0pFU3KSW1jIXhTvkOn/aanq+vec73w0+f9b0Ygpf3yErST+kbnk6VB/sO4iTbIewIDHg9WOMC+PIwLcxVjkfu8Q2+Qebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596012; c=relaxed/simple;
	bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEKXNSlcIGPyDQZ1i5p0/+qkRPPJqG/0thC7FJbvMYJMsSTJrYbTSUp70MYncKfzF25NNbH556pozimgbgrH1E4XW7CEKQnbc0DVtp1nbAZ882iXbDcgTpeac4RqP0DzdkD+bkFC1Gfqo258IXKyOU7pQoa9R5/ypz2l2SdZrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl7s6ciS; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso3935461241.2
        for <cgroups@vger.kernel.org>; Thu, 22 Feb 2024 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708596009; x=1709200809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=Fl7s6ciS+4en1deeuOU1AB9WFgIiGeW1f4XEAekJTZ75iq/9K0zrmPX8NhW9X9AUuT
         rIQ1bhTNP1/ArqGkQo6HiNaG0lvbiRuCiwjxV8zRR931e/kxKipH+1tXcxSwhCciQD9F
         swg16CJUpxbze9NfoejW0g7KuioJZM3daXgKi0E2vxseSMc6+r2+y6uYd8LipL/9aPf2
         yuz7aJTTtJDtHnmyioZxhaQphffvs3V0hrDSGHVrhPHJRUziBd/e2Rkt1xZwqbP9HYzY
         u1ipZpJD+g7DjFIyZZEWx98Hu+sWJfypdUg9c0mxSGGmqpL7L2EcLXkzklunvFDnY198
         jCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596009; x=1709200809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=oqZffZDwau48EeuqiyiUmBLOEko9U6bo7fapn7h2FGEjIWT2d5DHXjx35lYDDzSSDs
         oIDrsTKJHBf/D62GNJp+GYO+1W2areNlNHDCj4L2l3snkxaKMy6mIq0yNTp4OanY1ldl
         /DaiN3Zq1zk0NQHchwy9wMKN1gyn22TKRJc6VM4C4ed0r0cx0FR8mGguOm4NuyQzdQS+
         FLUUEWaR9orELmUo2Nvd94526+K0SUPHYswzQ5aJMsrJ28EnjV32G4XFW8k4tx1N6aq3
         o6SoSDBAuFPxDmXEA64D/lC3/95pvpbhkbZin2Wyln/bKcmiRiCfvpEsbBQ1vHRe92kv
         tiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWlOzyfBWVlr4dIc3Tjy0UB7/CbA3pqXfwdJhBjXWq4Q+5FsvIeDSF64vU8s3lYzu8Wofsb7cFuFadacnlUksJeZBgBDj6Grg==
X-Gm-Message-State: AOJu0Yx1sK3OavEB/tSlIKyeqRVpW0oOlIsJ6QsxivmlF5V/cGuJj4K7
	HN+x7KGGeTqGqdielY8p3M8/8Pwgm2gSASHMWloeQ7tAOrn/CQ42E7iwfwxHEkSpQaUma+VM9Mt
	1wXcgIcub1Tu5HlNDZnY1ZmgZjj1Zo3BMq59E
X-Google-Smtp-Source: AGHT+IHtNH9SG5kviHG0Zp4ObgcElY0QaPwq/WKIrJZZn0CRZo740etRowxrv/bo9NQSJHSXY5Ib9q+PDO3ajLn3tTQ=
X-Received: by 2002:a05:6102:1626:b0:470:4a6e:4a4e with SMTP id
 cu38-20020a056102162600b004704a6e4a4emr14352031vsb.29.1708596009136; Thu, 22
 Feb 2024 02:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-25-surenb@google.com>
In-Reply-To: <20240221194052.927623-25-surenb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 22 Feb 2024 10:59:57 +0100
Message-ID: <CAH5fLgiyouEuDGkbm3fB6WTOxAnTiDx=z6ADx7HN3BTMAO851g@mail.gmail.com>
Subject: Re: [PATCH v4 24/36] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Memory allocation profiling is turning krealloc() into a nontrivial
> macro - so for now, we need a helper for it.
>
> Until we have proper support on the rust side for memory allocation
> profiling this does mean that all Rust allocations will be accounted to
> the helper.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <benno.lossin@proton.me>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: rust-for-linux@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Currently, the Rust build doesn't work throughout the entire series
since there are some commits where krealloc is missing before you
introduce the helper. If you introduce the helper first before
krealloc stops being an exported function, then the Rust build should
work throughout the entire series. (Having both the helper and the
exported function at the same time is not a problem.)

With the patch reordered:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice


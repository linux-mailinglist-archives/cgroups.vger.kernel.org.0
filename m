Return-Path: <cgroups+bounces-1668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D98582ED
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97C71C2224F
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC1130AF8;
	Fri, 16 Feb 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyzLVMnD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCA12F36A
	for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102021; cv=none; b=OvoX/Py9Ph1JAWXWi691EmyRqYftq08bKW3ImV5IAmYMxD+IyWF4n2AiF7vkaB9csLv62FK3I2h7u22HND/cWEu96gaNYjjrI+/6dK56RF26ibnS7dmDJbKX67sLzYLB1qfkZu7bxl5mKR7XZW4Jywa9WB/IUUdvjaHrJe70m4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102021; c=relaxed/simple;
	bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoHZ99JaaxIQNaQgnj8BIQJDwlA1B2a6WJSkNr3sCQOaGH/DId5U3yX3BlVojN3uOgRQMI3sIR4RRRxY8SCRwogtmpE3ssRS8gSvRFO+0DUE3uFnbl5WdJgyH5LFuF80bzr2GOlHYw8FfKrKkf4KHSP+96qgnbCe/CHt6+vIk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyzLVMnD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1174448276.3
        for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102018; x=1708706818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=OyzLVMnDCE6jz4Q+qffCh6Gh4iWQJtQHHBHNJHFU9nOqqh5XY5J548bB3HMg+pqoZE
         wj46/z6t6lXNQh9dj8V54j9KaGAle7I+Y7tvVVaN6koEplIwc3/Xx1nySgpkoEb5Im2/
         DE5Vow6Od+e2urKCrffkKdJ5Qtu6IHsfBCg3S167TZSkhQfQDYF0KCEfttJy2vZkewdA
         4L29cUOQiSv+Ytc+NB/3Xy4sXBCAz40WEeqswQISFsbw4tgpeCiG9Q89YvDZYkg3VQdq
         VWlbGw4TJ/ibTkC5oEnw2jWyVxhd5z9qKbWOk/VDIZStfJ9x4gQwDNeyxUREYQ+UlLVT
         hwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102018; x=1708706818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=uW8VSsJSz4amHOtsmJFdb5FvN430W7x4dqWblF6B/yo6bJwCsyeMe5MpfZYBjUtVmU
         GwMg3uhelCLoGh8KEFYPLMcq2wYiUjJILfzmJMsJpKOjeC15yBpohnmjZrqXMspqKUF+
         P8OuqtlGF2gUcMoP4uNiNpKI5Z128IY0VigDJoXtadVJs9FDoMmR7/0R/UbWH07xqtKu
         Egc+MxPpwXYAOfcBc4dhRuufzuYePbFK6ybCAhpiLXx9efIfRnBeHrRd/mzU/W+0JZr0
         iw8ORJY1z7b44+7aPIy+sw1MqQkYl86DI+tpE1MhB29ko2Nj4IFOspQrM4/IYxNOGbTT
         ZWwg==
X-Forwarded-Encrypted: i=1; AJvYcCXU+CGvVm1De6WydGtXmUW9w2+qm2F1msdLqsg3Ua21jQAKxUBMt8s7rkijLX7L25ul2SxyECaCzRDwFb125InNDwDOP2SoYw==
X-Gm-Message-State: AOJu0Yw59tbmsE7g97IxB8c/xwdvqfFnRFyrSJqnGhVD1S7PkUwQIaKR
	+LYUpCOLAJD2SgQ1Y9tH30HDXQg5AXANQTEhMuq1nhIhk8YotXZITQhnxjz0NEHprMx4H6H/PeL
	v1LFm6OEvoPPcJVA2admDSOkcxH8AhEOEFvl9
X-Google-Smtp-Source: AGHT+IHpVHS0ppvETjTRvFKcu78rYESIPuQ3727VZfvfJc5knt0q+oxLKdnegsBYKFjwcpEUJdgoCQszaHZUroSf3Gc=
X-Received: by 2002:a25:ae44:0:b0:dcc:6894:4ad4 with SMTP id
 g4-20020a25ae44000000b00dcc68944ad4mr5406936ybe.56.1708102018033; Fri, 16 Feb
 2024 08:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
In-Reply-To: <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 08:46:47 -0800
Message-ID: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > When a high-order page is split into smaller ones, each newly split
> > page should get its codetag. The original codetag is reused for these
> > pages but it's recorded as 0-byte allocation because original codetag
> > already accounts for the original high-order allocated page.
>
> Wouldn't it be possible to adjust the original's accounted size and
> redistribute to the split pages for more accuracy?

I can't recall why I didn't do it that way but I'll try to change and
see if something non-obvious comes up. Thanks!

>


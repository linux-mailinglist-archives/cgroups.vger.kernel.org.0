Return-Path: <cgroups+bounces-1737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B309F85E5EE
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 19:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64331C24159
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A785647;
	Wed, 21 Feb 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3+Zb8DB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EDA85288
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539980; cv=none; b=KRuiuoBBBrXD+v9JFIZjr0q4puArruTMc0OCF//TWfJWR0Xy+GkBmS7vMIkPw9x+Ry4ntNpjNrCbdT2MsWJ3Lwv63QG467442mdRKlgKCGUCyFPG+9fvE+vHXfEgOQbcZ40929aIfU1JHjctoH26sA6iFht4PNuItBMGutO3tYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539980; c=relaxed/simple;
	bh=vXrmA+YUNbHeZInMv385ll0KIlZ9s0pW+epVCXD2DyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBrqFV3RXCzSkmXzmnwxQi95SIjdmtGp494sswLj06g76FOHNoo3XblGc0b0vf8ji+StxORcpJdZCCeeHoPbxIVc3wbtal53XgsVT56L3EIm+3Bn/MW0E5ODhaU0wuPz5zTF0hndV+Kpn81peJ7pdVMuI0DUcB8GeM8uW9XRFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3+Zb8DB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1069506276.0
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 10:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708539977; x=1709144777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXrmA+YUNbHeZInMv385ll0KIlZ9s0pW+epVCXD2DyE=;
        b=J3+Zb8DBBkreOEG4kHviLtCxTCWFW7dxUW2IgpbLFMfqcu/ambpyUkvdiTearxqjq7
         scgkHr+EcfVdCDFWhJlFe/Q/lbZB3/f2k7FUfXaxGOopsN/qfyzioyjqN3t9q3AMxcs/
         XB1Mb82/xx/b7WyQDwPbzf2lNJH6BsZiryalu0zYDMyOUxwE+ouWKmdP4Bj5UssYDymS
         gVIE/9FsxRSJKtCxgNoce3+4bKfCWfWJiPqYGbAJt0sifLpth6YgcOVG5CMPr25K7Fin
         pGkYdGt+PWryalhijrwoZzmJ9RqbIWsfJ8mpnIz2CHbiNtuKaaN6eePFhXapiQ+F/2jy
         QNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539977; x=1709144777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXrmA+YUNbHeZInMv385ll0KIlZ9s0pW+epVCXD2DyE=;
        b=fh5vx9hxyuDU0HLgmp+yPjagAq0JtR6TdupW/B+ReSCEFT1lOgb07fB7vcHEhQwUxt
         XdmSnoZK7ZO2zCjlW1IsMdcBDhaR5ZqOx9gR2DySBtyA+zqa86Egx3/7R+kHgA9lLp95
         ee1ABV3cvn0nLPU4vzmGLlgvjUuBVwjwFl4Od4faVD5gB1Fr1l4aCzjev0OW6nBeWBH4
         DBPrvLKkGo8be5DZ/roWvp+o4QSH9lezT7NbmfRQypC/EUQq7F1Z2t9PoLaHOuMFJhwC
         2Rn9OiQf+bHn+DQR24jIKBqAThXDGP2VgqEbMCcHMzifgygOBOdXeaiRP1T/g0WBZomm
         2bog==
X-Forwarded-Encrypted: i=1; AJvYcCXV36e4ogmMjnRg9ZWnA03i68G2jmNwuKbA+JFTwQ77LP+SIsfthg0s80CCc9RPti7Ygb8zY4vyuaq9T4XaF95wpXMYng0X+g==
X-Gm-Message-State: AOJu0YxGRRCEg3JBL4gMLK6R0dZxgm95BWOcIuEHn32AFg+I6FjcBmKx
	9k7mVUe0RLgGGWD+dD/RFkVJpXSnHrQNMOYP2Ykhj++/OJULTR7Gz9qnakGnQwXXPpVgA3/UJ00
	Jfa9nx3Onn4gXaT19wYTGOH14WbmIQr5gjG83
X-Google-Smtp-Source: AGHT+IFqS8tJn14NncAWY62WTNABteq4kVyKmIkcCAlDBmY1N2BQti8G3zCHf537pCEhp7uq+qbCNuxgh3NLwozuq4M=
X-Received: by 2002:a5b:bcc:0:b0:dc7:32ae:f0a with SMTP id c12-20020a5b0bcc000000b00dc732ae0f0amr80411ybr.65.1708539977180;
 Wed, 21 Feb 2024 10:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz> <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home> <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home> <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
 <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz> <c5bd4224-8c97-4854-a0d6-253fcd8bd92b@I-love.SAKURA.ne.jp>
In-Reply-To: <c5bd4224-8c97-4854-a0d6-253fcd8bd92b@I-love.SAKURA.ne.jp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Feb 2024 10:26:04 -0800
Message-ID: <CAJuCfpFyrUizGbS+ZnMdp4-chg8q49xtZgFhejHoSi76Du1Ocg@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
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
	dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
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

On Wed, Feb 21, 2024 at 5:22=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/02/21 3:27, Vlastimil Babka wrote:
> > I'm sure more such scenarios exist, Cc: Tetsuo who I recall was an expe=
rt on
> > this topic.
>
> "[PATCH v3 10/35] lib: code tagging framework" says that codetag_lock_mod=
ule_list()
> calls down_read() (i.e. sleeping operation), and
> "[PATCH v3 31/35] lib: add memory allocations report in show_mem()" says =
that
> __show_mem() calls alloc_tags_show_mem_report() after kmalloc(GFP_ATOMIC)=
 (i.e.
> non-sleeping operation) but alloc_tags_show_mem_report() calls down_read(=
) via
> codetag_lock_module_list() !?
>
> If __show_mem() might be called from atomic context (e.g. kmalloc(GFP_ATO=
MIC)),
> this will be a sleep in atomic bug.
> If __show_mem() might be called while semaphore is held for write,
> this will be a read-lock after write-lock deadlock bug.
>
> Not the matter of whether to allocate buffer statically or dynamically.
> Please don't hold a lock when trying to report memory usage.

Thanks for catching this, Tetsuo! Yes, we take the read-lock here to
ensure that the list of modules is stable. I'm thinking I can replace
the down_read() with down_read_trylock() and if we fail (there is a
race with module load/unload) we will skip generating this report. The
probability of racing with module load/unload while in OOM state I
think is quite low, so skipping this report should not cause much
information loss.

>
>


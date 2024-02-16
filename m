Return-Path: <cgroups+bounces-1673-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8C8583F2
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA76FB2600C
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39D13175E;
	Fri, 16 Feb 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="bQxTPOn9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4727130E3D
	for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103928; cv=none; b=oafyz6fjGLpaOojthJoL86B62XSallguPW5bRg5U2EpTaT5UDKc3Hu7g/VaHrmDeGP/w96+rAlCxrX8INdFqFnpqfgAxt46OjFZdeN8MltQCdoVu1hISBgsqFyDD7zzncDRsraX3ezvqvOohcX7hjdx+PTkjqX0gSfO4CuJjrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103928; c=relaxed/simple;
	bh=2eKrnC6xOIWZ1NTwD/IJazyXMwCp/t3u/M4Pc8vdQNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsnFcZG82DqJxgncC53hOIdJ2uynsg2bgb5B6e2DeC7n/oaUSBvqhj0m9C/UjfTDZjwgzWGZkFQ0E/rfYN8OPqQ6sSEU80xqD7llMgRTgOdN1mpoX36xRa0DomqOCm5P6Th4Fzq8D1NE980rfpRnnxAJB4NPLi77otFWnrrx7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=bQxTPOn9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42c758f075dso27988601cf.0
        for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708103925; x=1708708725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttXNwKWugMJyygslP182txVVK8JBh5UVtMFEymJTCI0=;
        b=bQxTPOn9WTXLnpyhxDEsmtOgQUNtA+cfA8a1UJ/SnidZ4cNowB3IzH91BFmbR8yVVX
         n5w9F5nCodKqFu4cv6Uo1TVdfDutrblXDoFJCBkpZNdgpsd3jAvxKQvocFs73FqfCfnZ
         Ty8VcdWL0UVMUiz/dwFRCwY4UMecgApLg+pC9V7lKjQCnK/TDEMitZ+rOeF6cfrnwUTN
         LvwR1PIp8T9BlpxILOqJFiRfZN2sNWNAIXHBG51pGvUgQ4AI+Dmqk3zSvYQ5y0/2lE1r
         bNuROBCX77VZOrM68PUxyOF9LjQHmtZ0WcLMbANRzuWCLmEccyY6XJidFLSGtG0TnzLC
         MGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103925; x=1708708725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttXNwKWugMJyygslP182txVVK8JBh5UVtMFEymJTCI0=;
        b=ZQrbQNQ3GC2WzgNltsaoRre4nsuDXJHuHY+sw7Hb6ORFQGU7FjQxJVP3fD6xqLn5fl
         xWFbHgqqkXAzvISZGZHKozdXy0c1BDPr7kyO8tK5kZPDLkX9PFDOicNQncCjDYaY9VuZ
         r7mZ7q3XMVJOtEryiA4VhpeBFbx4KYHIGPfzyCGsOygbyojY47kente2q8oQdDW+7F4A
         lx4Z1eE7LPeIBg4kTpfmkkw38DJTRYatwkZ2ykTuoQdYAb22YXGLqfVInpkI7plOzyJI
         G7s7hORfqqGYir3TvkXmPQr0XElrAuvXD8cgGA+fu8xo0bq6+6T+heh1RMqFFmG9TR7D
         c6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVq7jULot5hcip/55w7Dx/rXl6C7EdLJ0Kp6mAp9vCICiwp+aE0/Tv9CKHegq+VJcML5e6jRjNL1XHCkEIffZ+EEOBv/39GGA==
X-Gm-Message-State: AOJu0Yxax4DUqwgtMzuvQGcj5ob8pZSigJUgD4ofSoRpKk5lo6LjvN+V
	UkOCTk/sgryOOjx8SypgSulmBDfxH8W1N1hIvjAsXEa3l2Zt20aUi+Zcn5QwxzJEvfbzInGbhup
	NSRi7hkAtg/VMbOCXBapoSnNnGUbAQf6GbsxB7Q==
X-Google-Smtp-Source: AGHT+IGK94jPimX8q7FvTT5r2WHXeqQfvdyDWPQi6YyK2aTQJC/GbkrY2OBKc6aAMFaGl9yMXVM9CDJXDWJJ3i4OZS8=
X-Received: by 2002:a05:622a:130d:b0:42c:7b12:70bd with SMTP id
 v13-20020a05622a130d00b0042c7b1270bdmr14455790qtk.9.1708103925488; Fri, 16
 Feb 2024 09:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
 <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
 <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
 <iqynyf7tiei5xgpxiifzsnj4z6gpazujrisdsrjagt2c6agdfd@th3rlagul4nn> <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
In-Reply-To: <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 16 Feb 2024 12:18:09 -0500
Message-ID: <CA+CK2bCsW34RQtKhrp=1=3opMcfB=NSsLTnpwSejkULvo7CbTw@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Personally, I hate trying to count long strings digits by eyeball...
>
> Maybe something like this work for everyone then?:
>
> 160432128 (153MiB)     mm/slub.c:1826 module:slub func:alloc_slab_page

That would be even harder to parse.

This one liner should converts bytes to human readable size:
sort -rn /proc/allocinfo | numfmt --to=iec

Also, a "alloctop" script that would auto-update the current top
allocators would be useful to put in tools/mm/

Pasha


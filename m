Return-Path: <cgroups+bounces-1654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846B85782B
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 09:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375451F21422
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184818EBF;
	Fri, 16 Feb 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJESOs2Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B81BC46
	for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073772; cv=none; b=OU3ifAPFzDRcGAiqDesOkygB3998/EyvGFhKt5ETPbB276GV8WT6awzug3lQISM+J5ih1+JOK96dyx86+yCIr2bmXmaOZ00x5YijbwNgENrVaZCt2ATJ8DfS1+S3jan+kWBkTaZDMz5JTlZEWIzgGxmCkEBILGUGbWR+UA0fhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073772; c=relaxed/simple;
	bh=uqVdQY9SV/OExKyE4s6w4bLyYMVNFe3RTtHlktWdqeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zsgw76/22ZpqB1soDvER3+2WxsvddqQmo23Z/ROEIdDZ29XVTJLR60I7qTu9wG9FBcFNIEKfqPLf3pIXsHp4ywQMXwjyssXe0yFCCHESKSO8y4w6ZgLJUOivO5ZollM/TAGV6wnQqSoOCpWIgk3Ii3wpaEoBE49AKKVntKz8R18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJESOs2Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e364c985so12966867b3.1
        for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708073769; x=1708678569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/bNm1+I792YdZVlTWr+H7KQ1f6kurFtOITMvEEBO/k=;
        b=NJESOs2Y3PT4OxwP5J1nMk/LAOE1gjA2BSNqG0HtqsYPdQ6hvYlbYkqMzVgRkqvrfL
         J7RFTzIiTpFBCPvTlecAzLztnmNG3we0hR9SfcERJoPu3wyDe0V7dahUWc+qLaAoeYfz
         W0xWLaYZDBuVLwFw4HrwaPjyF5v8xSanMZLNhiNuZYkRAnHdXC3cLmB2Vjp7zhiV6j4T
         g9x5W62Sv2TqDGPd9K1wN2N/pvn+RBM/GYBnzpZyadzWEF+PsSZ1nDXJgupop8PfHiX7
         Kwruhvoj9uo9UShr6VyfS2Gw9+qCM9OcsQyzMhnDWe92QGFNgNEOuBpX3y35+oHwW3TY
         etsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708073769; x=1708678569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/bNm1+I792YdZVlTWr+H7KQ1f6kurFtOITMvEEBO/k=;
        b=krhAIph38vk3V2mGr5JHKQDf3OjzdRqZS3XSFvPOS1RBuAKd1QSrRferCvOuwlvhGA
         Y60i3HS4yEjZZHNAc2vc0t98s6MVQIqyJPp+RaIgOvPNWLwEoU1woUj6zbj2pRzqsA/+
         WeY3rdnnD1R5IWbEm4BpxlCSvUAsUSTvGOC+WruXRPXC1dMnTPsiwqQsD+kd3BvSzRzw
         ytv2UTK5rw3+aaCdIkAdQnlKbe07blJkq9a/LMuvBfE9OkT9B/lek6Lwrs4vb+HtBydK
         325xonhUm/pwY4lTUfgNQ11+YyP5hXK0Kc5Wvg+Mp6nAbFZsX7PqgpEZMphL/y7EMtdL
         wgzg==
X-Forwarded-Encrypted: i=1; AJvYcCWverLC9Xr4yIBAdzxCFVmI+iXMuewd7sgZPHgAi/iVv4Li9jLrmrGUyplt8aC70owizdBoZNWPIiRLLmk57Xfxv7w8A75I5A==
X-Gm-Message-State: AOJu0YxZZ5ClDFnI8kO0XeWBkNr67rqnaMmxRxGESEBxtqK7vYuYMzSh
	5Gr6YZd1pzQKQbkTP56NiuCv/hUW/HbO+K1yigcJi7mY55ANuJbhiJJrZHzTyKpw0l6sUDkaI6W
	2S9QG28/1mOMPQuu6kdx89iyBpylBOrskIKkc
X-Google-Smtp-Source: AGHT+IFw3ocFlZSouw+paS1hIeBQ1jvyrkD/y9wwPSet8TNkGfntAT9zTk1byuyak5s5oUNAVQdQpoe3oTLJW/QgCY8=
X-Received: by 2002:a0d:e606:0:b0:607:9d64:d68d with SMTP id
 p6-20020a0de606000000b006079d64d68dmr3931990ywe.11.1708073768807; Fri, 16 Feb
 2024 00:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook> <CAJuCfpGU+UhtcWxk7M3diSiz-b7H64_7NMBaKS5dxVdbYWvQqA@mail.gmail.com>
 <20240213222859.GE6184@frogsfrogsfrogs> <CAJuCfpGHrCXoK828KkmahJzsO7tJsz=7fKehhkWOT8rj-xsAmA@mail.gmail.com>
 <202402131436.2CA91AE@keescook> <af9eab14-367b-4832-8b78-66ca7e6ab328@suse.cz>
In-Reply-To: <af9eab14-367b-4832-8b78-66ca7e6ab328@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 00:55:55 -0800
Message-ID: <CAJuCfpF_RbdQhUpJfQNiYHXwheojF07R-L7Y53tmLZRgr7iR6g@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>, "Darrick J. Wong" <djwong@kernel.org>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
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

On Fri, Feb 16, 2024 at 12:50=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 2/13/24 23:38, Kees Cook wrote:
> > On Tue, Feb 13, 2024 at 02:35:29PM -0800, Suren Baghdasaryan wrote:
> >> On Tue, Feb 13, 2024 at 2:29=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> >> >
> >> > On Mon, Feb 12, 2024 at 05:01:19PM -0800, Suren Baghdasaryan wrote:
> >> > > On Mon, Feb 12, 2024 at 2:40=E2=80=AFPM Kees Cook <keescook@chromi=
um.org> wrote:
> >> > > >
> >> > > > On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wro=
te:
> >> > > > > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definition=
s to easily
> >> > > > > instrument memory allocators. It registers an "alloc_tags" cod=
etag type
> >> > > > > with /proc/allocinfo interface to output allocation tag inform=
ation when
> >> > > >
> >> > > > Please don't add anything new to the top-level /proc directory. =
This
> >> > > > should likely live in /sys.
> >> > >
> >> > > Ack. I'll find a more appropriate place for it then.
> >> > > It just seemed like such generic information which would belong ne=
xt
> >> > > to meminfo/zoneinfo and such...
> >> >
> >> > Save yourself a cycle of "rework the whole fs interface only to have
> >> > someone else tell you no" and put it in debugfs, not sysfs.  Wrangli=
ng
> >> > with debugfs is easier than all the macro-happy sysfs stuff; you don=
't
> >> > have to integrate with the "device" model; and there is no 'one valu=
e
> >> > per file' rule.
> >>
> >> Thanks for the input. This file used to be in debugfs but reviewers
> >> felt it belonged in /proc if it's to be used in production
> >> environments. Some distros (like Android) disable debugfs in
> >> production.
> >
> > FWIW, I agree debugfs is not right. If others feel it's right in /proc,
> > I certainly won't NAK -- it's just been that we've traditionally been
> > trying to avoid continuing to pollute the top-level /proc and instead
> > associate new things with something in /sys.
>
> Sysfs is really a "one value per file" thing though. /proc might be ok fo=
r a
> single overview file.

I'm preparing v4 and will keep the file it under /proc for now unless
there are strong objections.


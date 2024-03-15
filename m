Return-Path: <cgroups+bounces-2064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACB187D094
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 16:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BEE1C22482
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E9405FD;
	Fri, 15 Mar 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BK1grvRy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A883F9E0
	for <cgroups@vger.kernel.org>; Fri, 15 Mar 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517635; cv=none; b=jUcwccTebi5fudQRR1JdzNTHjm1tF3mFgmwahj5rM2B8NZ1VNbZtIU/lBMs5UKcfm2WCg/NXYn27EClxgtsZNAOAnH2PzHEp8ENJRjQYO/IprGvWOyUE7PzdMrq59DC5+bytk4wPW21lNQpi4cCXJzAXFwNqgsOZ0LVFQEQpcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517635; c=relaxed/simple;
	bh=wNtT6+0t+kGzkNhG5FyRgYZZ74DtQijFGV7l7mpb0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPB/gWk20WjJ57lcAwxTsrx5jNxtVH2PAUOf03arxcVa9poOI8b/QYtONy6/otbKv3XjAP40ZRj7olAX3cs/yxZz3bIz1zSzmmkB02sQbHxjZpMi8oro5eD1Wdp/QCNStnNJG7ZmgPC4+w+6qT/AaNFXOPygCIhcueM+AY+Ijsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BK1grvRy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fb0450d8so23798647b3.0
        for <cgroups@vger.kernel.org>; Fri, 15 Mar 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710517631; x=1711122431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=BK1grvRy0GHfMYHQ/RADrgIOOArUHGsc9V9yMuEKUvHDWqdM6klTeI+9Z7Oam/sMoo
         Zs22/qsOuClHiTVqN7YvL/pFRDkWcsLJG3YdL0ZYBd17g4wf5f8aY51KGl26wOY17FH5
         kSrgnTgXtBg1H+IERx/QKVpNEp2fNdolrXUDJAWoMQwo/VkMHNldV/x9SYE+lgYVloK7
         TF2QoIVu4k8YJSGWZ/z/zvoyo2bHgLm2yOAps6MBjiHnpF9Xlkh/Aqo5kly72MY7s+Su
         mtst0LviU8A/+0YeiJwKtd+oq6cUXloRNoOqWuAG+lOG+LVr066k02W5V0atYmHs0t7y
         +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517631; x=1711122431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=YTeYCT3/ONedcvuHabnopLV//n1z4tgCTKkgksBT2xULJFy2cnowOQ2U2mJ2pCazqR
         AG15nbjtsVzgmLIg+ezVGi9Ex5IbkmW5EuCG2EUO26YRcoCYSc2JXA2wqCzaJpwZHDdV
         GSYQXL7I2j7+vb6WojH1wt1IJzziyhsbMF6do3hjh0XsqRnHakDnV5T+RmRqH9qiPCK+
         S0OeLhDBvevwOS4zp7TUYtS54xfLBYPo5Yk8WJjPEAJ7kBE1qlvsvZXa4P4BT24zItn2
         0Xsl+9FvwVSHgsf7TpJvJKYim6jk+W1VDUh4YEA85hEtAoTrFIByvar5o/AadVS967RG
         EqZA==
X-Forwarded-Encrypted: i=1; AJvYcCVRWa+Y09NpN/TN1s8LzQTN+xhvtQ/SjqqZpHUc8tKMuEEeuzxiMhj16Eze6V71LMn+lAdgK6ykoYjgCGPF62pI0+sJfqWT8w==
X-Gm-Message-State: AOJu0YxM/cE9rC93aGBtyx0u40D1bhY2bsr16f9oI5xI+FDncHufS9U7
	2z+kgjLF2v9vierTBmyV5FF0NOJvweKQlEFGSBqtl5jidbeeG7zKCTPrpsAwGdMcC757cKGyAIZ
	2fq0d4VvD5UEsiHsPCz9t/uKGBqMPvvUJ+fRq
X-Google-Smtp-Source: AGHT+IEwiyjib3jLb0fcW3RfIFy8PuKVxjXiqnQa/2aHEZk0YzBmdn1yExjQqvOF2tJR6SyIA+70XUnt7nI7TF8fE6Y=
X-Received: by 2002:a25:ad5f:0:b0:dc7:4f61:5723 with SMTP id
 l31-20020a25ad5f000000b00dc74f615723mr4966380ybe.39.1710517631010; Fri, 15
 Mar 2024 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-15-surenb@google.com>
 <ZfRaBJ8nq57TAG6L@casper.infradead.org>
In-Reply-To: <ZfRaBJ8nq57TAG6L@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 08:47:00 -0700
Message-ID: <CAJuCfpEpMwfEgrsMALqpzH=3FL0WxrXY1bRkvezMdCw2BAtQRg@mail.gmail.com>
Subject: Re: [PATCH v5 14/37] lib: introduce support for page allocation tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:24=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:12AM -0800, Suren Baghdasaryan wrote:
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order)
>
> If you make this "unsigned int nr" instead of order, (a) it won't look
> completely insane (what does adding an order even mean?) and (b) you
> can reuse it from the __free_pages path.

Sounds good to me.

>
> > @@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >               /* Do not let hwpoison pages hit pcplists/buddy */
> >               reset_page_owner(page, order);
> >               page_table_check_free(page, order);
> > +             pgalloc_tag_sub(page, order);
>
> Obviously you'll need to make sure all the callers now pass in 1 <<
> order instead of just order.

Ack.

>


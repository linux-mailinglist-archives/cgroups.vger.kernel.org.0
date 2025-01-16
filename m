Return-Path: <cgroups+bounces-6198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AAA13DC5
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C8A3A1FD8
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4C22BAC0;
	Thu, 16 Jan 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiboD/Me"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2022B8B2
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041764; cv=none; b=FB+nGxD+24T8k2fK0rSFLZvomLzYYWpwcBA0lKDzhpl8Nw9rn8Lb95OUTnbGdfwjQRAe2DUcBpAfWxPg5m0l2u7MpCF8Y9inJUpp1Ee6+KmaT25TvPzmgS9Stuw+pu3ij1gzqXXMw9JGvwM0IhpszmJqiSmp0YOh9MVUur8/jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041764; c=relaxed/simple;
	bh=fo1NgW63J4SKuzXXMhTWxFtnNcHO6pz7B41Kv4sChNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHOodalJ9NO4CYK0HwbxKU7dIgDIMk06HAM1jEs5VpXK1C6IHvvP9fAhi7TXhKoI9M+9QhnpM6txlnqpbs6z2T6TeaVO1Dmdru3CH1DgBAdsyFppm3YsuM7LlKwWxu8cmtPJyJLNtgFFqlsMLVWHjnBYjybJRKLBxmlTMAzc6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiboD/Me; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e1a41935c3so13604096d6.3
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737041762; x=1737646562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwoQXtB03J2k0TrNlaF4zg+3HM5xnvoWUuazwn262Ng=;
        b=LiboD/MehyR4eQjZwqkeqVqWej92pjoU9EuBZk3t40Mw1FsrYItOOULL+K17Icn4Da
         /uX+YtwaVOQChTR/2LQ8zWz6TDxIZN51xTiFL2CpsrE1z4T5ckeJuYEA3zJETvJnqOax
         TTsoWmCC5WfMiWYk0le8j8MEh72sYccy8NnAlpxjzynRzDhxIO87IQEDozwznG3Nobqh
         uZGn2y09TC5YQqQzeezLpBYiyqOZqUwXAMug7lnCLWobJxbJ3botZK/4znp5JwSAOKUs
         RaLil06kwazgdJ8B9Cs+iWc3FP7IDlt83NAH39iCx6pBZ8v281kAM4dmI0tIVZN2N5fv
         e2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041762; x=1737646562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwoQXtB03J2k0TrNlaF4zg+3HM5xnvoWUuazwn262Ng=;
        b=ah2um4E2zLZG1Vo2H671/2P1gVZJRvnfMz01RlEXrub5aZmjcL0p9KxXETDmp2TiAL
         xUXwF9yUSp5oYa0uhSAwxbE407FVvM2Bd8H6yRGAUYr/7N484RD9QV1tRRGS10ZVCCF4
         1TlDLJl4xGUi9zS9St915ERy1EgnrP1ba1Zem5jplKysTOg/B0iJbHiNNlXzrsuj5N8P
         KzivHlRImAgKb+SU4+awhOAxjA9fzU55RKsfKI9WHumeL1dj322+R1U9hrSs/EiBkCRO
         Rv1wbCmDKHeEZ7F5pNGSmizUep8Q+oeI9OV06SYcaXc0q6HYZgqJPMHRkplvLRFS9x5e
         Qf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXro9tzxMdjt3PNY4GPZ+CmdZVk6761mCc8F7wx53+oPY4mYPXE0XHWNOKYhHwHgRlA0M6cxsD6@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCr5KntuBnQm2fnPye27+R14pU1sEK9pPXeJ2gIGTHdJ5CnxN
	Cu7hnIfz2golhqjRS/76+tfAkhIhDKwRNsFRxkqYsd1BfhyC6Onv05Fo71A/EMgii3fulCqCkzL
	zvFRsMHHwy9syHRs1Ggg3wkRwcimvSJfoFWNf
X-Gm-Gg: ASbGncuXHpyr2B9Q/XtDPAy2NPqqfO/lB8AcpP1/VYnM5+0F2PoMAU6y6N0JgV6qeSr
	1G7qrBdzcpz29uRgh2zIG+pcG6tFwpz/Kt5c=
X-Google-Smtp-Source: AGHT+IGQx7oMBedqeGgpo6yQr9WNwpasiimO5fE+NbzzO4q5VJOFglCPvDATO0nKf03AVFZ+/JKqZYOHXU5sX1cr04M=
X-Received: by 2002:a05:6214:1d0b:b0:6d8:86c8:c29a with SMTP id
 6a1803df08f44-6df9b1ce0fbmr604590146d6.10.1737041761771; Thu, 16 Jan 2025
 07:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa> <gn5itb2kpffyuqzqwlu6e2qtkhsvbo2bif7d6pcryrplq25t3r@ytndeykgtkf3>
In-Reply-To: <gn5itb2kpffyuqzqwlu6e2qtkhsvbo2bif7d6pcryrplq25t3r@ytndeykgtkf3>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 16 Jan 2025 07:35:25 -0800
X-Gm-Features: AbW1kvYFC55FklfPWaCbeq5zpRtCrNzWLETLwIsv7izVGGfcV01UiDEi7-li7Kg
Message-ID: <CAJD7tkY8sge3wxqjFMa0CmyhjXv4_o7vDz5SkptxnK62noUHyw@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 7:19=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Mon, Jan 13, 2025 at 10:25:34AM -0800, Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > > and flushing efffectiveness depends on how individual readers are
> > > correlated,
> >
> > Sorry I am confused by the above statement, can you please expand on
> > what you meant by it?
> >
> > > OTOH writer correlation affects
> > > updaters when extending the update tree.
> >
> > Here I am confused about the difference between writer and updater.
>
> reader -- a call site that'd need to call cgroup_rstat_flush() to
>         calculate aggregated stats
> writer (or updater) -- a call site that calls cgroup_rstat_updated()
>         when it modifies whatever datum
>
> By correlated readers I meant that stats for multiple controllers are
> read close to each other (time-wise). First such a reader does the heavy
> lifting, consequent readers enjoy quick access.
> (With per-controller flushing, each reader would need to do the flush
> and I'm suspecting the total time non-linear wrt parts.)

In this case, I actually think it's better if every reader pays for
the flush they asked for (and only that). There is a bit of repeated
work if we read memory stats then io stats right after, but in cases
where we don't, paying to flush all subsystems because they are likely
to be flushed soon is not necessarily a good thing imo.

>
> Similarly for writers, if multiple controller's data change in short
> window, only the first one has to construct the rstat tree from top down
> to self, the other are updating the same tree.

This I agree about. If we have consecutive updates from two different
subsystems to the same cgroup, almost all the work is repeated.
Whether that causes a tangible performance difference or not is
something the numbers should show. In my experience, real regressions
on the update side are usually caught by LKP and are somewhat easy to
surface in benchmarks (I used netperf in the past).

>
> > In-kernel memcg stats readers will be unaffected most of the time with
> > this change. The only difference will be when they flush, they will onl=
y
> > flush memcg stats.
>
> That "most of the time" is what depends on how other controller's
> readers are active.

Since readers of other controllers are only in userspace (AFAICT), I
think it's unlikely that they are correlated with in-kernel memcg stat
readers in general.

>
> > Here I am assuming you meant measurements in terms of cpu cost or do yo=
u
> > have something else in mind?
>
> I have in mind something like Tejun's point 2:
> | 2. It has noticeable benefits in the targeted use cases.
>
> The cover letter mentions some old problems (which may not be problems
> nowadays with memcg flushing reworks) and it's not clear how the
> separation into per-controller trees impacts (today's) problems.
>
> (I can imagine if the problem is stated like: io.stat readers are
> unnecessarily waiting for memory.stat flushing, the benefit can be shown
> (unless io.stat readers could benefit from flushing triggered by e.g.
> memory).  But I didn't get if _that_ is the problem.)

Yeah I hope/expect that numbers will show that reading memcg stats (in
userspace or the kernel) becomes a bit faster, while reading other
subsystem stats should be significantly faster (at least in some
cases). We will see how that turns out.


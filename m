Return-Path: <cgroups+bounces-1332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D96847E3C
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 02:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE281B26941
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD523C9;
	Sat,  3 Feb 2024 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpVskmD+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1E1FB2
	for <cgroups@vger.kernel.org>; Sat,  3 Feb 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924192; cv=none; b=kI6NsUY50a0zVIg9Gda3Q0RMuVMSPn+DTu/nzensDmTjWkNSX7yOtf114qKOuwUmZZfFAgjyyh+BbRgLS+TWY1QhAUybpnbX7NH4kU5ViBSSjCnCHMK0+HI9z+xPbD2oNT3OopCy1QxEN6HwsssaRoiS9q0Oj4PUkaybM6BD7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924192; c=relaxed/simple;
	bh=Hf6uyk3PkhlfPyC3HRqmW4VM5M44oxj62qu0PS7I3jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyHGVpa6WC51nlRE6ICHV2KgA/M5Kk/+n9E3ODQjZCA0qFzhm7bXtpQ89R+oVivWPn6hKKcOoM1mYwRojbt+vNpz9LjQqlSanCLdlAdVH78AA1YpfJag96QWs18dYwH98C53drTf7pkjagLWn8266HsWzjMcva1QMseVhQvlNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpVskmD+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35b32bd055so342228866b.2
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 17:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924188; x=1707528988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZtJdSb7EI9zmC17ta56Eu+wHYjQhwSEAchKE32W20c=;
        b=TpVskmD+gga1/dXm1v3DEPQN+/3QUZ2KjZC8QrTCoDjmIot4QuOKBGcCgjag+YMphE
         BEwDcnrHJyoH0Y9wWoWr7am2FPPDr/P6rI2K9Epwke5tR62hBJMIUMZd7dRQoL0AMWzr
         CGIqsB5T8GgOieFornDqQelozvoDRr4n9VDO1rEtbbBKSSmo9dwSZImdN+Luei2xyTck
         j8zZxUm7+BEZegQ1m2rY2bqHRFnMk0v1fB4yvVrfrP7DWICSpzr+VO/y3ZzciLZeKx8k
         Yk4psBLjtdwIbersIKf3mH2wAh9+hhDsqRyFBZJhrZIjCf1mA/WAcyYkejghdxE1uY/w
         4yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924188; x=1707528988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZtJdSb7EI9zmC17ta56Eu+wHYjQhwSEAchKE32W20c=;
        b=pOVBFTpwEpuP5EVj6hhedcU0q3fPlOyxr7uOch+gqR1iYmZcsnnqNj7E+ec6xhbx7A
         O1SVCCBHX5f9HtGRrdqG6eP3uhwoWhwOE0uTW1fcQKL5tJnODQJGT2/vwS6UDRtZk44s
         yu+Qx6qLPt6Ab3w+5gyZrwoVN7IUhujtbPg+7XVNmqndvdEOzpNsTTI/Fnrq+AZpo4uL
         gSAWlR13dAm7AsNfzfTWldXKxB/eY1ngdUt561bl8vpgO4ptmR05JTgUFlJ2hRRWb/LT
         Zzx5Ez4Op6TvQPgnl9A+1bYoXfaD4quHjrVegZqEhy7cU/dfBrlgZ5oiaMVqYT8x1kM+
         wgFw==
X-Gm-Message-State: AOJu0Yzleokme5SOlgQVF1A6zEybWWhyY/HBdeJRVR6GnKKMQGg1j5QY
	DLhcYcd3RWV4u+Sf7KPtOoxb21jntFOiIhpUg873ds1LpCQ1NzCf3poCDfv9DzfprWCctj7fkZ8
	jgMP35M+A6mx430MHAtG9o3du1TRrGSAb3jsr
X-Google-Smtp-Source: AGHT+IESunm6BBZ+RT4xmmTLaeoG0U7tcSgV83ArDerCBOVGM3/ZzMDno9Ecy/mHegvx1S4l6wD5GMMFI3eEWh5MYUU=
X-Received: by 2002:a17:906:36cd:b0:a36:55d5:2364 with SMTP id
 b13-20020a17090636cd00b00a3655d52364mr2781404ejc.21.1706924188353; Fri, 02
 Feb 2024 17:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201032718.1968208-1-nphamcs@gmail.com> <20240201032718.1968208-4-nphamcs@gmail.com>
 <Zbtfku0wVGXBHDTD@google.com> <CAKEwX=PH5abBFCjYHL+d99v8MMwiASqP83aF2vSv1iwezX3UHA@mail.gmail.com>
In-Reply-To: <CAKEwX=PH5abBFCjYHL+d99v8MMwiASqP83aF2vSv1iwezX3UHA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 17:35:49 -0800
Message-ID: <CAJD7tkbu+nGMuvkK3B9-Ekt9+P_wtwOM1A_9cAM0wLM7trO+CQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests: add zswapin and no zswap tests
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, shuah@kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > +{
> > > +     size_t size = (size_t)arg;
> > > +     char *mem = (char *)malloc(size);
> > > +     int ret = 0;
> > > +
> > > +     if (!mem)
> > > +             return -1;
> > > +     for (int i = 0; i < size; i += 4095)
> > > +             mem[i] = 'a';
> >
> > cgroup_util.h defines PAGE_SIZE, see alloc_anon() for example.
> >
> > On that note, alloc_anon() is awfully close to allocate_bytes() below,
> > perhaps we should consolidate them. The only difference I see is that
> > alloc_anon() does not check for the allocation failure, but a lot of
> > functions in cgroup_helpers.c don't, so it seems intentional for
> > simplification.
>
> Hmm I didn't know about this function. I think it was Domenico who
> added allocate_bytes() for the initial zswap tests, and I've just been
> piggybacking on it ever since:
> https://github.com/torvalds/linux/commit/d9cfaf405b8ffe2c716b1ce4c82e0a19d50951da
>
> I can send a separate patch to clean this up later :) Doesn't seem that bad.

SGTM.

[..]
> >
> > > +     if (cg_write(test_group, "memory.zswap.max", "0"))
> > > +             goto out;
> > > +
> > > +     /* Allocate and read more than memory.max to trigger swapin */
> > > +     if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> > > +             goto out;
> > > +
> > > +     /* Verify that no zswap happened */
> >
> > If we want to be really meticulous, we can verify that we did swap out,
> > but not to zswap. IOW, we can check memory.swap.current or something.
>
> Hmm would memory.swap.current go back to 0 once the memory-in-swap is
> freed? It doesn't seem like we have any counters at the cgroup level
> for swapout/swapin events. Maybe such counters were not useful enough
> to justify the extra overhead of maintaining them? :)
>
> Anyway, I think checking zswpout should probably be enough here.
> That's the spirit of the test anyway - make absolutely sure that no
> zswap-out happened.

The test is making sure that even though we used real swap, we did not
use zswap. In other words, we may see a false positive if something
goes wrong and we don't swap anything at all. I know I am probably
being paranoid here :)

How about we check memory.swap.peak?

[..]
> > > +     test_group = cg_name(root, "zswapin_test");
> > > +     if (!test_group)
> > > +             goto out;
> > > +     if (cg_create(test_group))
> > > +             goto out;
> > > +     if (cg_write(test_group, "memory.max", "8M"))
> > > +             goto out;
> > > +     if (cg_write(test_group, "memory.zswap.max", "max"))
> > > +             goto out;
> > > +
> > > +     /* Allocate and read more than memory.max to trigger (z)swap in */
> > > +     if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> > > +             goto out;
> >
> > We should probably check for a positive zswapin here, no?
>
> Oh right. I'll just do a quick check here:
>
> zswpin = cg_read_key_long(test_group, "memory.stat", "zswpin ");
> if (zswpin < 0) {
>    ksft_print_msg("Failed to get zswpin\n");
>    goto out;
> }
>
> if (zswpin == 0) {
>    ksft_print_msg("zswpin should not be 0\n");
>    goto out;
> }

SGTM.

Thanks!


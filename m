Return-Path: <cgroups+bounces-1778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7027885E9F2
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25301286BB3
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20281272D7;
	Wed, 21 Feb 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JxUB1ljL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE2127B6B
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550472; cv=none; b=NBJmWOIazHdNuqHm3GywHK1U+6xKj/AW7gtpdsJL/zCa0C5gOT8StzUDb6HXTTNCpLkXBIdQqlSfxkszaM+F+pzKgRchgulzqIlvNznETfVLsEIHT4sBjzeVrzGtUKMtn1UAO1xpI8fHIh/FsbWZbypNse7S/RBYFboP/bkWE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550472; c=relaxed/simple;
	bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoLjfz8qpiEkJ6vcnkt2XGV3J9O1ele/HlkA1dI27Bk8hTER9ja4mIArpzjgbESXIZ0Az3U071rgi/wvUZTnGuSip7/kowZfLocPfP5+XZAyNRGGP7YEEwDL4+AzzqkC3hgvnXtyH2I4AiIl1X+w4et1oTBX7fBNu4P1BSTetOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JxUB1ljL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a0ba5098bso40436211cf.0
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550462; x=1709155262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=JxUB1ljL7XvovtiVCEiIV+ZgtEh/WCr4kltgFFgJQOX/Nze6UEOtT6SfoHf94oS5jO
         F3PgJkRi/OzC+uTdyAXVDZmtuBXx1QevUcedfG5duFQQZh76wbB6L3+KWuUhGIpLKmeg
         lE+A8eFEnzaYCiggTXZqyAlSoc8Xi3sSVCBTwEevS3Nb7Wvz9IiH3Mvo9QqvuKM1Exzq
         rmwxKg2TCPQiLQ4fmnLgyPwn+aTdMq13ksJqrR7dXfzOnHvMAEgoLrl3ha+pGyxeENnF
         JY0D23vKekg6Y0NHqqHpT8rjyB+aP5mxYFacnV4aFLgKRoeUbHuCMt7fUBTn/1Ola9MY
         AQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550462; x=1709155262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=cJLPuNiwNBL2ry4pckLjqZiPk2vqJAF8Bzkdkl5IX5xYmj8UQUo3ff1bfz0imGtca7
         8O6q8AJKtCqYp9M3zl2WgSZS5eDPkM5qAfJMS3GnUNEd/PZv8wHnXPaCB4/wq3JF8mqK
         6KsVEEYkSEcQmrxzjC13bt9w1o5txQCBl/YDpBwq8etKmXTpvNFMmeAbIOYyHRmjuTks
         Zt/GZTtooUEOrw3GtY75MMEihBRaZJSkK1N+XeYdh4jy5bCfXwpQbISB9T9k52cZgSq1
         oauKTZkMS14sgmMlDeoehIinxi+rin6N9Umvwz+wTUTGeAYQSdoNbNChuJJp85R/jyMw
         Z0bw==
X-Forwarded-Encrypted: i=1; AJvYcCWFUjOMZeDyAKdKWYrfJO8fumYuMm3nYodoDqWUdZowpVhg4qK+1Gj4Y9NNDdtZwrn0kUsHyDARHC+Ca7d0QMDWRzTJp+Qsmw==
X-Gm-Message-State: AOJu0YwF1TDYB7Pkgt484QXJWypm/Ucn73hA3lW4263e7olDStD/TAY/
	/qNGMWDe+HQWm0SvBPQpKPyfkYWj9mymHVjgnSQCc0T/n/+zwfcWXzZVNTyLE2CM2ITTOyUAidP
	BriRgR3tv3yvIL39MPWMAeQYoN/gYau02nf5YxA==
X-Google-Smtp-Source: AGHT+IGJtekCGEzDieaihS15p2Hc5EreGxKXqPCCpXJixs6Ac2iIPaw+nCtg/oETMxVwF6eTa85a+lNh3bwEt5JkkGQ=
X-Received: by 2002:ac8:5981:0:b0:42e:17d9:f8bd with SMTP id
 e1-20020ac85981000000b0042e17d9f8bdmr9654015qte.24.1708550462298; Wed, 21 Feb
 2024 13:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-5-surenb@google.com>
In-Reply-To: <20240221194052.927623-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:20:26 -0500
Message-ID: <CA+CK2bBqUV-mTOYSuDCBaMjy+HyEs+=YnY9Ay9iQ45mStSn47w@mail.gmail.com>
Subject: Re: [PATCH v4 04/36] scripts/kallysms: Always include __start and
 __stop symbols
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
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> These symbols are used to denote section boundaries: by always including
> them we can unify loading sections from modules with loading built-in
> sections, which leads to some significant cleanup.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


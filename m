Return-Path: <cgroups+bounces-1551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DF854065
	for <lists+cgroups@lfdr.de>; Wed, 14 Feb 2024 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041361C26377
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 23:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F163407;
	Tue, 13 Feb 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="iZIWTFME"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372E849C
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868489; cv=none; b=rGEBbCNxF/OBhnp0li60lJEpG+HJBLA+RDrAGtactzgSg2e93+sgD0X6WAjziQhoMz/yOLlMn52lZx3lJTJcTpXolSGUGtaQ/SLjbvuSqekhbjwOm0eM4d51uHgEl2MQA8NNOSpF/lbBYQM/ivsIg+oImrLOQX978ST0kwaprds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868489; c=relaxed/simple;
	bh=azZvqzbTFipUnuC8HX9TaKZdjTIk9iGcAhgBe6cJRrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR1BCKAlksLJHdc4JemkJ7Xoz5lu7hNC1G2BmXpK0rsGDCuXb5rmPGZKIiPffUshuikM8W20b+f+PPyypUUbkI5DOwCexSVQLlQG4TYAa6APPoaAd2TnVk1gc/PcbM7Ep+9EZEnlnQgY9PHux6wMwwybi2OB9LfRqxpfQxr6HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=iZIWTFME; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42c6b6ec76eso31603151cf.1
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 15:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1707868486; x=1708473286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azZvqzbTFipUnuC8HX9TaKZdjTIk9iGcAhgBe6cJRrA=;
        b=iZIWTFME+t+1SHOM4yinordj9CYruFblhTVUvUm/W2nVLfGoAk0wGwx47CyflginyL
         eJ0RfbdAzZCfikmzvtiggCm3X0xJxdc6vf9baCea+zdo48Ua4RoG90WIMjqjxySsISZW
         Jlw7/YPzvUoMOXACZx/Ohyb+YgL9kD4+Ikcg4OMr49xmcF46nGxwG8VQMluOOeAZG7IR
         tgZCffzEPQbegLqUTg7lQzJHp0W/4ij9QTKCspJcUqyCjwYKvN6UgUaLHG3V+Gby6bxd
         zKJ9KT/8VMAc3EdhCSFH696NoT8yEs8oEgKCYxE/72LrScYPwq98k25LYKxT0fN7HZqP
         J+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868486; x=1708473286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azZvqzbTFipUnuC8HX9TaKZdjTIk9iGcAhgBe6cJRrA=;
        b=SzYFNAhoWC6qaAMvUJEEHBLVOla+5xSvh1sP+sZv0ObJiDTOY2ToIY4QAlDhT+gZw9
         AMn500veP1LHOesU/pLk+lbIzNXXCjYUpMzUoi0FB8MnVO+NjLpy5Fez6WNgc3/P/kGW
         MYO0gbQslVFS3KAa+zA0UnbXKrHDRYOIZTLsrkH7aLYcLn0vRdIYV8KpZqqx3zBbCqHv
         iale5PZh8F0KWEwkBnewchK9gfrO2TQDxiaN7qDQAtzGrEOlvdPpqP83sRNRvw2e8aSe
         XhxGidmLu6/w+F6CawKFjxzLTkAE4b4omKrAOSC5NixfLRu76vSS7vY+T8vbz16VAVHI
         1Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCXag0agB9ATbD0rvJjr7EfN0k3ckB5CwQurlxJ6ER6ivmlkqzLrF9DWsRbLkkbh5aL7shzljWn6N8Um5m/zP+y8/Q3cBnbAYA==
X-Gm-Message-State: AOJu0YyYszfXxs1YHbRSG56TpEuTjspoRLhkBDJwSMf5ujp4cuRoYJr7
	qTgyKvC0gffYPQHAPBtRRbwZw86ljZ9LtaXpAwK3NI801H/flWcVpBS0VOKbzOgxs+OtCUe/Iwv
	wzSDVDGLq2UeqEhBgPNnlxvJaCcGgs0NqcOQuZg==
X-Google-Smtp-Source: AGHT+IEvHYDq5ElFOxC+Jycs64+Hk1KrOdwVZPwmI5s/vqF7SbUqUg8DtswJfzCkhvxh12zppSmre5tJAe7RcmjwUGQ=
X-Received: by 2002:a05:622a:41:b0:42c:6fb6:8d2b with SMTP id
 y1-20020a05622a004100b0042c6fb68d2bmr1159462qtw.46.1707868486727; Tue, 13 Feb
 2024 15:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zctfa2DvmlTYSfe8@tiehlicka> <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com> <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com> <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com> <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com> <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
 <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com> <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
In-Reply-To: <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 13 Feb 2024 18:54:09 -0500
Message-ID: <CA+CK2bCvaoSRUjBZXFbyZi-1mPedNL3sZmUA9fHwcBB00eDygw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
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

> > I tried to be helpful, finding ways *not having to* bypass the MM
> > community to get MM stuff merged.
> >
> > The reply I got is mostly negative energy.
> >
> > So you don't need my help here, understood.
> >
> > But I will fight against any attempts to bypass the MM community.
>
> Well, I'm definitely not trying to bypass the MM community, that's why
> this patchset is posted. Not sure why people can't voice their opinion
> on the benefit/cost balance of the patchset over the email... But if a
> meeting would be more productive I'm happy to set it up.

Discussing these concerns during the next available MM Alignment
session makes sense. At a minimum, Suren and Kent can present their
reasons for believing the current approach is superior to the
previously proposed alternatives.

However, delaying the discussion and feature merge until after LSF/MM
seems unnecessary. As I mentioned earlier in this thread, we've
already leveraged the concepts within this feature to debug
unexplained memory overhead, saving us many terabytes of memory. This
was just the initial benefit; we haven't even explored its full
potential to track every allocation path.

Pasha


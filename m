Return-Path: <cgroups+bounces-7863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C8A9E6C9
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2F169DB2
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354319007D;
	Mon, 28 Apr 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw1SOGIP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD64431;
	Mon, 28 Apr 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811841; cv=none; b=ZSCapG3t56bMB0+CkYFS2UptKC3FzbhZybOChaonPOfQpMnPSWTQyl6DDPcgMIruqosuFQ08d3wzIZMIScXCiaj+CplATuQitL1+SBZ/i7meVUz0p9oyTcDrAaC2Lzx/4PYvK8TCCP4BIoo9JR88sT5YjaAHKdc5xIDge1GmviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811841; c=relaxed/simple;
	bh=zM04meY/cNVobywryZ3QNUIjX4LroMojaucg0JZUKCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0UMAH5wFgrV9qsYDvRhcA3zEoBnPT+pRlbeDlewdQSk3v4ROPjUk086j+FC34VwINXKW/V6BH9mWlgHL/+NEnAAYmlmAhVsCpzrrKW2wrlfSd9l6byvszpsj6OEZFsa95tn1XGTy3UqqR/vZ0Ppav9+6517n9oST7Ylk3jxXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw1SOGIP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso41178121fa.0;
        Sun, 27 Apr 2025 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745811835; x=1746416635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM04meY/cNVobywryZ3QNUIjX4LroMojaucg0JZUKCM=;
        b=Uw1SOGIPb/8iK8JySEu+UWug6kQyLKugjyDtfzvtcRuHa13XI0iOGbCNRwRb/Jz4+x
         V18+DZ84XWr95soJMRREdQq2/QGZJ1SRoPCkrRNR6HD9TNaTIqtDri6d1O1kLcS6ID/l
         i/K7Zdp7UofvmUFkc+ctF0eKOA6W/djRXMbsF+BBFFQHVbDDCBOn8vn7V3GMDmbCldDi
         AGe3e7jCJKXlRvJ88PGcUs2JOI6+gsKZ1lFYmUWN+kJZzPSYc05Hdxr515Efb68tC/go
         kC/u9SNWA85F1UvKeoixQdrtqqBz74fWt7s4yNtF1cs9NOfQ/uaZ7cExy6aUOqyt/ihs
         cYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745811835; x=1746416635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM04meY/cNVobywryZ3QNUIjX4LroMojaucg0JZUKCM=;
        b=xOnUTE9PZ+0M1rpPft4315acBHnXTNn8uEJyy5Gj4SR79EkTF5tcTDgJmPJTvelsuR
         VM18bU30gflzEVSY4Vb4n1m+0YbJJRNwGtS5vKBFogjZYzhdYvfyM9PWWwOkq5WjHPml
         QsTEAr0rHaJ9A73uVCdWHgPa0q6JZnIFVEl6Wzxj+OlAE2byMxJsW1paB+qHIGJMI3aQ
         xwgZsZ372caItTvxJj4uTgjo06bT0Wlvp3bHy+UEm9T+Dfd2z8048BRHTMVHQ1oqrM/X
         z+j6yajPOcfpfE76i33IRUGkckoUcqxAMTvnyXKDcZLWbWnnhT5uThMuiz4bYskSIXoq
         DGmw==
X-Forwarded-Encrypted: i=1; AJvYcCV+R/JRttcDf2D61Y42FmLzii8FWDryQIxz1CzaqgIfw41YhFTPw/YGx2aNdg+V3W74V5u5Vu5M@vger.kernel.org, AJvYcCWVtsjdDk/rgb6vgRhMAWQ8aZ/qWH27ae3L7cmfYJbMgZFwlHOeZVIjvXeZ/XC8DNQrypyTnDAYOO2SDj+u@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKFvQBonMCmbcIO5CWPIiIGu5eMHksUqSrKzE9kTw0WK/Xcow
	cHwgjGFxpKFDVXxa1TlV6N7pJNNMNMklVVpQ5raIGDkbLSgqucLU72OvQSxbVMhScDpzShSCdDF
	8DpvfOsUHjRxiSqPYaxMGmQwcusQ=
X-Gm-Gg: ASbGnct95snb6LkXXDtXYLURDUl8sFGsqzPDv9taHHqdlC4jzlBs5REVxln7vPUvqwC
	3OFFfqwfIJmdFtxZK73mYIq1Ap55YNstyHeh5EtGod72Uext6l1Tv3yRKSgRlvtUsOdwf9RAdMc
	v9EPkYubu+1FUfmDPYvJvS69hEMr9iPuE+
X-Google-Smtp-Source: AGHT+IEH70hVVW8rOsOgQxJZC6NCsSrX4mNRBQgHnfMcJhGj2rh1j/QWmLKtV8gyZHlAIJARxIxzR5Q7v1nitZy2bb4=
X-Received: by 2002:a2e:a802:0:b0:30b:ee78:79d2 with SMTP id
 38308e7fff4ca-319088ac327mr36378271fa.36.1745811835253; Sun, 27 Apr 2025
 20:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev> <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
 <aAF2eUG26_xDYIDU@google.com>
In-Reply-To: <aAF2eUG26_xDYIDU@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 28 Apr 2025 11:43:38 +0800
X-Gm-Features: ATxdqUH374CfcqPtJrjSLJjOFu2q-YT7JNnIJJVXMirRn2dBGdwtM4zrlTltdZI
Message-ID: <CAMgjq7BNUMFzsFCOt--mvTqSmgdA65PWcn57G_6-gEj0ps-jCg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, 
	mhocko@kernel.org, shakeel.butt@linux.dev, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:45=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
> >
> > We currently have some workloads running with `nokmem` due to objcg
> > performance issues. I know there are efforts to improve them, but so
> > far it's still not painless to have. So I'm a bit worried about
> > this...
>
> Do you mind sharing more details here?
>
> Thanks!

Hi,

Sorry for the late response, I was busy with another series and other works=
.

It's not hard to observe such slow down, for example a simple redis
test can expose it:

Without nokmem:
redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
SET: 16393.44 requests per second, p50=3D0.055 msec
GET: 16956.34 requests per second, p50=3D0.055 msec

With nokmem:
redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
SET: 17263.70 requests per second, p50=3D0.055 msec
GET: 17410.23 requests per second, p50=3D0.055 msec

And I'm testing with latest kernel:
uname -a
Linux localhost 6.15.0-rc2+ #1594 SMP PREEMPT_DYNAMIC Sun Apr 27
15:13:27 CST 2025 x86_64 GNU/Linux

This is just an example. For redis, it can be a workaround by using
things like redis pipeline, but not all workloads can be adjusted
that flexibly.

And the slowdown could be amplified in some cases.


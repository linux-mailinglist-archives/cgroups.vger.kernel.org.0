Return-Path: <cgroups+bounces-3787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A389372AB
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 05:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A40B2825CE
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A798F45;
	Fri, 19 Jul 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPK4omv9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A07C8C7
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358734; cv=none; b=mhJjr4T+u6tQ/R7lD1E6OLaLtGhkqIccgKX9AI8RUSv+llY3OdLF+pU9yIeSqef0s1rt06sFySv/uraZ/BQ1C7jxLs6L4Xaw2hUYhjUzlJNzrfH0/VdBylUTngH+SeHEhi/tOeuq8w8UUhMBSmzTS6PcTX24VcCUpX+smB7hZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358734; c=relaxed/simple;
	bh=OtxVFTr4gXr100XAGy8UzNeghE+SSoRlyYJ3oX/BbxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3mh3M+7VQ8ooaZXrv8XZwleYIm+V99oQUMtAfK8ocZLgOEzHMqGu1Borvf+fTjIyvdSFC5+guumLBSZhAHd5yh75McmlfX6NCdmLCz5dewOncCtkAzzxI+7quyH6YrzM2oIhvLuLvrgx/TwXo5ihgCI/8WBbGC0BN+V4l2xrio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPK4omv9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so146778266b.3
        for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721358731; x=1721963531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWrlWFsEEKaXoZhx0GTyR+UbVi2aC5Ulw5/+3CDCuiw=;
        b=CPK4omv99XtXOJr2jFXeVOi8aJGGy/zNmwWRXkSXtqopr9t17M6mwoYbOZZT1nM+W9
         we2HuUUqhSN8pK+JgIySDR474RDBlOh8TcDHLZ6XBwydswpbSYFcp0ukHmg1LfjVzZTE
         dMpzWt7KKgH/fPLxu5zIqaGYYkHebT9v4Mx3xYHv1vfHYVR2akjZQsYeXh9z3zjbkiZc
         zWdU92yjU/NQv48+lk8v1tdLwv2ZiowseX6IHZR+MiJnHwttV6OgcRp2zTK6YOU0D9Cw
         HM4z+38zLRNZQU0q2elHwgf6diSM7iGKAlWyyPMuqjRwHC/fYw1UnTAld+P2768tNYj0
         r7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721358731; x=1721963531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWrlWFsEEKaXoZhx0GTyR+UbVi2aC5Ulw5/+3CDCuiw=;
        b=ERGzku2sgFMNjl2FoPW+Dj9p1sH8KlgOOftUUD+FtTF6D8kOKHMxl4BOCKJ7FavA1r
         g3OEDUwxGb8aKSj+OndUNCds/K9gXvHkK8cgqgzLFVTR7cFhAG+Vih7WX3/NIG/9ZHyl
         eGuJjeTL6dzUUsfhsSOifpTDyEAMS3aAsKPfwees32deuYSixzyrT1E+MX7/E1QmCqiK
         ZkL4nKsoLeIaSUMPvhvRFoV9OMMMUAv4Poq+YG5RJvmVeIZ8U75CVzWxww0j5Dc/RabK
         Ww/rw8fR73Jct3Tgl0Nkwn238x/zo8DPFPRjWWkrahXwUrENi54MwqK2I2oKG8Egr+hT
         rKBA==
X-Forwarded-Encrypted: i=1; AJvYcCUg0xXof07Sbnl3TeFRp3Te8IF5acBJg0wL/YlDI0gCVdNCEqXvjR9phT+kzjwxB31gra9Bnmgoh1X1Lq4RCZSWVYayWDr8Sw==
X-Gm-Message-State: AOJu0YwMoJuBN+8F0P5yTsVJY/3UJmLZ48fYRFThJDZpxEcx0rqVck9T
	L7t39Q4rioOnCTMXw2+EgL5Vo+8dtJadLVkoGzF7EWv9TXfevh/xTYmUFVmN8gumyvSqeV2pAPM
	fVg89NGx+VA2OBBcXOmx1R6PhKxN59uAqfc2s
X-Google-Smtp-Source: AGHT+IFkZK7JtKXq3yk+FqsXb0FFcMjlEbMm01qd/yCdC4ALR8VoUvA++xZIWpXXc+YkUidBTWzX0vp3A2obLGcWs5I=
X-Received: by 2002:a17:906:487:b0:a79:fbf0:8106 with SMTP id
 a640c23a62f3a-a7a01139bc2mr457799066b.6.1721358729904; Thu, 18 Jul 2024
 20:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
In-Reply-To: <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jul 2024 20:11:32 -0700
Message-ID: <CAJD7tkZbOf7125mcuN-EQdn6MB=dEasHWpoLmY1p-KCjjRxGXQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:41=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Hi Jesper,
>
> On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
> >
> [...]
> >
> >
> > Looking at the production numbers for the time the lock is held for lev=
el 0:
> >
> > @locked_time_level[0]:
> > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
> >
>
> Is it possible to get the above histogram for other levels as well? I
> know this is 12 numa node machine, how many total CPUs are there?
>
> > The time is in nanosec, so M corresponds to ms (milliseconds).
> >
> > With 36 flushes per second (as shown earlier) this is a flush every
> > 27.7ms.  It is not unreasonable (from above data) that the flush time
> > also spend 27ms, which means that we spend a full CPU second flushing.
> > That is spending too much time flushing.
>
> One idea to further reduce this time is more fine grained flush
> skipping. At the moment we either skip the whole flush or not. How
> about we make this decision per-cpu? We already have per-cpu updates
> data and if it is less than MEMCG_CHARGE_BATCH, skip flush on that cpu.

Good idea.

I think we would need a per-subsystem callback to decide whether we
want to flush the cgroup or not. This needs to happen in the core
rstat flushing code (not the memcg flushing code), as we need to make
sure we do not remove the cgroup from the per-cpu updated tree if we
don't flush it.

More generally, I think we should be able to have a "force" flush API
that skips all optimizations and ensures that a flush occurs. I think
this will be needed in the cgroup_rstat_exit() path, where stats of a
cgroup being freed must be propagated to its parent, no matter how
insignificant they may be, to avoid inconsistencies.


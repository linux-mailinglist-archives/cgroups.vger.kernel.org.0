Return-Path: <cgroups+bounces-8338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E68AC2CCF
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 03:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA04540645
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17B1DE4DB;
	Sat, 24 May 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VX37isXK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFE2BB04
	for <cgroups@vger.kernel.org>; Sat, 24 May 2025 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049062; cv=none; b=CerLPiTqCv36pGRZLEOmy5JcVfko46yu/ASGNMJvJcWMOPfjJf893PQ7gkj3CTFjpMgGw3oDOOunDv2WpjK1MlL8wKWei3DZJf3C5Z6Yd/QoD5ID4KGtuAj4NRQuy7znnlkBhNvW0vxH5q47y+WVHSlewjbSoGM8OW2ZP86AZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049062; c=relaxed/simple;
	bh=wespwvF6kqzq5dgx3obPD++AP8ju/UbhX9PaIJjnAcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmKrD3nzdQn5EH5mAcQXrvib2QBcP2WVgK0VqnvTEccnMx/PBu+RC0EkGwvp4p/KzMzAMQPmDAsUQRzgW0JvI5WgO2ARH9qmOPKwiOxUGvmgGQvX3w2Eq0Z2WwaiqmCwXdlUFVURJFy0krM0M/3PHn7lglLqe7C6BKWUvLDFhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VX37isXK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-551f00720cfso588808e87.0
        for <cgroups@vger.kernel.org>; Fri, 23 May 2025 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748049059; x=1748653859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wespwvF6kqzq5dgx3obPD++AP8ju/UbhX9PaIJjnAcs=;
        b=VX37isXKWMApTKWVAzaPXPTA3zzcC+Xd4a/v44zhmlZMixG+Z0XSgdYihX/3Q3F7Pd
         2ZoWACZ2JWn1mppu9IhcbC4tPU+hYw4G0RX6X5SXs0jF+y/LwJvH0/yl1AbFz23PU7j0
         0SF37oxmqCwK4Px5Vhm0n5PZ6Kair/Zxs37qo0l09+rClHBPa2+TKe1bVI/8gwWyfsdp
         Fb9ygoxvzs+ZFe2byLmP7ndykbiYwPidKJhT/6BRvO5SyHNFytEqHyqVsd0LnDBjt+hS
         67+iOSEbc66mPB6HRyTMf1jHrpvouKPd+GmJuMyDsoGnZeNxKeN+UDw7+jUgQ/xLLTKv
         OWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049059; x=1748653859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wespwvF6kqzq5dgx3obPD++AP8ju/UbhX9PaIJjnAcs=;
        b=j+afEHMeqJq5ae5XaYwFVZhzTFSUZqVnVYTMmTrc7C3HQbFRDf9sjSvOUk2Vx+JhuP
         8uKjsojLkZ7rgfYefFA+4nwxXZUUxUvVZu7KB/SFJz5VsRkP39G6JhpjVrHrkMqarSXs
         mqnB2f5oz4bN/Tlf4knIgcg6KkcX+rOg0tzQZqnrpYGkBm0IzczmBNZtwG04PZIRNRgV
         Ogsr3ADOPAbzqEr+1PPUcXUHKQ50eEbXpwKXCWPI9KDWCNo4WCx/MLXs/KAfM0MyMFCM
         lRrX3d2pJjP394RUd20i0uBhAtCh4vScnHCcYv5d0XvtPIp64Eb0TvjSgTD79CC/lOJ1
         mDXw==
X-Forwarded-Encrypted: i=1; AJvYcCVrJOti3en/3SCh19oS61f+rKv96nsyQiApS5MQvjTd3Mx76lAlconbyX3hoIL9kZ1hDzQHdnlY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/ThwTMLfRHlsPyZsrIV6qiinJPfmYKoLWby5ogFfWCP8O/Jz
	IXj3is/1XQtihCMUOv0AAzXH8XvqruaRVA4rF91gubvPhpl0xTq2Rvy0+6E8bK1N103/jPLIHQz
	ySHJu7lBQUPGQIR3YO1Zs7WNeN59fstpMtL1LzqCYw9hXYiXRB+N4kt8=
X-Gm-Gg: ASbGncsVQcBX4mmESqM2Aatmv14Tqss5EPfCNiskGxNcyR9hVBaOu4/Q7BlcirUu9F8
	0OHbekbtQWwL+0f10no1E7AgXrxiziELUrkL5HNZhWlNZ17VmbGqwnoneA16QVU5V8r4r5vBUcf
	BPysgh87nBQA6xLVJgtG/uVRB6yNLZkziI7QE=
X-Google-Smtp-Source: AGHT+IH5kNKjU5mY0iqNrnFhhvRdZxyDeoZSH7FdpYSyRUJRwx65Aa9wswzpoQgpipYAIMWDpukycaM4+rxyvstCBqM=
X-Received: by 2002:a05:6512:3c8e:b0:552:1c1b:556 with SMTP id
 2adb3069b0e04-5521c7ae35emr424381e87.24.1748049058648; Fri, 23 May 2025
 18:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com> <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org> <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org> <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
In-Reply-To: <aDCnnd46qjAvoxZq@slm.duckdns.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Sat, 24 May 2025 09:10:21 +0800
X-Gm-Features: AX0GCFtSWHIc8ezRHjr9cZ4HLh0KjLJb_vy2wgYKIE3iBWgQLXGLTBxq8dVy6uM
Message-ID: <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 12:51=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, May 23, 2025 at 11:35:57PM +0800, Zhongkun He wrote:
> > > Is this something you want on the whole machine? If so, would global =
cgroup
> > > mount option work?
> >
> > It doesn't apply to the whole machine. It is only relevant to the pod w=
ith
> > huge pages, where the service will be unavailable for over ten seconds =
if
> > modify the cpuset.mems. Therefore, it would be ideal if there were an
> > option to disable the migration for this special case.
>
> I suppose we can add back an interface similar to cgroup1 but can you det=
ail
> the use case a bit? If you relocate threads without relocating memory, yo=
u'd

Thanks, that sounds great.

> be paying on-going cost for memory access. It'd be great if you can
> elaborate why such mode of operation is desirable.
>
> Thanks.

This is a story about optimizing CPU and memory bandwidth utilization.
In our production environment, the application exhibits distinct peak
and off-peak cycles and the cpuset.mems interface is modified
several times within a day.

During off-peak periods, tasks are evenly distributed across all NUMA nodes=
.
When peak periods arrive, we collectively migrate tasks to a designated nod=
e,
freeing up another node to accommodate new resource-intensive tasks.

We move the task by modifying the cpuset.cpus and cpuset.mems and
the memory migration is an option with cpuset.memory_migrate
interface in V1. After we relocate the threads, the memory will be
migrated by syscall move_pages in userspace slowly, within a few
minutes.

Presently, cpuset.mems triggers synchronous memory migration,
leading to prolonged and unacceptable service downtime in V2.

So we hope to add back an interface similar to cgroup v1, optional
the migration.

Thanks.

>
> --
> tejun


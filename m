Return-Path: <cgroups+bounces-8577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF4ADE143
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 04:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446373A02EE
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8518C932;
	Wed, 18 Jun 2025 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="coluYFFr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD79C2EF
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214802; cv=none; b=tSbunKjsAlFk1074GhN+DpMqPUqZkIdtLbxVH6eExGXuiG42eBEnUiXXSIpyM24t5nEPOvZrslS3oqoAbk5Ock3Xa2oSAeieee0dVHR/dJZT29XSDEipgS3/DR1+q42dkgiApCX9qPWfGPr+84B9m3py0WYpG9DB6VycgIyPt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214802; c=relaxed/simple;
	bh=Ivgj77nxv4ja5sleaTi8wLMvw3SpGA7NV9iJe2hO6Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVCRnp4ob9TzHc+PBSpT2KLm6u+pubH7LaxjrsdQluVdroBs1dS7oHYzZJIPKLkYjM0YxNyMeflKlmRi23rwJsxdizNWAjDl1mXxQNKDU74gq9epxUGXpaH4mDU8w77jmYuUwgX9vQ1bceBayQH38YY/zPk5UWDNrpX+cSKdQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=coluYFFr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so302011e87.1
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750214798; x=1750819598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlbTTxogMVAgz2GX3ZB4Ou7NdaW05i4PGwqMN7tDkTM=;
        b=coluYFFrn+SYPCEYn/sU3g3vXfpvF0hEKaRYCdiPwN1w979jHpNorq226uW97jI/UP
         6Nag/Lb8mTVZuDkX6WXmzGaXNrrYGZE+N388AStxQ6NC2IQHUknPe3rZvo0Q1P3gNxd+
         pWAHdiezsX+3/CogftYgKrBPmWTttx6RooDCQabiqruyESCtpOv4VSE0x6ERq9okxRRM
         AYgy5D7Xd1kIwFydMXormKBy/jFbRcx0TfC64lVedYEhn2nWGCOyupdkQT3ulUMhf1CZ
         DOnAeKxQ3j1CQUkVbBR/T8UVQjx7/cLRzFf2Jsh6aP+Lp7N/S3cCOqmTNotqZhu2lk/9
         Q+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214798; x=1750819598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlbTTxogMVAgz2GX3ZB4Ou7NdaW05i4PGwqMN7tDkTM=;
        b=Po3EJomca2hIoWwu+LT6Stxam0qDLad1ct2g7tkzVN+JUoyL/2j5gdIhIvVX5j1oF8
         Fv4v6jRPbxrf2w6IEW/+2L8DA+H+i5hBvU4EJdsngZEdCjrc33A4NPtjbBMfIMs3Ob6c
         BllRa5AosQwmyCk3q0aLQyeuKRo3gZST8/1ZNKtVLObG0WncIr8WSyk+jGV/m9/ijVog
         FFyyeF5YwZgMJjLJwGaaWFChSswt/0fjCsNdgUkCd4RqWcR0/MF44MJprlEsftBX7yxA
         DzR0AEQ+B2f7ZgOg1QDJCqoSdSMOZZ6B43jBs1l35+wtessp8STSjrG56zpFHTF8+uyz
         rBiA==
X-Forwarded-Encrypted: i=1; AJvYcCVrBVD+u1z7ABdSEI+nZiqtqCX3iLeabPuDcHBzoyCnecNUxLnx1eHoldL4znxyHV52HO8OiQO3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuv+c65ZjF5ZL6l7FhtnEcVKggtMiK84fIEN8plMK6CejGpfws
	uWJsaeqE79lcIYoupDGCJ0Ptx7e0w+BxLmYkqwxPczRR8ECKJmMW3T1yD8ATS+hL0SvaYuKCO1s
	8iXnq6vT24AHACXFJWAShhgkkBl7qRXcs0S9vwj3J+Q==
X-Gm-Gg: ASbGncsJl9Sg0MJhemG3wr1n+R0i3fbVQYtxblq2mdMz1oUVav7/PWm15NO0npj7a1c
	4ssn29iZskEa+TjQ1okIVhSfyL4h9jkrSgMs8SlluuHDjSR9TX2wfCfGy8TW+it/7nGSaBCgHGL
	90TYf56qkmKxeosI/rnSWxC01mEJ1WxupoyxR+Y4tTlz2W4dclM+yyliv2pQ==
X-Google-Smtp-Source: AGHT+IFH+5k5d2KikhCUeU/mTDD7JvT76U8P2i4cmHYhj2Fs6UrmiJa8GoakOVf80UhgStV3cmiCzUTtE4lAAObj5Bs=
X-Received: by 2002:a05:6512:3c89:b0:553:51a2:440a with SMTP id
 2adb3069b0e04-553d394f5fbmr241527e87.23.1750214798425; Tue, 17 Jun 2025
 19:46:38 -0700 (PDT)
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
 <aDCnnd46qjAvoxZq@slm.duckdns.org> <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
In-Reply-To: <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 18 Jun 2025 10:46:02 +0800
X-Gm-Features: Ac12FXyS_6UzG10qm6bDVnhkATOHiq0B69-3NOlo_uABbEm1VxUNBONp9sE05dI
Message-ID: <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 8:40=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Sat, May 24, 2025 at 09:10:21AM +0800, Zhongkun He <hezhongkun.hzk@byt=
edance.com> wrote:
> > This is a story about optimizing CPU and memory bandwidth utilization.
> > In our production environment, the application exhibits distinct peak
> > and off-peak cycles and the cpuset.mems interface is modified
> > several times within a day.
> >
> > During off-peak periods, tasks are evenly distributed across all NUMA n=
odes.
> > When peak periods arrive, we collectively migrate tasks to a designated=
 node,
> > freeing up another node to accommodate new resource-intensive tasks.
> >
> > We move the task by modifying the cpuset.cpus and cpuset.mems and
> > the memory migration is an option with cpuset.memory_migrate
> > interface in V1. After we relocate the threads, the memory will be
> > migrated by syscall move_pages in userspace slowly, within a few
> > minutes.
>
> Why do you need cpuset.mems at all?
> IIUC, you could configure cpuset.mems to a union of possible nodes for
> the pod and then you leave up the adjustments of affinity upon the
> userspace.

It is unnecessary to adjust memory affinity periodically from userspace,
as it is a costly operation. Instead, we need to shrink cpuset.mems to
explicitly specify the NUMA node from which newly allocated pages should
come, and migrate the pages once in userspace slowly  or adjusted
by numa balance.

Thanks,
Zhongkun
>
> Thanks,
> Michal


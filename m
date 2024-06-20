Return-Path: <cgroups+bounces-3249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B8910597
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455C2289D7E
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530B1ACE7C;
	Thu, 20 Jun 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRBgRsdE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AA1AAE34
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889267; cv=none; b=QavDT761WSsJUY0tiqwHB1LVWgi2Ek3UetVm8SKWjkwFJivA70tallNivUQFQOkcPfeQ6F0pzb6sDGTUubwUmqk5N/9cvSdo0RBSjFOXBI8+DmbCgkJxRs+nlCN8M0kaFV3t0FIR+P5+xCyxT/JGm9Z8TDHzBLS4n4F4R7J/Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889267; c=relaxed/simple;
	bh=Y+MEEyx41IcOVMqXoXDJWkJ9+FrOPr++BZN75feuo1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYCPlr42WaXXc+GYuxMmiTMzChirOTcCHAI0h8iG5qlVFjM7bb5fAIYzF5p+RnGTr/t61c18qdJTh1JybGPBbYNG7WmTJFLqwakVRjgmMKaOnCuwQvFyAdf09OF4VILwzQkydz0x7DakMsV5SODxRXPvilKDlwl3SrN4rD3XcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRBgRsdE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4415e623653so14751041cf.1
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718889263; x=1719494063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
        b=pRBgRsdEoVVhHSevcztTbX0ZQbs6ODQpR+ZDGlx4bS6LsN51+wh+5jJxEHZF17AIwC
         EwntDMgI4oMOZwvavysBQ7dfYv0cLsEJ9vn7N/rTVCkNChPK/p9eVDXJzl59HxwlScSw
         3Pl4pZssaPdHXObOHR8ieYxQdfgh8/2J1W+Gt15p43V9HSVS4bdg1x8q5c8kYQGUdOs0
         VaRQxPvn0CqE7+PZb3Fc/5ucnT15ftHjDZu06LEl3wV2dm1C0Ap5kEXtL7vbnXEU1Gp3
         DytIeT6pMw1uiXwEmJuXLXFvN8LaRy5NsJwPjr7mlvB6EHiioWO4iv0kGnlL0YpZhGKw
         gDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889263; x=1719494063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
        b=CdlwzyMTZNozuLyMwTNXJNJauEe5Jmw/TqhhGvXOqoANlgLc6RBqvb1KtkLQAZ+yNv
         0cJu7BDdef3pZl87ShBWu8wduWUNTuUjwGp1aVZWAZcT+C8gssCKVCM2LxJwAt5CakMd
         0FlM657EDQ9NN2EkaaW5AtTKXUzMdd8tL8kCc6dMQbnRwWWrAXM79FDwcLCA21P6AR6A
         JedY0cEGNoKZlUU9axwtqzZjUUtByp2iCq1eOJ1GjCBQxLhErV9R7s+c12W4XSvF23rJ
         UvhugwFFv1TkE0P6/ahO6Y7Nb8C0FJH7By9LiQc4y5Ko9QyRzhtTU/+XKnzod6tJzmoI
         nuYA==
X-Forwarded-Encrypted: i=1; AJvYcCVC9ohHx5PNAQgtk228DeYD3AlA9EkBOwfZUlYK/NtcCNHRge7qdqnKIL4juotZuYOq8RvNbF/1Dj8qAdHROl/lqKjNBdeEBw==
X-Gm-Message-State: AOJu0YwRi7PBBnDDJ9JkwTABZdUM0P1j1XWrfxLNxyYwVELP4+K17daj
	JRuSKFW6pwL5oX7nt67HlYTBbDtGh8pX2Win8ZnUaZpOZ8rSrAfEOolfkWYIJqJLOzYy0NWiXdP
	3YKFxeVf6elcZ3jzIo3L+bdoVWD+eA92wwTP8bQ==
X-Google-Smtp-Source: AGHT+IGiHKV+q2qJu/mkMnrbWS6TykUfrsN8Y6wuNtachV8KZU4pBm3Bkt8z8L8YuUKSny6A751rJg0UHn+YKbmJrf0=
X-Received: by 2002:a05:622a:1813:b0:43f:f5e0:8e86 with SMTP id
 d75a77b69052e-4449b90ec32mr145142351cf.10.1718889263444; Thu, 20 Jun 2024
 06:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org> <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
In-Reply-To: <2024062028-caloric-cost-2ab9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 18:44:11 +0530
Message-ID: <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Hildenbrand <david@redhat.com>, 
	Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> > On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.9.6 release.
> > > There are 281 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > 1)
> > The LTP controllers cgroup_fj_stress test cases causing kernel crash
> > on arm64 Juno-r2 with
> > compat mode testing with stable-rc 6.9 kernel.
> >
> > In the recent past I have reported this issues on Linux mainline.
> >
> > LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >   - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >
> > it goes like this,
> >   Unable to handle kernel NULL pointer dereference at virtual address
> >   ...
> >   Insufficient stack space to handle exception!
> >   end Kernel panic - not syncing: kernel stack overflow
> >
> > 2)
> > The LTP controllers cgroup_fj_stress test suite causing kernel oops on
> > arm64 Juno-r2 (with the clang-night build toolchain).
> >   Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000009
> >   Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> >   pc : xprt_alloc_slot+0x54/0x1c8
> >   lr : xprt_alloc_slot+0x30/0x1c8
>
> And these are regressions?  Any chance to run 'git bisect'?

it's difficult to reproduce the first one so we haven't been able to bisect it.
It seemd like David and Baolin might have an idea what's causing it.

- Naresh


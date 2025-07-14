Return-Path: <cgroups+bounces-8720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E60B0351B
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 06:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257EB1893985
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 04:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C231E5B9E;
	Mon, 14 Jul 2025 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtFf+6td"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C332BE4A
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752466218; cv=none; b=io//2fjbn7Zm7q2/snWazmmkPjULX/SCzZKb0AGcVuGC2BqJ7pYWsDkeAi9EyaaChidkkgLX6W8LDxiYVp9JWfDfLQk+6di5VQDwEYp9Gq/LivYAc0IdEs4TomM+gsduwIY+PGm6ekZ5gnI6p9YfqxaU5GrXkpv0Fvh8PFSMDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752466218; c=relaxed/simple;
	bh=0RBGOGib+8FNEsJeuRkiZyrnbpxS9v6t22bM1KqRB/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny8JuMYo+LuS+yEuXnO0uPE/0Zwa6b3qkQJbWP+rYXyMuW63Zn/q+40JnoBF/r0qQtsmS5Gbanfz/Ydpt9dL/L9XJV7Fh3zSwyKZ3jNNJd2IDi7UBeVDUeFn8A7dm2HQePhAi/a1K+G1s+JWftndJ9SXaLi60RvJjZ2Sw7DRhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtFf+6td; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32f1763673cso48303461fa.3
        for <cgroups@vger.kernel.org>; Sun, 13 Jul 2025 21:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752466214; x=1753071014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/gVmDUU9ZTwh8NsXEvXK1uXZhLAi6w8GFZDgksmXrM=;
        b=PtFf+6tdX6sGxtcR3TsQBFSD4bsrkojuMT7F89jNL4vYhEh5C7dDANjsJA6/v8xcPy
         QmuDARDJaCZgoc9zQXC7WpwoV0tHk3kYo/hnSTSvmolZ5WpgrNrmMACH08cjCIUUhd8h
         jM8Yxjk8FgcP8qt910V09MiNxFxp6ZDAlVWmYYgmWahaOGY/pJTYePCDWI5ifm2aqXWv
         LrqYdUCxqccttpsb/Fdq8T/c/znZSE8XXCzs1OSXMLkmGzw3V+BKsuqMDrC8jj7xUSxM
         qXAdMvwPMm/jOdzrMKd46OD5jhtKZImeaQSdJER6eDA9zfdFlfaGb4QKqOxFsZduf006
         FBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752466214; x=1753071014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/gVmDUU9ZTwh8NsXEvXK1uXZhLAi6w8GFZDgksmXrM=;
        b=Kxwe7PxKczEXDohGa23tSRyaxrjQQSMq9gf2jTxVVXJ+Q2G3p0fm97K1wuUG87cBA2
         qH4lSj5IT2eqg/xn01ZJUltvEd3UhjLjfP3J4nrOgBVOe2YMPuVUScB9zP2XR/LOEoNd
         hVi6dybckUfxoB89WOvIPbPd6UahSmiJY510p46FmLZ4AiojKCYLakgWE+Fr5mQ4/m4D
         ErB9QmpZ9Ac0wFow4a3yRZml2e7Fb1EeZxoIRbvRCw3WsCxnenE/k6A0hZ1rtxiANQXk
         iS+Zp7ERKgt9mZysbCUcT7rpDpu3aSlQ+T9Um+vm2RSI8ss1GJtXUqJ22Ipdnou3N3TE
         n+zA==
X-Gm-Message-State: AOJu0Yy0JjzqqTAe8XQABX3FrnkNyptnuW31R3TRNALALhLBAf+7/QZJ
	NnFVZN4kpvPYT1n59TIl9jgFtkfe74y9/mXRk6RmxK6CO6I077AUwZijf0MZYNugi0uVyR5P+JB
	CGFiZ+eLC0Qg88oeyqAhAIoQMsAuak2RuVJVCzaM=
X-Gm-Gg: ASbGnct9GN7fMRR+WI5fNLYiy4PvDOzEfxyhWcmmLBk6P7zFoe3DJN391hW1t2C3Gyy
	N7Hwq6u42vRk0ZzvrCGvatXvK5btz7LaTUL8Obis1fAgx3Ci/BkQgYaoMm3HKq05jWvLUEUjSfF
	KrP5NTCjN3VyL1WJT4Db/s64vxVHCVHOGh08jEHNp6NwugnaMqqYE2TrHfwduqjmmIS3Q/cbTB/
	a+7vlw=
X-Google-Smtp-Source: AGHT+IEjj7LkU+/zXA9RFUzEoyYMOc/60OqyUxPXTRejH2xLF17q1g3MGEGtMI47/U6B7sRgfzDZEfQTjO+vQJs+7lM=
X-Received: by 2002:a05:651c:3052:b0:32a:6eea:5c35 with SMTP id
 38308e7fff4ca-330532dbfe5mr25554741fa.15.1752466214167; Sun, 13 Jul 2025
 21:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+prNOqAG31+AfgmchEMbeA=JpegKM946MZPm4TG0hEXDDRUag@mail.gmail.com>
 <b9a3d8da-9fd8-4ffe-b01e-4b3ecef5e7a6@huaweicloud.com>
In-Reply-To: <b9a3d8da-9fd8-4ffe-b01e-4b3ecef5e7a6@huaweicloud.com>
From: Xuancong Wang <xuancong84@gmail.com>
Date: Mon, 14 Jul 2025 12:10:03 +0800
X-Gm-Features: Ac12FXyyql_br33bBhih0vSvhZ4cPITGpOo7kTZIBWGlCzsOj-wJk6MxvXZQFXg
Message-ID: <CA+prNOqPXJUHV4fM9NR991=zySXhLhbYFjCSDevq7Yz4opjf0A@mail.gmail.com>
Subject: Re: kernel defect causing "freezing user space tasks failed after 20
 seconds" upon deep sleep
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Ridong for your reply!

Linux wxc-moht-aero 6.8.0-60-generic #63~22.04.1-Ubuntu SMP
PREEMPT_DYNAMIC Tue Apr 22 19:00:15 UTC 2 x86_64 x86_64 x86_64
GNU/Linux
~$ lsb_release -a
No LSB modules are available.
Distributor ID:    Ubuntu
Description:    Ubuntu 22.04.5 LTS
Release:    22.04
Codename:    jammy

On Mon, Jul 14, 2025 at 11:53=E2=80=AFAM Chen Ridong <chenridong@huaweiclou=
d.com> wrote:
>
>
>
> On 2025/7/12 12:51, Xuancong Wang wrote:
> > Dear Linux kernel developers,
> >
> > I am referred from
> > https://github.com/systemd/systemd/issues/37590#issuecomment-3064439900
> > to report the bug here.
> >
> > In all recent versions of Ubuntu (mine is Ubuntu 22.04 LTS), deep
> > sleep will typically cause the error "freezing user space tasks failed
> > after 20 seconds" and then the desktop will hang. To 100% reproduce
> > the bug:
> > - lid-close operation set to suspend/sleep
> > - sleep type set to deep sleep `echo deep > /sys/power/mem_sleep`
> > - SSHFS mount a reasonable-size Python project folder with a
> > anaconda3/miniconda3 folder inside it
> > - install VS code (version >=3D99) with Python parsing plugins
> > - use VS code to open the Python project, set interpreter to that
> > anaconda3/miniconda3 located on the SSHFS folder
> > - while VS code is parsing the project (spinning gear in status bar),
> > close the lid or run pm-suspend
> >
> > You will see that the laptop does not go to sleep (sleep indicator LED
> > does not light up), after 20 seconds, open the lid, the desktop hangs
> > with the error message, "freezing user space tasks failed after 20
> > seconds".
> >
> > Only reboot or `systemctl restart gdm` can recover the desktop, all
> > unsaved data are lost.
> >
> > Cheers,
> > Xuancong
>
> Hi, Xuancong,
>
> What's your kernel version? Are you using cgroup v1?
>
> There are two issues I know about legacy freezer. Wish this can be helpfu=
l.
>
> https://lore.kernel.org/lkml/20250703133427.3301899-1-chenridong@huaweicl=
oud.com/
> https://lore.kernel.org/lkml/20250618073217.2983275-1-chenridong@huaweicl=
oud.com/
>
> Best regards,
> Ridong
>


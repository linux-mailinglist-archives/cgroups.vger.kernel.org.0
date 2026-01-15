Return-Path: <cgroups+bounces-13259-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49622D27C48
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7A43019965
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FC3C1FD8;
	Thu, 15 Jan 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNI8ZNMc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833323C1984
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502778; cv=none; b=EPef6FuXq3++t2+z3VqYHRlfyUvGovKgq/AHzFcrbzSrcQ6fLkcVH6nm67vEPmR3nFabroZdRBlTTM1TdIPYGe3w7R5PGJt1To037bspQYuwTsRdEz1HxlkP33AsNgJEY3NCx5Ni5bASH02PTG3Cowi1yYDhNyN1WTc2XoZEjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502778; c=relaxed/simple;
	bh=yoL58zai68CZSyJdiYhMj7CCFJXXuq+Jj3HM8quNLlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiWxmczdk1NuUnInlPsIpts6vLGJ70r3m0fHW31+svmBYMsBJdK3ECXB8vpxDsYV0L9LZ6i5H/jt0WmOV0cXa6S93Wt6+NNwPOwT6EpkK5TfJOn9ghJ9iy8NWRat4M7r/vRxh7y2qhLAb1UYDcE6OMh/z8bugPnGJFGu/Dt9u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNI8ZNMc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so7742485e9.0
        for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 10:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502769; x=1769107569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfZUcI2wWecmILQbjLZTDNlnWfzX7KEX8mqfKcqDtxY=;
        b=HNI8ZNMcHLai94uyRYeK2MYeWXpl46PRBviSx/deIYDOl+C0ddtH7+O+cCGsFgelNA
         hR0EzYHvtUW1gkNtu6DZd5IWe9C+zx2gXiHjgTuUgrbbjN4NOlreda2OAEVDyRj/7h4a
         Rf6OWg2SAnwKK62i/0Z5STdRWisvu12NHJVxk+YKXoJQajbW/RqdsomLRzNOMyHJIbQC
         BK6Cwfb+1RDeIMyYOxtFODqn1x2DrHXWvYBsaoBdLbbq+Y834ckCWlwH1zM5rsIvIWft
         yB9EKy3PZrQJW/WbrgDwWg27N/+CH0TZ3OZbPwnyOmtIwHGyIRDc81DDP+wu7VEvRaBF
         uG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502769; x=1769107569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfZUcI2wWecmILQbjLZTDNlnWfzX7KEX8mqfKcqDtxY=;
        b=pOMvWVHXcYGn9TaGWut/923M4A7nS+XQq+Rtm0YxznOBovwlhkQ4eBSFzxeFDUGKxZ
         K086jCVEkXLASoKbTW5JXAHeC3Ex/rSN3+nJTS7yKrX9CuV1KZtfM+Z4eJW9DwKnXrhN
         4wPqZ/sUxJtjGoMhM305C9gfQ91ipFX+2hZCyrnBZYLRxFfqErdB2GkG1p+w5ceIFmK3
         MBnrjWAaPcXzz1qBvjs3coX43E2XTIaNgz6qLuCgNSSTO0K+CXfWAKq1c/9s1kVeNwB2
         J0p9zPgUYUcdHTyvQHkY8Eo16LrFWkxTXFYbNiiieYFMDo4EKAH/jWmMJ1eKJ0d9VA98
         EBow==
X-Forwarded-Encrypted: i=1; AJvYcCVDYOciE5E1V21+16Efja+2WLT+X6xb7FBfjbh5EsZbef5psFLv7Pz3jmjo/KEvZiuzG0f7h5Lj@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqSNREqU2zrRz2noKviT4vlVXY7Wd4CRnUB8oXC9o63IqEZIt
	/gvpaFHR6egcCxsHBl6oYHPTHEI78BT3+vXuCr6XcxZjMg/yTM5RqlGMPranmmTZMRLxJ/IsroL
	nx9+Stg5+8sknrVydGvX1jDysAWDZsl0=
X-Gm-Gg: AY/fxX4wN9C/e0rxUMaZe4/vWgqaDrxOsRCoPwoIhSS2y15aSGAO43PKks6h8g3HDzP
	Ri+ZVRC+o6lUHpBlkZ/PaWJjx9LG9qW7XxYnVE8Lzoh8MP5PYJ1oNm9yq7fGteGYoCnPgZS014B
	5iZ4xl9CGGanGIli0v4yCOyifQbcDW4jfkRC2Zb8eD2BP/fgAUQJ0x0dzTDDlqQieOpKLQ4sun1
	ndv3fCkcG1IQ6IJvYe51eKKG3WNtdsPkQkQcQjYGthHQeb1utaJQKI5e8QraGg++P5qgMnPJnnt
	mK7ntyYysg2vPFBkJsXfrw==
X-Received: by 2002:a05:600c:35c6:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4801e2fdf57mr9930315e9.10.1768502768980; Thu, 15 Jan 2026
 10:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-fix-bpf_rstat_flush-v1-1-b068c230fdff@gmail.com>
In-Reply-To: <20260116-fix-bpf_rstat_flush-v1-1-b068c230fdff@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Jan 2026 10:45:58 -0800
X-Gm-Features: AZwV_QhSINgSoi3rz_nFYdVY7KfAkFH5D1xcTL8ipub-P1YjOCBQnnV6czHFcYE
Message-ID: <CAADnVQ+B7_oUcZDx2cs4sohAXNLy1qopkfsJsE-X158rfj2vhg@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: fix missing prototype warning for bpf_rstat_flush()
To: Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:34=E2=80=AFAM Ryota Sakamoto <sakamo.ryota@gmail=
.com> wrote:
>
> Add the prototype to cgroup-internal.h to resolve the Sparse warning.
>
> The function bpf_rstat_flush() is defined as __weak and global in
> kernel/cgroup/rstat.c, but lack of prototype in header file causes warnin=
g
> with Sparse (C=3D1):
>
>   kernel/cgroup/rstat.c:342:22: warning: symbol 'bpf_rstat_flush' was not=
 declared. Should it be static?

No. Ignore the warning. Sparse is incorrect.
We have hundreds of such bogus warnings. Do NOT attempt to send
more patches to "fix" them.

pw-bot: cr


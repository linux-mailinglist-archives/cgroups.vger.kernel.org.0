Return-Path: <cgroups+bounces-7870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50788A9F98A
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 21:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597215A30E1
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD71B423B;
	Mon, 28 Apr 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khYxIsfG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C718C1E
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868725; cv=none; b=XHjq+kmnAMeEkfTr3xbimtDGJemqMs7w6yT64S/kFXmj7fhsK6bx+OL9rlqjPyav/7YGnlUrioPxind+uFEQFZjXuFBy2Azdx6k57xkKzwbf899/0z3qgvsrd4NQrFLCY3eE9iehVbU7rsYolNAqWE/YSASacYWe0qP4R7exOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868725; c=relaxed/simple;
	bh=clvMixzUlwXVdP1MVYhs8dd5jD9W6xD/V/kA/2PWTsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cC3KcMELGSvWKdjQvCdZe2vPMsfxjfVubS9ci7VtQe8Fi8NhQrDL04eegnOUofCUDRMOhdjG1Vz62sbO5GhmkWB4ZQFadhUAQ3S1pqTnDCNhcdRDW9kMHUAcUHOHL/9Sq48WNCstYw022aRKZg+Gd69e3KgFM0o8go11ENh4pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khYxIsfG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acae7e7587dso775007466b.2
        for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745868719; x=1746473519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clvMixzUlwXVdP1MVYhs8dd5jD9W6xD/V/kA/2PWTsA=;
        b=khYxIsfGjQKIUOgPRJSUnAnOTtnKMkuVPim1LijlNDXJV7ZqcI8WXOKkG2n/gqXvqi
         mKQk7KTbDXIu4B1S9CTBsHTZu5GJ/ra4I4m+tm45Jks1ExiBt+T/gzd/iG9jYDSYMoLJ
         xxrQset6DuGsigJvTfxhThgO6bMzssWp3+OAPgLUZTq0W7mEhwybfy6mJNu8gUOrlVjc
         8ORhuabIPojKJ3jWjIXxBoUZrub+nWaD5T1EqGhu1tekrAixvN3QRlfsPbEzaymiUEv0
         0gUyWdXbiySlXJ5QpIeO3GG8I5lp6b6Nr8w7WzfYp1a5zMou46AaoRDtFPgVgK6X/m7M
         +nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868719; x=1746473519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clvMixzUlwXVdP1MVYhs8dd5jD9W6xD/V/kA/2PWTsA=;
        b=ocIvvzxejehfyeqgBr/iqMpv8m/kHmbV+P1L+qTbDgp4KwyN0HHm5CUOBnNOZh+iH5
         7JZTqUsCmhQASdfgfM6DsSQ33aP+XAVDKw4LftCtzPvyECZEwA1E8Gs3UwGkINjklo1I
         d6Rbwcb+3WxGplVhlXVwaZFvwe1PW3wuwKWx6u+9WwXYcCWLb9UuLP8aN6iBLb/BNpxo
         I2zozh31c4s6VI6A+0AqQlfwNo5aqMQzHgAcVntR5NPrKkeMgvmJi7Pr65M7LoTYyu8G
         6qt5OYGF9l6SMtyN6iEBpGjDR2E0OdwrfS0btfdvTlOnfoEcNfSfvlaQ5XxKXkwGy9BJ
         s0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUuckXU0t2vUgv3Yw+XKe60Xk782fWaCSwi9dAFS+uoLQp9O0ipsIJbMQNQ27s3AwYK5WcHdtr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lBTLrs/Y33t9rhySZW4LAg20TpsTIiMt+gnXw2Xmq2ogWk6Y
	3C/dw8YyNRp6VZnM4aLVgLttJu5HupZ75MMQQvzfollooV+y5NkLkhN+vNHpBJEZ9J51iXUWqGi
	l832nAWtwxuheCVh5tiY5+wvKNEn4rQ==
X-Gm-Gg: ASbGncvR5/zmtMsQQ54o0IddcfyYrQpZdRCZr7DnHjt3mx56f8e17lTOVpoZUr/rVoh
	Ovxq8BOD+hfizdpAPNYD9Y4bs2j06gW23IHWswBJYN2traYH12LxoeMV78cpcpOh96ny7otMB/1
	qBlKRTa66yFrWmX+0kEsf4TZNNCB/uVl8=
X-Google-Smtp-Source: AGHT+IFLuUocUdQmizosojpHdukguxfQt2DZzVHhIIuVAmlSuN8A3ZHMSJnYr5cbpnG+GpgGCSNqqRto8AJov4Lc9X0=
X-Received: by 2002:a17:907:7f8c:b0:aca:e33d:48af with SMTP id
 a640c23a62f3a-acec4f20479mr85905966b.61.1745868718523; Mon, 28 Apr 2025
 12:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423214321.100440-1-airlied@gmail.com> <4bac662a-228e-4739-b627-5d81df3d4842@amd.com>
In-Reply-To: <4bac662a-228e-4739-b627-5d81df3d4842@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 29 Apr 2025 05:31:46 +1000
X-Gm-Features: ATxdqUFX8TlA8SB5and9ojCYJazRG2Xwfktm6GA_G0-fvfnIIHi7VfxOzfvDHjk
Message-ID: <CAPM=9tzVijMmf8P=Kthc-UcaYXK28Gy3e3W+F8i3NKdYzhL_BA@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 at 20:43, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 4/23/25 23:37, Dave Airlie wrote:
> > Hey,
> >
> > I've been tasked to look into this, and I'm going start from hopeless
> > naivety and see how far I can get. This is an initial attempt to hook
> > TTM system memory allocations into memcg and account for them.
>
> Yeah, this looks mostly like what we had already discussed.
>
> >
> > It does:
> > 1. Adds memcg GPU statistic,
> > 2. Adds TTM memcg pointer for drivers to set on their user object
> > allocation paths
> > 3. Adds a singular path where we account for memory in TTM on cached
> > non-pooled non-dma allocations. Cached memory allocations used to be
> > pooled but we dropped that a while back which makes them the best targe=
t
> > to start attacking this from.
>
> I think that should go into the resource like the existing dmem approach =
instead. That allows drivers to control the accounting through the placemen=
t which is far less error prone than the context.

I'll reconsider this, but I'm not sure it'll work at that level,
because we have to handle the fact that when something gets put back
into the pool it gets removed from the cgroup kmem accounting and
taken from the pool gets added to the cgroup kmem account, but
otherwise we just use __GFP_ACCOUNT on allocations. I've added cached
pool support yesterday, which just leaves the dma paths which probably
aren't too insane, but I'll re-evaluate this and see if higher level
makes sense.

> > 4. It only accounts for memory that is allocated directly from a usersp=
ace
> > TTM operation (like page faults or validation). It *doesn't* account fo=
r
> > memory allocated in eviction paths due to device memory pressure.
>
> Yeah, that's something I totally agree on.
>
> But the major show stopper is still accounting to memcg will break existi=
ng userspace. E.g. display servers can get attacked with a deny of service =
with that.

The thing with modern userspace, I'm not sure this out of the box is a
major problem, we usually run the display server and the user
processes in the same cgroup, so they share limits. Most modern
distros don't run X.org servers as root in a separate cgroup, even
running X is usually in the same cgroup as the users of it, Android
might have different opinions of course, but I'd probably suggest we
Kconfig this stuff and let distros turn it on once we agree on a
baseline.

> >
> > This seems to work for me here on my hacked up tests systems at least, =
I
> > can see the GPU stats moving and they look sane.
> >
> > Future work:
> > Account for pooled non-cached
> > Account for pooled dma allocations (no idea how that looks)
> > Figure out if accounting for eviction is possible, and what it might lo=
ok
> > like.
>
> T.J. suggested to account but don't limit the evictions and I think that =
should work.
>

I was going to introduce an gpu eviction stat counter as a start, I
also got the idea that might be a bit hard to pull off, but if a
process needs to evict from VRAM, but the original process has no
space in it's cgroup, we just fail the VRAM allocation for the current
process, which didn't sound insane, but I haven't considered how
implementing that in TTM might look.

Dave.


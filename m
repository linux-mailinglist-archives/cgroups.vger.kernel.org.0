Return-Path: <cgroups+bounces-8313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5EAC0C92
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED08161262
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AB23C384;
	Thu, 22 May 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIucM8bS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889128BA84
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920146; cv=none; b=eFEaGdx1D8ovc0IOejZ0UAQcjdPI8QJmzthUO3bdfzAmepSZn5epUEPcJ2hNDx0SwOah6aMaZVYm0hViYCxtaDnejXX+VRcvcWMKBEFIHwyl+0tFukO2SgGXSG1y0TgDOyOyDnkPPSsjg6B5fWzPgGSGeZF3SqvTeuuF3QAXbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920146; c=relaxed/simple;
	bh=GhnPvnyF81qCLEuuuEpjKTmEy1+h7b5EK7ttwhsx74E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jucTvJSCXnp70V7qgWeL4yPB2tTA+vDTSkcSArTH9k/J5e1oHn9zewhTcUhgMQc/dVpx23FADzaR9XJYbKmPzWlSQ2C8VG/+g34mGMEo0sQOaVKSx2sr/VGksIAimgtqkYKxKwdXqhIBCMM6Qn/DSMBgGrjuAQjF5xTfd6E3tQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIucM8bS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32923999549so35979211fa.2
        for <cgroups@vger.kernel.org>; Thu, 22 May 2025 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747920142; x=1748524942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrjBkq0MK2du99CfewRZFEGnjtf2ZXkpLkF1BzPcvck=;
        b=ZIucM8bSYqknMw5NKiIYgCYGeLW+HeeJcxK1DkXcFEYLQx/RHQSxJh/s4DB1+wxKlB
         CXleJJl8g+1eebSUJ4QMk/OZ2yoOBMoIinpCSACuQaV/Ib/naYulVJ73BKpEpMs/5fC9
         A1jhiEExD8U1ZbFNhnT2nnSZZnuLyd5HPeOiOZCL0MWlBPFNpCdLpSXyhJjVWLjLy4kh
         /RVxmsUsVc1A+siDi0gaAWEygJ4pUmNk6jmZumE4mq02dGvL0h4+/0QbVA4Pyd23DeJT
         mhMGOzZHWYDTzWuyN9ZVafQhgjrcYvBbz3jM70O735gqXtjIB2UqBISiI49FByUiWIGq
         /CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920142; x=1748524942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrjBkq0MK2du99CfewRZFEGnjtf2ZXkpLkF1BzPcvck=;
        b=KWfcWuEFM8KP7NdzBVz74pngLmICRmUzi1GBWLqU/on7AeUBbzTqQ3d2ymK0My9Sjr
         VsXhBL62buK99QoHQaHzxqafcoNG/8wPvdYIKEOt6bqcjaOIAV9KnDHmKhobWQlYTqrg
         VBPeg/EVBwcbKn8GXRrLAKtCWJdv42dEpPk/fUl0fauKSueNubNX32WwgbU0mHE20gpJ
         X61m798h2nkm0Bq7U6vsuSLGuJigZAHy66YVbM0j7gR+H2Kear9hpU7HC6Hf1wJdwZnZ
         CNojHlyNVFp8GIXYyq7aYRdd0Xmb7O7zgH8V6eqr1CkBFKBGuXOF6/bppHNHnSlQ9VR1
         3SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqfzKNtKYsw3o8GKdu6aSbXOqRD0p86FwxFioCwNp8O9EUY43qQiHEh06jMjO1E1uQebkJ1bHc@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxgFDd/x1m0L24+vk8K7Tr+mNUP3e/Bd//HjoyzpI1e6Ey4OT
	FRgA4AtSD1Bt7OQupkD17rhH2K7wNuKSmZgVwWJcQYtb2vCUmNpcAh2x
X-Gm-Gg: ASbGnctB/fhZknzufn2xLifGtpeBjSwNglUDNvkvUbmTDXJDk61oJEQorwu1t6vQtb5
	z9gnC4Ol+hEciW+0G91rBs9kQR0ijIk5ZeNzjqy45GFVKE1t78O91g3gYe6x0yqMWq2O6AQJ9Qj
	zId4W+u+NFuaec+nD8VLiPMPVaXTxbcaIhor5a0/u/B47Hid1T+LHp1I5aOPaJhk+oxM/hWFx5k
	Ts8Y2L+Ur1CCqbLJQ7f/elYJSC2mCX8yPI49SF4zb6fuXFwsu6nWOgLSS57xPHL+rxKv+A6hdnF
	pVRn0bQBWc964nJS366xv0bs/mwI+irJTPZcToCkVjVxjh1sO+Q4mxw/5gJT3nL+G+x4Bb2Y+3k
	dCA==
X-Google-Smtp-Source: AGHT+IH4ityy5NjdXC/bWVdInq12NqRwUx3fQ2VDq07e9qe8MbuqTUAn1d/M0pPBIz2guBzf7BNiyA==
X-Received: by 2002:a2e:a546:0:b0:328:539:755a with SMTP id 38308e7fff4ca-32807741537mr94219851fa.22.1747920142276;
        Thu, 22 May 2025 06:22:22 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-328085edc14sm32425801fa.107.2025.05.22.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:22:21 -0700 (PDT)
Date: Thu, 22 May 2025 15:22:21 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.16] cgroup: avoid per-cpu allocation of size
 zero rstat cpu locks
Message-ID: <xmvzgfhmfujzxm7xa7lthl75z3gpvmei5fqyzjzdrjzveam7hu@ad6yhbpl27sk>
References: <20250522013202.185523-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522013202.185523-1-inwardvessel@gmail.com>

On 2025-05-21 18:32:02 -0700, JP Kobryn wrote:
> Subsystem rstat locks are dynamically allocated per-cpu. It was discovered
> that a panic can occur during this allocation when the lock size is zero.
> This is the case on non-smp systems, since arch_spinlock_t is defined as an
> empty struct. Prevent this allocation when !CONFIG_SMP by adding a
> pre-processor conditional around the affected block.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Fixes: 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")

I can confirm this resolves the issue for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>


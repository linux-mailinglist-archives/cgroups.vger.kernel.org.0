Return-Path: <cgroups+bounces-8418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14579ACBF16
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 06:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB79916DC27
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 04:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3111A5B95;
	Tue,  3 Jun 2025 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sB+jjauh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D3FE4
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923861; cv=none; b=XTJO91J+LLhQiD2cmZ85Ff7GmlEbdXxp0YXZKREb2e2exh3uthD1pU1LxGoVrk6YCKWxGf5ysbz2q9kEp8VA1o4zGPwaEg13kfcpfbe4j5cSPE70i3UV+kLP5+iJ5zmvClxn9hQAzBFsYcKHYu8kcHaR7aawSmtVL3FD9zJjgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923861; c=relaxed/simple;
	bh=fyHL9PfGfuHfJ+/FgVIfLdDcopMJ/d17KHdaJ1psq6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkzPb1/21cPBwXZsS13Bf7LNGX+aoFmWYqfQukuQDT87x+nMmy/4Fpkqop2OIhpWVm3ALxQ4Cd/PfsQ+B6hscKddUhZ/cFg4QVcf62e6Tl6WZ8TqTjci5t9Jz1dEE8aZAq0NIAUgcPyVcq32UWRX92XHiqF8ebJz5+Vs/cWVptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sB+jjauh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW5SFM0DfyK28LiSvWv7IJWjKONPoPP8dBo2lmTJEQzvYhWWcSpWNnb3EdL/3XQDeSMW2ETptig@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748923857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyHL9PfGfuHfJ+/FgVIfLdDcopMJ/d17KHdaJ1psq6k=;
	b=sB+jjauhgkTooaBOi0jJmdu2id9qLXciOUuqDb6m05hxL/Q+haFJ6fDjSE0wPi7BNtN8Tc
	5wxzhms7f0Ht8bfzgpbrGFvkTedFsJp+9peqhFGs5qnYmFEWznv3YSfax87I5db4DotAP1
	y6OqSkjZiqkEYXytfXTa3wiA+wwAwYY=
X-Gm-Message-State: AOJu0Yz1a21y1kwogqCh4ehiYE49HIl0vJsPLDfQYWrlrAqzyKeafQM1
	EUYKURtVygqUYuNFPgSwb+27Z/eye+hCwctuyno+H7YPmSlRr7UN3i7UUjiA07g/yB2Pz8jXbnm
	FPq7p2l5TA20+NhYW3BjDuo705nSZm24=
X-Google-Smtp-Source: AGHT+IGu0RPZx7g/Fw/yXBZJqHeBNgd3Wlm/dGDjCYpg2FksPv6OYcFMfdsVcnLl1u67C5N1aLnP8GPRjW5s90BZP0M=
X-Received: by 2002:a05:6102:a47:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-4e6ece33e74mr11660010137.13.1748923844454; Mon, 02 Jun 2025
 21:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522013202.185523-1-inwardvessel@gmail.com> <b9824a99-cca6-43d3-81db-14f4366c5fef@roeck-us.net>
In-Reply-To: <b9824a99-cca6-43d3-81db-14f4366c5fef@roeck-us.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 2 Jun 2025 21:10:33 -0700
X-Gmail-Original-Message-ID: <CAGj-7pV8-S_b7Bw5uhvdjN-uNRL=gsyyQTMf+36TTzhJXpT3CA@mail.gmail.com>
X-Gm-Features: AX0GCFvffCela-JHm8qWAxM6ah-WI8DA_Qa1VBMvvmS-zln7O7Hmg5RiXaTYm5E
Message-ID: <CAGj-7pV8-S_b7Bw5uhvdjN-uNRL=gsyyQTMf+36TTzhJXpT3CA@mail.gmail.com>
Subject: Re: [PATCH cgroup/for-6.16] cgroup: avoid per-cpu allocation of size
 zero rstat cpu locks
To: Guenter Roeck <linux@roeck-us.net>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, klarasmodin@gmail.com, 
	yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 2, 2025 at 8:38=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Wed, May 21, 2025 at 06:32:02PM -0700, JP Kobryn wrote:
> > Subsystem rstat locks are dynamically allocated per-cpu. It was discove=
red
> > that a panic can occur during this allocation when the lock size is zer=
o.
> > This is the case on non-smp systems, since arch_spinlock_t is defined a=
s an
> > empty struct. Prevent this allocation when !CONFIG_SMP by adding a
> > pre-processor conditional around the affected block.
> >
>
> It may be defined as empty struct, but it is still dereferenced. This pat=
ch
> is causing crashes on non-SMP systems such as xtensa, m68k, or with x86
> non-SMP builds.
>

Does this still happen with the following patch?

https://lore.kernel.org/20250528235130.200966-1-inwardvessel@gmail.com/


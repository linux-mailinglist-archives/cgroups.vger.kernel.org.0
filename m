Return-Path: <cgroups+bounces-7097-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3EA63658
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED66D1885B31
	for <lists+cgroups@lfdr.de>; Sun, 16 Mar 2025 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425719C543;
	Sun, 16 Mar 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9phuXse"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEE381C4;
	Sun, 16 Mar 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742140766; cv=none; b=lXmF6YJXDeezunCEuBkqZkq5P0YY0DuEKXsPdj+n/pnt0FtAUSdpfumuG8qqzpAfeWM2wHWXSHeDlC55D9SSW06/ZZQV5Fd+4kGs4cjZ2s8Si5hYOQ8fRsLg3N1MYdtl6Qsgyym0+0yyXqQAjk1pgsOgdEJcjgf7ElTCvQg6vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742140766; c=relaxed/simple;
	bh=wKUObvYL/6PIILGbRD1vfUG0vk+Dv9uBdZURz28Gz68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm4kCq0pawhRZmcfmoMQ8/c1topCeANt4W2Vf7f7/3uSdcdqLkJ6QPDLAGsI78N4qpd3MpAL/4pZCcDRjLC1YasJoJKkSDfDD5V3AiOXG4ZWcSY1N1iB65wYzSsi3zchTkAwb8+V6ZZRvRxlB8nmdSWeXZnGXxh6LYtkdI1PaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9phuXse; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-226185948ffso792445ad.0;
        Sun, 16 Mar 2025 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742140764; x=1742745564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4bZp2fvqVXmj3CQtnXGqP+MV9d+iqYo2DdHMBvTbsM=;
        b=U9phuXsefHBnJWHuh/MKUbAFbraxPqKsoH9nj8e1IOkvMTISxYd92AQKYTf7mTHYrd
         N68wV96pAiIBV0zeXMkJTnIBfEGKYk2oz53YK2ADByX1EGTGBDuJ6+51uPgYD6lavyjc
         l9BQmjQ5rbxCqLdBaiYHdOFcTjLf5LwzM2hV+g0n1DCg0kXNAZbKB24k6pnDyU1qZbvT
         SqxNzeT1eH5tIXhj1mXF2JpLhdIxq0XNH8sxYf2fsXGGxilQkH3/X/XTGEyXuZyh6Lgg
         5b4Hpi7PCGt/zGa34Nt7b1hYtz0zV6YVJJyTjPV376Ezc7VasoV/zSArXRZvETVr7a8L
         82ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742140764; x=1742745564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4bZp2fvqVXmj3CQtnXGqP+MV9d+iqYo2DdHMBvTbsM=;
        b=jCz8vp/NQwmoHimS0RjE7zkG7yPBik/0G7XEccQe+JlOSJlgOYC2rvS0feEQeYSUGY
         M2HXMMtnXF8IQTs0UZUW9awFOVpOA1t3DHzR/w+L0+mc2y6W+oyiHsgp03dsC7r7iKBT
         i/GW0np2E4BI5My2z3Btg2FUl4468hzRyNkroGcxFLu3zuHTXd6Rr/ktK/xqpFN+qSi9
         GfqsVvMqozsdqwS3P8A6hcQPf3w8HQ8oRoqjhXNtw5wOeb1JdN0zb0EiiLeIOSH2z988
         HiyGPyky9e9Y0JKTKbbCEocIsFOOmnLnzT0E46vYd0/6z6HVEEQLfjkw/5xkDr8TYOYe
         Lv/g==
X-Forwarded-Encrypted: i=1; AJvYcCUgO+oPkafankks6rezEsirx1ykA3GQIfB0XcrRIw/BqotB1Hmv4fKZQH/3Ja7w5TlsPVb2mfJK@vger.kernel.org, AJvYcCXQCut6/5PfMSa8oF2mJU6ANdnq4nbacSdTuRtHdzOFoGAGsX/IVgZajpy5IqreKyRfMkF2qSjF7Vhc40Qo@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDAxn1RfFWGaRWpIFX/HtB0ZmuqmC9+K/fiSTG8tKLMeTgSR/
	Nydr/IDwuVWMzmzTGxgf7B5ZmgpCF/GQWcIPb0IvE2L1nXqKxwDA
X-Gm-Gg: ASbGncs6jGfNvLvnnAZuJF/afk/tQIKVu2jZRhJKHS5/JW855phhuDT5Qq/R48bkGEe
	w/1mJe2+Vb0Y4wnxdORqcHEqv7mE01FVsUCUdr8QYGzE56VdsMLhrwj4XQky8giV0blhtLmoXHY
	SMSvv3exqUPqwaEpclDhHlgndo7J8vX9lleLokRttw/R39kQRATjKjoiDxxp7EQFNLPEdF5JcLY
	h+fG4opoBgr5/D7+bU0G1/39cU9NqixF5DEJqscVRCABOVy7YDe9mYTSdqaipR4zlqNjO4Bqo0B
	Yw0Sp5oz8fz2G/vik6LisyCpn5n2VlmkabmxrP4So1e2oepEAGxv7Ah7fCd7F0i41enHzf0=
X-Google-Smtp-Source: AGHT+IEQAEZ6ns6hsA7mRZvJHISXdD7LaGEtw+Oe7yAnHpSLVjJcLic04uKzeIOZwjy/qbtI3xODVQ==
X-Received: by 2002:a17:902:ce02:b0:220:c066:94eb with SMTP id d9443c01a7336-225e0a6b2cdmr125317245ad.25.1742140764417;
        Sun, 16 Mar 2025 08:59:24 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::5:4180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa906sm59447255ad.88.2025.03.16.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 08:59:23 -0700 (PDT)
Date: Sun, 16 Mar 2025 08:59:20 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-ID: <tk35wbak4rp4cpz7khnkpwz7ortta26otktb67c5pmt3yan34z@qgyjxc44rvmp>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>

On Sat, Mar 15, 2025 at 08:57:59PM -0700, Andrew Morton wrote:
> On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > 
> > This is a cleanup series which is trying to simplify the memcg per-cpu
> > stock code, particularly it tries to remove unnecessary dependencies on
> > local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> > optimizes the charge path by combining the charging and accounting.
> > 
> > This series is based on next-20250314 plus two following patches:
> > 
> > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> 
> Unfortunately the bpf tree has been making changes in the same area of
> memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
> stock_lock.")
> 
> Sigh.  We're at -rc7 and I don't think it's worth working around that
> for a cleanup series.  So I'm inclined to just defer this series until
> the next -rc cycle.
> 
> If BPF merges reasonably early in the next merge window then please
> promptly send this along and I should be able to squeak it into
> 6.15-rc1.

Ohh. I didn't realize that try_alloc changes are causing so much trouble.
Sorry about that.

Andrew,

could you please instead take bpf-next.git try_alloc_pages branch
into your tree and resolve two trivial conflicts:
1. https://lore.kernel.org/bpf/20250311120422.1d9a8f80@canb.auug.org.au/
2. https://lore.kernel.org/bpf/20250312145247.380c2aa5@canb.auug.org.au/
There are 7 commits there.
You can also squash Vlastimil's fix
"Fix the flipped condition in gfpflags_allow_spinning" into 
"Introduce try_alloc_pages" patch or keep everything as-is.

I'll drop it from bpf-next right after.

Then Shakeel can rebase/resend his set without conflicts and everything
will be nicely ready for the merge window.

I'll defer other bpf side things to after merge window when trees converge.

Thanks!


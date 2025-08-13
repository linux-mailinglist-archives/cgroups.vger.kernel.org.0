Return-Path: <cgroups+bounces-9135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCDAB24FD7
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDFA5C6230
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5B285053;
	Wed, 13 Aug 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ia8Rxzvr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F7286424
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101834; cv=none; b=HP2nsJV6LcUCPKI+Ic2HO3GYrKX6qzVpjRzezksVxXdxiYoPYGX7124o+lK6H8kOttvXhtx1kclOymsInUaYn8+yuHsghj/2gx9xhF7/IO5n3IFg5ingG3QoWBNp83jaKFY9ImrtSxlGmn9UZDyPPhkwq+PjGgrqJC/NNp7bdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101834; c=relaxed/simple;
	bh=aLnZpcSWdOkXn92ubxlWxf5O2UCHUI3ra/13J7g/mq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJxWxdMKq3qbEovZoNH5x8NIZGsVRptjJYggNpCiXAMbXq8P0D6xD9UiNBzURRPgxlglHTgV4Cbxgn1mJFYoOrvn66m0wAmcgsskgh2i3WSqDusB68ONFh/e3Ahv9/C2sxeDudliiKqv5gby4wdqp6JMWUx6g52HW++IzzFbMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ia8Rxzvr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e62a1cbf82so478770085a.2
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755101830; x=1755706630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0r8lX0/1M6KsfijF5/m66QhjeQjFJTvODKoUvnEDMw=;
        b=ia8RxzvrROyJtWb4VyAqvpjk2HWUECUbQcj/XKu2JeVwgr++mnuR6dY+T2hXOQBPtz
         2blZSwirOZPhacLwrC3taqui8/9UJssoM/duHvOZq2HyiooF7r4eM76mPcgRJWeBcjme
         r1gbU1fp5nVp7Lm39JYmKc0huIYgbBDmjb78kp8zhOHhMHHFRmBYNoeqz2x9NMZWMYFe
         GqJVyFJwAZP8iVId1xHYsh1Tf9KpKnGMT65wYXUVjoKI94sXsFMHWZ/nk99EhOhCL3K6
         BV6njPefy1y+Gt+IZyfgcVyg2Ev5k/1j7ujxXhXrDeUtxmtSTXGkDm7/a0KnQi1eTEh9
         fOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101830; x=1755706630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0r8lX0/1M6KsfijF5/m66QhjeQjFJTvODKoUvnEDMw=;
        b=WyxAOx0erNoU7/3ZXGUAGoVa3Dcd2D9XGLfQtYvoK7p5E4gDUX9v+04i9/9ywbZrUX
         Z6W7/icX6MO4tuqdCX4IrK+1b0BCuMlT/0cQKKpml5/b5lTJbDYtPH6ldHuQEWOFkVOC
         nZUarX+vQwZD/xFBrGaAeQg5z3doTawHGGH3sSwahhoO7lTOrkvHQAAqhBxvpRoZgoX6
         8PffAMwuSmNHF8wVZ8u3vtH2mWREriT2XEd55AAIX+dEZj77WPvljdHOT6MA3sojvX1l
         i96wopsZLGppeTu05rOsIELgON0vJrkTIbpf1DDJ85zzJMl7lWCHhzGDL7d6kYnq1kR4
         HiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTg+CTcQ7549BkNWrQtT0krdE4N1Bw6PVRhaG+UmhJISekp9cjkav4NXuPjWTKF2ZAPEKAWw/U@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyEIpdNcN2e0pHJyOl8ft/37YNhv0DwTCXEMcE3Zn+osPY6SF
	3XcDSWHdoB8qFHUh4RZ4F2kkCObE9O7uL3P0BfN5g4JzXDQ4BtXhyRnPnEVXk1pqGHE=
X-Gm-Gg: ASbGncuySnAXBNBvvSHJbEOVjIhfElu0x6KrVXJeRyqJ4VUTU5pZCBvJaSFbCknRN6v
	mkl0ElpRJl/ArTXx7ogTEILaRD6TV8Ol1GIrSoMjAahLyjiffvlqV3QcwOnzgxBduUNxHUwN69t
	j2yvhOEMxV3tyZM+AxxslsSVruhWWVoVCvF6aS0GKgzdgGK9SQGOM9iedhuJaS2QzKcikijrNXl
	xlXFI9ZmC14cV14Q8spuaaW4F56snT0Pck8d2lgL75GXnMoxxnZLNvIktRFWBCat2JiOd1HiRPl
	Uv1M197ZY5XoxtWYGHdwAruaYTRq5PY3kbRl/2V6kHE8iF4nulekwQkF6/sxVYpQnBhtEWL8yTZ
	5xA53abM97ex1HGC0dOjODQ==
X-Google-Smtp-Source: AGHT+IGHCZVUArn+hQTSYfm5ZLOiQRAX3EihSL5rOgIAp2pUobtvdJENs5NTWAKywrm2ri8umYv+Hw==
X-Received: by 2002:a05:620a:560d:b0:7e0:e7b0:967e with SMTP id af79cd13be357-7e86522c104mr386843385a.7.1755101829593;
        Wed, 13 Aug 2025 09:17:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4af230d8a21sm153187231cf.51.2025.08.13.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:17:09 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:17:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
Message-ID: <20250813161708.GA115258@cmpxchg.org>
References: <87tt2b6zgs.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2b6zgs.ffs@tglx>

On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
> space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> other entities as well.
> 
> This results in a unconditional mem_cgroup_handle_over_high() call for
> every invocation of resume_user_mode_work(), which is a pointless
> exercise as most of the time there is no reclaim work to do.
> 
> Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
> quite frequently and the empty calls show up in exit path profiling.
> 
> Optimize this by doing a quick check of the reclaim condition before
> invoking it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


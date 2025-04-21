Return-Path: <cgroups+bounces-7678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F3A95501
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B07C168010
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB281E0DB0;
	Mon, 21 Apr 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SnUsAOd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289719CD1D
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255178; cv=none; b=lsFGeQbL4PnLTlj6Mr/6dVNtUZpVm6xNhXL54MP+KHdm00El6MiVkf2r/zqpaqdIVhaNpRuQDpgBy3IzcnOko31znYm4hSVBhMf3ddQSjviQ9kkIzLsiZ1Pz+1sLUOZEeVGL6LCuhUp23C38ZlfZPjrpUSVCGZJOfAjmSuPla6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255178; c=relaxed/simple;
	bh=yfkSwOMgh7jwOhoRL7xNX8B9gRCyDko2LfQ/jk2ZI6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=apGr6D3T7pZDBmWDiyLovZ0YV4yRm0Kez+pALMSh7o79bH/q93TtcKshwPdvr2o5CqWCOD2mGvuBMYPpkgg7qhYDDlbO6uaz5lPznCu5OM8/DKcATC/0gZkaCOwgb+A7z8LUXCWChKr5yilry/uEyO63+VXLWvawg5cFOIOxA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SnUsAOd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso3847223a91.1
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745255176; x=1745859976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGVm6Iz284Y0SobVO77Gr/vtAHZx6PoDVFWOgbVwgEA=;
        b=0SnUsAOdubshSd/bQOuL05TzErYZjZutaYksR9/xgbAMVpqJX22B5nDXIUdt1ub6nb
         yY/mJLtWmsVEZVK3n9mwB3w4cYggDfMewot1s2Mkam7a7+0gPAKsi2lepmlxaJ3xO2pt
         GHTrg0b7f4yE5qILc96tzar+bylVtVji24SQWya7wONFFeVSAZqc7mko3uySJ1Xdj7DD
         zsffW7itH0E45RXZOVulhxQ+QWKbIRnsJ9+ZrpY7EVZBCcp6mM3+V+yk3/qAsOtl+2ez
         +vtdIUHfc2m+SaJAFodf5uOF3sdLXalZAASrLyEUbD+9B55ewJDN0LcUlPTnhZuthOlO
         sTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745255176; x=1745859976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGVm6Iz284Y0SobVO77Gr/vtAHZx6PoDVFWOgbVwgEA=;
        b=psyKU+df0/j8fagaQCNZtRSulHLYyVcY/a8Db7N0tCuiUGjv3w2lJAdkvQsoMtJ8Ib
         oAvPp/oNewFzXxfWuSKKLrPii2XVK5JJh5mA9ra02n/3u8x8k9PhYiZCCEY3LWtg2z9x
         ATmXME/38NWTxi4V6xb0xiISp8Jr+vQnNT+4hwNVhBSrzvgRROOtV7qovcVoYVV2rF/9
         xEb3GDwRtSGiHm+q3y1UcB4p1MKx++G8hV0yNlfptuHllmItbokTPBy56N1Almi3UMln
         xCqrxk4JV3ij2GHsRh+3oVisk/1rS6IVf4lqVX5kZxRrbygGB9S/n6JZAYhaNRodR8iR
         Krjw==
X-Forwarded-Encrypted: i=1; AJvYcCUUwCfdidDKh6tpuBpgZH58NA3P9rfRV3MUKodhicoX1k6K8epyG4AUIc6FgvVz4wxjmnq8nGiY@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMqFQMSqRlXfwNASeUaYJADL/ucoV3qaVzu+nDZB9f6imEvg6
	zfFf4FIdrUO4kNiVkECNXjitFStBZbKqS0KbYEd3+5F86A43G+Qq+NVN+xuTXIPM3327ZDgdJFn
	7Jwm36w==
X-Google-Smtp-Source: AGHT+IGJnoJr8pRxSRD/hhwYoroUkE+lGUx4/nXUcE18/FUK3RmYB2FZoc725vebNXgkeUgU5nmSHFss5Hw7
X-Received: from pfij16.prod.google.com ([2002:aa7:8010:0:b0:73d:65cb:b18b])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2704:b0:2ee:94d1:7a89
 with SMTP id 98e67ed59e1d1-3087bb36bb4mr16771781a91.1.1745255175978; Mon, 21
 Apr 2025 10:06:15 -0700 (PDT)
Date: Mon, 21 Apr 2025 10:06:13 -0700
In-Reply-To: <rgze2xgrslssxoe7k3vcfg6fy2ywe4jowvwlbdsxrcrvhmklzv@jhyomycycs4n>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
 <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
 <ohrgrdyy36us7q3ytjm3pewsnkh3xwrtz4xdixxxa6hbzsj2ki@sn275kch6zkh>
 <aALNIVa3zxl9HFK5@google.com> <nmdwfhfdboccgtymfhhcavjqe4pcvkxb3b2p2wfxbfqzybfpue@kgvwkjjagqho>
 <aAMVWsFbht3MdMEk@slm.duckdns.org> <rgze2xgrslssxoe7k3vcfg6fy2ywe4jowvwlbdsxrcrvhmklzv@jhyomycycs4n>
Message-ID: <xr93ecxlsauy.fsf@gthelen-cloudtop.c.googlers.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
From: Greg Thelen <gthelen@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Fri, Apr 18, 2025 at 05:15:38PM -1000, Tejun Heo wrote:
>> On Fri, Apr 18, 2025 at 04:08:42PM -0700, Shakeel Butt wrote:
>> > Any reasons to prefer one over the other? To me having separate
>> > files/interfaces seem more clean and are more script friendly. Also
>> > let's see what others have to say or prefer.

>> I kinda like O_NONBLOCK. The subtlety level of the interface seems to  
>> match
>> that of the implemented behavior.


> Ok, it seems like more people prefer O_NONBLOCK, so be it. I will send
> v2 soon.

> Also I would request to backport to stable kernels. Let me know if
> anyone have concerns.

I don't feel strongly, but I thought LTS was generally intended for bug
fixes. So I assume that this new O_NONBLOCK support would not be LTS
worthy.

> I asked AI how to do the nonblock write in a script and got following:

> $ echo 10G | dd of=memory.max oflag=nonblock

> Shakeel


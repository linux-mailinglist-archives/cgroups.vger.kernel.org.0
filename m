Return-Path: <cgroups+bounces-6253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15CA1AF62
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 05:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FA516D3A7
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 04:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE41D63FB;
	Fri, 24 Jan 2025 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GyNrJH9O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81291448E4
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737692589; cv=none; b=ElurpfyEHwgfn7TouanHneZX63ooVVIlU6KvQohENJsoM+UBseI+vxfFWQS2rYivpfxqZ93d5CY+s5/FJjIxtTVXC6+4REYU4HKftS7Z+KJmU/mJiomompq0J/LoByoVxs5wNMyhGUxIwflCaR2KPpa/7gMZu4P+DfvrCyXlsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737692589; c=relaxed/simple;
	bh=QIUoKjwxPBNQni2VV+m60SGOzN6C+VWkQ/6ZLrpa8Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPRtaV/CZHYKym57xP5MydZ16VQCoeumwumc5hw8eGBzDz4mxbXvJPpq9hHkAn8z/bScnRm3/8GRgTUMub61yZuwstEEO6Tl6I1hSCGXf10IeUVTWy3gFlPWX3ZQlpr6xNY+Zay6pW0Qbo+xotpuGd/Jda0Ne30JLuO2+Eze7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GyNrJH9O; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e5c74cb7so141033885a.2
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 20:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737692585; x=1738297385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kG4DUpM1UB6jOLI1pm+8TNJuI6YIiIHXVVab7FNAq7c=;
        b=GyNrJH9OpK2mdg0he1+TAS41GyxKLDUXpBtmXPbdYQd9xrDw0SiDYl5QBh/+JtoAVX
         niO/svlwnm3jB70MSN5haGeC863ZeqNHoyKLzztPaSXi1Smmd33OocUgIaHCrGZzzq46
         AhVKexW3vHT9CFF2gK07DCoj8HQ9vMr3x5aUi9xYfKRCHc9+ce4BreRJWdT/f0YEHY4W
         ODrCUAyOEVZGZ2ZizjCxuj7TBB9r9NmvRgErpVmIJyHeBZAlClsoun9ESC4lLr+tRLyA
         NESxBTUfqw9vU02IypssVnmOYEMhQWxU4ylnVydmn45EP8EbN1ewyWu0fDcXA86kLw5X
         g1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737692585; x=1738297385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kG4DUpM1UB6jOLI1pm+8TNJuI6YIiIHXVVab7FNAq7c=;
        b=FUczWH19tIlZxghKlqiZ7Xd/9bOM875rru9bLQjowC86/TIw6Ptcy+LYG1ItquwxqQ
         av0U8etkBBFlqiHwHhcyDWbG5jcYZskyziUp/vwR5r9kPOID4pH3xH3gZMkbVQF7nOCg
         rp5AJvu8H9q9Z8bCcWle7HYbziknNA4CEl0O8YY25lk8WHL+VFABjhyacB56NEjoynK9
         4rx4bGedqK0mcFe+naGg4Wvu6doKNjnMGVl7yv8afsCqSfCAKeapHPW+k797uChrcXb/
         OAYWyrMxuPHNuacReZGNgAZAY1NR+h/rx7M0KBNF4ze7Ozihi1qQuR6sPjcPieAQNnoD
         /S/g==
X-Forwarded-Encrypted: i=1; AJvYcCVsh/l3UZDYRwDqKSPdg1r0Bcyo8R1HQRyk2o1tCz3dbQMiK9gFOvplD0c15r/QzS+ySP+aDZET@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzNICKECFAFhblipCX6dM+dhPgt6bzYDuScC3hPDqtk+Dp8eF
	JrLQ1bJ02YTkbSKN7aR250Zv1h0qXNSA79hYqnMPpFWWxJ+0Z4L8Ifv7vZtIcaI=
X-Gm-Gg: ASbGncuUDVEiEgOkiE+6dpC10NZ5R7fgXhAQppy7UJwRdhnXVNKMqOUGAwGOxcbG8FJ
	UqiwDCsZQUqifsBIRZa4wnd83Cjg6ou7Kwd8GZrIDtmI7k9hegUzLH1KzGPmtNaVEz8IYqMJ1nE
	QxOXMUdd+uh3ziLLbHvU1KjZi37RD6NufHa0Lay0vYSEUzVldST9+s8U6vWtxZGgamvvWrLGJ4x
	T/V6j7UVUILKcIkUVtHByUhpCCrCNH31riglVjiOuZd9BAGjNLQ8iiWm4Jcmm4a2X7RCLhiyIBf
	rIE=
X-Google-Smtp-Source: AGHT+IGo0KG1jJsV8LAVWPWibBVx7pPKXJw0TH3lDScWkAUGDKvetKsTjpYKOK3t4tcayDEiV/Ghsw==
X-Received: by 2002:a05:620a:c50:b0:7b6:f024:3ca with SMTP id af79cd13be357-7be63288d69mr4526978385a.58.1737692585320;
        Thu, 23 Jan 2025 20:23:05 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7be9ae7f84esm56105385a.9.2025.01.23.20.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 20:23:03 -0800 (PST)
Date: Thu, 23 Jan 2025 23:23:02 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 4/5] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
Message-ID: <20250124042302.GA5581@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com>
 <20250117165615.GF182896@cmpxchg.org>
 <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>
 <20250117180238.GI182896@cmpxchg.org>
 <6daaf853-1283-42e6-bb0f-55d951edc925@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6daaf853-1283-42e6-bb0f-55d951edc925@huaweicloud.com>

On Tue, Jan 21, 2025 at 10:15:00PM +0800, Chen Ridong wrote:
> 
> 
> On 2025/1/18 2:02, Johannes Weiner wrote:
> > On Fri, Jan 17, 2025 at 09:01:59AM -0800, Yosry Ahmed wrote:
> >> On Fri, Jan 17, 2025 at 8:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>>
> >>> On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
> >>>> From: Chen Ridong <chenridong@huawei.com>
> >>>>
> >>>> The only difference between 'lruvec_page_state' and
> >>>> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> >>>> respectively. Factor out an inner functions to make the code more concise.
> >>>> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> >>>>
> >>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>
> >>> bool parameters make for poor readability at the callsites :(
> >>>
> >>> With the next patch moving most of the duplication to memcontrol-v1.c,
> >>> I think it's probably not worth refactoring this.
> >>
> >> Arguably the duplication would now be across two different files,
> >> making it more difficult to notice and keep the implementations in
> >> sync.
> > 
> > Dependencies between the files is a bigger pain. E.g. try_charge()
> > being defined in memcontrol-v1.h makes memcontrol.c more difficult to
> > work with. That shared state also immediately bitrotted when charge
> > moving was removed and the last cgroup1 caller disappeared.
> > 
> > The whole point of the cgroup1 split was to simplify cgroup2 code. The
> > tiny amount of duplication in this case doesn't warrant further
> > entanglement between the codebases.
> 
> Thank you for your review.
> 
> I agree with that. However, If I just move the 'local' functions to
> memcontrol-v1.c, I have to move some dependent declarations to the
> memcontrol-v1.h.
> E.g. struct memcg_vmstats, MEMCG_VMSTAT_SIZE and so on.
> 
> Is this worth doing?

Ah, right. No, that's not worth it.

The easiest way is to slap CONFIG_MEMCG_V1 guards around the local
functions but leave them in memcontrol.c for now. We already have a
few of those ifdefs for where splitting/sharing wasn't practical. At
least then it's clearly marked and they won't get built.


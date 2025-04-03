Return-Path: <cgroups+bounces-7326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F5A7A2A7
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA96C18901FC
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971E24502B;
	Thu,  3 Apr 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gaTcrXEU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3A1C861F
	for <cgroups@vger.kernel.org>; Thu,  3 Apr 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682629; cv=none; b=iYatfP+DYiTtBexQQBAnFb9by7w3JfeIEv4vw2tjcRItTz5jf0MllTK7fAfExm92gMdi1RKqNTLlq0GcqZY/IpA/45wvvFADBEn1TlLYptIscAapjwLMAIeV7HhU9a4rIHclfRQqWQwlwNg0RmKVrN5GD2q59q/uOyHWJm96f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682629; c=relaxed/simple;
	bh=wFIIa1FHRVFXLxxXeQ1gqaA1krM7d8OpZjMKjJyzLb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPM4hte1yqvSAVyVgzCstJlnZiv/nn0bTELlcJDwhdWsDz6DNaxUxFuxeZHY5uisPjfS0zIvS/f+vMyVJjQ5CiP59vblmoQlmShE9FPS6Xf+K977rPCR401RSaS447seDtVAwvOBCj7FLL6IAsanck2yfrPocFB3MxO4nppfp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gaTcrXEU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso8716605e9.3
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743682625; x=1744287425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHtjp6fV8bfAv06r0KHl+YilzLbX3SHLECV51Mil514=;
        b=gaTcrXEUrEoVWnlLm3uoozXxVPXXHFW7T79+2pmlRs9LQYACFK/rPoaxuPt37UX4xO
         k2wKwZIpmaumTdqvoFSw2NXVyHm9+MpQiKz06aL6/f1VI8Nmcq+6NprGapRr+pYTxc3U
         S1Hpfo3VY/qotkoCcQB0AhYwlU/yTG6TYrr4l9UIyxl2zINdNXqv90IDzs1LagChIluE
         /DjsacDW/fgKlnN1/cGhoYe+5aeh+rn1tZA7e9DhsK1qSkAzQjGnLt3/tJ82d7XeADwN
         h8PXm2T86rHH7v2u0CxM93ikNVNlmKftXgts4yRo8PGujF/el9ovuEF+AwnMbvJ9o/Qj
         7Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682625; x=1744287425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHtjp6fV8bfAv06r0KHl+YilzLbX3SHLECV51Mil514=;
        b=wopd3gp+R5N0tbQiUTc5JXjwoU5STe1/g2bfP9spgIo04QLQS6nYQ3F/nAs2n5chfN
         oCkiofioUB/JV9Lho6IFdplJqDKoqbeC/u2fs0HlIojzqz+kBAG9Sp/vJJs3prEEkE13
         gSq0J54etRJK2cma8gBdkJKJlVp0GBh+HCSmjKYlgUIKid8cSfHh4LWZ23vHr/erpnA6
         y7qnHr7UqfgGLl8niyV8FmGbEjl2nUH4SFtkAdqrsL2VBRrkg2JXCGxN55fNn6g3jwqt
         P0aIQXIIJu3nByLMb8BzwFH30/ZQlWrPyfXO83xvhHbqU2x02TC4DiLBDszbivArxSVE
         eblQ==
X-Gm-Message-State: AOJu0YxK9xW4n468GQijmlGiwqu7GYLbyfscNYt6GRMzQteXZ1C/O/Si
	nM4rusEtx8YIVoTEY3VPPHbokIEYP8xox4VWJA9qR6mlTWlIhP+j4kUFgF3X1U4=
X-Gm-Gg: ASbGncvhS8FKSECGocdOORmj8xy4X4gF9riiGKZvhNxqJulmqxyDpmNrfAY6VHc/PS5
	GK4Xj/qqEb+CcBQZTzdiqQ2d4ViMAO7eQ/G3lWsNkTuQczgVl690L2LwKyvnuAu0vy+l87EN6Nv
	BKI2UPB1bL1S5/mG6JIBfU+W5syKP3VHEBMVNq+LBB0ChFpDm4vBNoSY2ox1Sw/738JmK3sfG8Z
	wgDc83NRet4X+7Qj1Qfwy/SsubRAtB/gKRgCoQeZvE9JixYBjeionp5nb3EiOq2kpIyJFeRMAwz
	3Zqjtzq/IGPKuzIDEl7i8Okp3CqxIY7SLut2NUDvgBwBfvU=
X-Google-Smtp-Source: AGHT+IHHZ6MLKNY6Dc5eXJkq9LfhDUgkdKNpEmRRRyJxO3Y9fBBgNgTXRDCTRWZppELhIa1Exeu9lA==
X-Received: by 2002:a05:6000:40d9:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-39c297e42a2mr5819410f8f.38.1743682625285;
        Thu, 03 Apr 2025 05:17:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm1678962f8f.39.2025.04.03.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:17:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 14:17:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Message-ID: <s2omlhmorntg4bwjkmtbxhadeqfo667pbowzskdzbk3yxqdbfw@nvvw5bff6imc>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250401110508.GH25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401110508.GH25239@noisy.programming.kicks-ass.net>

On Tue, Apr 01, 2025 at 01:05:08PM +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> > By default RT groups are available as originally but the user can
> > pass rt_group_sched=0 kernel cmdline parameter that disables the
> > grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
> > runtime overhead).
> > 
> ...
> 
> Right, so at OSPM we had a proposal for a cgroup-v2 variant of all this
> that's based on deadline servers.

Interesting, are there any slides or recording available?

> And I am hoping we can eventually either fully deprecate the v1 thing
> or re-implement it sufficiently close without breaking the interface.

I converged to discourate rt_groups for these reasons:
1) They aren't RT guarantee for workloads
  - especially when it's possible to configure different periods
2) They aren't containment of RT tasks
  - RT task throttled in a group may hold a shared resource and thus its
    issues propagate to RT tasks in different groups
3) The allocation model [2] is difficult to configure
  - to honor delegation and reasonable default
  - illustration of another allocation model resource are cpuset cpus,
    whose abstraction in cgroup v2 is quite sophisticated

Based on that, I'm not proponent of any RT groups support in cgroup v2
(I'd need to see a use case where it could be justified). IIUC, the
deadline servers could help with 1).

> But this is purely about enabling cgroup-v1 usage, right?

Yes, users need to explicitly be on cgroup v1 (IOW they're stuck on v1
because of reliance on RT groups).

> You meantion some overhead of having this on, is that measured and in
> the patches?

I expect most would be affected RT task users who go from
!CONFIG_RT_GROUP_SCHED to CONFIG_RT_GROUP_SCHED and
CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED. That's my perception from code
that I touched but I haven't measured anything. Would this be
an interesting datum?

Thanks,
Michal

[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#allocations


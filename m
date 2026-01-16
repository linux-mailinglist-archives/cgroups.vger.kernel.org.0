Return-Path: <cgroups+bounces-13281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3DD310C2
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2AB304A991
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3D1A0712;
	Fri, 16 Jan 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fBLNSFYP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D75464F
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566349; cv=none; b=D7wQssEuwbssn6H0+w55RTPFNyz2610aWyFG0x30EBOxNBvEcCVMNpU2I/7J9VTCxLeQMfvUwiYTlawbgBlQvB2M+pjSDdw1+wQAzgON8H1g4kB3/HbTMyHjhRRBCOLof2+0AkiTsHPnK/Vbsb0IFUgf4P4kD3t49NCIIO+z5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566349; c=relaxed/simple;
	bh=PPWNtewcaTGQxA+W9r8qFBb5ixGwHAuKTx78M+3dO/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4zUMEniwKdAPYogW74D/Jn4IkJ/DPRrQ7ShX5p7D6LoZ27d/ZX+kTgefsuuTXye2DTpL7n3IevgT9F8sRfO+SabjOwHmuYA+ddtc4SeXq3ftNBQIuglBDWpLlMa5Vh+3CzEYseCnCFq4yszlNAyAV3lfe4cgBHDEE340rRlNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fBLNSFYP; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so1410018f8f.1
        for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 04:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768566346; x=1769171146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFQMY/xsDJvG31vX56byjsZOMI0xogP8BAsnuUmd/Ss=;
        b=fBLNSFYPP5P22u7zJHl3YHDHYIvvUMoc8CF11o2t0jCyLC7n5+5iy51cTbHiJgaVVs
         mpV9dz7d9lSWLdz0rHCvKpXJJvb41IXmP5AZCZ2sEapRcOiJGl8Fvjr/en7PqOSAh/NU
         4NNvfYqcz8PXv4RrNSWxxNvQaqh7mvp9AwbGCjkZ8Va9pXli5UchLM6tJj783Oqa92YP
         6F5Rr3m7LdlqDLbb8LTAeN19fDUALGAOqEXsWHMnlvWsdG6eqlncLtvPa2Eqzz09e9st
         Jme+EoV27IL5EhmtJawqqB2ApO9pvVE1JM+B6fOjzHDtZT/j5onsBQwdLLeEYkTf+9P/
         6nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768566346; x=1769171146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFQMY/xsDJvG31vX56byjsZOMI0xogP8BAsnuUmd/Ss=;
        b=QJ14Jvsrq4FI2pvXYYFZkH7u5OR7eSxpqMniNkDARxqYLzJTkm0EaFTYYIEF3q1+oO
         /aHRNONUItdNPR18QF/+iEFrAE8+NdURyUnh5bQpi3+pKkaJnrXuj+9hMHZGTrCv1vVZ
         gQP4/tGvbzKHLmgfxwsxJpr7KSA2vd9+5v6htK4TrGkT+yJuPydR4dd9CWGiaYLY7l2c
         GiX9o6PEpDhGEWwrojgta+Fm/QQHLHuZ1woIrbTk6WNCb9HKbLaScEo+CLR0W+ZvEyMQ
         5LnPRzfBwWJzIRzCn0b1Bez7z9WXuM1aKarEsEvFT5Nwoaqk1qhqzyYV26mfXIPmYL3J
         lZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVwtWcKgbT/lYmBNCNpDy5KeJGohc4D+dZUfYipJTJIRXe6xpo28+vETEEHBDeM2JGDI1lXijhB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02UFl5kEpwfmz7jjOD8zj1Bg5z0uBTZiHTUkyUShZSre6gLXu
	ZP4veZZbqsl0a7btdJPb4+zREHwRms7zIAn4wo6UYY9XOLbFsRJGUsrSqdsJ3PFSzY4=
X-Gm-Gg: AY/fxX5bDhaKIBQPA/nCQUgKBoguH7GXtYqk65FhnOtFg0sp1/8kAHEv4Vm0RFSeU2Y
	7hAVolFXFeAsznXV/PpzALgSbIdFThK0OSPC8ZLz6WVsAVwHZ1S+2TNXe7yEzUZPOwB46FhX/3/
	7+3F50OqJNJhFh5SLTatCM7XGf88bVB5MVY+R87+L3Bn07dS2bjKz8aYRdQ6xdhY2830eAdlZSM
	CG/0g1Lg6osgCaEWz16E9GmsqE9xbr6LsUApRQqpNaj2X273WtmujtpVd/l2x8V4F4UWfH1fxrE
	02VQoqkS44QPiGpFf6nS0M+ZcqWh8PYVxCiQnC+hPKkAGH2r6cGPcRRT0dsZCfpaxt5VvQMqc8Z
	jjJAKZMjjvxNnQXResOFJoj9YBCWuym4ua+zOHftnxw92Z4dDlLSKJlor/DxO0JXqR6X0ULPULJ
	XSRBRW6AgKXKTOsmYnLOlzc274
X-Received: by 2002:a5d:588d:0:b0:430:ff81:2965 with SMTP id ffacd0b85a97d-4356a060dc4mr3007686f8f.49.1768566345760;
        Fri, 16 Jan 2026 04:25:45 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e79asm5028682f8f.33.2026.01.16.04.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:25:45 -0800 (PST)
Date: Fri, 16 Jan 2026 13:25:43 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, ziy@nvidia.com,
	harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
	lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Message-ID: <aWouRwBftqNDz10t@tiehlicka>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
 <0a5af01f-2bb3-4dbe-8d16-f1b56f016dee@lucifer.local>
 <20260115164306.58a9a010de812e7ac649d952@linux-foundation.org>
 <fee37e75-e818-46b0-8494-684ef3eb5cd4@lucifer.local>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee37e75-e818-46b0-8494-684ef3eb5cd4@lucifer.local>

On Fri 16-01-26 08:33:44, Lorenzo Stoakes wrote:
> On Thu, Jan 15, 2026 at 04:43:06PM -0800, Andrew Morton wrote:
> > On Thu, 15 Jan 2026 12:40:12 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Wed, Jan 14, 2026 at 09:58:39AM -0800, Andrew Morton wrote:
> > > > On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> > > >
> > > > > This patchset is intended to transfer the LRU pages to the object cgroup
> > > > > without holding a reference to the original memory cgroup in order to
> > > > > address the issue of the dying memory cgroup.
> > > >
> > > > Thanks.  I'll add this to mm.git for testing.  A patchset of this
> > > > magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> > > > so let's see.
> > > >
> > > > I'll suppress the usual added-to-mm email spray.
> > >
> > > Since this is so large and we are late on in the cycle can I in this case
> > > can I explicitly ask for at least 1 sub-M tag on each commit before
> > > queueing for Linus please?
> >
> > Well, kinda.
> >
> > fs/buffer.c
> > fs/fs-writeback.c
> > include/linux/memcontrol.h
> > include/linux/mm_inline.h
> > include/linux/mmzone.h
> > include/linux/swap.h
> > include/trace/events/writeback.h
> > mm/compaction.c
> > mm/huge_memory.c
> > mm/memcontrol.c
> > mm/memcontrol-v1.c
> > mm/memcontrol-v1.h
> > mm/migrate.c
> > mm/mlock.c
> > mm/page_io.c
> > mm/percpu.c
> > mm/shrinker.c
> > mm/swap.c
> > mm/vmscan.c
> > mm/workingset.c
> > mm/zswap.c
> >
> > That's a lot of reviewers to round up!  And there are far worse cases -
> > MM patchsets are often splattered elsewhere.  We can't have MM
> > patchsets getting stalled because some video driver developer is on
> > leave or got laid off.  Not suggesting that you were really suggesting
> > that!
> 
> Yeah, obviously judgment needs to be applied in these situations - an 'M'
> implies community trusts sensible decisions, so since this is really about
> the cgroup behaviour, I'd say simply requiring at least 1 M per-patch from
> any of:
> 
> M:	Johannes Weiner <hannes@cmpxchg.org>
> M:	Michal Hocko <mhocko@kernel.org>
> M:	Roman Gushchin <roman.gushchin@linux.dev>
> M:	Shakeel Butt <shakeel.butt@linux.dev>
> 
> Suffices.

I have seen a good deal of review feedback from Johannes, Roman and
Shakeel (thx!). I have it on my todo list as well but the series is
really large and it is not that easy to find time to do the proper
review. Anyway, unlike before xmas when there was barely any review
and I asked to slow down I feel much more confident just by seeing acks
from others memcg maintainers.

That being said, if I fail to find proper time to review myself I am
fully confident to rely on other memcg maintainers here. So this should
not be blocked waiting for me.

Thanks!
-- 
Michal Hocko
SUSE Labs


Return-Path: <cgroups+bounces-9134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A386B24E64
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D0C9A48F6
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E86285C90;
	Wed, 13 Aug 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EprmuzHO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5F28507C;
	Wed, 13 Aug 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099913; cv=none; b=nEHpUtX82al6y1SGm5989pOD6Z8lfpfXBVFqM2nDiRFrgOlJ81FjO/v6oNdJk2AfoXMd5a/lv0uK7QGqctAjTRAr9HvgGFB7AkGcr7WCx3yV3X8G/ZQllQMTIrIFSrQjyieRYVma76tO+/PvuwKhj/+gMEu4Pb4NCBbsDcmB2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099913; c=relaxed/simple;
	bh=SsPDwhSTBJoReLg/9/YKJlevSdDByn1CpS92UikRLrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3N+o+Ap3cs8UbbL8p60IHXzEDn4DuxJNawAl0rZzOZnuITgpxLKQYx7BUGFHzoxmhZ6g+gVtu3nIzTDVJu/z8un8T0xBI9oPcgdSL3n7tRAHIo5sBNbh5cQ6ARmRibD4uMUj4YHHkRHirKRzgVQFMiFZfVHWveQdkpZ6y4a2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EprmuzHO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755099909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsPDwhSTBJoReLg/9/YKJlevSdDByn1CpS92UikRLrs=;
	b=EprmuzHOFgXR6T/Un4d8FyvdxlSvFwXlSh+XmMWLyARs9/QurDnM9B2l748u+jSFn+YVu5
	cGeYlgobVLC9l02O58aMzTZc3Sc8TbqTVd31gv7iOf2l5w06YraQo1dkybNq4ipvKctMRC
	XXUItOdleZVof38aYxrbhvgEPK93qX8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org,  LKML <linux-kernel@vger.kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Muchun Song <muchun.song@linux.dev>,  cgroups@vger.kernel.org,  Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
In-Reply-To: <87tt2b6zgs.ffs@tglx> (Thomas Gleixner's message of "Wed, 13 Aug
	2025 16:57:55 +0200")
References: <87tt2b6zgs.ffs@tglx>
Date: Wed, 13 Aug 2025 08:45:02 -0700
Message-ID: <87ectfgr9d.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Thomas Gleixner <tglx@linutronix.de> writes:

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

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!


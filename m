Return-Path: <cgroups+bounces-3741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948D93412A
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ADE1F24776
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E71822E1;
	Wed, 17 Jul 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OBTpYwvE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BA1E4B0
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235857; cv=none; b=txKMjxGpYHOocR6S9OoixWk+vsIx4GhOyLYWCGeD0+3/MsPkHHz84jcq1XuhZmRD7bt49AvJHQXMhWXBuTHPPkqrQHbVdurbxKsvXowJHlRMuhgJLjGmwaPSRvxIe3ydYwmSV9tZMcR558naDZicLPatE0AsT1XX3aAICGBhnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235857; c=relaxed/simple;
	bh=mrS2oiESaegLvEzkRpferI0fA006AnGF1b7o4wPWsKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibJ5Islcb3OqyXBUyh2AiQIByoMPX0t59k06t+dNlBB2c7rcyuTeyC0OHoWAh8CeFV1ykSp24Koy+jYA9eAcmiE6XWh1GP+G1vejKm7WTo8kpHrC++rGfR0NgZziyZQHHzrWf4wRoQ2MJXs2ioTQD/SEuuYzM796JkIX2RfpB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OBTpYwvE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447eb65d366so41967481cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721235853; x=1721840653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRUnGmde0gGroE3rQQ9XsC/MMS7y6d0VThMieKRFaBg=;
        b=OBTpYwvE9jJp03AZsY2Q1y1Mw2t99iLXjUYaoo6XXB/LLl8RdxsN1mJkVCmQarPV8O
         Fix4hym+0EHDcnTNn33iCKbb7mqGFFsN2sza+zJNQp+RrAbqSQM+eFrDLBY+MbiGXIv7
         oWJED627fIT6GUNAyRZLTN1vqik5qzqt8VJpJr9PyL6WGOjP5Cg6zdLe9p4Ss2+pnLqJ
         jNWfBIKlh4STUqx+c5pTArtiwvQ4KTImdYHDhQjpxOPxktvxFz8EmtraVkXmuN0jg+UD
         GRG9ybrmqNv9sKp7eBCVKfgSSz/k9UTY3VcOZbocwbE5V4kffX4Nmda6hzfm6JMwaG6y
         848w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235853; x=1721840653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRUnGmde0gGroE3rQQ9XsC/MMS7y6d0VThMieKRFaBg=;
        b=anmJ9vM3GxdeigQ17TqQ2jCEvHm7+AIe+jXPTkAO4DpXv/6iNNOlBE2RbwyQ/JeRMJ
         OLKXTZTthPYFnKlRQc5nJ20yKpl3W1OtqrznadNtStni4+RowDbkNAWlTeVglEuRl3NQ
         jDV4lWpW0WgbdPLtCZdtZfCrJK0012TCxZpJClmvHVdz7bheS2/HgmhU4x5Iii1ZFRAu
         JXzV1YUFcbbh4/a9lf8V5KrT5sj9/R5EQz2HRE/iCXrK9yM7C9YUcOXVliKqQu3RKHLp
         /rBdAeeuWwEv1chcJtRa32QREKMjgxD2Ho2pdpVRhUNql+Xrm5VvQAfpdvxsVVKiRtrf
         BMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbkjsHAiaOqNpjbj5dSMY5p8rFadprXZjFowRxD8Vg/P+ckUoxFYfKCvNVXS1hO3VPRhwQaMQZrCivBYRNVARLAkn6X7poYg==
X-Gm-Message-State: AOJu0Yz3KFc1nDyDMP37Q2DXc4h66ZJIa5rRdOWx8dhbcmlOpgdwff38
	yyjhBENVZ6FNeMAF6Pr1jGmVDi4hDorhqpW8lHkay8xQyUJpCOpdMuzGIdBLFCs=
X-Google-Smtp-Source: AGHT+IFWhIiuqTrPrLgEKk9yyoBUOyaQC4cIo3mPC9fwvmoBNcNRFbthBE/KZxwdgchUpEIo5TEs+A==
X-Received: by 2002:a05:6214:5198:b0:6b5:6a1:f89a with SMTP id 6a1803df08f44-6b78caf6152mr37393066d6.2.1721235853523;
        Wed, 17 Jul 2024 10:04:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c4f68f7sm143776d6.40.2024.07.17.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:04:13 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:04:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, David Finkel <davidf@vimeo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <20240717170408.GC1321673@cmpxchg.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpajW9BKCFcCCTr-@slm.duckdns.org>

On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> ...
> > > This behavior is particularly useful for work scheduling systems that
> > > need to track memory usage of worker processes/cgroups per-work-item.
> > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > opinions), these systems need to track the peak memory usage to compute
> > > system/container fullness when binpacking workitems.
> 
> Swap still has bad reps but there's nothing drastically worse about it than
> page cache. ie. If you're under memory pressure, you get thrashing one way
> or another. If there's no swap, the system is just memlocking anon memory
> even when they are a lot colder than page cache, so I'm skeptical that no
> swap + mostly anon + kernel OOM kills is a good strategy in general
> especially given that the system behavior is not very predictable under OOM
> conditions.
> 
> > As mentioned down the email thread, I consider usefulness of peak value
> > rather limited. It is misleading when memory is reclaimed. But
> > fundamentally I do not oppose to unifying the write behavior to reset
> > values.
> 
> The removal of resets was intentional. The problem was that it wasn't clear
> who owned those counters and there's no way of telling who reset what when.
> It was easy to accidentally end up with multiple entities that think they
> can get timed measurement by resetting.
> 
> So, in general, I don't think this is a great idea. There are shortcomings
> to how memory.peak behaves in that its meaningfulness quickly declines over
> time. This is expected and the rationale behind adding memory.peak, IIRC,
> was that it was difficult to tell the memory usage of a short-lived cgroup.
> 
> If we want to allow peak measurement of time periods, I wonder whether we
> could do something similar to pressure triggers - ie. let users register
> watchers so that each user can define their own watch periods. This is more
> involved but more useful and less error-inducing than adding reset to a
> single counter.
> 
> Johannes, what do you think?

I'm also not a fan of the ability to reset globally.

I seem to remember a scheme we discussed some time ago to do local
state tracking without having the overhead in the page counter
fastpath. The new data that needs to be tracked is a pc->local_peak
(in the page_counter) and an fd->peak (in the watcher's file state).

1. Usage peak is tracked in pc->watermark, and now also in pc->local_peak.

2. Somebody opens the memory.peak. Initialize fd->peak = -1.

3. If they write, set fd->peak = pc->local_peak = usage.

4. Usage grows.

5. They read(). A conventional reader has fd->peak == -1, so we return
   pc->watermark. If the fd has been written to, return max(fd->peak, pc->local_peak).

6. Usage drops.

7. New watcher opens and writes. Bring up all existing watchers'
   fd->peak (that aren't -1) to pc->local_peak *iff* latter is bigger.
   Then set the new fd->peak = pc->local_peak = current usage as in 3.

8. See 5. again for read() from each watcher.

This way all fd's can arbitrarily start tracking new local peaks with
write(). The operation in the charging fast path is cheap. The write()
is O(existing_watchers), which seems reasonable. It's fully backward
compatible with conventional open() + read() users.


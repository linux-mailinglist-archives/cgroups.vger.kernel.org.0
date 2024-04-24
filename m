Return-Path: <cgroups+bounces-2695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C48B0AAC
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 15:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490D62837E7
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462AA15B973;
	Wed, 24 Apr 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="EULqXNl7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AC2AEFB
	for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964764; cv=none; b=q5xf3ONdoadJlb+r1a1Egz2+tJnI2uyZxHnJgBGB09pCXEX62QWwKLPQ3Qe7u/A9F3Vd3Ea2OezwqdN5xqxNDcbGjfjpLrufME5LRA94DIgnNnbY9N9RQNdPpxMpz1+gzvx0brg3msgX2uoQbeOSAlwhCKgR4C09JsVEDtg4GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964764; c=relaxed/simple;
	bh=eWDgcUPoqiHy04toIRDjF+zURyREPsGTrP5YsYJgcwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpVX6lkWOfqUJqsfS0tY6kPGIhw0xWC4CvW41MzDulha0PAOk1+NLaJS0YjU8y+cc27LxUWKbfoSPpvHJIeUJzimHiS11HzlAIlstt4MNyTh0XYFWirU/JxBlc6PQkbsOsfO/AtPR+zkbkFmEtrqz0qIRq5XRygnc7GkjIAtXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=EULqXNl7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f049ddd7dso505399585a.1
        for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713964759; x=1714569559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzkq09b2+VRg5r2hzH+VShVRDqHUAWf8E5efl7fvk7w=;
        b=EULqXNl7siYpv3gW8S3krA4vhPOfm6iSjsVn3vOU+BIWVDq2YIIHdQcdAijDBs48rV
         Oj1HY5ouU80qtG7hYn6CXBYcBce8TvjnFPTFHHCGi7FrsoUzbhVmtZURkz5ezDlL2W1G
         frROq6TEdTZlLmqQdww5EozJTzqe7tnOhK4m+pgSLNmCtisdpwFg5Ty0IWFO8/paqy1N
         I9vMPdyTdXvlpqXpyEq3QvZd1i47A4WsbSQ36mw6nkjNWl/AQW47I+dLlUuBc/jYBgnx
         U42sRvUdm1/+otk52Od89WUsInKo+bYuigMiSLIkEw1dU09l5oVWWQdo95VE24Z38Z/S
         xX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964759; x=1714569559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzkq09b2+VRg5r2hzH+VShVRDqHUAWf8E5efl7fvk7w=;
        b=vyM5+lVUqV+U0E4AEbc7OV2cCoWtU3Ov4mpXrugRFhQq9hzo0yF+nkOcAMwHmDbPHO
         30aQtnfY9ARpT2wc2cBhbhIKUphFbDGCps+fqCP096mAMIbPbgWxxHJxcaWTJVybT57R
         h3EXgHxE3tVcb5DI/LCmfFRcxbHUZrUlDh/RnZ7vTH12EtPbnu8oK7aBb3TioVTPyZ22
         tPrezYeSMVa8ezwzodi3BWG6UDL0WyTkNqFFypJ6g++kvoNC04Gpf1yhzVSdOELktbEw
         paw0jNlQHliSq+o3g4ljrl2sTn0iT1OvpzNo5O0kR+zlaqpI2ZJSLpKEUM8D2yoAcPmF
         6G5w==
X-Forwarded-Encrypted: i=1; AJvYcCXf/RCBud3oJgYumrUYYP2izW0yIAQ+cqgbX4Y4DIrupvY7zSumzK16EQF5nEO3TdU2sHgDFRD8n8aQ7geyB5x8ZWo8/+o/cg==
X-Gm-Message-State: AOJu0Yx72+YHm8HUrtFMcnbXZCIEbzkYfH6kk0hkYxs+onSvFJHrannc
	a5Rkh9rT0GCzKur5VAdN68c1X/dw7kLYsgM+0UcEPJrAizoWX6QIdKM838O9K+k=
X-Google-Smtp-Source: AGHT+IH7H4ZWxUHyX1qfEJXytrGSqajq5xSCmpXOA1RCBI5MLyT6vOp7AiPOzrOjdTPPLd4rKssRww==
X-Received: by 2002:a05:620a:8222:b0:790:652a:f419 with SMTP id ow34-20020a05620a822200b00790652af419mr2528675qkn.41.1713964759520;
        Wed, 24 Apr 2024 06:19:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9cfb])
        by smtp.gmail.com with ESMTPSA id u24-20020a05620a023800b0078f12e42f0csm5747909qkm.20.2024.04.24.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:19:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:19:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Breno Leitao <leitao@debian.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, leit@meta.com,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
Message-ID: <20240424131918.GC318022@cmpxchg.org>
References: <20240424125940.2410718-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424125940.2410718-1-leitao@debian.org>

On Wed, Apr 24, 2024 at 05:59:39AM -0700, Breno Leitao wrote:
> A data-race issue in memcg rstat occurs when two distinct code paths
> access the same 4-byte region concurrently. KCSAN detection triggers the
> following BUG as a result.
> 
> 	BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rstat_flush
> 
> 	write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
> 	mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
> 	cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminator 7))
> 	cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/rstat.c:278)
> 	mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
> 	memory_numa_stat_show (mm/memcontrol.c:6911)
> <snip>
> 
> 	read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
> 	__count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
> 	count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./include/linux/memcontrol.h:1120)
> 	handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
> <snip>
> 
> 	value changed: 0x00000029 -> 0x00000000
> 
> The race occurs because two code paths access the same "stats_updates"
> location. Although "stats_updates" is a per-CPU variable, it is remotely
> accessed by another CPU at
> cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> the data race mentioned.
> 
> Considering that memcg_rstat_updated() is in the hot code path, adding
> a lock to protect it may not be desirable, especially since this
> variable pertains solely to statistics.
> 
> Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
> can prevent KCSAN splats and potential partial reads/writes.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


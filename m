Return-Path: <cgroups+bounces-2919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB618C6B1F
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298001F243A5
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF938F97;
	Wed, 15 May 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RobFTo1s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF084D03;
	Wed, 15 May 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792299; cv=none; b=SUTNe9bez+GchVk3FqbyGnv9SCIg8A2azkvL+MP1dTFLaY+K44dYwaKwoV12NHJuYh20rr1WFDcNUkjchlIcZhgrXlOB+JjGE27wQj1oMW0ROAYxYlwtV3jDktMwsLBNLs3HslFQUUrKpxIL5lhcQ2rZpnA5906PIlPygWcfx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792299; c=relaxed/simple;
	bh=ShbHlmZ5HSYMg7vUemRsJ6CUyHdN2PXIXd0r1VRWU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1+287dufM+L9wzIFJ0PN6rA8Ig6uVejsSrEqt6Z3AECCnEh7sD8LJKK/YAt9sAFMkb089oZS0+2u4C7WJVqIpRD2nER1Z/Tr/9a1yppaFEWZaWiZjrrgWTHIjIgT7hKzWO6qvxiQS4a3r2fqW5OvbR2soszPKBQmlEvN6GJ7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RobFTo1s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eecc71311eso59363695ad.3;
        Wed, 15 May 2024 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792297; x=1716397097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jshxQ4zKsW5Ka5jjJJJHS/DYAFWEr1OvskuDDmMdj64=;
        b=RobFTo1sNa1WhUss7//7KaomdbKhoclY6C/HKFhLr248DrrCv0JCN7FMyvApt+t7Ka
         kYwnBDCfMc+xbhOZV47GtamXGQNov0dE4lkisH0Y+xt867LhAQ461/n7+CC3pNCwG0It
         8GBTGmV/Y25huZbdQX+qt0n1nbLzTT2TMJ1nkl0O4C0mq7ELd8mF85j6ND/HTl6GHQOh
         wdS0O0HclEMpiOKUOm9S79Qq90stKvc5fQjIXx20JMrkeJwH2zmiJ4XILzye7CTu53iD
         G/QizNtP6KAIEiaR/TAqmKCKh/pfgMdc/Rjf9B3/H2WbjoQRbTqlQudAr8TLUcU6XF8L
         kRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792297; x=1716397097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jshxQ4zKsW5Ka5jjJJJHS/DYAFWEr1OvskuDDmMdj64=;
        b=bhnM3JFWjpfE1O2LxTdrT9Y4Vv5yWD5ioHl0Lfoy/8BUvDTUyBxV44YcjQBAXf0j2t
         y8oSlKwPcU2kz4LGU/m4G76LiuX5WK+tZyAD2Ipl1zB7VHvYIf35JAq87AV/O4WQUvdc
         T8RKaTXcx8a1NnTwAOyTHauEWFNSAGd0Bw1UorQjS9y7ustHAoOFgQ/NGe277WOdiIzk
         leOnO6j57uHwU0v1113XnUefb8B4VRLJU8kUOd76FMa+T6txxhovjnB4ncdo4OjI089b
         vNMmr3zikUUhRwS1R19sPwlraF/YFFommDaWo9oZcDnp7oqpvZ8ziMked698qlTS0H/6
         yTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKPq3W++SSJNuiEF6JwgvDcMbriqNcOBSKlTlznWmIyG3J7DIPR92Bxl73+/aJ4SGmC3aL3oIcMm4+aakUd7JuSNnoW/Ioh0Nk0bkvTOPlwYtC0sT6XcwJwUo3PFHdyQ==
X-Gm-Message-State: AOJu0Yx2mOcUrZ4bqDGrekyqJ+01JCaRROqAx43TB2SjXf9X917Wvj4g
	NtJqdydfrj21o8+37TfzXiyosSqrgT+rKz7ajiz3Ew9n2D1Vxf1t
X-Google-Smtp-Source: AGHT+IG5wszVZqanvB9HgaZHryt+doBbEuUEmVA2UhF/VUutBbI6rJ319TrdzyCrZZK/ucZyFKPcYw==
X-Received: by 2002:a17:903:2311:b0:1e3:c327:35c0 with SMTP id d9443c01a7336-1ef43c095c2mr245697405ad.2.1715792296999;
        Wed, 15 May 2024 09:58:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcae8sm120624315ad.103.2024.05.15.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:58:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 06:58:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
	yosryahmed@google.com, longman@redhat.com, netdev@vger.kernel.org,
	linux-mm@kvack.org, shakeel.butt@linux.dev,
	kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <ZkTpn3gxDdPlcDFk@slm.duckdns.org>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171457225108.4159924.12821205549807669839.stgit@firesoul>

On Wed, May 01, 2024 at 04:04:11PM +0200, Jesper Dangaard Brouer wrote:
> This closely resembles helpers added for the global cgroup_rstat_lock in
> commit fc29e04ae1ad ("cgroup/rstat: add cgroup_rstat_lock helpers and
> tracepoints"). This is for the per CPU lock cgroup_rstat_cpu_lock.
> 
> Based on production workloads, we observe the fast-path "update" function
> cgroup_rstat_updated() is invoked around 3 million times per sec, while the
> "flush" function cgroup_rstat_flush_locked(), walking each possible CPU,
> can see periodic spikes of 700 invocations/sec.
> 
> For this reason, the tracepoints are split into normal and fastpath
> versions for this per-CPU lock. Making it feasible for production to
> continuously monitor the non-fastpath tracepoint to detect lock contention
> issues. The reason for monitoring is that lock disables IRQs which can
> disturb e.g. softirq processing on the local CPUs involved. When the
> global cgroup_rstat_lock stops disabling IRQs (e.g converted to a mutex),
> this per CPU lock becomes the next bottleneck that can introduce latency
> variations.
> 
> A practical bpftrace script for monitoring contention latency:
> 
>  bpftrace -e '
>    tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>      @start[tid]=nsecs; @cnt[probe]=count()}
>    tracepoint:cgroup:cgroup_rstat_cpu_locked {
>      if (args->contended) {
>        @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}
>      @cnt[probe]=count()}
>    interval:s:1 {time("%H:%M:%S "); print(@wait_ns); print(@cnt); clear(@cnt);}'
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun


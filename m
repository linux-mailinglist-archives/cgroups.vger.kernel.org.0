Return-Path: <cgroups+bounces-3737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC0934081
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD121F243F2
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE0181CE0;
	Wed, 17 Jul 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcILhm9T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A76FB9
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233950; cv=none; b=Jk0OOmCl0o1UPqvrMcs4LpPueTkcyd1DR0pubtUC37rEj3RUJHLIqV4n32pdAF0T80xIppmPg+/rBHKBz2NfzXWcDtT8n5qP8In+FIE5sMKAzSQt6NEfOqanKuTMAFqybrubtcNhBj/mUvvFwo87aXemnhyv2bRDmxEy6x54NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233950; c=relaxed/simple;
	bh=NtEQHw6icc+eZOOGYuBEMREz5cq3XA+8Vsjrg/wANXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOsiVEkcWPqubC9e+uNptLOn9wGIIeg4B11APw0EISLK1ZSgtmhCg3hGz+XScthnq6Tsn2rol/7Jcau05BNe/CSDQnzQCzcJzQiqewyRZRT09OwR/fh+5OUKM8mvjIwK+QD6fMQS2+FFI2yCQO7Ka8ylcnnYrBDtdqPpTbU+O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcILhm9T; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so1900791a12.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721233947; x=1721838747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8xVRfMJ7abYq0IMMhEbnwpXyZd3kKKex3fs0rUVCOA=;
        b=dcILhm9TGFdkXGjdq50vUMbAiNHriBhWgZixBDXvv1fafwROoDwomGgyOMDCJQhrhX
         cRlCy0VrvQUgewoGFceQ4ZwXDd/945oRxh2Y5FgLpaB6Y9yFR4cYxlf7T4HRCluJDgDt
         wjpp4/dt3nI93np0ZkhlnsoF3WNDhVURQIbgAEMViBgV0JxP3zS4eU29bGFFa6AmfjnT
         UYVGj9OCb0/sJIzKstvw8ClEYMDvWWN5bgihVhSKoZ9NLSgLT4Ekqr1GFfQJPc9xq2cY
         F/Ezt9KWp3tNUOLyCyu+NQWAtAP7AkylLRk8qu9YZ6GvJq+m3+kxCsIorfmQfxabV6Db
         aJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233947; x=1721838747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8xVRfMJ7abYq0IMMhEbnwpXyZd3kKKex3fs0rUVCOA=;
        b=Tpr2huks7GcGS8tHF5ZE5EQ2cdrQzapfjp+WpB/k6p+4rbfDgOxKAjPwLvKUcym+bD
         ZunaACR9Bw+MDYkVAXD7dPhnF7aLEOWmpNcYbF8j4ERraIqEyfPXVz5plozItmSDAfhQ
         veNKmaFWDQOXyg3tOGHXCyy71Yc0HlTbTW+XmA6IsROX4VUxpIdK9VvVKw/x+4vkztTz
         6y1qXuAV2G0UafG7yt1EGT3ZHtcEQ6o6EHocEEBr7KXKP+EAWKN4wRMPYDLHbjgTZ7F2
         fu+g1DEzsENgZH0GGEY+agXnPXi6vvd2qVikpC4/f7l3z8I3jopQMjbPHQQEx21r+oti
         KH0w==
X-Forwarded-Encrypted: i=1; AJvYcCXXw4FvFtP9MY11FS9Wu3zRnrRCPgWLeKi110ful49W4Ru78HtRIx/GxhEw5LBGZC/vouSH5dIYySB07Uokcqdy7n9qPHLzSQ==
X-Gm-Message-State: AOJu0Yzw48VdKnc7YESvdI04271TegKJLTqa+UN7ALB+KTlibthD8hvi
	32UjAeIn/nbQsnZBEhLpuazaHBcRtjPFKhxLOJXuajPJ7Wsss8KT5fOIxT9HQYVM3tlazInqJr+
	TZwFyzqtr3bcVR4ICqFLvDyJVOxzQgBww66J70s2e1KZnCtq3lA==
X-Google-Smtp-Source: AGHT+IHG5R+9vUC0pxg3o2S6hutLWKPft4fiUKe+vWmBY5Soqw+9Q4/c+7zXX5r5yN16r1FkY4xe/DpCTZx2CcRMxrk=
X-Received: by 2002:a17:906:c0c7:b0:a77:cc93:ae02 with SMTP id
 a640c23a62f3a-a7a0f75e206mr15786166b.28.1721233946078; Wed, 17 Jul 2024
 09:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com> <8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org>
In-Reply-To: <8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:31:48 -0700
Message-ID: <CAJD7tkbFPt-eTHkqtLxuOoV59eaqauodz008btEECT--x3VcBA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
> I agree that description should be updated as patch have evolved, and
> you suggestions make sense, thanks.
>
> But I'm not sure we are finished evolving this patch, because the scheme
> of allowing all sub-cgroups to become the ongoing flusher (and only
> avoiding lock-spinning when cgroup_is_descendant), is causing issues in
> production.

Sure, I just wanted to point out the the commit log should be updated
going forward, not implying that we are done here :)

>
> We are using cadvisor in production for collecting metrics, which walks
> all the cgroups reading stat files e.g. io.stat, cpu.stat , memory.stat
> (doing 3 flushes of same cgroup in short timespan), but individual
> cgroups don't overlap much to benefit from ongoing_flusher scheme.
>
> Below is (1 sec) production data, where cadvisor and kswapd collide:
>
>  > 02:01:33 @ongoing_flusher_cnt[kworker/u395:14]: 1
>  > @ongoing_flusher_cnt[kswapd5]: 3
>  > @ongoing_flusher_cnt[kswapd7]: 4
>  > @ongoing_flusher_cnt[kswapd6]: 4
>  > @ongoing_flusher_cnt[kswapd8]: 4
>  > @ongoing_flusher_cnt[kswapd9]: 5
>  > @ongoing_flusher_cnt[kswapd2]: 5
>  > @ongoing_flusher_cnt[kswapd10]: 5
>  > @ongoing_flusher_cnt[kswapd3]: 5
>  > @ongoing_flusher_cnt[kswapd11]: 5
>  > @ongoing_flusher_cnt[kswapd0]: 5
>  > @ongoing_flusher_cnt[kswapd4]: 6
>  > @ongoing_flusher_cnt[kswapd1]: 7
>  > @ongoing_flusher_cnt[cadvisor]: 9
>
> For cadvisor ongoing_flusher only helps 9 times to avoid flush.
>
>  > @ongoing_flusher_cnt[handled_race]: 18
>  > @ongoing_flusher_cnt[all]: 61
>
> Our ongoing_flusher scheme detects overlap and avoid 61 out of 462 flushes.
>
>  > @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 61
>  > @cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 462
>  > @cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 9032
>
> This is bad: Lock is contended 9032 time within this 1 sec period.
> Below, lock_contended cases is captured in more detail.
>
>  > @cnt[tracepoint:cgroup:cgroup_rstat_locked]: 9435
>  > @lock_contended[normal, 4]: 1
>  > @lock_contended[normal, 1]: 2
>  > @lock_contended[normal, 3]: 6
>  > @lock_contended[normal, 2]: 15
>  > @lock_contended[yield, 4]: 49
>  > @lock_contended[after_obtaining_lock, 4]: 49
>  > @lock_contended[normal, 0]: 59
>
> The "normal" lock_contended for level 0,
> meaning the cgroup root is contended 59 times within this 1 sec period.
>
>  > @lock_contended[after_obtaining_lock, 1]: 117
>  > @lock_contended[yield, 1]: 118
>  > @lock_contended[yield, 3]: 258
>  > @lock_contended[after_obtaining_lock, 3]: 258
>  > @lock_contended[after_obtaining_lock, 2]: 946
>  > @lock_contended[yield, 2]: 946
>
> Lock contention for 'yielded' case for level 2.
> Goes crazy with 946/sec.
>
>  > @lock_contended[yield, 0]: 7579
>
> Lock contention for 'yielded' case for level 0, the root.
> Is really crazy with 7579/sec lock spin cases.
>
>  > @lock_contended[after_obtaining_lock, 0]: 7579
>
>
> IMHO this shows that, due to lock yielding, the scheme of
> ongoing_flusher for sub-trees only cause issues.

Just to make sure I understand correctly, allowing non-root to become
ongoing_flushers is problematic because we only support a single
ongoing_flusher, so if we have a subsequent root flush, it won't be
the ongoing_flusher and we won't benefit from skipping other flushes.
Correct?

I honestly think the problem here is not that we support
ongoing_flusher for subtrees, which imo is nice to have at a low
additional cost, and does have its benefits (see below). I think the
problem is that lock yielding means that we can have multiple ongoing
flushers, while the current scheme only records one.

What I think we should be doing is either supporting multiple
ongoing_flushers (by replacing the global variable with a per-cgroup
flag, perhaps), or biting the bullet and start using a mutex to drop
lock yielding. If there aren't any concerns beyond priority inversion
(raised by Shakeel), maybe adding a mutex_lock_timeout() variant as I
suggested could fix this issue (and also put a bound on the flushing
latency in general)?

(I suppose the latter is preferrable)

>
> IMHO we should go back to only doing ongoing_flusher for root-cgroup.
> There is really low chance of sub-trees flushes being concurrent enough
> to benefit from this, and it cause issues and needs (ugly) race handling.
>
> Further more sub-tree flushing doesn't take as long time as level 0
> flushing, which further lower the chance of concurrent flushes.

I agree that the race handling is not pretty, and we can try to
improve the implementation or handle the race in other ways. However,
I think that skipping flushes for subtrees is valuable. I am not sure
about the cgroup arrangement in your use case, but we do have cgroups
with a lot of tasks in them (and/or child cgroups). If there is memory
pressure (or hit the cgroup limit), they all may go into direct
reclaim concurrently, so skipping flushes could really be beneficial.

Of course, if the difference in complexity is not justified, we can go
back to only supporting root cgroups for ongoing_flusher for now. But
as I mentioned in the v4 email thread, some of the complexity may
still remain anyway as we have multiple root cgroups in v1.

>
> Let's get some quick data on flush times from production, to support my
> claim:

Thanks for the data. I agree that in general root flushes will be a
lot more expensive than subtree flushes, but keep in mind that the
data may look really different depends on the cgroup setup. As I
mentioned, I think we should still support subtree flushes unless the
difference in complexity is not justified.

>
> The bpftrace onliner:
>   sudo bpftrace -e '
>    tracepoint:cgroup:cgroup_rstat_locked {
>     if (args->cpu == -1) { @start[tid]=nsecs; }
>     @cnt[probe]=count();
>     if (args->contended) {
>       @lock_contended["after_obtaining_lock", args->level]=count();
>     }}
>    tracepoint:cgroup:cgroup_rstat_unlock {
>     if (args->cpu == -1) {
>      $now=nsecs; $start=@start[tid]; $diff=$now-$start;
>      @locked_time_level[args->level]=hist($diff);
>     }
>     @cnt[probe]=count()}
>    kfunc:cgroup_rstat_flush_locked {@cnt[probe]=count()}
>    interval:s:1 {time("%H:%M:%S ");
>     print(@cnt);
>     print(@lock_contended);
>     print(@locked_time_level);
>     clear (@cnt);
>     clear (@lock_contended); }
>    END {clear(@start)}'
>
> Time below is in nanosec.
>
> @locked_time_level[0]:
> [4M, 8M)             623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>       |
> [8M, 16M)            860
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16M, 32M)           295 |@@@@@@@@@@@@@@@@@
>       |
> [32M, 64M)           275 |@@@@@@@@@@@@@@@@
>       |
>
>
> @locked_time_level[1]:
> [4K, 8K)               6 |@@@@
>       |
> [8K, 16K)             65
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16K, 32K)            52 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>       |
> [32K, 64K)            23 |@@@@@@@@@@@@@@@@@@
>       |
> [64K, 128K)           15 |@@@@@@@@@@@@
>       |
> [128K, 256K)          10 |@@@@@@@@
>       |
> [256K, 512K)           6 |@@@@
>       |
> [512K, 1M)            15 |@@@@@@@@@@@@
>       |
> [1M, 2M)               2 |@
>       |
> [2M, 4M)              14 |@@@@@@@@@@@
>       |
> [4M, 8M)               6 |@@@@
>       |
> [8M, 16M)              7 |@@@@@
>       |
> [16M, 32M)             1 |
>       |
>
>
> @locked_time_level[2]:
> [2K, 4K)               1 |
>       |
> [4K, 8K)             160 |@@@@@@@@@
>       |
> [8K, 16K)            733 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>       |
> [16K, 32K)           901
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)           191 |@@@@@@@@@@@
>       |
> [64K, 128K)          115 |@@@@@@
>       |
> [128K, 256K)          61 |@@@
>       |
> [256K, 512K)          70 |@@@@
>       |
> [512K, 1M)            59 |@@@
>       |
> [1M, 2M)              27 |@
>       |
> [2M, 4M)               9 |
>       |
>
>
> @locked_time_level[3]:
> [1K, 2K)               3 |
>       |
> [2K, 4K)               2 |
>       |
> [4K, 8K)               5 |
>       |
> [8K, 16K)            147 |@@@@@@
>       |
> [16K, 32K)          1222
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)           266 |@@@@@@@@@@@
>       |
> [64K, 128K)          199 |@@@@@@@@
>       |
> [128K, 256K)         146 |@@@@@@
>       |
> [256K, 512K)         124 |@@@@@
>       |
> [512K, 1M)            17 |
>       |
> [1M, 2M)               0 |
>       |
> [2M, 4M)               0 |
>       |
> [4M, 8M)               1 |
>       |
>
>
> @locked_time_level[4]:
> [4K, 8K)               2 |@@
>       |
> [8K, 16K)             17 |@@@@@@@@@@@@@@@@@@@@@@
>       |
> [16K, 32K)            40
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)             4 |@@@@@
>       |
>
> --Jesper
>


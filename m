Return-Path: <cgroups+bounces-13845-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG45HQmqi2naYAAAu9opvQ
	(envelope-from <cgroups+bounces-13845-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:58:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE011F92A
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20AD301FA7E
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 21:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6E3396E8;
	Tue, 10 Feb 2026 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3i2aU7F"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0F259C80
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760703; cv=none; b=UcHTDyHGfZ35WHP2vKcitsgLt4nxCxRgIsmYElXCYsQSSEv+ORllM0fLHfDAhc29AQD423DVqS4/bOJHJrZqganp8aYs+NOGgODfe58vcgGNfNC2zjoghs/zPuaV9SJZtWPZiGvCLc8kpT2qm5+qNrGgsP8JJ8eOJomFxnEeZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760703; c=relaxed/simple;
	bh=kVJ6XcSUnONVU4r8iohiHnKpwX95hZhZLfY6S9oR5xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1GkQg3mZamwMhKftwZfmWfjb11h17A9SBSoUMAFr5sHdpFYiMWbiEjSCP+U8lSX3ikEL4lVwvo1lUDRD5NQGNoS0zF8EUBFb67FlTNWmwI7yVnn3EbUuaHjqFrO+UvTjwkJ46NDty8Nb09heB1e4pyhPmGnM2ljO0lYN2v+Qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3i2aU7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD722C2BCB2
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770760702;
	bh=kVJ6XcSUnONVU4r8iohiHnKpwX95hZhZLfY6S9oR5xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G3i2aU7FI8NNF5RHybxam+ogLLyV02NodIv7ib+AWDQaDvfRzP+KfMi78YxcdJ7TW
	 PVxHFiIotQN3IZu3Yvh6EnfDAyOjiK7LcSGL3JkBeD9dCg7vZ3SWodyqbyem84fWga
	 DFgzyvEAs8oI3jJSEnOmPraU7EUcQgwGXEXEHHZ1yogq0bJE/k+gW84ORuwtfSICpF
	 as0zNw9T2QWlM9pqzJcBrPqieXx5HPEUZRec8oivys6HttthsDUqLmkcsYsKX/DNHc
	 5srL+l4tSrLDusgXPiALbqhSR1XF/6QtG1cK9Av7rRW5J7ZFTL9oLHmrk+5yRP0rCd
	 /E3R3jSQ0s0yQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-794fe16d032so12628717b3.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 13:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl9zNqJYUiDSI430VItvZUJzkeKFXmhDZiFUfnW0Ek09eFbEIdXpM6Bk7yNJqsOjB5czZYwC3c@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDNqXFMb6yfJmGKdFsrJX3czCflz2QPYK4agB9dEyifl9qBZU
	1cITkzW2rKd2V/4MwG4HRwHrhepErdbS9am/7mFzdCFg1/J1wCJXvB4MqjS4sXEw2liy5SJcklU
	ybD4cvPROCOL2C5cFGYbayMJilvHkZLAqOy3fC/yl6g==
X-Received: by 2002:a05:690c:ed3:b0:796:6784:82b4 with SMTP id
 00721157ae682-796678495b2mr18676517b3.34.1770760701457; Tue, 10 Feb 2026
 13:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
In-Reply-To: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 10 Feb 2026 13:58:10 -0800
X-Gmail-Original-Message-ID: <CACePvbVvzh8PcF47hz+MfFu3tta5vh3oD+WpGxEL_-NrzYZG3Q@mail.gmail.com>
X-Gm-Features: AZwV_QjzZlZPdFukwQ_AOOUFYaZQ7FMxvqqOugUDpx3sUwElLkc_lztl4KQkhkM
Message-ID: <CACePvbVvzh8PcF47hz+MfFu3tta5vh3oD+WpGxEL_-NrzYZG3Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, len.brown@intel.com, chengming.zhou@linux.dev, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13845-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D2DE011F92A
X-Rspamd-Action: no action

Hi Kairui,

Thank you so much for the performance test.

I will only comment on the performance number in this sub email thread.

On Tue, Feb 10, 2026 at 10:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> Actually this worst case is a very common case... see below.
>
> > 0% usage, or 0 entries: 0.00 MB
> > * Old design total overhead: 25.00 MB
> > * Vswap total overhead: 2.00 MB
> >
> > 25% usage, or 2,097,152 entries:
> > * Old design total overhead: 41.00 MB
> > * Vswap total overhead: 66.25 MB
> >
> > 50% usage, or 4,194,304 entries:
> > * Old design total overhead: 57.00 MB
> > * Vswap total overhead: 130.50 MB
> >
> > 75% usage, or 6,291,456 entries:
> > * Old design total overhead: 73.00 MB
> > * Vswap total overhead: 194.75 MB
> >
> > 100% usage, or 8,388,608 entries:
> > * Old design total overhead: 89.00 MB
> > * Vswap total overhead: 259.00 MB
> >
> > The added overhead is 170MB, which is 0.5% of the total swapfile size,
> > again in the worst case when we have a sizing oracle.
>
> Hmm.. With the swap table we will have a stable 8 bytes per slot in
> all cases, in current mm-stable we use 11 bytes (8 bytes dyn and 3
> bytes static), and in the posted p3 we already get 10 bytes (8 bytes
> dyn and 2 bytes static). P4 or follow up was already demonstrated
> last year with working code, and it makes everything dynamic
> (8 bytes fully dyn, I'll rebase and send that once p3 is merged).
>
> So with mm-stable and follow up, for 32G swap device:
>
> 0% usage, or 0/8,388,608 entries: 0.00 MB
> * mm-stable total overhead: 25.50 MB (which is swap table p2)
> * swap-table p3 overhead: 17.50 MB
> * swap-table p4 overhead: 0.50 MB
> * Vswap total overhead: 2.00 MB
>
> 100% usage, or 8,388,608/8,388,608 entries:
> * mm-stable total overhead: 89.5 MB (which is swap table p2)
> * swap-table p3 overhead: 81.5 MB
> * swap-table p4 overhead: 64.5 MB
> * Vswap total overhead: 259.00 MB
>
> That 3 - 4 times more memory usage, quite a trade off. With a

Agree. That has been my main complaint about VS is the per swap entry
metadata overhead. This VS series reverted the swap table, but memory
and CPU performance is worse than swap table.

> 128G device, which is not something rare, it would be 1G of memory.
> Swap table p3 / p4 is about 320M / 256M, and we do have a way to cut
> that down close to be <1 byte or 3 byte per page with swap table
> compaction, which was discussed in LSFMM last year, or even 1 bit
> which was once suggested by Baolin, that would make it much smaller
> down to <24MB (This is just an idea for now, but the compaction is
> very doable as we already have "LRU"s for swap clusters in swap
> allocator).
>
> I don't think it looks good as a mandatory overhead. We do have a huge
> user base of swap over many different kinds of devices, it was not
> long ago two new kernel bugzilla issue  or bug reported was sent to
> the maillist about swap over disk, and I'm still trying to investigate
> one of them which seems to be actually a page LRU issue and not swap
> problem..  OK a little off topic, anyway, I'm not saying that we don't
> want more features, as I mentioned above, it would be better if this
> can be optional and minimal. See more test info below.
>
> > We actually see a slight improvement in systime (by 1.5%) :) This is
> > likely because we no longer have to perform swap charging for zswap
> > entries, and virtual swap allocator is simpler than that of physical
> > swap.
>
> Congrats! Yeah, I guess that's because vswap has a smaller lock scope
> than zswap with a reduced callpath?

Whole series is too much zswap centric and punishes other swaps.

>
> >
> > Using SSD swap as the backend:
> >
> > Baseline:
> > real: mean: 200.3s, stdev: 2.33s
> > sys: mean: 489.88s, stdev: 9.62s
> >
> > Vswap:
> > real: mean: 201.47s, stdev: 2.98s
> > sys: mean: 487.36s, stdev: 5.53s
> >
> > The performance is neck-to-neck.
>
> Thanks for the bench, but please also test with global pressure too.
> One mistake I made when working on the prototype of swap tables was
> only focusing on cgroup memory pressure, which is really not how
> everyone uses Linux, and that's why I reworked it for a long time to
> tweak the RCU allocation / freeing of swap table pages so there won't
> be any regression even for lowend and global pressure. That's kind of
> critical for devices like Android.
>
> I did an overnight bench on this with global pressure, comparing to
> mainline 6.19 and swap table p3 (I do include such test for each swap
> table serie, p2 / p3 is close so I just rebase and latest p3 on top of
> your base commit just to be fair and that's easier for me too) and it
> doesn't look that good.
>
> Test machine setup for vm-scalability:
> # lscpu | grep "Model name"
> Model name:          AMD EPYC 7K62 48-Core Processor
>
> # free -m
>               total        used        free      shared  buff/cache   ava=
ilable
> Mem:          31582         909       26388           8        4284      =
 29989
> Swap:         40959          41       40918
>
> The swap setup follows the recommendation from Huang
> (https://lore.kernel.org/linux-mm/87ed474kvx.fsf@yhuang6-desk2.ccr.corp.i=
ntel.com/).
>
> Test (average of 18 test run):
> vm-scalability/usemem --init-time -O -y -x -n 1 56G
>
> 6.19:
> Throughput: 618.49 MB/s (stdev 31.3)
> Free latency: 5754780.50us (stdev 69542.7)
>
> swap-table-p3 (3.8%, 0.5% better):
> Throughput: 642.02 MB/s (stdev 25.1)
> Free latency: 5728544.16us (stdev 48592.51)
>
> vswap (3.2%, 244% worse):

Now that is a deal breaker for me. Not the similar performance with
baseline or swap table P3.

> Throughput: 598.67 MB/s (stdev 25.1)
> Free latency: 13987175.66us (stdev 125148.57)
>
> That's a huge regression with freeing. I have a vm-scatiliby test
> matrix, not every setup has such significant >200% regression, but on
> average the freeing time is about at least 15 - 50% slower (for
> example /data/vm-scalability/usemem --init-time -O -y -x -n 32 1536M
> the regression is about 2583221.62us vs 2153735.59us). Throughput is
> all lower too.
>
> Freeing is important as it was causing many problems before, it's the
> reason why we had a swap slot freeing cache years ago (and later we
> removed that since the freeing cache causes more problems and swap
> allocator already improved it better than having the cache). People
> even tried to optimize that:
> https://lore.kernel.org/linux-mm/20250909065349.574894-1-liulei.rjpt@vivo=
.com/
> (This seems a already fixed downstream issue, solved by swap allocator
> or swap table). Some workloads might amplify the free latency greatly
> and cause serious lags as shown above.
>
> Another thing I personally cares about is how swap works on my daily
> laptop :), building the kernel in a 2G test VM using NVME as swap,
> which is a very practical workload I do everyday, the result is also
> not good (average of 8 test run, make -j12):
> #free -m
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:            1465         216        1026           0         300     =
   1248
> Swap:           4095          36        4059
>
> 6.19 systime:
> 109.6s
> swap-table p3:
> 108.9s
> vswap systime:
> 118.7s
>
> On a build server, it's also slower (make -j48 with 4G memory VM and
> NVME swap, average of 10 testrun):
> # free -m
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:            3877        1444        2019         737        1376     =
   2432
> Swap:          32767        1886       30881
>
> # lscpu | grep "Model name"
> Model name:                              Intel(R) Xeon(R) Platinum
> 8255C CPU @ 2.50GHz
>
> 6.19 systime:
> 435.601s
> swap-table p3:
> 432.793s
> vswap systime:
> 455.652s
>
> In conclusion it's about 4.3 - 8.3% slower for common workloads under

At 4-8% I would consider it a statically significant performance
regression to favor swap table implementations.

> global pressure, and there is a up to 200% regression on freeing. ZRAM
> shows an even larger workload regression but I'll skip that part since
> your series is focusing on zswap now. Redis is also ~20% slower
> compared to mm-stable (327515.00 RPS vs 405827.81 RPS), that's mostly
> due to swap-table-p2 in mm-stable so I didn't do further comparisons.
>
> So if that's not a bug with this series, I think the double free or
> decoupling of swap / underlying slots might be the problem with the
> freeing regression shown above. That's really a serious issue, and the
> global pressure might be a critical issue too as the metadata is much
> larger, and is already causing regressions for very common workloads.
> Low end users could hit the min watermark easily and could have
> serious jitters or allocation failures.
>
> That's part of the issue I've found, so I really do think we need a
> flexible way to implementa that and not have a mandatory layer. After
> swap table P4 we should be able to figure out a way to fit all needs,
> with a clean defined set of swap API, metadata and layers, as was
> discussed at LSFMM last year.

Agree. That matches my view, get the fundamental infrastructure for
swap right first (swap table), then do those fancier feature
enhancement like online growing the size of swapfile.

Chris


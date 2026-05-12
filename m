Return-Path: <cgroups+bounces-15829-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJFECz7oAmpEyQEAu9opvQ
	(envelope-from <cgroups+bounces-15829-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:43:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257551CE3E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81AB8301A0A3
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A721495520;
	Tue, 12 May 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2faJA78"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA54A2E17
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575379; cv=pass; b=VN/QWC719xrIhnX2YjTYvIh1B38kAjQt7emu2rOQ2UW6rRVGgDyi1r3IRFLqfnbgivXDFLsqDY/cXHB4jhTo3huE4FGyKYaeOeLeRJMEdJJS2ks2iuZcxYoPJ8RM7h0byEC9qEA0qadQrktFJLEiGang12MVj9PDtz9gQaYXnLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575379; c=relaxed/simple;
	bh=4xDoye7MoBQXcYrdRIbQOjcbcaX852V6ROo5o6Tm3Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frV3O0+jYqXx+eyYuJ4NsMKX6cBqQvIFUsOct8hpMApJ58uYoovJuneNKEACiN4xqu1Tfkk/m1pgHKVYkVmzNSu+SGEEIDEzQxGrMDGgzJRmoKNpvhYEDdNdFygKBCwKf0Lz6h5rwB/bcZH6XVLg5GNEQbuhFFIY8agXSi0GVb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2faJA78; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so7345917a12.2
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 01:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778575364; cv=none;
        d=google.com; s=arc-20240605;
        b=NLdQbgVMcQ3wt0MYYKiGMX3GpMzCptHg3M2VkH16xW/0YsQ1sxtW+yDNGPwpPvsbtj
         ipNv9kTtFNAy3ZqYZYlIcvDt7tYJnenTjv8qHvgBJltZ2WfGE3EMEjX6hwA+FTiDPj3+
         Dk0zgObUCpc+8UxFdoIzeWCTXkC5DyKK88Ax40h9pG+jhWcg1C3JVFlbp/b3iFTsDefr
         YQmpBgNJBxtIau52yRi9u83QPvVh81mk85Mi+yhIzMtoHTdiG+CpZKkSN6ek7eC80oDL
         jOKGB75XyDP2x/Vgr9mcx5mTcCjZ/znnO5b8jX4B91tJysZXs+WEwV7Ppcn42fkUNoNE
         cWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hJKjII+FJUmbBqAMNaco8fIJYdssqkVVCS9z5kutKKA=;
        fh=vhbD0hFJSk94fTbQlrsdnMsxdGUCWC6m2OXrKBgNOsg=;
        b=Q0+X8bFRrlxcHDc2TGdZbuGwc1Tnwkf+uotkts1uM8pX1CqxuBqEw4sTjmGbwWVwQA
         7cYBd3M2/HGsJLseuY3hFisgSyHDl0gS///49hRyjLAMF9bHTAwR0crbuA8Knzpka6D4
         7O1DANdTk8VemIi+8UnatcWFA/pa9Iw4Pc7sWpDbivMPSRtU7fMYzG6SAe9ToR6DqRue
         7YezO+BDwU/umy1SYvHgMay1bpVigFjnXrT1smlFuig0+YOztN6IPh+atetX/3akbuRw
         XGNiX7+p6STIWx+fPvWr35Y5/OcdZST99lv+BeSqUfX5SKVBZOfb4jhg6oNUshptv1Ks
         GvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778575364; x=1779180164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJKjII+FJUmbBqAMNaco8fIJYdssqkVVCS9z5kutKKA=;
        b=N2faJA78hJtaUdJ79kYzpU1bWpTEaDYQo42wyoy6tUOuMlI0xbTR+/YpeLa3HmEFBP
         r16jTtB6OnJjHZ0VLH92pfP/4JP/7PPGQijrAEI1LK2qoZOvLcnkcxloV2fTNRcY1Lif
         NRdMlf/5nvTOreFt6S8qZ9w7KSy5VlV7ArMcOf/KLk46ZGcCrmp13I2b3igMUhZ/NYZh
         YN++prd1jqvSXnPtiSAITTQDPB+LueU78nDUub030uJaZV0NuoYvpQzMaawZ3qEZgvXd
         22IyPjVoXPeqTZBSQXGV8ogFSVqImgCU0t4Dqig3z2YVnjtR4otpIU3Ei2O0VPbphT4u
         Nu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575364; x=1779180164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJKjII+FJUmbBqAMNaco8fIJYdssqkVVCS9z5kutKKA=;
        b=KNZhR+V6ekdM0aWtA6A5wb13NLLftlEF4JngWNl7L8ThTKtYDlyEYd7WCBxyg68dcI
         AnOfR/rj8o9VRJD5/YgdH4aoMmEspXZ5mqVKaaUlrx0ye19NpAfXARCpqV5uklha32Oy
         Z8cfFv8i9a3QSwZJ/C3q2qS3nlRQ1ZWCcJkzhiKi4j8nuAfEJp83Cox0SpSwlvZA6bvQ
         p36o7jhkwMUZSE5qYD+H9E18o13D94s+cIGduYFd7efEClenPBZWamzz2uDE5rBiwni1
         Yny2FC50T9wnB3Gln4lWOID0H7H3WLqgBW5h+RiXFEBKAPehVg1UC+4qCoKrCW0lETRi
         iJEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AHxzspJ4c7QU7plLvfeRzXj6qH/U9LEYNR2CiYEX/ZmS56v8teBViFefUdl9nwMFyOous+x0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YweLiHxj46E1q2wu+HSTwFJeUp8CwQ/7afnyZJWB4z3NQh2w/eG
	yjgDh4VFMYlU5lulQyHqG/Juk3YfWBrvfoWxZcXiH1HcptABskfiBlRPr8Qgo2nNqwYOD+/4Geb
	Ola5rIorEsVJXEN+oyUl87SYIptAmDsjZUx3igMfEhw==
X-Gm-Gg: Acq92OFD/Ua9bv9a7HR86CGHReBoamnDQtJki9yZdCuvNqLXOhVCLaRFzKz+GDEGL3B
	c6tvg0YRNywYAfc0tXEYCUBaqmBs9CBgk6hYmI9XT7BETDK/BU4gk4mZ8KhZLG0MSkDvIrztCZb
	Ac8YN/rT2x77ElguvMBBhNSi4DI/5vknoEp+JRCWsdswkx62Ony7fb3KESAlnIlywZJ9uwWfcuT
	ELfIAc8MKInP5iNR9A6MmoesbyVg7bIKJvpt7EArnMyKUMqDaTd8bjpOMgWf8TQpvraloGtdlIU
	czkbeD7YoQNnuW5rocTN2bwXJvcNLDEN4sUm
X-Received: by 2002:a05:6402:1f83:b0:674:2565:f27a with SMTP id
 4fb4d7f45d1cf-67f713be67amr6296288a12.19.1778575364388; Tue, 12 May 2026
 01:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org>
In-Reply-To: <20260511113104.563854162@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 May 2026 10:42:33 +0200
X-Gm-Features: AVHnY4LYFXOoIWryjNNiTxTaYlCXoRvF7TUocK3DWEoFoqESqt48Semy9WRH8lk
Message-ID: <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6257551CE3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15829-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email,linaro.org:dkim]
X-Rspamd-Action: no action

On Mon, 11 May 2026 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi!
>
> So cgroup scheduling has always been a pain in the arse. The problems start
> with weight distribution and end with hierachical picks and it all sucks.
>
> The problems with weight distribution are related to that infernal global
> fraction:
>
>              tg->w * grq_i->w
>    ge_i->w = ----------------
>              \Sum_j grq_j->w
>
> which we've approximated reasonably well by now. However, the immediate
> consequence of this fraction is that the total group weight (tg->w) gets
> fragmented across all your CPUs. And at 64 CPUs that means your per-cpu cgroup
> weight ends up being a nice 19 task worth. And more CPUs more tiny. Combine
> with the fact that 256 CPU systems are relatively common these days, this
> becomes painful.
>
> The common 'solution' is to inflate the group weight by 'nr_cpus'; the
> immediate problem with that is that when all load of a group gets concentrated
> on a single CPU, the per-cpu cgroup weight becomes insanely large, easily
> exceeding nice -20.
>
> Additionally there are numerical limits on the max weight you can have before
> the math starts suffering overflows. As such there is a definite limit on the
> total group weight. Which has annoyed people ;-)
>
> The first few patches add a knob /debug/sched/cgroup_mode and a few different
> options on how to deal with this. My favourite is 'concur', but obviously that
> is also the most expensive one :-/ It adds a tg->tasks counter which makes the
> update_tg_load_avg() thing more expensive.
>
> I have some ideas but I figured I ought to share these things before sinking
> more time into it.
>
>
> On to the hierarchical pick; this has been causing trouble for a very long
> time. So once again an attempt at flatting it. The basic idea is to keep the
> full hierarchical load tracking as-is, but keep all the runnable entities in a
> single level. The immediate concequence of all this is ofcourse that we need to
> constantly re-compute the effective weight of each entity as things progress.
>
> Reweight is done on:
>  - enqueue
>  - pick -- or rather set_next_entity(.first=true)
>  - tick
>
> So while the {en,de}queue operations are still O(depth) due to the full
> accounting mess, the pick is now a single level. Removing the intermediate
> levels that obscure runnability etc.
>
>
> For testing, I've done a little experiment, I dug out what is colloqually known
> as a potato. A trusty old Sandybridge 12600k with a RX 580, and ran a game on
> it. From GOG, I had available 'Shadows: Awakens', a fun title that normally
> runs really well on this machine (provided you stick to 1080p).
>
> To make it interesting, I added 8 (one for each logical CPU) copies of: 'nice
> spin.sh'; this results in the game becoming almost unplayable, as in proper
> terrible.
>
> I used MangoHUD to record a few minutes of playtime for statistics, and then
> quit the came and re-started it with a shorter slice set (base/10). This
> results in the game being entirely playable -- not great, but definiltey
> playable.
>
>   Lutris / GE-Proton10-34 / Steam Runtime 3 (sniper)
>   Intel Core i7-2600K
>   AMD Radeon RX 580
>
>   Shadows Awakening (GOG)
>
>           default slice(*)
>
>   FPS min  3.8    20.6
>       avg 48.0    57.2
>       mag 87.4    80.3
>
>   FT  min   9.4    8.4
>       avg  34.5   19.5
>       max 107.4   37.2
>
>   FPS (Frames Per Second)
>   FT  (FrameTime)
>
>   [*] Command prefix: 'chrt -o --sched-runtime 280000 0'
>       effectively setting 'base_slice_ns/10'
>
> I have not compared to a kernel without flat on, just wanted to run non trivial
> workloads and play with slice to make sure everything 'works'.


I haven't reviewed the patches yet but I ran some tests with it while
testing sched latency related changes for short slice wakeup
preemption. I have some large hackbench regressions with this series
on HMP system with and without EAS. those figures are unexpected
because the benchs run on root cfs

One example with hackbench 8 groups thread pipe
tip/sched/core  tip/sched/core          +this patchset          +this patchset
slice 2.8ms     16ms                    2.8ms                   16ms
dragonboard rb5 with EAS
0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
0,689(+/- 9.1%) +8%

radxa orion6 HMP without EAS
0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
1,071(+/-5.9%) -82%

Increasing the slice partly removes regressions but tis is surprising
because the bench runs at root cfs and I thought that results will not
change in such a case

I will review the patchset and try to get what is going wrong


>
>
> Can also be had:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat
>
>  include/linux/cpuset.h |    6
>  include/linux/sched.h  |    1
>  kernel/cgroup/cpuset.c |   15
>  kernel/sched/core.c    |   47 --
>  kernel/sched/debug.c   |  171 +++++---
>  kernel/sched/fair.c    | 1038 ++++++++++++++++++++++---------------------------
>  kernel/sched/pelt.c    |    6
>  kernel/sched/sched.h   |   44 --
>  8 files changed, 672 insertions(+), 656 deletions(-)
>
> ---
> Change since v1 ( https://patch.msgid.link/20260317095113.387450089@infradead.org ):
>  - various Sashiko thingies
>  - rebase atop curren -tip
>
>


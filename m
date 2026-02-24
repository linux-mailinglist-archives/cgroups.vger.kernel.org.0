Return-Path: <cgroups+bounces-14226-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEC0IRfqnWlDSgQAu9opvQ
	(envelope-from <cgroups+bounces-14226-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:12:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FC18B122
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD10231025A8
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4273ACA41;
	Tue, 24 Feb 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAAY49QM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B592C235E
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956270; cv=none; b=qS/hDkUpufxHL+FI98xxLGYM+nCWWU6r7nK2PexTD1jXkYj/SZDSyVjexn+x3jmYjeuOUQPuvEXD8xIg01DrDZQMoiLwvnJHAO9yqaqgKaPvMAlvsr4QXPWuUYw7AZqnUmVuhiJgoM4iAUp3/tXgBczKqTIhJMIoPXX/XsYjmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956270; c=relaxed/simple;
	bh=5Qa3kNt4SoFeG9CBDN9YkibO4vtDu6bOOp+PptbvkWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzcTzw7NFlHhbSzyU12Ekw8S1ImUOQgE2tsFdi4ZbTGa3sSfPT79N9V7noqCTW8Bt8nar4jrrfCHkgji68irGMokNAuTSqx5w1990YPu9n0S0RtV05F8jEHsJzZSQ1G7DUWqkuKDZb2xtdkVRcnUNcmt9q2O1s5fB7k0bOvfDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAAY49QM; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-66f747175d8so3564366eaf.0
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956268; x=1772561068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS+j2puaAGsOcTjJlK5nBHRn9fQdF++IjhODBwlsIys=;
        b=SAAY49QMmU1aCBXHPNm5AfBkelNr8K/O0Atdr8tIvit9ti6Q7kreu1tp0ri6bSZfoN
         SawZbdXwU+H6igvoH85dVvOYCY8Trdo0I5ETRn/e9pZP8PCAgBWjoPmeyrkwCLGRarNG
         w6fQN+vk9OLjOdLOFu6T7+VQbz4evEYOVAhC2ea2gxGWo7ZHag8b9cZkuXjXq9btHoN8
         6qGbcOQlReIpvjfu1j4Lk4R2ZmIBRU4x+ezok8FZp31NsctpV9lAFvwKGuczizfix8hF
         PlISUKk9m4vqRT2kNEY9DrhL7rJygt/POwFzx+XPuz0CMyubDlIQIMs0FtIjiNi3jjsR
         /ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956268; x=1772561068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CS+j2puaAGsOcTjJlK5nBHRn9fQdF++IjhODBwlsIys=;
        b=Y4zUZ3nTpprBh2+UKroT+lQ2OF5G3dhOWt49OQ8inCPqNxwQZap4Ju4+zvSrhv2NZk
         6lhiXrWFrvkzGLYTq23E4w5JpV9ZhTt72NqEoY/Uh2RQHN5zCyg2t3LBFQQFn4W9xpc/
         rihz1pzU4lVXuUq11mGGxAUSbtuDhDlaoehsSA4vQQLK7UKOTpPHbr9jl/vF7HhqQ51A
         txz31x2Ps+R88L+Je6+IArXGoKhgo8MU0NPOnXHh4W/cDBH5aMF3prSW32+AAf/iSAya
         NPzzrSjMBz5zto4BAqUoA23cQMXYfpdAbTMbFzGRwtcR7enAnveelG/wBUVV7OIxWQCa
         ipQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnD+g2XazHLf9UX/BFiDrA3fNFLhbBN7lgG82aKvYGEIU2P89YBnHzVrV49kLEN+s7UBLbmduV@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUcPLNigweqIJKwsvdxt7n8fUR+8dN15v6zoL23uKBeR0kMRX
	3hQ0nN+CtFpU70MGGlO80ysFicR7R4MNv42q7FVS3+eVdRLIQ6jdB//LXK8Csw==
X-Gm-Gg: AZuq6aJS2butzrRtmx18qJD6zqkemLGAdBGgycOGYLiQm3/BFJ2ZwtmfFUequwd8z48
	+WNpHlGUhMUrLwWRtW8xMcR7b1Zepeh5SYetAb0P8FhpNHQPQFWbP3awNHIWHflm4Haf8u2VwRd
	ZnwoMQM8+vaUrbZBrLsDY6+J26xJd2vfYlGGl30G/oqi75LK5VCTIUFqtQgJSCzDIburAv7wEqp
	m/XdpHmWaC19LmL2IG5IqyWuHNfBpRyJQaxsYKZghkQP+ZdaYhqZfNftaMGXjAkMryOosWvZxnk
	QDhFRcMgoRA+KQdPROxFfbMK9PTQTkhR0beDkwNaZiFxaNEg+QP5m/Z7pKZw456bQ/3f6dV3mlr
	O6dhRV3bFQFFnIiQeQsdFXpUji5T1agggESWsdxUbC+4Jjowx7Otc1ATfev+gSItMgFBF60kSFs
	hmweePNGcoW8dO+/Xmfsj7gyWW7mKYwdpf
X-Received: by 2002:a05:6808:1b21:b0:45c:9936:10be with SMTP id 5614622812f47-46446387894mr6818660b6e.42.1771949639421;
        Tue, 24 Feb 2026 08:13:59 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d2d320fsm10358387fac.11.2026.02.24.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:13:58 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Date: Tue, 24 Feb 2026 08:13:56 -0800
Message-ID: <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aZ2LC0KPF0xsAwAL@tiehlicka>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14226-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 029FC18B122
X-Rspamd-Action: no action

Hello Michal,

I hope that you are doing well! Thank you for taking the time to review my
work and leaving your thoughts.

I wanted to note that I hope to bring this discussion to LSFMMBPF as well,
to discuss what the scope of the project should be, what usecases there
are (as I will note below), how to make this scalable and sustainable
for the future, etc. I'll send out a topic proposal later today. I had
separated the series from the proposal because I imagined that this
series would go through many versions, so it would be helpful to have
the topic as a unified place for pre-conference discussions.

> > Memory cgroups provide an interface that allow multiple workloads on a
> > host to co-exist, and establish both weak and strong memory isolation
> > guarantees. For large servers and small embedded systems alike, memcgs
> > provide an effective way to provide a baseline quality of service for
> > protected workloads.
> > 
> > This works, because for the most part, all memory is equal (except for
> > zram / zswap). Restricting a cgroup's memory footprint restricts how
> > much it can hurt other workloads competing for memory. Likewise, setting
> > memory.low or memory.min limits can provide weak and strong guarantees
> > to the performance of a cgroup.
> > 
> > However, on systems with tiered memory (e.g. CXL / compressed memory),
> > the quality of service guarantees that memcg limits enforced become less
> > effective, as memcg has no awareness of the physical location of its
> > charged memory. In other words, a workload that is well-behaved within
> > its memcg limits may still be hurting the performance of other
> > well-behaving workloads on the system by hogging more than its
> > "fair share" of toptier memory.

I will split up your questions to answer them individually:

> This assumes that the active workingset size of all workloads doesn't
> fit into the top tier right?

Yes, for the scenario above, a workload that is violating its fair share
of toptier memory mostly hurts other workloads if the aggregate working
set size of all workloads exceeds the size of toptier memory.

> Otherwise promotions would make sure to that we have the most active
> memory in the top tier.

This is true. And for a lot of usecases, this is 100% the right thing to do.
However, with this patch I want to encourage a different perspective,
which is to think about things in a per-workload perspective, and not a
per-system perspective.

Having hot memory in high tiers and cold memory in low tiers is only
logical, since we increase the system's throughput and make the most
optimal choices for latency. However, what about systems that care about
objectives other than simply maximizing throughput?

In the original cover letter I offered an example of VM hosting services
that care less about maximizing host-wide throughput, but more on ensuring
a bottomline performance guarantee for all workloads running on the system.
For the users on these services, they don't care that the host their VM is
running on is maximizing throughput; rather, they care that their VM meets
the performance guarantees that their provider promised. If there is no
way to know or enforce which tier of memory their workload lands on, either
the bottomline guarantee becomes very underestimated, or users must deal
with a high variance in performance.

Here's another example: Let's say there is a host with multiple workloads,
each serving queries for a database. The host would like to guarantee the
lowest maximum latency possible, while maximizing the total throughput
of the system. Once again in this situation, without tier-aware memcg
limits the host can maximize throughput, but can only make severely
underestimated promises on the bottom line.

> Is this typical in real life configurations?

I would say so. I think that the two examples above are realistic
scenarios that cloud providers and hyperscalers might face on tiered systems.

> Or do you intend to limit memory consumption on particular tier even
> without an external pressure?

This is a great question, and one that I hope to discuss at LSFMMBPF
to see how people expect an interface like this to work.

Over the past few weeks, I have been discussing this idea during the
Linux Memory Hotness and Promotion biweekly calls with Gregory Price [1].
One of the proposals that we made there (but did not include in this
series) is the idea of "fixed" vs. "opportunistic" reclaim.

Fixed mode is what we have here -- start limiting toptier usage whenever
a workload goes above its fair slice of toptier.
Opportunistic mode would allow workloads to use more toptier memory than
its fair share, but only be restricted when toptier is pressured.

What do you think about these two options? For the stated goal of this
series, which is to help maximize the bottom line for workloads, fair
share seemed to make sense. Implementing opportunistic mode changes
on top of this work would most likely just be another sysctl.

> > Introduce tier-aware memcg limits, which scale memory.low/high to
> > reflect the ratio of toptier:total memory the cgroup has access.
> > 
> > Take the following scenario as an example:
> > On a host with 3:1 toptier:lowtier, say 150G toptier, and 50Glowtier,
> > setting a cgroup's limits to:
> > 	memory.min:  15G
> > 	memory.low:  20G
> > 	memory.high: 40G
> > 	memory.max:  50G
> > 
> > Will be enforced at the toptier as:
> > 	memory.min:          15G
> > 	memory.toptier_low:  15G (20 * 150/200)
> > 	memory.toptier_high: 30G (40 * 150/200)
> > 	memory.max:          50G

I will split up the following points to answer them individually as well:

> Let's spend some more time with the interface first.

That sounds good with me, my goal was to bring this out as an RFC patchset
so folks could look at the code and understand the motivation, and then send
out the LSFMMBPF topic proposal. In retrospect I think I should have done
it in the opposite order. I'm sorry if this caused any confusion.

> You seem to be focusing only on the top tier with this interface, right?
> Is this really the right way to go long term? What makes you believe that
> we do not really hit the same issue with other tiers as well?

Yes, that's right. I'm not sure if this is the right way to go long-term
(say, past the next 5 years). My thinking was that I can stick with doing
this for toptier vs. non-toptier memory for now, and deal with having
3+ tiers in the future, when we start to have systems with that many tiers.
AFAICT two-tiered systems are still ~relatively new, and I don't think
there are a lot of genuine usecases for enforcing mid-tier memory limits
as of now. Of course, I would be excited to learn about these usecases
and work this patchset to support them as well if anybody has them.

> Also do we want/need to duplicate all the limits for each/top tier?

Sorry, I'm not sure that I completely understood this question. Are you
referring to the case where we have multiple nodes in the toptier?
If so, then all of those nodes are treated the same, and don't have
unique limits. Or are you referring to the case where we have multiple
tiers in the toptier? If so, I hope the answer above can answer this too.

> What is the reasoning for the switch to be runtime sysctl rather than
> boot-time or cgroup mount option?

Good point : -) I don't think cgroup mount options are a good idea,
since this would mean that we can have a set of cgroups self-policing
their toptier usage, while another cgroup allocates memory unrestricted.
This would punish the self-policing cgroup and we would lose the benefit
of having a bottomline performance guarantee.

> I will likely have more questions but these are immediate ones after
> reading the cover. Please note I haven't really looked at the
> implementation yet. I really want to understand usecases and interface
> first.

That sounds good to me, thank you again for reviewing this work!
I hope you have a great day : -)
Joshua

[1] https://lore.kernel.org/linux-mm/c8bc2dce-d4ec-c16e-8df4-2624c48cfc06@google.com/


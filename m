Return-Path: <cgroups+bounces-14418-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKKFCrP/n2n3fAQAu9opvQ
	(envelope-from <cgroups+bounces-14418-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 09:09:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925281A24DF
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 09:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFBC730166C3
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14A392C58;
	Thu, 26 Feb 2026 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WYmbTObg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1325771
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093088; cv=none; b=YUH0Q+zbE9N3QIql6dOdUBbNIKFlagWzFhW+sstTGb6bctbfBqm4f33byX5NbpYvTjd8wdbEp7mWGStNpBVcQJQU8Gj9PSexUJPZNfCgGh/gm7Ielv6baKX5mvYqjfgFyM+pW0H/igMJke9Z8uIhLl7KiSFAVjkXDAR15T7HyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093088; c=relaxed/simple;
	bh=N6P5jevl7PAhzYT+lpNqGSa5JS1dX+sqJHz4RsvzDzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCFz/z4JCnS+Rj+7osDjzQ6O/dqrKBldtv7uu4sQ7RpkeAaXNYnBfBW1NPqKOJK89VAmzjjMDzU47z4H/KFRpFM7xtVgDJJRZ3nVkSGZ2alIlamBfwycBPG6XTnXuppvRaqtXUiYlyWbb6aE7i+vOtKEXf7Fv9CYpHwGlwL25iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WYmbTObg; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48379a42f76so4517895e9.0
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772093085; x=1772697885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uS1xoFC20rI9dVkbD9ZqhHqbX9OMzBeyOLocK+DjeUM=;
        b=WYmbTObgzVl/2PR1KbxrlGzsm+duMrb54Zqb0RlAIknqi64nKeCQpE+iXzJB9lKDOw
         6sVSOpTvGXIzlCI+KfMhkHgQTOyYR+nQin8HbQ9c9c5tcMgcAjEsIUW/NgCQhhwbW5mu
         LhtFef0f/Z8kVyv9TLx0oP7IuOQIBztYKo+SJRrQSNaNrIknI52IEyyW3zCr/RJhk19r
         LN5qSU9h1YbH+GwviAOhvsNpYQnighcApfVC+Ap2dU+q00tAE4UtgALrRc172ELtUaEo
         wzq/AFQv/udTMuL0oQAkIBBvotabuwC7ygflbsvnFYAaUVxPNU7uR5PBbPgrVcqgRPsf
         oJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772093085; x=1772697885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS1xoFC20rI9dVkbD9ZqhHqbX9OMzBeyOLocK+DjeUM=;
        b=QjvFfCc3fon3ubGC+BTmABtea8Ikg8Rwi5QHOA/KpEV70SdpP7cV7GJiyBZK6sUj4E
         RMTA6oXVtE0s7M7Jz+RqPetjYhAftgX4oX8tyDT6dvmI0GJVWRtl1zCF3NI99VeAxkfa
         xRaIPZoPafTAkIBT0cB8JQImRKzsItWxMbhuUGB7XsGh4AdCuAR6W506tQwRghQMKFCO
         7CM6HCUMUYn09CNPivD5EgcF/WbHSAeRJwA05A5a8pWx2bJA2U+2P5P5BEgx//ZltIyG
         sNrY88Wdy7NiXhqWp6+1DP0CiAT6OXXlw+9vwFh4mUVbVCLb8t/uDPnq+sbg/zB6iY3d
         y0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXbmnHqO2jgD716qqXfyfxHOrqd6gcPoEO11s4ZmQowTU++4uLfJnwgEjR49jxxB5pEMttv3Ytv@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQvX8jyKZkzN6vVS4AYWfDqOIHbMU+8MfC8hkLKpPPxiZDLNK
	s/lAU0Gp0CdMBBcnbvgwQh/IUmB65wj4+BlzghpXcDcMNFtYA7ELGmG0EEKfH82WZgc=
X-Gm-Gg: ATEYQzy+kOuUpGBuWP3ckYN5nUh0pGIia+25oGeG10TJhpZQqbSKcTgnI5KA+bZPW9U
	MUMqOvertAK+TPB/rgrVk4ExfNXRObdtxhVAXtAm7OBtUcbzjM9QBM0gxgC8G9i/lVsgBeBVcsU
	QqvTTviFhT9+rJF8es1Qy3SFwNw6A/eG8sj3512yckqEFed5NozIyN24lpp6S1+yyw6YZlnG6LS
	PXvlNIl3Ue3sK8QqGacynSAg87GCasSVefDB2eRqgMBE8MdTY7vPNed7RBGNo9JSZ4stuYpqh3l
	UEkHQpjiM3wKCr3B1sRGlJK2/GvMwC/jCTv/ScSrcEUG6bxbEFRACjoUlSp8Rzp/o94KV6BaueC
	PkmmkoWRz4VGfe86ELgRWz9TzxjCnjSqS3DJhZ/R5bQTq/GMnzhzZfF+19KU3D0pWswIwZ3MraO
	yVO4expmPrJ43vCL/bm5qWmRPX7IjOcM1Lig==
X-Received: by 2002:a05:600c:c165:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-483c2128cc2mr56475735e9.0.1772093084653;
        Thu, 26 Feb 2026 00:04:44 -0800 (PST)
Received: from localhost (109-81-17-39.rct.o2.cz. [109.81.17.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfccd7b6sm29626545e9.24.2026.02.26.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:04:44 -0800 (PST)
Date: Thu, 26 Feb 2026 09:04:43 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Johannes Weiner <hannes@cmpxchg.org>,
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
	Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Message-ID: <aZ_-m7vSUPrzDj4n@tiehlicka>
References: <aZ2LC0KPF0xsAwAL@tiehlicka>
 <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14418-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 925281A24DF
X-Rspamd-Action: no action

On Tue 24-02-26 08:13:56, Joshua Hahn wrote:
> Hello Michal,
> 
> I hope that you are doing well! Thank you for taking the time to review my
> work and leaving your thoughts.
> 
> I wanted to note that I hope to bring this discussion to LSFMMBPF as well,
> to discuss what the scope of the project should be, what usecases there
> are (as I will note below), how to make this scalable and sustainable
> for the future, etc. I'll send out a topic proposal later today. I had
> separated the series from the proposal because I imagined that this
> series would go through many versions, so it would be helpful to have
> the topic as a unified place for pre-conference discussions.

yes, this is a really good topic to bring to LSFMMBPF. I will not be
attending this year unfortunately but I will keep watching progress on
the this. I am really sure there will be people in the room that can
help with the discussion.

> > > Memory cgroups provide an interface that allow multiple workloads on a
> > > host to co-exist, and establish both weak and strong memory isolation
> > > guarantees. For large servers and small embedded systems alike, memcgs
> > > provide an effective way to provide a baseline quality of service for
> > > protected workloads.
> > > 
> > > This works, because for the most part, all memory is equal (except for
> > > zram / zswap). Restricting a cgroup's memory footprint restricts how
> > > much it can hurt other workloads competing for memory. Likewise, setting
> > > memory.low or memory.min limits can provide weak and strong guarantees
> > > to the performance of a cgroup.
> > > 
> > > However, on systems with tiered memory (e.g. CXL / compressed memory),
> > > the quality of service guarantees that memcg limits enforced become less
> > > effective, as memcg has no awareness of the physical location of its
> > > charged memory. In other words, a workload that is well-behaved within
> > > its memcg limits may still be hurting the performance of other
> > > well-behaving workloads on the system by hogging more than its
> > > "fair share" of toptier memory.
> 
> I will split up your questions to answer them individually:
> 
> > This assumes that the active workingset size of all workloads doesn't
> > fit into the top tier right?
> 
> Yes, for the scenario above, a workload that is violating its fair share
> of toptier memory mostly hurts other workloads if the aggregate working
> set size of all workloads exceeds the size of toptier memory.

I think it would be good to provide some more insight into how this is
supposed to work exactly. If the real working set size doesn't fit into
the top tier then I suspect we can expect quite a lot of disruption by
constant promotions and demotions, right. I guess what you would like to
achieve is to stop those from happening right? If that is the case then
how exactly do you envision to configure the workload. Do you cap the
each workload with max/high limits? Or do you want to rely on the
low/min limits to protect workloads you care about. Or both? How does
that play with promotion side of things.

> > Otherwise promotions would make sure to that we have the most active
> > memory in the top tier.
> 
> This is true. And for a lot of usecases, this is 100% the right thing to do.
> However, with this patch I want to encourage a different perspective,
> which is to think about things in a per-workload perspective, and not a
> per-system perspective.
> 
> Having hot memory in high tiers and cold memory in low tiers is only
> logical, since we increase the system's throughput and make the most
> optimal choices for latency. However, what about systems that care about
> objectives other than simply maximizing throughput?
> 
> In the original cover letter I offered an example of VM hosting services
> that care less about maximizing host-wide throughput, but more on ensuring
> a bottomline performance guarantee for all workloads running on the system.
> For the users on these services, they don't care that the host their VM is
> running on is maximizing throughput; rather, they care that their VM meets
> the performance guarantees that their provider promised. If there is no
> way to know or enforce which tier of memory their workload lands on, either
> the bottomline guarantee becomes very underestimated, or users must deal
> with a high variance in performance.
> 
> Here's another example: Let's say there is a host with multiple workloads,
> each serving queries for a database. The host would like to guarantee the
> lowest maximum latency possible, while maximizing the total throughput
> of the system. Once again in this situation, without tier-aware memcg
> limits the host can maximize throughput, but can only make severely
> underestimated promises on the bottom line.

Thanks useful examples. And it would be really great to provide an
example of intended configuration (no specific numbers but something to
demonstrate the intention). Because this will not be just about limits,
right. It would require more tweaks to the system - at least numa
balancing (promotions) to be controlled in some way AFAICS.

> > Is this typical in real life configurations?
> 
> I would say so. I think that the two examples above are realistic
> scenarios that cloud providers and hyperscalers might face on tiered systems.
> 
> > Or do you intend to limit memory consumption on particular tier even
> > without an external pressure?
> 
> This is a great question, and one that I hope to discuss at LSFMMBPF
> to see how people expect an interface like this to work.
> 
> Over the past few weeks, I have been discussing this idea during the
> Linux Memory Hotness and Promotion biweekly calls with Gregory Price [1].
> One of the proposals that we made there (but did not include in this
> series) is the idea of "fixed" vs. "opportunistic" reclaim.
> 
> Fixed mode is what we have here -- start limiting toptier usage whenever
> a workload goes above its fair slice of toptier.
> Opportunistic mode would allow workloads to use more toptier memory than
> its fair share, but only be restricted when toptier is pressured.
> 
> What do you think about these two options? For the stated goal of this
> series, which is to help maximize the bottom line for workloads, fair
> share seemed to make sense. Implementing opportunistic mode changes
> on top of this work would most likely just be another sysctl.

To me it would sounds like the distinction between max/high vs. low/min
reclaim.

[...]
> > You seem to be focusing only on the top tier with this interface, right?
> > Is this really the right way to go long term? What makes you believe that
> > we do not really hit the same issue with other tiers as well?
> 
> Yes, that's right. I'm not sure if this is the right way to go long-term
> (say, past the next 5 years). My thinking was that I can stick with doing
> this for toptier vs. non-toptier memory for now, and deal with having
> 3+ tiers in the future, when we start to have systems with that many tiers.
> AFAICT two-tiered systems are still ~relatively new, and I don't think
> there are a lot of genuine usecases for enforcing mid-tier memory limits
> as of now. Of course, I would be excited to learn about these usecases
> and work this patchset to support them as well if anybody has them.

I guess a more fundamental question is whether this need to replicate
all limits for tiers or whether we can get an extension that would
control tier behavior for existing ones. In other words can we define
which proportion of the max/high resp. low/min limits are reserved for
each tier? Is that feasible? I do not have answer to that myself at this
stage TBH.

[...]
> > What is the reasoning for the switch to be runtime sysctl rather than
> > boot-time or cgroup mount option?
> 
> Good point : -) I don't think cgroup mount options are a good idea,
> since this would mean that we can have a set of cgroups self-policing
> their toptier usage, while another cgroup allocates memory unrestricted.
> This would punish the self-policing cgroup and we would lose the benefit
> of having a bottomline performance guarantee.

I do not follow. cgroup mount option would apply to all cgroups. In
sense whatever is achievable by sysctl should apply to kernel cmdline or
mount option. The question is what is the best fit AFAICS.
 
> > I will likely have more questions but these are immediate ones after
> > reading the cover. Please note I haven't really looked at the
> > implementation yet. I really want to understand usecases and interface
> > first.
> 
> That sounds good to me, thank you again for reviewing this work!
> I hope you have a great day : -)
> Joshua
> 
> [1] https://lore.kernel.org/linux-mm/c8bc2dce-d4ec-c16e-8df4-2624c48cfc06@google.com/

-- 
Michal Hocko
SUSE Labs


Return-Path: <cgroups+bounces-14438-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LedJKiNoGkokwQAu9opvQ
	(envelope-from <cgroups+bounces-14438-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:15:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1791AD6CF
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82D1630CC51B
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52242355F35;
	Thu, 26 Feb 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzAied7N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A833260F
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127840; cv=none; b=Z1YrnB/fq+UnXr+5wZzbSsy1//LvIuF4ZdmrVvkZj546j9h7GgOwXRwHSueLdSjpLyJz2ZUea/eYvcQKLT4npdq48w5cUfla8JgXxzcdQrMeXBLdLo8S7G0c+fcjcJl30BZhUYS+6bFnFu0RuLdApFr2ATKAijrkiq/dtKDUzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127840; c=relaxed/simple;
	bh=tOt/JY+55T+l0NX275Xse3q7Y1/1m039xaSmDs6P46k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzau26ECJ4Q0m33hLsSK9gayv472FImACWdOhwhBHSa26Ji6+K8/hDOOtPkEf5SWVm+ekEfUuCEIObUIk/JVgAwKCD+znMhl+vKG2Cf0gjUs4uQAnYaiR0gLMPiIpqtcoZmTUghQbgwhmMW1qt2pJdt62pmBF97i9eWO6vRKjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzAied7N; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89549b2f538so19407416d6.2
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772127837; x=1772732637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9YpbVK1L35uP8WZppOKKGwEMIRFy1q54VTAL1bze0I=;
        b=CzAied7N0ylbSt+mucycFBbkuEBuetwhOb2XVSEA6Slkrdv/jk/uHEJ6Jy+g7qJ/Gu
         veOnYVYr2sICnyQzAGzdvaGR/Txk0rRsKNe8K3xfDe92BSLwaE6Zuvlfi0M1fXTETC8O
         FCzXq8/qHU7m1dAMsHsbhi4n5a3qmbfJTTB9cJ0nHimGzzoTEMPeqUahBfyuRMRRUd2w
         0WfC/fDNpfpaUi1zDYzYzxGhU0AvID8BBvlftJwh6/HqCxJyxkaqV769UESNO79B9QcX
         mvkAg5pjq48u5ma+8DtYEKry1cEry0HH5b33sLatRXDsTjWVlmIPLrGjnk/DMozCsg/j
         CzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772127837; x=1772732637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9YpbVK1L35uP8WZppOKKGwEMIRFy1q54VTAL1bze0I=;
        b=d36Q5ux4RLq6nNBiL5rCsfwwdzHZLmsPiC+FiC/ph3FzBPRTywy/UrXC24uu6PR9WZ
         8YqmMYcmzcLsZpPb/wCpWQ9LAKCaFzZKkh9bddx11qba8hougVtdt4vBGWych6/xrjVw
         /73X26dy5ckO/lt6LbDVyx4VPtW/w0endYQ+tXw/V4ue0VNdhgEfiyGK9WN3GSK0rKyi
         KFS/wMHrFrCgM6Ziwme0geEsUXpBASaP+VqRby0MtOBN5MV1Hwwjhcr4bKEqDAVwcFmF
         v4uf5Mw/fFMjcSmxID8y8FDSm5cynVnnDPtS5llrtT8If5P5pTFMydE+RJQ4gQ5sZn1q
         b1vA==
X-Forwarded-Encrypted: i=1; AJvYcCWBNSIoSPphFukr9hvOta10ZQEYnfPj0SHVcS46u413dlBcdoiq8JQcbr/78aCoI0VjLj/jHQJu@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBpeUlmD+XZIJSWZ6nCIMdiQIpQKBnZQwOx1Di8L/DiVvo+P6
	m8nQ6JDHjART+kmRlavP1ni6myxJHRtlgb9gvo3DEZ1ODlBotl3ZQJF+I45Q+Q==
X-Gm-Gg: ATEYQzw9FTkPO7Z1TO7rCwX0Uz4RhrSrJhBJ9GIFqX92YMtUkM1ZzUzy5P99jMIMaUn
	JHYsTZP0TJ9n2B43mPs/s73B6bA4vGJK/Xc+sC+s00mzBA4+YfVf1Vs0McFhzgAABS/ggmzbcce
	XCcgyun8uJ7cu8UQnhcz28tOXfnqKBzI0wju6rOqGRrh+CWDGwUld9S0+syLL2ogSotTvDFqbBa
	v35DZhf9Y1gJ8E9Kx1gIGucyss2Jv4ZEfO+5TButXblaGkUo0QspjpU68FnocheoBhYuk4bdjxj
	GWBzL55o/WccXB+S4V8pt5moE0z00m7QalUNC5lXCPDghzq4TCfO4VOJc2kKBPVJ5VZ+eDYrj8N
	Dx/o08zWibFU1V/XYVFjqS9jLSEAg5q87dNCvdKUxoTtEq15oIalaisYfzcZJuVRm22ldwDkBTL
	2JH9tfeQhtzIO+SPzGlLvh3g==
X-Received: by 2002:a05:6808:d50:b0:464:5aa:32cf with SMTP id 5614622812f47-4649f01f7fbmr2640192b6e.46.1772122122920;
        Thu, 26 Feb 2026 08:08:42 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb35290fsm135998b6e.4.2026.02.26.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:08:42 -0800 (PST)
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
Date: Thu, 26 Feb 2026 08:08:40 -0800
Message-ID: <20260226160840.1220006-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aZ_-m7vSUPrzDj4n@tiehlicka>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14438-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: AE1791AD6CF
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 09:04:43 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Tue 24-02-26 08:13:56, Joshua Hahn wrote:
> > Hello Michal,
> > 
> > I hope that you are doing well! Thank you for taking the time to review my
> > work and leaving your thoughts.
> > 
> > I wanted to note that I hope to bring this discussion to LSFMMBPF as well,
> > to discuss what the scope of the project should be, what usecases there
> > are (as I will note below), how to make this scalable and sustainable
> > for the future, etc. I'll send out a topic proposal later today. I had
> > separated the series from the proposal because I imagined that this
> > series would go through many versions, so it would be helpful to have
> > the topic as a unified place for pre-conference discussions.
> 
> yes, this is a really good topic to bring to LSFMMBPF. I will not be
> attending this year unfortunately but I will keep watching progress on
> the this. I am really sure there will be people in the room that can
> help with the discussion.

Hello Michal, thank you for the encouraging words : -)
Yes, I am sure that the audience will have valuable ideas to share
as well. Hopefully I can catch you at another conference!

And by the way, I've sent out the proposal here [1] if you are interested!

[...snip...]

> > > This assumes that the active workingset size of all workloads doesn't
> > > fit into the top tier right?
> > 
> > Yes, for the scenario above, a workload that is violating its fair share
> > of toptier memory mostly hurts other workloads if the aggregate working
> > set size of all workloads exceeds the size of toptier memory.
> 
> I think it would be good to provide some more insight into how this is
> supposed to work exactly. If the real working set size doesn't fit into
> the top tier then I suspect we can expect quite a lot of disruption by
> constant promotions and demotions, right. I guess what you would like to
> achieve is to stop those from happening right? If that is the case then
> how exactly do you envision to configure the workload. Do you cap the
> each workload with max/high limits? Or do you want to rely on the
> low/min limits to protect workloads you care about. Or both? How does
> that play with promotion side of things.

Yes, thrashing is probably the biggest concern with the actual performance
if deployed to a real machine. I would like to add that this is
(arguably an even bigger) problem without this setup as well.

Once again on multi-tenant hosts, if we have three hot cgroups whose
workingset size consumes all of DRAM, and one cgroup whose memory is
colder than the other three cgroups, then it will constantly face
thrashing as it has to compete with the other cgroups for hotness.

So the question is whether the thrashing happens to a well-behaving
victim cgroup, or if it happens to the ones whose workingset sizes are
too big.

I also have two qualifying points to add here:
First is that the effective toptier memory limits is not visible to the
users. So when they are designing their workloads, specifically on how
big the workingset size can be, they have no idea how to tune it. So
cgroups that appear to be well-behaved and whose total footprint is
within its memory.high threshold would still see reclaim activity.
Maybe the solution is as simple as exposing the toptier memory limits
as a new sysfs file? But I'm hoping that there is a more clever way to
do this that doesn't add more sysfs entries to the cgroup interface ; -)

Second is that there are scenarios where on a relatively idle machine
with just one cgroup where memory.high, memory.max << toptier capacity,
we would still see reclaim activity. I would argue that this is not
so different from having a cgroup go into reclaim on an empty host, 
even when there is memory avaialble.

But I could also see the argument that those two scenarios are different.
What do you think?

[...snip...]

> > In the original cover letter I offered an example of VM hosting services
> > that care less about maximizing host-wide throughput, but more on ensuring
> > a bottomline performance guarantee for all workloads running on the system.
> > For the users on these services, they don't care that the host their VM is
> > running on is maximizing throughput; rather, they care that their VM meets
> > the performance guarantees that their provider promised. If there is no
> > way to know or enforce which tier of memory their workload lands on, either
> > the bottomline guarantee becomes very underestimated, or users must deal
> > with a high variance in performance.
> > 
> > Here's another example: Let's say there is a host with multiple workloads,
> > each serving queries for a database. The host would like to guarantee the
> > lowest maximum latency possible, while maximizing the total throughput
> > of the system. Once again in this situation, without tier-aware memcg
> > limits the host can maximize throughput, but can only make severely
> > underestimated promises on the bottom line.
> 
> Thanks useful examples. And it would be really great to provide an
> example of intended configuration (no specific numbers but something to
> demonstrate the intention). Because this will not be just about limits,
> right. It would require more tweaks to the system - at least numa
> balancing (promotions) to be controlled in some way AFAICS.

Definitely. Two components that make sense here would be to throttle
promotions when toptier is facing cgroup-local pressure (reaching the
limit), and to also have some background balancing between the two nodes,
maybe by kswapd. I'll be sure to include some of these along with
performance numbers in the next version. 

[...snip...]

> > Fixed mode is what we have here -- start limiting toptier usage whenever
> > a workload goes above its fair slice of toptier.
> > Opportunistic mode would allow workloads to use more toptier memory than
> > its fair share, but only be restricted when toptier is pressured.
> > 
> > What do you think about these two options? For the stated goal of this
> > series, which is to help maximize the bottom line for workloads, fair
> > share seemed to make sense. Implementing opportunistic mode changes
> > on top of this work would most likely just be another sysctl.
> 
> To me it would sounds like the distinction between max/high vs. low/min
> reclaim.

Ack. Makes sense to me.

[...snip...]

> > > You seem to be focusing only on the top tier with this interface, right?
> > > Is this really the right way to go long term? What makes you believe that
> > > we do not really hit the same issue with other tiers as well?
> > 
> > Yes, that's right. I'm not sure if this is the right way to go long-term
> > (say, past the next 5 years). My thinking was that I can stick with doing
> > this for toptier vs. non-toptier memory for now, and deal with having
> > 3+ tiers in the future, when we start to have systems with that many tiers.
> > AFAICT two-tiered systems are still ~relatively new, and I don't think
> > there are a lot of genuine usecases for enforcing mid-tier memory limits
> > as of now. Of course, I would be excited to learn about these usecases
> > and work this patchset to support them as well if anybody has them.
> 
> I guess a more fundamental question is whether this need to replicate
> all limits for tiers or whether we can get an extension that would
> control tier behavior for existing ones. In other words can we define
> which proportion of the max/high resp. low/min limits are reserved for
> each tier? Is that feasible? I do not have answer to that myself at this
> stage TBH.

In terms of feasibility, I think the easiest would be to enforce limits
based on capacity, since this would let us get by without defining
per-tier per-cgroup limits. So for a 4-tier system with capacity of 200G
and at each tier,  100G : 60G : 20G : 20G, and a cgroup with a 50G memory.high:

tier0.ratio: 100 / 200 = 0.5		tier0.toptier_high = 50G * 0.5 = 25G
tier1.ratio: 60 / 200  = 0.3		tier1.toptier_high = 50G * 0.3 = 15G
tier2.ratio: 20 / 200  = 0.1		tier2.toptier_high = 50G * 0.1 = 5G
tier3.ratio: 20 / 200  = 0.1		tier3.toptier_high = 50G * 0.1 = 5G

The alternative would be to have 4 sysctls here to set limits which...
doesn't sound too fun ; -) And I'm not entirely sure if we want limits
per-tier anyways. For most scenarios I think it should be enough to limit
how much to protect or limit toptier usage.

> [...]
> > > What is the reasoning for the switch to be runtime sysctl rather than
> > > boot-time or cgroup mount option?
> > 
> > Good point : -) I don't think cgroup mount options are a good idea,
> > since this would mean that we can have a set of cgroups self-policing
> > their toptier usage, while another cgroup allocates memory unrestricted.
> > This would punish the self-policing cgroup and we would lose the benefit
> > of having a bottomline performance guarantee.
> 
> I do not follow. cgroup mount option would apply to all cgroups. In
> sense whatever is achievable by sysctl should apply to kernel cmdline or
> mount option. The question is what is the best fit AFAICS.

Yup, you're right. I mixed it up in my head and got confused, in terms
of functionality I think kernel cmdline and mount option are same.

Actually everything except for runtime toggle makes sense, since this
requires the system to do the additioanl per-tier accounting even when
it is disabled. With kernel cmdline we can tell the system to completely
ignore the per-tier accounting and enforcement and the user faces no
effects at all (except well, the additional cacheline in struct page_coutner?)

Anyways, thank you very much for your thoughs and encouraging words.
I hope you have a great day, Michal!
Joshua

[1] https://lore.kernel.org/all/CAN+CAwNwpjRf9QhgAEhBQZD7r7sXCzLXqAKbNrPeMEq=7bX8Jg@mail.gmail.com/


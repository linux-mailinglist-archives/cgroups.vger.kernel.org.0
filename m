Return-Path: <cgroups+bounces-17202-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JRPBEpDqOmpNLQgAu9opvQ
	(envelope-from <cgroups+bounces-17202-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 22:20:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F616B9EE7
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 22:20:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="j7/Hk6mG";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17202-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17202-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD44F301D324
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C431396B76;
	Tue, 23 Jun 2026 20:20:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218C393DC0
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 20:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246017; cv=none; b=Z20/r0T5jwkdtFdzHvhWZDWaxJeqrN3VMCZ2KK16M23kF7IN3+X/GZGt+zYE0LiL9+L600dJJClURu+8arjLjZ1yqxiVUIAzXMlzDNMtznVFRgo6RevdyTnfwG+OpcO/5nJdvYbAsfG54oAkUniq6M3vjEvIfeJU8402nNYyDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246017; c=relaxed/simple;
	bh=KqtOpSSTVlbth/Rv52sXptXvEZmrsi/uigN1jugU9/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7jQCfWl+ze3wbXxlk/IGjGtGg1u6yo+tAHPY6NMjcfbtRD+sZVhaUDsjzkDmGeCAbe5HDEfjTU79fJe+pddKun9Y4zSO6gKcFg3MI+3SRVKBqNECClDv/wVUlJUQR3H5JW8Yi76kOSU8Mb+lgD2JwjAHyFUo7Vwqcj8Renu99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7/Hk6mG; arc=none smtp.client-ip=209.85.160.43
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43fc82b52afso228402fac.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246015; x=1782850815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlda4oAsQumV8NATBu2dETgjrgOcL8S9Z7OS1/x6sqE=;
        b=j7/Hk6mG6Eu3cONOKdjpD0NMIInK/p/0Ui773rFYXriIZqIVRWnDU9Fc3/QUnu6eZ7
         wrdzBpUhIKRGOZID4f3TgNSv5fT4ZjGo2oVtIwTtQZ25w6NQsBdcFVR5wWfrx7Qba6uJ
         ksm5kpC6YFV5tTnWZEuSpKVfSE+/lvktAjBWyoYgyIZvn1Nvi5ZQhiGm4AZE7qvdDJiR
         XuSdGjvUILdqoiy4uCIZGWtAMcgI9bsvZEqIbTNfjL8Zmt0kAl5n8d51KuVJYnThyt0v
         AcVC0eIaXU3O9PspyUh33yJBW8VWM5QVb47Wid++Y7v7cz4AsWPbr9R239A8kA5g5GYJ
         rJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246015; x=1782850815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dlda4oAsQumV8NATBu2dETgjrgOcL8S9Z7OS1/x6sqE=;
        b=hTOFYOF1c4PbOmn4ggDyRcleAYcsZn/0uu8tpLNT43Eq90g1w4eA50+cGZdNPnKC35
         XrpBMP1isoYg3hKpp00rmcSGZXT72q/Iu3zlBp7wpOvPD0gnBoAkOaVon+8N166pMbg9
         lazrZ+KLLOudugjekHvY+pOYiwE30eEbH040hmTp9ytwpGp0fZq4ci5VjbFXRPHnLND4
         95n30tyf+w9U/Kij80FWdZkZG7DUUaEHMnztztCzydKtmDmoFLIBsQBLukl061kJ+h/F
         WfHmpv3Ye+bqoC5UzgUONfMudnITYBAC7MQP3Af5cnSAEw5fCBIGSRDrPnOV/KLErXns
         +KBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tGjJWbx/Tv0TEthU7uvoshRfoIXE06M9VnEHKqUTS3nP0jtRB2lDC1LSRcIuBbUaQ8JGsh1z1@vger.kernel.org
X-Gm-Message-State: AOJu0YyBt5wlxPs17AxCO5zyQHKIkrVfP9j5q23r5qHgVu3T4nnSchdI
	2hEQxFkbtwt4uwlZ7IxMq+Da4HxaITVeaivrp9n3IPwiYLfWTLt8LCGf
X-Gm-Gg: AfdE7clmkwko+2FcFN5aHaj8A+2QLjDgTxFegs35NNXHkKKa5OgiduRtstUIiq3gFeT
	0QPXeRtGtAMD497es5AALwTRXm8oArtGG+cqmL0uqqV7qR90Q3lVeHkCMLYFNDsu3MeI75Dpwj1
	FKXbVYxdZCo1eS68VuPBss+xI2XrqtdU50t5eAIx92G3L9mYVbK5DM2Fj40BjJH+vGIuXlBSP72
	5A5RFpFfWm48dRGD0G8eN0j2B8ZcTIJAF2el+CqY9vdKAga6FjPRVLJuNUBL6+lSvQ05juTgxxp
	jlicO7MIDGXjTHb0CAOOOJn450FwkdZz2WqTcUt/07LddkRErqhd1hSwgMYwXk61MQjJi0iHqwa
	zbwzv8PduuI5J7Xv9pt6kKUUvuYuae2c/xCBMva+2wR+zzy6CbqCuhY2Ct2cvmqcxx7A4zxVBQR
	QW4wMnmght/+sylbApH4G4A0anSRf61Xxk9kqrM0QjUR0=
X-Received: by 2002:a05:6870:3c8a:b0:447:3081:a4c5 with SMTP id 586e51a60fabf-447dcdd5400mr288139fac.10.1782246014730;
        Tue, 23 Jun 2026 13:20:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472efa8860sm8765027fac.9.2026.06.23.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:20:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Youngjun Park <her0gyugyu@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
Date: Tue, 23 Jun 2026 13:20:10 -0700
Message-ID: <20260623202012.2446676-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO9r8zPwHYj284gyyjqnH6Z-NNLLbftKqzoOKycaMzm3+ifSdA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17202-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,memory.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91F616B9EE7

On Tue, 23 Jun 2026 13:06:10 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Tue, Jun 23, 2026 at 11:56 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Tue, 23 Jun 2026 11:10:32 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > > > To get back to the question of how the auto-tuning should work, the
> > > > main question is to which ratio we scale the swap limits to.
> > > > Do we set the swap limits proportional to how much swap is present
> > > > in the system, or how much swap is available to the cgroup?
> > > >
> > > > So if we have 3 swap tiers A, B, C, with 50G, 30G, and 20G capacity
> > > > respectively, how much should a cgroup with swap.max = 10G have if
> > > > it is limited to tiers A and B?
> > > >
> > > > This is what I was getting at earlier when I said we have to calculate
> > > > different ratios for different cgroups, based on what tiers they have
> > > > access to.
> > >
> > > That's a good question. I think the case that is particularly
> > > interesting is whether or not the limits of other tiers should change
> > > when another tier is disabled/enabled.
> > >
> > > So basically in your example, assuming everything starts as "max",
> > > when swap.max is set to 10G, the autoscaled limits would be: (tier A,
> > > 5G), (tier B, 3G), (tier C, 2G). Now the question becomes, if
> > > userspace sets the limit of tier C to 0, should the limits for tiers A
> > > and B change?
> > >
> > > On one hand, it's simpler to just keep the autoscaled limits unchanged
> > > in this case. However, this means that the effective swap limit is now
> > > 8G, which is not great :/
> > >
> > > The alternative is to recalculate all the limits when one of them
> > > changes, in which case the limits of A and B would change to 6.25G and
> > > 3.75G. But I don't know if this will work well if we allow custom
> > > limits. What happens if the limit of tier C is written as 1 (or 4096)
> > > instead of 0? It's effectively the same scenario, but the tier is
> > > technically allowed.
> >
> > I think the one problem with this is that it becomes quite easy to
> > accidentally overcommit. As a toy example, if you have 10 workloads and
> > 100G swap (as in the example I gave above), intuitively setting
> > swap.max = 10G for all 10 workloads shouldn't ever cause any contention
> > on capacity. But if you start excluding some tiers from some workloads,
> > you actually get overcommitting on the tiers that can service the
> > most workloads.
> >
> > I am not sure how concerning swap overcommit was, but at least in the
> > memory tiering scenario accidental overcommitting of toptier memory
> > seemed bad enough that I wanted to avoid the problem entirely.
> >
> > > The more I think about it, the more I realize it may be best to drop
> > > the autoscaling thing. I imagine memory tiering might run into similar
> > > issues too :/
> >
> > And that's why I didn't include opt-in/opt-out for any of the tiers;
> > if you have system-wide ratios, there's no need to change the ratios
> > at all, and as long as the sum of your memory.limit for each workload
> > is under the total capacity, all tiers will also not be overcommitted.
> 
> I think eventually there may be use cases to opt some memcgs out for
> some memory tiers. For example, limit sensitive workloads to the top
> tier (or vice versa).

Yup, that makes sense to me too.

One of the things that did concern me a bit with my model for tiered
memcg limit was that system-critical processes would also be susceptible
to being demoted and churned, when we would much rather make sure
those are kept protected at the toptier.

> > Now, all of these complications aside, I think we might be overthinking
> > a bit here : -) The auto-scaling should just provide some sort of
> > "reasonable" default, the users can always override the per-tier
> > limits if they are unhappy with the autoscaled values.
> 
> I agree, but it seems like both options are not ideal here. I think it
> might make more sense to not present a default value at all, have
> "max" be the default for all the tiers, even if memory.max or swap.max
> isn't. Userspace can set the limits if they need to. Autoscaling the
> limits in userspace should be easy.

I like this idea a lot. That would basically make swap tiers a no-op
unless you opt-into setting the limits yourself, so we don't run the
risk of accidentally enabling tiers.

On that note, maybe it makes sense for me to change my
memory tiering series to also just not present a default setting for
tiered limits, and instead just set them as max until the user comes
and configures them?

I think this is a better question for the memcg maintainers, who might
have more to say on this. Johannes, Michal, Roman, and Shakeel,
what do you guys think? Could an approach to just make the memory
tier limits writable from the get-go and not expose any defaults
make sense to you?

I think that would simplify the code quite a bit and also help mitigate
the possible side effects on system-critical workloads.

Thanks!
Joshua


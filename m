Return-Path: <cgroups+bounces-17198-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X/yzBtvWOmoeIQgAu9opvQ
	(envelope-from <cgroups+bounces-17198-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:56:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B66B98B8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y2dwX7wq;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17198-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17198-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5C9302C167
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C534D916;
	Tue, 23 Jun 2026 18:56:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343192DF15C
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:56:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240982; cv=none; b=rOXKNDQEo9u50AqDE7OOYECe2bqxYPS7mdzemFbMoPBlF5/RUvF37Ssos1nQCFIU7jLFDdUVHHZ1ujPfEMmrr5Bh0Q3hYYyeKxJgUMymQB8m+xNxLpCw5dWVfSdsZeoCX1bHElUOTb8abZMHPzEf2NAk1Dg9gjSu9qOjUXXwl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240982; c=relaxed/simple;
	bh=f8lp6baf6Q2p8c0zIqoCYZYPwEqpstqLIfWZK2LtHJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9/N8syBdOjpWYv1nRfwNmaXeCqE5ajuQnHK9U53JEdeQ/vVrpDM71CceJ8A2IibJBZDCSPFHPxBYmc+0+hIMlb09g1qCjFE2lKzsjTU523mFdmgSLZyO8LVUOTWZxI3n9iLuPehxDB6doHRYAeYeOfZDPeWVEZ00kjUKDrUKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2dwX7wq; arc=none smtp.client-ip=209.85.167.180
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4877b2c9e9fso247436b6e.0
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240980; x=1782845780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J+ANK03VaN7rdpDI6tnomDHkaUzerJG7W4wHHMwOJo=;
        b=Y2dwX7wqdZCD55xSWyO/DJqMoZkLB8/l7gIEWvcfmzrCLYtLYIndRUzxVUw2RwdK0T
         RBFzRj5ol1Xaqhlr2dz+KYAzUDvhjhV9L7WmChr1Lx3tELhG3TOSSsYQrhWfftzAWju1
         YttlBOAtuIE+9mmnS+JG4cgFIKuhNpl2bLDEfm50qesSiOTDoezpI7AoJ2AGhkyDrQjU
         N4CQkB1DZPy1oljVRUrYhzBDrlfTsyQNl/ZcogmKSmmIaAAXoF7wett2Ed1BKuTIGpqy
         ZD9rfaPnjIeyJBowuBek8/QwTolFEURoJOgoEwiQXNSroh5k3CZdG+JHLtiRfxZUVmZK
         JKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240980; x=1782845780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6J+ANK03VaN7rdpDI6tnomDHkaUzerJG7W4wHHMwOJo=;
        b=JH/ms/0pG79+sI3fDoG5EUgpLR5+KgP8+wrzSTUiJDFrdyLHn0/TGDACEAIm8kqR5x
         r8nz/TtKhqgYDN77/JQkhuJc5zN8laezuj18dC6POb+BT0R+Bc61XwGi4oKQM1K/IY1T
         r6EyZ32/InDFslYPKtMXam2tNRU9a2RKCoQ8BxGfwoH702ugqmfLqpuWBkUf950vZzUb
         WK74MqkBnkrdKyFquk4hP6FJF5IHXCOZ25jxDEigDkYZo8BkudqMSwbxJ0OqL8kXRN3e
         EThm/uY0QdH0ZH27hlGUU71q/u8j1RtwrLiqHm8MKupl47CKKVus/+9W8kuzsJ6vbBUu
         UoKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ibjp3H6mokFQI6dqwycAGNRznVuvWbVjHocrPVwPD5mOi25XzgAcxoVMG7hxI0GPtjXgRRwOu@vger.kernel.org
X-Gm-Message-State: AOJu0YygFjTANgAJ/SLwD/Sjhwam9iu+syDLeqG12B8AVe6la0lk0VLV
	17SzPk8/ZZQCyaZrkA0mB7cjOzxmbMajD5xSw84DyxzU2NlcTHB+2P36
X-Gm-Gg: AfdE7claSOm2OSWXyLnOpkcwAobdesQLHx6Hzon794BYhWmekxPfUNZ7chDT5EvCdA1
	sQ/6VZlfuK51OSXzYhgWeL9SHk/UP2yYla7zski7HaEjy9rS+eJ9rD+xmyqFreIHcSqD928K+fu
	eqya9oVUoZLB5iCPip9jvlOHoomE+iT4f9a0+XzwU4I1y3Tr+EgPxxMtui0mVOCZnA+fz3DK6Rt
	e9mcqb+ewx08PExF6Set5kobPnYubfVyBvGC64jsXuTyDu1vQ47m39s1BJ3YNG+VqTNs1k9ddXA
	hVRuhjSmCP8+ONv86hstZJ8u/lVxbOU+zHSUhXYO7ZE3Jf7sMjbsL6KfIef/TeDoqpwfNAMGWx8
	0of7KrINQXpkL5STT2ymyHlkqPPgF+iKky+rUidsPz52ppBSKhgf22NOnKAoHPx0EJdA43jW7XA
	mH29fE0D/8AlC9g3D3XeS+yDbZ2kimwTQeFaOZMiTwPA==
X-Received: by 2002:a05:6808:7008:b0:487:5613:1f with SMTP id 5614622812f47-4907a57addemr445b6e.27.1782240980141;
        Tue, 23 Jun 2026 11:56:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0e5e53sm6944307b6e.8.2026.06.23.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:56:19 -0700 (PDT)
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
Date: Tue, 23 Jun 2026 11:56:17 -0700
Message-ID: <20260623185618.1488231-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO9r8zOQQwDxmHGsRw_9k2eu6r=HU_HiXxbB4cbpwhc1GGgHOw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17198-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,memory.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C7B66B98B8

On Tue, 23 Jun 2026 11:10:32 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> > To get back to the question of how the auto-tuning should work, the
> > main question is to which ratio we scale the swap limits to.
> > Do we set the swap limits proportional to how much swap is present
> > in the system, or how much swap is available to the cgroup?
> >
> > So if we have 3 swap tiers A, B, C, with 50G, 30G, and 20G capacity
> > respectively, how much should a cgroup with swap.max = 10G have if
> > it is limited to tiers A and B?
> >
> > This is what I was getting at earlier when I said we have to calculate
> > different ratios for different cgroups, based on what tiers they have
> > access to.
> 
> That's a good question. I think the case that is particularly
> interesting is whether or not the limits of other tiers should change
> when another tier is disabled/enabled.
> 
> So basically in your example, assuming everything starts as "max",
> when swap.max is set to 10G, the autoscaled limits would be: (tier A,
> 5G), (tier B, 3G), (tier C, 2G). Now the question becomes, if
> userspace sets the limit of tier C to 0, should the limits for tiers A
> and B change?
> 
> On one hand, it's simpler to just keep the autoscaled limits unchanged
> in this case. However, this means that the effective swap limit is now
> 8G, which is not great :/
> 
> The alternative is to recalculate all the limits when one of them
> changes, in which case the limits of A and B would change to 6.25G and
> 3.75G. But I don't know if this will work well if we allow custom
> limits. What happens if the limit of tier C is written as 1 (or 4096)
> instead of 0? It's effectively the same scenario, but the tier is
> technically allowed.

I think the one problem with this is that it becomes quite easy to
accidentally overcommit. As a toy example, if you have 10 workloads and
100G swap (as in the example I gave above), intuitively setting
swap.max = 10G for all 10 workloads shouldn't ever cause any contention
on capacity. But if you start excluding some tiers from some workloads,
you actually get overcommitting on the tiers that can service the
most workloads.

I am not sure how concerning swap overcommit was, but at least in the
memory tiering scenario accidental overcommitting of toptier memory
seemed bad enough that I wanted to avoid the problem entirely.

> The more I think about it, the more I realize it may be best to drop
> the autoscaling thing. I imagine memory tiering might run into similar
> issues too :/

And that's why I didn't include opt-in/opt-out for any of the tiers;
if you have system-wide ratios, there's no need to change the ratios
at all, and as long as the sum of your memory.limit for each workload
is under the total capacity, all tiers will also not be overcommitted.

Now, all of these complications aside, I think we might be overthinking
a bit here : -) The auto-scaling should just provide some sort of
"reasonable" default, the users can always override the per-tier
limits if they are unhappy with the autoscaled values.

In fact, maybe it even makes sense to have sum of swap tier limits >
swap.max.

(I actually recall having a really similar discussion when I was working
on weighted interleave auto-tuning a year ago, on how weights should be
set when switching between manually-set limits and relying on
auto-scaled defaults [1]. I don't think there's a need to follow this
convention, but we should think about what the expected behavior should
be if a user manually sets a limit, but later wants to go back to
auto-scaling limits). 

Anyways, I think these are important questions. Youngjun, Nhat, Shakeel,
any thoughts from you all? : -)

[1] https://lore.kernel.org/all/8734hbiq7j.fsf@DESKTOP-5N7EMDA/


Return-Path: <cgroups+bounces-17164-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XRKyHirWOWovyAcAu9opvQ
	(envelope-from <cgroups+bounces-17164-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:41:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCB6B3038
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:41:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G2LXhw7I;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17164-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17164-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A6A23034B33
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41178384CCD;
	Tue, 23 Jun 2026 00:40:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F7385516
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 00:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175223; cv=none; b=J4yWtSyU69vUUdZY7yEqPFxbyKHLmaW9I4Q2UaO+poRW/5dvXrOAIWFK1lhodA/7e9rIUUdGQr5F3t4JjSCZdPAbWiUaJ+5ohKMG2AaS445vcCG6Hn7xAP1JoT2JW9UXXpUIYFoSf4z6QPXPYm63XBlySa0IZPBLquw/ynep46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175223; c=relaxed/simple;
	bh=8Ma0gQVNTcv+IfJ75yhGUGafUNM9eQ+Z9QNdgtcMMlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhT1/1/mAgyMxv6oYjhb1Sos4tRGxq5kYRb0tWmw4bNGK1lpW+YFcDkBZDaG0ui/xYnRRYkNdScHuhaoSmX80+rYHbrGkrEjvX5yTFBgYI9hgPDOVO+cWg4J7ZfMvox1hT7LR42eNKK8DhPv6X3oCqIU/3Ykg3p/PlsuP7LY/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2LXhw7I; arc=none smtp.client-ip=209.85.161.46
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a1133217easo188781eaf.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782175221; x=1782780021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2f1vIQGRwaVINXfqVMqUzfca2k+PegWVGEvoxiBw6w=;
        b=G2LXhw7IXho1SiFpVNUmHUMjwD8HgPEVtcknesXQiF+Rrr2443boPsdemw5M0qt6HM
         tsU3FG1jItWTwgu2uTGpwT2a7/1JBDC2fLrOOHRulL+M0IRxxOs+5Pd02x8iSOClxuDB
         8r5sNuG7ntgQ5c1wz6WJDYsmPLXjmtxy0MyWJbfBQU5/luU1CoSx7vwPkHaMG6MPzpcM
         mn8Ic9gf1YCo2vClPdvgZLanK03lzZbeCT6TfYXTV2cnxbDKfC3DRo2MgtGrdpTlHEHL
         PDL0ThNa+8YTlkgGmGlU/YzmkJ8rhrulefef8FqTyTxDd3P1OFVb1cpAhSvYqqo8HmZW
         OIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782175221; x=1782780021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2f1vIQGRwaVINXfqVMqUzfca2k+PegWVGEvoxiBw6w=;
        b=Xf4Lk9p8Q3MOKkKaH6tNN4eNq1S0TMzfO1b2FiHp3MohG1vu78KjZM9+49SIAKxccG
         2Z1r0k547c0L6rQ9dZOxuXLUTWBTNm7hf+UUa8+JwjV8Uhwa63XS2Z00ahnyZbABC7du
         +xeiN3WAP85vHzCvvTS7ncLYDJggWPTrsne90Sb8AXhso7idSwNpy6cTSCUOoX/sWoFq
         iwknZ360ZvRHNik2Zx9uLSPmDxl6nuwuMhsqSv+ItXsdosgRybP1fCEiKL8cOcB8jKII
         NLiLtoeA9CYINb44sTaVNwfF8T8XDTaS8+puyRDJT54nsA1yFY/4C7MF80d2PkhVf391
         F1rA==
X-Forwarded-Encrypted: i=1; AFNElJ8HQaAUPDHi12aW3zHNX1gAET1aB6BZTveHS1vfpaAWLAGm6yAiqawJAe2fRnVPCYS75jML1GeD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+G0OHIKIL8i03XPQAYN8M2UcwtjF05IRiTaN4VLrYC7+n3LL
	/cCDP4UDuGkyyBryD2vHxTz2QJPuKFNPdr5HspxHzbtpsMFkEhUdGgz3VSO8VtU2
X-Gm-Gg: AfdE7ckZVWBpR5tdOwjub2OOvSooVelDfgfK+7dvNq46TeiKgf+f2wirBscuZg8k62H
	h3wAbV1WNIFHmuIHrBCgALM/y04szpzM7Vn9t9Gm7GOV7Qw/voYGU2U98iAsDmSMFNezfNMcE40
	7YhNWRPpltVaSykcACwVznUyk8wZdbfhW2c4uNb+4NqWpWDF407Ekl8IG5zN8FrO0oeF7/7iIWh
	5TuOmrkxlbSc6u17EPRIYr408vczm0GE/iLYbUG1/aXDeNzoOt4gve+3XX3feNtenVsmc87Jjfy
	2eLvjH4xysMr/5WR0cFA8zxn5O7emHBRqNhhXRkxPIEBBiMDOpyVgnNnFeY0F3s6SIsbeVGxIvr
	jAYyAuul+ixKRM2alrkEkB+1BiTE2MDhT0bJuQLO29INcKVEA0yuovBmMv64sOtChswAA2yLoaF
	jNOdI27s4WFPVI3UcyBCMUBFuk6IUJgd+qOxpmGEBHSACAWv1bu2XJsg==
X-Received: by 2002:a05:6820:16ab:b0:694:a1d1:f363 with SMTP id 006d021491bc7-6a114b59217mr673249eaf.15.1782175220586;
        Mon, 22 Jun 2026 17:40:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0475e3sm7140080fac.16.2026.06.22.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:40:20 -0700 (PDT)
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
Date: Mon, 22 Jun 2026 17:40:17 -0700
Message-ID: <20260623004018.1864121-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ajnIasdb6j6yDUdy@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17164-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0FCB6B3038

On Mon, 22 Jun 2026 23:46:31 +0000 Yosry Ahmed <yosry@kernel.org> wrote:

> > > > If that is the case, I think auto-scaling makes sense but can be a bit
> > > > tricky, since there is no universal tiered ratio; each workload will
> > > > have different tiers it can swap to, so they will all have to calculate
> > > > their own ratios. Tiered memory limits escapes this difficulty since we
> > > > assume all memory can be placed on all tiers, so we have a system-wide
> > > > ratio : -)
> > > 
> > > Hmm I don't follow. It's also possible (maybe not initially) that a
> > > memcg cannot use specific memory tiers, right? I am not sure what the
> > > difference is.
> > 
> > You're right, I was speaking more to the current state of memory tiers.
> > The majority of the feedack I received was that we already have too
> > many memcg knobs, so I just opted to make tiered memcg limits a
> > cgroup mount, with no ability for individual memcgs to tune their
> > limits or opt-in/out.
> 
> Right, I think this is similar to the approach taken here. We have a
> single interface for per-tier limits. The main difference is that we're
> allowing 0/max values to disable/enable different swap tiers per-memcg,
> as there's a use case for that.
> 
> Seems like for memory tiering there's no use case for that yet.

Yes, I would agree with that.

> > What do you think Yosry? Would it make sense for us to be able to 
> > tune these values? Personally I think it makes sense but just wanted to
> > make the basic features merged before I went to push for making those
> > knobs tunable.
> 
> Right now we're not proposing to allow tuning swap tier limits either,
> just enable or disable a tier. My main question is about the default
> values.
> 
> IIUC, for memory tiering, if you set memory.max, then the limits for
> tiers are auto-scaled. I think it makes sense to do the same for swap
> tiers for cosnsitency. Or am I wrong about the memory tiering limits
> behavior?

No, you're right about that. Sorry for steering the thread to my 
series ; -)

To get back to the question of how the auto-tuning should work, the
main question is to which ratio we scale the swap limits to.
Do we set the swap limits proportional to how much swap is present
in the system, or how much swap is available to the cgroup?

So if we have 3 swap tiers A, B, C, with 50G, 30G, and 20G capacity
respectively, how much should a cgroup with swap.max = 10G have if
it is limited to tiers A and B?

This is what I was getting at earlier when I said we have to calculate
different ratios for different cgroups, based on what tiers they have
access to.

Sorry if that doesn't make sense, please let me know how I can
elaborate!


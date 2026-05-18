Return-Path: <cgroups+bounces-16033-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE9SO5cTC2o5/wQAu9opvQ
	(envelope-from <cgroups+bounces-16033-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 15:26:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092156D973
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30CD303CA41
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90F43E4B1;
	Mon, 18 May 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jTuvA+kW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A53D47C8
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110520; cv=none; b=NX7ZqGJEpZiq4Ce0HDfc767OVCD8aXngBcjIoicr/eJ1+BpXh5sFzTPM/TACWGVU7leNWuNQo6zh7AhzFr4zEUbEQjohHBZ2jMsejzsKMhrS+nytnd6j7OCRYwAVwLAn47ygI7Ttvd1Oav7a+x91v+aP76awiloKdD1UD7MSkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110520; c=relaxed/simple;
	bh=6UYKcNQm72GyMtIHNlGEBzktPmOrdk1rsDS7GHVaUkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaLbLUxaKVwMIR102Y/ANl1iCbrNJid1QtBLVfTeVPxHZZFTHYyk1u+uBEhsLIzYMCCBh8VULVJgfUG7elmbJ/9CCMiwoxTSrMVoveujB670rg+0MnATgLMoMWiYk1zJj19on3oUmlFB00COzVrcmmil5HJpZ7UwDYbfdyjMj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jTuvA+kW; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-911dfc86903so278375585a.3
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779110517; x=1779715317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8m8UOlb8bhby27tmt+X53ydiTiMfQFdaV5Cc51ilhA=;
        b=jTuvA+kWugyK6f9p5WvbDeFreke58EEHjGPORKXApuMoP6WCDSXpp3sT3u66mRGRKB
         XPdpi5FlOqClECih+QFbUaDRAUrJUgwxy2UH2tuee6ytRyW+ab626k+lZQDfzyaMWKv6
         6cwCWBg65Mn712RxQ/0yoi/t/iKQMaNpFusFQcQshRumKHWaqt+DSXszXTiFtdbDPx0J
         tNyBxetoL3sij2uze1FWKQPgLWpek9+htjriLRkuwcTv1/vdFWOiE4i3clxeiSR8XzrQ
         MVyDyM8/Ak57qw075Er8xmHQTmkauwQu5wg7vhUhlJH/0OBhW3xY3EdZjgnwpOBcIpZM
         Xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110517; x=1779715317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8m8UOlb8bhby27tmt+X53ydiTiMfQFdaV5Cc51ilhA=;
        b=W9N8QGg2/xaqK+/z84M/M3rkLRp7cUkPNIEwwJamsVZQTDqtx369AX2uQnSN8g9Gxu
         jcCPmUDO8AIqujt7Po3ovdBpbvEvr48VyhXEMiaJrdedJrKgqylngQmJHbdObcoPyN7N
         rQcOVdxEptsPGupFLZAzCcDXPv/rnJbfKVdJ2Z8AuxPUzSOZS17fDuz2tV6ECK0StBfA
         ca14z3OhBtsZCMsRrHpt/hwwNPS53MQj0sowQ4uesZOnSpx0Ax4YuJJ7cpIPCCa42M3Q
         F78UzpCco05UpVAV/0pSXJlLENNO11IrXr2HT2p1b/q1VWxekExPCtT+IktPwsB9TUMW
         zImQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PAMX62s0Hm4xbRabBHlBKUlI5uFp0guinH61hPOLy5HsDst1gVG4IhA7tmCDcevx+Qh6/ldfR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4fj7Re2MNVw5DHD7lkvLii8h+ehQugnuQ+VafQ4AUc9ySPgo
	/vvr3LkCs581xFj+HzHIzsPnAxWPuZK1whtV4oxWYLSMNrkQi8roKuQcRamVFRQeG4s=
X-Gm-Gg: Acq92OF+FHEec0f57gH65D1z0hzjcS7Ofo0zBGHMN9oO0hTfT+yb/YX8HfcYhynYxRf
	2YIa16y/dIKgFmvG0W5cbEUs5uMFHU4PWJpJAoxRfdg0kxgsCYbDsc+RPDgdGHXZLA6FOSkFBh0
	UzW78xSFeJueFOruF3wSzG+Oo7r1tQ21xJmLyNVGcJcuRF3z0fwdpYXDCi8BogkA/EbaXpmi29m
	oUOj8BLzpTp3CAwLFje2xN2Uym1CPAcIS5cTRkQjvI4FqWFh6HLPTmTWZO1BZEG1INDN694wIoS
	sWhyVD+YACX590OC4VPku90aduxdpDMa6kiDqzSRRdntPc3GwBhaeb1XZXxszRMkihtoyPEIHhE
	6ubUYCDbVD9GM/VTD+3IkB1a/uLjPQq076Xh45vHDS7pv0o7euBggP2rinpBr8/XYwxi1wLktfg
	9ovOnDz5VEvLtyKv8FJk3oSqYkM0J2wGPE
X-Received: by 2002:a05:620a:8413:b0:913:c647:fadd with SMTP id af79cd13be357-913c647fdb0mr681606085a.39.1779110517498;
        Mon, 18 May 2026 06:21:57 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf318e4sm1460238885a.32.2026.05.18.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:21:56 -0700 (PDT)
Date: Mon, 18 May 2026 09:21:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: propagate NMI slab stats to memcg vmstats
Message-ID: <agsSdPRDjFwqUdd7@cmpxchg.org>
References: <20260518082830.599102-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518082830.599102-1-alex@ghiti.fr>
X-Rspamd-Queue-Id: 9092156D973
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16033-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 10:28:19AM +0200, Alexandre Ghiti wrote:
> flush_nmi_stats() drains per-node NMI slab atomics into the per-node
> lruvec_stats, but does not propagate them to the memcg-level vmstats.
> 
> For non NMI case, account_slab_nmi_safe() calls mod_memcg_lruvec_state()
> which updates both per-node lruvec_stats and memcg-level vmstats, so
> flush_nmi_stats() needs to flush to per-node lruvec_stats as well as
> memcg-level vmstats.
> 
> So fix this by flushing to the memcg-level vmstats for NMI too.
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Cc: stable@vger.kernel.org
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


Return-Path: <cgroups+bounces-17862-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDVwEjKVV2rQXQAAu9opvQ
	(envelope-from <cgroups+bounces-17862-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:12:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1575F330
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:12:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=cnEFkVeQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17862-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17862-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 696A13041E91
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AFB36F906;
	Wed, 15 Jul 2026 14:10:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3936998A
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 14:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124626; cv=none; b=sk9zynyi7vBC+/InwSvYfKbROYBvqq6DiGy8Mo8N2IjAN2i3MXmyVfmppBGlr43F/5m6mRMSLCS0spBaCY7oGbSM7LIIRl1UgU/1z9dMw9aC6SCcnUOfTAn4ym0lNgfdUdHGE9CW4+SEj++MI+1PmOJ3yqU/5oKYMpQEB/P9nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124626; c=relaxed/simple;
	bh=hc8yMDX9dOnwEROGH/nbWb/48BForaOXcHScoSyTMwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfCwdRMt5SUr2UCBCxKzyLQJDzYS8N7VdGu7I2NRDQKyaBI1BCMoN2Hb9tXnGEP8tJqIai6+O47+Yb3qhI/9iYHTv/PtM6ItG0duqoJaKXNRUWUjNEDuzDF2GBtEIy4gX0EAJ7XVd7PTwnbJQbmoTI06Ein/a9j5uGUp+PHlifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cnEFkVeQ; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476a130c138so2149945f8f.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784124618; x=1784729418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pIsfZleXeVRVmzFEqb2XavBzUBRe+/S77RcLpiiBE+s=;
        b=cnEFkVeQh40WkpFOyO8gGgcQJ8QaxhIKVHKQcPJ2+h/lUkPQVr89UsRe+DYnqB8bpF
         bGSx0/PCIRbI+M8ChEzL77mPdbRGqtMU1e92w9zhoU7lM10jxOvLa0m1N1zu6nnCpN3w
         HCNynbx8460WojiyOqFkEYpD8X14+744RSqGQyMRI/rLE/TiRzsReXzkYkugF8Mrrvug
         NIs3jjhSLT/Q/owIZAMVYdUoeHFnrIuXOAQGdUmsEs4G/k3zt52cpfWNuUD+9mYwrNeg
         aWE9Ql8IBOG9gpcfofpd2y7V2HzafkVMXXGE2CVFfpJmCENhjP0uePAMQDd7aiOtiBby
         WR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124618; x=1784729418;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIsfZleXeVRVmzFEqb2XavBzUBRe+/S77RcLpiiBE+s=;
        b=impu+iO2zGGKgW1RtiNaobR5Xi+nEbbZECFEZFsm3yonWLDyZxUVrG2MhCBe2gMEbN
         /1v+8sLs4AQLKh7NNFcL6S2RErtwDqz17/Qgtz3NtS+yC/lmeAVrFRNvPHP2ZjqqB7/t
         71WanMybPu2r+CPXvLRTbcBFG/6SIZnJugGNfcxRnJEI0MPAW5Rtmor3NmTcAj1q2pGU
         nkz+kZLk2proCswPdP/Ugjg88D9V2JRZ18aiWkre/zOF99RZkJwAZDveUuRbfXvNChSZ
         RXfC8UdmoYDUYPwrxel14rUlFyqzHD+ybkmJQCh5tDsCq49iQKf2MKMnkdSFDNEe6212
         luLA==
X-Forwarded-Encrypted: i=1; AHgh+RoJoJrT2P8HZSsguX99HLrEtSOtkEUnSrbcqfBlswfZRSaDxEgTsIdmhbs+azwm9n3mssgvGMyo@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUfYFlwq4PDdXpMjrHQysObN7oCzINueLCsJ1qiuZ6cQs2ndt
	nS9VvGblM1ZGP9/SqfGEvaOGrHdILQBxSY+RtZ8Y3KzaMlsCySgcOXgl+iydSkVuEVM=
X-Gm-Gg: AfdE7ckak9VPp+v6qMlW3uf7KW/bOi9K6zJzeNimSdhklBIEpA62IwdIVspnPGciuhM
	CY1QzYqtPlZFgXYXCp//NKRV2qneAJ+pST2XjDHrJ7wq48WrGHBs5rhE600tJigS1jdMeTmBr9L
	kbTzzsMQbYWEby97TnsZP6dPNgFi5Mw5NdIsOiS7bX1ZDJ80S+atiAkba+zNdF8OzGno9PnuJ3D
	ANdWyNhjxqfNp7xu6C1HnwPLrb/gaAWlG4QPOFQgqANVF6Afga8Bc8a8XsLJNM2r0bzEwrxX7+f
	aUqbCer2K6P8/55A04sy7Pvpml8lb2WKN5PLHcUV2S1MXFUumgFPNuS9p6O6ITS5Sr927aU9/DT
	hWGASj3TwnQuNxnyXyMo6Clp7a5dB/A2iEpd2UpK2zihM42zLcwXVXqOx8GzXacq11B+MpzB6md
	GC/kJ3dqgWod+AsQ==
X-Received: by 2002:a05:600c:e548:10b0:493:b877:fbc with SMTP id 5b1f17b1804b1-493f881d146mr126677095e9.21.1784124617927;
        Wed, 15 Jul 2026 07:10:17 -0700 (PDT)
Received: from localhost ([2a02:8071:8280:d6e0:1353:8eb8:c84a:b6d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953f643acdsm24454195e9.3.2026.07.15.07.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:10:17 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:10:15 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chrisl@kernel.org, nphamcs@gmail.com, baoquan.he@linux.dev,
	youngjun.park@lge.com, roman.gushchin@linux.dev,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rientjes@google.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm/vmstat, mm/memcontrol: add _monotonic vmstat
 readers
Message-ID: <20260715141015.GP276793@cmpxchg.org>
References: <20260713163443.3562378-1-usama.arif@linux.dev>
 <20260713163443.3562378-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713163443.3562378-2-usama.arif@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17862-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,kvack.org,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:chrisl@kernel.org,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:rientjes@google.com,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:email,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1E1575F330
X-Rspamd-Action: no action

On Mon, Jul 13, 2026 at 09:34:16AM -0700, Usama Arif wrote:
> lruvec_page_state(), node_page_state(), and global_node_page_state()
> all clamp negative reads to zero on CONFIG_SMP so that a transient
> per-CPU delta skew presents as zero pages rather than
> as a garbage unsigned value. This is the right behaviour for
> non-monotonic page-count readers.
> 
> It is however incorrect for callers that snapshot a monotonically-
> incremented event counter and compute a delta from two samples.
> Once the underlying signed long wraps past LONG_MAX, the clamped read
> drops to zero while the previously-recorded snapshot still holds the
> pre-wrap value; the unsigned subtraction then underflows into a
> ~2^31 spurious delta for 32-bit architecture and corrupts the
> caller's accumulator.
> 
> Add non-clamping siblings that return the underlying state value
> cast to unsigned long:
> 
>   global_node_page_state_monotonic()
>   node_page_state_monotonic()
>   lruvec_page_state_monotonic()
> 
> With both samples read via the _monotonic variant, unsigned modular
> subtraction stays correct across a signed-long wraparound as long
> as the true growth between two samples fits in unsigned long
> (< 2^32 on 32-bit, < 2^64 on 64-bit); the 32-bit bound is the
> practically-reachable one that motivates this helper.
> 
> The variants are only safe for monotonically-incremented counters.
> Non-monotonic page-count readers must keep using the existing
> clamped helpers so transient negative reads still present as zero.
> 
> This is a prerequisite for the following patch which
> replaces the producer-side anon_cost/file_cost accumulators with a
> read-side accumulator in prepare_scan_control() that samples
> monotonic per-LRU vmstat counters (PGROTATE_*, PGRECLAIM_PAGEOUT_*,
> WORKINGSET_RESTORE_*) via lruvec_page_state_monotonic() and folds
> the unsigned modular delta into a per-lruvec cost_accum[].
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It's unfortunate that we mix state counts with monotonic events in
node_stat_item. We have vm_event_state for monotonics, but they aren't
tracked per-node (which we need here and for other places in vmscan),
and they can't easily be made so because there are "global" events in
there that don't easily map to a specific node.

So this seems like the best solution for now.


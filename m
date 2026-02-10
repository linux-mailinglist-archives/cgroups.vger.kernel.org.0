Return-Path: <cgroups+bounces-13823-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOV6MrKZimk8MQAAu9opvQ
	(envelope-from <cgroups+bounces-13823-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 03:36:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0081165B0
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 03:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC13730093AF
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E912DFF3F;
	Tue, 10 Feb 2026 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="XPEjMes8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2572DC339
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690987; cv=none; b=cU8aT6yNZ2k8AnfKWGolsymeN578adZcwwi8nPLvlIyRe6DrqyVqLklz6qjP7Bgtd3Bhdj9ZiCDCYp4KQP8J68fFtJXKuPYiBRzufim1u+bkvBbMeSz4FodjctlxdTcEvch2JdadMbpevVQ30WvwVcTt7r/vzoecIDB52bwvdME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690987; c=relaxed/simple;
	bh=x26zTWRCZztFplfzMY9lFckYK/i5zTHyU1H9HRMmxYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B91raP5NE2JMA28E6DzyGC8NFooWo/UkRQV5L6iPkyI/CXdNzWjiKjWebGKSkBBM/OLfpKRqDPMEzYoiLHGefluboxULLUvR2iWqcZWvOc1E6C+NUTvs6rS9vkIZh2OI9VjtAu5GA5yl+wQnuUT+/5pT3X9yox6FmxASouaQvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=XPEjMes8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ca3807494eso28308585a.2
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1770690984; x=1771295784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjDQ6ZMUprUoxKPSBAzYwFLvE0UYKCpqmBg/Zxxlb4c=;
        b=XPEjMes8JmLyeg0/7lSTn+nuGzFQ6Esjp83z8vxDH8vRYKFL3+7NPe+KVskk89Tr++
         L/0PdiId1bsIODT6qYCEft0KOY5BxMPmL9lqUeRjfzoNBzbCeHalEOg6lmZt9ML/YDf8
         vlfcIzlRCW37hb8JNt6fPrPonFDOw+64RfX1egkCMB69QxDYmRZaB3ZCsqbOzWwpZJES
         XpxSnHK3WL6y0Sacx6p7IMgJVmYsIPLaYaEEO6FvhK5ogx15xb/7z7IO7xK7jf/M80jj
         oluLL4RH3KKr4tEPHDGMthYtBzAdWwKpqwZ0uMM8caqmAxB+Hnqz8ZtXiAKSnhQVJxWk
         b5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770690984; x=1771295784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjDQ6ZMUprUoxKPSBAzYwFLvE0UYKCpqmBg/Zxxlb4c=;
        b=f/2EmIyz+EPe/n3JZ14Q/s8+8SKPDZNDf/xsq78GGyCHLoH2bGq7iFsFBuPTdDQlMk
         E89bjefaDy85pWBx5XhCp3IoYUf5d6CoIqoTJAFFY96aNK8E0HMn4bl/3KAdvieBg5oR
         LfFjcTtf6Q7AuJrwCZILDaQ3GSH7hvCOpBhYsZlC+GziRIzaPwj9QtTkmlJPiBmrxirB
         x3GTO9O8qALIjabP1l/LQNQ+NOSefr34Dz7Eq63LlxZKPEqs+8IQe+a7a/1gGv5sGwnn
         YsBsDia+BH5CvlUAaH5sFDd2ucHaQp6XCrXp7LkNNpJmfp/sP+EnGwmgI1sF1oynoYla
         MuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwOq7wwsl1Kgj4oODDolaZPIKSFF41XRlJ2ua+dMolwePTmbKrHyNiyB9+fTyTo52kf8kn2dVz@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxoD1BzmYHkxUHA9M6iKRoeYMFPaXb2wfb9Ji8hYb3jbIGZUU
	FmsXNPud7zCuFSX7BYp43MzPYQV1jOeUxUt1uOdAgVi0Y+5XwtKTjH8Rb8R16xkTjcw=
X-Gm-Gg: AZuq6aLLj6Cs2O4ZDQnbaZXxTE4COq0gEeVwRX78oaf2cj0soG3Qli8r+i4DH1ZK4S7
	6YcBok5CMEtjFopG/3RHKsFBVHyFtBnEBvQ/nPfxM/wa3vNfUGnSagVkzG+yyUnprmxNEOxXtIL
	8fu3mkMm18S4/SWgNoOTKf4wPEsCvG5/AD42Z1KGsCgiXi5kLHGTwVZ2HJHMsbA+Z110ks5X/+p
	706ilNXiREnmxD82LkYJQn4M4Z6IxR+CpDDczFOqHMs8Js9bctkwReRG8KZihxUT3c0DhNGwDZk
	kQhS7IToSVR/uncMuR2h383mlLxSc/48VLOCYbN5cc61+zfEtdFKXBgLEGqda6H4f3SeW5EbDoI
	MI5IBhzLMNByCzoXIPa7gLspWqGlDVGvCmX56xKfFqt80jKcyFxiZqr7mXKT9lxfI/q2uWJq93K
	ASd6M3Fm2h/YlGKFw4yfIHdTbrDi0Yaqk=
X-Received: by 2002:a05:620a:448c:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8caf16ec082mr1704468885a.77.1770690984280;
        Mon, 09 Feb 2026 18:36:24 -0800 (PST)
Received: from localhost ([2603:7000:c00:100:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c03fca0sm89843846d6.28.2026.02.09.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:36:23 -0800 (PST)
Date: Mon, 9 Feb 2026 21:36:22 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	christophe.leroy@csgroup.eu, pavel@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
	peterx@redhat.com, riel@surriel.com, joshua.hahnjy@gmail.com,
	npache@redhat.com, gourry@gourry.net, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, rafael@kernel.org,
	jannh@google.com, pfalcato@suse.de, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Message-ID: <aYqZppn4yDbTP2_q@cmpxchg.org>
References: <20260208215839.87595-2-nphamcs@gmail.com>
 <20260208223143.366416-1-nphamcs@gmail.com>
 <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13823-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,kvack.org,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 0D0081165B0
X-Rspamd-Action: no action

Hi Chris,

On Mon, Feb 09, 2026 at 04:20:21AM -0800, Chris Li wrote:
> On Sun, Feb 8, 2026 at 4:15 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > My sincerest apologies - it seems like the cover letter (and just the
> > cover letter) fails to be sent out, for some reason. I'm trying to figure
> > out what happened - it works when I send the entire patch series to
> > myself...
> >
> > Anyway, resending this (in-reply-to patch 1 of the series):
> 
> For the record I did receive your original V3 cover letter from the
> linux-mm mailing list.
> 
> > Changelog:
> > * RFC v2 -> v3:
> >     * Implement a cluster-based allocation algorithm for virtual swap
> >       slots, inspired by Kairui Song and Chris Li's implementation, as
> >       well as Johannes Weiner's suggestions. This eliminates the lock
> >           contention issues on the virtual swap layer.
> >     * Re-use swap table for the reverse mapping.
> >     * Remove CONFIG_VIRTUAL_SWAP.
> >     * Reducing the size of the swap descriptor from 48 bytes to 24
> 
> Is the per swap slot entry overhead 24 bytes in your implementation?
> The current swap overhead is 3 static +8 dynamic, your 24 dynamic is a
> big jump. You can argue that 8->24 is not a big jump . But it is an
> unnecessary price compared to the alternatives, which is 8 dynamic +
> 4(optional redirect).

No, this is not the net overhead.

The descriptor consolidates and eliminates several other data
structures.

Here is the more detailed breakdown:

> > The size of the virtual swap descriptor is 24 bytes. Note that this is
> > not all "new" overhead, as the swap descriptor will replace:
> > * the swap_cgroup arrays (one per swap type) in the old design, which
> >   is a massive source of static memory overhead. With the new design,
> >   it is only allocated for used clusters.
> > * the swap tables, which holds the swap cache and workingset shadows.
> > * the zeromap bitmap, which is a bitmap of physical swap slots to
> >   indicate whether the swapped out page is zero-filled or not.
> > * huge chunk of the swap_map. The swap_map is now replaced by 2 bitmaps,
> >   one for allocated slots, and one for bad slots, representing 3 possible
> >   states of a slot on the swapfile: allocated, free, and bad.
> > * the zswap tree.
> >
> > So, in terms of additional memory overhead:
> > * For zswap entries, the added memory overhead is rather minimal. The
> >   new indirection pointer neatly replaces the existing zswap tree.
> >   We really only incur less than one word of overhead for swap count
> >   blow up (since we no longer use swap continuation) and the swap type.
> > * For physical swap entries, the new design will impose fewer than 3 words
> >   memory overhead. However, as noted above this overhead is only for
> >   actively used swap entries, whereas in the current design the overhead is
> >   static (including the swap cgroup array for example).
> >
> >   The primary victim of this overhead will be zram users. However, as
> >   zswap now no longer takes up disk space, zram users can consider
> >   switching to zswap (which, as a bonus, has a lot of useful features
> >   out of the box, such as cgroup tracking, dynamic zswap pool sizing,
> >   LRU-ordering writeback, etc.).
> >
> > For a more concrete example, suppose we have a 32 GB swapfile (i.e.
> > 8,388,608 swap entries), and we use zswap.
> >
> > 0% usage, or 0 entries: 0.00 MB
> > * Old design total overhead: 25.00 MB
> > * Vswap total overhead: 0.00 MB
> >
> > 25% usage, or 2,097,152 entries:
> > * Old design total overhead: 57.00 MB
> > * Vswap total overhead: 48.25 MB
> >
> > 50% usage, or 4,194,304 entries:
> > * Old design total overhead: 89.00 MB
> > * Vswap total overhead: 96.50 MB
> >
> > 75% usage, or 6,291,456 entries:
> > * Old design total overhead: 121.00 MB
> > * Vswap total overhead: 144.75 MB
> >
> > 100% usage, or 8,388,608 entries:
> > * Old design total overhead: 153.00 MB
> > * Vswap total overhead: 193.00 MB
> >
> > So even in the worst case scenario for virtual swap, i.e when we
> > somehow have an oracle to correctly size the swapfile for zswap
> > pool to 32 GB, the added overhead is only 40 MB, which is a mere
> > 0.12% of the total swapfile :)
> >
> > In practice, the overhead will be closer to the 50-75% usage case, as
> > systems tend to leave swap headroom for pathological events or sudden
> > spikes in memory requirements. The added overhead in these cases are
> > practically neglible. And in deployments where swapfiles for zswap
> > are previously sparsely used, switching over to virtual swap will
> > actually reduce memory overhead.
> >
> > Doing the same math for the disk swap, which is the worst case for
> > virtual swap in terms of swap backends:
> >
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


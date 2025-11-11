Return-Path: <cgroups+bounces-11803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FFC4C51B
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E863AF41D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E42EBDC0;
	Tue, 11 Nov 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TlgJz8pw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D82BE658
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848643; cv=none; b=n65D4xMXUuiC8yA5fek5knKD1+D0RvjWkpu6bcSlKUsXzlRBhX6ya4FNzPWZ5jxs2utb8vRmtaOP2Y71KxpIPlvSp7KRJgGwq2nKtxDJbYVDYZ73SXu3BICMboLuAXSJzHjdohGXW1zJsvDfW2P8TR1944s05GFfqL8Xgr+nLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848643; c=relaxed/simple;
	bh=l6nRJ7tdRGvxA4c5h4KBMAhCvuaIH/Goxb69gB+0GP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1cDvelXO49MZWIzpYhED8h+SdJD+LRuyCG8aoe2L7RlQVwZuoqVkgELyMUdWSGC543mC1Pbtdx8Zauvz1kdJUUTtsAayktpTkBeEPQMxDgfxeLLITRyB8kY38jh3Z8EHGgSRb8IC/7gcf9CUDZm4X/PM4RNa6baFXmXlr8YEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TlgJz8pw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324204so688202666b.0
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762848640; x=1763453440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQbue78pKwkHXp+W4v6uPbf6iMxcJPuiWhAhoJWq+ek=;
        b=TlgJz8pw921GFXv+BAHpqmxytw9WivNw3nHQNI+q+p2xvs6o/Jzc6woYDg95mMxvhm
         F1lBRg8PceWaaEqCW0UHnxmsk7Ex9Z9zPoFxb5hS0dBtNI2U7xWS3QIOUdo5Kdi9VF5L
         Yep3aPijohcNipi37iHEjlJJmmS1dNWuKgTdjdu8RO1ZTmdo/REk0zcT4BN9VjLOUlEg
         QFHFUO4LE5KiX48lHSTjsK+mA3bWahtg89m30bPbLtPVo7Cm/t1gdkYOPo4FYTtdR8Gs
         hh65vPPkcHFYyNhaQpzJCdea7Zo3A2CH32nqZQz/PrrQ64u9jli/A9mkzcEPonAbaeAH
         2xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848640; x=1763453440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQbue78pKwkHXp+W4v6uPbf6iMxcJPuiWhAhoJWq+ek=;
        b=MF8y5MhQeMpVpvGkca+dLPqtljVcTKVJRt+QyYqnRtOn9uehKB6Z295zSDpHKVHtvc
         5Jx9ABorz6wp2+RTjnGSKVvr3RndpWIBFeATzxkPC+8tGs8prNOjQv9Nnxi7gZ8zCv9E
         m9FmfCUFQ2IVEedtt5n5x96gvNtBNMEdSZ6mpB59sEAzl9gTWSyWJ5C6y3I14IeiKpAc
         wbyvU8UPSEiIQd7GKCP5poxBEEYtpgD033VEDzG0dDdONlCfVrVLBS8A5f+kuemf8SbK
         Db5WwVQN3k2LlBI7+zh7OQC7TjTPGV07OaYgmOUck06cB3942fkPgAKhmGFL3mi7vDoV
         YUXw==
X-Forwarded-Encrypted: i=1; AJvYcCXRiIOzDiXG0IVmto6+v+mfRmyqcbISEXJkqYFyWleTprKJ8xISgLXz0gL4+f6ZB1dt2TBgwd1H@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EsiPCDI4MelPFbVePU+VcuMJkHd7uF1usqpDQHv14bZxFCjn
	VWfwuqWAxPOX9h71XPzY/5GciIiidr4+zLAfAVzLSM9pcLMG9XbhbUpOaG3c99h+Vy4=
X-Gm-Gg: ASbGncuiFl5zSmjGBQhGPqUMwDPnlGd1UXsIqL4TsD3qdVLs4pZ+B3VrIIVO1zu4p/i
	qVaPqsPfyJAMDyf2DWorbmQQvfbupYk20Ud6pYtpFJ05Jppd8OPiTyHq8nuntUmGFpkmI5RfyY8
	WfE6hsbTb+UrXtM2bMGHniNkeitYckoPLWX5+OF0C43oC2yKBoCHvKNYxyEwZbY30Tkc9nP/oHf
	hVXdHuT7rJ1OFjRWsouIiLtFS+i0np/kgAEMPL+hwasF88+HHiTz1gNlgOhfBq3IyFMSVO0wLgU
	GgEHBZK16ecQWXnpVCXPb/n7yeL4ikC65wA3+RKG3ceOnb87/81GXZ8XEHjuf2NtV3DXdAPZAFH
	jp6q64kLJsO087Ag+Mf08dWUETm+7GGwqQeEdLl9jZoihZGKbbu5OHB21EJz1uO6mkyLINbPwTF
	Y0MmK/ZFl/AXxPEa8q+nIeGOzZ
X-Google-Smtp-Source: AGHT+IEZYvAe437RcYeslkObkmRF/TXOLhs0HzqzcY6BdpIa2QVGfreM/sajryoPs6lMwNHAyeu0Pg==
X-Received: by 2002:a17:907:3d44:b0:b6d:8da0:9a35 with SMTP id a640c23a62f3a-b72e028d598mr1171710366b.13.1762848639974;
        Tue, 11 Nov 2025 00:10:39 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm1292308366b.23.2025.11.11.00.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:10:39 -0800 (PST)
Date: Tue, 11 Nov 2025 09:10:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	tj@kernel.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aRLvfoMKcVEZGSym@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>

On Mon 10-11-25 14:50:11, Michal Koutny wrote:
> Hello Leon.
> 
> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shopee.com> wrote:
> > Memory cgroup statistics are updated asynchronously with periodic
> > flushing to reduce overhead. The current implementation uses a flush
> > threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> > determining when to aggregate per-CPU memory cgroup statistics. On
> > systems with high core counts, this threshold can become very large
> > (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> > statistics when userspace reads memory.stat files.
> > 
> > This is particularly problematic for monitoring and management tools
> > that rely on reasonably fresh statistics, as they may observe data
> > that is thousands of updates out of date.
> > 
> > Introduce a new write-only file, memory.stat_refresh, that allows
> > userspace to explicitly trigger an immediate flush of memory statistics.
> 
> I think it's worth thinking twice when introducing a new file like
> this...
> 
> > Writing any value to this file forces a synchronous flush via
> > __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> > descendants, ensuring that subsequent reads of memory.stat and
> > memory.numa_stat reflect current data.
> > 
> > This approach follows the pattern established by /proc/sys/vm/stat_refresh
> > and memory.peak, where the written value is ignored, keeping the
> > interface simple and consistent with existing kernel APIs.
> > 
> > Usage example:
> >   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
> >   cat /sys/fs/cgroup/mygroup/memory.stat
> > 
> > The feature is available in both cgroup v1 and v2 for consistency.
> 
> First, I find the motivation by the testcase (not real world) weak when
> considering such an API change (e.g. real world would be confined to
> fewer CPUs or there'd be other "traffic" causing flushes making this a
> non-issue, we don't know here).

I do agree that the current justification is rather weak.

> Second, this is open to everyone (non-root) who mkdir's their cgroups.
> Then why not make it the default memory.stat behavior? (Tongue-in-cheek,
> but [*].)
> 
> With this change, we admit the implementation (async flushing) and leak
> it to the users which is hard to take back. Why should we continue doing
> any implicit in-kernel flushing afterwards?

In theory you are correct but I think it is also good to recognize the
reality. Keeping accurate stats is _expensive_ and we are always
struggling to keep a balance between accurace and runtime overhead. Yet
there will always be those couple special cases that would like to have
precision we do not want to pay for in general case.

We have recognized that in /proc/vmstat casee already without much added
maintenance burden. This seem a very similar case. If there is a general
consensus that we want to outsource all those special cases into BPF
then fine (I guess) but I believe BPF approach is figting a completely
different problem (data formating overhead rather than accuracy).

All that being said I do agree that we should have a more real usecase
than LTP test to justify a new interface. I am personally not convinced
about BPF-only way to address this fundamental precision-vs-overhead
battle.
-- 
Michal Hocko
SUSE Labs


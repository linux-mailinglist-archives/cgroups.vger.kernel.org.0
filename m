Return-Path: <cgroups+bounces-6492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB9A2F6F6
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CF03A6506
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E402566F3;
	Mon, 10 Feb 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="B1sBZ8qX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AD25B668
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211954; cv=none; b=QndRm0flOE+GF5uWhSEcc/fBOZB+5fEpLNWdy0bBnuyJwYWgcK+KsFIQS53oypUXhcyfZl9iPMKodYFtce2cApZ9ZD7uvD3y1o0AbwT22t8OJ8eBQYq8KswvhG+kbcvfcyHI+HUTZqTLUtuZbiDKaIHpF4LihUFSr2iv9dBoZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211954; c=relaxed/simple;
	bh=yw+lKZDoeBK7rkNspoTrT5upsSeMqE0byCe2rNIKGy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB95SvOyqSRsc2GwKpndyo23sB05LPOkZzoRxAW7nfXkk6K/GDS9fK0vTLc5xCO+M0IKE/pWUPGL+2apmuPVCWrzEaOWuyAE5eIzkIU0FWCBAgbW22T+vZEyPhXVOMCYIv2Hjf9iO+1dCG0RrpB1mnwIwytUPNTO9gZSNBAO+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=B1sBZ8qX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c058ae6777so168625685a.0
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739211950; x=1739816750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hZK6XGnRLi/IyorocuGwcKKQPXtEGusIrxLUfwsFRE=;
        b=B1sBZ8qX4Q8msELlEl2SM0O5rUMt8TZEmz9rZ2GXv0qCach+Abcsl5xPFjVHsbIP5I
         RyLsiVVeh6/f4zQc+lVZeOSR+FwtUOA3jDOL6YuZseo089k2cs/5MDHbjn8qQVzm36i+
         OaMUesmprHldlagm0wt8ybRrFodTVQpgTHt6FQ137MQVyugmQw6nvwcqS1Gd7UX7e5aB
         qWQ8pDWS7CTW37KSGOtwtO4ZMs6vppaV7lh9daWz5DAd/J6Rld2r4Qm0pEb2/9dPSmg/
         zcADcgwe3JSETooMSLwJOG6cAQkuPpL3qSTgwioHCUGpp/siNI2p6W9FOLFmrqSVQiAl
         In+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211950; x=1739816750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hZK6XGnRLi/IyorocuGwcKKQPXtEGusIrxLUfwsFRE=;
        b=J7hE3BEOBTiRDu17HvSw+Z7qHN/s7Wk0SGDSTFF8JkGSpBZX+6O5yAuUiQRuKZ9MT9
         NQtg+eBPrlNg++0/NbAzbE7nn8DM0H39Dtf/LHnjhh12uyoZfOCYI5ltS+iqXtsb2iUF
         8Z6GDiG+b58cKv0yj1Xg2Tl2xdHiKyhzce/xRCoWb+tLRTD2SfTnjlP5gLctt88a8uQL
         KxCB/Lo80fHNuXXXz8tobrRhNw8THSjMeY/Aa2LEill/eaBVv1fJFS0Bpa3gbHWs+xdE
         QHzknt6Sy4iER0dzh2a9tHf34AStHj8ropj/4pg1N9ghvrb3fyFXlKIB7TBIcqC5zXc6
         UK4w==
X-Forwarded-Encrypted: i=1; AJvYcCWGQs1zBudwEAQrVChaCeN/LvTK3O5/WwkK/Wendj023mDqhxstQC8jsiIkGT2KwdSQWPtLuDPF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqh4mTWz2dzhrN3mFk2WKI8am94R5gw706xxSzoXtlv6+1yS+N
	IQ93NzDg2Fq0b/SM6zuJixKT1cSQaUd3Wuc/QEUE6MRp5CYWs+9SSlwjCPbQj6w=
X-Gm-Gg: ASbGncvFh5xA0Yd0BOxm6T6frCg8vfTE+4uPGqH9ES3oaj0/Zq/O9e9iRQzagaH3oyY
	E8IFWXSSs3tdxljOfDdGpT2cupYQLL+MpCCpnktRhU/P7fUf9MbnyhB6iLEHgTx03FWPrmyGfko
	Woi4ea3qGI3Gp9h12lZxdTaouIayFC5oOBqzUeuHLH2adrAvjKkhenp5LqtMw8V9OIfhlhBn8IH
	poHp3dJyIy1+dVUoxsAjIRKqNu6gHpLgEB5yu7ocEvenZpWyt3K3WPPS1yK9JV4of96VO97TYpw
	R5JGMbP4PlaULQ==
X-Google-Smtp-Source: AGHT+IERn1pEjIUK9eVekbDQIrmmcjZ+a9exbhT86XMP+EPRyQ3FbMbg8dM1n6UR9Wtt9h0PfLk7Tw==
X-Received: by 2002:a05:620a:2549:b0:7b3:5858:1286 with SMTP id af79cd13be357-7c047c45da8mr2008700085a.47.1739211949818;
        Mon, 10 Feb 2025 10:25:49 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c05fdd0d58sm140341085a.6.2025.02.10.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:25:49 -0800 (PST)
Date: Mon, 10 Feb 2025 13:25:45 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Message-ID: <20250210182545.GA2484@cmpxchg.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
 <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
 <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
 <Z6onPMIxS0ixXxj9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6onPMIxS0ixXxj9@slm.duckdns.org>

On Mon, Feb 10, 2025 at 06:20:12AM -1000, Tejun Heo wrote:
> On Mon, Feb 10, 2025 at 04:38:56PM +0100, Michal Koutný wrote:
> ...
> > The challenge is with nr (assuming they're all runnable during Δt), that
> > would need to be sampled from /sys/kernel/debug/sched/debug. But then
> > you can get whatever load for individual cfs_rqs from there. Hm, does it
> > even make sense to add up run_delays from different CPUs?
> 
> The difficulty in aggregating across CPUs is why some and full pressures are
> defined the way they are. Ideally, we'd want full distribution of stall
> states across CPUs but both aggregation and presentation become challenging,
> so some/full provide the two extremes. Sum of all cpu_delay adds more
> incomplete signal on top. I don't know how useful it'd be. At meta, we
> depend on PSI a lot when investigating resource problems and we've never
> felt the need for the sum time, so that's one data point with the caveat
> that usually our focus is on mem and io pressures where some and full
> pressure metrics usually seem to provide sufficient information.
> 
> As the picture provided by some and full metrics is incomplete, I can
> imagine adding the sum being useful. That said, it'd help if Able can
> provide more concrete examples on it being useful. Another thing to consider
> is whether we should add this across resources monitored by PSI - cpu, mem
> and io.

Yes, a more detailed description of the usecase would be helpful.

I'm not exactly sure how the sum of wait times in a cgroup would be
used to gauge load without taking available concurrency into account.
One second of aggregate wait time means something very different if
you have 200 cpus compared to if you have 2.

This is precisely what psi tries to capture. "Some" does provide group
loading information in a sense, but it's a ratio over available
concurrency, and currently capped at 100%. I.e. if you have N cpus,
100% some is "at least N threads waiting at all times." There is a
gradient below that, but not above.

It's conceivable percentages over 100% might be useful, to capture the
degree of contention beyond that. Although like Tejun says, we've not
felt the need for that so far. Whether something is actionable or not
tends to be in the 0-1 range, and beyond that it's just "all bad".

High overload scenarios can also be gauged with tools like runqlat[1],
which give a histogram over individual tasks' delays. We've used this
one extensively to track down issues.

[1] https://github.com/iovisor/bcc/blob/master/tools/runqlat.py


Return-Path: <cgroups+bounces-6882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71007A56319
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF173A7F6F
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B41E1DF5;
	Fri,  7 Mar 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlPoFrZe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D871E1DE2
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337968; cv=none; b=cIxcmYZTDXjzSeWdFOzVPpyOMtYNXQE5TUDhaGtP+Ai466RDwcP036vhY6siO8zMRm0sLygM95TsDkz13tV6oc2enEeRDSlYoWNVAr1dBliKjU8Dk7x9sG+my2xglVZfrirUxvcVqTZRGslupO6BZcvCWiH7PHkaLFi1GsZ10Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337968; c=relaxed/simple;
	bh=DnLQl3Ksq7Z2cxllWUtimVgS0kCffSWmdptylR8Su4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4LJ+23anbVcdxg1SU9JoxpYZlyzTyDQMsBF+jpHtai8NS6KsWIQgACpAd83wEFymARNAHAI1et0oTOOg1epTdBSdVzEFjErm0LM5XYjELLYds6g8cPJoX4grRi7bV6J20rxNMGTBGuWvwA+GAJvVnereQcRBgVhaN4ro+ki+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlPoFrZe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741337965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNzbo/dN/JoeBXTVjx7dS75+0FihoJ2m5H1svayNa/U=;
	b=MlPoFrZe5HUIRdkbZUboppxAgLCQmyWIaXQwVKPNZYYQ1JKf9npMDIdeEXDjx+Jxv/pboW
	0tyO/ApPLAtaLmrB65dILahakTJedNegW5PRjYCpmPpw/Op/i1vgfIQJJxrw5urTYzwUts
	dkUj5VNu1+46bdpqKr/9CPR7HUfq9WQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Qg2-h4xpOROeyKqssamoLA-1; Fri, 07 Mar 2025 03:59:23 -0500
X-MC-Unique: Qg2-h4xpOROeyKqssamoLA-1
X-Mimecast-MFC-AGG-ID: Qg2-h4xpOROeyKqssamoLA_1741337963
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-474fff2dd31so35945121cf.0
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 00:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337963; x=1741942763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNzbo/dN/JoeBXTVjx7dS75+0FihoJ2m5H1svayNa/U=;
        b=pwDGApXkiroURqFD+3o3DaK+Gw4KZBhwL1WOrk2sp96E1eRTGQd4wnCu6lXKA5AqWT
         mPrIPoQj0cKqhX5TyagPhA0nmytFm06QZmOh2QtnizAUIKjlcH+9m0WBjGwSUgsoj6jB
         j31jXoD1rIiWtcPafXlWSEsij5jtHmiVrnzs84socyr8z3mza6wP69gstt9WRkoUwg7F
         k5kuko7iT/Zl4gknLVAT8aN1UST/jN/ujk0q95C/fDShAFSXx63kRlNZ08Py30skNfB3
         +0ZMs/2nfLoHI6y4NYnTaMWab37uNkyoUhd1M1590luK8aGTCqgERbP+YOm/im+zUA1K
         of5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmA+rujFV44105GCwlnbBWBrjN6pkNkUcdV2ncAj+7cDMIZjO136S/0KWpQmrTtV7oop4J3J8X@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRJhROsukaJ2lZWBS3a4F2I4ktSo/BjM7fL1EW1WCREw3lI99
	ZjlC/D0xcIqQTW5chUrGZ0t/Shr43PWQGxoOY/Mz9xqmtPgVHSgulCdgkYyUd4jrz0TAOoquEdY
	MBsyBScHnmXJOB0q0UxjKlIK/PxN72WuPxQM8OVvdPhVfpC+G0pm7Cm4=
X-Gm-Gg: ASbGnctWt/Y8ALW2byNQhJX5jMWI4WhJxmGFhL1PtjYfCP7JAbqtXw5+MF4TEBpd7Oj
	xBipvsfLkYcSQk/ox4POg8jrK++nxjaCul/8Q8aYoPD26Nd0oNOV1GArVewBwMwK4SZTOb3RI+o
	FtmJOe6XniYgI0nipVjQCURAkyUWccWhKKkO2toHVnF4rFGYlSUD+RF1A5es28op0knqhHjJjWK
	iRyscvij7Vgwf03/0pdLpdYkZ1w1Whg42v+hdcV0FZ223r3NC4NC+GIFez6gBPksS96NDt0SrcP
	o/TeoDqfcDbasqBUzaWe4MzGczqltuI+E7YuaNhRGWRlaV2ocI/+RECNQNLOvoV4K86QltVUav3
	vQJyq
X-Received: by 2002:ac8:7f42:0:b0:471:fde4:f0ae with SMTP id d75a77b69052e-476189e8118mr29380181cf.36.1741337963202;
        Fri, 07 Mar 2025 00:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq0N4B7njPtAmPXmTzn2vvYLdOcpPjQWYIsJ8Snozrqg1T6MF5pIGRzPtQzrAvPBv5qyU+Fg==
X-Received: by 2002:ac8:7f42:0:b0:471:fde4:f0ae with SMTP id d75a77b69052e-476189e8118mr29380101cf.36.1741337962968;
        Fri, 07 Mar 2025 00:59:22 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96f378sm18205061cf.30.2025.03.07.00.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:59:22 -0800 (PST)
Date: Fri, 7 Mar 2025 08:59:17 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z8q1ZdJEjOEkhEt2@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
 <295680e1-ba91-4019-9b7f-e8efd75d7f13@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295680e1-ba91-4019-9b7f-e8efd75d7f13@linux.ibm.com>

On 07/03/25 13:02, Shrikanth Hegde wrote:
> 
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Rebuilding of root domains accounting information (total_bw) is
> > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > is that the way we keep track of domain changes and try to add bandwidth
> > back is convoluted and fragile.
> > 
> > Fix it by simplify things by making sure bandwidth accounting is cleared
> > and completely restored after root domains changes (after root domains
> > are again stable).
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

...

> > @@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
> >   	rcu_read_lock();
> > -	/*
> > -	 * Clear default root domain DL accounting, it will be computed again
> > -	 * if a task belongs to it.
> > -	 */
> > -	dl_clear_root_domain(&def_root_domain);
> > +	for_each_possible_cpu(cpu) {
> > +		if (dl_bw_visited(cpu, cookie))
> > +			continue;
> > +
> > +		dl_clear_root_domain_cpu(cpu);
> > +	}
> 
> This will clear all possible root domains bandwidth and rebuild it.
> 
> For an online CPUs, the fair server bandwidth is added i think in
> rq_attach_root. But for an offline CPUs the sched domains wont be rebuilt.
> It may not be an issue. but the def_root_domain's bw may be different
> afterwords. no?

dl_clear_root_domain() actually adds DL servers contribution back on
their domains (dynamic and def) and we want to keep offline CPUs DL
server contribution not accounted for until they come back online and
the domains are rebuilt.

Thanks,
Juri



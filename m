Return-Path: <cgroups+bounces-15731-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IYuGxSiAWpKgwEAu9opvQ
	(envelope-from <cgroups+bounces-15731-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:32:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320CE50AF11
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B968C3027F58
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481013BF66B;
	Mon, 11 May 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8tOssuZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBjZmITb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B73BD654
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491796; cv=none; b=GOdxvMNLvvcNRmgpJi3opdJIxmE1fq3OzJwa3BHaLIA9jqdl0oMJM/sCyRreSA6ZoTsuBXfYsm7K6JNkQGSlMpnr9GkbMHfSIIB3KIw87qMvUC2Y0abMSiCf4bAgLEmpzGutLgaZ7zxiC1L7pIjL5Qf7w+u+f8GO3nKB2KuKJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491796; c=relaxed/simple;
	bh=p0ukpXDdMIjahg/dwyxcpgBlHpQ/LJiiE2hUUZVLoR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StLRGX+H3stnZ0hPaxBp4GDpNJ1bcDQzoI8wdadGS0i2lIxVYGs9JLtLEYxHwlNBkmj4bwmR/QPyqRi8YGm2rI/rXTF33V+7cxbPPJNmnf4EyKyp381zeU8KoUhTd6ntKGjOeYE8PPtzk2phq2xS7nIcmvUqKAgEXwcSgFqt9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8tOssuZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBjZmITb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778491793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL+az9BIHTnebA7bZqfjZuHBOfbE8wVkbiZ0XEwVSBQ=;
	b=b8tOssuZ4DA7/Dv+BPfIIh4HGnlRh1votuzK/WGcXdz0w9LLpkgbPchO16fKSGWwqRfTm+
	Uqc+SYOpTpugjIcFkZweAu+d5WcaCn4j4hnPr1HicE8WoPfc2cu+NjW+leUnvunK7DwCcr
	TWskq4HHbceHmYAiem3gfVqDwmhpMwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-o1ocqXvYMvWmUE88nIowLg-1; Mon, 11 May 2026 05:29:52 -0400
X-MC-Unique: o1ocqXvYMvWmUE88nIowLg-1
X-Mimecast-MFC-AGG-ID: o1ocqXvYMvWmUE88nIowLg_1778491791
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso30721695e9.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778491791; x=1779096591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yL+az9BIHTnebA7bZqfjZuHBOfbE8wVkbiZ0XEwVSBQ=;
        b=EBjZmITbClwUT4OpPA3bxHg+wAtjdouVE1hdsEBy2WyopZPc+WG+2FUoyVTRZrEKgP
         UWxaQH6aAw64nYFVnUQx26Q44DpeB04U+DNgkqH7JM14Qk/MFFzAZJAnUsfFAlnN1xk3
         y94PSpg1GTgtyGaKhYdN3Dzgk7ppNWWNn3yhE9uHlOI7DldZFpB2LiCBkLEGIn53tEd1
         kNSl0Ata5cibtoX0egA7dlRffqjv228te7loM1A8/oz15x1FSjeYoqOvekNcJAQ6oHYX
         g92L5SI5eLA6zBlqSJQnzwfF4uBwBR/bQm/1w5REZYUpcbdBJxpJoN9sKbjkhAxJ3V/O
         kDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491791; x=1779096591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL+az9BIHTnebA7bZqfjZuHBOfbE8wVkbiZ0XEwVSBQ=;
        b=RzYB/9qbtAu9byOiI0DVpXxk1aBrD/kcrGZIeHXyl0PLQkz5PKPgpuANIwwJl3HjyZ
         afcGlWcHSicB3JuV/yajPwh1W/3JTAQFEuO6bbEqn80uMmjbZR/tN0+zobPy6HZhPIpc
         w0pirAvI8wcagEzqf1hktGWM92RhWlzKEnpkGqqODdjaz5KJLya/+6GNgGPPUVVZWsKg
         MyrJEiKzr1BhOuMwvZYZtevFL0NlbueNQtc9kC4oiX5mHia1vkEBru/M1p26d6VdoQxJ
         2ijYONqO70GFXOeQBFy1s+Yf2kcKoeaFx6PvqJ+odR4eEIvsp9AIENveyG5xjPDvmAT6
         uF6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8CkdkBH62OOYsaJmuAPSZxSigdt+po4vYrRfydUbX7sGmAVJCzURQXigzJgoaKKBcZckkoHnHe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FtIQ4mawNwGNrDxqzzMWSWqRtenezDGpE7Z9wQFiuPD6loqS
	IM+vMOyT7nbyZY/56M36ECofItsA93g3oy5FUX8ZeF4lLRbK11HwB9kIK6HXuREK49HmifeKknH
	2lfa48p+iiP0DT79gJ3wmgmuI72Z5rpHDDV7Wt76/MACpW3l0lo+1g34m3sU=
X-Gm-Gg: Acq92OHfGETxFRL42kM1N5zaM3us1R/W04xTaMytV9QkmAXuRhJlquka9A9zjpLXFn5
	vLGmqYbuaTimI/Xpq2a0Oyt1mOJNUENsG9cUSprBNgUbmZzFFvLJ+Ls2Wr74r7Xw6f+/JEuCdJF
	goa7/51FvOB4VY9wbdxMfqoy3MgtQMSZxRuwP25XySIcM7cLe2L0d6ZF10dY/kNnHDUag2XcRvS
	OCal7/xYLRsprKBH7xDVrflyWvTTXAWrlAne+YR3XSOdWdsePc+D+b1R2+hMg2eDewjGywojqIn
	GIaiqbl6deFjUhCDnq/ABuKsmfDrdM7AR9VDPyriFj60frt35gAYwEecoAXVVRi58TtabpSiDzA
	8eaDxk8aTIFN1XClJhYDnnQSVjLVrdEcY/UUR+XUYg9uuNtkwE67B
X-Received: by 2002:a05:600c:4591:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48e707f81e6mr138978545e9.22.1778491791030;
        Mon, 11 May 2026 02:29:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4591:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-48e707f81e6mr138978155e9.22.1778491790616;
        Mon, 11 May 2026 02:29:50 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.56.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5630sm159657345e9.8.2026.05.11.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:29:49 -0700 (PDT)
Date: Mon, 11 May 2026 11:29:47 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agGhi9_SG6vRnDVq@jlelli-thinkpadt14gen4.remote.csb>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
 <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
 <20260507183931.3915dc59@nowhere>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507183931.3915dc59@nowhere>
X-Rspamd-Queue-Id: 320CE50AF11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15731-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jlelli-thinkpadt14gen4.remote.csb:mid]
X-Rspamd-Action: no action

On 07/05/26 18:39, luca abeni wrote:
> Hi,
> 
> On Thu, 7 May 2026 17:03:41 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > On 07/05/26 12:53, Peter Zijlstra wrote:
> > > On Tue, May 05, 2026 at 09:56:58AM -1000, Tejun Heo wrote:  
> > 
> > ...
> > 
> > > > - However, the cpu controller is a threaded controller which
> > > > means that it can have threaded sub-hierarchy where the
> > > > no-internal-process rule doesn't apply. This was created
> > > > explicitly for cpu controller. The proposed change blocks it
> > > > effectively forcing cpu controller into regular domain controller
> > > > behavior subject to no-internal-process rule. Note these are
> > > > enforced at controller granularity and this means that users who
> > > > use the threaded mode will be forced to pick between the two.  
> > > 
> > > Right... this then means we need two controls, one to do
> > > hierarchical bandwidth distribution, and one to assign bandwidth to
> > > the internal group -- which is then subject to its own bandwidth
> > > distribution constraint.
> > > 
> > > This might be a little confusing, but there is no way around that
> > > AFAICT.  
> > 
> > Just to check if I'm following, you are thinking something like below?
> > 
> > groupA/
> >   cpu.rt.max = "50 50 100"       <- 0.5 from root
> >   cpu.rt.internal = "20 20 100"  <- 0.2 from groupA for threads at
> > this level
> >   + threadA                               <
> >   + threadB                               <
> >   +- group1/
> >        cpu.rt.max = "30 30 100"  <- 0.3 from groupA
> >        + threadC
> > 
> > And we still keep it flat, so 2 dl-entities (per CPU), one handles
> > threads at groupA level and the other threads inside group1?
> 
> An alternative idea I was thinking about: we create 2 dl entities (one
> for "groupA" and one for "group1"); we set cpu.rt.max for groupA, and
> we subtract group1's utilization from it (so, if groupA's cpu.rt.max is
> "50 100" and group1's cpu.rt.max is "30 100", groupA is served by a dl
> entity (50-30,100)=(20,100) while group1 is served by a dl entity
> (30,100)).
> 
> Basically, with this idea the "internal" reservation is automatically
> computed based on rt.max and on the children cgroups. A possible issue
> is that if the children consume all the groupA's utilization the groupA
> RT tasks remain with 0 runtime (and never execute).

While I like the automatic approach, I also fear that it might be more
difficult to maintain/use from a systemd admin perspective, e.g. I
cannot make a subgroup reservation bigger because there are threads
running in the parent group which consume all the remaining (internal)
bandwidth. If we make it explicit it seems easier to see where bandwidth
is allocated at all levels.

Peter? Tejun? What do we want to do with this interface?



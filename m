Return-Path: <cgroups+bounces-6654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFBEA4192D
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C605E3AEA45
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64124502C;
	Mon, 24 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY0hEtjV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B724500E
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389261; cv=none; b=MMdtlOykIY0L9qvGeyvEAyhdCa8VkNV9Prwuvn/PRZ6OVzBqKjNwCO9GGCyOEp3IcA/rp1ig+g5mHF7LI5amVdurWA0UdggwmRdBd81B++j+67UxJMuRTR9IxM8ztQLnEj8hjb+XHKbkpx60p0V6E3WLWO0IopE2smBshgQLEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389261; c=relaxed/simple;
	bh=pUC6Ed2z/zY6KZOsQgf29yYj/OuBkJWzoRQUf/rC154=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umVJBTvPKFPW3+hsfYBdQ1hvAonC6Zpnl8+72sAuM4uxLu0VKetbHAh2FNXV/3epPZmiab9h2R8UfxA3pGVCwUU70bKtBxh6SOcn7IvLR9Og+1f3pyMxtcWtt4UFXTEnexTnwTYKvpJy4gahf9xbX6YuIC7bs9CdAxzQfsWv8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY0hEtjV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740389258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0X0AQO/2ghVbNwC3CVRjTuq8PTR+HZJjGnXHV3qwXKY=;
	b=iY0hEtjVQxjTdAKZvQ3xt88SnOWDnncSELXqJ2lh4kB9iMwDKFvbUbmP9LuqDeDOzrsXW3
	6l8NtiF3MOM/wlutq7lvC4cJV+vU5NEvaBzrkkcmJMNE/OHXqE6MEmM30r/mCG/GqpCDmw
	/NkrE0rDxvWfnBOb5LMrnyQRjrws+ZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-dpI2pSWWMCKwDL5PXACj2g-1; Mon, 24 Feb 2025 04:27:37 -0500
X-MC-Unique: dpI2pSWWMCKwDL5PXACj2g-1
X-Mimecast-MFC-AGG-ID: dpI2pSWWMCKwDL5PXACj2g_1740389256
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1687928f8f.1
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 01:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740389256; x=1740994056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X0AQO/2ghVbNwC3CVRjTuq8PTR+HZJjGnXHV3qwXKY=;
        b=uIqS+WoSjgCTlx/W3fBuhusqts13xEinFfr+Ov6Lxt/reFL05gEno3CpAJXQJn3D8L
         IDA0vKZidn6Varn4ypxGuKQPc9nImIIEZBMsavbJ9jmVc4M+vbdl6GulwAMzuR9WzB1W
         a+E7c/CwWd9mgZag54QrQHUZtxpbokMmYT83Nj6PrlYc6lit02qwJUQThzyBVJnJbFrL
         3YA90O1AYS+JeywQuhis3h90dyPW+a6QFczqkF8FlKEuiqxtU9AcbVal6R9tQ4oEwR6Q
         RY8ghZAxURKZa6gt+w7YpyPYQb96ujZa+coRGXzdgfuV0MnX+98yn1ltAt031ggBxLrW
         NhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGfaWzmKWMQUZ67L/i+h5XmYO8M3we4wh21smK5aYZAxk6QyjisKBuPMQYbHefgFAuaBfVjrXK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu71zvv1ymy/lNaKtjc6Oj0L+KrN2zOP+9FjLNAzmW3cR7ltlx
	oVjHAdtQpZSSlPeE/p5CY9LadeqAEz07Q4aPrBwVeTIGJRCithGM5sODpY0giILoZBPOoYGgGdu
	7utc3m724CpjkYxhRIna8pAIK5RyZHl+xhduCpMnXNTkkaYiW++uiOr8=
X-Gm-Gg: ASbGncv4A1r7i0k5VCcvOn4eDoyGMaIew6mzx+pG8Iu54ueJ6Jr1cLyFwOnA1N3ic+h
	rP5H0ibWPPMWaSpLKkFZ5puMop1OggQOnm168WU4Zu+nlmWznhFkKoEHdDVsgtpMmc1fMOWG8Bp
	s5r1C4jzgJ72kTVmbxq1A1Q4ZJKKh9C4enqGY/E18zijri9r8nYzSsZTdS8ipMs5SnpBbSW9JT6
	I+Ioj2PRp2N1bv88X3TABTJaRXoXnvX+reEySM/hxUkpoLitB1ZFjyEb8kd+pHh1Wvow3PSBgZ0
	O330JUmlcQYzIcOk9nLMPmZyn4miGaJkuoFyhVSgWsB0
X-Received: by 2002:a05:6000:154b:b0:38f:4c30:7cdd with SMTP id ffacd0b85a97d-38f6f09789fmr8445592f8f.37.1740389255967;
        Mon, 24 Feb 2025 01:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaS0RFZ37ne1nVAbmV7xLchKHTtvTGvrdxafr5L2u+6HaGa2IC0AD7fHvr/akM++F67G10Dg==
X-Received: by 2002:a05:6000:154b:b0:38f:4c30:7cdd with SMTP id ffacd0b85a97d-38f6f09789fmr8445575f8f.37.1740389255519;
        Mon, 24 Feb 2025 01:27:35 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm31411004f8f.99.2025.02.24.01.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:27:34 -0800 (PST)
Date: Mon, 24 Feb 2025 10:27:31 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7w7g1zb0nfu9-C7@jlelli-thinkpadt14gen4.remote.csb>
References: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <20250216163340.ttwddti5pzuynsj5@airbuntu>
 <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>
 <20250222235936.jmyrfacutheqt5a2@airbuntu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222235936.jmyrfacutheqt5a2@airbuntu>

On 22/02/25 23:59, Qais Yousef wrote:
> On 02/17/25 15:52, Juri Lelli wrote:
> > On 16/02/25 16:33, Qais Yousef wrote:
> > > On 02/13/25 07:20, Juri Lelli wrote:
> > > > On 12/02/25 19:22, Dietmar Eggemann wrote:
> > > > > On 11/02/2025 11:42, Juri Lelli wrote:
> > > > 
> > > > ...
> > > > 
> > > > > > What about we actually ignore them consistently? We already do that for
> > > > > > admission control, so maybe we can do that when rebuilding domains as
> > > > > > well (until we find maybe a better way to deal with them).
> > > > > > 
> > > > > > Does the following make any difference?
> > > > > 
> > > > > It at least seems to solve the issue. And like you mentioned on irc, we
> > > > > don't know the bw req of sugov anyway.
> > > > > 
> > > > > So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
> > > > > 
> > > > > dl_rq[0]:
> > > > >   .dl_nr_running                 : 0
> > > > >   .dl_bw->bw                     : 996147
> > > > >   .dl_bw->total_bw               : 0       <-- !
> > > > > 
> > > > > IMHO, people who want to run serious DL can always check whether there
> > > > > are already these infrastructural DL tasks or even avoid schedutil.
> > > > 
> > > > It definitely not ideal and admittedly gross, but not worse than what we
> > > > are doing already considering we ignore sugovs at AC and the current
> > > > bandwidth allocation its there only to help with PI. So, duck tape. :/
> > > > 
> > > > A more proper way to work with this would entail coming up with sensible
> > > > bandwidth allocation for sugovs, but that's most probably hardware
> > > > specific, so I am not sure how we can make that general enough.
> > > 
> > > I haven't been following the problem closely, but one thing I was considering
> > > and I don't know if it makes sense to you and could help with this problem too.
> > > Shall we lump sugov with stopper class or create a new sched_class (seems
> > > unnecessary, I think stopper should do)? With the consolidate cpufreq update
> > > patch I've been working on Vincent raised issues with potential new ctx switch
> > > and to improve that I needed to look at improving sugov wakeup path. If we
> > > decouple it from DL I think that might fix your problem here and could allow us
> > > to special case it for other problems like the ones I faced more easily without
> > > missing up with DL.
> > > 
> > > Has the time come to consider retire the simple solution of making sugov a fake
> > > DL task?
> > 
> > Problem is that 'ideally' we would want to explicitly take sugovs into
> > account when designing the system. We don't do that currently as a
> > 'temporary solution' that seemed simpler than a proper approach (started
> > wondering if it's indeed simpler). So, not sure if moving sugovs outside
> > DL is something we want to do.
> 
> Okay I see. The issue though is that for a DL system with power management
> features on that warrant to wake up a sugov thread to update the frequency is
> sort of half broken by design. I don't see the benefit over using RT in this
> case. But I appreciate I could be misguided. So take it easy on me if it is
> obviously wrong understanding :) I know in Android usage of DL has been
> difficult, but many systems ship with slow switch hardware.
> 
> How does DL handle the long softirqs from block and network layers by the way?
> This has been in a practice a problem for RT tasks so they should be to DL.
> sugov done in stopper should be handled similarly IMHO. I *think* it would be
> simpler to masquerade sugov thread as irq pressure.

Kind of a trick question :), as DL doesn't handle this kind of
load/pressure explicitly. It is essentially agnostic about it. From a
system design point of view though, I would say that one should take
that into account and maybe convert sensible kthreads to DL, so that the
overall bandwidth can be explicitly evaluated. If one doesn't do that
probably a less sound approach is to treat anything not explicitly
scheduled by DL, but still required from a system perspective, as
overload and be more conservative when assigning bandwidth to DL tasks
(i.e. reduce the maximum amount of available bandwidth, so that the
system doesn't get saturated).

> You can use the rate_limit_us as a potential guide for how much bandwidth sugov
> needs if moving it to another class really doesn't make sense instead?

Or maybe try to estimate/measure how much utilization sugov threads are
effectively using while running some kind of workload of interest and
use that as an indication for DL runtime/period.



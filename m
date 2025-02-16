Return-Path: <cgroups+bounces-6561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF3A375D1
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A06E3AB3E5
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FF19AD8C;
	Sun, 16 Feb 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hQe5evxT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB6199EAF
	for <cgroups@vger.kernel.org>; Sun, 16 Feb 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723626; cv=none; b=I5jfIV3qXPmcnvtoqdj2L3RZjIXByeXtf34Drm9brgPbtF0fY9pmQ78IC2+KtH+9a22SEyZHqaaSo26PTm3se0d3LoE3dHWjLOCISCpm41jP7Az86gJUQkeAKeH1RSoCa3DrnYlyt7C4OUvMxe1KEeIXDoAZCr494EzVALwDDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723626; c=relaxed/simple;
	bh=BICul6GUdFbuU5tzJRFrpq8T0hra/dZQaGyO/rn8I6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKsCJK0ks+lpbQKaOil7JIR5Q/6JaUXvzMEK94ZbYAomLIES7ai/Xv0xc7rhi+cQT9dhEL7hMoNXC1QMtKCq1XTXFrYSOBuhozVD3BfWTXuCxb5A5S7QMzDYjO7uTa657KRSeCHzkVT2GdBRxAxDq3cnxzL6ahbB92y5ym9G4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=hQe5evxT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so24602345e9.0
        for <cgroups@vger.kernel.org>; Sun, 16 Feb 2025 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739723623; x=1740328423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUMfqS3dZBd43tbBbndbhZ/u2f+U8HCOLG9lUIdc1Xk=;
        b=hQe5evxT+0D7PSbChtzPQKbTiyUIiiu7l2aK66kgJeYjF374OOaElthMytJrcyagA5
         WwQBI+JNBdPAyWfOh6eVB5grz1sPeiBNgMbT8XDOlzYhhwSUcTnxlg4WDoF+Zxf0PDGL
         oVha5iJpYwO8zKx/C0P+BokFcqleYmYITWPcQCPbCuEaWNurgvvJBngdlVgF+IYwugYg
         w4GYjSl0nKNNuYHbsEy8AzyR3FjCJ3PRsCA7eXAGXsiCFiWAp+BuE9/1C/InSTA4wPfR
         elniRGqo2vJGpiYK+KbGy3Xwyf2kI0Mefw8XiJZ5wFT5ZQ00cezj1v331aWRLYS4ccNH
         rzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723623; x=1740328423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUMfqS3dZBd43tbBbndbhZ/u2f+U8HCOLG9lUIdc1Xk=;
        b=C35bA6/iHtCq9M76CsVjr1j400kwltSbmiP8weicO6JRQDmT2c6ROfmtxbVJVAHXtD
         0Syt+ruJ0xFZV+jmVNjuH+kjGzNou6K3MUple2d4OZqomBh5Me7XGc0tJU7z+/EswSUI
         2IVRSNRIEsNHmmVbO2fHz+BzQemrYKLSSsmYdTgyVCNqc2VvG+R/ZBD4aBzSz1xg6TJE
         xDr7QEWuNnAy7+5CzY1rVfvXRgTbC/tuc7k52sI15nYkbDd9ccVnRMgSns0a8mqMD/h9
         zqPw9sT6lJzwrVjPnFZrJFKdatz/g5jmtQa7D6iZm0a2jByEXl2skNgozqhEdlAvSlQa
         BaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJur1NG1cenQzUyz8EqjCyqiesHdKTVzIPIDvhnSEKP9FU2ncb2tBO7TGlzXxdR7xCsEOgnGw/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G/va57094RVBz/cLMZNqWYLH1BLA0lmhw4tp83SpFVXJa4UR
	Nunn+UVI9bMC2ByoG02ToBBbFmtvAPg+rfydyeODtLhAhJvV5U9s+KwaIA1B/OQ=
X-Gm-Gg: ASbGncsFO+WxSeiHJ6ELBKmmIZcObAXWJ1hReWQ6TcOr3kRlLL7kTpVXT/qEofKE5Df
	Q5CYPn6Sj9rG17JkyzbMkJmm9Y9acMczeRwkVYK4c84blfuFNmrBKjPxdt00xHj+r9QGj0CGp+a
	ukxQIfdtADVx3tBRlIlhdvU86jw63FHrB1YVsbPU07uel4myXpaob7DyxdpP/yu86JA05ceQStm
	pCRpTCBmFGrMy67fgaRBUJEk7iJneE+P7+DwbaPhukAoy3BLJtXafBqyyWBFW0a1utxXeXDDu9H
	qqD6dhDnPSDns0fQAqdfFsRnExMf3Yh8HsdSMc9yWQ/mxfwE+cVbQlrbKzM9UwzZX3hL
X-Google-Smtp-Source: AGHT+IEeNlCzVzCebfog7rtjgazJvr3JIatphpj/eDAtE93/JEe47lhOf70TFBDtpeDDgQbB0eiCOg==
X-Received: by 2002:a05:600c:3c9d:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-4396e7674c6mr66151195e9.30.1739723622005;
        Sun, 16 Feb 2025 08:33:42 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8dd6sm10107550f8f.62.2025.02.16.08.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:33:41 -0800 (PST)
Date: Sun, 16 Feb 2025 16:33:40 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Juri Lelli <juri.lelli@redhat.com>
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
Message-ID: <20250216163340.ttwddti5pzuynsj5@airbuntu>
References: <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>

On 02/13/25 07:20, Juri Lelli wrote:
> On 12/02/25 19:22, Dietmar Eggemann wrote:
> > On 11/02/2025 11:42, Juri Lelli wrote:
> 
> ...
> 
> > > What about we actually ignore them consistently? We already do that for
> > > admission control, so maybe we can do that when rebuilding domains as
> > > well (until we find maybe a better way to deal with them).
> > > 
> > > Does the following make any difference?
> > 
> > It at least seems to solve the issue. And like you mentioned on irc, we
> > don't know the bw req of sugov anyway.
> > 
> > So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
> > 
> > dl_rq[0]:
> >   .dl_nr_running                 : 0
> >   .dl_bw->bw                     : 996147
> >   .dl_bw->total_bw               : 0       <-- !
> > 
> > IMHO, people who want to run serious DL can always check whether there
> > are already these infrastructural DL tasks or even avoid schedutil.
> 
> It definitely not ideal and admittedly gross, but not worse than what we
> are doing already considering we ignore sugovs at AC and the current
> bandwidth allocation its there only to help with PI. So, duck tape. :/
> 
> A more proper way to work with this would entail coming up with sensible
> bandwidth allocation for sugovs, but that's most probably hardware
> specific, so I am not sure how we can make that general enough.

I haven't been following the problem closely, but one thing I was considering
and I don't know if it makes sense to you and could help with this problem too.
Shall we lump sugov with stopper class or create a new sched_class (seems
unnecessary, I think stopper should do)? With the consolidate cpufreq update
patch I've been working on Vincent raised issues with potential new ctx switch
and to improve that I needed to look at improving sugov wakeup path. If we
decouple it from DL I think that might fix your problem here and could allow us
to special case it for other problems like the ones I faced more easily without
missing up with DL.

Has the time come to consider retire the simple solution of making sugov a fake
DL task?

> 
> Anyway, looks like Jon was still seeing the issue. I asked him to verify
> he is using all the proposed changes. Let's see what he reports.
> 
> Best,
> Juri
> 


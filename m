Return-Path: <cgroups+bounces-6763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2AA4C5EC
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8C07A2768
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9F2147E8;
	Mon,  3 Mar 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYw/czL8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F907080D
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017616; cv=none; b=RvCOjxoo+F+9o6Uhht225PU2Trd286jih7Z759xzA+WWtZC8PAXhlul22VyXf0EhYEcToZ3Aznq9XXrtVA9ZHi/l9Kkp4ZCl2OxPoQcalQIvCe03YouUgQGODZO43E4DSEOgUxHiNUtKzA1NObG5HZ3rLP/6gI6LqgX0x/shhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017616; c=relaxed/simple;
	bh=jFOF7k8K0bUwNF3eRcNy8u9EGvWjbUR67H+Rn8NM2ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDA2gdgxAyevHLW89ASarGsJ8se+GmV4OeK+SndGH9O1uHMcvJrbUw1FBrKc8czFO++Y3HjEiGog2sL45X2lqO1rcXbvbDaqygrBx4B611MxuYYYQD4NUa8wa5OQ1JLvRwktNmjvNEwDv0oRFXW6vBs50pnQPNrHxQXrtVLXLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYw/czL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeMgwkEfJ4wko22XhtG7puIWAiqthft7+Cg2qc+WP50=;
	b=LYw/czL805PEJ7mE82MXJS80B1XBWvS59QM4hejLd6qJppKTmPVkeolOJYMWpFwSUYLSyq
	Vtk/hp4+5U/CqbarusBAnk4L4yJ35Xv1lA6mcpHjeMm9mYbb9iLnobDrl/uLJSue3/7Zbq
	vhaWGq6VE75D5FmZ6kq5wqwBOy2C2rg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-AQmSTeCxMla25yi_GrqtdQ-1; Mon, 03 Mar 2025 11:00:11 -0500
X-MC-Unique: AQmSTeCxMla25yi_GrqtdQ-1
X-Mimecast-MFC-AGG-ID: AQmSTeCxMla25yi_GrqtdQ_1741017610
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bca561111so731025e9.3
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 08:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017610; x=1741622410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeMgwkEfJ4wko22XhtG7puIWAiqthft7+Cg2qc+WP50=;
        b=cS6qgSTP05Ho9T/oks9JmOCH3flxOBREuYmJnw28W6r3Zo05fyaymxHYLWVuIKapmE
         7c7f6kFSkh3zysE/Q8QGsAdKks8YOEaCyLdvRRtnIF7E/TWpkSVpii6Vm+3FIfILBPiL
         aJBWOsMnOeoRhtmk+tPlXbgp1vT4VlBHx87ed1JczK3uy84GNNzF5Xua7GU8WF3JpDKT
         8uHSm0MdsRT/PxsPZ8UHmIrQDvmX04AFQoFMGv3Y8QpTB73gGVp1k57GNxXtdyPIDQ5/
         4ZrrBf6xI8LXoX+MHc6+1xVTaOKl6AD6FcDW5Y1ejbLeadUPXO8ZXan7CU/nDhnTjAg8
         FCOg==
X-Forwarded-Encrypted: i=1; AJvYcCWiHmrnxN68rG4f30/7Q05C0yC3Kd7jg+Lv0ldO8NJsXMaXbH6uPrtGRbGBnMChdXC/H9fnx7ED@vger.kernel.org
X-Gm-Message-State: AOJu0YyULilYGeRQh840IMlvj6m9anvludE9AZmL2f76LR+LmjQ+sT7V
	owrUAAXRjFQlLe1QqXfF2ne9/PDXMSWqBoz4PcYfusebTuwUQiKTPU6ZEettZscxUR5+g7Dohi2
	/1V7nQH78tk2+18ZIZBzeAkweVX3rg9Lxmmjs3yNHCFjSc8FYPa9OxZY=
X-Gm-Gg: ASbGncsFEQ//Bn/XVdEcMH/yHVDJURoF1EP6HOcUbEMgclzhbehok3pjo3vd9j1XLfF
	TcCMVG51/A2LVCbmsxu9lBjNBWtcEE4+uOCgmFNXOj4G4JClN19++TgVQte5OOiE3ZtV5J0eE7q
	uWybHjVHlNXdGAIeJU52Vp4QwWQn7S5YIltegYJHEW97Z/7tvfFrfoiVSogpxRZFK7qB4R3URj9
	ylsoeT8qx70btXajtWyfqNDhMCdyKCGzVs3UbNYecBCrZTkoqOXuOk0jfW9isp/rSf6a+PWJVDG
	Wpy5ls+zR5WQWoujetsqq552bAWVaQ8P67axdQWD7i/P24uHPWrkC0pGhz3MwwqvfulI2l9WRyJ
	j/yMx
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id 5b1f17b1804b1-43ba66fec18mr128239835e9.15.1741017609771;
        Mon, 03 Mar 2025 08:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcAeVlV0x3Lsv/XUbSYCaDoG4BHyq8Ft0JsRryYoUoofcmIq5h1yB/qI8Y+i3wzQ2M9xQFVA==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id 5b1f17b1804b1-43ba66fec18mr128239335e9.15.1741017609386;
        Mon, 03 Mar 2025 08:00:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm200147315e9.34.2025.03.03.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:00:08 -0800 (PST)
Date: Mon, 3 Mar 2025 16:00:06 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
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
Message-ID: <Z8XSBrCNjPVRJszF@jlelli-thinkpadt14gen4.remote.csb>
References: <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
 <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
 <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
 <bd9eb72e-5c67-44a7-ba79-1557eaa319e6@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9eb72e-5c67-44a7-ba79-1557eaa319e6@nvidia.com>

Hi Jon,

On 03/03/25 14:17, Jon Hunter wrote:
> Hi Juri,
> 
> On 25/02/2025 09:48, Juri Lelli wrote:
> > Hi Jon,
> > 
> > On 24/02/25 23:39, Jon Hunter wrote:
> > > Hi Juri,
> > > 
> > > On 24/02/2025 14:03, Juri Lelli wrote:
> > > > On 24/02/25 14:53, Dietmar Eggemann wrote:
> > 
> > ...
> > 
> > > > > So DL accounting in partition_and_rebuild_sched_domains() and
> > > > > partition_sched_domains()!
> > > > 
> > > > Yeah that's the gist of it. Wait for domains to be stable and recompute
> > > > everything.
> > > > 
> > > > Thanks for testing. Let's see if Jon can also report good news.
> > > 
> > > 
> > > Sorry for the delay. Yes this is working for me too! If you have an official
> > > patch to fix this, then I can give it a test on my side.
> > 
> > Good! Thanks for testing and confirming it works for you now.
> > 
> > I will be cleaning up the changes and send them out separately.
> 
> 
> I just wanted to see if you have posted anything yet? I was not sure if I
> missed it.

You didn't miss anything. I cleaned up and refreshed the set and I am
currently waiting for bots to tell me if it's good to be posted. Should
be able to send it out in the next few days (of course you will be cc-ed
:).

Thanks,
Juri



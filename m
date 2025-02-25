Return-Path: <cgroups+bounces-6705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B1A43A4C
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1669C3B9EB8
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C926281A;
	Tue, 25 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZg5V0lo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943F8494
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476913; cv=none; b=g2CS0+BoibbYT9WozD47zb/pBsHCcD35jz5lavI9B9s+szaL6QDdwvYYlLjwzOR5ml5rbgMtQbKLm9xS1hAojYcju95/uAb7kT3fO4Qy02PYvOXZWLZHwSpE9bAQDvdwrBtovAUq/xyTOVGmh6uzz5H79nw6E7T2X6ocIWwZ+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476913; c=relaxed/simple;
	bh=nGlvMoyzBTZDRXMl3c+sUlUWlnh5FHc2EHGicv360qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqSonSbsqkSwvc7Jq+sY6Q3p+ga8umo95H4MLW0EzQZwalbXK3Jq6JCIZNfXDizL4ASWdapQPO3Yn5QhUnyN0oZsGx6mZUZ70DYXkjl38Jow/tlY0glz+wlM4TRoIoaggZSxKVfnlqamwT0DzBnZRHbBK9eSjGz2Po7sLY187nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZg5V0lo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740476910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0682VwDrfrWl0p9aic376RslWqpGKhFnq7HFGON2EH0=;
	b=PZg5V0loYNIW+qM6MUp8tsWqs7GDfWJFSEyACoG5MkOKqrd+8wctfS8UzSVIU3lm5ZLOBg
	79nT///+yMEZR5qQ+yJGwzojUWbb9Xb7bAEFhxMoSt6xysJW8yMnjx3i726vYpZvVjOKrX
	y2F8taLG33WAwKSs5XuKpcRSCfX1XZc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-z4tvHY5JPG6yGiuKMAQwXg-1; Tue, 25 Feb 2025 04:48:28 -0500
X-MC-Unique: z4tvHY5JPG6yGiuKMAQwXg-1
X-Mimecast-MFC-AGG-ID: z4tvHY5JPG6yGiuKMAQwXg_1740476907
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so37399765e9.1
        for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 01:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476907; x=1741081707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0682VwDrfrWl0p9aic376RslWqpGKhFnq7HFGON2EH0=;
        b=GNDdet1cosOQf+UoFRHnKCxL2DiYO45wnENA3784NCd93LlvrjzqH+dcnH7IU9F7qK
         iA/mNl/HMS4IEAMZs0/xLgBDGdItCGN2GOvoLr7Mq7aY+tBfaNCw6DAawsbcaGdqavai
         Q18uwp8zNCHG87bVg8i3AhUV8Zqflt2DopND9xvCnLA7ARebn4EUmTHU2xkL4trDPGaZ
         j8hhlpykVtTsetlF5bdxEo/Y8LcLXatNtn9DCk/pWkysJLE5H+0p05R3f+ZdEmSioqtP
         FL1fuSQaEpE0pnCPzKtXzkad4WK2Cur5yBTWIujmBfxDYAF13B91oegPIOxUhRrAwjDI
         MykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSwLV8Y/xGKA76Ddktgc8NS9Dfv2QLM3mFBoePFz/TIrfFY15xBtm5QyDGRHHh6iXxZuxObj/I@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNaHx8PIqk8BImd9eYazkJA8OX2hVxUzsyD12Lzo6D7F+yn/Q
	ZyDyPQ3PNPH4Ir12Oj9YhO7199tkBdnSC4saSBjOVG93w3jlSdrEnKdwg0vMlPBZG5g7lktnpAR
	d+alN2ZCj0ISPQWiCy4njfDWoIA4QqjIJyd56ADkI1BSAwkAeYVaQYEg=
X-Gm-Gg: ASbGncvBc0SUyNpyr5s63Kc8FjPBK0vpxngoYpMZlXtNDWuLeGiuNswombYZi4brrnK
	DIV1sRTyaxuTOy41oXOxxn8OMYUGx4GzIgtWwTIi6FFchUYB7fqR0RcmI/M9eGSm4CDrbhsVlEy
	rZblBcOJA/zo6QlYUtY+kFbUxGE9mNWcG5KHUZvE522st7bskOIuPYIw3TDTnzLQx77NEcZ73B5
	NUivwbmEEYHx2wQE1wmzLtG1d7DY7oO2nwKqjlT7euVMbCQODxtq2WzGnJe7Fa1Kvo9LXTjQrNR
	za75HWqkRphQ6KZ+e1U7r83zHG8Mq5taZTdo0FytIXzn
X-Received: by 2002:a05:600c:4686:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-439ae225a53mr147040105e9.31.1740476906812;
        Tue, 25 Feb 2025 01:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6KgXf9mu9XV5XIx/bzsC4rdve5WG9ngEo3WrqVFcizZhbRqC2DByd0rmzNqluKUQCmvTvDA==
X-Received: by 2002:a05:600c:4686:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-439ae225a53mr147039685e9.31.1740476906457;
        Tue, 25 Feb 2025 01:48:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.7.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b01346d1sm136419845e9.0.2025.02.25.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:48:25 -0800 (PST)
Date: Tue, 25 Feb 2025 10:48:23 +0100
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
Message-ID: <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
References: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
 <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>

Hi Jon,

On 24/02/25 23:39, Jon Hunter wrote:
> Hi Juri,
> 
> On 24/02/2025 14:03, Juri Lelli wrote:
> > On 24/02/25 14:53, Dietmar Eggemann wrote:

...

> > > So DL accounting in partition_and_rebuild_sched_domains() and
> > > partition_sched_domains()!
> > 
> > Yeah that's the gist of it. Wait for domains to be stable and recompute
> > everything.
> > 
> > Thanks for testing. Let's see if Jon can also report good news.
> 
> 
> Sorry for the delay. Yes this is working for me too! If you have an official
> patch to fix this, then I can give it a test on my side.

Good! Thanks for testing and confirming it works for you now.

I will be cleaning up the changes and send them out separately.

Best,
Juri



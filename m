Return-Path: <cgroups+bounces-6824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF41A4E60D
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3098A5F71
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5483259CB0;
	Tue,  4 Mar 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QavnOK3n"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08858259C92
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103637; cv=none; b=Jzw87ROFvhhghzrgmNzOqJ5I6Yxx6OlAiIRikkZ4lGuctErYDSgIvunsJ3s1jiRrlQbYdSvvaUCUFjPWvKDNWmP3OfRmqLryWgo6wl0QmEhJyJIkpWKxmr7KoqopFBXTz4WuWQLal6FmrmrV5xdml2hxNwSXm9dHXnP/+n4S5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103637; c=relaxed/simple;
	bh=1vV7+BT4xw81qLATGwFSVB9T/BFBbp5ljRvUFKtYJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5fjptvNUvTAt6qBqQfkoYCtl1Fy1VWfTzWjoylRHNveDiWG+0bvE2/4eI4gC5oNTWpGyJIm5fxmJBh+lHpUtutGfKkCkQTOccSt8CI2iGKHpgucnyTrnNbx/D9kcTVd7mp8wH3xa7xNhwyeREdCnYLuMLynPrkM1W5JweIglW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QavnOK3n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri5wR93YJXv4w21IzGikMZS6QGEGNEj5q6TV1QKUdt8=;
	b=QavnOK3na/hdl4n2QtUQjk8l7nfqiWglm90RBZA+pajmC1iFBNnIY2X7mceVPOoVvH8mPl
	v1in8FMzY8bslg2+B4PXUhPJE6MTGwAe30EMVzgPKkOOZ7YaMqxLi6K1gK4/nrKV1tMptu
	JqQWN6BXKHGjeeJlKNTScehVA1L62sg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-QbWDYeHxOS-pJzQxRVxn3w-1; Tue, 04 Mar 2025 10:53:52 -0500
X-MC-Unique: QbWDYeHxOS-pJzQxRVxn3w-1
X-Mimecast-MFC-AGG-ID: QbWDYeHxOS-pJzQxRVxn3w_1741103631
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so8026235e9.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103631; x=1741708431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri5wR93YJXv4w21IzGikMZS6QGEGNEj5q6TV1QKUdt8=;
        b=qL1RfSzipFN0ijloxEZYWGMTlMUvXKerBsHBk6S40eaEFf9k/X0Z7H4hCb7YZ2/y1U
         ECCcpF+mAYtuD7obTw/UnGiszl1IagNJBhBaMfYgF4lnV2ccZ1plf55OoQHN6f5t2Ln/
         LPN6efHikXtJdfilqnOjxlgTncZ23hp36s3gI0w+flo59VPWek++UQLX9w+kyCPdUiZe
         jPa4MNZ7zXM0tTBjey2Regn3J5tUX46KlYwfNY40PkQRK7gB2rtEn9M8MfHNzbpfWFU5
         sVvdw3XVK5/SxnM7T684jwPb9CAF9EPiOeDqSfr2uWRNt5TSWf3ssbY7VqKiNeT9P6mb
         hIXw==
X-Forwarded-Encrypted: i=1; AJvYcCVfrY+uEHhPzJZk4KD1PrxLpJZZZeFoHvtlFhOqyug9x9fF1YvFByy66c0lX5c04YIpWzzlUg73@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNCNl1ZBWW2Io+VPYtKOs4YpegYweJfktHWugRQipvjpUG46H
	ZR3u5/9nerlsvOEbt8ePn/Im1WHFVC2qXFfoigoaJldiLW2pzyrarEUP+SmgW/l6xQIZJzY0sqi
	KqXmACilqlVWNhqFjVNq+2Co8KAMHaBmZPNsILp4Nki9ByD97KT7qq/k=
X-Gm-Gg: ASbGncuNVwGfQPssZm/TjluQfNwlT7PBTnj0TaixSNR9r0YvwHIUyjX9/tFRewIZqwY
	JM2nCVjuTcy6HppiQiBgdHlmhea61h2VJigoQ41RfYJLPJl7cRzXGFGo4qcwkwLpkFy5wPET0x7
	HAMyCjNTRT3fNzwnglFK5AaNobfaet/Y4tQIk3HBziQ1Elp2YkAu22J5FQqE8vakUBnQ0Vj9MUy
	ORcd2IfwRLO7++xhks56Hqr9EgJr7YJZTrRhLmSXlAzET+ED1lw92I+wvUP2FLqIC4b4WCYGX1A
	3rwhc895Ufq065K9Bd8wLDiJxMyUrJjuMW/KqXfIa/983QYiyq8qc94bNUjlzT09xNChe9kug5r
	NeAn9
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr16312422f8f.3.1741103631481;
        Tue, 04 Mar 2025 07:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBhIMPB956a7ncBlyy8BOaBmL91FKiR7SKf3cdKksS88vwy8ZlkzWMX3xE90PfLivuTds0aA==
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr16312395f8f.3.1741103631142;
        Tue, 04 Mar 2025 07:53:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm149763155e9.0.2025.03.04.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:53:50 -0800 (PST)
Date: Tue, 4 Mar 2025 15:53:48 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
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
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 0/5] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z8ciDMdstzJCZoBm@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <a04845cf-c70a-4699-8260-27a3502fd01d@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04845cf-c70a-4699-8260-27a3502fd01d@nvidia.com>

Hi Jon,

On 04/03/25 15:32, Jon Hunter wrote:
> Hi Juri,
> 
> On 04/03/2025 08:40, Juri Lelli wrote:
> > Hello!
> > 
> > Jon reported [1] a suspend regression on a Tegra board configured to
> > boot with isolcpus and bisected it to commit 53916d5fd3c0
> > ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> > 
> > Root cause analysis pointed out that we are currently failing to
> > correctly clear and restore bandwidth accounting on root domains after
> > changes that initiate from partition_sched_domains(), as it is the case
> > for suspend operations on that board.
> > 
> > The way we currently make sure that accounting properly follows root
> > domain changes is quite convoluted and was indeed missing some corner
> > cases. So, instead of adding yet more fragile operations, I thought we
> > could simplify things by always clearing and rebuilding bandwidth
> > information on all domains after an update is complete. Also, we should
> > be ignoring DEADLINE special tasks when doing so (e.g. sugov), since we
> > ignore them already for runtime enforcement and admission control
> > anyway.
> > 
> > The following implements the approach by:
> > 
> > - 01/05: filter out DEADLINE special tasks
> > - 02/05: preparatory wrappers to be able to grab sched_domains_mutex on
> >           UP
> > - 03/05: generalize unique visiting of root domains so that we can
> >           re-use the mechanism elsewhere
> > - 04/05: the bulk of the approach, clean and rebuild after changes
> > - 05/05: clean up a now redundant call
> > 
> > Please test and review. The set is also available at
> > 
> > git@github.com:jlelli/linux.git upstream/deadline/domains-suspend
> 
> 
> I know that this is still under review, but I have tested on my side and it
> is working for me, so feel free to include my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Great to hear this and thanks for the super quick turn around with
testing. I will be implementing the changes that Waiman (and possibly
others) is suggesting and post a new version soon.

Best,
Juri



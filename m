Return-Path: <cgroups+bounces-7751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33DA9947C
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7838E173FC7
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C371465AE;
	Wed, 23 Apr 2025 16:10:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918D2A1B2;
	Wed, 23 Apr 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424630; cv=none; b=Ku6vD2Bej2oV0eNSoQGApoMOYCf8BFyHxwXHhzt+GaF88GZZXKbXto8LGiEV1H/wmln8vH1yDl0tFJj9f4jqhX9Ou5CwtQUmNCyUNMOpnh3wjgvt5B7yrFyFfcSju1qq4neDzyFKuiCaohaLCHbEjwlbprGLBY1FD9HX5mBTudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424630; c=relaxed/simple;
	bh=KsvIbUrm8OSyttjgO753rlaHmKX2V4jvBHYmbymRQg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK+QlZ+ZtcRLUljbnEfEd89Ksrag36fzgil8Jo/FDYEv35WMyEowicC8Z2X2fHQHr7vH0yH03yDZ2+IpTjFIZK1wnIvxnQ/A2pIufE/dekpoco5aLCg4wNlwlzrxRhjLy5clPnlb1FgQraQ++xN4xyR6iT9jno0rEkoZRJxtWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E73C4CEE2;
	Wed, 23 Apr 2025 16:10:26 +0000 (UTC)
Date: Wed, 23 Apr 2025 12:12:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mgorman@suse.de"
 <mgorman@suse.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "tj@kernel.org"
 <tj@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "llong@redhat.com" <llong@redhat.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "raghavendra.kt@amd.com"
 <raghavendra.kt@amd.com>, "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
 "tim.c.chen@intel.com" <tim.c.chen@intel.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>, Chris Hyser <chris.hyser@oracle.com>, Daniel
 Jordan <daniel.m.jordan@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "mkoutny@suse.com" <mkoutny@suse.com>, Dhaval
 Giani <Dhaval.Giani@amd.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Message-ID: <20250423121219.15d5c2ec@gandalf.local.home>
In-Reply-To: <104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
	<20250417191543.1781862-3-libo.chen@oracle.com>
	<20250423113459.0e53be50@gandalf.local.home>
	<104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:05:44 +0000
Libo Chen <libo.chen@oracle.com> wrote:

> Also wondering if we can fail the build in this scenario so it will be easier to
> catch this bug at the build time.

 return -EPONYS ;-)

I wish. It's hard enough to catch this at runtime.

-- Steve


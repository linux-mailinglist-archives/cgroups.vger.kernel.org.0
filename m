Return-Path: <cgroups+bounces-7754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D89A995D6
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B214D189B0F5
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902A289367;
	Wed, 23 Apr 2025 16:55:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5712701BC;
	Wed, 23 Apr 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427308; cv=none; b=RNRDyE0r9bRy36fZ2MQAIt70k547BmHh1lEYQDoq2QkJiltSoLfanwODmkZZ0qgqw7EXIwoDOhrRpMHjaQ49/AW8IIrt44Gvz8VkwR/iLMJYRpSNxrUKPTmRDUmwW2InRvJHoIm50dKB7i/Vleq13YwZOwfOGeerTMATVukuAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427308; c=relaxed/simple;
	bh=iwMhWxLCcrPUFQPNwgY0pi2f2ZlK1C+Grx1MBipWhk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSlDJ/YYjF0VGYz4ELoaR8I/oTL2CcxVGEUjq2isSI0Eng/v/JmpaJy2mwWVUwTUBEbIxWrC0MNEppTbBxkAzWt3xDejRqI3ygbQR5H5Ukv1JE4qECi7bk1I7nFnbtuqiCoZexAuDq4JWOQGXITjeGtkhcE0TA0duwGMJIUWGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE02C4CEE8;
	Wed, 23 Apr 2025 16:55:06 +0000 (UTC)
Date: Wed, 23 Apr 2025 12:56:59 -0400
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
Message-ID: <20250423125659.3585b540@gandalf.local.home>
In-Reply-To: <720D1AD7-112F-462F-9ECF-A060670D62D4@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
	<20250417191543.1781862-3-libo.chen@oracle.com>
	<20250423113459.0e53be50@gandalf.local.home>
	<104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
	<20250423121219.15d5c2ec@gandalf.local.home>
	<720D1AD7-112F-462F-9ECF-A060670D62D4@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:50:15 +0000
Libo Chen <libo.chen@oracle.com> wrote:

> Correct me if I'm wrong but can you disallow any passed-in pointers to be
> dereferenced when TP_printk() is executed? This is something you can check
> at the build time, right?

You can dereference if the pointer is to the content on the ring buffer.
For instance, you can have:

  "%p*h", &__entry->val

It dereferences to the content stored on the ring buffer.

What we can't have is:

  "%p*h", __entry->val

-- Steve


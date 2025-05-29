Return-Path: <cgroups+bounces-8387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B042AAC77A4
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D221D7B0949
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B8253957;
	Thu, 29 May 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ESCRyFey"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877A1A3167;
	Thu, 29 May 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496400; cv=none; b=qKsTdT3kVWHdRUF12r1HijkblQwqNJ9cpId3Uk9DjBQX5JeiEqu3MTAHsGejlXrvn8Opc1LehhqajvlOu8cRagCOsKe4J4sDNTUTSj0FvuFZazvXElalT0teq6GMOtzUZrLephwyxnnunaQul0A3nFuzVG45M+68SiEAE8XumYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496400; c=relaxed/simple;
	bh=cVBzFvZviZ8pvz+47LE3tqeO5frJE/NB6BSJkLFA6pg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KybegitOcOTpPiHB6WVXysd8gBw8vw1B1zxf26k95WM9aVt+YPoxXCKs/Cff0Be82A/+At7mju5k9JsuuwA7fCE53EkpGh0dhbprMbLek489vlggHbeeCOC2BnnbPdlCxor8MhFc5TkOBgEqCBsikl5v7flDkHtfQ3lQuohxhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ESCRyFey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CACC4CEEA;
	Thu, 29 May 2025 05:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748496399;
	bh=cVBzFvZviZ8pvz+47LE3tqeO5frJE/NB6BSJkLFA6pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESCRyFeyzivGehtzkl2S80Ug9HK3ixH4GRTtOA6wrVrALiJs8hp0mC+2Lty58OWDH
	 /Ilre1ynJSb8+/2gYaB5WENLyyCPs7rbTosoc3QSIhJ5OhM90Bv4oAKtEpmYXW3dp3
	 eAvyF3JZudNJWtOEOvPGD5bOK4PczCXVxrPPtCvY=
Date: Wed, 28 May 2025 22:26:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: peterz@infradead.org, mkoutny@suse.com, shakeel.butt@linux.dev,
 mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net,
 mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com,
 libo.chen@oracle.com, kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 venkat88@linux.ibm.com, ayushjai@amd.com, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v6 0/2] sched/numa: add statistics of numa balance task
 migration
Message-Id: <20250528222637.38b3a12b6b01d2e499afcb7d@linux-foundation.org>
In-Reply-To: <cover.1748493462.git.yu.c.chen@intel.com>
References: <cover.1748493462.git.yu.c.chen@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 12:53:36 +0800 Chen Yu <yu.c.chen@intel.com> wrote:

> Introducing the task migration and swap statistics in the following places:
> /sys/fs/cgroup/{GROUP}/memory.stat
> /proc/{PID}/sched
> /proc/vmstat
> 
> These statistics facilitate a rapid evaluation of the performance and resource
> utilization of the target workload.

OK, thanks, I confirmed that there were no code changes since v5 and I
updated the changelogs in place.

I'll aim to include this series in the second mm.git->Linus pull
request next week, unless someone prevents me.


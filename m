Return-Path: <cgroups+bounces-2857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5A8C2100
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEAF2818DE
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB7161936;
	Fri, 10 May 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7UXPYPE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5F161330;
	Fri, 10 May 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333675; cv=none; b=u/X+Zivtf6KqyGd8JfkzLINhSg+djKLuj87CahC9dJW0nibHRk5Xd5fgFCnfN9nmUebZNgXYoa+VhmdXT6r6x4ClHstV4SM1GozyYXUTy6F0XTa9+ZkqFCLnA2OroZ5HQ9GJKySHghMRRhu8tgd5eWK8M/tPChew1olIR82XlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333675; c=relaxed/simple;
	bh=fkKst5tRTPmG3SWpn0MZBr1yx/AoXoDQnBVjNHcEMhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkxi2dy+IpoohgH7z+mC153CpHiYfz0Z8aMYU8/l5z7zZMlH/VXJhFAZfWwGTdGyLj6zot0GZnZeVywsFV+8TScaabdKN48ASIrKseJVSAMIjsY44j1BwccBeaISv5orxfjr/twEt4zZz6jsCnTNvStpuEAB0ShZnMc3cqXqptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7UXPYPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3B8C113CC;
	Fri, 10 May 2024 09:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715333674;
	bh=fkKst5tRTPmG3SWpn0MZBr1yx/AoXoDQnBVjNHcEMhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7UXPYPElwbH6RH2AbctTcL35+I6v0LHbxah7Qb0nxfHFh0PCe5zBFBuckuTCeszb
	 GQsalXVhtQ6PfUF8bCkmcVWGgg8P0d3gMCWGuPNWXGWx/wR5LN1QJKgmSVnaUnRgWS
	 yiuc0jxlH3sA6GPFbHlAaNYi9IJcU3chIloFPL027+FIEPajLPumlAntrtJC4DzkY5
	 thWGerpq92S8oGz5KVnXmyM0TFhzssV70mGZWDmyN30aywKkdc+fM9OMoTtO8aaThq
	 uohhmfzP+YNpMCnVDjpiZl7Zp9L+CfNA92DlxcWa9KLsbbWBvHQQD4XLKtAvg7wLAq
	 ab4exq9fijocA==
Date: Fri, 10 May 2024 11:34:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
Subject: Re: [PATCH v3 0/3] block,nvme: latency-based I/O scheduler
Message-ID: <Zj3qJP_J-D3DEP6W@ryzen.lan>
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509204324.832846-1-jmeneghi@redhat.com>

On Thu, May 09, 2024 at 04:43:21PM -0400, John Meneghini wrote:
> I'm re-issuing Hannes's latency patches in preparation for LSFMM

Hello John,

Just a small note.

Please don't reply-to the previous version of the series (v2), when sending
out a v3.

It creates "an unmanageable forest of references in email clients".

See:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

Instead just add the url to the v2 on lore.kernel.org.

See you at LSFMM!


Kind regards,
Niklas

> 
> Changes since V2:
> 
> I've done quite a bit of work cleaning up these patches. There were a
> number of checkpatch.pl problems as well as some compile time errors
> when config BLK_NODE_LATENCY was turned off. After the clean up I
> rebased these patches onto Ewan's "nvme: queue-depth multipath iopolicy"
> patches. This allowed me to test both iopolicy changes together. 
> 
> All of my test results, together with the scripts I used to generate these
> graphs, are available at:
> 
>   https://github.com/johnmeneghini/iopolicy
> 
> Please use the scripts in this repository to do your own testing.
> 
> Changes since V1:
> 
> Hi all,
> 
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
> 
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>   latency tracker
> - a 'latency' nvme I/O policy
> 
> Using the 'tiobench' fio script with 512 byte blocksize I'm getting
> the following latencies (in usecs) as a baseline:
> - seq write: avg 186 stddev 331
> - rand write: avg 4598 stddev 7903
> - seq read: avg 149 stddev 65
> - rand read: avg 150 stddev 68
> 
> Enabling the 'latency' iopolicy:
> - seq write: avg 178 stddev 113
> - rand write: avg 3427 stddev 6703
> - seq read: avg 140 stddev 59
> - rand read: avg 141 stddev 58
> 
> Setting the 'decay' parameter to 10:
> - seq write: avg 182 stddev 65
> - rand write: avg 2619 stddev 5894
> - seq read: avg 142 stddev 57
> - rand read: avg 140 stddev 57  
> 
> That's on a 32G FC testbed running against a brd target,
> fio running with 48 threads. So promises are met: latency
> goes down, and we're even able to control the standard
> deviation via the 'decay' parameter.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to the original version:
> - split the rqos debugfs entries
> - Modify commit message to indicate latency
> - rename to blk-nlatency
> 
> Hannes Reinecke (2):
>   block: track per-node I/O latency
>   nvme: add 'latency' iopolicy
> 
> John Meneghini (1):
>   nvme: multipath: pr_notice when iopolicy changes
> 
>  MAINTAINERS                   |   1 +
>  block/Kconfig                 |   9 +
>  block/Makefile                |   1 +
>  block/blk-mq-debugfs.c        |   2 +
>  block/blk-nlatency.c          | 389 ++++++++++++++++++++++++++++++++++
>  block/blk-rq-qos.h            |   6 +
>  drivers/nvme/host/multipath.c |  73 ++++++-
>  drivers/nvme/host/nvme.h      |   1 +
>  include/linux/blk-mq.h        |  11 +
>  9 files changed, 484 insertions(+), 9 deletions(-)
>  create mode 100644 block/blk-nlatency.c
> 
> -- 
> 2.39.3
> 
> 


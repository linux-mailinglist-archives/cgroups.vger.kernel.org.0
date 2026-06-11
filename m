Return-Path: <cgroups+bounces-16864-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+j2M1rwKmrbzgMAu9opvQ
	(envelope-from <cgroups+bounces-16864-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:28:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C9673F99
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 19:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=QHcieltN;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16864-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16864-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7032312BEF8
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539D4ADD84;
	Thu, 11 Jun 2026 17:21:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBF4A13BD
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 17:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198518; cv=none; b=m6CJhtagf12Bi4kSWFJmXGvnKDt7rAypmzXeyCVuSQCrWI0Qtn6H+E3tLpTZkm4LjoIJi80SJMvD9lBnlOUyxUfS5rFJK51HIQ1tC4LLij47VqUaT3qyWuJIZaPnvW8F8VI/lOG7dAWfax9G6eX7EWPBZZShYODjqwXnfJR2H8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198518; c=relaxed/simple;
	bh=J41vScc8tWOTlu0rD6gFdr0xLnd16WiIM1stwB23ze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIt1TzAKOdNq9m6gJ9EoYWFKhXoyo2kC7OBzHZjiO7wiXQT0QAhato8mbxD4mys9tm4LNEUdYrrG2inu6frvsQbrZE/9g3fBnCmYO6gvnpdpxN7oxt6ukKDuFAPKVdHVmf9cSsENaWB5tfPgnkLcNbHDOJE7nxp+cpP1YCuGQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QHcieltN; arc=none smtp.client-ip=91.218.175.188
Date: Thu, 11 Jun 2026 10:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781198511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Yb89dnim3jwXQsF33yzL/m+QYNw/vWjAYzs6MeYtKM=;
	b=QHcieltNPLyCj0doMAB67sVHLu2JhfhsnDfAxc61otPSi+Bm0Gp39yKZFr4vbb89v0xhNa
	b+eRQxHN6ksv8sJtAfXWxi9riE+TggyCxkY22OMoMlQicEZ376fzEW5D7j07Iy0YUj8FIS
	Vvk8zooGke9eFJLBHj3f6znMIYsVkyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: rcu detected stall in count_memcg_event_mm
Message-ID: <airuQ36pKQ8x8CZk@linux.dev>
References: <CAHPqNmzgCY+sHOOG8YVrCFO-7oh6TBeL4SCHEcfVvH6J1SUVdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmzgCY+sHOOG8YVrCFO-7oh6TBeL4SCHEcfVvH6J1SUVdg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16864-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:coregee2000@gmail.com,m:syzkaller@googlegroups.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 487C9673F99

Hi Longxing,

Thanks for the report.

On Tue, Jun 09, 2026 at 07:57:56PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. INFO: rcu
> detected stall in count_memcg_event_mm. Details are as follows.
> 
> Kernel commit: v5.15.189

This is an old kernel, can you reproduce with the latest kernel? Also at the
high level this seems like CPU starvation. Can you also describe your system and
the workload/test which is trigerring this issue?



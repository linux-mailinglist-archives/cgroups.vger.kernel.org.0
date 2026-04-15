Return-Path: <cgroups+bounces-15311-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPOuAv1t32m6SwAAu9opvQ
	(envelope-from <cgroups+bounces-15311-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:52:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EFC403707
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AA6C3029069
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18846346FA0;
	Wed, 15 Apr 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxpj4DTv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E72222D0;
	Wed, 15 Apr 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250205; cv=none; b=p/znGS8ASfdc+TKOtheRxWZQLrVzVEzXf2EPqPGLZfn54FBLiG8I6CvlorCsxnPXhvodX2d4tpXm045PMSnNHNqJ7K3KilUYpwmDBTyjkGV3Fb1Z8oDdhoSnWgsP919lYX3Y5xVzlIWY0VIfcmU4erGIUWz11rx7bwy+xaG43iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250205; c=relaxed/simple;
	bh=7Y9LZV6U1xyrOHwAijlBN1vXwQsWgvG1uZWTDoxA/OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHH/FegOcGukmM6o4ml3Yggl62+LbYt2h1LaHxysTqem+Yb+AswTuilb/bOhJfCiDPQFq2NcmjBrldwMkDquR1dj41kvTJhdLHyw7OUJjAG0a75pmX8f+eBSES4vi4dviPrcotfm41Wsy1F6nUOsiKHoeld8WPje7r1eagApYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxpj4DTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D0CC19424;
	Wed, 15 Apr 2026 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776250205;
	bh=7Y9LZV6U1xyrOHwAijlBN1vXwQsWgvG1uZWTDoxA/OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxpj4DTv/Yk7p5jvwdsLH5oWgEvb10ysaAyxQKmqcTsDbjN7noPDFcF4XY92vYNJb
	 dOBvecYWIYwyaKhU51xhNFbJzDK1/r+r7irvKFZf0QXmrqleaKgjuTdx9MEhpQPWHC
	 a/kBEIAQAcdivAYufyXZYmLM/fymJTb/ieawaY6CT9YD/021Wf0MNWjlUDAJiUu6r8
	 j0zwzpWv45cWJNWchRO6obf4PwTSAA+kyao49lACKA2EfoMqYVDGORFxrazmDTg6Qa
	 NooZUVllQoJyWF1P2kWtY0IE5W9KG6V0laP8BmIxTjn241wOO3SCgCxFMx9RDe2gzP
	 lV1YlUpVXGoGw==
Date: Wed, 15 Apr 2026 12:50:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 08/12] workqueue, mm: Support dynamic housekeeping
 mask updates
Message-ID: <ad9tWw-J_t-f6AcB@localhost.localdomain>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-8-06df21caba5d@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413-wujing-dhm-v2-8-06df21caba5d@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15311-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 05EFC403707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Apr 13, 2026 at 03:43:14PM +0800, Qiliang Yuan a écrit :
> Unbound workqueues and kcompactd threads determine their default CPU
> affinity from housekeeping masks (HK_TYPE_WQ, HK_TYPE_DOMAIN, and
> HK_TYPE_KTHREAD) at boot. Currently, these boundaries are static and
> are not updated if housekeeping is reconfigured at runtime.
> 
> Implement housekeeping notifiers for both workqueue and mm compaction.
> 
> This ensures that unbound workqueue tasks and background compaction
> threads honor dynamic isolation boundaries configured via sysfs or
> cpuset at runtime.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

Unbound workqueues and kthreads are already handled by cpuset
isolated partitions.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


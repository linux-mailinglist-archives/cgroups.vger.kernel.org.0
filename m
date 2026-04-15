Return-Path: <cgroups+bounces-15308-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELdqFIRi32mKSQAAu9opvQ
	(envelope-from <cgroups+bounces-15308-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:03:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD940318E
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48F5F3043D1E
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD934028B;
	Wed, 15 Apr 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQhxAiKe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB039FD4;
	Wed, 15 Apr 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247369; cv=none; b=rRfCiuESSENvcp4H+LSSbmz5N8sddPRznfijS2E1BieaDz01xYNoRpH33mnEukPQKm8Rhp1Fh1xZImTO9AlWHKDI9cM8+a8EGuNnAi/dKPChBsYMPTZOfmb9bW48KJoF8ZmELTunr/9rACj9pGTeSiIPGbShOE3H+sIvfLvWdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247369; c=relaxed/simple;
	bh=PiXJdW3kZWWKz5fjJpgKb9m4Wz+/cknIAv+flbdQIuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaGv1etRnk6K/37xxL8W7qqz/LEmmmtebj8TnQVaV9ygBgzUIV5QE38GPOAqmLAa7nF20OYzHEsaf2qw+HYobdPxHmNKrBetfkaUxqfSYJ8d0OE0GToYb1MYGSXaNRxKvZQFRkiNbmoFNHTVSMNicxTKMTFBowcyAUKJ+nnGmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQhxAiKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ECEC19424;
	Wed, 15 Apr 2026 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247368;
	bh=PiXJdW3kZWWKz5fjJpgKb9m4Wz+/cknIAv+flbdQIuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQhxAiKeGXat7xSllrdQgMuU3NlrY5J4zXg7WbTjtLVim6Pa+EFRh5ab5us4ML0tb
	 YB6BVgh5tuDWN+LUkb9oK6q+8zti+kGwuWOROVuxvpib5nOIJ47auNzzZK9vvOJeYK
	 iLfjRw7PwWfxmE6JpftYw8riHE5Gp1jIAQKtFWQlMvDvxfPL7FTNZGFQDOS23p4Y66
	 c45Y/UE6uE1WWgq2oWcsxXBgEbThqAE9D3xfvpPJ12JKymhYypKk4jcuDt5TWKYOOv
	 TtA0pFuBoSlaORK0YghptTx42cO1k6TPIF7P3/+ZMviNa2UfliakbM+aV29yJ98xyG
	 /NWLvUBGTJRCQ==
Date: Wed, 15 Apr 2026 12:02:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Qiliang Yuan <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/12] sched/isolation: Separate housekeeping types in
 enum hk_type
Message-ID: <ad9iRi7xrX89nbFV@localhost.localdomain>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-1-06df21caba5d@gmail.com>
 <fd77bca8-bee8-4997-a11a-932a1693edf7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd77bca8-bee8-4997-a11a-932a1693edf7@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15308-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 10FD940318E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Apr 13, 2026 at 03:25:46PM -0400, Waiman Long a écrit :
> On 4/13/26 3:43 AM, Qiliang Yuan wrote:
> > Most kernel noise types (TICK, TIMER, RCU, etc.) are currently aliased
> > to a single HK_TYPE_KERNEL_NOISE enum value. This prevents fine-grained
> > runtime isolation control as all masks are forced to be identical.
> > 
> > Un-alias service-specific housekeeping types in enum hk_type. This
> > separation provides the necessary granularity for DHM subsystems to
> > subscribe to and maintain independent affinity masks.
> 
> Usually, if we want to run a latency sensitive workload like DPDK, we try to
> minimize all sorts of kernel noises or interference as much as possible. Do
> you have a good use case where it is advantageous to remove some types of
> kernel noises from a given set of CPUs but not the others?

Right what we want to do here is to remove the aliases (HK_TYPE_TIMER,
HK_TYPE_WQ, ...) and rename them to HK_TYPE_KERNEL_NOISE.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


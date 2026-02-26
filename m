Return-Path: <cgroups+bounces-14428-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHNtF/tioGk0jAQAu9opvQ
	(envelope-from <cgroups+bounces-14428-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:12:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFB1A8561
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7653B317A9A2
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7D3ECBC0;
	Thu, 26 Feb 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhQRaUjH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AC3E95AD;
	Thu, 26 Feb 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118026; cv=none; b=NS7VYDqyEZqxCJi6nT0z+7Z77cxaePy84YIj/C6u76O/PlcVQLmNZKjY4e/6WPH50OQesKRP8qS+gAfXJNKut47FnOmI34hF1lyasPUC1yaPsMPWwnNHuFanYjxkdxE+xbRVWuYQfiRndk6wxWXZ27mzWIAk63XvMkX9uBGhZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118026; c=relaxed/simple;
	bh=bqZ8WWSZ5a3pZP4a60mik9GRowf40NscT6UmzsMmrCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndtbSGmZXzPePOosrgNL7jeHai5qznD0zMatvkh4w101Y7nU3FCEYx8FDrzZTMc6xrg0A8bOLdq6aH7Podu6GEii9voI28YPFzWvVLeRXnoJJZC6pDqLxWh20LJ9kVb48Id5eNf7VWS/xIwrZ6VnW2RsoCakFztALbFe1ypFyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhQRaUjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E64C19422;
	Thu, 26 Feb 2026 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118025;
	bh=bqZ8WWSZ5a3pZP4a60mik9GRowf40NscT6UmzsMmrCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhQRaUjHkExtpzjzcZJmhHfkYb6aPxi80dQ+PgUWOr6qhuFFTuVsQglEAmn7eble8
	 A1v4vrN2N1P0rBToaS7Y1FgodO6VFqRzpLwsIFuBxDZ5sZCsd/InLppdTx9pSBqfMu
	 vPhgO/KlfqVyoe1OO1G5WROG+8WN9UcPIt9SJd92eBcsAyo1hsjBXKM1LZ8beYA0F3
	 RJLellNuv8YHZTJN0wLfQH7Mffb9MXWKzXCHNrIVRK95KJOYX9I5kLnF5hZuhdAXJc
	 drtrbIpfuckKTTOKIdi47uTaUrbL9OeRZrXT792kjgZ9yaxf/KndlvKz3AEvmpzzaR
	 3pw+VTv91wniA==
Date: Thu, 26 Feb 2026 16:00:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/8] cgroup/cpuset: Clarify exclusion rules for cpuset
 internal variables
Message-ID: <aaBgBistmO3XpqF_@localhost.localdomain>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221185418.29319-4-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14428-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BACFB1A8561
X-Rspamd-Action: no action

Le Sat, Feb 21, 2026 at 01:54:13PM -0500, Waiman Long a écrit :
> Clarify the locking rules associated with file level internal variables
> inside the cpuset code. There is no functional change.
> 
> Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs


Return-Path: <cgroups+bounces-14433-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGGhLTlsoGk3jgQAu9opvQ
	(envelope-from <cgroups+bounces-14433-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:52:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416B1A9212
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9A2D3035E09
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A6426693;
	Thu, 26 Feb 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8e2LxfZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A019425CE7;
	Thu, 26 Feb 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121104; cv=none; b=QiI6r8tYFHgFpyyErCIkOwoflqzMN2RgL55qG5LdOcW1W0NccDQtCzqqKklTU0oxNJ19PlFIRLuy1c5DymcIJhiXi2jqUpidqHEIl7pMSBXN/e/WldrJi4i9ekEBdyD3iRW6tcsNlTwgLZXAyrIFLGks8sa8n14qOrpDyVFvMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121104; c=relaxed/simple;
	bh=VqaSR0JBQ1eUP4jJc2XA5zRz1WrMzIPDLeU/NMhZ2eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=decOFqYhFQunw9CUnHGW9o98qfOBs1969iDVFhvN8tW7kb1IAe+lHrZHO617l4Jj6pf7EQHjd5RJxzhfLtSL03GIwghulEByYXB3okwKI9ZuPWmf9wRgE23aUpRYqnXlwNlzUNPa2333FjR2FCyc/cEEGWJ6Hg4RRuonDGzZ1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8e2LxfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73AFC116C6;
	Thu, 26 Feb 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121104;
	bh=VqaSR0JBQ1eUP4jJc2XA5zRz1WrMzIPDLeU/NMhZ2eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8e2LxfZG+RYxPneRrwuDaahHvk0uGRF3lGx0jZW9232qQpW6t6to4Kj+g+IJ/MaA
	 1i+JMQRK3oae0y6XjtNxVVnXyhBiKeN5KwG/3QvqUSnZmqLb5cWrQ3lUUsErfinaJU
	 hXd/A0MDE93U88qnvFQLfpggPkcz6tVpSKy29EkhxP/0575z3omULcXX41qyarh5Mc
	 j2UgO/saAtUMYqPvSAeod3jBD+BvMYVQ2jgOL+H3n+5z8X8lRfKtMPSXiH+vz8L4lj
	 qJdctuiffQRH5xhQOKbM4Ac7uk/W+BKf8rN3g9CG/OLGIA/PK/84HnNdv+3k0qwT92
	 G/V6CcNFtkT6A==
Date: Thu, 26 Feb 2026 16:51:41 +0100
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
Subject: Re: [PATCH v6 6/8] cgroup/cpuset: Move
 housekeeping_update()/rebuild_sched_domains() together
Message-ID: <aaBsDV7X0q4sNTTJ@localhost.localdomain>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-7-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221185418.29319-7-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14433-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 5416B1A9212
X-Rspamd-Action: no action

Le Sat, Feb 21, 2026 at 01:54:16PM -0500, Waiman Long a écrit :
> With the latest changes in sched/isolation.c, rebuild_sched_domains*()
> requires the HK_TYPE_DOMAIN housekeeping cpumask to be properly
> updated first, if needed, before the sched domains can be
> rebuilt. So the two naturally fit together. Do that by creating a new
> update_hk_sched_domains() helper to house both actions.
> 
> The name of the isolated_cpus_updating flag to control the
> call to housekeeping_update() is now outdated. So change it to
> update_housekeeping to better reflect its purpose. Also move the call
> to update_hk_sched_domains() to the end of cpuset and hotplug operations
> before releasing the cpuset_mutex.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs


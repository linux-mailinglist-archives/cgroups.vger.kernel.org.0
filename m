Return-Path: <cgroups+bounces-15111-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMC3LRi/ymkb/wUAu9opvQ
	(envelope-from <cgroups+bounces-15111-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:21:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B635FB28
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF9F8302961B
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85307366056;
	Mon, 30 Mar 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awxIo7pe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5528DC4;
	Mon, 30 Mar 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894866; cv=none; b=b/uwAK08yoDqx4BmYlYGiL5dCV4OAPDt7qKxEEGnP58UQEuNndRMF0UrIFuRMPoVfqKv1PeYD6ds0303kfXpGqGDnODd/NAQsQ8v7iy4Itw5QMjxqUo6LoHPkW6cEW66MXcHbaUHK9jEhg6Qeo09bvaRlw7fnenN70Cj8LE7kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894866; c=relaxed/simple;
	bh=wLKFz1dNqc7DzZ0sjh8HsTDFHr786GFLYOG9cUpnLdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcPgRIUQtbsY9KqVMYta5AbJsa72kBR1N/on4u9mvH46xi97CUvQdwSc5bmn0K1aTo3rLMfJV2XgX3IDdzAwYaYh8c/K7tss8dWQU/nSkYqN2zZ+no+nTn57y+Lp+nlKcbbwqsNDiJ6nuYXfHqvI2+wF15kv98s37bS2dVgm0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awxIo7pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97847C4CEF7;
	Mon, 30 Mar 2026 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774894865;
	bh=wLKFz1dNqc7DzZ0sjh8HsTDFHr786GFLYOG9cUpnLdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awxIo7petjzPEnV73OfwVtk+qt1fTfvrL/dBhNG9n2B8PseXB4+20DUSkt/Lvsl0k
	 My1D9fIHhr3RmTPNNdRbGICh00CPQTt40fZVRYfpYaflU+ql5li+LaGgBvQ4Nw48wu
	 DD88SmabxO9Aik/Y4gyuMQZ5+Ud9laPkLQgnnQnMFxhPVK87jGJxMc8Ql/v6mo2gxP
	 fYSalTNH1VCsD78yRCeNLuC+vaPss6sJXH7BIOG0S7WukGFmKLo9NPwBbnlMENiYg1
	 vVtdgRw+HQin4wrr4rQv1UGgnzeBLiykI7LiHYoymo/zLCYS8riHZZw/1C2h1IRVtA
	 qhRDG5Y71uk3g==
Date: Mon, 30 Mar 2026 08:21:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Chen Ridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
Message-ID: <acq_ELmOia9K8dw4@slm.duckdns.org>
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-3-longman@redhat.com>
 <c80c6838-e33e-4e5c-82ac-9bfa4d012dcb@huaweicloud.com>
 <83e3d0fd-ab1c-4078-ae0a-e902e92fcdb6@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e3d0fd-ab1c-4078-ae0a-e902e92fcdb6@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15111-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 332B635FB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Mon, Mar 30, 2026 at 12:15:01PM -0400, Waiman Long wrote:
...
> > If there are many tasks in the cpuset that has no CPUs, they will be migrated
> > one by one. I'm afraid that only the first task will succeed, and the rest will
> > fail because the flag is cleared after processing the first one.
> 
> The setsched_check flag is used in the cgroup_taskset_for_each() loop below.
> That loop is going to iterate all the tasks to be migrated and so the flag
> will apply to all of them. So it is not just the first one.

During migration, a taskset is used to group tasks in a thread group if
cgroup_migrate() called with %true @threadgroup. That doens't really apply
here. cgroup_transfer_tasks() doesn't set @threadgroup and even if it were
to set set, there can just be multiple procesess. Besides, it's rather odd
for it be a one-shot param that gets cleared deep in the stack. Wouldn't it
make more sense to make whoever sets it to be responsible for clearing it?

Thanks.

-- 
tejun


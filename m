Return-Path: <cgroups+bounces-7285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64472A78302
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0051891005
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705E20B7EA;
	Tue,  1 Apr 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhDoIu3t"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEF149C7D;
	Tue,  1 Apr 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537580; cv=none; b=dKzF7q1jLNNtZQbemTrWOls63w3jo+srIK7dvQS5Es8DSe20o4nd8XunQr1+gTNqNwccETOw02v6b14pEEvMBZWe0317ZR94svTG4IkQzN8RJZrsux3geyrOOHOQ7YeDxTTSNvWiuJRLfNmZldfhcG3C5HeBdd7M5aEjIJlI6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537580; c=relaxed/simple;
	bh=tncNSm+UNYU1jooNfPV27W/DH7UbX3ICgX+sPHAz5jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIRJ8b9u1TsFf7fkBbB0Elv70y9jN2zdPV89IcgWjeuRNbkf0ZUK3vvE0w61DnZH51G2ZTXnD8/8FaQoYswRZtoESIlIkFS1pgdq1d/00xPJkngMq9H7OW9rzKGJ8S3T6yiSH58+ptJuwdXy+0BBVrCzweNpElZeWUAViloy7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhDoIu3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A9C4CEE5;
	Tue,  1 Apr 2025 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743537579;
	bh=tncNSm+UNYU1jooNfPV27W/DH7UbX3ICgX+sPHAz5jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhDoIu3tP7Yb5bpoY/L4pQIzGPL14n46v3UDUR6FYHFCEbccIrMCOKs5u6C6yDfhm
	 Jmyhumxp2Kdg4O0pebV7ZYayJJvzP2zITFiLhuA/cEfGMA16l9rl60mrTqb8rP5ydY
	 iDNnYD0Fb4qMWd0iNh9BO7dNNHgReM06pGUpKItYh0LgDckIK9LPI0GswdPdoCoULP
	 zwAiGN0KP6vNJUw+Tvv0ZF6czCpGn07Uo+tpkri38GRiDTLqsok3JhVr+paCDCVwNY
	 fxAH2sQkqKQM/ov/8W/7IKmZWEWTxFvtT/pZal9tIpGdV+Y48PTMaGHqQlCWAFd14r
	 xRbARAOfAwMSA==
Date: Tue, 1 Apr 2025 09:59:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <Z-xFqkBsh640l5j0@mtj.duckdns.org>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-shjD2OwHJPI0vG@slm.duckdns.org>
 <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>

Hello, Waiman.

On Mon, Mar 31, 2025 at 11:12:06PM -0400, Waiman Long wrote:
> The problem is the RCU delay between the time a cgroup is killed and is in a
> dying state and when the partition is deactivated when cpuset_css_offline()
> is called. That delay can be rather lengthy depending on the current
> workload.

If we don't have to do it too often, synchronize_rcu_expedited() may be
workable too. What do you think?

> Another alternative that I can think of is to scan the remote partition list
> for remote partition and sibling cpusets for local partition whenever some
> kind of conflicts are detected when enabling a partition. When a dying
> cpuset partition is detected, deactivate it immediately to resolve the
> conflict. Otherwise, the dying partition will still be deactivated at
> cpuset_css_offline() time.
> 
> That will be a bit more complex and I think can still get the problem solved
> without adding a new method. What do you think? If you are OK with that, I
> will send out a new patch later this week.

If synchronize_rcu_expedited() won't do, let's go with the original patch.
The operation does make general sense in that it's for a distinctive step in
the destruction process although I'm a bit curious why it's called before
DYING is set.

Thanks.

-- 
tejun


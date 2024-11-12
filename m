Return-Path: <cgroups+bounces-5520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF19C6105
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850532853C0
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841421832A;
	Tue, 12 Nov 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du6wzgQA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1904207212;
	Tue, 12 Nov 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438509; cv=none; b=RYCEUP1Y28kE2Vp1zNoAdoFhBNAZNt39z/VtEJNb4S10Xiz9FVVL/Yg5GPoXQE9dnUN4vvINh7MhqYP4x/YHXhNlBDFNJ2SKLSiueCClhrIW6Sai9M0TmvhV/kWGtl3buF+/KDzIji54A9mgXYTnxLLQj8bAhJW2tvuly1AzZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438509; c=relaxed/simple;
	bh=qvf55bd6aibk12ZnaIORjrXt39F6ExkPJK5maKjA7Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guT64Hn8T39eEct7WjutpWT20w95AsRyfegvo2ZCCuQStA3PSDG50jspCZ3TY780Y6NQR4pXmg3nwyukz/aa8q9ygAGAS2/BnHqrwQDINYS++phPndM6omgzNVg5+N6+H+OqkbZDxuTzSzq3eCriglhaHo9umB0VA3CcX4fdv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du6wzgQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB61C4CECD;
	Tue, 12 Nov 2024 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731438507;
	bh=qvf55bd6aibk12ZnaIORjrXt39F6ExkPJK5maKjA7Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=du6wzgQA0DrEscYRYnaXLCfykKE9TyaHbLw6Xpc0ietw+EHmlRDiTcNEmqWw0qNes
	 Wq8ih4SrJPeqQ/mQT8VuHffVmkuoT8p8FqZjkOtkwQCSixBuPKDz9nyvg6TEJcTrOU
	 Guq+TitJOpcZ55hxTYhBpRMt9mImj35RZ1hN6NfYbsjgtkhE2Te90P10SqeH0gqzWY
	 Fr4jdICaA9phAIhq72B2Fp/9iMu5lOchgOgE2SGizP2DAkhCFMVdPrN4yC/AzwOz3i
	 FUOy0RegLzmKDY4A5/8yRxCb7FIIE4eTJJdr+MgNNA9l61yNg5nU0H/I5O3JTKRc9J
	 Y0SbTf1BkpWqA==
Date: Tue, 12 Nov 2024 09:08:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 0/3] cgroup/cpuset: Remove redundant
 rebuild_sched_domains_locked() calls
Message-ID: <ZzOnqqu-Wg3V3z1z@slm.duckdns.org>
References: <20241110025023.664487-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110025023.664487-1-longman@redhat.com>

On Sat, Nov 09, 2024 at 09:50:20PM -0500, Waiman Long wrote:
> Waiman Long (3):
>   cgroup/cpuset: Revert "Allow suppression of sched domain rebuild in
>     update_cpumasks_hier()"
>   cgroup/cpuset: Enforce at most one rebuild_sched_domains_locked() call
>     per operation
>   cgroup/cpuset: Further optimize code if CONFIG_CPUSETS_V1 not set

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun


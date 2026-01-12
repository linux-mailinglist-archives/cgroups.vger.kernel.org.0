Return-Path: <cgroups+bounces-13096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C7D150A8
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE203043F03
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CB3242BC;
	Mon, 12 Jan 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aISKZsF5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028642DF122;
	Mon, 12 Jan 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246324; cv=none; b=RTQGghtiKHmxovRLGcZAkm5hSMwY5pA5uLQvjy7ksF/ygoIcr/2ipqDfho0HIWjQ1lSr994INzms0CI+yfNU195lpGHG/013Zx4h+ItlDdKVT8BkGb6KhZ/NXADCtAZ6ywjg/+bRcifj/EMxl5rntIyk3CW+0f7f0nehh+qhuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246324; c=relaxed/simple;
	bh=mmyRYWrNXyiFol1EzO2ZXS7h+n3gTjk3EHTt7AJJ+sg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dHigPtUm02ikemxwnAhbnpYJc+Afh7XX7lQHhIV+r3SWiou2Ii7V1Vct0MHUyaORyBEo8JMV6+W/p8jPxuVn7ABkDXBwbl8lFmHt4uSok/AgJYi9LSwgaOQAZ2156UuBcqkmRsAa8zYicguktCBrklTQIJ/1BL3iSP57FPWrWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aISKZsF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CFC116D0;
	Mon, 12 Jan 2026 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768246323;
	bh=mmyRYWrNXyiFol1EzO2ZXS7h+n3gTjk3EHTt7AJJ+sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aISKZsF548wqdnnznxChDJHMSRsN2SLTIJ2VkOkILoprWtIuDiJTlCxgcIzP+lc9c
	 UnVdCZAIOcFzS0ERoBGEhv8e1mMAt9mTfko5I00ta1p2F9kU82qTdYkMr1G4wuQL6+
	 ln3mKkbAMbsrJp8ZJB15SfJws/Q22UfYVuKyUvxHgSUtv1avcqax943A5WnMFQoHtB
	 2yqhPG90wtbm3uywWVSnpBfk3Pd5BVhvylaUxy9cNAZuacZ0/mjh1wGsoUuJOPN5aB
	 LnbaoBLhKJ4QW1GJ2k7x+bANw5NO3ESEiOjhhdTghNo+md3ic6PJr0iwtvfk4qFad5
	 YP+7U0OeR/0aQ==
Date: Mon, 12 Jan 2026 09:32:02 -1000
Message-ID: <7aefe9e72d50112957940405affd3d4e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Waiman Long <longman@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [cgroup/for-next PATCH RESEND] cpuset: replace direct
 lockdep_assert_held() with lockdep_assert_cpuset_lock_held()
In-Reply-To: <20260112071927.211682-1-zhaomzhao@126.com>
References: <20260112071927.211682-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.20 with the cpuset_is_populated() hunk dropped as
the function was moved to the header file by a preceding patch.

Thanks.

--
tejun


Return-Path: <cgroups+bounces-4434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9E95DA45
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 02:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987251C21F8F
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B5029A1;
	Sat, 24 Aug 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej+wyhS+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EEC23D2;
	Sat, 24 Aug 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461093; cv=none; b=MiNShfKSZJCJIz4HzEXM2/3a+BwWGBZF9/IJSm7XKEO0ibGNbaP98qw7u2bL1IM2MN7X6XrjncnijuiyPAM+QcpD52TDZzkX1Rpepb64J4hGu6xq1/XryENv/BXD0+TIfZQKj7SvqZ5xXIt8bk1cFGJb/uJe8dgRthAljC4Q1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461093; c=relaxed/simple;
	bh=wLpRyS6Ez4NZGfYJdL3ji6PyWJDWj5wQhQaWUUUhD68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WshknsGewbb+iZJB5BcBihbrQMUrYruJ+IG/wCCU/6qNIkE3VokMOzyPuSBlY08oCczCOJLkKW+koJusUaYa5aEaSgfwlefIzrB0Ts/7r306TQsQRIh7DBw9TB8EV8hjHgk35HxoMxi8KkVfvDrFzMmUnhS8uGscqwnsEDpcTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej+wyhS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B147BC32786;
	Sat, 24 Aug 2024 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724461092;
	bh=wLpRyS6Ez4NZGfYJdL3ji6PyWJDWj5wQhQaWUUUhD68=;
	h=Date:From:To:Cc:Subject:From;
	b=Ej+wyhS+SS3omS9kOjf2VJDnIUTAKgH6PJoY/HP8+X8DJovX5obaPLPwUB+5kEWs9
	 UcNcr/jSP1+nbXBxMp1tw7IHcM2HszDwV4tKmRUkkwqa7qycfmJawngDV1Q4HBp0MD
	 97wC/eZi5ok49F49pTePte6N/WSXi6tFUJ43FxojNxJ2jU7GEZIiCkAP8iLExptIq9
	 D2Qtq4zMkGhSPaopLn6+qn27Mq6ajjN877KdXQZMCDXgb25vnes6GMPUZwo5ZuVgxc
	 K1Nv0W1XhIgUyyDx+YGPG5ducZqVHA+9wzn6+lpFPMFBZgqbLSZlJKrHQ2wjpmZst6
	 yxTpSSit+eq1g==
Date: Fri, 23 Aug 2024 14:58:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup: Fixes for v6.11-rc4
Message-ID: <ZskwI2nciPwdwNeA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11-rc4-fixes

for you to fetch changes up to ff0ce721ec213499ec5a532041fb3a1db2dc5ecb:

  cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug (2024-08-05 10:54:25 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.11-rc4

Three patches addressing cpuset corner cases.

----------------------------------------------------------------
Chen Ridong (1):
      cgroup/cpuset: fix panic caused by partcmd_update

Waiman Long (2):
      cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing only if cpus.exclusive not set
      cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug

 kernel/cgroup/cpuset.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)


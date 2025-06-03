Return-Path: <cgroups+bounces-8428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C8ACCD3E
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 20:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32E316EB8B
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20D288C35;
	Tue,  3 Jun 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+cmvMvL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684E18DB24;
	Tue,  3 Jun 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976182; cv=none; b=r+8RPfKXNG6yYXtduVfR1CmGaLl/cZlM65ALSPwk2XUUH8ky/Syn+2E6/yvnPnH2zwlz0nQ/+xwoUSRBv7XOI8dUlrh7HMlNHcqdEf/wcwJhlux10m85+I5jfQtJHuotg2NFtgYCq1AC5KY+OKZbnVUBOe/jP1ULcB3VcApPr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976182; c=relaxed/simple;
	bh=nNiKNQY+MIhCiea5NHlLT+IwR1EGNB+D4oonGblbQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G36DoVDRPsEdvo7eMic8ce4MOcsN5ApZy6S+g7YT18fwQZLuc+1mPERsAq/0tejmlsiuLtFL4xbU35yBG/td0kD5bgBbW609b4vprr1oURdrok7+oIyQ3X47RLk2FSOh0VOWvS9CAQXPgFJci50UestHrmGxvGXWS461Ts37ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+cmvMvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56474C4CEEE;
	Tue,  3 Jun 2025 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748976181;
	bh=nNiKNQY+MIhCiea5NHlLT+IwR1EGNB+D4oonGblbQqg=;
	h=Date:From:To:Cc:Subject:From;
	b=m+cmvMvLGb5Sy5BlKDq3L7MxkGKhW/G8mpAXGtZZ1F8Xa41nYz/g93Q8KkrDBKtir
	 6Rrz7JxwKBPw+Mkfuq2F6U0zLVl8EA6+RbUIoVLedZE3Dq/XaCBl5JQ8xtbB9N0TwZ
	 /AZ2+IJUOwEqFjGPJ8o0oD+44hpLiZXbwsDwFXqYy4hM5gRkPX/Id8vLdu57RkOqAw
	 fwlhCwf4Jicb9Ar+Qgfpr43Vh0GMDrA+VE/fGn7Swxhy46dpi4Iz7qIn9u6Rkhvlk5
	 YMIDvYL6SWV5uo/JzURcOgyg0qZ3DRsV4oI93bu6+dSa9/pBKCMuAY7MoaZx3kxa8V
	 5PnTV78Z+12Jw==
Date: Tue, 3 Jun 2025 08:42:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	JP Kobryn <inwardvessel@gmail.com>
Subject: [GIT PULL] cgroup: A fix for v6.16-rc1
Message-ID: <aD9CL3oO5LFgKNXY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce:

  Merge tag 'pull-automount' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-05-30 15:38:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.16-rc1-fixes

for you to fetch changes up to c853d18706de8c9525126b362f747d2e480e93df:

  cgroup: adjust criteria for rstat subsystem cpu lock access (2025-05-30 14:36:13 -1000)

----------------------------------------------------------------
cgroup: A fix for v6.16-rc1

rstat per-subsystem split change skipped per-cpu allocation on UP configs;
however even on UP, depending on config options, the size of the percpu
struct may not be zero leading to crashes. Fix it by conditionalizing the
per-cpu area allocation and usage on the size of the per-cpu struct.

----------------------------------------------------------------
JP Kobryn (1):
      cgroup: adjust criteria for rstat subsystem cpu lock access

 kernel/cgroup/rstat.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
tejun


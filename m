Return-Path: <cgroups+bounces-12363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBCCBF0DD
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 17:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51F253021F43
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856DC349AE8;
	Mon, 15 Dec 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goI7KLZ9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DF349AE5;
	Mon, 15 Dec 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817665; cv=none; b=H65ldNOjeYFI/tIgUSyR0cEd9CBhRn8+CDpqX6tf++nMZFqNJGgdYGG4fqEaEUzq0qtJS54CyYBuhvk2tSnhhQHjjHFYuLfhDGfx+ykAttXDy674IGntPB8fEXzkHF8jJRSIDB58gytkdKRh430dUwKXBiD2G9vT5ZtR6aZ1OFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817665; c=relaxed/simple;
	bh=ErcJTU2I30u0iJrXjVOiwteg+1NQErBclsLxc0MvMao=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dgBXxQfkGj8atq48KfI+OyycRViyiH6DMVz3gZ3PztEcpOacV5pCxGwDj7buHB4bl0vDzH8qBaOFXMg0+QxS+7yz9N44qC9Xy65fXHTwDXeqw+J7vPDFJyQGvv7Yjd9O4XpJ1m318EONrtSq7IxmalpQgvdrzQu3Fl4RWJwlCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goI7KLZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80899C4CEF5;
	Mon, 15 Dec 2025 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765817664;
	bh=ErcJTU2I30u0iJrXjVOiwteg+1NQErBclsLxc0MvMao=;
	h=Date:From:To:Cc:Subject:From;
	b=goI7KLZ9c5K84iFzl0DVs6DwK9e+ygnJMrd5ZDwWxt8KcjodsFLDMsR5496xkmpWl
	 fIGt6Ip4CgP53+hufr2WV9807KLyy5Gm660oJDJ/jCTObK0xqVAOlKW4jE8a4mFvak
	 k1BHEFUPiwmW4oGd7FOu9PBEG3oOX57SLV2Nx/N/RPkiK/p4gSGu2Yh18DoncuYsY7
	 Wn5ZXjvKULIpQn1ralFg0Xeh7Pz/06AUZ09AHMIRjWCAeaLAe7wYM4RnYPyZr6h7BS
	 4fLS7Ba2hq5LH7+u57blZ6D5/nFlqvbAute7fwgSq6zluMii4zK5U8Mzcoe+Io13sB
	 dCFsgPd2D5tQw==
Date: Mon, 15 Dec 2025 06:54:23 -1000
Message-ID: <ab515375a4aa072868aeba23668fe162@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.19-rc1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Hi Linus,

The following changes since commit c2f2b01b74be8b40a2173372bcd770723f87e7b2:

  Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc1-fixes

for you to fetch changes up to 3309b63a2281efb72df7621d60cc1246b6286ad3:

  cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated (2025-12-08 08:26:56 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.19-rc1

- Fix a race condition in css_rstat_updated() where CMPXCHG without LOCK
  prefix could cause lnode corruption when the flusher runs concurrently
  on another CPU. The issue was introduced in 6.17 and causes memcg stats
  to become corrupted in production.

----------------------------------------------------------------
Shakeel Butt (1):
      cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated

 kernel/cgroup/rstat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Thanks.
--
tejun


Return-Path: <cgroups+bounces-7684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0EA956C2
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA13E1890557
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC111A01B0;
	Mon, 21 Apr 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWTpeUiL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F11CA4B;
	Mon, 21 Apr 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263943; cv=none; b=QhmApGenzpJdqQSweWZi3O4dudhNOpAL/BC4ZNkRec9aVMknIE35CBlH7tWOtW/spNL9O+8i2Fq4M+MjXiKDIr4GXYyhuAmRpOtXrSzq6qBCEZzLEOhIhVDRFQ2HnI+a9CeY77NmkEPsERMSoMpk8jZcmggMmV4JguxDap7h/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263943; c=relaxed/simple;
	bh=rpxdkaF2RVUAMtSxv8qBO5V5KupOrGKZB+ESy62Fc5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qa36Z52IY3shbFM2rGRgJUS+DWZH6YQga6lZewlID+I89D0JAPKOuskkoTylqe+2JWUknON/pBBmLaNRUcfIxNSp8HGujuP3ejnhkJBvluuIxHUrakIxRL7hD4BYfMTkbjHw0DDV0zPhjT2h987dmxRK97fDp+Xxajr0SjkPgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWTpeUiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCF7C4CEEA;
	Mon, 21 Apr 2025 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745263942;
	bh=rpxdkaF2RVUAMtSxv8qBO5V5KupOrGKZB+ESy62Fc5I=;
	h=Date:From:To:Cc:Subject:From;
	b=XWTpeUiLnTFWsioJMe9Q85PqeH1ggh3PO5+lbhME1NX8f59aZixkSjyZFFj+qh746
	 8/t181OJtXpsTstKe7UHMjvdZrLnrOMqVyWn6xKvDuiY1ax820wu3O1mecTObyV3KB
	 vZydEP0EomZoIV12/TrOzIryV0zSzD5LBmDa5N20WCSVR4IglabHM/YYSRSVTSlJqS
	 TPTsA44kpBut05Ldvx9S+NygH4XpdlKKQCzGxOfsVJM49C03oZyufW5sf9ZuiJMgLQ
	 rqQfPzS9kugjI3InSHbbHoRAvsX7aS4XSIF15Jd3HvOSclLB95xEtU0ZTJwycND1Mi
	 9JV5UkrbDK96w==
Date: Mon, 21 Apr 2025 09:32:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.15-rc3
Message-ID: <aAadRYdydJYibDwB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cfb2e2c57aef75a414c0f18445c7441df5bc13be:

  Merge tag 'mm-hotfixes-stable-2025-04-16-19-59' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2025-04-16 20:07:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc3-fixes

for you to fetch changes up to 1bf67c8fdbda21fadd564a12dbe2b13c1ea5eda7:

  cgroup/cpuset-v1: Add missing support for cpuset_v2_mode (2025-04-17 07:32:53 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.15-rc3

- Fix compilation in CONFIG_LOCKDEP && !CONFIG_PROVE_RCU configurations.

- Allow "cpuset_v2_mode" mount option for "cpuset" filesystem type to make
  life easier for android.

----------------------------------------------------------------
T.J. Mercier (1):
      cgroup/cpuset-v1: Add missing support for cpuset_v2_mode

gaoxu (1):
      cgroup: Fix compilation issue due to cgroup_mutex not being exported

 kernel/cgroup/cgroup.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

-- 
tejun


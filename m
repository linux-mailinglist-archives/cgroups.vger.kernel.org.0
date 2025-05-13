Return-Path: <cgroups+bounces-8146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D6AB4886
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 02:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D419E8114
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763867DA7F;
	Tue, 13 May 2025 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuFLWQph"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCE7346F;
	Tue, 13 May 2025 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097068; cv=none; b=tvo1S5g9e4KojnaPyONXK5xERAc4qTxaID5d5bzSu2up84FvjTj0mGZKDvU/wLL465uSvLbe6JUI7NuWTZP73LspJK9zghgHKOCx8/vzLY9rtR3ckKaywzlWfQy8jBuNbwf61JEFci1ddtSDBB0lJiRMdC2WNWtawltikDzOXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097068; c=relaxed/simple;
	bh=+0iTciGzBfR0HdqvDFtENps1Vl+DYeFfLxf0nyUiFdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ATU4OJxAJoO3nN4i84uXl8Pdrqxiqn881Yk83OFCC4K9UJRa5HCvX9Si01B2k8OV02TCoSvpmCHttJRUjBZ0VOPNuI2YuA8/pH3Jrl7WFVI1cgZLbgKQiarYY0PUkQswqqYpCcaohVuMHeRHBVvxd5M30tXk9h/7EOMJv+pAaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuFLWQph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A95C4CEE7;
	Tue, 13 May 2025 00:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747097067;
	bh=+0iTciGzBfR0HdqvDFtENps1Vl+DYeFfLxf0nyUiFdQ=;
	h=Date:From:To:Cc:Subject:From;
	b=LuFLWQphTsF6tSiP8sNnBkSgtAVfRQmUWWwPOrk8UYBD4x/egdGgNw6A1XC6+PxgL
	 aQa7+dgp3uIAshDt55trgz1peMGhXu22gxqniGTTrozTSBtyGA9BJAmy7lSJpsXzvm
	 C6NOtnZKEgs1RrgTzQpHqzKbKdjSO9zRbhgdywbNlunMOVD4uioIrIzDTgcyFcYH+p
	 9hDufmKkHWfXdywy7Ty/vpXlFmVvs56s7s4qIKAc+l9cBB8+FtZ0ryt8ydamVu9mim
	 QfddzatlUXg2rutCt6Bb9/+FAX/lt6KVn/XQnBz8aI7QnLJsaG6QdhHWjMnJMKikeK
	 S18Kda+T8WvdA==
Date: Mon, 12 May 2025 14:44:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup: A fix for v6.15-rc6
Message-ID: <aCKV6jvb5Cej5wlF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1bf67c8fdbda21fadd564a12dbe2b13c1ea5eda7:

  cgroup/cpuset-v1: Add missing support for cpuset_v2_mode (2025-04-17 07:32:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.15-rc6-fixes

for you to fetch changes up to 39b5ef791d109dd54c7c2e6e87933edfcc0ad1ac:

  cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks (2025-05-09 07:35:14 -1000)

----------------------------------------------------------------
cgroup: A fix for v6.15-rc6

One low-risk patch to fix a cpuset bug where it over-eagerly tries to modify
CPU affinity of kernel threads.

----------------------------------------------------------------
Waiman Long (1):
      cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks

 kernel/cgroup/cpuset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--
tejun


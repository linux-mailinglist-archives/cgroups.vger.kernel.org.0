Return-Path: <cgroups+bounces-9312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161FB305A2
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D95E33CE
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4702FC026;
	Thu, 21 Aug 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prvdqZIV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F322F362E;
	Thu, 21 Aug 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807262; cv=none; b=cSk74giqcSVhX2WumhfypAGr70tc7/Yh/wez1L8tdG6PkSPiaMt1TUCmVnxYKeKYT+3YIbTLSD2SF4IorJ+3ih6FLaJgLocN02Ui8wAIzUtkOUAvD40cfW0lAC9fQZzrB2Lg8LXrQT6zoP4gyL9GXt5SQCyTjIb/+NvpqeN5nAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807262; c=relaxed/simple;
	bh=QMBXSzK2U64jz96+ZN/QYNMpcwS4a7Az2XADNkpLqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XHH4EINdlBJ83eb/6AvNnxtccUGysy3VAFmojzHvcFgXFk3i+NOscBXNn5nTaptEpZfIlI9YVMnDBOhJWPksRp94F03SiBFpuPWQCom7NSbVjLn99VI1PlM0zh2bvhYQ9M8mMZcXFiFbGQCqomMLq3oaHfwLysvDcnNHrAqbS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prvdqZIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EF9C4CEEB;
	Thu, 21 Aug 2025 20:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755807260;
	bh=QMBXSzK2U64jz96+ZN/QYNMpcwS4a7Az2XADNkpLqeY=;
	h=Date:From:To:Cc:Subject:From;
	b=prvdqZIVXfJgjz/jlv8qz2CTmf+b0QhS3fsGh07xKo+2NODK0WRSZS7plhZc/OGaq
	 KCu5o76UvH1/5ewXlm9MqWnuPavahYAp32VK68DdTQduwn+9kXyk1q40ZaSlDZN4Jr
	 9vk21IC60/H9XSiWBa+IcEDFmCXrVndY1/WolBKJDViFDbu0UCBONwZ2cjzhIiAddh
	 3jLagXshcz8CCpnvlI5eV+YBkZ1f91mPN6y4YKoiLYTc6gQ6coc4iPA6r7tLcFe2Bz
	 yiaFWs/+6CpNnD1mbtwtAFkeXilJzFECpAHNRpyAY5sfOJM0nt6YnOiQFLPHTqFtF0
	 A3mAvnLaaSg1Q==
Date: Thu, 21 Aug 2025 10:14:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.17-rc2
Message-ID: <aKd-G9DuRlPJdQgv@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 561c80369df0733ba0574882a1635287b20f9de2:

  Merge tag 'tty-6.16-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2025-08-09 18:12:23 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc2-fixes

for you to fetch changes up to 6563623e604e3e235b2cee71190a4972be8f986b:

  docs: cgroup: fixed spelling mistakes in documentation (2025-08-12 10:52:28 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.17-rc2

- Fix NULL de-ref in css_rstat_exit() which could happen after allocation
  failure.

- Fix a cpuset partition handling bug and a couple other misc issues.

- Doc spelling fix.

----------------------------------------------------------------
JP Kobryn (1):
      cgroup: avoid null de-ref in css_rstat_exit()

Soham Metha (1):
      docs: cgroup: fixed spelling mistakes in documentation

Waiman Long (3):
      cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key
      cgroup/cpuset: Fix a partition error with CPU hotplug
      cgroup/cpuset: Remove the unnecessary css_get/put() in cpuset_partition_write()

 Documentation/admin-guide/cgroup-v2.rst |  4 ++--
 kernel/cgroup/cpuset.c                  | 11 +++++------
 kernel/cgroup/rstat.c                   |  3 +++
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
tejun


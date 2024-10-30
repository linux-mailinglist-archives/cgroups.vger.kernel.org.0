Return-Path: <cgroups+bounces-5322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0149B58D2
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 01:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A765284322
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6F1EB56;
	Wed, 30 Oct 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMnT1SV1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18344C70;
	Wed, 30 Oct 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249328; cv=none; b=SiC+dOQyMTjZHSF34oWuc/AMnNjMC+6khQaXBAESqbNSH2EI7u+Dp6Iya7OVEfADEyXzmmCwnhxqgBCR1d0qcp6Zpgr/XTHMX+KNVKu5ajSG/FDKPSA6zklYEOB4oZeIks4nqYAmkJMIuzXKPBcfcRRSq6WsSPa7hpzMtFg4kGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249328; c=relaxed/simple;
	bh=97w9E5ZcD4Tld5FFeLVUkMm+FoGOknYL9VY1icR2+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IErxMllW9AL5KZJbLpIurUD8s698PJxbhqD4n8a8xccjBuB7T3iOfA1LsMxuSeF7aE9sgUjoCoJpuPjhuQAXU+97wj+gMX3RmPu8NsKYi7qBetUtLHCR1S8/91wEjbf7CzOwIJTvA8TDnPUBgMhIc8mo5q3vGjgnsTNQMKY3CHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMnT1SV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4468AC4CECD;
	Wed, 30 Oct 2024 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730249328;
	bh=97w9E5ZcD4Tld5FFeLVUkMm+FoGOknYL9VY1icR2+OU=;
	h=Date:From:To:Cc:Subject:From;
	b=GMnT1SV1C3tVwJG+j3WErsYbxElkeiSuFj0vBPnf/Rps4WHjTbpeqiPHyehXXSIWw
	 zEIXVI6nPqBhNxbo+ka/kbDpJnulq+qazLfuRo3qgA8mevs6xre9bzjS5BjxaSu7Uv
	 hqZCfwZWaUr6AlGuFTGsV9Gad4fpr50D6bmsM1YZ39CPxd8D/brqjzgTWvciq9/rzY
	 5GBO+sTn1XrN8PzhWeA6QAhkhxfgBeujbBCvzcCrnMOTjLSutDRQwYHXT2SSbLBuRp
	 X8L6JUasAn+aRL4LEgFPe70b3UuY9+07Bm2kd98LMTVMvyUo9yHsfoxCnGZrzMra3Q
	 xSHeWqFcyLb0w==
Date: Tue, 29 Oct 2024 14:48:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.12-rc5
Message-ID: <ZyGCb34Fcj3yoVL2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12-rc5-fixes

for you to fetch changes up to 3cc4e13bb1617f6a13e5e6882465984148743cf4:

  cgroup: Fix potential overflow issue when checking max_depth (2024-10-14 13:39:25 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.12-rc5

- cgroup_bpf_release_fn() could saturate system_wq with
  cgrp->bpf.release_work which can then form a circular dependency leading
  to deadlocks. Fix by using a dedicated workqueue. The system_wq's max
  concurrency limit is being increased separately.

- Fix theoretical off-by-one bug when enforcing max cgroup hierarchy depth.

----------------------------------------------------------------
Chen Ridong (1):
      cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

 kernel/bpf/cgroup.c    | 19 ++++++++++++++++++-
 kernel/cgroup/cgroup.c |  4 ++--
 2 files changed, 20 insertions(+), 3 deletions(-)

--
tejun


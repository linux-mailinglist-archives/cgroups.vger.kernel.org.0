Return-Path: <cgroups+bounces-11606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B2C370E4
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D436507926
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BF33A03C;
	Wed,  5 Nov 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYe7RY+t"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2B31353B;
	Wed,  5 Nov 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362448; cv=none; b=Pxi7AAWfaHQVhgRygjTq6NeAnwKejpsHXLK9B+eBS26PcV+AmLd+3Zbpek0ffu+IfCnoVwO//UOFZfQ+VQRxGmnQW5Q0SH5hHJ2TYiPenVdl4mhgdTHnTCbCd5N4wM82NqH6xIAnQrqdtZQnydC8JkDzRVnaZgF/NlQnnJDVDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362448; c=relaxed/simple;
	bh=uvpy1+5IwsPTyPrF41fa8kfdS2ROsOZT51o7Rrkd1x0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Sd/lt7Daq5zrhCmcCxALOEtO08maMf6VSIsblwYeTCgx/7oMePkbcYrZLHWvNjZAwrzLj1VtHHAOFncWrCZemCOKE/HDcnFvjrzXX1F7YXCno7gU48NJvM+Qjzr/pZOCJ1BxZJhDXaJb/FiTa0ZULV9CgWqUD/I4uIfqsnMaG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYe7RY+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC847C4CEF8;
	Wed,  5 Nov 2025 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762362448;
	bh=uvpy1+5IwsPTyPrF41fa8kfdS2ROsOZT51o7Rrkd1x0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYe7RY+tVWdGRnIeg+gwFVXUpQ6o5CluJK3cpv/aSVE+bCjA29bhRCiXL4IDnEDkZ
	 J+hwm86a1ZIRt3QHx7KM5LK7MThK7jGyHeMio8LaxcLkLp5Ay+ZYBqMXxKKkO9LB+4
	 BN9WY6F46oNFhPsCpysQXw0kh6p051VLIkUNTVrEEJAeJ6tF+OXZ7MEhGOD97SulaS
	 7vl84L+Wjs+IXFa2gOj8WxPVTzS9jPa0NCIGuDJdKucoZRRUz4oEJyUV7Zv3yViPmU
	 /IDqFPvPOKKjdx3s7oxt9ZX++Yn+Fzk8xG7xqf+0GTKTp6A0rhFIt6ZPvD5c5VctnO
	 iFTWPNiIWbmWA==
Date: Wed, 05 Nov 2025 07:07:27 -1000
Message-ID: <a8248fa3f61fb85f7088312aefbf2751@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] cgroup/cpuset: Additional housekeeping check & cleanup
In-Reply-To: <20251105043848.382703-1-longman@redhat.com>
References: <20251105043848.382703-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

> Gabriele Monaco (1):
>   cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
>     update_isolation_cpumasks()
>
> Waiman Long (4):
>   cgroup/cpuset: Fail if isolated and nohz_full don't leave any
>     housekeeping
>   cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
>   cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated
>     partition
>   cgroup/cpuset: Globally track isolated_cpus update

Applied 1-5 to cgroup/for-6.19.

Thanks.
--
tejun


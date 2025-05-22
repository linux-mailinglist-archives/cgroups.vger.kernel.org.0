Return-Path: <cgroups+bounces-8318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDEAC14B4
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2FF4A1F3A
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D029DB79;
	Thu, 22 May 2025 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCgsPc0j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3E288C05;
	Thu, 22 May 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941413; cv=none; b=q4L+ntFAVvjyoqrTLAStmLzDc+PYjc226amdFKNXUdV1dK5tWU89G7qbTNzY9ff/AlFdIZ1uvHNplhN82H2nJ4B36L0w7Y5KsYZgn8WjEz9m1bZk7b5gv5TVnfPkZcjLxlDPbF9l4PBzfI9w+Y3vfvybFD0+95CaarEQg4BgdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941413; c=relaxed/simple;
	bh=KYyoSn6EliVEmcth8pocugMaIbIn2wzs+N1VExO/owo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE592L/H9HNApVpwNoQvSTnCdYrcyv+CgRfc7vmzY3VxkHZa1ZMy9dAszVdRYJXAaCM30REIoyjcaKSyKWUlUDGkqRH12uXTVLMwe0hgUuX1oD9aEiuCcQbcPRCKAG3q6LDmW0xLMChwgUiB0BfHC7yPeOck1ho3u7ghypcZ72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCgsPc0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD6AC4CEE4;
	Thu, 22 May 2025 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747941412;
	bh=KYyoSn6EliVEmcth8pocugMaIbIn2wzs+N1VExO/owo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCgsPc0jFGxFUz6bikpDUcCpgmPnac5gvPGSjyMjRcwVbuQ90iV7+fPzbXvpJbRhT
	 mM3CgSHX/uj+kfbzDD3sykjTlZhHSI+wBKh+V4Pi9fyygzYAEZFCFeS+hin6LOtveV
	 NVAoPI7xGkKWucELyg+t5sF3M47fkEoMh1LDKF+LxfBAsr4sQaLBGGg78gkRPvdPiJ
	 qT78a0NhEdS396go9IbcC2t02NDZ1WVQ+wQNx8Xyq7pho3lX48d87WLSY0lX8P2+wL
	 NJaSFJbo9Xkn3zROLmjMPGBqw11ss0NW0ffCn7Qa7pGFJjJqoXfB1ftuqeqbzgYRJi
	 JtnvwcisbNEyQ==
Date: Thu, 22 May 2025 09:16:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 3/3 cgroup/for-6.16] sched_ext: Convert cgroup BPF
 support to use cgroup_lifetime_notifier
Message-ID: <aC94Hfcc6FJ_XXik@slm.duckdns.org>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
 <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
 <aCQgFIxz82oxLf8v@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCQgFIxz82oxLf8v@mtj.duckdns.org>

On Wed, May 14, 2025 at 12:46:12AM -0400, Tejun Heo wrote:
> Replace explicit cgroup_bpf_inherit/offline() calls from cgroup
> creation/destruction paths with notification callback registered on
> cgroup_lifetime_notifier.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied 1-3 to cgroup/for-6.16.

Thanks.

-- 
tejun


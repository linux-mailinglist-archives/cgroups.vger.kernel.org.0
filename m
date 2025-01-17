Return-Path: <cgroups+bounces-6223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40EA153BC
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593A17A0FDB
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC54198822;
	Fri, 17 Jan 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnENOBfY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1C13CA81;
	Fri, 17 Jan 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130102; cv=none; b=J/gMpbEHPxWvrJ5rt42PR8snTfRNHLt/wPYGmOpegx2V8T51q/jb9tSvhFQPCjtA1mtvg6kiabOMnSFUK/RflNtJkg3XpNkPjthDIqR79ysRSoiEeBdFUIMi4iCcwdyzR27BQq+YS67rHZA8t2AsKVM+8eik60AOzIlCXQD8mvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130102; c=relaxed/simple;
	bh=Go1ltsOcEukGy1CqFu0g48zoWQi/OK+17d70mDcWPws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmvOl0J0LPGfRGhGiXXez+A/hVP8oPwsj1+Z0gtFe0uhXrY5LOB2rERy9HnDOt9LqMUCF5wVgRnLFz30LrT4sKSDvf+uoxI9iU+W4AwYJsS+xg2/YYM+unxiSkC+kU1stxHm8YkamxfDvlDYu6oLs3EL63f09dUoPgGydguxuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnENOBfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76442C4CEDD;
	Fri, 17 Jan 2025 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737130101;
	bh=Go1ltsOcEukGy1CqFu0g48zoWQi/OK+17d70mDcWPws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnENOBfY2Eos5PEMkFmNzM1XcNRnBCM8fDqGP2XI25dMapvobsw60dnpDxAStXOXb
	 X39/DZX3R0g/Ojr1bX0VhydOZct/agOcEIf8d2sFFZwxyA9Q/igY4nE44rG4pMmb68
	 V048zTinRgjeZumqBiE4yeng4EefMXRiSE13gENRD2EKqTwsI+3rAg7uK4y2PEhdia
	 az7V/Jt5y8yZzRk6T39hODUrjKeHHZHwhoFxTTTAXq9DATK74x24x3eaycEHriz6Mo
	 XyMnVgWllOBX6+Bzv4x4Ryk901G0Rp+RNV+tuNAvVoB5tT7TrQwJ8105j1B/kLo2AJ
	 MZzV6o/UXJfaA==
Date: Fri, 17 Jan 2025 06:08:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <Z4qAdJ9g7E5SyLDJ@slm.duckdns.org>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
 <Z4lA702nBSWNFQYm@slm.duckdns.org>
 <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>
 <Z4lgLxZXjoKuMh3r@slm.duckdns.org>
 <7ft2u3u5kniyb6s7tcajsntvmn7kbico7yjclgamjlr5rgqvwk@vzfqbcivt77i>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ft2u3u5kniyb6s7tcajsntvmn7kbico7yjclgamjlr5rgqvwk@vzfqbcivt77i>

On Fri, Jan 17, 2025 at 11:44:36AM +0100, Michal Koutný wrote:
> The cpuset file is a legacy attribute that is bound primarily to cpuset
> v1 hierarchy (equivalent information is available in /proc/$pid/cgroup path
> on the unified hierarchy in conjunction with respective
> cgroup.controllers showing where cpuset controller is enabled).
> 
> Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
> cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
> Drop an obsolete comment too.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.14.

Thanks.

-- 
tejun


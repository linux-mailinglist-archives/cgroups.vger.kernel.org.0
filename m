Return-Path: <cgroups+bounces-8426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32923ACCCB3
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5683D7A4EBE
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D60284B59;
	Tue,  3 Jun 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM7COI6v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3881284B33;
	Tue,  3 Jun 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974536; cv=none; b=OFwOHWImEfwnCM7MvoOaAm1jYfO3cwC8pge2npjELXdXbsxaBwBdIoAwowUuWGjUHOv+I9eHJKXJInw70t9lA9Vu4G34j+CmMwP6HVkOS98BnZAjnuEtNq0flwgSiU00TfY8jX4bUkVbbmqSfSgOPEBwgZZ3WYu/p5GRmwNlrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974536; c=relaxed/simple;
	bh=oS0oU3PHGXcrufSiI1cSmPk3kZhUyal3rJUuQNhMDbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbHsaJ7vtZt2gbXllmEF5XBe1wKfhQ4UaW05F0u7wi5irBEGLGG0tBT7yk4mAiVicCDpQGPxF4t2P69p7F3Nd7iomzq4dt6yGk5ofH65kQeKK63cSIiN5SSy0NeTECVpeo4FaT5s57CzjNyAIb+7klqF4Ivl+X89WlhLx32VnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM7COI6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B74AC4CEEF;
	Tue,  3 Jun 2025 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748974535;
	bh=oS0oU3PHGXcrufSiI1cSmPk3kZhUyal3rJUuQNhMDbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PM7COI6vkiKUagz3nGTHM3WehM5bnPJzipFTd6J/aYw63XAnA6bthdf/4dn+Gm7RC
	 9Et6kvNy7nEyzoBELS/1+s/40SXQ29NsgYmHUsNlCWbuyTmq73iT52Mttkzx0OXbVk
	 EFYvbl8aLYdTy/6lvnRTC3s0aslykfkJtk3sjH3aRul0cm8jHUDmBENFGRAdFfsLu+
	 Db/JIA6aJYMOv4nwdHzwdkYP5J8vHRsroWA5Um/U/QRJewUv8Td+e7qO+B88Xfvxvr
	 WrhsibB4vv17gQogckTlhhmIPlb3A/iVqjXWxep10VfCOTtuPEqQ7574t4CubQt8R0
	 nL90N/YtOM5nQ==
Date: Tue, 3 Jun 2025 08:15:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] cgroup: Drop sock_cgroup_classid() dummy implementation
Message-ID: <aD87xm9H_wiQK_S2@slm.duckdns.org>
References: <20250603154528.807949-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603154528.807949-1-mkoutny@suse.com>

On Tue, Jun 03, 2025 at 05:45:27PM +0200, Michal Koutný wrote:
> The semantic of returning 0 is unclear when !CONFIG_CGROUP_NET_CLASSID.
> Since there are no callers of sock_cgroup_classid() with that config
> anymore we can undefine the helper at all and enforce all (future)
> callers to handle cases when !CONFIG_CGROUP_NET_CLASSID.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Link: https://lore.kernel.org/r/Z_52r_v9-3JUzDT7@calendula/
> Acked-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-6.16-fixes.

Thanks.

-- 
tejun


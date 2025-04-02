Return-Path: <cgroups+bounces-7290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D83A7890A
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 09:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B66F7A519C
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F0123371E;
	Wed,  2 Apr 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnW1H/iB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB862AE77;
	Wed,  2 Apr 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579840; cv=none; b=bYHsTXKnTcRMeGE54Tk+hY0bFVVG5wuPCzko9WwCMmQapZAbA4h+W8IChpFJXKF/EaD4i8wcQOtgrh0atU7te9+F0KiTw8V3eqyzFYBHKJetjk85wPy3LyUUw/kSP89BOj/XmX9Lao9S9PfUSrLU4v1QcLA19S8VkfyvkHrqvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579840; c=relaxed/simple;
	bh=79oZiKPNcgeMH72JXqZK4G1DEIB8nqM9lhZHMO4iaUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU+ExI6YH5iLMpvn2dDleGW65idYv2oBAwQKEBhSKRbD3RKmIt45jLThUtNqGzRf3xHjKuwt2ICI4GNA5Rb+VRQyLxiS6ALomUO2oSjaHE7JDm5CMAA3FZNF9hAaUr+k3faMiYt1FHNCs2Q+DD7fKPuUrO9GlZ7w247ySV4Gnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnW1H/iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF3C4CEDD;
	Wed,  2 Apr 2025 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743579840;
	bh=79oZiKPNcgeMH72JXqZK4G1DEIB8nqM9lhZHMO4iaUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnW1H/iB0Hl7hNtigJ75OD+j3Xz+zrqKHzuL7tBeHRcXVLhoMPnhtjRN9Dsp6sbPX
	 lQAeQReK5jaYPP4IHdjJXx5vfM/qDLhL71bGFeRdH1NsyKXVOPNH5HiKtDARmXw17I
	 9Wq3jxfaxoHOvhR8Ts9QKMriSTd6GHEcDLbU7DCVJT4faIarC/dHr9peN8yZR8M2wk
	 +2IXKb56uRmJJa1nk8Vv6KYxknQzAjyUDhKqHO0JB8BjhPVnYikegBcD8+ljpAMyvl
	 VUozsVJ2PuTRPq+2mAc8CfVghRcw4Vgk/fLIRj0MJbX0EZ8xBLJajIwV5y9AnujM5R
	 fYRJ2OAzZcW/Q==
Date: Tue, 1 Apr 2025 21:43:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: netfilter-devel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <Z-zqvmJFI3PkNl6R@slm.duckdns.org>
References: <20250401115736.1046942-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401115736.1046942-1-mkoutny@suse.com>

On Tue, Apr 01, 2025 at 01:57:29PM +0200, Michal Koutný wrote:
> Changes from v2 (https://lore.kernel.org/r/20250305170935.80558-1-mkoutny@suse.com):
> - don't accept zero classid neither (Pablo N. A.)
> - eliminate code that might rely on comparison against zero with
>   !CONFIG_CGROUP_NET_CLASSID
> 
> Michal Koutný (3):
>   netfilter: Make xt_cgroup independent from net_cls
>   cgroup: Guard users of sock_cgroup_classid()
>   cgroup: Drop sock_cgroup_classid() dummy implementation

From cgroup POV:

  Acked-by: Tejun Heo <tj@kernel.org>

Once folks are happy, please let me know how the patches should be routed.

Thanks.

-- 
tejun


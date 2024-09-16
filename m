Return-Path: <cgroups+bounces-4898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CD97A55E
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E5E1F270F6
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29115958E;
	Mon, 16 Sep 2024 15:33:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4715749A;
	Mon, 16 Sep 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500822; cv=none; b=pPqyb5SNM2zuSmLyRJgcPfyGaUZ3J0wpvHwGNQTBWi0uqjGYI0K6kV8RNY1PmHTda1gAzPL4rfRVcti4ZRIHEK57DMbswq8vdOeltTzAHxcg/EgcmwgI/uaP7lHEWLuWLczDzvp+cbXjJz5c5XHYI72MLDFK/8263AOehjq14EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500822; c=relaxed/simple;
	bh=un/i0gViPPSEFoEji7kwMkqEV659V7f5pGJSsTREtm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBHRqj3wAC5TvFZ9X/yOWfFVWq/onGkB4HeVzMa5eCix5hAkSx69Z+DED6fsAwJvxBFs703m0iBdoZj9S9Y/AvfiBOoCA6Ov064VjIE1QWU063MKtuWXxn2olguOPCSIfLYv/n8FMvkI6b97GXUyqaajV1DkAPB9fFQ24cFOinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=38220 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sqDjJ-00FzvZ-RV; Mon, 16 Sep 2024 17:33:35 +0200
Date: Mon, 16 Sep 2024 17:33:33 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	cgroups@vger.kernel.org, Nadia Pinaeva <n.m.pinaeva@gmail.com>,
	Florian Westphal <fw@strlen.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 092/121] netfilter: nft_socket: make cgroupsv2
 matching work with namespaces
Message-ID: <ZuhPzTZxBLBU6Vx5@calendula>
References: <20240916114228.914815055@linuxfoundation.org>
 <20240916114232.178821333@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916114232.178821333@linuxfoundation.org>
X-Spam-Score: -1.9 (-)

Hi Greg,

This needs a follow up incremental fix. Please, hold on with it.

I will ping you back once it is there.

Thanks

On Mon, Sep 16, 2024 at 01:44:26PM +0200, Greg Kroah-Hartman wrote:
> 6.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Florian Westphal <fw@strlen.de>
> 
> [ Upstream commit 7f3287db654395f9c5ddd246325ff7889f550286 ]
> 
> When running in container environmment, /sys/fs/cgroup/ might not be
> the real root node of the sk-attached cgroup.
> 
> Example:
> 
> In container:
> % stat /sys//fs/cgroup/
> Device: 0,21    Inode: 2214  ..
> % stat /sys/fs/cgroup/foo
> Device: 0,21    Inode: 2264  ..
> 
> The expectation would be for:
> 
>   nft add rule .. socket cgroupv2 level 1 "foo" counter
> 
> to match traffic from a process that got added to "foo" via
> "echo $pid > /sys/fs/cgroup/foo/cgroup.procs".
> 
> However, 'level 3' is needed to make this work.
> 
> Seen from initial namespace, the complete hierarchy is:
> 
> % stat /sys/fs/cgroup/system.slice/docker-.../foo
>   Device: 0,21    Inode: 2264 ..
> 
> i.e. hierarchy is
> 0    1               2              3
> / -> system.slice -> docker-1... -> foo
> 
> ... but the container doesn't know that its "/" is the "docker-1.."
> cgroup.  Current code will retrieve the 'system.slice' cgroup node
> and store its kn->id in the destination register, so compare with
> 2264 ("foo" cgroup id) will not match.
> 
> Fetch "/" cgroup from ->init() and add its level to the level we try to
> extract.  cgroup root-level is 0 for the init-namespace or the level
> of the ancestor that is exposed as the cgroup root inside the container.
> 
> In the above case, cgrp->level of "/" resolved in the container is 2
> (docker-1...scope/) and request for 'level 1' will get adjusted
> to fetch the actual level (3).
> 
> v2: use CONFIG_SOCK_CGROUP_DATA, eval function depends on it.
>     (kernel test robot)
> 
> Cc: cgroups@vger.kernel.org
> Fixes: e0bb96db96f8 ("netfilter: nft_socket: add support for cgroupsv2")
> Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/netfilter/nft_socket.c | 41 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
> index 765ffd6e06bc..12cdff640492 100644
> --- a/net/netfilter/nft_socket.c
> +++ b/net/netfilter/nft_socket.c
> @@ -9,7 +9,8 @@
>  
>  struct nft_socket {
>  	enum nft_socket_keys		key:8;
> -	u8				level;
> +	u8				level;		/* cgroupv2 level to extract */
> +	u8				level_user;	/* cgroupv2 level provided by userspace */
>  	u8				len;
>  	union {
>  		u8			dreg;
> @@ -53,6 +54,28 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
>  	memcpy(dest, &cgid, sizeof(u64));
>  	return true;
>  }
> +
> +/* process context only, uses current->nsproxy. */
> +static noinline int nft_socket_cgroup_subtree_level(void)
> +{
> +	struct cgroup *cgrp = cgroup_get_from_path("/");
> +	int level;
> +
> +	if (!cgrp)
> +		return -ENOENT;
> +
> +	level = cgrp->level;
> +
> +	cgroup_put(cgrp);
> +
> +	if (WARN_ON_ONCE(level > 255))
> +		return -ERANGE;
> +
> +	if (WARN_ON_ONCE(level < 0))
> +		return -EINVAL;
> +
> +	return level;
> +}
>  #endif
>  
>  static struct sock *nft_socket_do_lookup(const struct nft_pktinfo *pkt)
> @@ -174,9 +197,10 @@ static int nft_socket_init(const struct nft_ctx *ctx,
>  	case NFT_SOCKET_MARK:
>  		len = sizeof(u32);
>  		break;
> -#ifdef CONFIG_CGROUPS
> +#ifdef CONFIG_SOCK_CGROUP_DATA
>  	case NFT_SOCKET_CGROUPV2: {
>  		unsigned int level;
> +		int err;
>  
>  		if (!tb[NFTA_SOCKET_LEVEL])
>  			return -EINVAL;
> @@ -185,6 +209,17 @@ static int nft_socket_init(const struct nft_ctx *ctx,
>  		if (level > 255)
>  			return -EOPNOTSUPP;
>  
> +		err = nft_socket_cgroup_subtree_level();
> +		if (err < 0)
> +			return err;
> +
> +		priv->level_user = level;
> +
> +		level += err;
> +		/* Implies a giant cgroup tree */
> +		if (WARN_ON_ONCE(level > 255))
> +			return -EOPNOTSUPP;
> +
>  		priv->level = level;
>  		len = sizeof(u64);
>  		break;
> @@ -209,7 +244,7 @@ static int nft_socket_dump(struct sk_buff *skb,
>  	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
>  		return -1;
>  	if (priv->key == NFT_SOCKET_CGROUPV2 &&
> -	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
> +	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level_user)))
>  		return -1;
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 
> 


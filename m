Return-Path: <cgroups+bounces-4741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1896FC44
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC931F29029
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0F1D45EA;
	Fri,  6 Sep 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZRqK3dx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2414B956;
	Fri,  6 Sep 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651597; cv=none; b=E9/ukujxGBHJr+4XhopFfi3nSBCCm1l3GKxHJkbiH3fmy9/pHtde2oLwoD6vDyPA19c8kxTQPwbCffS9CSrOeNTODaMlCThfcioGz4QeTLdcUSKp6gLAbnNNo029BZEu+O0uyuot9TV7N5Nra9QAVAC7pE+/rZ6yuu2x0hRi160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651597; c=relaxed/simple;
	bh=FForPeY29LWUkliV8Eg5m537GYP5ZUgBZsfL0V4472A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pctW2e0GZD+OeYfapEPXVGQaI82/ySazYtuxLdM+dZHSapqJAb0ddO3o952F3Cgpm89fLlHN09amfz4pVQHZifTyUOd/Pon11vzOYGVOtN8KXJ0XDpq3FsguqWlUgNj5IfmFUYSHQ3eqnhtaS4MthJKcm/KEzNvdfYfGMqaOL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZRqK3dx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725651595; x=1757187595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FForPeY29LWUkliV8Eg5m537GYP5ZUgBZsfL0V4472A=;
  b=YZRqK3dxgQisWHobsBLpdmhQjYXL77Z4DqU9XLhbXM+5cYKTR0IqvkpE
   vWVyAnIbURH8qBlGtOmjnpEREctkBOJLf5wnoFRVXlHEA4s5Oe2m4u7Yk
   RIpwiX6wOu4llJ7kyl3p0v64PgZ1gp7X5HpBttMoVFkCwpKh6UyFbnx4V
   VszVph0IuZVtBOjMhLLxhb8UqbGCojhvHMjxM7IrMWA75eCAJjArmr/9e
   KQ2rLwTMgdZz50w0secgeH9wU3o/uTrSe++glcaTMLmrA9SSVnxZ6u59/
   0DK4YenODXoMhg2eSTJtmEzvzVRZTO4iV3726IdV83Jbc/euM8iLOdyXO
   A==;
X-CSE-ConnectionGUID: g6UWTDZxRd+3EOzmafdcXQ==
X-CSE-MsgGUID: vGdey4wUTt+nixQ6dolbmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="28208292"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="28208292"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 12:39:54 -0700
X-CSE-ConnectionGUID: oQ48nklUTyS1ftwghR/WXg==
X-CSE-MsgGUID: 007zZK/2TEeQR156VEbHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66076663"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Sep 2024 12:39:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smeo9-000BeH-35;
	Fri, 06 Sep 2024 19:39:49 +0000
Date: Sat, 7 Sep 2024 03:39:32 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Florian Westphal <fw@strlen.de>,
	cgroups@vger.kernel.org, Nadia Pinaeva <n.m.pinaeva@gmail.com>
Subject: Re: [PATCH nf 2/2] netfilter: nft_socket: make cgroupsv2 matching
 work with namespaces
Message-ID: <202409070305.pBDk8EVS-lkp@intel.com>
References: <20240905105451.28857-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905105451.28857-2-fw@strlen.de>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/netfilter-nft_socket-make-cgroupsv2-matching-work-with-namespaces/20240905-185930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20240905105451.28857-2-fw%40strlen.de
patch subject: [PATCH nf 2/2] netfilter: nft_socket: make cgroupsv2 matching work with namespaces
config: arm-randconfig-002-20240907 (https://download.01.org/0day-ci/archive/20240907/202409070305.pBDk8EVS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070305.pBDk8EVS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070305.pBDk8EVS-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/netfilter/nft_socket.c: In function 'nft_socket_init':
>> net/netfilter/nft_socket.c:212:23: error: implicit declaration of function 'nft_socket_cgroup_subtree_level' [-Wimplicit-function-declaration]
     212 |                 err = nft_socket_cgroup_subtree_level();
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/nft_socket_cgroup_subtree_level +212 net/netfilter/nft_socket.c

   169	
   170	static int nft_socket_init(const struct nft_ctx *ctx,
   171				   const struct nft_expr *expr,
   172				   const struct nlattr * const tb[])
   173	{
   174		struct nft_socket *priv = nft_expr_priv(expr);
   175		unsigned int len;
   176	
   177		if (!tb[NFTA_SOCKET_DREG] || !tb[NFTA_SOCKET_KEY])
   178			return -EINVAL;
   179	
   180		switch(ctx->family) {
   181		case NFPROTO_IPV4:
   182	#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
   183		case NFPROTO_IPV6:
   184	#endif
   185		case NFPROTO_INET:
   186			break;
   187		default:
   188			return -EOPNOTSUPP;
   189		}
   190	
   191		priv->key = ntohl(nla_get_be32(tb[NFTA_SOCKET_KEY]));
   192		switch(priv->key) {
   193		case NFT_SOCKET_TRANSPARENT:
   194		case NFT_SOCKET_WILDCARD:
   195			len = sizeof(u8);
   196			break;
   197		case NFT_SOCKET_MARK:
   198			len = sizeof(u32);
   199			break;
   200	#ifdef CONFIG_CGROUPS
   201		case NFT_SOCKET_CGROUPV2: {
   202			unsigned int level;
   203			int err;
   204	
   205			if (!tb[NFTA_SOCKET_LEVEL])
   206				return -EINVAL;
   207	
   208			level = ntohl(nla_get_be32(tb[NFTA_SOCKET_LEVEL]));
   209			if (level > 255)
   210				return -EOPNOTSUPP;
   211	
 > 212			err = nft_socket_cgroup_subtree_level();
   213			if (err < 0)
   214				return err;
   215	
   216			priv->level_user = level;
   217	
   218			level += err;
   219			/* Implies a giant cgroup tree */
   220			if (WARN_ON_ONCE(level > 255))
   221				return -EOPNOTSUPP;
   222	
   223			priv->level = level;
   224			len = sizeof(u64);
   225			break;
   226		}
   227	#endif
   228		default:
   229			return -EOPNOTSUPP;
   230		}
   231	
   232		priv->len = len;
   233		return nft_parse_register_store(ctx, tb[NFTA_SOCKET_DREG], &priv->dreg,
   234						NULL, NFT_DATA_VALUE, len);
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


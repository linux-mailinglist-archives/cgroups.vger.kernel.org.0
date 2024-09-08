Return-Path: <cgroups+bounces-4748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2469708DC
	for <lists+cgroups@lfdr.de>; Sun,  8 Sep 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F141F215E5
	for <lists+cgroups@lfdr.de>; Sun,  8 Sep 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AA175570;
	Sun,  8 Sep 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsGFvEAy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA585132111;
	Sun,  8 Sep 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725815251; cv=none; b=eo05aX/4SZKAqmFC2EKBGhyaSqnY5A0Js+lQ6BQOUnfVQZy5tsUBqp7dX9zN2UGyuoq0eQUPVajibFTORrV2kWDhtCo+Sv+GihhdNELpX9eM+weFLq/fyjE5i2gFVkxaGuw1ycLOiooMrFQPgNMP3zsXl+ko86VBkThVaXBqMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725815251; c=relaxed/simple;
	bh=P2/0U6lW5ks2HD0ZSmhZupVFrPU9sUMaH9Nid6z7tdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB1EViR7kVAIBU5aYZudMDLBZh8brXVG7V0Xl1D48g47KUHbXxa7gjcyev7Dk5EyEYH/zIiA6sgqK718TT8y0r+Ffpbo74QaL+mCgk4j6ywn4brASHn9l+2x/xOzTWqDzatv4EER45jADc68sZdTuzp89ZTXTmoseVOlEwEbqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsGFvEAy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725815249; x=1757351249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2/0U6lW5ks2HD0ZSmhZupVFrPU9sUMaH9Nid6z7tdw=;
  b=MsGFvEAyAuY1CV3U6HTfdv3yVYPSP1r50YayOnzGIbSVOh1CQ3ODWvpM
   qO+mgzhHJuME1br5/sgC46XymZjE43Cr/PTyD7eqs5rAP+uyt4JbWzpEc
   MnOi+sS4s2C4zoed/WsMWgu8RvIyW6xVqSy8fk6F/mtOGWB6G7ShmUdXq
   GwuFX3UMawNDA6I91n+wfmRLv2R7OsFhACQP51j6RifKULSU9E+jYt8Xt
   TQ7bWMUh5xiJ41W/JiFJMfc5LVgzmXv4RKEBP4qot7DrNsyQTeJFrsxyl
   ++dyKQAiZXXuO2hIQuf4wHvhQ6zJe/KhhRirAc/T7edJ/oSA3dHTzf0/x
   w==;
X-CSE-ConnectionGUID: mHtItamdSyGKPK+f8e0lPQ==
X-CSE-MsgGUID: 8U3B1Ru4TPSzLd7oxJrmXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="47028567"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="47028567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 10:07:28 -0700
X-CSE-ConnectionGUID: iZ83Dsn3QYS6/GzGz2KYGw==
X-CSE-MsgGUID: Ta/qcRvVSWmtx+Bm2/kzRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="66478878"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Sep 2024 10:07:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snLNk-000Dkl-0t;
	Sun, 08 Sep 2024 17:07:24 +0000
Date: Mon, 9 Sep 2024 01:06:48 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Florian Westphal <fw@strlen.de>, cgroups@vger.kernel.org,
	Nadia Pinaeva <n.m.pinaeva@gmail.com>
Subject: Re: [PATCH nf 2/2] netfilter: nft_socket: make cgroupsv2 matching
 work with namespaces
Message-ID: <202409090022.jxFbbVYj-lkp@intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/netfilter-nft_socket-make-cgroupsv2-matching-work-with-namespaces/20240908-025647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20240905105451.28857-2-fw%40strlen.de
patch subject: [PATCH nf 2/2] netfilter: nft_socket: make cgroupsv2 matching work with namespaces
config: i386-randconfig-006-20240908 (https://download.01.org/0day-ci/archive/20240909/202409090022.jxFbbVYj-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240909/202409090022.jxFbbVYj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409090022.jxFbbVYj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/netfilter/nft_socket.c:212:9: error: call to undeclared function 'nft_socket_cgroup_subtree_level'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     212 |                 err = nft_socket_cgroup_subtree_level();
         |                       ^
   1 error generated.


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


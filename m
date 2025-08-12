Return-Path: <cgroups+bounces-9093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC7B22B6F
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB43117F54B
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C772DC34B;
	Tue, 12 Aug 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6a/LmrW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFB2F4A11;
	Tue, 12 Aug 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011365; cv=none; b=HegIEg02tGTAKyHuQTVmAOR5xMcRFofrzIzaNUvD3o0NcAIp8shlAD+N+DHEGXH5iYrUrj7/2zmbWT8BF4vCXQIqxsUjDf21Xt0G9IYkgSuu4VKFZAM+Z0yRpzaY7htiFH8qKbvOluouHMrdBK8gi7QHLb4UeyspvY58YYMAnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011365; c=relaxed/simple;
	bh=x9Q2uf+Vcwv+UGHML2zmP1ZdgpCoiBIGCjX2Ui0X2/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYukIzFijhVAWBARPxpmXNSyb6Gk+x/Bnpri8Z1bAVpLsnKmPI9chNiOyOlN+RPth/L3GRbEtWF8MpB8pbQkAu72uWzKTxFVxwKRQI/19S+YaEWklicU6zLT61CeBf7c2WI4l38BKtf7UthpgzLAzQdKwXHlo6wRQQemw37AyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6a/LmrW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755011365; x=1786547365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9Q2uf+Vcwv+UGHML2zmP1ZdgpCoiBIGCjX2Ui0X2/w=;
  b=j6a/LmrWXBgLv9urS0KH+sV/1qT9dJNRQ4XJwZi4mK2bHLyfkIX2LOcs
   rrbfXSkqQnlL/b3ypICQhjK1BZ1spUJKl3B35+fFdJsbJWNDFIZoz2K7g
   tpe8ttIwrGjt9jiFpdhv23p9pw7myEYIxyNeRIc5MKD4d+PyckCJuFfNJ
   QsK4HQvntmV7cTg6yELqVXygIYRjl4Xzs+ASck6g4KU00AsEYUHFqEVcz
   zl/VCloSgL5EIP4YHKu1hUAhxcgWfKCCdyazOuEZGrIDvSaTP5OYLDDvC
   bSxAgKur6W3p9gVlCnHFAyJHEDMdJXqqzEYuia4Fqkr5dakSHfE3ToDAF
   w==;
X-CSE-ConnectionGUID: 2U4JtG6zR8CjAjk1RErYHQ==
X-CSE-MsgGUID: BmnwoLDrS5KjteNfg6aphg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67554585"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67554585"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 08:09:24 -0700
X-CSE-ConnectionGUID: rS845/2TQf+XLHduchzOWQ==
X-CSE-MsgGUID: c+qvQ3xoQPqHerCxvYIYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165444512"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 12 Aug 2025 08:09:18 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulqcl-0006v9-2T;
	Tue, 12 Aug 2025 15:09:15 +0000
Date: Tue, 12 Aug 2025 23:08:38 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, mptcp@lists.linux.dev,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <202508122213.H31XXZsm-lkp@intel.com>
References: <20250811173116.2829786-13-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811173116.2829786-13-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/mptcp-Fix-up-subflow-s-memcg-when-CONFIG_SOCK_CGROUP_DATA-n/20250812-013522
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250811173116.2829786-13-kuniyu%40google.com
patch subject: [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg from global protocol memory accounting.
config: csky-randconfig-002-20250812 (https://download.01.org/0day-ci/archive/20250812/202508122213.H31XXZsm-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508122213.H31XXZsm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508122213.H31XXZsm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cleanup.h:5,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg.h:15,
                    from arch/csky/include/asm/cmpxchg.h:162,
                    from include/asm-generic/atomic.h:12,
                    from arch/csky/include/asm/atomic.h:199,
                    from include/linux/atomic.h:7,
                    from include/crypto/aead.h:11,
                    from net/tls/tls_device.c:32:
   net/tls/tls_device.c: In function 'tls_do_allocation':
>> net/tls/tls_device.c:374:8: error: implicit declaration of function 'sk_should_enter_memory_pressure'; did you mean 'tcp_enter_memory_pressure'? [-Werror=implicit-function-declaration]
     374 |    if (sk_should_enter_memory_pressure(sk))
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/tls/tls_device.c:374:4: note: in expansion of macro 'if'
     374 |    if (sk_should_enter_memory_pressure(sk))
         |    ^~
   cc1: some warnings being treated as errors


vim +374 net/tls/tls_device.c

   363	
   364	static int tls_do_allocation(struct sock *sk,
   365				     struct tls_offload_context_tx *offload_ctx,
   366				     struct page_frag *pfrag,
   367				     size_t prepend_size)
   368	{
   369		int ret;
   370	
   371		if (!offload_ctx->open_record) {
   372			if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
   373							   sk->sk_allocation))) {
 > 374				if (sk_should_enter_memory_pressure(sk))
   375					READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
   376				sk_stream_moderate_sndbuf(sk);
   377				return -ENOMEM;
   378			}
   379	
   380			ret = tls_create_new_record(offload_ctx, pfrag, prepend_size);
   381			if (ret)
   382				return ret;
   383	
   384			if (pfrag->size > pfrag->offset)
   385				return 0;
   386		}
   387	
   388		if (!sk_page_frag_refill(sk, pfrag))
   389			return -ENOMEM;
   390	
   391		return 0;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


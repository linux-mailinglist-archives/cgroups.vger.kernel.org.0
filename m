Return-Path: <cgroups+bounces-7216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B9A6CE83
	for <lists+cgroups@lfdr.de>; Sun, 23 Mar 2025 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880EB16B862
	for <lists+cgroups@lfdr.de>; Sun, 23 Mar 2025 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3B202C5D;
	Sun, 23 Mar 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="XjYX/WC8";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="HqsZhSro"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFD800;
	Sun, 23 Mar 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742721624; cv=none; b=Mm0exvv8fiKmgx6U6BGooHDt+7bjh0NhtLHNoOIpc8ymwC1UdtvS3tvAvozkGEdKm5glAOLDf/aii0o2DmplPaM7mQg2EK4KKfMudgHKKsPaTkLNhUiaaCv7kJgqQv0Pu3LYpAu6n1Up8V8MdJaaaVz6es6hCkNnc2EHHfsmEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742721624; c=relaxed/simple;
	bh=fTHfjM3YpFDVqr7eOMrB75AxCidt7NZyJSHi+kvPL70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDsEAw0eHWly3I+Jr5fT40UnK6gLSQo0WnNYO8Y8aDnF8LiTpCMBgul7BFmpD/OTcrlumfxHBo0A+g8thwe0t8xBa/TFpDzaWkZkUOWiC7mz9dHq8BEiwRu4LVEz9+XCT2D+WqtDIVA8Gb22vKVz1n0N4n1NCOJ1BMrslqd4Mw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=XjYX/WC8; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=HqsZhSro; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 841CD60385; Sun, 23 Mar 2025 10:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742721616;
	bh=aTpgttncmN+s4PvDh7qBtNfVTcRVZaa7iHnpbbQkRlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjYX/WC8l32MrMVxruedzOhZ/DIXDX3voFcc2xNPD1UO6e4CPULJosbQMmwrECFqV
	 Mt/ibWQgiHsK7xBmRZbwJt9QLgvxX60whvG6vlEkAyiz0+nMl9ffk8pdcOJL8KPuwL
	 Z6R4kJghBbV9DSSANBHkwTlJKwNSa2g8LuOLMQxRv6alzTjzhRfka7aFOER/8mnSpR
	 1U5za26uEjcXLdtHyM4/YFa76FynIhNguGxBYApob2KvKFdozx/QLbQL5/JlBXQubi
	 IDqejQm5MUsgbuiTFVWaashvLQhxEtFuh2iSqr7pziiShvcZ0Oxrrb6pfA8cLpxhZQ
	 gDUhR/eQCHa3A==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E0A056036E;
	Sun, 23 Mar 2025 10:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742721613;
	bh=aTpgttncmN+s4PvDh7qBtNfVTcRVZaa7iHnpbbQkRlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqsZhSroZwXlEEDEN8V63qBqxl6tsE9zuyjMob3B9TwVWcxtozH2fNV1WpltukNzy
	 H5J9TIg2e1o+q6x9duSphIh1FFinGv7CQ6FRFJXJnFM0cKeEF1tU4Px8953WXs1Xqa
	 eQFhBIu54GzrF9UGCuDEUnxDT8ar4jMHZ0rNfalXcm8xemLCqLdHZ66TJB+vvePhqR
	 oXvtSe2DmgpO32APscNPacWifxO7y6nEWc+G36kWmIpMI2wcq2kE8s3uxA+qDG1FKc
	 dbnxA14sfVaUXpK3gVSFjh9nnt/CX+/msSNR4VABcXPCtm1Z91RfTnprZ3sGmQGB54
	 lPS1sLFyB3X+Q==
Date: Sun, 23 Mar 2025 10:20:10 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org,
	Jan Engelhardt <ej@inai.de>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <Z9_SSuPu2TXeN2TD@calendula>
References: <20250305170935.80558-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305170935.80558-1-mkoutny@suse.com>

Hi Michal,

I have one question.

On Wed, Mar 05, 2025 at 06:09:35PM +0100, Michal Koutný wrote:
> diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
> index c0f5e9a4f3c65..c3055e74aa0ea 100644
> --- a/net/netfilter/xt_cgroup.c
> +++ b/net/netfilter/xt_cgroup.c
> @@ -23,6 +23,13 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
>  MODULE_ALIAS("ipt_cgroup");
>  MODULE_ALIAS("ip6t_cgroup");
>  
> +#define NET_CLS_CLASSID_INVALID_MSG "xt_cgroup: classid invalid without net_cls cgroups\n"
> +
> +static bool possible_classid(u32 classid)
> +{
> +	return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) || classid == 0;
> +}
> +
>  static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
>  {
>  	struct xt_cgroup_info_v0 *info = par->matchinfo;
> @@ -30,6 +37,11 @@ static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
>  	if (info->invert & ~1)
>  		return -EINVAL;
>  
> +	if (!possible_classid(info->id)) {

why classid != 0 is accepted for cgroup_mt_check_v0()?

cgroup_mt_check_v0 represents revision 0 of this match, and this match
only supports for clsid (groupsv1).

History of revisions of cgroupsv2:

- cgroup_mt_check_v0 added to match on clsid (initial version of this match)
- cgroup_mt_check_v1 is added to support cgroupsv2 matching 
- cgroup_mt_check_v2 is added to make cgroupsv2 matching more flexible

I mean, if !IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) then xt_cgroup
should fail for cgroup_mt_check_v0.

But a more general question: why this check for classid == 0 in
cgroup_mt_check_v1 and cgroup_mt_check_v2?

> +		pr_info(NET_CLS_CLASSID_INVALID_MSG);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -51,6 +63,11 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
>  		return -EINVAL;
>  	}
>  
> +	if (!possible_classid(info->classid)) {
> +		pr_info(NET_CLS_CLASSID_INVALID_MSG);
> +		return -EINVAL;
> +	}
> +
>  	info->priv = NULL;
>  	if (info->has_path) {
>  		cgrp = cgroup_get_from_path(info->path);
> @@ -83,6 +100,11 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
>  		return -EINVAL;
>  	}
>  
> +	if (info->has_classid && !possible_classid(info->classid)) {
> +		pr_info(NET_CLS_CLASSID_INVALID_MSG);
> +		return -EINVAL;
> +	}
> +
>  	info->priv = NULL;
>  	if (info->has_path) {
>  		cgrp = cgroup_get_from_path(info->path);
> 
> base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
> -- 
> 2.48.1
> 


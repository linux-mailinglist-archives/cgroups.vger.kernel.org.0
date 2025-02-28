Return-Path: <cgroups+bounces-6748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5AA4A132
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674731709CE
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916227002E;
	Fri, 28 Feb 2025 18:11:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473251A2554;
	Fri, 28 Feb 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766307; cv=none; b=AZb0nci2vn98KWAV5Sqhaas1LWHNZC/XrZU7jP/aJpVCHBIL1x8jnUToJADdwaOXDFw5CanrPwqNAfgwEnPSAP5IV7dVlBrVnt30l3JOhMnT831xwjQ5xEq36GICU15vB/xt2zkeaMsN01f1MeyoiRJpArWxtuyB9OUprCpd+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766307; c=relaxed/simple;
	bh=KnY61hLvrf2jTbQWMQPNQdlx+jAyWdmCTwJsF1oXWto=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o/niNLcjv0ppZZqtNquQ1wdGvpmxDUBw48fp8TGcbAlaztj9sD12l7i8dnB+xEZARItCVHI8QhvLocV3Weko1Z5YATcZIvI9jQad/kEPUIse9/H/xMNhnH57h+qX6VoXufiejiNZ9YPBK/dY5iLXwozkbpUIY7U7hrGB3bj+UQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id C565A1003DF114; Fri, 28 Feb 2025 19:11:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id C51D51100AC40A;
	Fri, 28 Feb 2025 19:11:34 +0100 (CET)
Date: Fri, 28 Feb 2025 19:11:34 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Pablo Neira Ayuso <pablo@netfilter.org>, 
    Jozsef Kadlecsik <kadlec@netfilter.org>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    cgroups@vger.kernel.org
Subject: Re: [PATCH] netfilter: Make xt_cgroup independent from net_cls
In-Reply-To: <20250228165216.339407-1-mkoutny@suse.com>
Message-ID: <osn82ro6-08p7-q1so-r050-7poq60803250@vanv.qr>
References: <20250228165216.339407-1-mkoutny@suse.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Friday 2025-02-28 17:52, Michal Koutný wrote:
>@@ -23,6 +23,14 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
> MODULE_ALIAS("ipt_cgroup");
> MODULE_ALIAS("ip6t_cgroup");
> 
>+static bool possible_classid(u32 classid)
>+{
>+	if (!IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) && classid > 0)
>+		return false;
>+	else
>+		return true;
>+}

This has quite the potential for terseness ;-)

{
	return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) || classid == 0;
}


Return-Path: <cgroups+bounces-6798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3CA4D21F
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 04:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BF97A7D2A
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B601B21AD;
	Tue,  4 Mar 2025 03:45:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790904A3C;
	Tue,  4 Mar 2025 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059925; cv=none; b=NiEYxWu/7D144MRK2+hlPG8OVd9ihF2sqkhC3cb5QP47Lhv/8sfXdnaTTM7nCVkEkUDsxHm5icjc83pVZsiRBTm02HvHsvC3A921hqWbbCZN8TEd6K+yiGF0+ZCHkGznzGmhvZUu0ff1iiGIPV7mzcPWQFAhxx4/mfQxtW2+YAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059925; c=relaxed/simple;
	bh=bBHThCWd7M6hrzmH8PiqcgtfCtVSsXz+ER2Biwmdnog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgeKXyb6TbY5G0pNS7gG4keGfgMSyvg6qJxAjYkXeJtYZHI+WnSi3b4GzLwInFw4EhImppWnloZtlyJvMOjT4xx+QueXvPBOC/PjnPnQxpV37cXepFq3Y1DM+zgmS7de1/Q34vEfbz70Xm1bDhu5+eIO0aCM71V6gnwhAPx4W0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1tpJDG-0007PA-Rp; Tue, 04 Mar 2025 04:44:58 +0100
Date: Tue, 4 Mar 2025 04:44:58 +0100
From: Florian Westphal <fw@strlen.de>
To: Michal =?iso-8859-15?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <20250304034458.GA27044@breakpoint.cc>
References: <20250228165216.339407-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228165216.339407-1-mkoutny@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Michal Koutný <mkoutny@suse.com> wrote:
> +	if (!possible_classid(info->id)) {
> +		pr_info("xt_cgroup: invalid classid\n");

I think this is too terse, I would prefer if this could say
that the build doesn't support cgrp v1.


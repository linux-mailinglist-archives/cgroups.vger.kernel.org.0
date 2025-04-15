Return-Path: <cgroups+bounces-7579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF18A8A271
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A583BB829
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5222973CA;
	Tue, 15 Apr 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="UK5bJemo";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="pRh0tqPv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9B199FA4;
	Tue, 15 Apr 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729784; cv=none; b=N6AWF7HStfGiWbw9Gdu7UirdiJAot7QXsbRLFyRH8x4z+0LGWaNvgK2G7oU4UyChosbYRziGZiOFvO3NMYJkhOGjLx8BgvPwzivqlJav5UZZ1mOj08Fla4ePnaLtVFUR10yjGsfD/+kXWGBLvVCGgib4m1vS008nUnwBPyvJd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729784; c=relaxed/simple;
	bh=1sY8h35aN2Hmwd36JiY1vQFSG475B/5TTcTr4pmla/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+0vvibdTDlXLydjcTuL5tbZiDapuIrKDyTeYoqfQ2a/mKbZz8nOaiC5n5nHsoWqXddr96ru1qhifx1Vq7rMJBIDoSWIHZGU6ZlF+jqLoXmXv8R8mGl2prYC8EalqDsALsK3HhDJ8AYmJafMip0rsd+aAm9HS6J9gvQnzDFttqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=UK5bJemo; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pRh0tqPv; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 40BE660B8A; Tue, 15 Apr 2025 17:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744729780;
	bh=vGQh7X7rXzqZp7edqwor6awCdiBrTcxU9eCBdReDiyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK5bJemoSppoh2NRsRoyoVj4/gLHmnsPwH+OMNTQ7gS6MTRGGFYhUP2KJIUpymUsn
	 wDP+prGuedR1RYt3+42LSw59ALvfJ3P8FW5qmMfHtgh5y72gVEEt3AD207Py702HLO
	 ActJ0lT9U0IAlTQPC1n9HykjbCVTrov7IE/JavoV16XtKQp1pov+Ru1mlXin7zzPhB
	 91RRYV6nKOv7YyeZ2F6+B6gArQlmhoy0max0OMulgoHDOuMNILNNHvWW1pQE+PqPsR
	 5/NFymKqWot9G6z3GDKK2Q/uNLpJqjlYwcC/sTGhp2HPS0nSAFg6wAC3aa8X1cSX0v
	 4S0OsDp01VwOg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 92F5D60B76;
	Tue, 15 Apr 2025 17:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744729777;
	bh=vGQh7X7rXzqZp7edqwor6awCdiBrTcxU9eCBdReDiyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRh0tqPv/J8UAh3jZ3ZSZVUlgwiqCdLBXy8YzG8tGeVG+Q5mPAhCARPFAVH1vXUdw
	 VlZYTwWRrRIG2feir8w9zbpbmLnm/mX6aPHmLnafWKN/YO9o8IwkwneEvztum5mXT3
	 Nnv7imQdfdoZHizskiyCXCYDnHU7auIyllSRiGmvi2aYB4/F413ukKbj+ixZI2RzZ+
	 +W8oAGSbGNO0WesXEtSM3gqGG2ohYhb9fri8J4NuINNmPoCOFqYhwmf+AQW5BB8wEb
	 AoXDucmQvphhX/LGNJgfxzcAHGUjsp5igTlcqk5kGAldMLKU2nVG7j0r1NeTfPObtJ
	 y7iP/7bfkHg5g==
Date: Tue, 15 Apr 2025 17:09:35 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netfilter-devel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <Z_52r_v9-3JUzDT7@calendula>
References: <20250401115736.1046942-1-mkoutny@suse.com>
 <o4q7vxrdblnuoiqbiw6qvb52bg5kb33helpfynphbbgt4bjttq@7344qly6lv5f>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o4q7vxrdblnuoiqbiw6qvb52bg5kb33helpfynphbbgt4bjttq@7344qly6lv5f>

On Wed, Apr 09, 2025 at 06:56:17PM +0200, Michal Koutný wrote:
> On Tue, Apr 01, 2025 at 01:57:29PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> > Changes from v2 (https://lore.kernel.org/r/20250305170935.80558-1-mkoutny@suse.com):
> > - don't accept zero classid neither (Pablo N. A.)
> > - eliminate code that might rely on comparison against zero with
> >   !CONFIG_CGROUP_NET_CLASSID
> 
> Pablo, just to break possible dilemma with Tejun's routing [1], it makes
> sense to me to route this series together via net(filter) git(s).
> 
> Also, let me (anyone) know should there be further remarks to this form.

I am going to apply 1/3 and 2/3 to nf-next.git

I suggest, then, you follow up to cgroups tree to submit 3/3.

3/3 does not show up in my patchwork for some reason.


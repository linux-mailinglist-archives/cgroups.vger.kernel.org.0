Return-Path: <cgroups+bounces-7191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3EA69CD3
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265B788340D
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69382224AF0;
	Wed, 19 Mar 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ctVkYzJO";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YG9j2QdD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572916F858;
	Wed, 19 Mar 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427871; cv=none; b=aHxqJU3H2oQQSj05buOk/OSw5Qsn0U1ddAGN5+fMX5ee5R3hVsjqZ+EsO9f3DXplNXkfYYbYYGrHjyG/PiSpeAsU9e1MEPhMZVsm+fQY+oV5roV/QZ9B/rn0UykdHqg5fE75s200hObbSKjqUqKj/b62Rzj6PWnBmTAJ4JTZUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427871; c=relaxed/simple;
	bh=8O4QrfRpB6IDq3ko+6A55O4k2nnuAuaY7R5+TSfdkmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCIbRBP6/x5kfouybNoKw0F40AHL95dbywpf6ociu0n9h3Gk+6AQNXYgjzeI3LA3oPC83RX89E1Hfnzu/KlvymBZNfZoSTASnVwqnw1bsaq9FLfy/hOvvcucewCM1hyBWkxuaBka/o0vfmL+5pjcGMelkMQcgochzJnXz9t/RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ctVkYzJO; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YG9j2QdD; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 069AD603AB; Thu, 20 Mar 2025 00:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742427851;
	bh=GNBfAL5tBesE6D+Wz3Kjvd8+408rgskBVZfEyIzPa+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctVkYzJOo9GYyWmIgvXN4v3gYHJek32Gns8BuDnlM6bgtREngTvE2e0fNsNjQS8+d
	 PVQaQLo0KHjU5N59siBqwmTYQSNSbtqvB4tp8E0tLFBRb3ci5H7GF0Ja4BH7RiZFLD
	 0nWRhgkeJ9Rp1+iQ1qyLs0nuSmWV1H5tCdcTyP5zYyQZnk5yja+KJLQdmdZNRi3hdz
	 JF/js3byxkRNREgBoGCXh65ETboQucvyLMaUv4705lTeVXjCYav/iVYY9ZjfZ9pvHL
	 H0aE+UxHy2avJ4YJvTdK+5SFvcrG+aj8URxydmpv9e57V4WV1uxf9D9wuF3JBFZXEJ
	 8wVxQA826KWnw==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D6D7A603AB;
	Thu, 20 Mar 2025 00:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742427849;
	bh=GNBfAL5tBesE6D+Wz3Kjvd8+408rgskBVZfEyIzPa+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YG9j2QdDiW4VVFcqnNZ0P/sKJMImrtfoWq4inwhUv26jYyYMQpJdaguKvVZuUFLQc
	 InzrOLE3peM+8sICbLzYBVkE7AsCk+DArG+fO1uc6n6LZ1GLMrBZFUPMVpo3BbE+0+
	 ZNi0PevxgO8m0H1ChwQCwCfV5yFdEWlJem3pcNcg5UaNXx1kHj/ow4HBohlEWBWAxc
	 uHwko22XM52Ufu5EUuMZSkTHzhU5NUja84dDHOt9vsLTyAjWCV6aiJr8J5Ylwqmcup
	 I4ZtV94FVeH7MozjpHm3WLUiOK6od65baNH9fZhl9fHJetUy3q1sYcdUPnyY6Yn1l/
	 THedQAJl+298A==
Date: Thu, 20 Mar 2025 00:44:06 +0100
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
Message-ID: <Z9tWxkg4UQA-hQGi@calendula>
References: <20250305170935.80558-1-mkoutny@suse.com>
 <xn76sakdk5zai3o4puz4x25eevw4jxhh7v5uqkbollnlbuh4ly@vziavmudqqlv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xn76sakdk5zai3o4puz4x25eevw4jxhh7v5uqkbollnlbuh4ly@vziavmudqqlv>

On Wed, Mar 19, 2025 at 06:35:47PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Wed, Mar 05, 2025 at 06:09:35PM +0100, Michal Koutný <mkoutny@suse.com> wrote:
> ...
> > Changes from v1 (https://lore.kernel.org/r/20250228165216.339407-1-mkoutny@suse.com)
> > - terser guard (Jan)
> > - verboser message (Florian)
> > - better select !CGROUP_BPF (kernel test robot)
> 
> Are there any more remarks or should I resend this?

No need to resend, thanks.


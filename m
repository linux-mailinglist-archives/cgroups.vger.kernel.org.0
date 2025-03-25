Return-Path: <cgroups+bounces-7231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F210A70510
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5791816743D
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FAE19DF4D;
	Tue, 25 Mar 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="dqBa0NGx";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="q3qFTrXS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155442A96;
	Tue, 25 Mar 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916726; cv=none; b=LWvTEx5McdhTeTdJP6M9wbNfFv5pq7zZF/FKzlRAXEbwblLIfVuN1D55f5kzUqmeUM1HwkEbOt5IgKL+BR99afQHE134PByH1tL6zTKWOvbTB8bMs4pKjpvct8ETDC2yOYMWm5w/bcJPCHxuoTAvT/TL7ECrbAJc1ASKm1iKmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916726; c=relaxed/simple;
	bh=x2NmSt9yLbVIJPlyS82xD2DGNKCq8MlMoH8SFczXq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKPMlFiSMGQ8Z8ms4c/VR1lkYGdzKVS+/FXTxVEn9wwnbUCzB7KpNvf6MKRCedwB+k8GInWAqbRb3DiGcDF7ApfAKFEIewl+WzZb9Di2SvLNs/WfIrK4mOquZhlW+29Nx5IKRi0HauKhUHBWkM1fhpbv4BIbecAz1/RjXnhxX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=dqBa0NGx; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=q3qFTrXS; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id DE3016032E; Tue, 25 Mar 2025 16:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742916720;
	bh=uqCXvfdB2apsnaT9FS0TOcbMaur2YtZsVJVBqKqOVhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqBa0NGxkoj44VfwN1i2rHQFWsvTKCPmfpuj7lnYou27otd2hiwa9RynLJfM39Jbf
	 R2YAK1ZvEDr4aHAALJl4ZbDY5INvoqR50+cw93t4LeI3QnBL+C3ssbVFosNXGyvDxX
	 ohy1mxW5luDd4JdEiWQdx7fujQu1cgq5OaY57Oo9tqGwphJ30RYE2CRThcJezbFsrl
	 glnWX3Bh5x5/YIq8EQA2sV10KmgvMDJnNPLr40BmT/M8L82+zf9XFqY7afYp8R1+LO
	 8CxkDu6ydQpfAK4Oe2W/jdUj0xH7kXTpDsFKqiJd8EjXkrBIycNyvyi085c5NXM+yR
	 olJOiL0aquPFg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 2F53960292;
	Tue, 25 Mar 2025 16:31:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742916718;
	bh=uqCXvfdB2apsnaT9FS0TOcbMaur2YtZsVJVBqKqOVhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3qFTrXSS2hEHC9r/3hWthMYvvglJvKbVle3F0+2hmRKzCoQ+jsZD2yNt83Wc1bJQ
	 a39DMxUYuu2tblvm4pUi642xqNzPMqpHomiXBNaTnCsAEaQjfZpbV5DQ8PqlFDICV3
	 dYAIcTW1Qzw2uvAh/dZKFRTErBbfwxeIjYqhJwNbUOyykemfDYv+Z03l4WO6zyQm/P
	 S1kzLKcPme6R4/8EJBdwKkZuU1DgvvjZYpv9taiOrWKk7npBWiVr1mAh5Mt3oC+ZFc
	 Qg+wdlx7OqKoTjPcxZzFcqKXtbys0gzH30zFctsq3hkH081K5M+GKaUyl5L8ckOlo1
	 yIls4dFI5VUPA==
Date: Tue, 25 Mar 2025 16:31:55 +0100
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
Message-ID: <Z-LMa9k9q_tJolr3@calendula>
References: <20250305170935.80558-1-mkoutny@suse.com>
 <Z9_SSuPu2TXeN2TD@calendula>
 <rpu5hl3jyvwhbvamjykjpxdxdvfmqllj4zyh7vygwdxhkpblbz@5i2abljyp2ts>
 <Z-GNBeCX0dg-rxgQ@calendula>
 <iy3wkjdtudq4m763oji7bhj6w7bj2pdst7sbtahtwgcjrhpx6i@a4cy47mlcnqf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iy3wkjdtudq4m763oji7bhj6w7bj2pdst7sbtahtwgcjrhpx6i@a4cy47mlcnqf>

On Mon, Mar 24, 2025 at 07:01:14PM +0100, Michal Koutný wrote:
> On Mon, Mar 24, 2025 at 05:49:09PM +0100, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > If !CONFIG_CGROUP_NET_CLASSID, then no classid matching is possible.
> > 
> > So why allow a rule to match on cgroup with classid == 0?
> 
> It is conservative approach to supposed users who may have filtering
> rules with classid=0 but never mkdir any net_cls group. Only those who
> eventually need to mkdir would realize there's nowhere to mkdir on (with
> !CONFIG_CGROUP_NET_CLASSID). Admittedly, I have no idea if this helps to
> 5% of net_cls users or 0.05% or 0%. Do you have any insights into that?

I suspect this partial support will not help anyway, because user will
be most likely matching to classid != 0 in their rulesets, and the
ruleset loads via iptables-restore in an atomic fashion, ie. take it
all or nothing.

> > Maybe simply do this instead?
> > 
> > static bool possible_classid(u32 classid)
> > {
> >        return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID);
> > }
> 
> Yes, if the above carefulness is unnecessary, I'd like to accompany this
> with complete removal of sock_cgroup_classid() function then (to have it
> compile-checked that it's really impossible to compare any classids w/o
> CONFIG_CGROUP_NET_CLASSID).

Go ahead remove this shim function and post v3.

Thanks.


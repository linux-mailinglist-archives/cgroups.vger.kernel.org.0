Return-Path: <cgroups+bounces-7221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2CA6E027
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8160B3B22D8
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E722641CD;
	Mon, 24 Mar 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="wTRGOOI5";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="DCPnz+Gj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB3261586;
	Mon, 24 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834967; cv=none; b=XXHwurOEwX7+LzM/HRtFoENrtbaL1kOvU0ktGu30ybLNc6ePubDQy90vavh7IQRps5mIx7wyQUbsQrWEH8O4Id7Qf6g3xgPVZbPKKYfFOb1GEKSjvzqcDTcvLAdNf5VAXcHVgfBDHll+9v8hw3Kl38AbGpB+dTHk99Xh61OYNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834967; c=relaxed/simple;
	bh=5fRaRRqoLXk9VvHYdcvASGdB+1Jt16QfeJgofkT4YqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxN6Yyy6iext76ZYR5VWb8JhNm4yZXDxk1QLBI5YUqznYZyp7GvTcVoQ8UkYSCIqXBKvCoix6WsU7K1/Sv8wXZcU2Nl50TJ7xfjrpKrHYPyrFg/vi3+VMJI+Zbrg9D+DtwCEDUBwvLuWufE3NVdXc6xdDi2QDhICZU6rFImYd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=wTRGOOI5; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=DCPnz+Gj; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 7E48860390; Mon, 24 Mar 2025 17:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742834955;
	bh=GGDJ9ToJtDJw+S47TSdM9cpM1oN2wQQEXFzOumVzNjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wTRGOOI5j5ondXNwLDawdD4j82Ru2vOHGWWppgQwjHax3kidJsU01JPVyWMvJWUuo
	 mTlzALu2ndA/PN1/PV3qbS1jtE0gIN4MZn9Px+MTY3f1ooPuHrejXseAm98hsak18I
	 0ILH2j9IWbHG2oFFPSGwrTcaTurXdJLWbXKXQfInp8slWtBuf4gkUm1Ew72dTEhXBa
	 mKrOPVtkR5ATvo3p/FZHS+q1ji+LyRr5TGNJKBCTM3gWAH0U6soNJVcMjgv2eJhA+m
	 +aTajPruzLQkeBcZLdm0gHq9G1Ipv+72SP/3qZgQJ3KpiidC7bHjO+0Et/bjpTUOR9
	 S1H1zkeyaSRPQ==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id DB85C6034A;
	Mon, 24 Mar 2025 17:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1742834952;
	bh=GGDJ9ToJtDJw+S47TSdM9cpM1oN2wQQEXFzOumVzNjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCPnz+GjATTwDRX3cEAXYvzpHMgEbhxo+Um4+G4iZp77oga/M9H5MquqVeX/BV9IY
	 KBZNU0v6OevhOTNQ3Zt+sPKh3MbwtFLMevwQc7cFBfhhymq0TR+bZ2u+knkWHspR4D
	 FjNxNetEur4h+TmKXvzrUWhyyFKZ99Fcf0W3w6sTMgrrEbNKJEl3X4rhs+VPAEEigu
	 NhJNR9cQ37cusjxHiPxAqgV2ODW4wl3GVVmq/ey9BgQAWCOgrALHDvsz87SUcheLH2
	 6ZOb5qYNROVcBaoqnRK5zV1FTYqtwHgPv5JjHiun/ZZ6xcOvlRS4hnOlzdsn3c215i
	 ncHJcpfKEceYw==
Date: Mon, 24 Mar 2025 17:49:09 +0100
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
Message-ID: <Z-GNBeCX0dg-rxgQ@calendula>
References: <20250305170935.80558-1-mkoutny@suse.com>
 <Z9_SSuPu2TXeN2TD@calendula>
 <rpu5hl3jyvwhbvamjykjpxdxdvfmqllj4zyh7vygwdxhkpblbz@5i2abljyp2ts>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rpu5hl3jyvwhbvamjykjpxdxdvfmqllj4zyh7vygwdxhkpblbz@5i2abljyp2ts>

On Mon, Mar 24, 2025 at 01:56:07PM +0100, Michal Koutný wrote:
> Hello Pablo.
> 
> On Sun, Mar 23, 2025 at 10:20:10AM +0100, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > why classid != 0 is accepted for cgroup_mt_check_v0()?
> 
> It is opposite, only classid == 0 is accepted (that should be same for
> all of v0..v2). (OTOH, there should be no change in validation with
> CONFIG_CGROUP_NET_CLASSID.)

Thanks for clarifying this, more questions below.

> > cgroup_mt_check_v0 represents revision 0 of this match, and this match
> > only supports for clsid (groupsv1).
> > 
> > History of revisions of cgroupsv2:
> > 
> > - cgroup_mt_check_v0 added to match on clsid (initial version of this match)
> > - cgroup_mt_check_v1 is added to support cgroupsv2 matching 
> > - cgroup_mt_check_v2 is added to make cgroupsv2 matching more flexible
>  
> > I mean, if !IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) then xt_cgroup
> > should fail for cgroup_mt_check_v0.
> 
> 
> I considered classid == 0 valid (regardless of CONFIG_*) as counterpart
> to implementation of sock_cgroup_classid() that collapses to 0 when
> !CONFIG_CGROUP_NET_CLASSID (thus at least rules with classid=0 remain
> acceptable).

That is, 0 is the default value when !CONFIG_CGROUP_NET_CLASSID.

> > But a more general question: why this check for classid == 0 in
> > cgroup_mt_check_v1 and cgroup_mt_check_v2?
> 
> cgroup_mt_check_v1 is for cgroupv2 OR classid matching. Similar with
> cgroup_mt_check_v2.

Yes, and cgroup_mt_check_v0 only supports for classid matching.

> IOW, all three versions accept classid=0 with !CONFIG_CGROUP_NET_CLASSID
> equally because that is the value that sockets reported classid falls
> back to.

If !CONFIG_CGROUP_NET_CLASSID, then no classid matching is possible.

So why allow a rule to match on cgroup with classid == 0?

Maybe simply do this instead?

static bool possible_classid(u32 classid)
{
       return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID);
}

Thanks.


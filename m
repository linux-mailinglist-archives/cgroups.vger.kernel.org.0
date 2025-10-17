Return-Path: <cgroups+bounces-10839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B0BE9226
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2CD4FA8ED
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD12309B9;
	Fri, 17 Oct 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="tdvhWsDN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2132C946;
	Fri, 17 Oct 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710535; cv=none; b=c7UGeH/bY21tC+Sw/o18e7CAI5nkRW7bHi7CY2r602wE2hhvfdShykDdr81+OEMAM2prftV1Sl+5+hk7ac9twESvOdZ2M7sX8E1NF41gq0IGBqS5/0sQQBl4cZ71GPXXZ+S4Z5onWVG9EgiktwTkHXRLllLL1yncVe9RLcBQRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710535; c=relaxed/simple;
	bh=th2Qlh3fS77eQJ9bDXg4SvSNkkzZckDQ2+t5qOAP2rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsPH7ngDxZe9T9skBtAjnj/TxXtVbOmRlsCIzfJcE283gK4K14/7p6I+E1l2Lm5iSCneKYrHcA9e4/urDFrat/dr5SjVRyu8z7ZAQBzpLGo1DaKHpD7fjI0mt0AfTXz6F/BSPgM2uE1X2m1o2Kf6huCAMcZJVTrTwn61Firni5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=tdvhWsDN; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1760710521; x=1761315321; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=hXKmsIldz9QqYvJfYTeLTtnXwnXEkz/LZjkPfMe+5tU=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=tdvhWsDNZNEBUQVAGiA636NnpXjvHTM0mSiKJ7hu0tD0wLe+t5u4QDuvcZwAoljucA7Bs2X79ohRhxiyDhYXzpNV4YUowA5rVY1X0FCI9c7RK7esjmL+/vtgzzzcejrku8m9ovqqTZpd0AFTCvDuVi6kBmisQnv4io5unuFgn8Y=
Received: from [192.168.88.20] ([188.75.189.151])
        by mail.sh.cz (14.2.0 build 9 ) with ASMTP (SSL) id 202510171615201074;
        Fri, 17 Oct 2025 16:15:20 +0200
Message-ID: <209038ea-e4fa-423c-a488-a86194cd5b04@cdn77.com>
Date: Fri, 17 Oct 2025 16:15:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory
 pressure
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Matyas Hurtik <matyas.hurtik@cdn77.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Wei Wang <weibunny@meta.com>,
 netdev@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20251016013116.3093530-1-shakeel.butt@linux.dev>
 <59163049-5487-45b4-a7aa-521b160fdebd@cdn77.com>
 <pwy7qfx3afnadkjtemftqyrufhhexpw26srxfeilel5uhbywtt@cjvaean56txc>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <pwy7qfx3afnadkjtemftqyrufhhexpw26srxfeilel5uhbywtt@cjvaean56txc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D0333.68F24F79.0006,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 10/16/25 6:02 PM, Shakeel Butt wrote:
> On Thu, Oct 16, 2025 at 12:42:19PM +0200, Daniel Sedlak wrote:
>> On 10/16/25 3:31 AM, Shakeel Butt wrote:
>> I am curious how the future work will unfold. If you need help with future
>> developments I can help you, we have hundreds of servers where this
>> throttling is happening.
> 
> I think first thing I would like to know if this patch is a good start
> for your use-case of observability and debugging.What else do you need
> for sufficient support for your use-case?

Yes, it is a good start, we can now hook this easily into our monitoring 
system and detect affected servers more easily.

> I imagine that would be
> tracepoints to extract more information on the source of the throttling.
> If you don't mind, can you take a stab at that?

We have some tracepoints that we have used for debugging this. We would 
like to upstream them, if that makes sense to you?

Thanks!
Daniel



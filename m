Return-Path: <cgroups+bounces-10821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B746BE2DDD
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 12:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE81A4FCF49
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B882E0938;
	Thu, 16 Oct 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="qtT7BYAX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBD305079;
	Thu, 16 Oct 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611346; cv=none; b=InXrrj8wFpkmHqXgebaWFOCGPv1Nl9eQBZwWvphP4Zs26rige9riMzJqkW5ihxchqM1i+mGogq3FNn/DwtMOwrPu0/Yrr9OIM76/JIO3eE8jiFUElCJc7SGQH/DjAqVqLfEeEXQKyjz/cB8ZB6m2c6wnpXOC9vb1ZQ/neSPAWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611346; c=relaxed/simple;
	bh=yJKBfnLlUEQ5ZRG8L1M5ZmyEhhel75fMN7aGsTK7b68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+CQmLgytIPpuqACggESENzMPQL7GzCKqOe6xn/MwZHTRIIw63/CflpIE08/uLlH1oOSLPR2k+eKa5S+BGmkGA1g0TNoYXBoSmWjTWPCPR0M/8rCR3k2oRZrtUtiv07fHZidPoRNgz2dHvXo4C8dP832G+DSfihTEC3tB9SkPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=qtT7BYAX; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1760611341; x=1761216141; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=qV1vjNqTC7g0wYqXVbFuuQgO1xGeyPpn8o/0TBe9zlY=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=qtT7BYAXHacUHaOWwcNVZUb+OOX/qRxrW2/MGG4T5N++dY6H7t1qu235QwWdQF3EhSGRB7lZHgdlx8UT6PESarUaRmNuW7QFxA3GaxFo7hN9ZWDKFMXzlWAAHI8iZIp1GMe7npLL4QMpKN0oRpDtxRHlndxh6EF8+3f3SDGsEac=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.2.0 build 9 ) with ASMTP (SSL) id 202510161242190311;
        Thu, 16 Oct 2025 12:42:19 +0200
Message-ID: <59163049-5487-45b4-a7aa-521b160fdebd@cdn77.com>
Date: Thu, 16 Oct 2025 12:42:19 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory
 pressure
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
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
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <20251016013116.3093530-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D0311.68F0CC0C.0030,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 10/16/25 3:31 AM, Shakeel Butt wrote:
> The kernel can throttle network sockets if the memory cgroup associated
> with the corresponding socket is under memory pressure. The throttling
> actions include clamping the transmit window, failing to expand receive
> or send buffers, aggressively prune out-of-order receive queue, FIN
> deferred to a retransmitted packet and more. Let's add memcg metric to
> indicate track such throttling actions.
> 
> At the moment memcg memory pressure is defined through vmpressure and in
> future it may be defined using PSI or we may add more flexible way for
> the users to define memory pressure, maybe through ebpf. However the
> potential throttling actions will remain the same, so this newly
> introduced metric will continue to track throttling actions irrespective
> of how memcg memory pressure is defined.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Daniel Sedlak <daniel.sedlak@cdn77.com>

I am curious how the future work will unfold. If you need help with 
future developments I can help you, we have hundreds of servers where 
this throttling is happening.

Thanks!
Daniel



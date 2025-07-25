Return-Path: <cgroups+bounces-8902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90526B1155F
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201673B18B9
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 00:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F6165F1A;
	Fri, 25 Jul 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx4P75kK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6532BAF4;
	Fri, 25 Jul 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404301; cv=none; b=tW+Sh3SubH/AF0SPZdtHK1r4TK2bB0vvAVF/MN6xmi0aTaHti64twiDmvelqvNMsVHakTcoyyWLL8KcUkCZJhPZLxPsBMGyJL99+LZGbAGaL067VOpOGtmb1cYk/6I47BRJlu9xs6FAbSK/IOny1BcHKYT7OpeXAvwOpisQ1HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404301; c=relaxed/simple;
	bh=dvzxxFO1gaX+9xGTWwgKBCgV2b2CxVSK7tOnwNJFUio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwx342poV/ynte34h7Pc3yMl0O93Z1aCZqvAAP9DAg7fJmC0VhjFpuvA1i+R8iUmiWDVSF6eWWVCfRSliu9jui2HuZT37D00zQi8j/2jgOGwtX2z3kjOqN3/SGac0sIX1Fw7pvErjmeQWpUB8/sSZCquQt31uYRYmtG83KNze20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx4P75kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA47C4CEED;
	Fri, 25 Jul 2025 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753404301;
	bh=dvzxxFO1gaX+9xGTWwgKBCgV2b2CxVSK7tOnwNJFUio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx4P75kKdF2V/aTgUjzyLBGy6f2MxQkesu7J3yxq3vEfAcB7ES6M60ybBRTtdBoS/
	 jolS/1xxvErQtFnIo0OQZVGIMAEjrOal3WiqWUDZP6BbIWS/Ila/lyf2dC2nSf/Gbj
	 rq8WPXzQ3J5oTC62KScmoUJoOOZOcXtNfQOCRDNghJKTyrwUPsfByokTTShdldhSI6
	 ECrRz2veukkxssSq5AZPpWLseG8RxnO6UYjaU1lOpUkmRmGCHJFftVhjulI39Eh4fj
	 9neuKi7uot7S9R4FfwgtPHW9x2iGksCBRuTYjcBfB3adZMD8a1hBTI2Ym4HkHU7y9e
	 l6dOJgW1jksGA==
Date: Thu, 24 Jul 2025 14:44:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <aILTi2-iZ1ge3D8n@slm.duckdns.org>
References: <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
 <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
 <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
 <486bfabc-386c-4fdc-8903-d56ce207951f@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486bfabc-386c-4fdc-8903-d56ce207951f@cdn77.com>

On Thu, Jul 24, 2025 at 10:43:27AM +0200, Daniel Sedlak wrote:
...
> Currently, we know the following information:
> 
> - we know when the pressure starts
> - and we know when the pressure ends if not rearmed (start time + HZ)
> 
> From that, we should be able to calculate a similar triplet to the pressure
> endpoints in the cgroups (cpu|io|memory|irq).pressure. That is, how much %
> of time on average was spent under pressure for avg10, avg60, avg300 i.e.
> average pressure over the past 10 seconds, 60 seconds, and 300 seconds,
> respectively. (+ total time spent under pressure)

Let's just add the cumulative duration that socket pressure was present.

Thanks.

-- 
tejun


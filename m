Return-Path: <cgroups+bounces-10602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0006BC4EED
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A4819E13F5
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B0251795;
	Wed,  8 Oct 2025 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="JDPCBdIo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB7246BB6;
	Wed,  8 Oct 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927590; cv=none; b=o7OuPiU3BGOLIx33JlIDLKuY61F6PsHMY7mA9i1fC6pDKicaNAXNeN8TZks/EvSH9YAwLH7FiLFSFmK4d4DuLMpbfDJyrz7WXdjxBAoNgF9941qjV1d/O3RqTcH2qJVHGO9aXbma/7QskQRw7+QZ5fBRnyNRRvWGjKulewtwwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927590; c=relaxed/simple;
	bh=bdplL2rpAWNb4aoW6dsVwxjpIpkkjgM+sJAhQTqcmy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvjPgMrI7rckN5aIyLdJgsWdV3mXrgqeeBRNLlj5bx/2Dpfz6H6OAtk4g6Cwcdj9JBJ1yd1Dd0U26SN+tFTt8hH+CPp4/s6z3pvzoE802EgOzHHW71a9sQv8/C7gnZ6klbX01VRy5mivtdURlyF/OWC667aWVdkIaM1P0c3ZLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=JDPCBdIo; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1759927585; x=1760532385; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=YsJun95Wxhwf/ur9MneaPmQvhR6RH8R5auchgi1X7Ng=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=JDPCBdIoNeGiQm2XgBrPzRm1JA4dH2d+wbkdxjyXuiLKON0wMnxiV3hSDcXJvM/cqQltBzkVLBC4+EwMbH2NBg5qdQMkMm0Oh3Hcc1dO3WWd10o9PIdC0aWRP2+3wrqy1lzVJtjk7gOa29oc1EEy+hOerDNGcGSMabahNOv1kZw=
Received: from [10.26.2.242] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 17 ) with ASMTP (SSL) id 202510081446246620;
        Wed, 08 Oct 2025 14:46:24 +0200
Message-ID: <6cbf24f6-bd05-45d0-9bc8-5369f3708d02@cdn77.com>
Date: Wed, 8 Oct 2025 14:46:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Tejun Heo <tj@kernel.org>, Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <aOVxrwQ8MHbaRk6J@slm.duckdns.org>
Content-Language: en-US, cs
From: Matyas Hurtik <matyas.hurtik@cdn77.com>
In-Reply-To: <aOVxrwQ8MHbaRk6J@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A2D0331.68E65D20.0068,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hello,
> I'm not against going 1) but let's not do a separate file for this. Can't
> you do memory.stat.local?

I can't find memory.stat.local, so should we create it and add the 
counter as an entry there?


Regarding the code, is there anything you would like us to improve? I 
had to rewrite it a bit

because of the recent changes.


Thanks,

Matyas



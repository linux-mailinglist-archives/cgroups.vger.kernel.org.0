Return-Path: <cgroups+bounces-17707-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iRveCfHLVGrYbwAAu9opvQ
	(envelope-from <cgroups+bounces-17707-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:28:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56974A5D3
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 13:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=SdutnbTM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17707-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17707-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B2E3047423
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8E3DBD43;
	Mon, 13 Jul 2026 11:28:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8583E2746
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 11:28:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942091; cv=none; b=QbROxCWSRmwMwL0OkyTZqaie6cAu1Dg2wBQymhwKFBKQcFOeSJZR0Za8bLEhcf09XGMt07tTZTRX+0NHb+/rb76Cm42BnJ0czP3ilS8M3IRSIPAblEd714sLVfvstFqyoRt14BGnHXMhpkGixcopfkLfStS2VjshInKAmOqRGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942091; c=relaxed/simple;
	bh=9NbjiGnRbO8bMlr++XqTPvUsQTxZUPSWWuF0+rAbG5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldEKPaTuI9yFYAbWPvDwqcvkVKFH17gajhMQgxFBCS4afM7/TP9hG68ZZgw1dMBhgp+Kbw3WmTiVJ/tld85DKLrC5RkoCazRHebfkdoUrlqz5/As6oO+GZj3j3Wo8hItJU4VMdS1BEKoSdHlXIb2s62j4tQfVWUoWykK/PMv0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=SdutnbTM; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ba701891so28399385e9.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942086; x=1784546886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8NaKZPLB2MbLryks2UXn+vW7Ic/yS2EZxUfavZtTHM=;
        b=SdutnbTMDe3W/NXIGYGZv4VcCjNgbRBU3izkQTIofgDjT0oi+P9/Gm0LcUUNTSa7Rk
         W/wbxhUcDoMR/m+kDQhbxzMIxBylryQJzW9+twKohvgY6B8kSiNszpDp7J/QKvPjQAZm
         pVvlBUAJjsfukhwPQgiK20+FX1c4hI8Nh7cQIWl12ZGkY9+L3GUvaulD0OuHe4MsDAvT
         uWFjeoEOCkKw5De9RVNxc7texnkkC61lzE6XwPR/qkMnA3WSekWGqOLZm9UuRGrX9Mdh
         wTPmQLJgRBWafMDlfBjQjb2yLGAUO3uJLn/qSIsmmECrY1n2yJHszr+TazCl2DygL3Ym
         Ef9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942086; x=1784546886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8NaKZPLB2MbLryks2UXn+vW7Ic/yS2EZxUfavZtTHM=;
        b=eYU3dDX0ZRfjqBY1FiY2Kn3z5evRsVET8ZHbfCYAj47Hhiojx+Phk55kd1+AOM6MHe
         krLwaWbLbA91baRMEgZekbJncJzCnz2suo4igKF3VvJ7GTEeplrVCfNDQur0/43tG3SH
         V+5rKxcG3/4ymX5GB1h3OD0fO6fwDpn+6umshrZokdLeavjHNTqlL0pbNmARoI0gnxWQ
         OPmJ4kRmaXW6NsrjO/O1p2gxXji8MMum9yozUE2IocC7I9vFA8VTr0/N+fEHnwcvZfc+
         KfKF43UsfX3QRXgJ3uWPBquSFb2uLACiXuHGZ4VWJWXc7Z2FVOa7IFkQcc+S90KI2i27
         dMQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNuUfI0QC2vQvd3ejWapII2Ph/twC4YPRyujifb9SJLxOw1sPrWZf5fZ4oCJzQDlztf9EuhHyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Ixz9p/NwYRLonnwZeVwp+4sfDwZ7XWlsdMCPHOeSLib2XBQN
	lJSZXv1BP81ZzrTg54r/574NzqPh69K+1mZ5Ev92uR0PM+bguCMiAsnpoqVVC8y1g/0=
X-Gm-Gg: AfdE7ckAZabRIv9TVCVjCBkcpkea5zvx44dJQSA9ZBlgiX643laDFM7qUuXtxLhEd26
	MLQDxQNI+Xn+R6/n7kfT3MPcI5U0lTmnAnMwXf4KwI7IeCIOfPukhjTmJ1vsVmOTj5PWIBvbYIb
	Dr8XXkS5CJYCbU/jRBYABK1XO3evD1n8ZGO0ANUJR9Wiqpdei8ZVp/f50sNmiCcTjeivi6M1RER
	MO0rkxa2bxRDBxR1OilSk6ZTM50DuMLgx1mKLxw3FAA/hLtvIlJOUJi3y8QEpumEHCRfjrJUUCb
	5qlwk27oW4BvegVlaFtrL7zjwCyfZWjIMIPcgWAh1oRmBOx1z4cBqFes1CCi91cYkAWPZxvyoI7
	sFxHqzsiQvKGOOtcoKUjmBYo7nYS338wslQMZt9/IPTZaxWL/qYTifpTaDCCDQdDh8KygyzG9tY
	yEJ9dR1IZ3fA==
X-Received: by 2002:a05:600c:5489:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-493f8851d4emr87837105e9.39.1783942086092;
        Mon, 13 Jul 2026 04:28:06 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm79986910f8f.31.2026.07.13.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:28:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:28:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	David Hildenbrand <david@kernel.org>,
	Barry Song <baohua@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH 2/2] mm: vmscan: fix node reclaim ignoring swappiness
 parameter
Message-ID: <20260713112803.GF276793@cmpxchg.org>
References: <20260711091157.306070-1-ridong.chen@linux.dev>
 <20260711091157.306070-3-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711091157.306070-3-ridong.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17707-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:david@kernel.org,m:baohua@kernel.org,m:yuanchu@google.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email,vger.kernel.org:from_smtp,cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C56974A5D3

On Sat, Jul 11, 2026 at 05:11:57PM +0800, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> sc_swappiness() had two separate definitions depending on
> CONFIG_MEMCG. The !CONFIG_MEMCG variant simply returned
> vm_swappiness, ignoring the proactive_swappiness value passed
> through scan_control. This caused the swappiness parameter
> written to /sys/devices/system/node/nodeX/reclaim to have no
> effect when CONFIG_MEMCG is disabled.
> 
> Fix this by consolidating sc_swappiness() into a single definition
> that checks sc->proactive_swappiness first, then falls back to
> mem_cgroup_swappiness() which already handles both CONFIG_MEMCG
> and !CONFIG_MEMCG.
> 
> Before fix (swappiness=max ignored, mostly file pages reclaimed):
> 
>     # cat /proc/sys/vm/swappiness
>     60
>     # cat /proc/vmstat | grep pgsteal
>     pgsteal_kswapd 0
>     pgsteal_direct 0
>     pgsteal_khugepaged 0
>     pgsteal_proactive 1840
>     pgsteal_anon 25
>     pgsteal_file 1815
>     # echo "64M swappiness=max" > /sys/devices/system/node/node0/reclaim
>     # cat /proc/vmstat | grep pgsteal
>     pgsteal_kswapd 0
>     pgsteal_direct 0
>     pgsteal_khugepaged 0
>     pgsteal_proactive 18013
>     pgsteal_anon 337
>     pgsteal_file 17676
> 
> After fix (swappiness=max honored, anon pages reclaimed as expected):
> 
>     # cat /proc/vmstat | grep pgsteal
>     pgsteal_kswapd 0
>     pgsteal_direct 0
>     pgsteal_khugepaged 0
>     pgsteal_proactive 0
>     pgsteal_anon 0
>     pgsteal_file 0
>     # echo "64M swappiness=max" > /sys/devices/system/node/node0/reclaim
>     # cat /proc/vmstat | grep pgsteal
>     pgsteal_kswapd 0
>     pgsteal_direct 0
>     pgsteal_khugepaged 0
>     pgsteal_proactive 16283
>     pgsteal_anon 16283
>     pgsteal_file 0
> 
> Fixes: 68cd9050d871 ("mm: add swappiness= arg to memory.reclaim")
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I would put Fixes: b980077899ea ("mm: introduce per-node proactive
reclaim interface") instead. It wasn't a bug before that.

Probably warrants a stable CC for 6.16 as well since this is pretty
user-visible breakage.


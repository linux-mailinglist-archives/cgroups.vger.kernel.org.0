Return-Path: <cgroups+bounces-14903-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA4DAxctu2mRgAIAu9opvQ
	(envelope-from <cgroups+bounces-14903-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:54:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE52C3A7D
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7963028C0A
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7F330B2D;
	Wed, 18 Mar 2026 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Yu6FJ2LO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA42459DC
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874451; cv=none; b=YaTLbYEB/KjYGtJQpBQjhuLhJaSCQK5oII7iXngJhJ/YWugiz8NgRFvv2nfJOG7I5/q8aZd7oHNMjdzXzzMDufceAOHU3q2K3a/rKyWpxUkmqcS1kHUK/HeWGZ+TrGKOoj5qwWiHDh4A5orNLdjJ0WigfddVSs4jM1PvwSY2+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874451; c=relaxed/simple;
	bh=rRYJnyAWFPF7AoIupo3ZJeRw5l4Ugmp6cUwc8Y7dUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDXwTyLeOJEYzj29MwOhSPjY6RvbljQNq+sUvZBPxmqbDpDenhLGbZ2FR5ioPSfLOcxbwBLSdxDDN/xjZY+73P72PQXzToLELCtXl2tnRBDJsvX8yJQIX9Y8TZ7YSsWoB/7ScSriO1ZIUCSh5POyH4ipfw+qe37bRaBdRGdojQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Yu6FJ2LO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a000f5adeso6996796d6.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773874448; x=1774479248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3C6OkbYPe6oQrXzYVsFhDRac3t3GyQCJ31s/cMP59Y=;
        b=Yu6FJ2LONqs1hQFwz1cOzESGGbK74kXuYXASg8X9831MWYIiZoje8v0WF96toVHD16
         h16vjD+nE9g1Tjyg93hPD+gWxfmdMgUmKdLWa9ULJb7qJBRM+FZYgjVPnoV26q8lM00H
         X4fL4fqVHrU4Bmr3gOBIzonofervOYnsj8BDoHw7rc/9Pn/vhS3mQj/k+Oz/mfRm4TCH
         +KgMT5yE2aiHk4Seu0tH9wP9NMTwGfhVeNX9QU7Q9n7kb4M23UsThaNjDpJGy/fm7z5a
         0yy1G+W/f0h9CG+c4AnVdeGh5VEtz9RbsaU5G4exrCYjJ/pjITPJL3w8U8KY65q2+rJN
         NF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773874448; x=1774479248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3C6OkbYPe6oQrXzYVsFhDRac3t3GyQCJ31s/cMP59Y=;
        b=YI76ST7bKlcfQragvoAok6rgKBIRkVs+hsMpFgAjy8xfdxVOs6vHobfUk+8PBcNzNO
         fN6jdSXBWju9RgCigaqxm7JKEGi2CFjxpiTN1ruGUiaHb46nwoRegcUNwx72hdDvbaRC
         RRAU+pDMCwwfv7CW1fc52dbc/yc4x5dlJK2siXFjcignMZagxCit5zQQoaT+FLJHcKkM
         HMrv++guhgXbzC/utWiYl8KqBYvQiPgVOBJSJOK3doEi3Me3Or39JwPDWhhniQ66dnXB
         REqEXLHuLIO4Lpb97qtgWiVGcoTHysHOfWy/WiQDYHEXxU6d0GMNNT7eO1gQNO2oHfLy
         ocOw==
X-Forwarded-Encrypted: i=1; AJvYcCVvSwwWxB3PkxySxLUKi4TPl8poBjnucKNfcijh3mj7zn5hdUE3N3Fl/QgCKpz74B9i535j2Toe@vger.kernel.org
X-Gm-Message-State: AOJu0YwlS9DT45Vi0BhgWuEeBBEDDHpyro1eYJfK9opdT93Cqv6ucYTs
	d7KC6HwMvbGsodX5Urdd3uCmrPZF/Xdpjv4HKW7Qyd1q+guYaVkqTmbfkx0jJg4hKT0=
X-Gm-Gg: ATEYQzz2QwzsJHCRnSRnBS5pw47aUDpL07znYfTegeVMNy6ONeKp50XYx7cnCt68tPJ
	YL6ayB6n28cCKa4Hr9oB6sHle3IO0MtIydjS4lcDX4kIIXMyQ5RWXJm3P3+lTbfzfPf56LdZGni
	y8Kmiy4B/wkyuh3nYqLuDUqi7jZsxoJ8TEAcVGj3B89gB/CE7j+3OlDKJtPdTlx3DgqHzHvxwVX
	G+XA3PEPOfw/CS0h1/G0Xj3vl6zeanMpM/ynwXJ835SkalQG8xxJCbj8W6a0uIfQKJY2+fHNzeU
	1x2N5LHHERPeperlzN7V9VuWeM27hNcFIm2yFm0JbHTb2Q8A9XixZo7MmPJQ9WlF6ti0UV2cgM5
	VOhn2MTIPO27x1KK5PSXPIq+wVsAxdmiXcsTWMxJ6J+ICFYDPkmVIrVk44lcBmRoSUOkUFSaw11
	BZTRcn4e+RiGdw+rNRRGGTfw==
X-Received: by 2002:a05:6214:3308:b0:89a:443e:d43f with SMTP id 6a1803df08f44-89c6b56249cmr69999326d6.33.1773874448372;
        Wed, 18 Mar 2026 15:54:08 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9ce2absm31068786d6.25.2026.03.18.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:54:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:54:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Bing Jiao <bingjiao@google.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org,
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org,
	david@kernel.org, joshua.hahnjy@gmail.com, kasong@tencent.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	mhocko@kernel.org, muchun.song@linux.dev, nphamcs@gmail.com,
	rientjes@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	weixugc@google.com, yosry@kernel.org, youngjun.park@lge.com,
	yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3] mm/memcontrol: fix reclaim_options leak in
 try_charge_memcg()
Message-ID: <abstDuof91T5Tojv@cmpxchg.org>
References: <20260318215629.2849052-1-bingjiao@google.com>
 <20260318221957.2979346-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318221957.2979346-1-bingjiao@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14903-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BAE52C3A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:19:46PM +0000, Bing Jiao wrote:
> In try_charge_memcg(), the 'reclaim_options' variable is initialized
> once at the start of the function. However, the function contains a
> retry loop. If reclaim_options were modified during an iteration
> (e.g., by encountering a memsw limit), the modified state would
> persist into subsequent retries.
> 
> This leads to incorrect reclaim behavior. Specifically,
> MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> is reached. After reclaimation attemps, a subsequent retry may
> successfully charge memcg->memsw but fail on the memcg->memory charge.
> In this case, swapping should be permitted, but the carried-over state
> prevents it.
> 
> Fix by moving the initialization of 'reclaim_options' inside the
> retry loop, ensuring a clean state for every reclaim attempt.
> 
> Fixes: 6539cc053869 ("mm: memcontrol: fold mem_cgroup_do_charge()")
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


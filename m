Return-Path: <cgroups+bounces-16476-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIUIFcxNGmqI2wgAu9opvQ
	(envelope-from <cgroups+bounces-16476-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 04:39:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3160AF8B
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 04:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42112304CFF7
	for <lists+cgroups@lfdr.de>; Sat, 30 May 2026 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCE33689F;
	Sat, 30 May 2026 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTUaJj2F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136E23394B
	for <cgroups@vger.kernel.org>; Sat, 30 May 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780108688; cv=none; b=jLA6TFgMIUBqHNbYP1wibcR129uGjz7nI+lI47fRqiI80TtWi3xcNndfKRWjNHBbZVlDrQuiqo7WhJ+9alSkIP0b+HEbGweIGFH8nldvYfSeB+0elLNFlkETDEV/JyMxeV6m88VdNXiK7WbT/NY2K0OcWppcawiVvFAAKNXB1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780108688; c=relaxed/simple;
	bh=9J8XXv2zOyekSj0FycOqYPNaykPTCgIvDg8dALt2oas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsrH1nMEI2BK/p/8dwrpSsaNg21lxSEknVNa1Bq6QwIpty8ccsAbB0zd4VBwITWYwKezjHkd9X80nxtoP4vF67fZ1JkG5KMTBv0qXEoXwRn4zCjhxzjpGWnEFe+rAT+GuK1ZzLrXusoDk0gFz2+2xg34G7PBNBVGGBvwBiFCgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTUaJj2F; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso2456399666b.2
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780108685; x=1780713485; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xka95KubKnbbs2owwDRl8KytmLnYPZfdx9pjSujQuJo=;
        b=QTUaJj2FplmQvEPm+N9h0GaI7yzjeAzVo9QIoSQSIlPjZD94qv3u+ih57JkVUf8fkR
         9KYToD/LJyLKGpn59YoOCFlMNPifqy+EH3nvvbgmEk6Wh38RnlNXktBokmQOZ8sBLgH4
         5JLrDus7Y+CgHC9ekPrNuvJN/2YpPag24vjnJMddpGGyVvEOVTRxI1xBzpxSDWsGaEy4
         SZlgWgknxsBQaHNhhU3d+aa+P+D4JW9lFNk03yiLOD3mqeDqfrChAnUjT+4wemIu5n/j
         YPdGCFR+pFBUfoXH+LN8muMNptY3dVaKptq0LcRLHOAWjYMFVbVRTQHkkRi+i2CIaa35
         8XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780108685; x=1780713485;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xka95KubKnbbs2owwDRl8KytmLnYPZfdx9pjSujQuJo=;
        b=bTvcSFgLO+ia2/ohHYcYbnvhicC5si3isB95q24gPPjMy+Hgglns3nFdiPzR1nu1RO
         JsM9L1Jy4f8KEdbutQZKL5BSP4bw55PJKB1QnKQi8sM5uTUlIP9Hfej1RZ+pssWG1RXS
         KP/3dprGumnZEQ5qK85Sq/rKck1ZlM2y1SBygn/L3lUZ+5St7KxtVrRk6dajzl+m2uJr
         sQoMBeVqe92oyEyzhjedNHcS78n2A15li2i6Kp3wueZZDZSFomC9uxil00gM1UnW6S/H
         Xm3Z2NcNsHYWcaWJt086BADcy+LJA/QOu8K4Benv21JSNGZXTbEqy+kyexJVSdcOyUK8
         u9kg==
X-Forwarded-Encrypted: i=1; AFNElJ/+q/QZkaloL3F4zcl3e2grWG/6GfXxD7cYwOTWf5jMFuuBuc4xM+60eP95TT/H2d3W47diH2qB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6lCRgD5wJ6l4uWVAZS8XADbnS7BulPxrfh1F3/Ap4PB3JFSk
	8OMFWvGQL5yoY6RNxFmpnEmIgRivrl+3rlv6Y4EKZaCdA37j1FL7NKHv
X-Gm-Gg: Acq92OGvxBsSh69DR4Ay8DLF1ZTdrQD5N+hjD0K2fE4yFG0ZDdmKrPHxvUeyCO3kW0r
	LHMJ3gcHaKAVoBABqgg8kf7XUTI5o/krUqUyzPBcqs97m7CZJjBPGVwVjqXbKelM83A3LXmL/zM
	+7PkBGMxACY+pVnLgrlh3oywRlCtjYloAQwLbY6ah5utP05oawGc9gmI8mjbjKpyT/MJe8x6+Vg
	6SouAj3mKiGV3jB7GVWLpnyUptevuAb/bem6tCXR3TCrE5tgqO+LFDLDLx6YoCnwBvhtwSBgti8
	Keui9Y3FiNm2gNXeIJLLqmskPkeLwu94aQIgDPRHccGgyw3vy0vhi6WGsmD3BY3ot+JfcXOLGfl
	pxkRdBo0V/s7n7H/u9H/UdYRVpaP5y48tjDzmcmKbDzrDyKuXzlaDGYpNdaONypNXhLY/yYubcG
	P5OgLNa7SzKy86LZbYntdOlb6K0H1JqFxX
X-Received: by 2002:a17:907:d9e:b0:bd8:1c88:cfef with SMTP id a640c23a62f3a-beab394bc61mr117829566b.5.1780108684896;
        Fri, 29 May 2026 19:38:04 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d5cd7b15sm118510566b.39.2026.05.29.19.38.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2026 19:38:03 -0700 (PDT)
Date: Sat, 30 May 2026 02:38:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/9] mm: list_lru: fix set_shrinker_bit() call during
 race with cgroup deletion
Message-ID: <20260530023802.l5f6ywulxl2bpafg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527204757.2544958-2-hannes@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,cmpxchg.org:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-16476-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: B0A3160AF8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:45:08PM -0400, Johannes Weiner wrote:
>When list_lru_add() races with cgroup deletion, the shrinker bit is set
>on the wrong group and lost. This can cause a shrinker run to miss the
>cgroup that actually has the object.
>
>When the passed in memcg is dead, the function finds the first non-dead
>parent from the passed in memcg and adds the object there; but the
>shrinker bit is set on the memcg that was passed in.
>

This means we just miss to reclaim some obj, but won't crash the kernel.

>This bug is as old as the shrinker bitmap itself.
>
>Fix it by returning the "effective" memcg from the locking function, and
>have the caller use that.
>
>Fixes: fae91d6d8be5 ("mm/list_lru.c: set bit in memcg shrinker bitmap on first list_lru item appearance")
>Reported-by: Usama Arif <usama.arif@linux.dev>
>Reported-by: Sashiko
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

So we don't want to cc stable, right?

The fix looks right, so

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me


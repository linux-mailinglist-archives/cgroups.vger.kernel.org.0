Return-Path: <cgroups+bounces-16787-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hNqPFlNAKGoyBAMAu9opvQ
	(envelope-from <cgroups+bounces-16787-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 18:33:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAB6626B7
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 18:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=nj5hcN6J;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16787-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16787-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E58FD32738E1
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D0494A19;
	Tue,  9 Jun 2026 15:43:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866C49251A
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 15:42:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019779; cv=none; b=eqZ4WG46NwBY6/RifEltbybdv+ASdH7+e6BM3ZcKT6YxL0qwUl8EPa0VHpmf4p+fRncHQXHLfPLD1uHqbx1g/vKty3mfmpOJxhPv4SG4PLF4Xn8DJRjkcH2woY/+AbcVBBeNEU7f73ry7f8gK2zTqxmWTqz0pvrcPu81Hz0eux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019779; c=relaxed/simple;
	bh=IYTad2VMSstbrfqv+BvNe0iFG8zMHmrDimOGxJEiK/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR3daeIGw2LY6eKVQO7tnhoYGK4YbjnKqlYlBNMty9TbwAJ5qjX+cf6Ucz6WpMFzozsA5Ra0bYyUjPB3JWVCrnHGrpCfFn6C1mrDBazGA1wAxDhCqzxLggNDcZU+UUsFl9kfQdimdjVJhn8+77XoSPCTy0NIO+0M49SYNkFHT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nj5hcN6J; arc=none smtp.client-ip=209.85.222.49
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-963b7d9bf68so2072506241.3
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781019777; x=1781624577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m1lBs+cPKEi9J2sI7ojOxRGjTO3OcUCSuFxlAgPpsc=;
        b=nj5hcN6JlQJgOWYDLK4wfeASTCo43yQla1RhHtAEJHJzk6+vjVRDpXrNTIquWtLtCd
         HjBzwPdKkjjkRU7VKkLSQbGOsYvhGkkLGqFKcPjBv7R4JcAf6YTDugNIDtVxfWpSeT7I
         zeYMHyK+K3xp5v84NufOJ29Oz7itqDkYrA4sJwNJ/R3bfYgZIxuCCpl4Bn0b3GsSTrBF
         IJTqP24MIsOb0KCW2QSatNzD3gTFWyaqnh3WTH2iKqcY3PLT212IGggGxASaVWs2uagn
         E/vFrJh/dQNtu+kyuTvOzYwkxf5rTSzP/CQUEe99DCDEL1JrEIL3XYwtlUIYmcOsfkc5
         Q4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019777; x=1781624577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m1lBs+cPKEi9J2sI7ojOxRGjTO3OcUCSuFxlAgPpsc=;
        b=IxWv6RIKa2jikpxTFNq684+ZPwPj8FlEehqGvjtP43ZBAvUdggMpTjGpszIYjPNo/u
         u6V0F5/I01C+Vr7sTXxZpnQm1+9vIBIijkeX0JR+X5omxq9TjoaSYR8z3Z8wLqbWXjcO
         yBGspLt4qNRY7ogSKO5e4y6s9vuoe+V0rgzqYkHEBfABU/JlQ1LoyaP6umATxNjZ1siJ
         cJQDHYdjk+aAd+bxMi5d1eY+zf6lXbBbla6SBXAo6v1ataUcfP2ani5MfiWt8L5u31PV
         bH3274wwwSK87+xf6Uto+EmzqHI6Kf4heuwWRST2qCGs0hzYe/xtlUcJdlrmWauinW6X
         JMjA==
X-Forwarded-Encrypted: i=1; AFNElJ+C1IjUCcVlqKmTpybz5FY+92DuapP2rwWE0+bGTwfCJCYdtluE26NkCs0YMCmVnC5c08NEamd1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2pLwQrD7jrSFWHSA/T67za4pojC8zOUCd9KBh7LEaneGpDUL
	gwOtq6VU/LEkx+X93gHg67Jg+65cmKnW6CyiE9gVKACr4rdy8CUQe5GWMawuq0IoT0W0rZnCNlS
	u+uVG
X-Gm-Gg: Acq92OHIjkW5VR6b2w/Jfh0WGFqZoDbJwEPfAPLb0MNe9sYt5OrPHdWRjD/jLxli5+T
	V+G6LP9baknTZ71dFhr4u7iaC9DqXw+6GKlaKcq9lWFV9pYgAmlLtQcHaqwUvEEc8uKuFn7X8hl
	HtJvPwiTxxGVVIY3T1OOnU7fvWw056b6ICchfYn0zoe28eZNKeMm0IejjslDkiPJWq00cZ+bn9c
	43VePxOxZSPodfAdUBVDAtCtJzfF+93RoUuenHAUnboP4CzQfTKBnyuADM293Tvks3qH3yI8XQD
	1XOiHyBvwq1sfYsUUhP6MiO5A8hdyJshcBasrT1H0rJtRgSPZif9M+wK8JNLs1XnhUs5jIjW5cD
	lMpl4Wc5gz/BEJLr9106O3923OQ2ALUxiwBw2aH5PhGb75TeLTJY1BiGlyzJUFh/PyXGvZl7CYb
	raQGidvmHHRg2GXWH/ewJtku56rbVOSdbNdKIg6vP4+amrUNecWadNwj2omPB/PjaOKMMSG67pA
	rOV+KnpjfwKGT/TAw==
X-Received: by 2002:a05:6102:149a:b0:636:c0c:4d91 with SMTP id ada2fe7eead31-6ff07fd12f7mr12087727137.28.1781019776857;
        Tue, 09 Jun 2026 08:42:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb5e92sm205961926d6.11.2026.06.09.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:42:56 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:42:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, kernel-team@meta.com, longman@redhat.com,
	chenridong@huaweicloud.com, akpm@linux-foundation.org,
	david@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, rientjes@google.com, chrisl@kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
	youngjun.park@lge.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, ziy@nvidia.com
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and
 alloc_context nodemask
Message-ID: <aig0flBMN-sCCogW@gourry-fedora-PF4VCD3F>
References: <20260609002919.3967782-1-gourry@gourry.net>
 <aifDlU96HSRy72Rb@lucifer>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifDlU96HSRy72Rb@lucifer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-16787-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,nvidia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gourry.net:dkim,gourry.net:email,gourry.net:from_mime,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75EAB6626B7

On Tue, Jun 09, 2026 at 08:41:59AM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 08:29:19PM -0400, Gregory Price wrote:
> > The nodemasks in these structures may come from a variety of sources,
> > including tasks and cpusets - and should never be modified by any code
> > when being passed around inside another context.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Thanks for doing this, it's nice to gradually up our const correctness game
> (as much as C can ever be const correct :)
> 

I've actually been carrying this patch locally for about a year in the
private nodes work.  Sorry i didn't send it sooner.  There is likely
more work to be done here.

> LGTM, builds locally too, so:
> 
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> 


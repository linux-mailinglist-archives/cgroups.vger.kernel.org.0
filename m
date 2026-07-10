Return-Path: <cgroups+bounces-17650-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z8++M33lUGpn8AIAu9opvQ
	(envelope-from <cgroups+bounces-17650-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 14:28:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394273AC71
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 14:28:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=WuzurDSK;
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17650-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17650-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A2383009547
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3A403B10;
	Fri, 10 Jul 2026 12:21:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FA3101D8
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 12:21:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686112; cv=none; b=YHXhbr6UYnYKdzUkCpHYN8Ch+mrTKSBEaJLWVtaTBVMksVXvYl3/LK8EwRbf9uAXPCbeKjz9fGEl4vAWLtlExPJ/5lYcaPG3YpcLY3md1MVSmgbeqPC4b1pX4z3ESzBci+xtoUGuiuaeAXR7RHm4nP4GRGQIvk8aN8qv2yyIkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686112; c=relaxed/simple;
	bh=og0WJvzzd8vztnMZeGma+I2G3E/LjkJGGM51YXdhWLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7+SjrhKl76QkqPN96MfFSMUvbzwptBAozgCbYTtTgxU2XOr8MVrJwHQn2Kkh+46UzmIfXH4tl4lxk/s0xCwvamyv3u7rztTocJGxve1/JP8NxGNN1IAXCtUM9ecETAbPWtZ0tgKumJwFc8HWESVVRHdXpWUyPFzGS7ojpLcxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=WuzurDSK; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfbe05683so4629491cf.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783686109; x=1784290909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pnykIrs/H9V/9TFzopaasthMan7ew7i/OfjNhpwuS2U=;
        b=WuzurDSKqs4lbrTpICWlSzLK2XOdWACjrOYKPQrfwvLAZJENqBCSl3SehACHDX3HIr
         COfKR41Jvb2+l2B1er9liPOA1U0Fr1aUgujmg+B46vk9rvtJZ0NAK3vVV/4KF15hnVnf
         T3pPGkUhQoRYC7+RVez6ROpZj1kMMvftcp/Waemp/UT2JT5fUfL8B/442LtDWGqtk4lf
         ABR5NbnBF6/xZfJf9PYxiQ3M/UMFSZVfYS5cNhgz8c1TMVBxXgqYd1wZyeurgUYKZn7n
         25hJWm670Ixdc/1LrsvfBWxFZUO1H1yUlEZThSHaeNkZYvwmDPnCTKscvYa5JpgRcI8+
         OrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686109; x=1784290909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnykIrs/H9V/9TFzopaasthMan7ew7i/OfjNhpwuS2U=;
        b=POTUXSrnVbSJza3A/bJeoHpTejikzbpD8LBvncoExEnKTFA7/G8ZAIvk2p6XHEih8e
         VkNarJZtMuMjlJUuIUZHZ12/nQRl6YsVIEG0b/4TfII9BJaEMTbmrTuaCykVJZuh8sFO
         PjaHGc6+S/Sgl2Kzk6jt6ENpe73LaXU8SECEsHQLJcnZM73F7FyqpBLnm+ND5eSkhiyY
         1FVJpyjFZIOeDq3o5jPxo533efF8vl7SNAEPn0UnHP4qltPGuhF8hLVKYmkGerFo0GyH
         O0xWBmUlyw3mbRfPVC49fhm0NhU6pJ0a969yJy/cSN9Y9u2mwIgPJhUdUEFOYoJxD92f
         xGjw==
X-Forwarded-Encrypted: i=1; AHgh+RpoxZRZMeIKxlYJIbzrD/ACHgQemcx2TcuIB0zBj1fx1lSee9ir30EFoznM/77YGUxm3FYv0w0j@vger.kernel.org
X-Gm-Message-State: AOJu0YzqpUBNBr9fNUtwC7yXlyMPVpe5hBXno/eE099heUxlTY7ZDc3q
	5OEBQduZUkSUvydGB7Lf0mPGoq3ZgsWxsHQW4jlrZ1nRnXbcaYm2MJIscn/mj7ZIMxw=
X-Gm-Gg: AfdE7clM9jpIlGvELufRyddDEjDkeztTwii0/W6U6SfSlYwadRA6yq0pnYxJkwGm20F
	I1dCJJ16hP0+WzxooV3lzJjzxzwbrB/tEEEe/itRoeeIkQsIEsLPfbZx28jJ/e8BHaYa2WmsJkt
	VW/214x6SiOE/DAaWsCE0/3nfQEdd6L+l4BTYxnz1lkmAq9R3kDM+FJ+cP1YGBZsEAbphAHcpib
	XH4CwSknqOe3dsbnZM7A+FV0wDQALaAkt2h7vjkevCTbrwnJ4fR/aC26/xGJ/EbxrBnEVAVGNkB
	I6ORMdyVbr2jij3JY55ljhaH9I1XiVhh2U6+nbDKm4y33KvyLkcTIUzpfMpWESBL+Mnuo4PkpQM
	YssbUJM/ceUTDkw+baIXWWNhK0DKYN1IhPk1hyUgJcTxJ1LRHbMPJHUp32kZhS998IwPGOSsbdS
	oHyRuaBXSgxzo=
X-Received: by 2002:a05:622a:c08:b0:51c:12bf:d4a3 with SMTP id d75a77b69052e-51c8b3c683fmr122768331cf.52.1783686109180;
        Fri, 10 Jul 2026 05:21:49 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d22bsm39699356d6.32.2026.07.10.05.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:21:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 08:21:45 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ridong <ridong.chen@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH -next] memcg: move mem_cgroup_swappiness to memcontrol.h
Message-ID: <alDj2VzbpxT-I74e@cmpxchg.org>
References: <20260710111224.2355668-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710111224.2355668-1-ridong.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17650-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,lge.com,vger.kernel.org,kvack.org,xiaomi.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xiaomi.com:email,cmpxchg.org:from_mime,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4394273AC71

On Fri, Jul 10, 2026 at 07:12:24PM +0800, Ridong wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> The per-memcg swappiness knob is v1-only; v2 always uses global
> vm_swappiness and ignores the per-cgroup field.
> 
> Guard memcg->swappiness with CONFIG_MEMCG_V1, and move the helper
> to memcontrol.h where it belongs.
> 
> No functional change for v1; v2-only kernels drop the unused field.
> 
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


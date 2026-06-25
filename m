Return-Path: <cgroups+bounces-17289-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxbIBI4nPWoZyAgAu9opvQ
	(envelope-from <cgroups+bounces-17289-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 15:05:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8D6C5E14
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 15:05:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=Tfcyr62c;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17289-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17289-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9618301693F
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2791D89F4;
	Thu, 25 Jun 2026 13:00:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E5221723
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 13:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392411; cv=none; b=lXg1M3vwh0Gxr3/92abRxkn/qkyzcFunguRosVUU9k1gBr9nFI26rEQiyMIj/LSRJLyM+wVnCkS9sh3lHc0Amr0eYKzwogUhvd3qzqXQtQ+pAH0qND+FYlGRT8cs+yIhtxZmgB5RKQ5FzfQJMGAJTO9UzL7MwcK+DrV80Bn8zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392411; c=relaxed/simple;
	bh=bCw3MIqx3g0NUFGvKXHpmcRdrQ/MWTJ2UV4eNsCAY0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQQSRogHZE2XIZSMVMQfl7wpq+/GfUZvWxj2xOvIaqbftg0Sglabo91KsXcuVLx1vX4QH/4WdZVcgxGqFqa+uNzuae4DvnbtAbCJJ0Z4C54v2DcRZUeuw7hjwK65bIvMZaubWaA/DQQu8bDKgQOT655nafHRJkeYGiH3Z1KW0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Tfcyr62c; arc=none smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51758478240so12197971cf.2
        for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782392408; x=1782997208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E7xhSxqesBGvRNciE8rd995p49J3l/FL5kNnGzEtQI=;
        b=Tfcyr62cxJDHGGn7N55w7M28TIXd0HwQj6wYILiCTPn/Yq4HSPEXp7Ed4N8Ij8Udup
         Md0a8YmISVjgzeVtB+3+ZKK/7aGxI+QxVdVRO103l5rv0CkPp8CrmteMvK9vfdFkSadU
         7iGV1qZ68iuz4lLZTMEmekVOTm+1mHyQaFvUXfiXa+iPhwwA2duOpFVHFyRR2rMh4VDK
         kZZblM3v1eQErjr/O5qB5zuXov2EIJ8ogzel9UHoUngt5iXY2B1eYvu4O8fRhnvZ3T/e
         kw0hqQ+9UA/JLX0IOQYs3O4+OuLhwp9u/NfUVpkDa+HxA+UWvcsklRQkn+DNqqRsGXuM
         cItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782392408; x=1782997208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E7xhSxqesBGvRNciE8rd995p49J3l/FL5kNnGzEtQI=;
        b=tECje3RP0mpxoqtG/iAC89/rHd9W1rQh03ZHMGQ0jQrtYLOJZbE37KX+Z8lxPhvGPN
         Rv+vGi04NJFuPcVk64wlcTqZTVx2bby61c8iclJRWpWBnIlCSVr32+joLmf0rYN7TbS/
         /NU94nbSHWTc4Gei9yu4KpQIMklTzVp9cnivLH+rpGM1ZSReDs2s+zILF/qkILm/T9e9
         rmRCNYEu5G4P6S7TubOQQHCZ4zpD4O4oU/Zn6BlE34HVGdEc9dtl8dV0XHrKjgLbUlar
         cgpC4YtqYdEzl1rhom0zBWdtruwrfcV4JOj0GW7IWLqrVSFDRM0DaH6BkFfOVwA7exI2
         7VnQ==
X-Forwarded-Encrypted: i=1; AFNElJ81JTwjuocOS6UczEoU960Y+QN2kvg5yixupPeKpWhQZ2A8PsaWb3l28v7KoaHlr7uuhPNrkxCX@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXpP54BMzoT+AkROAtQwkr243Z1iw4vCU51Lz6IpqnDnZsJE/
	Nbd7pZe8Gj+R/9xoakzLwGbiGUumAM0LZ+FTSvftXqmm1eglFFIw7J0UpA/rROwo31Y=
X-Gm-Gg: AfdE7clcKyMACU2vRYAMtB7LPimiZ7oesOPZgp8v6TGfCmJaH4mR0CZs3erV7K9EN6t
	54G4ra67YGG6pZ4Xn9MVGASww9Ty54Jenbo+bA+armcq7DLKxDM4bGCNkydMMobL3VibW+maUmz
	yPe3SwbIAkP4M26QIuA77wzVclqgo80aCG1c9d4hqXignYVFJTj1mf0f6LN9uLxTGBsPwItAv2p
	bQ5RK7OYJqsWYLOOusb4pzaVVO/1qO83wXKHV7taSj7qMo8eKHDLcotMr7mG7n94mntBCWIxgxF
	gQwaYO69Y8qnm7bqST9bifcVxRrs6N61OO7e/cvyqXQ3nntusim9xd6wDf8AolRguF73WVSnXDS
	vLfY5LgxLAdm6juerlKYQoSTuT5NCmnJ2jLjGjPN3ybMb805xCaltAYfXoAHOBq5A5J7guRWak/
	Darw1+kUDTdQE=
X-Received: by 2002:ac8:5f8e:0:b0:50d:65ec:a071 with SMTP id d75a77b69052e-51a726f933cmr29001281cf.5.1782392406263;
        Thu, 25 Jun 2026 06:00:06 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a657f7b2esm34801631cf.30.2026.06.25.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:00:05 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:00:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@kvger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/memcontrol: remove unused for_each_mem_cgroup macro
 and cleanup
Message-ID: <aj0mUeI_8t04Y4fj@cmpxchg.org>
References: <20260624183700.1152742-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624183700.1152742-1-joshua.hahnjy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17289-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:linux-mm@kvack.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@kvger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD8D6C5E14

On Wed, Jun 24, 2026 at 11:36:59AM -0700, Joshua Hahn wrote:
> Commit 7e1c0d6f58207 ("memcg: switch lruvec stats to rstat") removed the
> last caller of for_each_mem_cgroup back in 2021, and there have not been
> any new callers since. Remove the macro.
> 
> A comment in mem_cgroup_css_online has also been out of date since 2021,
> when 2bfd36374edd9 ("mm: vmscan: consolidate shrinker_maps handling
> code") open-coded the for_each_mem_cgroup iterator. Update the comment.
> 
> Finally, 99430ab8b804c ("mm: introduce BPF kfuncs to access memcg
> statistics and events") added a second declaration for memcg_events to
> include/linux/memcontrol.h, duplicating the one in mm/memcontrol-v1.h.
> Let's clean that up too.
> 
> No functional changes intended.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


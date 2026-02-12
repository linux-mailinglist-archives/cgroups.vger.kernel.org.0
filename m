Return-Path: <cgroups+bounces-13885-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A5oNXeBjWn93QAAu9opvQ
	(envelope-from <cgroups+bounces-13885-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:29:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B612AF45
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B526D302922B
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5C2C026A;
	Thu, 12 Feb 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VT0kJMof"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCC2BEC3A
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770881397; cv=none; b=HmTXvHv85Ne9cfsNn2GeqltqHJ+aJT5TLeWCjDcrd25oXySQYmKRfymCeLW3fS3I/HzxHi3ZLkXxfcH1iA+PBE8w/HzJ7RCoLd/a831iKoccipHXZU4vg6dz7D+R1ACSp1Br+vKlYw5JpHoEkr307hUFJM4UH+4wL9Vq8k6IbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770881397; c=relaxed/simple;
	bh=zO+hFB/XNykEPmOHYVCIykOgF/5FeY/JtT1N8MAYZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frmjd5a23035RTTN7RksW+mLdlxicdJudgvfSEDCg1QjbwiClsHga7TJx7hy9er+2FS31WUP7GJvdSwRBvkoDol5mwvr8xrlS8Td7mnyHI1Vk5X83e8bNr+3GdBlt2+Vb2ReGp99Rj0xPB60XaolsSBpIn17I7CFnFyRGEMmckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VT0kJMof; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so62393965e9.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770881395; x=1771486195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2O6Sm0cEIfahlqGv931PH2G0tMd8cyKa75kNbunAo0=;
        b=VT0kJMoflPPvqv4RbltG2eTrEmIbaaSpmNP6skafFkxNf1jOL5e2IuyWJJ5W/cecx7
         xIXmtcVBdohqGfSHsZ9q5H/udTnmbGp1bmjKgy2kjzkFyzlQOEI7GxxcIVtW/bTb1UhQ
         dF99cjaaT/HoVpYo6a26oroxAlmnouV42Hu3YwO9x8QiCblmE7F8wU6Y34FYt+MzDdFy
         uMyi8mknsyeUKiQf2OihfTqUBQwQr3HeGpDz+F9rU9dMIaxj5dElbpm4p1joLRMnWh9G
         tIG4hrUlf2gClYxOABe335aV/OvIzwguWkgyFvpprnHZijoqKnxl4o6m4iSBinCOMfXh
         zEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770881395; x=1771486195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2O6Sm0cEIfahlqGv931PH2G0tMd8cyKa75kNbunAo0=;
        b=uC+aN3w3OZplos58904LPWDo05wY8OpbAaSvmqftmaeOMjwKBenWCvcbTSOWCBOqzG
         7N16MA+dKVFrhiyQ6JQOHKgMg7G3coLnEmfS/hyl5idLyJsS98O+CshCTY4cn4847Ufp
         MvQmsXnDLBQlX3oAUh+BA85+1RiwVGcn1xLTqbgyEmuPoXAaLCPLi3c7h0VbAWV7KfC4
         /MIyDDig+r7eeSAN66GwAW0Py8+2GK7MgOQH5VtdVohwKxpYKlghuPKq0WtvtXTB7VYO
         cqbiW6kM23arinsKUV9uEuaehxYZsSJkLZA/wu2G/EmTu6JmIKIr8IpWkdg0uLC8OiMn
         4k9w==
X-Forwarded-Encrypted: i=1; AJvYcCXrX2kErGR4o+kYuhWbKSvPcezE4nHdFujmxMVIjI7iJXkmF6KXg7trVP3IfHUQJIlfaSyq9JyF@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLVnYPnfUjJwIUs8uw/glgY2A2r6gLpzgT0JnqJKK6NeolEIK
	818EohXCYFah4jOrtABvD3JDT6WcwNaL2wz8+WLssA/v1k1aH3c/bXKjBieSVDHWCjE=
X-Gm-Gg: AZuq6aJ4BhKg5+NJI2U/EY1z84uZ1yhHP8LaYs4qbj2YlZVbPvLrUs4/cv019DMbjuS
	VA/X13+pso7ftwimq/XOmydPLYDnSJXK3tokFPAnacSg8K1Rj9dsxCczD4Ru7f5qN5AiKKIR0Pg
	s5gVPlCw6LAcipLjsphFVYGyFodDk5tDA/W+4Pob+4cZu8k31xC0ox3t6D4xbf4ehSFBuIWK71/
	nGE+376oSjaZ9DoqJtKvekdjKWuG/rCbxFDBtXs/rSdJGAjt1uk82Gjrc92zvJfaPRQrFcwNezS
	Y8MYe1xQfntNjmNrAZEc27nqnNcEwMT/VzcwvR7cQ4GsH+ZiGAdVwh6F1AjSM77A0fakSFKHpm4
	81ffz/JpDeZTULoR5HOrZdyGX2tectJCaBAtod5fsbR3nb1IJrOtM25yXAALwoHheEa7EVFBmX2
	Fyo75tRQWuwO1DaMgnySnaRVk5cRtRlsYCh1lY
X-Received: by 2002:a05:600c:3b1f:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483656ae4a3mr22015335e9.6.1770881394566;
        Wed, 11 Feb 2026 23:29:54 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e0ed5sm164667535e9.5.2026.02.11.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:29:54 -0800 (PST)
Date: Thu, 12 Feb 2026 08:29:52 +0100
From: Michal Hocko <mhocko@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aY2BcIHIARSwwQpo@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212045109.255391-2-inwardvessel@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13885-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 790B612AF45
X-Rspamd-Action: no action

On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> It would be useful to see a breakdown of allocations to understand which
> NUMA policies are driving them. For example, when investigating memory
> pressure, having policy-specific counts could show that allocations were
> bound to the affected node (via MPOL_BIND).
> 
> Add per-policy page allocation counters as new node stat items. These
> counters can provide correlation between a mempolicy and pressure on a
> given node.

Could you be more specific how exactly do you plan to use those
counters?

-- 
Michal Hocko
SUSE Labs


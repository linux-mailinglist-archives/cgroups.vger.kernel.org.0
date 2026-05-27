Return-Path: <cgroups+bounces-16364-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPMdJttBF2p8+wcAu9opvQ
	(envelope-from <cgroups+bounces-16364-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 21:11:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82765E9613
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 21:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D27305D854
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65D364927;
	Wed, 27 May 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLaDRtSg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sfz1h2uT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE031364939
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909058; cv=none; b=QDVX/RDKSrV4ZLjtll3ZdWKE44MGxuB7wxP9pN2NgZ+mtXkfIM9eDXNJod1dTMP3vYtqpGM0ZmEnMBWAlwtbp4EKlrWhBsnZFTB9apceHDdYcnkVv8WwUb2YpsE4db9cxIt2kGNMIqfo30VQ9QRtaDlFaGHGJG7/xeSYIdDqSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909058; c=relaxed/simple;
	bh=nAP+UkwFMeiPRtMLEhgLbQeO3ddCP9DTym3xnAPg2B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt3AZt1b2zyLAzw4NGlX7JyLuSFMSNhgfDPYkT3LN8Tz7AxJvccwAnXb865x5ktaE3olD+seStLpkGpfXYnppWg10+MOft7ZpEZPW8COL0tARN18UqdjrWY9zhETgRp/eDR+DYGISgC0ogPJPTM/CbVj16wqE7gtLaU/Hk2GC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLaDRtSg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sfz1h2uT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779909056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOfRGPugae13jAxurJtrxuSo8jWBso3MtJfxNQrI0Jc=;
	b=gLaDRtSgDNmD6v2LjKuZ0Ct5hDQYgz4hbfzk+VOPrur0nkDgSF15yXIDWQD2ZluoMlLx5V
	Y0j3mLgW4ihpzIz561U8SZ6cyiUC/5MaTg2ysMrsjysTeg8QEGhDEXwxl31Tydlps+LaHb
	3fs+rrMYPA2km1bMv23RwjHFFfIYTGI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-OedKP-U3P46mWuhY-jHUsA-1; Wed, 27 May 2026 15:10:50 -0400
X-MC-Unique: OedKP-U3P46mWuhY-jHUsA-1
X-Mimecast-MFC-AGG-ID: OedKP-U3P46mWuhY-jHUsA_1779909050
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514551d5f2aso35845751cf.2
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779909050; x=1780513850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOfRGPugae13jAxurJtrxuSo8jWBso3MtJfxNQrI0Jc=;
        b=sfz1h2uTS5r8ZVhzp3aKesp7EAZAfH3UbsW1sI2NyYs7CIylEt5niUhX2qj/X/xTCK
         Am9PBuwFlJ6txCYqkUXBzaiSDntjA1e3TgirmogUimEf2GNn/C8wTmRCacYylRy1UIUK
         SvMjAZcKBrQLnkj7kMQKcMuRWhNNmMH0+JyijRKiZJV8K2BU/fu5dwXUzS0vdECWT/0x
         LYbtt1TzW7RFmp+lVrrBuNmilhFjK6wb7lsmVo77yur8IufKReR08ygks+j+tx+VjVk6
         WHDl4CDOZKHxsi9a8w1pJW+TrsRiX9L1KOpSz0+PIbwEP3VGCjpohtktgV1driGm8u1Y
         VdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909050; x=1780513850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOfRGPugae13jAxurJtrxuSo8jWBso3MtJfxNQrI0Jc=;
        b=GZME0ulzzjhmszrChfZAnednfQP2ctWT4y9cNzhr+FoIJ45AMInNXEWb1iwwHJ/cZA
         oiQtm+r/RZwcdZ/yCsRnb2x+t/qeI7nbsFy5Xjzm2ofc2GqVy+UeeeUzb5EURMGfzq1c
         t+8Jydhub5CpPzrEs/zYcELlCgiy7oC9MQOVOF5kYS/F8W45ARb+suBN1Ex87So/G0a3
         eacFOKcJzWZMaimx6udWgDt0E9vQma76g6tmCJzhT3j/NIUpYdzuiPPfVVU77q5jSrUW
         Am+Sqssy77CxR9IBMmt7PZb3bJNwEh+NDY5/TgcJxJqNaN5b300DvLx2JDeaF3euOUVy
         0HLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+538YmiSIIADpq8a6fNWEN190RcysLOsLrugjUlALpLIbuXg/L12vbzHyiqfJQsIa3IxDGj+kd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/rXnRenT4WOp8odbGMKH+aSV7SGSEtDzngzeRwszr2Wh5j2v
	wf9OER9HTB24qLhy4O9R+WsPlJAy1VK6G9ANcTQ7BDRezr/K2WaXwezn8wQx68GenLDhJhOy4zr
	XROL7rpZSyG/VV4Em/6GSuBkEG6zpdMqG7VjVeBhzaZJKJSfWkupueodzXWc=
X-Gm-Gg: Acq92OG04z58E4vpzm9aPuCp1FzV0F0ZWouMkXCr0GQ3fxDZP2XCwntbca28udHjvE4
	BMkG0LncN9Aom7CJzOLe/ly5NEzPqel7n8RbWuIU0YXto+3QqECImh2ogWYDTS/CY3lekFhNMpW
	mx5i02sLPq/ftLJd9G4KaUt+IEwZMOy2pXTINPH2V7oHkba6jTA1GUno4K7IKQYyfP75Q/lavbo
	tjk/r3V5a5Nn8LOyFwRIHt4rdld0Mn6/q2+XJ0A8yAXpaof1bpRoqbV0avA3X3qV38Y1pUOpcR2
	d2Sohtl5LsoFyQ8Dq0ov9g+QMflEpvDjjut2PxXF0Kj9qSqFAKEJkcK2jf46CYVFZ+sXcEDSbiZ
	WSoLiOVFnMZeKL2oDYYbQoqFesOXVB7+KZ3K9khTmtyood4Z8IrspA6TEcawXSJsxb/WQ44poXk
	En
X-Received: by 2002:a05:622a:2d5:b0:516:4fc0:27ac with SMTP id d75a77b69052e-516d43e4561mr348875551cf.50.1779909049491;
        Wed, 27 May 2026 12:10:49 -0700 (PDT)
X-Received: by 2002:a05:622a:2d5:b0:516:4fc0:27ac with SMTP id d75a77b69052e-516d43e4561mr348874431cf.50.1779909048607;
        Wed, 27 May 2026 12:10:48 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc8f3sm51751971cf.18.2026.05.27.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:10:47 -0700 (PDT)
Date: Wed, 27 May 2026 15:10:47 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahWfypvuTVsB-pHQ@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahB7pCu_G4vuswc0@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16364-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E82765E9613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 08:53:10AM -0700, Shakeel Butt wrote:
> On Tue, May 19, 2026 at 11:59:01AM -0400, Eric Chanudet wrote:
> > Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
> > dmem pool allocations to optionally be double-charged against the memory
> > controller. Take the struct cgroup from the dmem pool's css as there is
> > no convenient object exported to represent these allocations. These will
> > resolve the effective memory css from that cgroup and perform the
> > charge.
> > 
> > Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
> > dmem charge visible.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  include/linux/memcontrol.h | 16 ++++++++++++
> >  mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920293e14920290fe7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -39,6 +39,7 @@ enum memcg_stat_item {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMEM,
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > @@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
> > +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> > +			    gfp_t gfp_mask);
> > +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages);
> > +#else
> > +static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
> > +					  unsigned int nr_pages, gfp_t gfp_mask)
> 
> Please follow Johannes's request to pass the actually memory object instead of
> naked numbers.

Sorry, I misunderstood Johannes' comment. I am not sure what to use
here. Since these are called from dmem.c, they don't have access to what
was allocated.

Looking at zswap, it uses obj_cgroup. I thought of resolving the
obj_cgroup from dmem_cgroup_try_charge and keep it in the
dmem_cgroup_pool_state, but that made me realize there is a catch with
this patch set, with something like:
A: +memory{max:32M}/+dmem
A/B: +memory{max:16M}

It gets the CSS from the dmem's cgroup with
  cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
  mem_cgroup_from_css(mem_css);

Which would resolve to A's memcg and not enforce the memory.max limit
set in B when dmem.memcg is set for that region.

-- 
Eric Chanudet



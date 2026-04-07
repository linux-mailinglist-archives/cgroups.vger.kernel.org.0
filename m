Return-Path: <cgroups+bounces-15190-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOWCEeeU1WkK7wcAu9opvQ
	(envelope-from <cgroups+bounces-15190-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 01:36:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC13B57A3
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428D33007C9D
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 23:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC037F01B;
	Tue,  7 Apr 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzwV2I2n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTHezU2E"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE29265606
	for <cgroups@vger.kernel.org>; Tue,  7 Apr 2026 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604963; cv=none; b=OWJmy9i0JJ9xQZhbDQQshRutIwO9/SnlXqCqw4NmyBI4Aob2rq8YGt8r+GF3SMn6m8RB391ppKTKftGQM6XzjtGIRWy7JK64xZrI7YUEuXtZ5OKfEL2KLjc6QQ+fiUo0ByknR+EE1KlD6SdM62AMrJoUQ69Ibx7I0ZPk15RTpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604963; c=relaxed/simple;
	bh=J2rNnxlWqh3SsVU6sZOyJgU6R/+22IABqsvYI8Pw4F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWT+sBgY/8uRYUs7PMXTUJYGVltvCdQXxlEthglHtFWDUzJbVM/nV7OFj4GLrnxKWjjj8Kt6sAzUxWHA0eXXRvV8CzKjdsGdyoj7JjcYj79LYAq/2Vpsz3o77af/2aii6kHOPhnHfILyNyJkiu5UegzTEizPwQ92Rfaz/whxlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzwV2I2n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTHezU2E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775604961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSte9vRO1TSshWcFHdBwTd4rL0Ri6sBQhlLf+reom5g=;
	b=gzwV2I2ncUaqe4+QeLgjoWkgtjPeLfmFpCTr4rwSDxK4lI4btnWMqUO++NzW1aPp4fp8Ow
	WP8R4m4Jnvezxs8mFvTp60v/XkbRv16gtk2CR58hFskdBBfdyVr21kon4pDLTIVBCGJhjL
	1wglG0RCTCdDy3ecrqUPW8SFVaGvM7E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-qQOKxbzPOX2cGtw6k9TAGQ-1; Tue, 07 Apr 2026 19:36:00 -0400
X-MC-Unique: qQOKxbzPOX2cGtw6k9TAGQ-1
X-Mimecast-MFC-AGG-ID: qQOKxbzPOX2cGtw6k9TAGQ_1775604959
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b52a2d70cso136579431cf.3
        for <cgroups@vger.kernel.org>; Tue, 07 Apr 2026 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775604959; x=1776209759; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSte9vRO1TSshWcFHdBwTd4rL0Ri6sBQhlLf+reom5g=;
        b=VTHezU2ERa5vLLY1bNeRrOzjrI3k7jPjHqDkuhy977AZgKMX8vzZxMkRgRmkdRztku
         kLW9bB1QuZiG0zCJLyAdOLLxHK9NlKKVJlBs9LGZCyP3fYYUivkYgJzr03aN4relF+1P
         WISzyba4RUH33eJHz53k7aBSMgBUf3txEjYcS3yPxIbhN026dCU/aeXivz5rf99BntKf
         H4o1BfJuLqsT1mAcFXnN4Q8LWouYO6lZCDKB1LQ5xAXZJG02plu6ZJzkr7C0qMiWwIID
         3MzPe516YkSSn0m458wmlve/0tADo9W6XmH1sW1tLfhtEN5xk7gnrWS9vuheYNcB3geX
         aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604959; x=1776209759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSte9vRO1TSshWcFHdBwTd4rL0Ri6sBQhlLf+reom5g=;
        b=l3Ie72V6POxKIZFD57cpNBUA8Aklg1HmO3IAHGKGCJQfsxm9VZQ3DDK/+dnHH2O8Cv
         NlANU6XK5qUFZeS+KdefsQnrrlrXXGU+81h5tjnIOzy98Fx4U17N08Wmj/wYE5zIF9GA
         d9NqlrUmDYUnd63zsV146vW187onZuoufwM2vsrosLg3PQwopLeYoyCl5dTtj+lyBCdF
         FCmHHuOdzc+ceYwVzI9FFiojkT6jkaoGg5i8RTZEC2DruTFXUT7jPZD4/2gR6hRYdf7f
         fSNu5BIviRSvtXub9n5vpw89KoHaF+x+65JNQ2Xs+OIwyamLu87++16tw0S9vsuJfAL/
         GisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI+xaYBjR7ILErp/u/2XmTIATp0X3+fhJy01Smqx5LKEsipAWbGFZgNMLDXF8NUiRZpuO3IBPE@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0CtCitVUl3ScWp83z6DVMr15Xvq3pG5YEQWoCoTvxIHcocm0
	8jeuTu10HL5vbYF+Sy7qY5uzXZJbR26+TJGKLzwM9hgPry5AY5YqNPmBP+76U/+bpw2zvCYyn/F
	QHiHyB23SEduSEJZzbbkCUkBeIzxazym3HKI4JfLa82tRpJkIsUc1jVL8jsU=
X-Gm-Gg: AeBDievCNDRMs9APr/xevypP7fA0SpAhpXmahlrgNnX71AGNtOnN03WMjnLK4lg2eot
	27MPDyYXAqNauyTgCZkxdrGnV2usLipTWeHP88oViei3oy7oxLdL4hwSMe3v5FZtM6YX3C4Wav7
	8LoyAPpclLvYFjIycUJUOkYxr8+SH8xQA5lnrL5fZOWdlunlz+vIRGgyJsBOh0k5dagSCzQNWZz
	8vSR4MVKDmZMqH7pZ9zQynX4AsypHo8c5L+NSTEc2oGLxnnCIaelWKuNRPdyJtoUNxpvHbU1uiY
	aK1+gJO8J/hPXcSrzTwm3IVBHlCH2ImWw66/qVPUWRKBSZSzdigxOdyyx5tuTDoEeHHtplvYRoF
	KyZMcrTVMmS0iipOmbpNJq+zyWlHtrYXhm2s5ACTQdxFEmikUifRCWCcv+QEuhsw=
X-Received: by 2002:ac8:7e89:0:b0:50b:41b7:d6c2 with SMTP id d75a77b69052e-50d62ad8295mr291701021cf.47.1775604959231;
        Tue, 07 Apr 2026 16:35:59 -0700 (PDT)
X-Received: by 2002:ac8:7e89:0:b0:50b:41b7:d6c2 with SMTP id d75a77b69052e-50d62ad8295mr291700461cf.47.1775604958598;
        Tue, 07 Apr 2026 16:35:58 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net. [100.17.19.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d5ea136a1sm129517281cf.25.2026.04.07.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:35:56 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:35:54 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
Message-ID: <adUVZ-i3Ot3R07Lq@x1nano>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
 <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-15190-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1BC13B57A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:48:05PM +0200, Michal Koutný wrote:
> Hi.
> 
> On Fri, Apr 03, 2026 at 10:08:36AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> > Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
> > controlled region also be charged in memcg.
> > 
> > This is disabled by default and requires the administrator to configure
> > it through the cgroupfs before the first charge occurs.
> 
> This somehow dropped the reason from [1] that this should be per-cgroup
> controllable. Is that still valid? (Otherwise, I'd ask why not make this
> a simple boot cmdline parameter like cgroup.memory=nokmem.)

[1] argued it should be controllable per dmem region more than per
cgroup. For example, a cgroup configured +memory and +dmem with one
region charging only dmem and the other double charging memcg and dmem.

cgroup.memory=nokmem karg would double charge all or none of the regions
for all cgroups iiuc. So maybe just make memcg CFTYPE_ONLY_ON_ROOT and
inherit that configuration in all children would do?

> > @@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
> >  		return;
> >  
> >  	page_counter_uncharge(&pool->cnt, size);
> > +
> > +	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(pool->cs->css.cgroup);
> 
> This is not necessarily same memcg as when the dmem was charged via
> current (imagine dmem controller to depth N, but memcg only to N-1;
> charge, then memcg is enabled up to N so this would attempt uncharge
> from new memcg at level N, possibly going negative).
> 
> There is a question whether dmem should enforce same-depth hierarchies
> with `dmem_cgrp_subsys.depends_on = 1 << memory_cgrp_id` (see
> io_cgrp_subsys for comparison).

Thanks! I'll look into depends_on.

> And eventually, if per-cgroup attribute is desired, it would make
> greater sense to me if that attribute was on the parent level, so that
> siblings competing among each other are always of the same composition
> (i.e. all w/out dmem or all including dmem). This likely results in this
> extra-charging attribute to be properly hierarchical.
> 
> HTH,
> Michal
> 
> [1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Thank you for the feedback,

-- 
Eric Chanudet



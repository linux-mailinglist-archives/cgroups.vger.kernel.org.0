Return-Path: <cgroups+bounces-17187-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /4aNFHCxOmo0EAgAu9opvQ
	(envelope-from <cgroups+bounces-17187-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:16:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75116B8A25
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=N6ULFb5o;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17187-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17187-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BCB300CE46
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE5302750;
	Tue, 23 Jun 2026 16:16:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183572010EE
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 16:16:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231374; cv=none; b=Eigu+3RN3Rcien7PlzuDbWShJj6na2f/YJz3Z9w2jvBUoM8eIG09lutVeP41pv1pZEu8w/D6axThZN3x5uixTd5YKW7JuflvpiQoIjtEgv52TlJlk36PDqWjkXZVErJU4W6hGcAPmwo8GectPc+1ti9MbAswpsd+LIlASJXD7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231374; c=relaxed/simple;
	bh=FEp+yKhN/uwAF92BEizkdUUute3l/a/GJYHsqyGEw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2UOMWbQukVg656wduSGV9UdyLd+BMP+fVxlwrSWgrGhqS+n2IqbQP4t7CPnsCxWqo+Txp7evff/OBL5F71Oy5wIpQ4wWyjdhHzNtI7ICIcWfpi7o2ySD5IsGO0jL7TUNDbx/UnzSiA6R50HQxqooU6uNI8u5345mmFibbWd+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N6ULFb5o; arc=none smtp.client-ip=209.85.160.46
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43cce34c881so85203fac.2
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782231372; x=1782836172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxkL22KDxjMJAOjKoz1/zPseOPibb81DxVe3Y2gr7ds=;
        b=N6ULFb5oxq1/jjPgHRBuVVhm9KF6s/htTM/T2KDkbXGylN+I34Exbf5wInRy1svR+q
         NQkFKr/ennDbxHXBpvF4t0zTbtiJGD+a5wdxziYIvbCynrdtZcZ8EGa5CVfkwhvfu0Lb
         ZiM+1jcPb1FgNMNGqYfrDdeFKURNMrT9eGl+Y881xCf3uFxeZBcSU9wJ3W/bFKj9m/wx
         RkL08aW2R18PhHsy22ok/SDJPN3UxEuu/t/n0ltaAgYvluJCZQXTFtW3yPWz/FJD6vHd
         yy1XF/AEzbedxObyTGB5T7qMqO3MTxhkOQYczmVt+0qzTV8bLsH+N8Xm/tdzEFqcV9TM
         OCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231372; x=1782836172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxkL22KDxjMJAOjKoz1/zPseOPibb81DxVe3Y2gr7ds=;
        b=pa8UYzG+q5xd2daKNKGudDygQ7foTAuotJylpBV8Ygk/Q+IBsnQ6yfNJLZU6q7iiLj
         tmRIuoz9JU2F9G/NJTMPQ6pwLPAVf/djx6/MUJVanSrfJ73ihv036FPibhOsjQP914+M
         F3o1xd90Lkr6bz3GPPnPfVvwXbYx4Ivl6mjcFHZCfJ2SQw0f25YVMr1rfE72KowUY2ZW
         /M6W8aW2xtPeEExjn//AodpsUH7+I6+3HutXMFosLPuyKLXJYv/W3xED0Q3DTijarn78
         DOD2iJM68/KD1a2ojkHVpNAibYNXSkv8lRo7AkdkdcBeoMW3wkI7f2l2vInQ65JzlP6M
         KloA==
X-Forwarded-Encrypted: i=1; AFNElJ8dDEvLrHYFa+Xe9phkge/8IzVPqHnZ/mss5S8eTVPZUYOrKD9sgeGDXCsHDFeIyEuQgXML/K4/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69c4p3AT8sEfsFWcYyLqF8/3Nd4mQzROhvKERlt6lmeysIqJ4
	7QrVDrb3pt1rKVYcWZVsv284rI+R/14p2QdTcK75bZxjZOc1ACO1Oschbo7a2wlleLg=
X-Gm-Gg: AfdE7cnDNstDbsq3kapUglqorKTDNnVCjWTNvYd0xC91LSOPzisuKWJ54kCGlrQ/AkB
	8h1GJhmKygy25r0oleu67gfUB1+2DHSBhIeFfsQWfQCWZCmDX2qlMJO9maCYFbyBHaLSeeX7FDQ
	CjpJWFxvkVWRbcBC/Oj3yR4JPQ8tcvy4r74zgayrG80ljTsBziJ0towEUQgEglMqAk0TPj+n4mE
	y2wY4JFJ1xzdYOZeFGEfotpUT03ycWiQLYe4KAyyYLtoZhk0gXV4o677vCpK1g2WnJPFaEgjZX+
	yIoG70zRoONi+aUAwGTMhPKsy1M9c+p+hPRO9P8n+6TGkBzbh87lm/pfEa2wc8D+/aJTICvG6pv
	hu7lyBDhilbg550TU7IGAl1LUoHuaPxLxinWRsyjUPd7xl0m0dfIHaBTqNorPnncxzeD/RV83Mz
	t6AT1X5Id+Re3nwUklh+8aMCgBuA9NmExsE1qXjdIqSQSiRblyWXI9z7VCLVbIpHSCg19Z7n8qc
	WOlg3E=
X-Received: by 2002:a05:6808:1513:b0:48d:e956:e3cf with SMTP id 5614622812f47-48de956f997mr6499808b6e.29.1782231371341;
        Tue, 23 Jun 2026 09:16:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm134046626d6.30.2026.06.23.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:16:10 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:16:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 2/9] cgroup/cpuset: Fix node inconsistencies between
 cpuset_update_tasks_nodemask() and cpuset_attach()
Message-ID: <ajqxRrhlglVqAeyu@gourry-fedora-PF4VCD3F>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621032816.1806773-3-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:david@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-17187-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim,gourry.net:email,gourry.net:from_mime,gourry-fedora-PF4VCD3F:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75116B8A25

On Sat, Jun 20, 2026 at 11:28:09PM -0400, Waiman Long wrote:
> Whenever memory node mask is changed, there are 4 places where the node
> mask has to be updated or used.
>  1) task's node mask via cpuset_change_task_nodemask()
>  2) memory policy binding via mpol_rebind_mm()
>  3) if memory migration is enabled, migrate from old_mems_allowed to
>     the new node mask via cpuset_migrate_mm().
>  4) setting old_mems_allowed
> 
> These memory actions are done in cpuset_update_tasks_nodemask() and
> cpuset_attach(). However there are inconsistencies in what node masks
> are being used in these 2 functions.
> 
> In cpuset_update_tasks_nodemask(),
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): mems_allowed
>  - cpuset_migrate_mm(): guarantee_online_mems()
>  - old_mems_allowed: guarantee_online_mems()
> 
> In cpuset_attach(),
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): effective_mems
>  - cpuset_migrate_mm(): effective_mems
>  - old_mems_allowed: effective_mems
> 
> These inconsistencies dates back to quite a long time ago and it is
> hard to say what should be the correct values.
> 
> The guarantee_online_mems() function returns a node mask from current or
> an ancestor cpuset that is a subset of node_states[N_MEMORY]. Nodes in
> node_states[N_MEMORY] are all online, i.e. in node_states[N_ONLINE].
> However, node in node_states[N_ONLINE] may not have memory. So
> node_states[N_MEMORY] should be a subset of node_states[N_ONLINE].
> 
> The guarantee_online_mems() function should mostly be useful for v1
> where mems_allowed is the same as effective_mems. With v2, the memory
> nodes in effective_mems should be a subset of node_states[N_MEMORY]
> except when a memory hot-unplug operation is in progress and a memory
> node is removed from node_states[N_MEMORY] but not yet reflected in
> the effective_mems's as cpuset_handle_hotplug() has not been called
> from cpuset_track_online_nodes().
> 
> Let use the following setup for both of them and make them consistent.
>  - cpuset_change_task_nodemask(): guarantee_online_mems()
>  - mpol_rebind_mm(): effective_mems
>  - cpuset_migrate_mm(): guarantee_online_mems()
>  - old_mems_allowed: guarantee_online_mems()
> 
> So for v2, it is effectively all effective_mems most of the time. For
> v1, mpol_rebind_mm() uses mems_allowed which may differ from what
> guarantee_online_mems() returns, but it conforms to what the cpuset v1
> documentation says with respect to setting memory policy.
> 
> Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>


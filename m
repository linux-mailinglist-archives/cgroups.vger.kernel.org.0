Return-Path: <cgroups+bounces-16139-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOvwBWFwDmq8+gUAu9opvQ
	(envelope-from <cgroups+bounces-16139-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 04:39:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94B59E26F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 04:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB10303F29B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAF374E67;
	Thu, 21 May 2026 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onsgQubU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E72D73B5
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331040; cv=none; b=PR8hLOlQ4EV2AWIFbRy/yk0HSnz7okv8Hw08po2GYRShmkmPdyLxv7hnHbT949zgVpcgZFUddljYAjLYsw8OkHQBncihtsZAS3Phgy/9Vwo+3cFcXBU6klJnomqxufUfQ2umUNkEeeVK2rbaxK+5yW6CB0eZAbNTk4l77zxBlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331040; c=relaxed/simple;
	bh=hvP+zx5nDdySfGXoXc3/DIIrPxhFWJ7VUfVTgfDPrRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=k5mTMKxgzEdGYIeQlN9f3mUhMKHs5mG5XkobAuFPc5AX4QUYkGWB+I6LfV4wx+Jc9ha0oApiVB348UYyPcrrBUM+yQ29u8w19Urq7QgRL3oLgIUENFE5iZYDyH+dphSpHqVLOtS60zyr+AUeID74+bwTYmp+oKaO3/WwQyKhU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onsgQubU; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bd2051167eso25217965ad.1
        for <cgroups@vger.kernel.org>; Wed, 20 May 2026 19:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779331039; x=1779935839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3VXZEZTkDJvE/SCtCoJk4/cTfgLUHmkSXPo8xqseOk=;
        b=onsgQubU/kgx/G2DdUwFlrg/t3/ANUs6CPop6n4AuuDfyKhhZzjWppPRxAcU1zEgnv
         /qSKKz3lrbGOs5k7n+UqZJ1rF9+bQkbRZo4S7yWHceQjcYYJbiOt28B7uI7hMbN7Pk6p
         UyluhnRSVjEiAVr7TCeXeHmccH+nOVev5y3cqAhFEcejyI3Vd6IqclJWzi/fHZr6H1sl
         /GIAYufA9oShXNR5PzAjPNBLLBPsT+tuTumqc1U0D6ayxA4Fhk0FB6OpmN5KnoFSwr7d
         uyslNqr7tDYUfJ98JNiS9xYhAvU+L9jwwj6je8gzOcAExsOCnnob+XSgsU260e0mUAHm
         uzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779331039; x=1779935839;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3VXZEZTkDJvE/SCtCoJk4/cTfgLUHmkSXPo8xqseOk=;
        b=eF/nJ2brAVFb9nL+iC/2EPZIMnd8v9Dig1r5k3oviFQZd2+UZnycCD2lXkMshiHsMS
         uSTJglSEP8rhISBGD2fz07udXj/tOMi7CQNJYXREvCYAek1KKu/XsH+njENLGBVAtkL1
         eR0Letqse3UyW1mXrTbxZUlkJT+hb9IOnhKYFSedP7H3j1fWdC3SkV9rpY/XJzbKOfb5
         iujbDrXB6dKrHShxtbNN2LawTNODOduESrF37+Mdp/IwLLo9aCJYJUSrKEqMh7vwivbZ
         ATeS+UlM0GsAGDi1j7cWUwsZdwL/quWF/vZAzmCB+fDUYw1biJmgdn6+x6ii8U6s9OE2
         njXg==
X-Forwarded-Encrypted: i=1; AFNElJ94+l7Er7MjJpVMu1YK0Wr7MjN5YySuojswJHrekpCI7D+a2MhxPp6SQJZ3T38hPkoaiPHyD+o4@vger.kernel.org
X-Gm-Message-State: AOJu0YxflMJFHdg/zFJI+J4csNKlZynWdjTcebdIFR2xv7gzjDaKezsS
	unM6hYTKoWqmm1MuDkQbLZHb/s85BltkWb6enfQ0KECwRyI71I1l4eGsEXdxQp1FI6I=
X-Gm-Gg: Acq92OG8QDiXfUy/nYvcoLq4S1u5lr/Ke9Gpr5ZSC1+hSEMxfsl5Slks8/8hxhlYavh
	an/TJoWd2noWgY/yVn2Za/vxBNQ3dOFJ8euI7Gk7IUwfuQhiG3y/xVUniM+LLTF/wixVnk4CBhz
	QEWJ/6BOenXGuMlenYMYKQcOMeNylkOD8Olw8I9fjd3DFN42RJPAM5WffM/4PD2b800h8APYM1L
	aRtmev4V0oHUWiBMLlEUmRWXkpdogZNO8R9ZmXt/o2JJtCLAmm8WvTIhP2ZNmUwwl6fqcD0wkoW
	t0uDf/k5qdX82+mr3Wms+YqHZx410O4cdwQYvCZ5hp8tty7jeo+vhJ/qacwaKmx7IvP+BYKdTyx
	tfH2wnJ3sLVpv2xS9X5GT12lw0QmKZyTvTxTUF9H4RYYRiXhb1VkciQAzMW0U5LuehlctrBc8kd
	qQNQ0cW3d8ztnHOH0N3r6q91HcTMinrcuv/El2
X-Received: by 2002:a17:902:d591:b0:2be:3dbc:eee5 with SMTP id d9443c01a7336-2bea2fcfd85mr7414165ad.2.1779331038883;
        Wed, 20 May 2026 19:37:18 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f9155sm245183765ad.59.2026.05.20.19.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:37:18 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: rstat: relax NMI guard after switch to try_cmpxchg
Date: Thu, 21 May 2026 10:37:12 +0800
Message-Id: <ag5v2LFie20WN+tw@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ag44Seky7krETHe6@linux.dev>
References: <20260520-nmi-v1-1-f2c8f08e4a2b@gmail.com> <ag44Seky7krETHe6@linux.dev>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16139-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B94B59E26F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:41:02PM -0700, Shakeel Butt wrote:
> On Wed, May 20, 2026 at 11:30:54AM +0800, Cunlong Li wrote:
> > Commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe") used
> > this_cpu_cmpxchg() for the lockless insertion, and therefore required
> > both ARCH_HAVE_NMI_SAFE_CMPXCHG and ARCH_HAS_NMI_SAFE_THIS_CPU_OPS in
> > the NMI guard: on archs without the latter, this_cpu_cmpxchg() falls
> > back to "local_irq_save() + plain cmpxchg", and local_irq_save()
> > cannot mask NMIs.
> > 
> > Commit 3309b63a2281 ("cgroup: rstat: use LOCK CMPXCHG in
> > css_rstat_updated") later replaced this_cpu_cmpxchg() with plain
> > try_cmpxchg() to fix cross-CPU lockless-list corruption, but left the
> > NMI guard untouched.  After that switch, css_rstat_updated() no longer
> > performs any this_cpu_*() RMW operations and only relies on the arch
> > having NMI-safe cmpxchg, so ARCH_HAS_NMI_SAFE_THIS_CPU_OPS is no
> > longer required in the guard.
> > 
> > Relax the guard accordingly so that archs which have HAVE_NMI and
> > ARCH_HAVE_NMI_SAFE_CMPXCHG but not ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> > (e.g. sparc, powerpc on PPC64/BOOK3S) can benefit from the existing
> > CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC path.  Without this, the css
> > is never queued in NMI on those archs, and the atomics staged by
> > account_{slab,kmem}_nmi_safe() are not drained by flush_nmi_stats().
> > 
> > Fixes: 3309b63a2281 ("cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated")
> > Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> 
> Looks fine but how did you find this? AI?
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 

Yes, AI-assisted.

I'm new to kernel development and was studying the memcg code.
When I came across the guard in css_rstat_updated():

	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
	     !IS_ENABLED(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS)) && in_nmi())
		return;

I asked Opus what those two CONFIGs mean and why the function
returns when in_nmi(). It suggested ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
may no longer be required after the switch from this_cpu_cmpxchg()
to try_cmpxchg(). I then went through the related commit history
and confirmed the analysis.

Thanks for the ack!


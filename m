Return-Path: <cgroups+bounces-17000-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AXuSHW5TMWpkgwUAu9opvQ
	(envelope-from <cgroups+bounces-17000-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:45:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774716900F7
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=a3a5F13U;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17000-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17000-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C41F30151D6
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1465D334C08;
	Tue, 16 Jun 2026 13:44:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E22FFDD5
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 13:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617498; cv=none; b=TT2NzeliIfpmZ54AFVwYRExLbj7Yj9JBRb1IyO7SPvkaSk6HVkPo0dMMzMw6onwN7LMTHBaN+yL/EhM2l0m+r2JbOMrM07UJZttpWMY6YNj+1uiSy/K/Djzvaom+OB+AKCyodLx+9+3oJd0fJme9J2ibcqQw/oIRkdK+ID21msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617498; c=relaxed/simple;
	bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqceBgkDL5n70XHp3ens9i8zFdAg9wCDHyVlkMYsdv+A1iGFkK8zTQKNSyhq3iR4SF3HSGkTZHba9lWtuP1soOsgtNI1QW3gnphlo4+TE4/2IgOdg0urJAVisYFYV5o0EqKp2+K39PZc/qK1FB39geDcNevQfHkC/jeV5eScvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a3a5F13U; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8dad1718d7dso2175926d6.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781617496; x=1782222296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
        b=a3a5F13U7QwjSojqxK6WJWsr4KMcn/68BL5eZED9kbZd8ouwwg8XXmV8kHQjnOkO2e
         1P1v+UqqXmwqJZ8mmp59WDtd3vgQ8+zEZqM8z/ST8jyv1FWh5a3XIfa9fEA9v95WB+QQ
         kgx4YRhm5ahRvbo0m3umIfLtC3WvYkLN+L1dMCDxqLtXNVqmjyZG9Ej2goFxVDGHHgov
         0L/rLIKobc+QB6TlUal3/sB9G2TnlKQNQ4JcT3d/Y68zviH8uSQpCgfum3oj1Bacp/71
         +jnxAJPKVsw2UZLQS8rIL77dY37VR0nkVrDPZDxf/ddEDgnnoePsAq2MMWc07WHXDf98
         ZWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617496; x=1782222296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
        b=WUS9RU9mKwPweBqNj8l5Ffy9VXc+nH+M5zekr4heMRYqLVcKpVrv69RoiORlV6mE+X
         +pg8yX3K7kSY8gDMojzO7sY+Cq17g64b7G/HXgbya4dYA+skTA3ldFSGVCRJqecNpOYI
         Y9XV4sMR1qYOeu/oEbi0KYxyE7sLd7n9PImCbD/ytafG8DTtCTKB3E9Y/WpRe0oFA+Tc
         fx8v80OhU8w+htfLDORknmHq60ehaIks6kVNiEJyOb7NNMmmkCvJiQXOHVtm+6YXjF9p
         ALtWODEIKVChj1bZjRRhuMKjOeuy90gnGDIPy0ZBBZHjtFw7v2BfcJoLnzqN4Psbn2An
         7GXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GVfoRjzkAuoUm6C793fQed3btmPi3USPx6RawXdEqq63DllwDAqk4f6tKPErSJKd5qp+5g8+P@vger.kernel.org
X-Gm-Message-State: AOJu0YycqBIDS521lPlf4lONX32ASw73CiAxiApdKqY5n0pB9JvvIZuN
	BKzoDw623uTqOg3iviushPl1Exte1fO9baeOksP35SbklkwcmanULhn1FmpLGDQXphs=
X-Gm-Gg: Acq92OE8B9dBJ2/dkkavpkXKkxptnR2qNSnbRjQG2rB9qVo265kSjhhPZT754eJocLZ
	ZVRVGXIXpq1vxuLfkmWCMEZ7AV74N8vCRIVYkktEUXLDUQ/1YH1ftWj9dIRqDAn2Gcfnv3PFHGH
	33k6iibOA/WkmJY67499LMTMXLBSWpq7RY1WCi74qFVoej+jVIRDoFOPGzeBnZtIS+gGIvR4IPU
	8+y6VReXpZs/ZGEPjxt9/4IOjteQ3VP1Eu7V69fyPtib5SFbjE7Aq2vV6hTTKd/h0st9S3IjQaE
	JKKAHYaNUg3t7eIk169NJnOr61+itFH8xffaQYBff6/XxCtXUEjx1lA3Sc7eC8Nld7MHHduRNim
	T1ziqOSoad9q+QBzTKEJqBFByB6MSugRiNDjVj1RRaj/v0l6D8YsY5mYboBThGr8WRUmQYeRSIM
	conGzcxCoZy1XPAjtqvkv3
X-Received: by 2002:ad4:5d6f:0:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8da1f0168f7mr50299196d6.18.1781617496409;
        Tue, 16 Jun 2026 06:44:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f4ff2206sm32423616d6.37.2026.06.16.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:44:55 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:44:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Farhad Alemi <falemi@asu.edu>, Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ajFTVaMBeu-ViGIC@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
 <c1495b1b-9dee-4cd5-ac8e-eeb7a2d968ed@redhat.com>
 <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17000-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:longman@redhat.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,berkeley.edu,linux-foundation.org,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 774716900F7

On Tue, Jun 16, 2026 at 08:59:07AM +0200, David Hildenbrand (Arm) wrote:
> On 6/16/26 05:43, Waiman Long wrote:
> > On 6/15/26 10:26 PM, Waiman Long wrote:
> >>
> >>
> >> The reason why I am suggesting to use cs->effective_mems to keep the old
> >> cgroup v1 behavior. If the consensus is to use the output of
> >> guarantee_online_mems() for mpol_rebind_mm(), I will not be against that but
> >> it will be a slight change in user-visible behavior.

I'm not grok'ing what is user-visible here.

The two values should effectively be equivalent because we're
using this value to constrain mpol's during a hotplug event.

If the values differed, you would be saying there's a race condition
that could affect correctness of the rebind (which can't happen,
because this whole thing is done under the hotplug lock btw).

Can you help me understand?

~Gregory


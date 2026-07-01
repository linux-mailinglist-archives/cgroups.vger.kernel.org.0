Return-Path: <cgroups+bounces-17425-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ksrJpV0RWpOAgsAu9opvQ
	(envelope-from <cgroups+bounces-17425-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:12:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4176F1554
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ZZq/fP/O";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17425-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17425-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14480302BBE9
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46893B6341;
	Wed,  1 Jul 2026 20:10:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D203BB67F;
	Wed,  1 Jul 2026 20:10:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936659; cv=none; b=faHDzZBqAYeWMn2i4xE2+uNvBmE5x96mrg4MKNIcDvER0iuNvs6fsIdObLiYcg2fw8GksfJlgXrWNHZyjzkp77p9naDEKdeXde+u2sXwpXy+qzFFwPBzW6dEuc85M8L+pP+RQjtw+7VhxWAlhuJKaAfqL6Q//NQ5ooTsZgQS+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936659; c=relaxed/simple;
	bh=jS7TB0HUTcuMj/hqMgFibYlZ8/MRJH92GYaNUUPWBp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dadIMo482anYvFLoR+L1NH7RQvYZy+QpwhPYvVIoRABqMrQScyjeVYpey4HHapw4Kk+jLtFgGo37PKWInCt+efBoKZRoNEBM2iXMb/j1qMo2jw3M/CtXqqkLsmYe1bY7anG5pGZmGmItGM4sHJ+UXXTVrKCqUTD8ae0yqfaZuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZq/fP/O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10381F000E9;
	Wed,  1 Jul 2026 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936658;
	bh=VUOJ0y9LDh3g3+h8oNdNTGK21keh5KSbMCa0j+HDbUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZZq/fP/OuuU3nOOPrmSRpiEpngyZc+7MOlJUdbptmQfQsvX6YgqszY+07WIJQiuP/
	 1+HRyhIqy+Y8/Rp46ejix+9elqfJ6cDlzGyAv7sCe7yAUtJep6zAErEe3hmR/B8lCm
	 4+NctwxONV5HqeFIdWImiP1jiCzpYI4e2Ev3Ylb2EwHZFXByOKr/aMHVlD1Av6m+kT
	 zM19j4teCgyWZriUE35mbCOavUGZf1YrVLlrGsEwvoUC5B9sX1mlXBzK9/XfgM7EBG
	 3pRD7kUackf2q99YyaRt6jGQFDmfVvXiV7BU7bdhsWJgeG4SVh8I/jIgtv4azPY/I0
	 Wrt4u2KvzgdlA==
Date: Wed, 1 Jul 2026 23:10:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry@gourry.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gfp_types: fix __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT
 documentation
Message-ID: <akV0Skp68nDUsny9@kernel.org>
References: <20260701182102.1586784-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701182102.1586784-1-hannes@cmpxchg.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:gourry@gourry.net,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:david@kernel.org,m:ljs@kernel.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17425-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gourry.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4176F1554

On Wed, Jul 01, 2026 at 02:21:02PM -0400, Johannes Weiner wrote:
> Gregory points out that these descriptions are cursed and confusing,
> considering what these flags actually do. This is mostly due to
> historic implementation choices and cgroup1 baggage. Improve the
> description of their actual effects.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


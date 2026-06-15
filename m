Return-Path: <cgroups+bounces-16978-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8P4cCT9LMGrpQwUAu9opvQ
	(envelope-from <cgroups+bounces-16978-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 20:58:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5E689544
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 20:58:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i+44SHLS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16978-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16978-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121B030F32B2
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2723AE184;
	Mon, 15 Jun 2026 18:57:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAC3AD501;
	Mon, 15 Jun 2026 18:57:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549827; cv=none; b=IlaU86FBykpsj56cYxv0oPPt2lM/WfPQ3OW72hfgnvHeP8xe/GYesq9PnZD/Ow1w9TsRQzCef1sr9mW2C5LmJVsywC1jvWS0R4N99PjvRwrF9Zl/RCLYVeGjgb9N3z7GHDf/h/u5+5NIzgfJgTeR0kqFf8MMb3rkvMkRYOUCoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549827; c=relaxed/simple;
	bh=ipTuWyEiQXg4CrHmekr0xKl3BUxx+ViO4QyjdDZgBOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUsbFgWnVh3B0vda0zqYklAZmUdd1QO2wKLOtz+wA0XzL4RRJnz/YdFauLU65FXFl4fZNrjH+h4LSuk6x99jpPXmAegZSHnMxfoXlL5YoMguQs37LsS9+ZZoumXWX1Y/YpDXZYa7mIPeBM3IV2bKZ6biPH6lrOnX+QmXOUXbfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+44SHLS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B149D1F000E9;
	Mon, 15 Jun 2026 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549826;
	bh=ZkxUGDLSZMr0Dq+DdzIPtXTXVSaYiY2WHl9OHQk/HmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+44SHLSEjFboHQKldJvgVHf3fFqesutTGQKBKUoBaYf1PDwTRUkh2KCBbfiv/zxK
	 AHpovUOYmMej8NestBeihJK5CrLS5z7Hbvwf2Of7QJjOK4OxZokXnmRA73OfXZFZAn
	 zdKEoHoe6a87h8z8m5TuXlcVyhmvLeMTAqSWmn5NjhSpJnBXUR32tU15ovJ5Bj/OXc
	 8g1oze2ON0nj84ddT6EiR8PjTYFECnDbTWQA60ql8B4kdR38mVdBh5ej7Kfj+/6GO8
	 iVlzkdwBGzWKAGCJ4MeDNp2MKoqtAIWvXoY3pt6YTKAE3kd6Qlra7H+r4/Tu+eEHVg
	 yjEBRjBz88cPQ==
Date: Mon, 15 Jun 2026 08:57:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajBLAsNoKesXmFcs@slm.duckdns.org>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBJU-Jp2QVy14qt@slm.duckdns.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.hellstrom@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16978-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,slm.duckdns.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CD5E689544

On Mon, Jun 15, 2026 at 08:49:55AM -1000, Tejun Heo wrote:
> The canonical behavior for cgroup2 would be not failing the write at all
> even when the usage can't be brought down below the new max. Updating the
> target configuration and tracking the current usage are separate operations.
> The former should just set max and trigger reclaim and a writer should not
> assume that a successful write indicates that the usage is below the written
> max value.

Sent too early. One of the reasons is that cgroup is hierarchical and there
can be multiple delegation layers and if you tie application of configuration
to immediate enforcement, some hierarchical control actions become racy and
awkward.

Here's an example: Imagine a system agent trying to lower usage in a subtree
which contains multiple delegated containers. If max can be set below what
reclaim can achieve immediately, it can just set the max and if the usage is
still too high, can go around and e.g. kill some of the containers. If max
write fails, it'd have to kill and then try again and inbetween someone else
might push up the usage.

Thanks.

-- 
tejun


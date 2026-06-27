Return-Path: <cgroups+bounces-17360-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BS/5CLQTP2rFOgkAu9opvQ
	(envelope-from <cgroups+bounces-17360-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 02:05:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E966D0986
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 02:05:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MZTbPqdo;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17360-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17360-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDD28302F683
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A140D584;
	Sat, 27 Jun 2026 00:05:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FC3C2D;
	Sat, 27 Jun 2026 00:05:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518702; cv=none; b=tbXl+OudvQB/duc1q4OXChjd549geT8HX3nAUb+6if7zr96SRpTgKFM8Jt8G3a1Ui7AJeli65crUByc1efecX1yq0XA4Qxw4YcmVpOPb7c3Mw5QUBAFHOstOhnw5tPuT4E9tghlmspdOdDO7V/9ALjMNt4HJl8/hkIERreQaNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518702; c=relaxed/simple;
	bh=2Zh6R/15i6vOTHGCOaxfoeHL+jgQib064kIUkuL/g0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olrQ+lWK2sS/zrv2plR6eXOQ9qZkqlTredCH+D2COj0yA+kA0XjJun0Kjf6XV4j+NcUcMTHwCdPoPts+r5NACXlWXR37SsZC5WfKDgE+JATPomzJm6xBMYPe4oSwU4ASRKs+iISqzHt+t9fIN2966jNE6Z/8EC6DH0QPVZYOE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZTbPqdo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BF31F000E9;
	Sat, 27 Jun 2026 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782518700;
	bh=qaTIdG2spwckKCehRc5kJjk4jNw/YP4es+XSEGs8qSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZTbPqdonoA49oh0gHgSqOLKuwIFjZJRM4j1UsXSBMvZ63LI0/LOhspgpSuv2LA2h
	 sm9pMMPk2qW8nsLrI0LgGk8bglA/ELX1QAuq5AecvwjL6Jry7RCJ8I9kNC/OrkJwYl
	 cRGZFZxmtaMNYlRIBXS/jsSOZnBbmMXZfLJ3SJfUz+Lq1PsU2ZDTXdZx4Hmnktn697
	 EeE/L+uVvYc7yXEZCS0zirjwi7USipcIQvFt3AE1EfOd4nPfNSRglHl6vg+K6XWMxh
	 PcuoEALYr+JpNu2Mk93yC+/xWfvhb9Sot7JVEA2q8fpg7i/z51TFWD2aRBWIMjRvtN
	 1VWQ/qlStZjBQ==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare() stub
Date: Fri, 26 Jun 2026 17:04:45 -0700
Message-ID: <20260627000445.85650-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aj7KoDXJv3NByGUm@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17360-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:sj@kernel.org,m:leitao@debian.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmpxchg.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87E966D0986

On Fri, 26 Jun 2026 14:53:20 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Jun 26, 2026 at 05:43:02AM -0700, Breno Leitao wrote:
> > mem_cgroup_oom() passes an uninitialized "locked" to memcg1_oom_prepare()
> > and reads it back in memcg1_oom_finish():
> > 
> > 	bool locked, ret;
> > 	...
> > 	if (!memcg1_oom_prepare(memcg, &locked))
> > 		return false;
> > 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> > 	memcg1_oom_finish(memcg, locked);
> > 
> > This relies on memcg1_oom_prepare() setting *locked whenever it returns
> > true.  The CONFIG_MEMCG_V1=y version does, but the stub used when
> > CONFIG_MEMCG_V1=n returns true without touching *locked, so
> > memcg1_oom_finish() consumes an uninitialized value.  On a memcg OOM this
> > is reported by UBSAN:
> > 
> >   UBSAN: invalid-load in mm/memcontrol.c:1932:27
> >   load of value 0 is not a valid value for type 'bool' (aka '_Bool')
> > 
> > Initialize *locked to false in the stub; with cgroup v1 compiled out
> > there is no OOM lock to take.
> > 
> > Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I prefer this way over the idea to initialize in the caller. For the
> actual implementation, the protocol is that the thing is initialized
> when the function returns true. This version of the fix maintains that
> for the dummy as well:

I agree.  I also feel the caller code is _slightly_ easier to read as is, than
adding the initialization there.  If it is initialized there, I would assume it
will be used somewhere.  But after finding out it is not used for early return
cases including memcg1_oom_prepare() reuturning false case, I would be confused
about the inefficiency.  Using a variable after passing its pointer to a
function depending on the function's return value makes me assume the variable
will be set inside the function.

The code is simple enough to read in any way, and my taste is sometimes just
weird, though.

Anyway nice fix, thank you!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


Return-Path: <cgroups+bounces-17263-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tu1IM2RbPGqunAgAu9opvQ
	(envelope-from <cgroups+bounces-17263-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:34:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E16C1C64
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KGR132xp;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17263-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17263-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61B3F3022DFF
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092563B1EFD;
	Wed, 24 Jun 2026 22:34:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242C8834;
	Wed, 24 Jun 2026 22:34:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340448; cv=none; b=uSycMPV38YLsTDRxd5ysISHuV2YDCK8fDeMrA4nZ8j1NUqPOFPgSFQhNLXrfPnJ71sF8TSpujg6LmVRwTa3zSairDLXLVyr5zcbmeFQQiCwMS+o8pKPraV0siB94QoO0NfvaoCNHldJYHoGru02eiIWNuurx4o7SlOWl8Xkdk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340448; c=relaxed/simple;
	bh=jii3cJiVzwMrZB4rB2WKhpoWQtBuM+AjGlyEzg1nA6M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dvqjtMoNtvXV4LGWQxYSlc7lc32CWlM8W6qQ2z+YTWZO1eObstyYDHTvQItJLZdE9ir4QE9NtziVkRnOgxiY2RL/GWDs19Hpw5OGw4Lbe8mdduLRUxQOSEC0beAJ1LtGpsJDX30FpxdOPKxE0B7jDRww7PgNsPfBD4Ab0DTuumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGR132xp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C01F000E9;
	Wed, 24 Jun 2026 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782340447;
	bh=jii3cJiVzwMrZB4rB2WKhpoWQtBuM+AjGlyEzg1nA6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KGR132xp4zKrvrBYJBccPaNSdBiSD0Bs6OC0/6nmN8DFF5KhKV62NFad/GK3gwRa4
	 Q/jURN8ktJGPK2feIYHxp5IlKZgx+cj2o85I99MxnECh1M7Slw3cYMl5r6l/9sityk
	 3r/cM8cSkQnrMeHQ9NvNisLq2WL/SnDBGH4Gh1yhHoTVmPF8EeVpYL0Rpy+jMYL5te
	 GZsp3yMsaVu4dQOfewsFNFw54830FLoHSQ5N/tK6UzhQm1oqTJkjLQNtg0CL0VwL6Y
	 PphDxGJdsGfUbvuE1i6oJDUC5TIXb0mTdIhYAHT3+nJCRACK7Q7UzgwXocNmZPB1qu
	 FLaSelRUQuEkA==
Date: Wed, 24 Jun 2026 12:34:06 -1000
Message-ID: <cf1e52e639fc595ddd5b1bc7cd8dcdf7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] INFO: task hung in cgroup_subtree_control_write (2)
In-Reply-To: <6a2fb248.8812e0fc.3c3fa4.001a.GAE@google.com>
References: <6a23a4b4.e4db5ad2.3b7dfb.0000.GAE@google.com> <6a2fb248.8812e0fc.3c3fa4.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17263-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:syzbot+bb2e19a1190a556c01b1@syzkaller.appspotmail.com,m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,m:mkoutny@suse.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,bb2e19a1190a556c01b1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 505E16C1C64

I tried to reproduce this locally with the syz reproducer on a matching
PREEMPT_RT + KASAN build and could not trigger it, including looping the
minimized reproducer with the matched controller set and high concurrency
over many VM-hours.

Thanks.
--
tejun


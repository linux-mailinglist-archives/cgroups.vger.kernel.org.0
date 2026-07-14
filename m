Return-Path: <cgroups+bounces-17771-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UW8gHQYQVmrSygAAu9opvQ
	(envelope-from <cgroups+bounces-17771-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:31:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E77536EB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:31:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sf5DyfPM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17771-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17771-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FD463022DBC
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9137755A;
	Tue, 14 Jul 2026 10:30:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213F3769EF
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 10:30:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025052; cv=none; b=j2TL9Ve9qErAgNXf73gNC0dtemSzREdxDrrrYmeV+NqSZ4CsDofJDX5V59A27e/J0jWHhwcbXWAuH48tN5RJR6dx7UQ5dm4Fo8CZ2EA+UiDT8PyDU06rmLrZF2tYJNwoa27vsNqmAIi4OB8aF4eZcuMnJHT7tYz6KFfkvdgmgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025052; c=relaxed/simple;
	bh=HmNx+IwtsMyp7HDRxMTrfeyywG50CrxCgsAyvEE1Ru8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahMlX9AO4oKvqzqxCxffj0xq8Y9FjN3MPn7mfyV0MR7gl1G9RuAkusV7SetNtiISV9Z4+a36npQvvdXPM/XwC+h3IVKNtnXIu36rr8PYgs0iZUoM22GctjeKoMMeOGOh6tfpIoRIg3lG+3p5gUOdQNLZvtB8bgD9FhDrIiSsfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sf5DyfPM; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784025039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cMrsQK0mZZzzTfisH0k4vPZ3JQTeKNbIs42nnTfRpiA=;
	b=sf5DyfPMGcyw+hHdHRiCZoIPv6Yi4SslE3UY4rE+ss1Jt6+Uj2C+31neXdskMnLCX61q01
	p28r5tdCKF0Wa6Kcva4DW5K7xX4Fpy/YdcdD4zWN153vtIGixrO48ePsGat5rVM0/WMqa4
	Jqak6OWk7sF7rj4h21a+vgoOk6q3f1Q=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] blk-throttle: minor cleanups
Date: Tue, 14 Jul 2026 18:30:26 +0800
Message-ID: <20260714103028.1334831-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17771-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 408E77536EB

From: Tao Cui <cuitao@kylinos.cn>

This short series collects two independent, behavior-preserving cleanups
to the blk-throttle policy.

  Patch 1 reworks calculate_bytes_allowed() to short-circuit a zero
  jiffy_elapsed explicitly, rather than relying on ilog2(0) == -1
  (fls64(0) - 1) to skip the overflow guard. __tg_update_carryover()
  reaches it with a zero elapsed time right after a slice starts.

  Patch 2 factors the four identical rbps/wbps/riops/wiops print blocks
  in tg_prfill_limit() into a small helper and drops two alias locals.

Neither changes behavior; the io.max seq_file output is unchanged. Built
and boot-tested in QEMU (cgroup v2 io.max read-back matches, throttled IO
completes without warning/oops).

Tao Cui (2):
  blk-throttle: avoid ilog2(0) in calculate_bytes_allowed()
  blk-throttle: factor out limit field printing in tg_prfill_limit()

 block/blk-throttle.c | 52 ++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

-- 
2.43.0



Return-Path: <cgroups+bounces-4816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CF973C95
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FB7B224C0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0A19F461;
	Tue, 10 Sep 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="Vz600VjG"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DA1946CD
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983154; cv=none; b=fdvOBVWGwsnZyAiWUeMpxe6dJZPr0NwVnLRhhc+LfypZfGSOav9IxHE5lzESF4XAG1gl15eb1nQKdH4WAbQ4DdLb2ZBOLVDaVcfkZQJmv8aYpKwPkHPwyoWuDXp4FIFt/EV7BoJRlSlT52dcrhNECWMmd9j0z/352SXBQ3tlCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983154; c=relaxed/simple;
	bh=ZGIN6oL8ZbhY+JlkI9Ku+beUgqeJ7DREjZJAKrxKUks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2ecl8MT0LFe4Q9MJNBEjZtPHstSDPz/I6xY2Wee05VJdBIbpGeTI/g/NNcB3AfdxhrtcH/amugMxeYKlRazKLE6o4qFAWvHJgf35POhtcVv3oUCQ8LjBgQVrMMNHRfZjHRGOAHBDinBIkbrafc1fxssQ1WcRDEBCPrPtszHbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=Vz600VjG; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240910154548bc164160fa38cd55c3
        for <cgroups@vger.kernel.org>;
        Tue, 10 Sep 2024 17:45:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nThz1Prv8qbxtOruFaTCR2A/NQ2gWru4hgUnv1ATbIE=;
 b=Vz600VjGeixnbiVq/I5rQLc1cFupil2HtlL0k1mMpot4i3Rb+qiBx2dgC5tEBchf7ZUy8z
 x4ABdutZ7QxR6c//wEv38Q307qCiczchclKz5CnwEHQTDehJzi5KblaFK2G2rIfMktVsZWwk
 0qzKkTjziOqSoqt2Kx04oDTzTRnA2Lke5DI/GkPVJsXuaEp+vRIfsTG2rbO7oFlJhkoxrdvP
 ObIFpg9Z2wlGGiAfi6S5ihJcKkwgccH104EGM6NcYKVeRy4LhG/m4EIjJf+d6Q0ZZGo4FrM2
 zpY0v0D2xauEwR6JUMDrNWGoPyCqyKeceqgJREfNaEqEWjdew3FG4hjQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 0/2] io_uring/io-wq: respect cgroup cpusets
Date: Tue, 10 Sep 2024 17:45:33 +0200
Message-Id: <20240910154535.140587-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

Hi,

this series continues the affinity cleanup work started in
io_uring/sqpoll. It has been successfully tested against the liburing
testsuite (make runtests), liburing @ caae94903d2e201.

The test wq-aff.t succeeds if at least cpu 0,1 are in
the set and fails otherwise. This is expected, as the test wants
to pin on these cpus. I'll send a patch for liburing to skip that test
in case this pre-condition is not met.

Changes since v1:

- rework commit messages (don't use ambient cpus, wq threads are no
  pollers)
- no functional changes

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (2):
  io_uring/io-wq: do not allow pinning outside of cpuset
  io_uring/io-wq: limit io poller cpuset to ambient one

 io_uring/io-wq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.39.2



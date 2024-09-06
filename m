Return-Path: <cgroups+bounces-4728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFC96F06A
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BE01F27364
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77A1C9EA5;
	Fri,  6 Sep 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="LWqDfATK"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC981C8FAF
	for <cgroups@vger.kernel.org>; Fri,  6 Sep 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616434; cv=none; b=ehets7etuIAQozs8MS88w2s9zB+0YwyCtLVWQC/hppXUc08uG4ibfBtaeu2q8Z0s1YJES0smcKNBfU2SD5XvT5xBGHEzNEBhosSm0OI82FTlMoRPMKL+5a5sqphGtVO5EVrtc4bP/C9CsRq7xuC+dad8S6H/RclhkzxL/M3ynXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616434; c=relaxed/simple;
	bh=1pi+ZE9H6rSyN5PpZ9k74hjrSRiBdqp4Fn5YbapZfXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9GTAb7t/KYU58jiBmql1CSiBErT2n5MuxDld8469XPZctIcybE2Yns86ZcuJTB9GgUWzXoG/QCUge/vHpO7TfWCTqz5F2R2Zyytk4vofJLvZNl6x23Rh72AtMDx7qnOu6X1DCzqRj/UkiAsae64j078+Au5DCKvRSi3ZV8etw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=LWqDfATK; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240906095343354df37bca1d737f05
        for <cgroups@vger.kernel.org>;
        Fri, 06 Sep 2024 11:53:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VQynP3ITLuCADWZje+F9AQoYOLz42+/shggf0ishfvM=;
 b=LWqDfATKPVenyJXuklby7nYPlGjUB/UWj1QvdlGlW39ZBRywTsvdFWcCuKyaEZ2EuJu7CG
 fQKysHpAUXijG0gQG14Qh716dV+wDxGghDiKUMOjHPBfn+GJN6ZbFOk1Mjn25V4/Pr1D/uR5
 MHdOp4xxPzZJ0y3sR1+qLPhZ7cFESa/P9p9FnjrrIp4ah0Xvyl59xWZsqKiMTUhDlAN/PZKT
 QOzM558GUKSMaAU/qU38ajG8owFcgpwRg8Of4OphWhkNkbWTmW35XQOuTfsYGgG6RC9cqjFP
 7PG5O7iaRhs610JNiUwuc9MhE7B2Ws8OUXjCZDI07u2IpiVzhsk+lvBA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH][6.1][2/2] io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on sqpoll threads
Date: Fri,  6 Sep 2024 11:53:21 +0200
Message-Id: <20240906095321.388613-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240906095321.388613-1-felix.moessbauer@siemens.com>
References: <20240906095321.388613-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

From: Michal Koutný <mkoutny@suse.com>

commit a5fc1441af7719e93dc7a638a960befb694ade89 upstream.

Users may specify a CPU where the sqpoll thread would run. This may
conflict with cpuset operations because of strict PF_NO_SETAFFINITY
requirement. That flag is unnecessary for polling "kernel" threads, see
the reasoning in commit 01e68ce08a30 ("io_uring/io-wq: stop setting
PF_NO_SETAFFINITY on io-wq workers"). Drop the flag on poll threads too.

Fixes: 01e68ce08a30 ("io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers")
Link: https://lore.kernel.org/all/20230314162559.pnyxdllzgw7jozgx@blackpad/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Link: https://lore.kernel.org/r/20230314183332.25834-1-mkoutny@suse.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/sqpoll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 11610a70573a..6ea21b503113 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -233,7 +233,6 @@ static int io_sq_thread(void *data)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
 		set_cpus_allowed_ptr(current, cpu_online_mask);
-	current->flags |= PF_NO_SETAFFINITY;
 
 	/*
 	 * Force audit context to get setup, in case we do prep side async
-- 
2.39.2



Return-Path: <cgroups+bounces-4846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5497583C
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FB71F25712
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F7C1AE86D;
	Wed, 11 Sep 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="AcdymZsL"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E2154C03
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071813; cv=none; b=mViWdH3zyzxKyEMfNRzXgVW65OAN9AOFemAiN30z2wPFoF8kgm4Kxa6pWV+h/cXXq7dkV763uZ0cJCuxJLMD33aTI3W69NSS5xbutmc/7hQF8Fvugs/ENK3ouJtwGZEPH7ruXFYshd5NXtOaLPC1ofX2HRHsiyJFuhVI/77m82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071813; c=relaxed/simple;
	bh=DQ4/cLuEW5tcRqYwQZf/I4l9TuqIbQLDHOMgEpeUrxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nwnxqMNkIX6EW/zBiGa1nkGx6l60b55cPY18duGkymhICD4SMDtACb6QV86ChOvkiSGur7aIj6HwNmr/pgdJsYitFNzzWguqcT/yPGc0soRkzQ6OqTGIT+/IH999zNI0ohKBxGn1/hjL4RTEUVgoyEkdKUCyH053ISKzaZQQl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=AcdymZsL; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240911162326b9d5fd2d5f4dbcb2b3
        for <cgroups@vger.kernel.org>;
        Wed, 11 Sep 2024 18:23:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZbAxDD40Km9oPWWOUlychunrfPvdHvgL52O1h9AsdFk=;
 b=AcdymZsLHnLeYRW2KJhr/G8jq+9fu1woqH9QglaZrO2E7M75jn0+0Yj7KeUBIDNi2gO57m
 4mYKnCWyG8qUwxBiJUy/d59o+eooXY3fA3DyY1Yhqr2aH4snZ9adrYRaeXCdeMBSZwgThqS9
 AJjro2N1phkfznUBWIPNj4DxDKUg4kzt5E5sQROJxtBT7HPA4laqFIS2W5X4v0R5g8oYczBv
 BTeDHYigobpt6WA1XNO9ELg5NA3KCBo1g9mEP8wC1MwhBIc65arucOvkCwaNDmWedD8ipwxF
 Y/1+BEeXYDH/GvKYq0Ag4PERSxDb60iai4pcBUiyd5vNRRcpKkv0AGuQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: stable@vger.kernel.org,
	asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 6.1 0/2] io_uring/io-wq: respect cgroup cpusets
Date: Wed, 11 Sep 2024 18:23:14 +0200
Message-Id: <20240911162316.516725-1-felix.moessbauer@siemens.com>
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

as discussed in [1], this is a manual backport of the remaining two
patches to let the io worker threads respect the affinites defined by
the cgroup of the process.

In 6.1 one worker is created per NUMA node, while in da64d6db3bd3
("io_uring: One wqe per wq") this is changed to only have a single worker.
As this patch is pretty invasive, Jens and me agreed to not backport it.

Instead we now limit the workers cpuset to the cpus that are in the
intersection between what the cgroup allows and what the NUMA node has.
This leaves the question what to do in case the intersection is empty:
To be backwarts compatible, we allow this case, but restrict the cpumask
of the poller to the cpuset defined by the cgroup. We further believe
this is a reasonable decision, as da64d6db3bd3 drops the NUMA awareness
anyways.

[1] https://lore.kernel.org/lkml/ec01745a-b102-4f6e-abc9-abd636d36319@kernel.dk

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (2):
  io_uring/io-wq: do not allow pinning outside of cpuset
  io_uring/io-wq: inherit cpuset of cgroup in io worker

 io_uring/io-wq.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

-- 
2.39.2



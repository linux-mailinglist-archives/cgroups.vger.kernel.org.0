Return-Path: <cgroups+bounces-14379-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K3kBjQ5n2m5ZQQAu9opvQ
	(envelope-from <cgroups+bounces-14379-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:02:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6119BF48
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563BB300D778
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803C2E11C7;
	Wed, 25 Feb 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="LatG+Plt"
X-Original-To: cgroups@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A02E5B21
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042540; cv=none; b=qDDFs0uelei2mjVrBrOXG1ge9FE8XCoM6T/vn8ejyYksg8W7zIUa52r2Oam4fs86ZSkS0UCfyIqaL1tcNvJzADQV5hjylF+V9mUJH4cJNyGoOBHINvNfBqPuFTxt8UreptgCbDtieRDQW1UsNOpn27NjfUK/D0wHxMe3/IY4MhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042540; c=relaxed/simple;
	bh=EunSblSeqcaiqr9wnnYmLp4K86sucNx3kfrc6yE3wQI=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=PmI+eV38j6C51YpHyBKYTJplJg6ru45/0WdODxRrsvBI2yJCn9Qe1Re0qCyLTXPLTBT8J9jjfoMP1/aphG6gVenXsI4vcWzBpDOlwLqlcoyOWkHBaCg1uRf5qSD+LxeRYA76RMqe/9WLbQ98aI8ekhm/+cGtqjFzF+rzCCQbA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=LatG+Plt; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 135EE80B89;
	Wed, 25 Feb 2026 12:52:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1772041967; bh=EunSblSeqcaiqr9wnnYmLp4K86sucNx3kfrc6yE3wQI=;
	h=Date:From:To:Cc:Subject:From;
	b=LatG+PltWE97fdaItw8fUUk6Edxhbd24tXtbNI/PcMyQJ7zMGMrcUm8wVNlP9AFuX
	 Vtawe7rgTZN1djucsbmCNh775LKlIzoM8Oi738ZSNE50/mOYOWxQpQy8U7GOii4QJg
	 Bd22jZCvlMBgnmyxpULs1i4wMhxy9cM9V5xqEjq0MTzWSVg7Zr0cEi4DQy+UL/ODKm
	 C8JomoZI6kLQLTiBxoLX2xUHxlNMvwbFcLvLio8teswKF/ZQZVqECMdyeDM45Map6j
	 uik1xyZ95cBBui0QFSMSrYlQGGiNBog4FGZOr7PuPybXp6DwcUY6sZZCObMis3+aN6
	 r9fA/vTjKAjvQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 09:52:41 -0800
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: linux-mm@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev, shakeel.butt@linux.dev, sweettea@google.com
Subject: [LSF/MM/BPF TOPIC] Cgroup v1: timeline and path to removal.
Message-ID: <7a5619a6d27119fcf566e43563a72396@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[dorminy.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dorminy.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14379-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[dorminy.me:query timed out];
	DKIM_TRACE(0.00)[dorminy.me:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sweettea-kernel@dorminy.me,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lpc.events:url]
X-Rspamd-Queue-Id: EEF6119BF48
X-Rspamd-Action: no action

Hi all,

I'd like to propose a discussion session at LSF/MM/BPF 2026 on
establishing a concrete roadmap and timeline for the removal of cgroup
v1 from the Linux kernel, acknowledging that this likely also needs a
discussion at LPC. This would be best suited as an MM topic, I think.

Background
----------

The ecosystem momentum toward cgroup v2 has accelerated significantly
over the past two years:

- systemd v256 (June 2024) disabled cgroup v1 by default, and systemd
   v258 (September 2025) removed cgroup v1 support entirely.
- Kubernetes 1.31 moved cgroup v1 support into maintenance mode;
   Kubernetes 1.35 is the last release to support v1 at all.
- The container ecosystem (runc, containerd, Docker/Moby) has begun
   formal deprecation, with maintenance commitments extending to
   approximately May 2029.
- All major cloud Kubernetes offerings (GKE, EKS, AKS) now default to
   cgroup v2 on current node images.
- All LTS distributions to my knowledge have released their last version
   with a systemd version capable of using cgroup v1, e.g. Debian Trixie.
- Work has proceeded in-kernel to isolate cgroup v1 code, starting with
   the memory controller [1].

At LPC 2024 the Containers and Checkpoint/Restore microconference held
an initial discussion on deprecating cgroup v1 [2], including a survey
of distro and application EOL dates [3], but the kernel community has
not yet committed to a concrete deprecation or removal timeline.

Proposed timeline
-----------------

I'd like to put a concrete proposal on the table for discussion, 
oriented
around the assumption that 7.4, 7.10, and 7.16 are LTS kernels.

   2026:           Complete separation of all controller v1 code.
                   Introduce CONFIG_CGROUP_V1 (default=y), required for
                   any v1 code to be compiled in.

   Kernel 7.4      Print deprecation warnings when cgroup v1
   (late 2026):    hierarchies are mounted.

   Kernel 7.10     Switch CONFIG_CGROUP_V1 default to n. Require a
   (late 2027):    kernel command-line argument to mount v1 even when
                   CONFIG_CGROUP_V1=y.

   Kernel 7.17     Remove cgroup v1 code from the kernel entirely.
   (early 2029):

As I understand it, enterprise distros shipping LTS kernels (RHEL
8 = 4.18, Ubuntu 20.04 = 5.4, Oracle Linux 8 with UEK, etc.) will be
largely unaffected, so EOL dates are not a constraint on this timeline.

Proposed discussion topics
--------------------------

1. Kernel-side code isolation (step 1): The
    memory controller v1 code has been separated [1]. Let's isolate
    the remaining controllers (cpu, blkio, cpuset, pids,
    etc.), and can we finish doing so within 2026?

2. Remaining user-space blockers (step 2): Are
    there applications or use cases that still fundamentally require
    cgroup v1 and cannot migrate? A known pain point is mem+swap
    (memsw) accounting. There was a proposal last year to add memsw
    for cgroup v2 from Tencent [5], and it is an ongoing pain point
    for Google (where I currently work) since 2019 [4] -- how are
    companies dealing with this and any other pain points?

3. Hyperscaler readiness (step 3): The major
    hyperscalers are at varying stages of v2 migration. Meta has been
    on v2 since ~2018. AWS, Microsoft/Azure, and GKE now default to
    v2. However, Google continues to work toward completing its
    internal cgroup v2 migration (last presented in 2018 [4]).
    Oracle Cloud only switched its default image to Oracle Linux 9
    (cgroup v2) in May 2025. Alibaba's latest Cloud Linux 4 defaults
    to v2, but Alibaba Cloud Linux 3 (still widely deployed) defaults
    to v1 and was still receiving v1-specific backports in 2024.
    Tencent and ByteDance have large fleets whose v1/v2 status is not
    publicly documented to my knwoeldge. I hope to solicit any remaining
    migration timelines from these companies (and discuss Google's
    planned timeline), and determine whether any hard v1 dependencies
    remain that would block the proposed removal date.

Looking forward to the discussion.

[1] 
https://lore.kernel.org/all/20240625005906.106920-1-roman.gushchin@linux.dev/
[2] https://lpc.events/event/18/contributions/1807/
[3] 
https://lpc.events/event/18/contributions/1807/attachments/1613/3344/Deprecating-cgrp-v1-Kamalesh.pdf
[4] 
https://lpc.events/event/2/contributions/204/attachments/143/378/LPC2018-cgroup-v2.pdf
[5] 
https://lore.kernel.org/all/20250319064148.774406-1-jingxiangzeng.cas@gmail.com/

Thanks,
Sweet Tea


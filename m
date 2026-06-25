Return-Path: <cgroups+bounces-17279-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GS7MtenPGqmqAgAu9opvQ
	(envelope-from <cgroups+bounces-17279-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 06:00:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719646C2A43
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 06:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tNwD1ur9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17279-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17279-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABAA30492A5
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 03:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753352FFDD6;
	Thu, 25 Jun 2026 03:56:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99023392F
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 03:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359768; cv=none; b=NkjQYQEmyZlVU6wyW3/rR4o0KzhboPnO34M+CfHMyLEcgAp2OxDu2QGVoGXIpbAadKxi/in3qy65DYU9Xgw5fjteQq2EEBptJsdTJMhycghCLttoWnU5lii8qHXTkEHYzOC34JMsldd8azXfKSFQW4rHAaQ9hsn95vy2vJeIIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359768; c=relaxed/simple;
	bh=i0aRAUFtI7aqAzKD4q0jr5L562kAcIUmoKjS1lDhZP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=VTZ+heRLQ7/nJs4avFsCFNrTIT6SNJSzi67ax4RkcaOPwJX6K5Iju/6XJxnfLaqCdj1GUoxLuaO8DlPD2pxf9q9RUdEh1xJSvVTFexgPjda6wEu7pAy9zWvmRjkT3KDJimy23TVdoWzVWNHIKhkt1eVSuMmQlbMqWwCa4L20iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNwD1ur9; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b9e755555so3893505eec.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782359766; x=1782964566; darn=vger.kernel.org;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srhS5i90p9Ok5lxqwOHZkSzHn+Lf7VA0N+H4FT65HJA=;
        b=tNwD1ur9T6rnXrFI83rv1VscADTwkgnGzWd3/8cXowET8MB7CWONP9LD8A1tY0SRrY
         0EmYh2+rrXPC+ozviEK86lZvkL1Ur9WahRbH4RzjcJgLj3LhrOFqMznBQ4vpU5QNT2jb
         oo+qFNzdsNXY3xQot7qGYa5aBYb2iLlmD+YpHbY/ch8gWEp8rrsrx/6pC/PcVKB0Gs1/
         E4UvohwcSm00Zugh6iQO3yBuzJWcnrI2oNbEXIA8vb+ttIucKGc2bjektnJWj1IAs7La
         AQB+ndJ7ShypndIVKhEx1nRanzRy5+2XZupX5GjytTV7PmRkzT6PCLtvrikUWPUxCKtx
         GNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782359766; x=1782964566;
        h=content-transfer-encoding:to:cc:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srhS5i90p9Ok5lxqwOHZkSzHn+Lf7VA0N+H4FT65HJA=;
        b=AhchrgOWdL+vk9ZSh3mBKnrDeHwtFVaLvI12/HTgw+Z9dbtrimnNhJiXZR+thbwc68
         uPjVw5pMGW9hmzuxX8smpWohmbW2ZHXYkXYxjt91tCzrH8oYoDi63cis1TcPf+Pr9fQ3
         b/O0TOf6R7PCZ/UV3qiDD87HvxFUf2qudMIl0Pc9vkOaaGpzo8PnfLFV7IISdDned+UA
         bZU2oSUz1rd2MqbjKsPpdjXXYjdnvb9wr4QvRCi4gKKETDcjuY36byIQvpSh+wU57S2H
         CR9qoEIOeSN5h06n0BXADT7dBa68pBQlGeBPCLjVrnnjnRQ49cbN9MJwqBztuJgMNvG/
         9ANA==
X-Gm-Message-State: AOJu0Yw4RDeY7Wtta977sytbwWUM912sqNZ2zWo8Q2EmAw7pEOw5zEub
	OgD2TeVglUsHNAbfPX+iP4S1NOXbXJ3knIKWvGTOLx9vPwDQl5ITNs5OmKaNvV/nwSY=
X-Gm-Gg: AfdE7cmcztHWoYB4MqL2n7m7UPkPj7Be4In19O05arzEFWMSQCe5QVeMRRUduJdsOZ1
	yLiL2syc1Fwgnd+O0rrFd+sRFj/Fq++kcPqID5NQPS9/MbAqUdFEELDbYOS+XXTHwu6o89Jxp+B
	ryiZUd7fMJJhNblhc/zvX2gDaqwn33KiOfkyDrISv4n7pSgmI3n086ytMW9o6BlLIG7PgofIyhk
	oRiI1HB4SdPOdybjzicyj41W4y92vbUvslpGK2SLeHlDPG2c0YU0FEbAfSqh2qvuP0OYztY/PE2
	t1eSlmLJoWwg7+X2PVFBu9s/nMkXkPQRW3cn2PDoTpA/47N/XXaZ+na29XE4zURzyoethVYjxaT
	vYPu6fXpeQpjF8u5JY/wu9grzp5oivwJHhZ/DJtnnatc0KiWNFyvnBLJqGVkEIaoRrJRwIqCT3d
	q6n/eJLqJTTYSvf7U0sfatgBWG1w==
X-Received: by 2002:a05:7300:23cb:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30c84dfad18mr1166720eec.23.1782359765690;
        Wed, 24 Jun 2026 20:56:05 -0700 (PDT)
Received: from [192.168.0.142] ([49.207.145.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm3867938eec.8.2026.06.24.20.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 20:56:05 -0700 (PDT)
Message-ID: <7959ba0b-c39d-4cb3-8269-482d1d593257@gmail.com>
Date: Thu, 25 Jun 2026 09:25:58 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@gmail.com>
Subject: [ANNOUNCE/CFP] Linux Plumbers 2026 Containers and Checkpoint/Restore
 Microconference
Cc: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Mike Rapoport <mike.rapoport@gmail.com>,
 Christian Brauner <christian@brauner.io>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Adrian Reber <adrian@lisas.de>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>
To: cgroups@vger.kernel.org, containers@lists.linux.dev, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-integrity@vger.kernel.org, criu@lists.linux.dev,
 lxc-devel@lists.linuxcontainers.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17279-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stgraber@stgraber.org,m:mike.rapoport@gmail.com,m:christian@brauner.io,m:mkoutny@suse.com,m:adrian@lisas.de,m:kamalesh.babulal@oracle.com,m:cgroups@vger.kernel.org,m:containers@lists.linux.dev,m:bpf@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:criu@lists.linux.dev,m:lxc-devel@lists.linuxcontainers.org,m:fuse-devel@lists.linux.dev,m:mikerapoport@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kamaleshbabulal@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[stgraber.org,gmail.com,brauner.io,suse.com,lisas.de,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamaleshbabulal@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lpc.events:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 719646C2A43

Hello,

We are pleased to announce the Call for Proposals for the Containers and
Checkpoint/Restore Microconference[0] at Linux Plumbers Conference 2026,
taking place in Prague, Czechia, from October 5 to 7, 2026.

This microconference will focus on current work and open problems in
containers, checkpoint/restore, kernel interfaces, and related userspace
tooling. We hope to bring together people working on container
runtimes, CRIU, init systems, distributions, orchestration systems, and
the kernel interfaces that make these pieces work together.

Topics of interest include, but are not limited to:

  - New VFS and syscall interfaces relevant to containers, including
    work around idmapped mounts

  - Closing remaining gaps between cgroup v1 and cgroup v2, and making
    migration easier

  - The growing role of eBPF in container runtimes, observability,
    policy enforcement, and checkpoint/restore

  - Mechanisms for mediating and intercepting increasingly complex
    system calls

  - Lowering the barriers to practical use of user namespaces

  - Attestation, measurement, and other approaches to establishing
    container integrity

  - Better resource-control interfaces and limits for containerized
    workloads

  - Keeping CRIU working smoothly on modern Linux distributions

  - Checkpoint/restore support for GPUs and similar accelerators

  - Restoring FUSE daemons and related userspace services

  - Handling restartable sequences correctly during checkpoint and
    restore

  - Support for newly added kernel features and interfaces

  - Shadow stack support on x86 and arm64

  - Support for madvise(MADV_GUARD_INSTALL) and mseal()

  - pidfd-based checkpoint/restore, including process-exit information

We are also interested in additional topics that may emerge as work
evolves over the coming months. Ongoing development work, operational
experience, unresolved kernel API questions, and cross-project
coordination topics are all welcome.

We encourage you to bring open questions, unresolved issues, or problems
that would benefit from input from others. In your proposal, please
include a short description of the topic, what you would like to
discuss, and what kind of feedback or collaboration would help move the
work forward.

Allocated time per session is expected to be between 15 and 30 minutes.

Please submit proposals through the LPC 2026 abstracts page by August 7:

        https://lpc.events/event/20/abstracts/

Linux Plumbers Conference 2026 will be a hybrid event. While in-person
presentation is preferred to help keep the sessions smooth and
interactive, remote presentation will also be available.

We are looking forward to your proposals and to seeing you in Prague.

[0] https://lpc.events/event/20/contributions/2332/

Thanks,
Containers & Checkpoint/Restart Microconference Team


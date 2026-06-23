Return-Path: <cgroups+bounces-17172-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HwHKHWQNOmqb0gcAu9opvQ
	(envelope-from <cgroups+bounces-17172-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 06:36:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB86B4042
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 06:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="tAtYyk7/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17172-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17172-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C60302C5E9
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 04:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DCC3A3E73;
	Tue, 23 Jun 2026 04:36:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9482C21C7
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 04:36:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189408; cv=none; b=AI6XDPZLuhggiuFi3kwxYQmPYN8baKUGPOxEl8z4GwdQDQU9GmZHCiSxhxGP5wXBiho2pVgu1Ni6O9033jgJVA4M9/cxc7Zl3dkmVWoVl4k7ZVzj4Jm14R5fbdAWvTdPawHOF0sFkt1NLrCqo+V7YWV32yMTXJutA7+sAzunDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189408; c=relaxed/simple;
	bh=n6nMMARM0X6AABdVweeX9/aLBCR+hwEeVXpsktkO1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BigH/2NVE9f4HU/CmcIQDALcB2kD+ket5yb7JUDRGPgnNAlXBk12+Kk82sXQppmYzAyGm2J5Ln2kzw3FdA40db7fYlN0n2sl93eNPFWzly71MZIjlggwb0mkF6CgNIbmeXtR1lTcw9rv+3s7mcMd1bBKruVtpvYSTSPlv2xGANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAtYyk7/; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84232e83ca9so2145962b3a.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 21:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782189407; x=1782794207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt3pySXLLxRAVS12q4gDT3vSD9nb/FdqPRExCFEr4zc=;
        b=tAtYyk7/kwuY6U6b/kwSJDbPDhSOeps5/twIX/P0H+K5XKpOMaM4DyI9JqkbugTZht
         lJfAT7x5l9mF5tgorMwaBNNy19L4/arNBlTuX9Dre6bGsdait44MK5qpExj3QEc3jIWb
         +c5YHo5IwhARGyIwEs0kdS4libgpgHzB6my9Zo47UN6CuPJ76F+C4GZM9xip90laapBu
         /64sAug3fjM8YKTNUnQgvpeBd2bpMPw4RwMHKlVDo3znnewHlHg9QgwBmmV/f2lfgm0h
         A5AkeDtv5gHduQLRjSDR1djwjl0mrhXls0+q/NlqLBvfr2V2yGu0dxuKnvZtq6R32qId
         TDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782189407; x=1782794207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dt3pySXLLxRAVS12q4gDT3vSD9nb/FdqPRExCFEr4zc=;
        b=kMbWKUuMwa1Ss+8MYCGUrHVHjHQ8XXvm+ob6gj+EcPbXwqBKwH/R02W/mWOaUirGSO
         X/3dUmQloeIaW0dQjdFeqt+MjzFo2z4fKIkCHCCTpEUOtxwy9uaEpjojnPusXsQ5VLfb
         ogJLNXcxiR9eB2SeUEyvaMhiBPUz25nCwtB+ykbp+9efvIDXfFlZOFdj8ZRzy4LfQKiE
         bqi8ljZwu7xqlUsNHJWYYwOoBCZ0q1rxFYXxicZuGqFWoxg/EBe6W8rKrBRzw1NSoVd4
         s6bIAZfqSc7M+mNviOXW5zeLwXBKRpvJ+2iqsXuPomY7+h4mSX9nkrdKPzIC5WKORvKI
         V8aQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nYDjIoFkCKvPEWGQC5jp52VGeWVq2tjXej4AhUqfA+D9P3zoPBe8Ljed+g59tn3YUK3TGIYC3@vger.kernel.org
X-Gm-Message-State: AOJu0YxnADVYPFlhKgfFW+h2etK11OR2W9CXVh7Ai2fJuJkehQr+T1oM
	f5e9RG3TRizJK+5gzUXSdKbKTWWlDdvVtiGQAlSpkenl9sKv1LURqs0t
X-Gm-Gg: AfdE7cn5aigDNashIy4kgKOqMwYW5ovQBzcXhjXLu2iEpnLIvYIQgABM5vHTsaIqxZJ
	E/D4lVwDxHjGAOxlM/GwNOlLaCHV3CYYwfjPq8NHBuGPgW2wVBsuD20ToL6otSyt5nQpbAbOUR+
	VPdqQaBUzWXg+AIwykUN6nLG9lXKo/HIiwxpVUm4ikRmGGqkPbqQU/KuCefkh1x633nhUnC8gjS
	Hep73G2OcozQuHedXleJwLWwfg2T3MTg3GVytT0HOKSuOWKuYbdOEBkLQpbaZHAyjDNfEcBORCM
	IoVV0LEY/B6fSDLXn40YBw8OT7MrN9vYS+IXGV3ilYeQf1sa5S2rhFGHdOjWf1gZS2m22e2kOM0
	rmTtJZFifl472IeoPVPNiEurMgp9viiQjFK4lYFyYwDv8WFDnZs+v/tFJodWa+3b3i7Bki1VTu+
	O9jtk+zic=
X-Received: by 2002:a05:6a00:f0d:b0:842:5ea5:5ff8 with SMTP id d2e1a72fcca58-845954402fbmr1535070b3a.42.1782189406881;
        Mon, 22 Jun 2026 21:36:46 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2cesm11059604b3a.2.2026.06.22.21.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:36:46 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 08/13] genirq: Add explicit housekeeping callback for managed IRQ migration
Date: Tue, 23 Jun 2026 12:36:41 +0800
Message-ID: <20260623043641.2391662-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87cxxnegqa.ffs@fw13>
References: <87cxxnegqa.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,chinatelecom.cn];
	TAGGED_FROM(0.00)[bounces-17172-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:realwujing@gmail.com,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9EB86B4042

On Thu, Jun 18 2026 at 22:27, Thomas Gleixner wrote:
> While this series might work for you by some definition of "works",
> it's broken beyond repair [...]
> Please coordinate with Waiman or whoever is working on it at RH right now.

Thank you for the detailed review. I want to clarify the timeline and
highlight a key distinction before proceeding with v4.

DHM was posted as RFC on 2026-02-06 [1], v1 on 2026-03-25 [2], and v2
on 2026-04-13 [3]. Waiman Long's series was posted on 2026-04-20 [4],
seven days after DHM v2. The development appears to have been parallel.

More importantly, DHM and Waiman's series differ in a key requirement:
Waiman's series requires "nohz_full=" to be present at boot (even with
an empty CPU list) to opt into runtime updates. DHM's goal is to enable
CPU noise isolation at runtime on systems where no nohz_full= was
configured at boot — a use case his series does not cover.

That said, I fully accept the architectural feedback: the on-the-fly
subsystem modification approach in v3 is wrong, and v4 should use the
CPU hotplug machinery.

We are open to coordinating with Waiman on a unified approach that
covers both use cases. Before starting v4, two questions:

  1. Is the "no boot parameter required" use case worth pursuing
     independently, or should it be folded into Waiman's series?

  2. For the hotplug path: is CPU-by-CPU offline/online the expected
     mechanism, given that you rejected the cpuhp_offline_cb() bulk
     approach in Waiman's v1?

[1] https://lore.kernel.org/r/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com
[2] https://lore.kernel.org/r/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com
[3] https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
[4] https://lore.kernel.org/r/20260421030351.281436-1-longman@redhat.com

Jing Wu <realwujing@gmail.com>


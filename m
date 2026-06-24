Return-Path: <cgroups+bounces-17214-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NTkDAGp6O2oIYggAu9opvQ
	(envelope-from <cgroups+bounces-17214-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:34:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8A6BBC98
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:34:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c+o57lgT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17214-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17214-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C07673045097
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDA388397;
	Wed, 24 Jun 2026 06:34:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC5388378
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 06:34:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282851; cv=none; b=K6foFWSeapcjOzboVpxzRiiubMKNcNoQ3VDkCPd1Jc9GpTtXJElApCSG7rq4OUc85u6ImzfZvjmnqgxuzxPNCB19HBClDFy/5nYFSQyIikuHk1CgQqPQD+xFrXVM+aRuXilC9FVDyYgNkByhFZSULRjCGqgK2vtbYUDBtRoLrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282851; c=relaxed/simple;
	bh=yFKVE1gDN/R4rptBShzoito5hCU5wF0GtrGLgkDuf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDP27bXRKyW0gy4X2ygm/RNXA1cJmQxU69/G7HRgu6qVuZOZPwWGPDod7kwNYXbG8UEJIahH2j0QtZ+36JFL4WS7jQTthmYT7xtzgtZmQc+6nGVWYAWsk2rcFRs7daJi0EscqAXiprg5liHdCfz330VRbFrdGGONThEfDoaG31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+o57lgT; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84347ad88edso797790b3a.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782282850; x=1782887650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkEtFGqDPkhp9SzmiZH6fjLwhoaBQ/zMPfZFx/9Imxs=;
        b=c+o57lgTysSOAqoM6OTxCfE/H7n3spgHU3iWmBnVSY3w3/oLHlBO+we0w/xRE20bbX
         a6vl8tcDwnDeCPA2RejuQ7IN49jbE0f4MJqrssP2xdJAKPaSmfyTooaRwogPaYCIDsr5
         0RnMEuIDtZNszNBXQ5bhtNnHBC+ZnBdvJx4D8ntQ1UzGr09qfqtpk/JS1FWUoTLNULCw
         582vgyKd31TeAC5fNPli+omtNvE3Io0Hzg126kkdQ3+0q0yN6WWnf2/b6CYbKfJgmPC2
         ut6q6jZ8UqEZNj+ty5ngaXBVLJmoIVNM4sj2CYWJZpQxRd+HmSBUTdRfpsododLG9pEZ
         DmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782282850; x=1782887650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkEtFGqDPkhp9SzmiZH6fjLwhoaBQ/zMPfZFx/9Imxs=;
        b=SVCyUsY96egSSjK8Ybqvd/QSiySqn9Z92sDrbnGKyzsRHvgUouVnYzndE+IOJf5wJc
         t7hx1GOB9X/OBm4SiPRBtlYQi6JKeuGcB499ASllREH7NnxXSMrs8Zvgc86TUe1sGNLy
         KAAATbJWCIZt4t35FhlXLU6vTHQ8c3Ea+gEsB8HcXJETTxDh6cwIeU7ulu8yQXBERJni
         a8J44PuvQNGcAiuxBiciVC50Bb97vYQ855E4kmzStmeNS5w7x8CETwT844JuEGSLAjjW
         cuEwtAni+WPTDl1VVGcBH+gtKiErTbn/gUldiCq5M+z3kFKyCXmLZSRow4VQ92P7k6Ys
         wgoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8X0XAlIsf6gZm+cqsbTJTRz0sbDoUf2xxMXTLLlowL4c3XitURrhKngPnS8lnHOuReD4kfGPfV@vger.kernel.org
X-Gm-Message-State: AOJu0YxR50yHsxJ6H2xylMHzomYeQjOg8nOmGPxWRkQop9Ate8I9yBEZ
	9qtdQBz3FYuEUBtBu3mTeanQ1LE87DGtdPLxteKADnF3z4Zwt6jZzWLx
X-Gm-Gg: AfdE7cmnX2vKk8iBA3/lHANvhgURILtumMShZAm5mmUpoR8Zh/W2gHsTklx5Ktdi1xI
	1WJHPl+c+u3Ncily8uxXk+idqWOk2Wi+mdoZhDgcE8xIR30I2nmajMsBvcSSsq95yAZ0HS+bujK
	3J0AC1bepR3bH/XVuzkdsi3emlMmNM3ipU9EdLZG8YMdm32+JU8lokAMmQyWPfDT+aX+1/FvQxI
	vmR0ZOwDbSuk95pYX/TFefiR3i4Y9ZHrVR7UPN5Ha1aNxb2aD9JToGhotswHv4vlSd746mdaV0o
	/mwh2EjpCzN/XJK3Cnm7mz/WtrY6cDmDb52i0nyHDL2/pIhuwheYQfV7+w8bv/T+rRSNf1eUn5j
	igl4ZCYQqPzkLMWXV8IAlWBujtsU2BTkHSPVTU2fVLW81iYIi3RHEcEdbw0km+1V1dHZpK7Uy2n
	EjrQGmg8Q=
X-Received: by 2002:a05:6a21:699:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3bd2cffd2d4mr2708731637.7.1782282849718;
        Tue, 23 Jun 2026 23:34:09 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc3172827sm11544089a12.9.2026.06.23.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:34:09 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Wed, 24 Jun 2026 14:34:04 +0800
Message-ID: <20260624063404.2106807-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,chinatelecom.cn];
	TAGGED_FROM(0.00)[bounces-17214-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B8A6BBC98

Hi Waiman,

Thomas Gleixner suggested we coordinate, so reaching out directly.

We have been working on a similar feature called Dynamic Housekeeping
Management (DHM) [1][2][3][4]. The RFC was posted on 2026-02-06, v1 on
2026-03-25, and v2 on 2026-04-13 — a week before your series appeared.
It seems we developed these independently in parallel.

After Thomas's review of DHM v3, we are rebuilding v4 around the
CPU-by-CPU offline/online hotplug mechanism, which aligns with the
direction of your series.

There is one key difference in scope worth discussing:

  Your series requires "nohz_full=" to be present at boot (even with
  an empty CPU list) to opt into runtime updates. DHM targets systems
  where nohz_full= was never configured at boot — enabling CPU noise
  isolation purely at runtime without any boot-time setup.

  This requires making the nohz_full infrastructure activatable at
  runtime for the first time, rather than just extending an already-
  initialized boot configuration.

Before we start coding v4, a few questions:

  1. Are you planning a v2 of your series? If so, what is your
     timeline? We want to avoid duplicating effort on the subsystem
     patches (tick, RCU, genirq).

  2. Would you be open to extending your series to cover the
     "no boot parameter" use case, or do you think it is better kept
     as a separate series?

  3. Are there specific patches in your series where you would welcome
     our contribution directly?

Happy to collaborate on a unified approach.

[1] DHM RFC (2026-02-06): https://lore.kernel.org/r/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com
[2] DHM v1  (2026-03-25): https://lore.kernel.org/r/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com
[3] DHM v2  (2026-04-13): https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
[4] DHM v3  (2026-06-18): https://lore.kernel.org/r/20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com
[5] Your series v1 (2026-04-20): https://lore.kernel.org/r/20260421030351.281436-1-longman@redhat.com

Jing Wu <realwujing@gmail.com>
Qiliang Yuan <yuanql9@chinatelecom.cn>


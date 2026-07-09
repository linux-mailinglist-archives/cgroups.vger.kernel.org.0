Return-Path: <cgroups+bounces-17589-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UHxSCLEJT2oUZgIAu9opvQ
	(envelope-from <cgroups+bounces-17589-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 04:38:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB572C065
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 04:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gKqSMIYA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17589-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17589-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C1EF3007655
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 02:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69151366DA5;
	Thu,  9 Jul 2026 02:32:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C28364053
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 02:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564350; cv=none; b=sYgW9w764++HvpsDURufovUcWM4/740UhyiOvQx+gWETBWy0r8JF2Ugw8wcMBlrsUu5X0oXUhDSYIWRSd+oET2aCQfjmNie0rG/6NwG6qxJEQaz0ANyxAIwoJ7ZPZvVuifEXJwmLvLT+muhg4aorxdQFyJiInsCa+bu5J4xmLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564350; c=relaxed/simple;
	bh=lkIEGCAQB9zasZeDMyaogtJAsY/y74T/tGmONLBNQ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkYXREFfv/bMOap7U7YBlwe9m0kmdrub4ocPJuCrQ4ZRszfER8rpydy6hrpruAAD5NY6a5WkdTJ1Sg0EftCCn7upOR0u4/CyPfviGwwxkXnzVOfm71C2Z00YjywwLjm9MsSdiaim5KDI+p7iM0hYzNKBQCdw4VBwj3HxoSLJIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKqSMIYA; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso13968065ad.2
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564348; x=1784169148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+15WoPo9JZ7YZJgmoBicVekPX6+Bo4zcfrfvSoymnE=;
        b=gKqSMIYAP5yxJmdOdbX1yuJ/esOPdQaIyPO0GgiCbfxFp6pFAwo8em7XViI2UNrBr+
         3N5Cnw0XS2qyX6ie9EEcb1vbf2Kw4cU/5CFA9151mrw6AwZ9gn67nBEUyeVOjaBqhj8u
         9WSQoDW4/REadcOP3OGYyH9eThTb4AxGtmZ5QF4gw16pxVUZlD6jiPg93ZYQ9R8ZTsga
         kGaNXKCdVpzGWywzR/wgGmLFo1TasyslIgyt9puSzfs1IZlXECuMHp2ZDenr0XVtVtIh
         SAEKsIc9W/TQexG3dp5GfExtzwVvvSf4ocJPWxr2qhnlCO/3TE8bNQXRR+ICYlkSI+Lc
         fang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564348; x=1784169148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+15WoPo9JZ7YZJgmoBicVekPX6+Bo4zcfrfvSoymnE=;
        b=N94R5lI5iisLMfoouVP+syWy6pgRvttqeVDYJBY8C1VwZV7tNiKAPc3sIqguxwpEBI
         N5sE+qNy7CGFPc3IZg1Z7i4zGFBchFVGrTLFOIPx/1sbgWEabw77soMEqsQKBetxOHVY
         zohucInOHB1X+O/P+dZtPQfnlFH2LuWdxw011QgAk0Sw0QEGRR3Z/a3THdmmXHr5OAXk
         Iwp74W1Stwo5BRPqAMmy15eA7MwN4S/GxmduLDCsmWgPQQs3viBj7XK49k92hWm45nL+
         oG9dCs9t0qVymvW1yDYKqYwfA4AW5ELD4t8I8Kbs+zjg5kaW7dI7E9s8lAyce5B0N9sq
         emTQ==
X-Forwarded-Encrypted: i=1; AHgh+RodhaoZx3Kmqv06Q7JbWpzmjbDhEBcbodvZgU0w/9yo6zHrAprz+XqWvtxnJVzyp9khTBtI8UOD@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXFChkdZZ7uKYcgVSqGPe9XKwP9zmyEx+9j3W7ueF/7xxpp2U
	ehwahg3UEo57ULxD+Zq7+7OWUA6R6Z18Ty+eCcYmgezj8x26ZUvSeAQG9rW4ictsxc0=
X-Gm-Gg: AfdE7clkOsBcFPeDZUg/Nua3zgbFRCU3/rFB9XIbeggvzVcPYfFmiNSKVtp3lTkIX1u
	vrzJgaAr33MYDpnE9j8sr26gQ1PjHJYZI7IoRPzz/RVguTEdYTqPj79e2pAelGXO7aMpQzVUv8A
	Y/FolJC4xoBYL1e90EI8WY7y9N6SdD5mGpwoXDvXbkBvJQnrVIpTdS3E9GXswL9uUIaDsPuK7BY
	8HjNp4PVQGHIJAa/wP+AjA+zD485e5wccd+UD3QjLJTo8T8SAPowOTOVt+yE+CBiPF8RBWdGZOK
	e3j6X4368D6shfVnkhNqgroUUe/VWqCwoWmSn0BzIbPBzJyfmjBcLkEGA+n1vFckwsCh+DKI8iw
	36TiVg+jGSlSAPhWtS64KPOzdF4mxKBq1xQT5wmu+YNm9o14kFS6BhmwAoPdRmG0ia4ku3zRggq
	PdI0v1vdE=
X-Received: by 2002:a17:903:298f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2ccea3485b7mr64177845ad.5.1783564348234;
        Wed, 08 Jul 2026 19:32:28 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bde9sm35795005ad.79.2026.07.08.19.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:27 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Thu,  9 Jul 2026 10:32:20 +0800
Message-ID: <20260709023221.634684-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702033934.984512-1-realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com> <akUii2CyEi7SRid7@localhost.localdomain> <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com> <20260702033934.984512-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,chinatelecom.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17589-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:frederic@kernel.org,m:longman@redhat.com,m:realwujing@gmail.com,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CDB572C065

Since we offered to take the RCU/nocb piece, here is a concrete shape to
shoot at.

Constraint recap (kernel/rcu/tree_nocb.h): rcu_nocb_cpu_{offload,deoffload}()
require the CPU offline (they reject when cpu_online()) under cpus_read_lock +
nocb_mutex, and per Frederic the toggle really needs CPUHP_AP_IDLE_DEAD because
callbacks can still be enqueued before that.  Reaching IDLE_DEAD pays the
stop_machine cost that disturbs other isolated partitions.

Observation: among the kernel-noise types, only RCU needs that deep offline;
tick, managed_irq and the watchdog reconfigure through the existing online-side
callbacks.  So bundling RCU under HK_TYPE_KERNEL_NOISE makes every isolation
change pay the RCU cost.

Proposal:

  1. Split HK_TYPE_RCU out of HK_TYPE_KERNEL_NOISE into its own
     runtime-mutable type, plus an immutable HK_TYPE_RCU_BOOT snapshot.
     HK_TYPE_KERNEL_NOISE keeps tick/timer/misc/wq.

  2. Gate nocb changes behind an explicit, per-partition cpuset opt-in.
     Default off: partition changes never touch rcu_nocb_mask, so no spike is
     inflicted on other partitions.  On: the isolated CPUs join/leave the nocb
     set, paying the offline cost once at setup/teardown.  This is Waiman's
     admin-choice knob.

  3. Do the toggle inside the serialized hotplug transition at
     CPUHP_AP_IDLE_DEAD, rather than the remove_cpu() -> toggle -> add_cpu()
     dance our v3 prototype used, which raced with concurrent hotplug.

Open questions:

  - Frederic: is CPUHP_AP_IDLE_DEAD the right hook, and is a new cpuhp callback
    there acceptable versus the current post-offline API?

  - admin pre-offlines the target CPUs (your earlier suggestion) versus the
    cpuset code cycling them via Thomas's per-CPU down/up primitive?

  - does the "only RCU needs the deep offline" assumption hold for tick,
    managed_irq and the watchdog?

If this shape sounds acceptable we will build it on top of your CPU down/up
primitives.

Thanks,
Jing Wu
Qiliang Yuan


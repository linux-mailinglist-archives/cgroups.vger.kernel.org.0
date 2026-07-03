Return-Path: <cgroups+bounces-17459-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id udfVJa1SR2qvWAAAu9opvQ
	(envelope-from <cgroups+bounces-17459-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:11:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F16FEFAF
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IL8OWiAY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17459-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17459-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61D83020AB8
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C03783C4;
	Fri,  3 Jul 2026 06:11:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B35360ECA
	for <cgroups@vger.kernel.org>; Fri,  3 Jul 2026 06:11:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059110; cv=none; b=MWWW6P2WcY+igG9+Qbo3XxoVg9qnHePZYMpY/TN1vTmQ/JXd773a7c8Bt+z6p35OQRx8Q/XnzA8OplAdcwRQjvD5smcN//VyzXlle6ICt+VURipR+/NRADIPuywCPcZD7vDk3TQNtWhJvjqxqvBZkkgsLNCmMn7ssav3pXtvL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059110; c=relaxed/simple;
	bh=jOhOP6zR2h/Ko2CFKX5hAJT4zH1NZT/juuyNlpCE0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjlBd+2ILQAWgyFNbUR6dqngfTTYo3Uqjt7yVjOBP6pPaIO1EUiDYirSGc+Du4Orp4Gwk6JbCN8NnnQxWq0SoqLYwSysBCEIfQJ+HS6naXkJgrsrsfqJIAiYibzaObhZhhYtS+F29G+vCe/eB7fE5+fbEpSbrHPq5Bv2MCsN1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL8OWiAY; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca265d6ca1so2485755ad.1
        for <cgroups@vger.kernel.org>; Thu, 02 Jul 2026 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783059109; x=1783663909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFrb1IqVlH/teSzvkSHFKk5+RmoA+DXh7g7twprTIs8=;
        b=IL8OWiAYAZZADjusMjzXWq90HTnB9McJ3hlaB3Ws74uCO0Vgy4QwCjUoLNhszOfbcR
         Wcu3QVuCN+pk4qQbJ2lOq8IYRyVDp8h3Vh/8k7e5gtc7FEF8+aoMsST9IgUJjFow7wVF
         AbTbbG/Rtoe4X8Y7kxUFc3uXQF41LD2VW6d+pqIY0JWlasMnoXBVlaheO9tpiPtkI8EJ
         2OewQDPwCwvd9NHov/l7QJAoFXn0AF4GTgIGMn/SVe7zTjfzvuwK3XaizDJBRbq4pfTT
         s6RCUMAKnY717O6QKSZf4yarg9DTsdJCTnigJ3MDl3v/sJMxrSAi8o+/lG/fH+TxUilE
         ZRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059109; x=1783663909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFrb1IqVlH/teSzvkSHFKk5+RmoA+DXh7g7twprTIs8=;
        b=mlkaJmNXsRGENsVS+SyQZrnTU9ytBS6PkZbispO/OoYGaOQ38bpbnrkOt9u4a90Tss
         hwzYZ8xh5zhlPVo9mlME5PRnWU2QQKDcCz7O0mREeN4IeZUIGalf2O8jgMFpsNOpGkU+
         o148qfMFLRI8YSTdt7gbs2yHU+iY35HPey+bEBXHQvUDtBz0KM/ILsid/Wv+G1IloO9s
         wYV2/NwX4aWpZ2qQbRl7UDw7sv4gSvM+cWmLvn6VX6S2stq50hIDKGiozaSn13CKgkGs
         GXFwBMFGIXzlskvIkdV5OuwGQn9TgVv7MtC3WFmVU3ky0XKodWOZHTXRdTIYQs5gK0pB
         6AeA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6KKh6yh1FUrN2gXVgSwIN07OFEr4hGCBtUnBRZmih8RdyvL2kCyoTs+x/l3gcFd3s7movv6ED@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmQiFwecdrd2HHPLVBmsUaNqLUahUJRhAZO7BIGiJybQZROYo
	jN83t0qMt2w+/4W5ahWzFJJb7AP2YdcV6Kk9Feo/Lowo6VRo7ig4NdT2
X-Gm-Gg: AfdE7cn6rXGUaI4gSoTbeCWTpjxaGqkBj+OTVY9RYcQsKw7yBWBkdzacE/n4E90n4RQ
	snqMVGDKJt5UV25x0dh51tj0IL//yPB0W4huKdz8KrjyTFuaKNOIEDwlPkU4sq6j1gfsSzKKuRn
	eLvABMY6GWAY01t55IvjtC6tXv2kG5YfdnxuSqD0BPRgyzG7gY1DirzzEOlIglae6rGTXeYrFh4
	gX3YRptjHY+ft0TQoWJCbUc2+2eFZyCL7BUUipA99uXOu3KktS0N7knXZuFiRoItHXIlkrv/DA7
	dMvZVnJBnvM3F6rN5+bkyVwzb/1SCXXi+Lep6DFHz/ej1+rW/eqEfvPAQ9dYvVbFpBsZAl20KTy
	HLUIfs04OQb1eGJwO07+oJn5kWhaInJbFCgaxcZusk/jVceQBGQwyRhZSf/ZcXgpbd8WbXGiOVm
	0GZ5k3rjvWe0x6v/lVkQ==
X-Received: by 2002:a17:903:904:b0:2ca:783d:c5dd with SMTP id d9443c01a7336-2cacacbc837mr35504525ad.8.1783059108851;
        Thu, 02 Jul 2026 23:11:48 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871290sm4162635ad.65.2026.07.02.23.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:11:48 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Fri,  3 Jul 2026 14:11:42 +0800
Message-ID: <20260703061143.1658605-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4b9bfc1b-2724-4507-b2b2-81d71eb79841@paulmck-laptop>
References: <20260421030351.281436-1-longman@redhat.com> <20260702033934.984512-1-realwujing@gmail.com> <871pdlphcc.ffs@fw13> <4b9bfc1b-2724-4507-b2b2-81d71eb79841@paulmck-laptop>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org,chinatelecom.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17459-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paulmck@kernel.org,m:frederic@kernel.org,m:realwujing@gmail.com,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A2F16FEFAF

On Thu, Jul 02 2026 at 16:07, Paul E. McKenney wrote:
> wouldn't it work better to just leave all CPUs in RCU-callbacks-offloaded
> state?  Then you can adjust the nohz_full state of arbitrary CPUs without
> messing with RCU.
[...]
> a continuous stream of race-condition bugs inspired the current state,
> which is to allow this state to change only for offline CPUs.

Thanks Paul.  That is appealing, and we would much rather not wade into
the online offload-switching races you describe.

Let me lay out the one tension it creates on our side and ask how you and
Frederic would like it resolved.

DHM's aim is to enable kernel-noise isolation purely at runtime, on
machines that did not pass nohz_full= / rcu_nocbs= at boot.  "Leave all
CPUs offloaded" needs the candidate CPUs to be in rcu_nocb_mask, which is
only populated at boot.  So the RCU part seems to come down to two options:

  (a) Accept a boot hint: require rcu_nocbs= (or nohz_full=) to cover the
      set of CPUs that may later be isolated.  RCU is then never touched at
      runtime, exactly as you suggest.  tick / timer / managed_irq /
      watchdog stay fully runtime-adjustable, so the "no boot parameter"
      property holds for everything except RCU offloading.

  (b) Change the offload state at runtime with no boot hint, which is
      precisely the online-switching problem you and Frederic hit, and what
      Thomas's lightweight-offloaded + CPUHP_AP_RCU_SYNC sketch would need
      to make cheap and race-free.

We would lean towards (a) as the pragmatic first step: it keeps RCU out of
the runtime path entirely, per your recommendation, and only asks the admin
who wants runtime RCU-noise isolation to declare the candidate CPUs at boot.
(b) / Thomas's mechanism could be a separate, later effort if a truly
boot-parameter-free RCU story turns out to be wanted.

Does scoping the RCU part to (a) sound acceptable to you and Frederic?  If
so, we will drop runtime nocb toggling from DHM entirely and just document
the rcu_nocbs= expectation, leaving the other housekeeping types runtime
adjustable.

Thanks,
Jing Wu
Qiliang Yuan


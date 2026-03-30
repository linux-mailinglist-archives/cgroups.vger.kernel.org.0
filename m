Return-Path: <cgroups+bounces-15104-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJWDFVljymn27gUAu9opvQ
	(envelope-from <cgroups+bounces-15104-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:49:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8735A887
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 284853010737
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF83C9437;
	Mon, 30 Mar 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQjTBw80"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF13C5555
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871181; cv=none; b=ZXWsSRi4M4eOorDyS7R495JcuLQtd9+rKckPyRqASz6a4M6B8sD77qbwcWYhshTGVK9fclW0a1GyYYxy2r08wvVSZjFmdWiXGRRtNREK7399EQgFOOLiVvdibFg182U+Exas0ZT0lFxFHRVLDlh/uluuBBIjx9fb1FihLXlmrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871181; c=relaxed/simple;
	bh=qTmtyABsMZxVL7dEpA9F+DSHfsWRV7AZpPMrHUVPxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYggFLUiZbN2ZGJdPmZlwDaNAUvOV1D6ea1cd4Gh4PPvrYLRSqAV9LyzHKw77gnhb2w/KSl2QVoCgpg7KX1E6MeBpmjVGn15LurkzlQNBZeA1BrrD5CDim6KIF8Hr6aUgsvIHvPkkoE0Ownqi6Hkrj05IRbEzTHKiT14fuoeM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQjTBw80; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12776bebe9fso353374c88.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871180; x=1775475980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88r4nrovufv2sJYIOMDGEaf/zyrN4LEqGmAEdjsIQK0=;
        b=oQjTBw80G6CPbV3xb9k8mHMMY66IwAMSWDkSUVihulzz4295Y2owI2WWIbWYbEYf7J
         8l5zspwZvwaZdE2B33Q9sljA5SQvXuRWRLvf7ZNEJuDVyGDszJ8V0nZDlTWWIliaxD7w
         I3STYj8BCUXAW+GgN0aKo/crTBlkkH0MpufaDThuc8MV0/qwvjuOaxSHizaZYmLpvn4o
         0mIfsL/6SkCYJtHrin0XJogiSfOT5oBLGJieUnU7hVhc8wYWf045jWgjvjS8/OijfcBT
         pxF3U92ZF9BtGwpfvlZlPaVT8tch9ocb+2ECdesrqPUclcn7wMB3f3hmPA/PkxnLGETK
         CeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871180; x=1775475980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88r4nrovufv2sJYIOMDGEaf/zyrN4LEqGmAEdjsIQK0=;
        b=SGzF2niAA9zxy9rDrfDV2OLIXEF+uyxy9M0eKFxT6x17/rrEs5Mabj5NdjE7urV0bw
         0m+alr6yPN3NULJYIzX1W8EsZa8j9jZEdpKxeXrcmAbrKb+VP9PG4/5d6yiTax85osj0
         yyvDIH//J2DVpdEeuBjntcNrDnSJrJsocCdDU3O7NQ1CYEt2vs1rL+ZhFvWmUmlPNg7d
         5DY8IeQWBxSBNeYiqQbs3ltAgM+Feaux6/Fa1ED3NhzAo0Q/asNhPMMJb3DBkv/a9w8A
         xifk7aastZbNYlJj3hBOqxt1F0EFaosuy88PrM6JSWjECKiYb1A7vKnj8nG7P3VlRTPi
         Vjhw==
X-Forwarded-Encrypted: i=1; AJvYcCWulF9f40rpuSMjhR/HCjpw9zS5Te/jbAvck9jAN93rQhavYEDBzSNlGHXURIlONYu48zrTqr9o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9LX0HICDWxm3wF63HwlyHglSxnJD9J5rH7keveo9kOKrO7Rj
	WkhmWiXeLYSauiAWbPeaOVk5T4ppLhosGvDSla7ky0RXsloep19z/Cem
X-Gm-Gg: ATEYQzxsS65fv7BmHgXkkVw3SiWE7jgYhZFB43QNQOhYc65oVH+M65wF4S0kdaAY840
	Un0/s656KiBHW/tVpyLf/mL7LYjj1kvFWNIPZPB4EVIVDxKvnVRfBPhU2Ro1giCUVeKa45SJr7f
	OjFWK57IB1D9Q21vVO47yhT22wD8cPp4C5wlgw49pa4wefslo7F+7MF5kHpaFxDtBqFPUJf/N2p
	TolJB++hJ8Qnlkog4Fb2M3koRCOeM3WT8HM7vlUnBMVWBBoAr/bhQea5H4qztucJzmd56JXby4t
	IvQ9YzGKfPJ0QevdBwaSxkSfoUiOG8K0qlhW19pBcMLrRSoxDOj0e4olG4+St2YF1haoCr141LN
	L6JzAKO22CyN5QRrAl3XdCQGZiRBqA2YbMcLf+PMryQj+v5kTFhwIy+04Ox5evX+vFTyXKNk4Ws
	pOsmgQ0VhdyhJQQ1c9gYecanBLWML/ovI09lg=
X-Received: by 2002:a05:7301:3d06:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2c6cdc30b84mr964511eec.28.1774871179502;
        Mon, 30 Mar 2026 04:46:19 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9c088sm6703832eec.21.2026.03.30.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:46:19 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: peterz@infradead.org
Cc: longman@redhat.com,
	cgroups@vger.kernel.org,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	boqun.feng@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jiangshanlai@gmail.com,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mhocko@suse.com,
	mingo@kernel.org,
	mingo@redhat.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	tj@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 07/15] watchdog: Allow runtime toggle of lockup detector affinity
Date: Mon, 30 Mar 2026 19:45:46 +0800
Message-ID: <20260330114546.103726-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325140324.GD3738786@noisy.programming.kicks-ass.net>
References: <20260325140324.GD3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15104-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65B8735A887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:03:24PM +0100, Peter Zijlstra wrote:
> Why would we want to toggle the watchdog? It's linked to the 
> TIMER housekeeping type anyway, right?

Yes, it is. The original patch had an independent toggle that felt 
redundant to you, and I agree. The watchdog affinity follows the 
timer housekeeping state.

I'll simplify this by removing the custom toggle and making it a 
guaranteed side-effect of the global housekeeping state update. 
This keeps the configuration simple while still achieving the goal 
of keeping the isolated cores completely clean during dynamic changes.


Return-Path: <cgroups+bounces-15099-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONcIGsJjymkj8gUAu9opvQ
	(envelope-from <cgroups+bounces-15099-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:51:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B935A920
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A34BB300879C
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1013C7E11;
	Mon, 30 Mar 2026 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QriGvYrj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93243C73F9
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870914; cv=none; b=JLBGk9mhzOIJfR6URD7ChyD7XQS1IEg0CSZLvqQFJ3+m6zWnIfYCaVtDK4SiQRNRIXO32Qj4hGLeHYEgLBfVCdEc9h08K+6NRqAHoA7OIIY0AtG09mPhxaSJPWTFpoEbB00EDP+uezOu3pw/etR23mNOddw9QiiE0cEmUfPGRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870914; c=relaxed/simple;
	bh=jy4JXObkxn6zs5G9yFF18bF4JPw9+ojVLYoPuhxyOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfGKTAdqqBcM0RxnIKrNlrAfhy4KUNk3PMZuwafxTgDXPdt7ywSSrT/z1a2EVHGa94yq9jDgBiH5zSI6OeFsgWiTRQ4uZAllSlrJDkT5mO37KA1LM7DLB1SPLgot39dByu5s25OXIq9cgJKqVWw1kbVsNphhDIp4ywkEVQhS2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QriGvYrj; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso5956532c88.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870913; x=1775475713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8qbAM+0abt2Xsw25EiZl6rgD9G86cRKj274QNi4sMI=;
        b=QriGvYrjwcEeiOdDxdSPz/bkSiWT6RprRk+aTdrU2IXcqAPLIIhrTbv20Y+e0dhseY
         Q6r8j/TvYKLQIj64d40XvKCLikE65OUcr9lsDIbDBfzevvQmrfICTTrl1AkZ0mT3MwBy
         kk+8EQSmsb3TvDt3+bRl5Z3n+oLHVlWlkceSFdx8sDA8tbA97aPNzOE85nMfrkfdTOga
         wEGna2Z2tclWxx/xa3UKtYNaAOV0gEWT8seRD8DkFFIwERMaDsSr6X/YmTiL4xvZSWQs
         skweBd8wYRqUIIju2jZDYepRhI90NFLR+VFsZn4fEMP9zXAweOksr0VKRhoJN49x28b6
         0DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870913; x=1775475713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8qbAM+0abt2Xsw25EiZl6rgD9G86cRKj274QNi4sMI=;
        b=IDTKrOfsV6Q1To83yJaIML/3On36JYjUwSrnUeKFsCmIeFID+iZj4uxe2cR7mfOcJt
         9Lj3t+Ny7qz18rQJKyBfyoghmbS/tqYTMTeiuQFGX4KS1jrxr0T+setY/Ob7LEDk9cJk
         ezX71n8HeLjDWCG0Hth1K7JQ5MSarhLjCPWS2zvZgq42ajI/VyqtzGrwv++1T0y8CHNb
         GXhjb+8viqoCOMo125JxUwH7aTKr46l9UO5EVJB/rkC/bT/png/AsfnSje/RPFjKK0yy
         YJpJdYu484248SS2sDB40EZL+HJTLnbyH8ncqNRP423LVwb2GKsKZOEkeyZeYFgmXn20
         m5zA==
X-Forwarded-Encrypted: i=1; AJvYcCUkNXAAU+fYjmz8vWCkTStHxUo4jN5nEkcMvYevfAZjF0RfnRCxZPUB14khrL9nOhYQjBVRhxkt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxph6c+7YYOnkwDA0a5wGOWevJVvb1ZYUJDoWBfiH8xn/at06RP
	T+I23FiL1/6cwAPuOBmy5cVB7ht0knbEC0Sky/Vfpd30DAG4eqzksW1v
X-Gm-Gg: ATEYQzypCNqrYFsAM+bEOFDxFMbePrrj28dak5Bl5kdSfmrAgIdPK4/G9ZXRsciazb2
	YCRO4GH/5IljdJrQnDndfb51U3wo13ACHSeHFg3P7gZzEf1xK7SS8mhCnZ73c66wG/Ch/CcXKs3
	yLsp0HiO5rqnTKVcj5meaXQdlQ79DBpVe7XFldgs2t1c/aSfrLdtaggdHT0AXhG6ARetUqiBTHf
	wjCn7I4JVyAetiyhBR5wslw/93dsdxcr/v3/pXOZMfW91BK8E8f3Yyv4ufmoIte1OjyGtzxlHkV
	2ky343W7PmXlcPZszMLuxKgA2qbrWMs8RwajUmmfKC08CHJoyn7nC9OtV9FCet+7p2SOT9AwMrY
	KZDYO6/2/NW2Uon+DmiFFynesE+3Mc81rh6QUCIoUdxzjBI4/GE7eqgnMCByggmBfUmcrSkrLAs
	vUqgMqsmaDoQ8SKJHikk6BMz2XzS/YyBx64EY=
X-Received: by 2002:a05:7022:4393:b0:128:d396:f2e2 with SMTP id a92af1059eb24-12ab2857b2emr5938952c88.8.1774870912754;
        Mon, 30 Mar 2026 04:41:52 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cad88sm7602987c88.1.2026.03.30.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:41:51 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: tj@kernel.org
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
	peterz@infradead.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 00/15] Implementation of Dynamic Housekeeping & Enhanced Isolation (DHEI)
Date: Mon, 30 Mar 2026 19:41:21 +0800
Message-ID: <20260330114121.101232-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acQHKwGhYrpoOH1P@slm.duckdns.org>
References: <acQHKwGhYrpoOH1P@slm.duckdns.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,infradead.org,linux.dev,goodmis.org,suse.cz,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15099-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 067B935A920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tejun,

On Wed, Mar 25, 2026 at 04:02:44PM +0100, Tejun Heo wrote:
> This needs to be coordinated with the existing cpuset and isolation
> infrastructures.

Thank you for pointing this out. I agree that coordination is key to avoid 
fragmentation of the isolation logic in the kernel.

In V13, I will focus on integrating this "Dynamic Housekeeping" logic 
directly with the cpuset subsystem. The idea is to allow the root cpuset 
to act as the orchestrator for both task isolation (which it already handles) 
and kernel overhead isolation (which DHEI enables).

> Also, Waiman Long should definitely be in the CC list for this.

Acknowledge. I will make sure to CC Waiman and the cgroups mailing list 
in the next iteration.


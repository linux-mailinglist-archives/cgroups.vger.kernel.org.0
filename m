Return-Path: <cgroups+bounces-15105-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHHsJzNjymn27gUAu9opvQ
	(envelope-from <cgroups+bounces-15105-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:49:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAA35A872
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DADF301D32C
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE040DFB4;
	Mon, 30 Mar 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHfAFMPQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331D379EE6
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871212; cv=none; b=PN4eMdggLIGSDH+nR7l2uNqALPsl7DJ+x1JEM0s+pTyoX23m8GVsLUgX1S8ikgSjaxy5LHcNY9y0/XPXbp6BxMeSykiuRq5vfbA0tdfpwEPiaZIAFU7TrLrmf/zCZwrcGomayB5swMqoT4VsJK22OzprWkLBtsEpYLypLrQwvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871212; c=relaxed/simple;
	bh=NL8trraTtD0OpTkWQqnsyUPcWRWAvLDDCm/yybFJDGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEtkuT5yfQd9QS6moYIyZTzMNOD9BWGgREupKPoqRDi6tF+Uqm74oHjFmg3HdnOpMYPF3kP99c+rOR6nFVk/2A7+CGsHgMbRqIUMEWwmLKdKuqyDM+PrsER2JmdUMCOg1Ki7UFxbejKTfqMJSIR1oVWpzDf6myzVW6X13Qvpeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHfAFMPQ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c160cb021cso4197651eec.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871210; x=1775476010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eML4waLa1Jl6y2CJpXYjrV0+SpUpnkgbYk+PFVbKujU=;
        b=IHfAFMPQa2UkHnwN5HtXTnEJHlCyBFHtJhbg/fqYG9RKMP0H9r4Wqb2qnmHMLm5h1g
         Kl8ZBmXyNNJxVGjMfWWckKfHdaHSCT+eODL5/Ovq3OpBztLfVwgdHAKtCxaY4PgxOwMB
         eDnVxr2QWgL3TfTDGUfr3Me5tWybpCrSTHYKZ2FG3F35SLhLoUTqaIs5bAL6nM66WkSU
         GgVI3/O8KoUDQ4sKRbURty2x7yIedY7nIDQTdAKulyxpOkztwYNDtDN0bhfraVT8Darg
         2MkaYnnmEg/VdpW2urqn3V7+Cbj1w4F/ieFl6Vk9PXZWYcegrfyCOxlWRZNSuW7tCNQF
         QuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871210; x=1775476010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eML4waLa1Jl6y2CJpXYjrV0+SpUpnkgbYk+PFVbKujU=;
        b=EfiCyT8Pu7vMNWshJ2AVeTD/+Y3G8wuIyl7TWOdzWSaMkuezvQ0lrIi+PuNstKqUyG
         r9yIWCpcp4SHmVDZ2u1CZN9RirT22JL1dnYyPFfSSzdy4EI0GxCSC/kwfHJBud3qKEuH
         k6BYMD9SMNVXMCjBLTbhy2LyA9HLmWepzV++mR67eGNJLkck5Opje+vPgAULzKuALhsA
         m5v5Wr+K70z386Zxs088tUY5FGtu5D5AFjRUiw5/6pukBvvb/W19OW4t3YlyZSu+Yj7Z
         9IWYmWyy4aZRDh8ZQqXRfMPI2suWcQYTOJs7qC+/bZHiRfhIL0Rcg0rawnWfQdF0fqSw
         LAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUprGXMDreffUHeJy++EIUjH6gmDNCZkLnHE4VcMopBCzFF96DuOv/xl7Lsck+1OHhxNPzhql@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlf2PoJakIGZ/PXKNnrvJAh1WJVUp+1fw54wSpg1H716OlGrH
	NCQ0GL3eZSEc6PLvpACP2bU3E5eI8EyOgJtG5N4/bMJrLLNQ4weSzwav
X-Gm-Gg: ATEYQzxeB5vKBea/kxNL3h8F7fFQo+TLJ84o3enSwI583PA1q6349pxstq9eQEeSklR
	AFUOxss7y29pTsluSWocustrtE2PXCUmhTdhZqso5xY8aaSDycBmT5HI20FK8mbpVy8+zvu+KBw
	yKtV9ul0pkCPg8y69/ZG19Pbci3POc5bUcs7f8Rz6ec8/lNDD2WDKtAdR3QO7FF4ISvTOw3a0UB
	IEC1kr5ZS6TfNwjgpRo7CpjM5Erx5QDE3FFjRrtxggL5BylvsHwotqx98zcxOnaOGsBc1sa6T23
	ARe8vvsWZPi1EAuNLqc+kFWsgA5wbbbwvW59bKJwSULiqFmelngF3Syi3OZDlWz2TYUrWOMOxQ7
	5QnbbsTGc3a5LKu5eS/zmeQOr8FMBeXKpfQONsQwh3SMKVSHx4QFemIr7W12inZAdpt6Mkti0b3
	2elhAB+bUb/BnV3OKTC/o+HfCAXBGkZLCr0lg=
X-Received: by 2002:a05:7300:fb8d:b0:2c5:3b87:2ffc with SMTP id 5a478bee46e88-2c53b8732c9mr2663188eec.7.1774871210414;
        Mon, 30 Mar 2026 04:46:50 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda147sm6869724eec.5.2026.03.30.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:46:50 -0700 (PDT)
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
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for dynamic housekeeping
Date: Mon, 30 Mar 2026 19:46:20 +0800
Message-ID: <20260330114620.104027-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
References: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15105-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52DAA35A872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:04:32PM +0100, Peter Zijlstra wrote:
> Why? What was wrong with cpusets?

This is the central point of the architecture. The distinction I was 
trying to address is:

1. Task Isolation (Current CPUSets):
   The `cpuset` subsystem (especially `cpuset.cpus.partition = isolated`) 
   is excellent at managing task placement and load balancing. It 
   ensures no user tasks are pushed to isolated CPUs.

2. Kernel Overhead Isolation (Housekeeping):
   Currently, `cpusets` do not manage kernel-internal overhead like RCU 
   callbacks, timers, or unbound workqueues. These are managed by the 
   global `housekeeping_cpumask`, which is settled at boot via 
   `isolcpus`/`nohz_full` and is static.

DHEI fills this second gap by making the housekeeping mask dynamic. 
However, I agree that a parallel sysfs interface is redundant.

In V13, I will move the control interface to `cpuset`. The root cpuset 
will serve as the primary interface, allowing changes in the cpuset 
partition state to automatically trigger the migration of kernel 
housekeeping overhead. This achieves "Full Dynamic Isolation" (both tasks 
and kernel overhead) through a single, unified interface.

Best regards,
Qiliang


Return-Path: <cgroups+bounces-16156-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEIfK5rsDmqwDAYAu9opvQ
	(envelope-from <cgroups+bounces-16156-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:29:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D65A408F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98393301285B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C903AC0C8;
	Thu, 21 May 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p48g+76n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE233B9936
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362912; cv=none; b=lkUi/Jw6O8xNmJqCTQFr8mpgin32J4AIW4r+2Wo/67INlfErZgzbK4NXTuO/bQfDfSmyh6xs/oocOfn74Z0/pMPMGHo0XxcTUX2RmmnPi+Ct90onaHtoAAk7g+qb4Wm68BHjnPcWD2rvY8sWhoMDUtzX0BmwZutZPQfg4Qtxg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362912; c=relaxed/simple;
	bh=pJ0LmjTRmoJJRpU0IfmiM4SBFKpGeMquloKlltNZ11Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEO9ccSYXRzJxYldNQXvKuK3qht/b10D6PnVc0gySrjQuQoatJH3DBSluL0sBAf1uhWb0PvxkTEgBNJir6OZKywzGKW5PNumK/t71uPsoR6+f6kzyRMWjJ7PMtUcgJqEN4xh3RFUUPJ2PvG+uqxjrjm7OVySAWOgq3kVJCceGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p48g+76n; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c19d23b19so8130288c88.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779362910; x=1779967710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJyNQp/avb8w2S5x2BnqyHifPaEtYXGBN4t4d2EgLfE=;
        b=p48g+76nhu+sdYIGzI3ugpvf3j6ZoE52cAckMK+mFMZCYM/+xrw2VqYoqJUe77XgDZ
         e11ffI9m6S2MTv3fk9PiYvSO7+7F6c3YO4GTyxRvkgLcvoj6nH/mNqA3xX+gQ5xt5rfV
         qjLD4CFA8/YVtevP0UoEbURDJFnTfZqkK9SHiRSaw8vLR6cmHbrs1lEiev11bYtaWXkC
         RYX8B9ZOWOZIH7WA3OhxTnSAswqRtFsdYts3qbFjx8cHagHI8z3aXtK6q+TsH4I9Z9YY
         3T16RptpsnYKW2vHE5U4RDL3ncHSEw5aqGqTe9wp2/rHXiwVEgaLxrpNT2m+y/BkAv+2
         hCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362910; x=1779967710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJyNQp/avb8w2S5x2BnqyHifPaEtYXGBN4t4d2EgLfE=;
        b=L9Pao1XunfefGRu1QoEK8UsEnAM3Myb/5li4ORDZ03mQ/AIsHu/wNt4H8dZRSG2A7c
         cJW3Ve+0uJfrYaZy7S95XJYoCAvikL7Aib86M1Yed3r2fbVOgUdq7X7WxJDIp93rtevQ
         3DdSIdjF51Nmx7lwd/2c14hk54JKAdJAJau2nSNREHgFoy5uLiO5ihBB9kQX1l2UJfMe
         AIB0fgJ1MlgqrMCnev+ofA/oU2F1RN7jhwfIy5ohCdTRJi76S9DBv1tR7I/llqTIKhmO
         daw7VZxTJi/OCjlYcJpfbxORkUxuNj2LGFq/4TACsCIPypbHNrcGxIT+OZySS52kk0p5
         zuYw==
X-Forwarded-Encrypted: i=1; AFNElJ+PkDMzyWSfSsb9k8o7AkObPTk4yOVJAm4/dZXYlSYco02zPY/DogzOpn9QoHNHnTHWNsMR84rS@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwxFYRLmVVniBEAgsyceBQU+AQ4cpTTbZngypbhKiVsvLLHBz
	qQNMvXONBWfnIUDaek0clOP407k0TIVwWbQqtxxi9RfHk9rj0oXFncoA
X-Gm-Gg: Acq92OEesnJwK7Qb00RLZIvkT5YuPQGsW/wpTWoZu/bY1VPQcAZXqSlYCm2zXXFd1wN
	F+eov8wF5Awlxm2JbBBiV451VGbpkVXlA9ZzjFUiFv+1zNw19TWeuFjmOTUZe4WSaRUO79JAP3o
	90bwOZK1TM4+44Z4b2n6M92/huFn6PA5CGjkBj26Q/WnxjFEp96oFfLNbz7LkuoH1EIoNzEnPf/
	9apO5WBuSo6kAsqeR2FLlRO9SOCFTEKU2SJH2VbEYKEeFBw+rYfOw06SKUpzbVjnoYgS9170HAR
	NpcnKeLSZqUp91U9/regghVU1WqBLavdJlsRbZ3+IbeEZv2W8mKP89mpx3pdfXhKZ5Fgtts0/8W
	7uL/u0qGCVgyfz9J14g9dJok+lw+s5xaPBP0MB3dk9y+BzjJkroVOAVagMQUVmPZICV5CyTfSGB
	C3pV1lM1zVwSb06vFwUKNvv23whbfovt0=
X-Received: by 2002:a05:7022:42b:b0:128:d7a7:5271 with SMTP id a92af1059eb24-13632e57813mr1088992c88.28.1779362910227;
        Thu, 21 May 2026 04:28:30 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13651ae2824sm56138c88.0.2026.05.21.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:28:29 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: tj@kernel.org
Cc: dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:25 +0800
Message-ID: <20260521112825.62249-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
References: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-16156-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B56D65A408F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Tejun,

On Wed, May 20, 2026 at 09:52 AM Tejun Heo wrote:
> I'm not sure about complicating dmem control model without implementing
> reclaim. What are we slowing them down for if the only recovery action is
> killing them?

Thank you for the feedback. Your point about the lack of a reclaim path 
is well-taken. Simple throttling without a way to recover resources is 
indeed incomplete and inconsistent with the cgroup v2 philosophy.

To address this from several perspectives in v2:

1. Recovery Path: As suggested by Maarten Lankhorst, we will pivot to a 
reclaim-centric model. Exceeding `dmem.high` will trigger a prioritized 
eviction process, where memory objects from over-limit cgroups are 
targeted first for reclaim. This provides the meaningful "recovery action" 
you mentioned.

2. Backpressure: Throttling will then serve as a secondary tool to 
synchronize user-space demand with the kernel's reclaim speed, preventing 
bursty workloads from overwhelming the system before reclaim can finish.

3. Graceful Degradation: For GPU compute jobs, this model provides a 
managed "pressure point" that allows transient peaks to be handled via 
rebalancing rather than immediate, fatal allocation failures (max/OOM).

The goal for v2 is to achieve convergence with the `memory.high` model, 
pairing prioritized reclaim with backpressure.

Thanks,
Qiliang


Return-Path: <cgroups+bounces-16230-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLsrKhQWEWqvhAYAu9opvQ
	(envelope-from <cgroups+bounces-16230-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 04:51:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 641285BCCBE
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 04:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBCCC300B5AB
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE72F3600;
	Sat, 23 May 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je59FQyI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C32264A9
	for <cgroups@vger.kernel.org>; Sat, 23 May 2026 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779504657; cv=none; b=B1ubxiOS416LR1Mzf/JQjlep6zdVqxOR2Yif7ilWeOtcWLA2AsUT0p7397qRdf0s7Rq/J2oIHrIuIPAoPSawVY2/Nz8mF+rOLw8SKv2NLJbUOA0SLx53QnGYULlybUiesLQs+ml9xsIfMXO2ptCk8mQojpgi8QkZaaCbSo5zNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779504657; c=relaxed/simple;
	bh=RRP7olD91HMgJfyrvvfbPN89rim5pXnnMPEr2Y7G/WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXBVnuzuIj/HH49e9ELYPJBX+5se5KkxJ1BAns4dqyG9lSAkNME9ds7D0yMViprc+vduZClVPgDiv/7joxDKEWPw2Tr8eUF7hhtHMVZfzXZWrmQO7VYwQwWX3d5coXk6TQfyQF6WYqntIKS9CmQheOeSMD8hnAXsPSERahLzUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je59FQyI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4042905015cso6736808fac.0
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 19:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779504655; x=1780109455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRP7olD91HMgJfyrvvfbPN89rim5pXnnMPEr2Y7G/WQ=;
        b=Je59FQyILJhy598Mdqfy+Mgsvlfnx2PJ2DN2sw7NQTE+m0y7pKHqCGHRe3ihGPqzSn
         ngC8XwqxmyPVjKafuhLja1QoWcyTDPkSfGKItZ0SmNNFnb7JoIlQZSkcHaeVW6Mqdnfx
         ht6cXUG9Iy6GniQUvpriblWIpjL1fhU6cbnh9lZsO4NHTR1WtpR5U2AnIBqAAj40HfcI
         fpASJPgCmvXt3xpe4gemPAKrrezDNJKUsmn3sp4Qcc/1vjUCtFlUmwjW9M0UI+DtTV/S
         y4u/6OnKR9t1tVmVux8T287NZMNRGGmpUuW6rwUM8ra/35hXXQvhtv2VYmNte0FJL7js
         gKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779504655; x=1780109455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRP7olD91HMgJfyrvvfbPN89rim5pXnnMPEr2Y7G/WQ=;
        b=HUTLA52/lfWLjC+0OmO2Mbx6gbo6Iicvag3CullSv9GVMGP4RHFKgtaBH7RIjxC1zj
         1Go4Dni7HUIofOcVKkA8gYWX8PnILBTDSdawcYDve8Fhf50uoc0FrayBFwRUm6ZoohzH
         TDAILsmSMa/Mcp3/cNq3ld1rISzZG+sjJrEq91XARKSwgBGrwVf/AqWo/I1oxkfwODPK
         Ixa8mwN1RYZyZvHlq4GknI3bpkz5nLtZkySV5KVU7uFKJy81SqXtGkQo7IyNm5qfGUK4
         SiyibZ6lMjdB76KbKk2ZdecUGGIpU8xsSii62U7GdFVPrK3l4MGYu94PD7ViAR5o8XUg
         zcbw==
X-Forwarded-Encrypted: i=1; AFNElJ85ZQknH2Qkcvd85BCPZhD5IJWDk59Hw85V9gmHDK7xcXyvkSTeNy+CWS60i2H2RVRBRSK22ZEc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyck2pf8tujERnV4wuCSvEJaAHtIte16jYWUWBEIUAx9M7IVfBT
	L2eVpSzrwm0rMExzJZhFSv2YI4hZTClrAAwivL69G/TApQVA0Z/zk1sz
X-Gm-Gg: Acq92OFrDAscM/+SX8Smm2dILqwHhVGVGktQwosmFTSJEUDsu3XxAzTbS+n9mmjUP/L
	lU1UZjHsTihoOp9rZOtSJW8b3gO9DUZgXF/0f8R+3bpgoKXp3/XylvCJaBAQ7FlrhmLGNa22uJ7
	WUIgZg/8mMplt5/jzbllbn0J19vpGthfjsQRCbweK3VYy9Oys7LpGkeUc35U4FZKba11zzxloMt
	t4BsUG8aUWPIYV6+TxuemHJwagc4ePv1Kemw5gJsN3X0G2WB0t7mOPZNSRR5iN8Wzb4qFMrncPZ
	4IXwAX4BDUVsC70lEXmOJ/fAPzP5KIhd2z7YQKoZUvSBdhAwZb22VeOvrnH6RxDp4Mz6g6xe1hK
	+7Yiwme0d5dulb1PK09kyagS3RULSRpWO/S27xdcX9xJUH5htMXniVTfyHv8p0gtbhPAlrHkxkj
	xd/45l0jygt+ZN84paPY3ejzQ+vVtZDM3m+RF+xMZX4xt9Rq99kkYbBzkZNsGOU03QdpSShbZiv
	ZY=
X-Received: by 2002:a05:6820:1c9a:b0:69d:7aa1:bd7 with SMTP id 006d021491bc7-69d7eb64572mr3483666eaf.21.1779504655191;
        Fri, 22 May 2026 19:50:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d836c6f22sm1853403eaf.1.2026.05.22.19.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:50:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/7 v2] mm/memcontrol, page_counter: move stock from mem_cgroup to page_counter
Date: Fri, 22 May 2026 19:50:50 -0700
Message-ID: <20260523025051.170871-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16230-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.789];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 641285BCCBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 15:06:18 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
> allocations, allowing small allocations to avoid walking the expensive
> mem_cgroup hierarchy traversal and atomic operations on each charge.
> This design introduces a fastpath, but there is room for improvement:

This iteration was developed and tested on top of mm-stable.
I'm seeing now that Sashiko cannot apply this patch, and I think it expects
it to have been built on top of mm-new.

Reviewers -- would it make sense to rebase this on top of mm-new and
re-send this as a v3, or should I wait for feedback on this cycle
before sending out a new version?

In any case, this could have been avoided if I just developed on top of
mm-new. I'll be mindful to do that in the future.

Thank you everyone,
Joshua


Return-Path: <cgroups+bounces-16090-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGBWNH6LDGo1iwUAu9opvQ
	(envelope-from <cgroups+bounces-16090-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:10:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8B582066
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB0363094B2C
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFE2E2DFB;
	Tue, 19 May 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra1bos6h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQP+YTkf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B82E040E
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206502; cv=none; b=XSfoRrytNFqBcdAEdgXwLKW3iOEUqcXWAZoCm+NSJ9mSUIq7KE8WGU/K40qtcGYeSIdnVkdw7TtdEnSYTww/v1zayWdXNEwDMMb+72WEh8Y+IbNcBPI9Prkq6WEzGS15zfhgI7a74lEtIFtukYuXHnDvzg181WtZBev00UZNh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206502; c=relaxed/simple;
	bh=6qUbI3kCpq9IrzG3DkvyvMZ2Bn6Qq+bPF5M36smFsFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=npag3mzUzSM4WaLvmGEVA97TFiT8zCQWlmv/5NQBVzAauqykbCA4y9NX0j7FAEEW9O6Q6HBL52T1Yzyby9a8g1syAdPxxPMBhDfsyTr23xu2SFdBSTq2pSwfE0BxCS003XGCoxsuz2GgSpiXzukoLir4h7KFlpRlHs9p9orArbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra1bos6h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQP+YTkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779206500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T6OjxI0zZxwDX8SXPRnZD+crOhWj/eJOyVt4Fi52IP8=;
	b=Ra1bos6hcFwLcQhxS1f8w1QQuwXtZHvVwSYH5a4EbtWflyujoBh1xVaSm4lWNPqG2Y/SH1
	hFB46csglNEqT3wwiX8ka8mnbig99PtX37vaM7Q2CsRulBf/40mO6RovRzAhgNcFloXUqq
	EGE/bwI+gSLceVTOoLBU8E51qcU7+TU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Mk7dwadBP6OfgG-VaUxVKw-1; Tue, 19 May 2026 12:01:36 -0400
X-MC-Unique: Mk7dwadBP6OfgG-VaUxVKw-1
X-Mimecast-MFC-AGG-ID: Mk7dwadBP6OfgG-VaUxVKw_1779206496
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91382222f94so741534185a.1
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779206496; x=1779811296; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6OjxI0zZxwDX8SXPRnZD+crOhWj/eJOyVt4Fi52IP8=;
        b=dQP+YTkfiYqA1H4Uw11m1+1xabV4GpAojoD3stYfYHeW2VUx+96qTIVGFpt1fKEAd4
         rVl/qmqGFCQYuW+2egPmDKYfGOTBSPNMv9+K7THUUK6NG4rMLfur1DX2lMHJ2UW6vqq7
         MzisW05I452Y2+AoWHt274lrHMottF/kA/XnhIsvLBpOP5JUOLDH6px2PeqZ5tr/63XR
         8GXLFRHQaPVUdwAPSl7hc7neR8dvR65Rd8TWlQv3x3TYYjw+z98kRsoaJ7t09H1iT0cj
         iS0CUl+gdgHZrh1hpSyIo41bB/VYl5FxFueoarh0abbjPT2g2a/Nq3hAKpljQGtYRy5c
         M6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206496; x=1779811296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6OjxI0zZxwDX8SXPRnZD+crOhWj/eJOyVt4Fi52IP8=;
        b=FctJMVjuJ8+G8yYPyMJoDdqelQYgV/2f/amNxU9iUX1hH9TIcWMlux8Y/PpjKI12Ah
         QGlkHLfxTZ/nRzKPsq8G5UUvgtOIliwXblcNPNaM3Wf5sqGC9KIoCTPejptvWhebm641
         fV+45Nn2OWq1of8/0L3A7ku7rtQwgp8EbNLhhdORZ5Ba7qRoGEDw+TCw1j5T3XCIocu9
         RDGcJNgAK08F2mdxFrdshPWBQzVkpjmF8cdQza39oCUjF6b7yqHn1zPaOaQkf+AhADdJ
         v9UmAaW50Ki8yQN32+Eb0r0Umzh9ySfrDJL2+sieVInzzP8oR2cGp0SF2FpsIKRmj5en
         OvWg==
X-Gm-Message-State: AOJu0YyMlM/fBT6X0NHgBHRlFWzqWZgwCSaSMBPCBolQRqIP2uk2iToO
	pRO139ysTOMncBq1Xaja88vyfWrpZwRFOXC/axHBOAqQ4kroQM47RhRVLlxTHBY5FpUjkIN8bzq
	LwYYv+5k8+uBrHYXKqDC2XQP978QSLIKiXU6GX/QDeZyGoPdDIj7Fgw76aas=
X-Gm-Gg: Acq92OEdz1G4qmBEBuWIWoGCjMa+qcQ1GLfyWRl9/QPYwrgpoW1AolTWIGfBtTv1G+L
	+QOyN24eqD7ukOyQrqarkXgfZNTn5uHeQcdV8Fz3WbHnAXQB7b172FKtsCBfkgvb1/MdMs2wE7t
	wHkVef/Q/JsJOyw4qVeWXs2ULnGO8/8xJ/48cPLbrkJq8m4+uyIRXCzafpMmNAzfdSNfmjY4kpQ
	xXI5EmBoK7n5jVWmEgivpLhIX9LaIFfqjWb4MnjAR3sj1DuXNxn5MMRJ4e9NCk6jOg1zogq0H6W
	TaTrZ1RlrmTO29FqKuUSBwikzlGYFuWH54fLldKoQoMZZbwZaa3nop+QMwNjB8YRrhA3dUk2+oJ
	HIDvjjS0ewmNxXmdYRWFO0XBGPcq1Dzp3PJsMNdJrriZb1Pd6XNcJQlPXNBJXUzpOCQ==
X-Received: by 2002:a05:620a:460f:b0:911:4cb1:8a60 with SMTP id af79cd13be357-911cd178131mr3073462485a.13.1779206455601;
        Tue, 19 May 2026 09:00:55 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:911:4cb1:8a60 with SMTP id af79cd13be357-911cd178131mr3072809785a.13.1779206430240;
        Tue, 19 May 2026 09:00:30 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net. [100.17.21.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc9363fcsm1883933785a.27.2026.05.19.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:00:29 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2 0/2] cgroup/dmem: allow double-charging dmem allocations
 to memcg
Date: Tue, 19 May 2026 11:59:00 -0400
Message-Id: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQrCMBCFr1Jm7cgktRZdeQ9xkSaTH7CNJG1BS
 u/uoAdw8Xg8+PjeBpVL4grXZoPCa6opTzL0oQEbzRQYk5MNmvSZWt2jDSUvL3QjjyixAV1ehie
 j4EVw8orIXLwfvAaxxFTnXN7fg1VJ3X+uE7V/XatCQtv2yqmuc6zNrbCLZj7aPMJj3/cPgkfhe
 r8AAAA=
X-Change-ID: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16090-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,lwn.net,linuxfoundation.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 95A8B582066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following suggestion[1], offer a cgroupfs entry to allow an
administrator to request that a dmem controlled region also charges to
the memory controller.

Add mem_cgroup_dmem_charge/uncharge helpers to resolve the effective
cgroup from a dmem pool's cgroup, perform the charge and update a
MEMCG_DMEM stat counter.

Add a "dmem.memcg" control file at the root level to configure memcg
charging per region. The setting is disabled by default and locked on
first charge attempt.

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Changes in v2:
- Use mem_cgroup_dmem_{,un}charge to account for memcg pages instead of
  exposing raw nr_pages functions. Use it to centralize where to find
  the effective cgroup from the pool's cgroup (Johannes)
- Set depends_on for cgrp_memory if CONFIG_MEMCG by having a memory
  controller in children cgroup (Michal)
- Move dmem.memcg to the root level as it applies by region for all
  cgroups
- Add a dmem memory.stats entry for reporting memcg charges for dmem
  allocations.
- Wrap the memcg enable/disable/lock configuration under a single state
  to avoid toctou races and simplify transitions.
- Link to v1: https://lore.kernel.org/r/20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com

---
Eric Chanudet (2):
      mm/memcontrol: add dmem charge/uncharge functions
      cgroup/dmem: add dmem.memcg control file for double-charging to memcg

 Documentation/admin-guide/cgroup-v2.rst |  23 +++++
 include/linux/memcontrol.h              |  16 ++++
 kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
 mm/memcontrol.c                         |  65 +++++++++++++
 4 files changed, 259 insertions(+), 3 deletions(-)
---
base-commit: d989f135f71699294bb2ffd4726b526456e2db68
change-id: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>



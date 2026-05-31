Return-Path: <cgroups+bounces-16495-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMcaHMI/HGp8LwkAu9opvQ
	(envelope-from <cgroups+bounces-16495-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 16:03:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C300D616937
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41A630071E8
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FFE274650;
	Sun, 31 May 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTtVJ4N+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsJKvvsE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC121F12E0
	for <cgroups@vger.kernel.org>; Sun, 31 May 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236085; cv=none; b=Oj/vT4ZmAMUG0EEWazrQ7r+q28woOMLO6sOgB/wTrfH//XseBWm2VQiVPGyjp/Imr+irUIj/glnAa6DJf6lHVJM+iCcIKh9lCA6SQDEAXfqxALxVKcQo1leLpdCySWk0JYr7mVM39kJw7zMTnGc4eAAIriRNRd2362vmuoxl7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236085; c=relaxed/simple;
	bh=cN7DgQyDDMKwlwoQV9Zy6CXTV747HEJD4SXWT7rDzt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hl8ySCsYykNPwa92/M6HXyIwfS8yb6qH5XaCNOkUsE+SJgFjNiFoMKRPisGLPPrrarnfbvIhQM6xIF2EcnizRdmL/Z40eEa+N1jSrLo04Nkg7FoFL4O7A3bvMv4nX9iiVRa04s+wta/eNziVPBpBo0YWtxEduF6xVqVyxyhPXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTtVJ4N+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsJKvvsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780236083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xablB6kB2yR2eWXgiEzwV/mfa3PUIVxolmDXg2loEdE=;
	b=VTtVJ4N+RQBd6R+Zjgeos0t8T6UTFv2IHFMDlecR2wU+qXniDe1HHi7/a4g7yDUzMKWhJA
	I/TrlAED5gOKruUREp+91gDITBlwu02IQBcaMO7hMPOiJfg2OprBeZ7m7MjQRySanKaAi9
	ZiIqsL0xmHs5WT9QAmwwyg+EOVv68Ps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-FD4Ka51GMM-MgESopr8qEw-1; Sun, 31 May 2026 10:01:21 -0400
X-MC-Unique: FD4Ka51GMM-MgESopr8qEw-1
X-Mimecast-MFC-AGG-ID: FD4Ka51GMM-MgESopr8qEw_1780236080
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49051422d55so82317945e9.2
        for <cgroups@vger.kernel.org>; Sun, 31 May 2026 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780236080; x=1780840880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xablB6kB2yR2eWXgiEzwV/mfa3PUIVxolmDXg2loEdE=;
        b=FsJKvvsE20hE9jNzWKYg5yPw9d2vGcDgvFi9M382q1WkKBuHt1YNX87AIMPngZEm4Q
         oJw6oREDq0uv4L5Wv94zrh1SehUA1D1b1EWoh5Vlsxp9nH881Pi9dOzbH+DqadAB5l4l
         BTH6hpcOMjnoYV3wfOQvcZHUP3u8lFfuu6bsdhGu/3zRiQEHwQ3asnfB+hzlw9VRmFQF
         BiWDMFmhiTpN6F32KqZ96e5pUV8qzi16Zk/zSiOfnA1Vd/c4GsNC82coqJW0JDME2wRz
         Oy/4HETbjZzwTkeNeO3GqcKr6VifNxjIq9Npzj1xq9HKmV/gIylTl+oee+zK1U3yaquZ
         ty8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780236080; x=1780840880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xablB6kB2yR2eWXgiEzwV/mfa3PUIVxolmDXg2loEdE=;
        b=B+Skehfl0ngCn6orcv5ksGZirzrg1QUwtFuu+utFJhulwfexPem899Rtp0RwJtCJxS
         56JZbsuZjnGMICbhOVuYszWwHAE+C7OnQzOSkNc2Qf7KCUZSg2u4Dojeow7SicGydBD2
         hkgEEixv9W+HI6U1mZ4iKtvI1XYVvmeAW/oET+z8U4Ufh+O7CylFnqCB6fELCh+GhnIu
         CD5a/6O63H2NQgaNuAdn+8PGkq8qR5/am8IV4gMAuwitg9jJwVmEQar0sxM3dmpFcYAv
         zX8ixvaHaZ54szwWJ2dvDMV99jw0aXYMj3QoNlgErENVTmjqmt5QHslPoObHqTtZZAcC
         SUhA==
X-Forwarded-Encrypted: i=1; AFNElJ9c04PzPddC6kLhpt/7OgK8FfW2rlQba6jevjr3I5EnsN9VdV1ldPvW/qtV4cUp8hISy8TTPzF6@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6nmb8JP8WgYaSUjomoj7TK0tUzGmrNY0NeQTzw8U4zQINP0m
	s14O5C6ZsU94RvqlepoDkapOway0H2G/DvNe/zkN71dLGPLNhFWFEvconCLXRdFWim0Ks9gpyZt
	tdQTjpHIn7sZs9spjHds5Acoccpdph6e5QjFS8JVDHfBSTn0a1KU7RloI8/s=
X-Gm-Gg: Acq92OFo5hjp5I2HKYaK7YTUnTzb59UMGp107OVY//RPg8clgmXeaTyf0G/+EtJVvhG
	69wx3k2+V3nPqlS8T89/5eXoIwmCIGwmM5i/sZHnyuxt6uWE4tPqjcXqoXq3rAUJ0j5lsDfB/H5
	gtAWwT8lW9laFIMoR+Ip2ILTbNOBpgq5dn/AspzVlFA6Ap/3d2CFt0qWbVOZcjG0D2vgv6PCj64
	SacD12u4okN8tCQW0k4xxhhhjzYORBfuOJL7PqSAWbdTJwvPdm7/fCPVJolCDMWG1jm1QZRlvna
	z4wCH1eisER/TRfSS6tXZjoex0gMkb7V+VrfLBITGR/LNtxACSRmh27pg9u9umkb8NIIRGDGbCy
	QtrsIeuoFl94yEgbilnUWby5rq5+zuAtQsc1ZYoqAIjLTxQ==
X-Received: by 2002:a05:600c:c098:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-490a2923cbbmr108126185e9.15.1780236080344;
        Sun, 31 May 2026 07:01:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c098:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-490a2923cbbmr108125565e9.15.1780236079839;
        Sun, 31 May 2026 07:01:19 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c12b2dbsm75194055e9.6.2026.05.31.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:01:19 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] docs: cgroup: Fix stale source file paths
Date: Sun, 31 May 2026 17:00:45 +0300
Message-ID: <20260531140045.4114289-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16495-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[costa.shul@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C300D616937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update two references to files that were moved:
- kernel/cgroup.c -> kernel/cgroup/cgroup.c
- tools/cgroup/cgroup_event_listener.c ->
  samples/cgroup/cgroup_event_listener.c

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/cgroups.rst    | 2 +-
 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cgroups.rst b/Documentation/admin-guide/cgroup-v1/cgroups.rst
index 463f98453323..e501f45ea93f 100644
--- a/Documentation/admin-guide/cgroup-v1/cgroups.rst
+++ b/Documentation/admin-guide/cgroup-v1/cgroups.rst
@@ -525,7 +525,7 @@ cgroup. It may also be taken to prevent cgroups from being
 modified, but more specific locks may be more appropriate in that
 situation.
 
-See kernel/cgroup.c for more details.
+See kernel/cgroup/cgroup.c for more details.
 
 Subsystems can take/release the cgroup_mutex via the functions
 cgroup_lock()/cgroup_unlock().
diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 7c7cd457cf69..ebedbc3c3f9c 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -321,7 +321,7 @@ Under below explanation, we assume CONFIG_SWAP=y.
 ----------------------
 
 	Memory controller implements memory thresholds using cgroups notification
-	API. You can use tools/cgroup/cgroup_event_listener.c to test it.
+	API. You can use samples/cgroup/cgroup_event_listener.c to test it.
 
 	(Shell-A) Create cgroup and run event listener::
 
-- 
2.53.0



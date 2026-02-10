Return-Path: <cgroups+bounces-13817-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBIsJAh+imnVLAAAu9opvQ
	(envelope-from <cgroups+bounces-13817-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:38:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D22115AC1
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56C3B300CA1E
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86523AB98;
	Tue, 10 Feb 2026 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLw4EY8Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7AB665
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683908; cv=none; b=llYP4YQUSUAHkQCt1Knn1TdYE0oKuTUnO+P81ZuQgZ67+5wl+A8OdylHB4ZO8qU7ElTXHR5VeiXxkjhOUjvgO7+YBUozeVd5PU36t4Zi4avtFPmjB7MTAfX3bhmwnGrB3MuF+e58251zAAiess1FAPiJGCyzYB/AaHa4WdgDj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683908; c=relaxed/simple;
	bh=PJxIqY9BILo/Wb6xL9poQCQMqT1HyNX/z+OFEJERO1Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TjAV08RJZ4YupBE7/zNKCJbWAqM/c3j34/VU+Q/VSZcvz6IiBc0TZoLPzPw3eAvYQbOtn3EYt0LTT9rHwr3vrh6XW66OcQaiGvPDTWGADc/nEu7Xk2Mq67GGxes+GrX7806DAnCuDTD74bJiVkxy4ZDgug/6CbSpy4QLg616/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLw4EY8Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545b891dd1so11027195a91.1
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770683905; x=1771288705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToFxyLXirio/gELGdBsIPVriUiQfEmrOHh3uciwjmrI=;
        b=gLw4EY8YbDYOxFsFmnop/KMtvNp/xz+nLw4AJ478/ud95s6Sm1Z2VX+jbiVhBZ1K8c
         TZuccQjIv64QgE0Riul/h+nNZId5YBu9vafootIpTxKQvf1mAY5Cg/X1ilSA3dIC18oJ
         x1ajEIpwi0BiPO9HavUT8f9+iCTPe7107cuGbq1a4fXhV/GcDE9lnoPXCppr2U0TawPZ
         PdDcsIL4XD6aw7kZpfbbNlqKAQKVLCYP0m+nSPTKN/vDsxSFXOP8x/hmEV/oBYhGW2Dv
         pue4EBA2MPSBc4IqqvMGfBLNliuPkwZCHuj5BBNSYVOcn6POimpZWFmJtp2ZWLJQVeFj
         vLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683905; x=1771288705;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToFxyLXirio/gELGdBsIPVriUiQfEmrOHh3uciwjmrI=;
        b=Ki6WMRpq87ziOruO6e/abfHG+7/TJ6qBbjvItox3buMEtjDBLU3PBtEdfcCPALS76P
         R4sUHcAQ0UcLVsf+KwfUwV3tTLGuXXWIB1u+6GGzNt/8g7rA0YLFMDmAXeeq2rUVkIad
         ObQZ1lAfDKQHI7qvHMst8arDsdBL9ISj3KNBiGYPbEh2iBx8zxUKgU5Dw8dYJTZTQsY2
         wNE+RBj5GJnLIovIEOVwFJ6/eqcZAgShAr3r7zBD46UCqmhqXoHcTNO6DeuQS4CQf5re
         5xUKqk7Gw1zWurzPrMGWf1Awvv/0DsIIiQUWFOiVuU/BlDARJAP9vgO7n0EPeb60JP2P
         YUJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2vIrY/sWWDC3c7W+QpLbsHJs+qdm4hFgDP4JvguVHlW/bPArBYCampqPHXeHBT9uapJ5pWuj8@vger.kernel.org
X-Gm-Message-State: AOJu0YweoHkfJqijvNPvjRTzBk+COZ6NJl8vGlK1BOJS+zxWj/FtiSFq
	RGP961F6a2gTGTzNnSbExKpowtvkhSJhWI6kUEspvwD83i0xaI/4lVb5wzYaujTW09ZiIwAW6dL
	L4iSclVc74+4GZS2VoA==
X-Received: from pgbee11.prod.google.com ([2002:a05:6a02:458b:b0:c66:e5c8:842b])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9c9b:b0:35d:d477:a7d7 with SMTP id adf61e73a8af0-39417855226mr372906637.7.1770683905284;
 Mon, 09 Feb 2026 16:38:25 -0800 (PST)
Date: Mon,  9 Feb 2026 16:37:58 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210003801.2834976-1-tjmercier@google.com>
Subject: [PATCH 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
 for files
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13817-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34D22115AC1
X-Rspamd-Action: no action

This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
events to kernfs files.

Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
but fails to notify watchers when the file is removed (e.g. during
cgroup destruction). This forces userspace monitors to maintain resource
intensive side-channels like pidfds, procfs polling, or redundant
directory watches to detect when a cgroup dies and a watched file is
removed.

By generating IN_DELETE_SELF events on destruction, we allow watchers to
rely on a single watch descriptor for the entire lifecycle of the
monitored file, reducing resource usage (file descriptors, CPU cycles)
and complexity in userspace.

The series is structured as follows:
Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
        on file removal.
Patch 3 adds selftests to verify the new behavior.

T.J. Mercier (3):
  kernfs: allow passing fsnotify event types
  kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
  selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED on
    memory.events

 fs/kernfs/dir.c                               |  21 +++
 fs/kernfs/file.c                              |  35 ++++-
 fs/kernfs/kernfs-internal.h                   |   3 +
 include/linux/kernfs.h                        |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 126 ++++++++++++++++++
 5 files changed, 179 insertions(+), 7 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.rc2.204.g2597b5adb4-goog



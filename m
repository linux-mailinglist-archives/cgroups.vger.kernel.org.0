Return-Path: <cgroups+bounces-13919-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eADSFAtNjmkaBgEAu9opvQ
	(envelope-from <cgroups+bounces-13919-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:58:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C389131673
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC7FB300E46C
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCF35CBD3;
	Thu, 12 Feb 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qd4lARPX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AA32C941
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933508; cv=none; b=PVlKsYWh6nxadXW6/hI6VZu8MDlcYMXCzgc2SqpeJy8tkqAKm+PqgApOkFeeZnT4eroDymRiJhVvmmuJftxITKtG/EYXoIuDDysDO+qbzxZkKJYQvEHqXsZ8qa4TK+dUkW/0+JEvtfXScMFzHYwO2ZCpfUXIzq3cFk6m/2FuOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933508; c=relaxed/simple;
	bh=rvm09WjgPTpfJFIcHNYOPR/b9d2nODdgLBbyUw3INaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cjKeUNGBcla5ze5qFVSaG8yD0uBp0cqOiPTFOsu1g2ktTZIDwRi2vo7zkGaC6FEKhV1pJ3m53nlaGJol7tovdEAL/wum4TvKT7xQTzt5R8roC8ZlwH2SNJT7/LRQGUvBi5DEr6kzqzi4d3kA1h6frGx9qAB2Xn/HpAuY6La1YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qd4lARPX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7a98ba326so2819675ad.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770933507; x=1771538307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IGPiVsRR2IN2A+m6Bv8PgAftkVsRzQaURBceo4FlM+o=;
        b=Qd4lARPXXYTjmgUxKfAK+erBQzcm9KfCzmheAg4Qmu7YB88cLBiZ672Ep7ecI3vCAp
         u+UrRA+vkUKQ9baBOEDUNFaTyjRxlc5WZf4yGjXjynjnDEZjplUbpQimWu2gNLKn8uTF
         6GvmjEVO8HhFzGxdX5NiPDvfNpz6H393ucan9SQgjN4/eJcwFKvRUytpOVDfkCum1JgR
         JIHeVTa43hMqx5MIvIkaaHX5NAfSiBWB1lbLzB5m8eu51Ia/WxXJS4oDTE09AwB8PUqD
         P2fx4YQiYnCHVHPZIXRF6zO8dzVL7kfz1e9qSIBZctbqNntvd3vANUZRhgv52Cve9tIP
         Z4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770933507; x=1771538307;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGPiVsRR2IN2A+m6Bv8PgAftkVsRzQaURBceo4FlM+o=;
        b=R1nTgcA9CIuGK0KNlsynyw/WzsHvOE3giXqTA6vJmdqus6ia5B+kjkNZ3+5HfUTSVu
         yPy3aMXE0ArEruCIkMSk4oJbjK105aZ0f3KCCEUUEGFaiSKaPfrEt2VRhxKwEapWG4++
         D8MO82dCcnbyAR8HohafnQPSn440IL9d6Gl/+7M3X8l5awtcgPiNbV0dc+lNUPf70SPn
         k9DY5yzhO1XbT0pQkIhaaajTw8q3urJVQ2HfhXtYE6sgJTrlj8goypohDIGwJjvVk52t
         eX2Uu+K/bINSH9LbQ/OlhVYXERWHRN00V24CKGYHcBir7wjT6/d/B0EkKfwKYeGhOPyI
         YOEA==
X-Forwarded-Encrypted: i=1; AJvYcCW9LePJbedD2zP3csKc4nB1lh2a43fqLxccpSFh7wwrRUxBnVG+8NywA6bFO6FtI7smTpqBjRIU@vger.kernel.org
X-Gm-Message-State: AOJu0YxbwzxUh0kkgOCwzfNGoueO3DQqjBvXjBVhLEUPCvpX6xpYz4c4
	gFXscIHJ9MNmkbwVlWXKxWpV92Qh3Ji6n9qY7iPBQ0qx5KjH2unC6C7DvxeIFiUwed91HNZxbxq
	PPX1P+/T6JGwtoZ+90w==
X-Received: from plbkn7.prod.google.com ([2002:a17:903:787:b0:2a7:73f7:74d6])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b47:b0:2a9:327f:ac57 with SMTP id d9443c01a7336-2ab3ac3ea7dmr43993265ad.28.1770933506507;
 Thu, 12 Feb 2026 13:58:26 -0800 (PST)
Date: Thu, 12 Feb 2026 13:58:11 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260212215814.629709-1-tjmercier@google.com>
Subject: [PATCH v2 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13919-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: 6C389131673
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

---
Changes in v2:
Remove unused variables from new selftests per kernel test robot
Fix kernfs_type argument per Tejun
Inline checks for FS_MODIFY, FS_DELETE in kernfs_notify_workfn per Tejun

T.J. Mercier (3):
  kernfs: allow passing fsnotify event types
  kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
  selftests: memcg: Add tests IN_DELETE_SELF and IN_IGNORED on
    memory.events

 fs/kernfs/dir.c                               |  21 +++
 fs/kernfs/file.c                              |  20 ++-
 fs/kernfs/kernfs-internal.h                   |   3 +
 include/linux/kernfs.h                        |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
 5 files changed, 161 insertions(+), 6 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.273.g2a3d683680-goog



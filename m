Return-Path: <cgroups+bounces-13986-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMboKZIwlWmeMwIAu9opvQ
	(envelope-from <cgroups+bounces-13986-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 04:22:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BEC152D08
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 04:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AD3303CE13
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250912DB7B3;
	Wed, 18 Feb 2026 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B70JCOX/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF11A9F97
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771384967; cv=none; b=PWF21Mq4csYsOlf47onAQEIuEF4BZ/WmJ0PjaMGpRGp3G8KEFBY5tGoWVM8pipHVdjXjehsNvK7SAVosgjVmBegrQWq45p2U9wK3gSQoad/AvenyFjCzM6YJt8DkJVeTwia5ycRFQZ7QYx+J1OravNSzvWYBoEQ2IWjOkUaF3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771384967; c=relaxed/simple;
	bh=32HF38AOD/I/0DWJn1DNDyTIUijzlwxnIPrqmmhrMEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T7s4mHRHrLj5o7RNM+/QsTiwgwThrwuyESvUfwfPQwvCOeNygoLwadk0HIRS/xeKsODIhSpzsn/dMc8aXOz3q2B5kUh29h7iYwVC9hcVZhyBXJgLJZZJQhJNptDlkxx1uylR+hIRKQsYwuTaxiPp3jyiU4of/mVk90KBi6b0F2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B70JCOX/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so5885306a91.2
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 19:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771384965; x=1771989765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5oh2GGuUIGHttG6QQKJrDgyvg+KF11aDAOaopsiwdo=;
        b=B70JCOX/inNG3gWIiBSuXhyja6cGFpC1aqa5uh1cKSsJ9zoSgkTsWo/Yfa7Ncf2IuQ
         MG+Z5IrLg6kPKGIdW6rdcb+29+6nENjqskyAwVrTluMDZEhpSizkMAF8Ug31mHW+MJBf
         om2pSwH1L7Eiei4ttENGh0gzq4BcYbqLxAhkiDmyt1MtshNulEWqDp84URURMTbnEUqt
         HHq6vG0Ptp7un0tyWN701U+CzWzYLOCjRzHKaeCAdnyVjiv0hKTuxobucFLIr2AHTVK4
         X7+j+wsIsD0eqbKo4tqO+DBEkEmvx47piB+uSLzmzLbja/2at0kHpb2ni7etIZrqXm4e
         R5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771384965; x=1771989765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5oh2GGuUIGHttG6QQKJrDgyvg+KF11aDAOaopsiwdo=;
        b=jmdlrNYs97nABvAq2zLbgFHLoNCgioqtX9HsOPwPMve1E6eneOrcpFYBjHDuhhbSfo
         mvLHjt9EEosfKTnVXZHgL842zf1lPDkfU3zKOcMfDoJ0bcUbjom5a888uJr5fsZQhvwh
         fKNnX+2o1WXhFYrzAqLNccf7126B0g7rwrEmS/AE4gjAmuvzozakAYReJZqRqkcx8xlx
         uf/X0sIJNxC2rrr5i9RQQiEpYvoWm4Bp0yps8mLpsoX01vhIhWw8JY0HkVOfEP6GIE4o
         3uYMtZA4PZaBaDAGM/tXWE9G++i7O54TIi52yXYyfRpqTBgJZ6g6zFWNXYJyd8vUBpeu
         vGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI9LLdrWkW9fDe2pKcoLLCMvuN9SzEMh8TJO3Lrxw14s9jbTSaFIpxzvi58XIwZC/o1oH785RU@vger.kernel.org
X-Gm-Message-State: AOJu0YxrC1EV27OALeBTlBqW/n1u525RhUfbzXMuVQdcc+hzAeHXrJ4j
	Pyy+zSQ+ge0HW6QBCsixYC0IP7NcC6rSP0OfZf9LvJ2bjB0iLchdQGtZR8KHO+Tz66IxYSOFSsi
	n8rhTl9vFn90ZYoEtnQ==
X-Received: from pjal2.prod.google.com ([2002:a17:90a:1502:b0:34a:bebf:c162])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c08:b0:34a:e9b:26b1 with SMTP id 98e67ed59e1d1-35889194a48mr474071a91.26.1771384964802;
 Tue, 17 Feb 2026 19:22:44 -0800 (PST)
Date: Tue, 17 Feb 2026 19:22:29 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218032232.4049467-1-tjmercier@google.com>
Subject: [PATCH v3 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
 for files
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13986-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10BEC152D08
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
Changes in v3:
Remove parent IN_DELETE notification per Amir.
  Refactored kernfs_notify_workfn to avoid grabbing parent when
  unnecessary for DELETE events as a result.
Use notify_event for fsnotify_inode call per Amir
Initialize memcg pointers to NULL in selftests
Add Amir's Ack
Add Tejun's Acks to the series

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
 fs/kernfs/file.c                              |  49 ++++---
 fs/kernfs/kernfs-internal.h                   |   3 +
 include/linux/kernfs.h                        |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
 5 files changed, 175 insertions(+), 21 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.310.g728cabbaf7-goog



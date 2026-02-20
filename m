Return-Path: <cgroups+bounces-14047-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ICzBZn3l2k4+wIAu9opvQ
	(envelope-from <cgroups+bounces-14047-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:56:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684CD164DE5
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7DF303CD18
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22E32E732;
	Fri, 20 Feb 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4ja4f0L"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CC326D4A
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566910; cv=none; b=SBX0VhEISbdYZ8hbwOB0C2yLKlZPPKeRfmO5xWoJ1kRuD8zwqNvU2EBPoE+sqk2QZp7MMU0XsnmSqf2JEK+cjo9B3JRVUFNRQpE/MQtCmvDCUFtDau28wTxL3ZB2twc+eFN02H5btlgEXSofqKBGVnmCZF2TEv4dikmL2OHalmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566910; c=relaxed/simple;
	bh=SETEcec1D+mm0BU0dgNl2Gb3HG9APdLtZ19G+u8CMQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B0XoI1Saf1l8QINNYBnZGJJ5sKIVk2tLNNfvvBiFl18db8plXay3QKJGiSUf920S+5lUOqiiJ3PqL6cIRNcJPF9zhfsI7qBqnzC6Y/FH8NWp/keaZvXVVaDU7V3niEEmaqn9FQmWEdjwxRjwBFFFA7Y2RtiWy7sgGNBzXfO/p1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4ja4f0L; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so1842761a91.0
        for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 21:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566908; x=1772171708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhOr9xc8hsjU1exlkJ9o+lRZ6CwgWrB0En0qqwGcrsk=;
        b=I4ja4f0LlfshNDN7PredsaOvaI4MSfe7fyNx7Z5nCKc6eVnE0pLROUbjX/FKA93rTG
         SiJL9HkpuaKQzP2UO6X7TIrDKvl28KeKYHFz+Wz3kd52ygj2K6vQjmaNoFfyd1Ax6+Jk
         M0xAYnn0DPVM2372e3Pd9CnjA6MziZ7Z8/lNv3IXn3St2NxpQo5a5NAmyUs6ozELbO86
         /XxJE6iSMHcv8hV/b0BPNQSgI2RMmtn0vXvOkgQQa22bSYb9XuSiwVHSAKzpPp+2D8WY
         3Avsga2DUGOWica3gKQ+wzNITJW5r4Xuu3Cl4IXxZRFPyvNeMXVEpK0uHzvIrFh/4tdt
         Fazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566908; x=1772171708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhOr9xc8hsjU1exlkJ9o+lRZ6CwgWrB0En0qqwGcrsk=;
        b=DibjlYjUSfLTRwWg54wbkhWpBQXFSf4V8+kkpyCgYMKde9sMToHu2Z48SIDNmsKqFH
         wv5r8Zzh7d29S74++AEtkKV5fP2Sp3RH+LfmZXkQtaXCVGz6tJ/6zN6BWQxNMSwutyI8
         UOhzMliav34gMX0mmYCBfQ2B20AowQlccMmbr8XbXogniVv4IFslHRaiStNuouyymCk/
         pkRBTaDySsZLYJ4hSxND6Ec5HGSq8VmyonbrUQgF0txLyWZNon7zyokRkjrRqm8+LiOc
         dzaPjbAXll1N9HrxWpf5+8OYf+fkfszbz2jcD0wnbypywJUw/ubpncEdWXC0C/kVU1ym
         tksQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAciHVrVWtg15pzyX/yWT4ircp8FK4ZqYl2hudhz1owbs7r1zwKLtw77fkiOPqpYC8CGKXvpce@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/PunndSGEHw3U2eVPQTntx2DkJgm/8rJtPRo0Lf+TOTJsLnz
	uEFAN5DPxQFEXPQxnSApk2vOwIys87KVly/w3FBND21TOcUDYeTocXV0CGwXxrCv7+1PMIsWEUA
	q0UHEWF/vPR+jWB58RQ==
X-Received: from pjbsj6.prod.google.com ([2002:a17:90b:2d86:b0:34e:90d2:55c0])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:da86:b0:354:a9f3:68bc with SMTP id 98e67ed59e1d1-358891cb92bmr6358367a91.30.1771566907697;
 Thu, 19 Feb 2026 21:55:07 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:45 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-1-tjmercier@google.com>
Subject: [PATCH v4 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14047-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 684CD164DE5
X-Rspamd-Action: no action

This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
events to kernfs files and directories.

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
Patch 1 preemptively addresses a race to set/clear i_nlink that would
        arise in patch 2.
Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
        on file / dir removal.
Patch 3 adds selftests to verify the new behavior.

---
Changes in v4:
Clear inode i_nlink upon kernfs removal instead of calling fsnotify
from kernfs per Jan. This adds support for directories.
Abandon support for files removed from vfs_writes.
Add selftest for directory watch per Amir.
Add Amir's Ack to selftests.

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
  kernfs: Don't set_nlink for directories being removed
  kernfs: Send IN_DELETE_SELF and IN_IGNORED
  selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED

 fs/kernfs/dir.c                               |  32 ++++-
 fs/kernfs/inode.c                             |   2 +-
 .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
 3 files changed, 144 insertions(+), 2 deletions(-)


base-commit: ba268514ea14b44570030e8ed2aef92a38679e85
-- 
2.53.0.414.gf7e9f6c205-goog



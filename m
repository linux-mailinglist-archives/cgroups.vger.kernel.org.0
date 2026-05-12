Return-Path: <cgroups+bounces-15832-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oArwKLTvAmrAywEAu9opvQ
	(envelope-from <cgroups+bounces-15832-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:15:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97851D727
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 422B8308C942
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980D3ACA5D;
	Tue, 12 May 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWHZXjeI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE83AC0FD
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577098; cv=none; b=XuNWATSqe+qvpJV2djDeaTR5cmIghPXOADppRf0TaqS2oNe0vj63YPwB4YLs1DEOCzpLpWvJ9BSMWJZSE+Qb3y0ueMKu4uPCTFrTZw/4PTGpevEuP5CN2igkrzGSMzNDhkXQCqwDGsnBV8lqnozkGWvmO6uv2Flx4uOme0yRQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577098; c=relaxed/simple;
	bh=J/qTQA7WOSp0NDpJTrrE9CeifCSS0KYK7Fhqb5IuZRE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q9SM/QPbdZyucm5Tnzj2nd7PrXlvlWYvXkFZiuZFO/Ax5aj600kCvOshfpCRAKnDxP5q5K+8/JpL/OSTkApP3IOxmWJ/aH+bz+hPLDvFobqVCmIgl3+g3P+FpRy1uhG60iVGIx1bAT2teiTvCU8jrj0plrxNd/DxbVmPyw3ULAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWHZXjeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778577095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p80uB9ppx8DS0thaGwc0VH0L36R/21WsbTghYE9KDbw=;
	b=PWHZXjeIrSy+VsffKsMKeLjOC3+O1hMqczZMEHI3xV7U2mDBv55yFhaytySeHU9aIoKVEN
	WY5rd8KpaGkNsJy7CB0fH/XRZzX7GVM+y4MMdkyOYIFwv4oM94ihSGdUsdjbXV6kPtNXbA
	SrlVIiwKWZdxavxnvlw88cTfuc1L2pA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-EieOxPp9O_ajxHZeof5XwA-1; Tue,
 12 May 2026 05:11:32 -0400
X-MC-Unique: EieOxPp9O_ajxHZeof5XwA-1
X-Mimecast-MFC-AGG-ID: EieOxPp9O_ajxHZeof5XwA_1778577088
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 228A618005B4;
	Tue, 12 May 2026 09:11:27 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09A6130001BB;
	Tue, 12 May 2026 09:11:17 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH RFC 0/5] memcg: dma-buf per-cgroup accounting via pid_fd
Date: Tue, 12 May 2026 11:10:42 +0200
Message-Id: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ7bmCTqEivhT7Aa5HQxk3cUk3Zi
 BTEvzd4m7nM7JBJmDJcqx2ENs6cliL6UoGfnkskxWNxMGhabLBTm3GFLWpj3fqeSTyTuJhS/JD
 zaVahroMPL902FqFkvkKBf+fiAf39BsNx/AFCOWAcdwAAAA==
X-Change-ID: 20260508-v2_20230123_tjmercier_google_com-f44fcfb16530
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778577077; l=4167;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=J/qTQA7WOSp0NDpJTrrE9CeifCSS0KYK7Fhqb5IuZRE=;
 b=w9BOSU+QzmBOQFJx39er3JufOMU+NTrwANFwrY1GjbF+ilD6YeDqgSMvjLwB7Lz3uKINM9vQE
 qrkVFKK2zfBDqr0ZUk82SaBAThNIU7vg1o9c6Q1zxh0DX4Y13wK5MeR
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 5B97851D727
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15832-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This RFC builds on T.J. Mercier's earlier series [1] which added
a memory.stat counter for exported dma-bufs and a binder-backed
mechanism to transfer charges between cgroups.

The first commit is taken almost verbatim from TJ's series:
it introduces MEMCG_DMABUF as a dedicated per-cgroup stat, so that
the total exported dma-buf footprint is visible both system-wide
(via the root cgroup) and per-application (via per-process cgroups).
This avoids the overhead of DMABUF_SYSFS_STATS and integrates
naturally into the existing cgroup memory hierarchy.

The rest of the series departs from TJ's approach. While the first
commit introduces the memcg stat infrastructure for dmabufs, the
export-time charging it introduces in dma_buf_export() is then
superseded: we charge at dma_heap_ioctl_allocate() time, using a
new charge_pid_fd field in struct dma_heap_allocation_data. The
allocator opens a pidfd for its client (e.g., from binder's
sender_pid), passes it to the ioctl, and the kernel charges the
buffer directly to the client's cgroup at allocation time, so no
transfer step is needed.

This decouples the accounting path from binder entirely:
any allocator that knows its client's PID can use the pid_fd
mechanism regardless of the IPC transport in use.

The cross-cgroup charging capability requires access control.
Patches #3 and #4 add a generic LSM hook (security_dma_heap_alloc)
and an SELinux implementation based on a new dma_heap object class
with a charge_to permission, so policy authors can express which
domains are allowed to charge memory to another domain's cgroup.

Last patch adds some tests to verify the new charge_pid_fd field.

We are sending it as an RFC to spark broader discussion. It may or
may not be the right path forward, and we welcome feedback on the
trade-offs.

Collision note: Eric Chanudet's series [2] adds __GFP_ACCOUNT to
system_heap page allocations as an opt-in module parameter. That
approach charges pages to the allocator's own kmem, which overlaps with
MEMCG_DMABUF. This series explicitly removes __GFP_ACCOUNT from system
heap allocations and routes all accounting through the MEMCG_DMABUF
path to avoid double-counting.

[1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@google.com/
[2] https://lore.kernel.org/r/20260113-dmabuf-heap-system-memcg-v2-0-e85722cc2f24@redhat.com

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (4):
      dma-heap: charge dma-buf memory via explicit memcg
      security: dma-heap: Add dma_heap_alloc LSM hook
      selinux: Restrict cross-cgroup dma-heap charging
      selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

T.J. Mercier (1):
      memcg: Track exported dma-buffers

 Documentation/admin-guide/cgroup-v2.rst            |   5 +
 drivers/dma-buf/dma-buf.c                          |   7 +
 drivers/dma-buf/dma-heap.c                         |  54 +++++-
 drivers/dma-buf/heaps/system_heap.c                |   2 -
 include/linux/dma-buf.h                            |   4 +
 include/linux/lsm_hook_defs.h                      |   1 +
 include/linux/memcontrol.h                         |  37 ++++
 include/linux/security.h                           |   7 +
 include/uapi/linux/dma-heap.h                      |   6 +
 mm/memcontrol.c                                    |  19 ++
 security/security.c                                |  16 ++
 security/selinux/hooks.c                           |   7 +
 security/selinux/include/classmap.h                |   1 +
 tools/testing/selftests/cgroup/Makefile            |   2 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   | 143 +++++++++++++-
 tools/testing/selftests/dmabuf-heaps/config        |   1 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 126 ++++++++++++-
 tools/testing/selftests/dmabuf-heaps/vmtest.sh     | 205 +++++++++++++++++++++
 18 files changed, 633 insertions(+), 10 deletions(-)
---
base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
change-id: 20260508-v2_20230123_tjmercier_google_com-f44fcfb16530

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>



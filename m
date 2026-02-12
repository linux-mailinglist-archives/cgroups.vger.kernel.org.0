Return-Path: <cgroups+bounces-13867-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCk1LtMgjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13867-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF6128ABC
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFB130254FE
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838251C5F27;
	Thu, 12 Feb 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bflo7ZBi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211F19F48D
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856649; cv=none; b=JTXSOZQjRYGc4Un/dAmEp6Oq0O7dnOrwLAkYX5BhDv0uZarGg2pu5k5Llz8ADVzVABACAPt2E9mQ+cWclJ9SB9LmOZucsxLFdu5KQUMZrUhp1QhxtarEFMLjd4IYRM4lBcwWzA8CiREiz+KcdjSogzdQR7OSn7vJMgRdUq2Gd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856649; c=relaxed/simple;
	bh=9WTi6KAC0+HthWewv6tioKPF1lEUgA9a4VwO5mmLJn4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KIGPkNCc9AJyOqOjHKCjiU3QWadgby3r18ZCqHW4WTtwYLJX/lw6nRrG6gNdbkeMCAmsvtR0VvfxRDnGy9Bb5w+fHpRGH9F0RyGhS2cHxUigWFj3RaXqP5zA9F8j6hipxJ+G7HB1Es4qaKlyTac0Y6KamEqgTz5Sk07wWKBRPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bflo7ZBi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8249ba7f6e8so607954b3a.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856646; x=1771461446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJpTlhiR4TRyjHrLxyY5K7IcESbEG+rqURvXdu9Kbh4=;
        b=Bflo7ZBi+oTruw92NTznVg+QPwuYMHL3v8GJwLvULFQ+Tltta9pHScczIR98PiFIHX
         eEA7COTGy0bZsjF4Fq0D1IVGjJ26gIXbrH0Xw5uA2bddVWCpWc+6F1l/UVNsT0o0vh/P
         i3Tv6sL8iauQ8jp7PwwyKFQrmMgjNK8VaIN/4bJ0vriK0sn4OjGonEVn25dmnE/I0Grf
         OjjsVhYz7G2SuUeLkZQfBOUWU4rnc9gcsUXM8lUNTnGSoB78llZoEXVClp2eNH8MJoHx
         lpZEqw2AagyOfCV8o4bwiS8VYIabzQexRf3p9J3LtKYS12LCPRNUm3dC5PAfm7lht9NT
         ShKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856646; x=1771461446;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJpTlhiR4TRyjHrLxyY5K7IcESbEG+rqURvXdu9Kbh4=;
        b=RzheZctVDKBm+1iNTuRJjXx5aWsz61qSjkb62seH83VaL6oSVzwqwQg7/zkZKNrZSZ
         RO7+pymHScPfk5bluvqjoJVmSrUXHV157PVvS+Sze53W8K4TDcUrTuadmEXIxQilDYoj
         eje2hLLYlFWb/cHaShWGzsh2LX1p8JpxO2Rm3DyzuqtacCRjXf2u+WinsN/+Bx+L0gGP
         IBzJg2AjeNk8qSDB/kG7PexkW+K88MzNuk6aEf15fO6FMxyBJAZTa6VRKDLn7nxLQ3oR
         Zu40kSFiO5m8oOoUYdatB7mIYYe7zClppoeQZC5D3jGbHhPyF9O1AV3tawgmh7XPtA7n
         GNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxa/0jJ0TYPcRx90xxijxpuQKF3q7wBM23adnQJesXqfFe9K8kHe/iL9oIfQ1CJm6vRnKfrmHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YycGap0o3dZNB/xUoxWJ4d9tzYNwPKbSU7DFONJXw+l6NiCb/9w
	GyTQ0lAu7bZK+nF99kZaZSkrdm3MtMFKT7EWqdBSspZfT8pab4AB8pJZJ22pejgW7kpi+WxI4Tc
	dUccuOkqIJQqY9kQUsvHbD8VnCQ==
X-Received: from pfbih24.prod.google.com ([2002:a05:6a00:8c18:b0:824:b235:888c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2492:b0:821:8230:235d with SMTP id d2e1a72fcca58-824b04e5834mr661593b3a.39.1770856646414;
 Wed, 11 Feb 2026 16:37:26 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:11 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <cover.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 0/7] Open HugeTLB allocation routine for more generic use
From: Ackerley Tng <ackerleytng@google.com>
To: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, mhocko@kernel.org, 
	michael.roth@amd.com, muchun.song@linux.dev, osalvador@suse.de, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterx@redhat.com, 
	pratyush@kernel.org, rick.p.edgecombe@intel.com, rientjes@google.com, 
	roman.gushchin@linux.dev, seanjc@google.com, shakeel.butt@linux.dev, 
	shivankg@amd.com, vannapurve@google.com, yan.y.zhao@intel.com
Cc: ackerleytng@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13867-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BBF6128ABC
X-Rspamd-Action: no action

Hi,

The motivation for this patch series is guest_memfd, which would like
to use HugeTLB as a generic source of huge pages but not adopt
HugeTLB's reservation at mmap() time.

By refactoring alloc_hugetlb_folio() and some dependent functions,
there is now an option to allocate HugeTLB folios without providing a
VMA. Specifically, HugeTLB allocation used to be dependent on the VMA
to

1. Look up reservations in the resv_map
2. Get mpol, stored at vma->vm_policy

This refactoring provides hugetlb_alloc_folio(), which focuses on just
the allocation itself, and associated memory and HugeTLB charging
(cgroups). alloc_hugetlb_folio() still handles reservations in the
resv_map and subpools.

Regarding naming, I'm definitely open to alternative names :) I chose
hugetlb_alloc_folio() because I'm seeing this function as a general
allocation function that is provided by the HugeTLB subsystem (hence
the hugetlb_ prefix). I'm intending for alloc_hugetlb_folio() to be
later refactored as a static function for use just by HugeTLB, and
HugeTLBfs should probably use hugetlb_alloc_folio() directly.

I would like to get feedback on:

1. Opening up HugeTLB's allocation for more generic use
2. Reverting and re-adopting the try-commit-cancel protocol for memory
   charging

To see how hugetlb_alloc_folio() is used by guest_memfd, the most
recent patch series that uses this more generic HugeTLB allocation
routine is at [1], and a newer revision of that patch series is at
[2].

Independently of guest_memfd, I believe this change is useful in
simplifying alloc_hugetlb_folio(). alloc_hugetlb_folio() was so
coupled to a VMA that even HugeTLBfs allocates HugeTLB folios using a
pseudo-VMA.

[1] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/T/
[2] https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring-12-08-25

Ackerley Tng (7):
  mm: hugetlb: Consolidate interpretation of gbl_chg within
    alloc_hugetlb_folio()
  mm: hugetlb: Move mpol interpretation out of
    alloc_buddy_hugetlb_folio_with_mpol()
  mm: hugetlb: Move mpol interpretation out of
    dequeue_hugetlb_folio_vma()
  Revert "memcg/hugetlb: remove memcg hugetlb try-commit-cancel
    protocol"
  mm: hugetlb: Adopt memcg try-commit-cancel protocol
  mm: memcontrol: Remove now-unused function mem_cgroup_charge_hugetlb
  mm: hugetlb: Refactor out hugetlb_alloc_folio()

 include/linux/hugetlb.h    |  11 ++
 include/linux/memcontrol.h |  21 +++-
 mm/hugetlb.c               | 228 +++++++++++++++++++++----------------
 mm/memcontrol.c            |  77 ++++++++-----
 4 files changed, 212 insertions(+), 125 deletions(-)


base-commit: db9571a66156bfbc0273e66e5c77923869bda547
--
2.53.0.310.g728cabbaf7-goog


Return-Path: <cgroups+bounces-3117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD78FF08D
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC4928CCB7
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD2196C85;
	Thu,  6 Jun 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c52DHjTf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c52DHjTf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3300195802;
	Thu,  6 Jun 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687366; cv=none; b=dG1juvT8AohU0dM3fj8CwIck42uVXtJjqsev5AZgf3Xqo5k/B5iTf1O7CH8aH5V7Q06qvWDQaQZJIVoQZMTA5hMYmY7mY4ADyBxcjx+Pe9UQJIG8pD5EeHU3uRu08tCkGnZQz462bGNNxyU+jOEeSQJkLa3/ymNrfbGlpXCSVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687366; c=relaxed/simple;
	bh=NDmh2xK9KL5BY3LXtKqrYFW8U7nU7cON6KAQh7Vw1AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2B4u8ax0/WC4DPV0iwcJRjvJxuqpCHDO8dPIOfe/Q408xLGgQsRir636L2DrKq1KBtAxovVXA6ldq+R3RKGEzYN4Jw/BVY1/xOpMwAivcIeAXHHgvCqpDUv1/Av0xNtQkhxPVsF43nv1UbfDTgskPwyOI1CS6ez/yz7uDv0tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c52DHjTf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c52DHjTf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7C942198C;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NVBrEhkQ/SUTCVD/ZxuFTIDe7cANiTexdjnYFfXgLAA=;
	b=c52DHjTf3tz5dLkltT4ybFvvfqEqeP7VMxVhebZGrZjSxJZTqFA2ujwnKNLd3/PUd3aLWh
	fmdUzRrs+qpFz5x0C5YT2Nq+hT0dbUWCkoqFNMkU6lwUpZTyvMObCWR+daUXWP38DnSQsa
	kg2Fba2IanT4uhU1ZPr5hPAgPTSvYoE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NVBrEhkQ/SUTCVD/ZxuFTIDe7cANiTexdjnYFfXgLAA=;
	b=c52DHjTf3tz5dLkltT4ybFvvfqEqeP7VMxVhebZGrZjSxJZTqFA2ujwnKNLd3/PUd3aLWh
	fmdUzRrs+qpFz5x0C5YT2Nq+hT0dbUWCkoqFNMkU6lwUpZTyvMObCWR+daUXWP38DnSQsa
	kg2Fba2IanT4uhU1ZPr5hPAgPTSvYoE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5ED913A79;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xy04LEHUYWbGbwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 06 Jun 2024 15:22:41 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Subject: [RFC PATCH v5 0/3] Add memory.max.effective for application's allocators
Date: Thu,  6 Jun 2024 17:22:29 +0200
Message-ID: <20240606152232.20253-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.02
X-Spam-Level: 
X-Spamd-Result: default: False [-1.02 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.72)[83.70%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Some applications use memory cgroup limits to scale their own memory
needs. Reading of the immediate membership cgroup's memory.max is not
sufficient because of possible ancestral limits. The application could
traverse upwards to figure out the tightest limit but this would not
work in cgroup namespace where the view of cgroup hierarchy is
incomplete and the limit may apply from outer world.
Additionally, applications should respond to limit changes.

(cgroup v1 used memory.stat:hierarchical_memory_limit to report the
value but there's no such counterpart in cgroup v2 memory.stat.)

Introduce a new memcg attribute file that contains the effective value
of memory limit for given cgroup (following cpuset.cpus.effective
pattern) and that sends notifications like memory.events when the
effective limit changes.

Reasons for RFC:
1) Should global limit be included? (And respond to memory hotplug?)
2) Is swap.max.effective needed? (in v2 without memsw accounting)
3) Should memory.high be also handled?
4) What would be an alternative?

My answers to RFC:

1) No (there's no memory.max in global root memcg)
2) No (app doesn't have full control of memory that's swapped out)
3) No (scaling the allocator against the "soft" limit could end up in
   dynamics difficult to reason and admin)
4)
- PSI (too obscure for traditional users but better semantics for limit
  shrinking)
- memory.stat field (like v1 but separate attribute is better for
  notifications, cpuset precedent)

Changes from v4 (https://lore.kernel.org/r/ZcvlhOZ4VBEX9raZ@host1.jankratochvil.net)
- split the patch for swap.max.effetive
- add Documentation/
- reword commit messages
- add notification support

Michal Koutný (3):
  memcg: Add memory.max.effective attribute
  memcg: Add memory.swap.max.effective like hierarchical_memsw_limit
  memcg: Notify on memory.max.effective changes

 Documentation/admin-guide/cgroup-v2.rst |  6 ++++
 include/linux/memcontrol.h              |  2 ++
 mm/memcontrol.c                         | 46 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+)


base-commit: 2df0193e62cf887f373995fb8a91068562784adc
-- 
2.45.1



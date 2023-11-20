Return-Path: <cgroups+bounces-480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E117F1C90
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0C02828BC
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61430CFB;
	Mon, 20 Nov 2023 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTA9iWAb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZZRf0/d+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E6D92;
	Mon, 20 Nov 2023 10:34:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0AB1F895;
	Mon, 20 Nov 2023 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TE/wmIqY+Mqmq3Uv3qpaJHn4wLurFsze1PiLFKu5tjU=;
	b=NTA9iWAb7zpjPvHwyg4esMrdJ8vKeanEb3iLWBslYWd3X7vt3x1fcGIctO29bmM8VtZa9y
	CL8VH2A7xuHHLshh4X9erTFthmcC5Q3DqS2QsInmMww+U7j2YuUn8yabXRectCp9H4NcG2
	k1NwXPWDXAHMZsjRc6UuPdjyeTq2NFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TE/wmIqY+Mqmq3Uv3qpaJHn4wLurFsze1PiLFKu5tjU=;
	b=ZZRf0/d+HXx84QJ4iQmfJf8GbYpdCD8NzhSyVn1DAQRsoM9MmArYprkHgd5AgYU02Q3WP1
	67j1bRCggDslOKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D01313499;
	Mon, 20 Nov 2023 18:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id omBJCr+mW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 00/21] remove the SLAB allocator
Date: Mon, 20 Nov 2023 19:34:11 +0100
Message-Id: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSmW2UC/03MQQ7CIBCF4as0s5YGhoaiK+9hXACdWqIthlFib
 Hp3iW7cvW/x/hWYciSGQ7NCphI5pqUCdw2EyS0XEnGoBpSolUIp+Oa8yDSnQr/tekPBGDvYYKD
 e7pnG+PomT+fqMadZPKZM7i+ktNor3clW9Z1FgSiKd/7qjvxkasMbtu0DXrt6spsAAAA=
To: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
 Michal Hocko <mhocko@suse.com>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 5.30
X-Spamd-Result: default: False [5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[25];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz,suse.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

Changes from v1:
- Added new Patch 01 to fix up kernel docs build (thanks Marco Elver)
- Additional changes to Kconfig user visible texts in Patch 02 (thanks Kees
  Cook)
- Whitespace fixes and other fixups (thanks Kees)

The SLAB allocator has been deprecated since 6.5 and nobody has objected
so far. As we agreed at LSF/MM, we should wait with the removal until
the next LTS kernel is released. This is now determined to be 6.6, and
we just missed 6.7, so now we can aim for 6.8 and start exposing the
removal to linux-next during the 6.7 cycle. If nothing substantial pops
up, will start including this in slab-next later this week.

To keep the series reasonably sized and not pull in people from other
subsystems than mm and closely related ones, I didn't attempt to remove
every trace of unnecessary reference to dead config options in external
areas, nor in the defconfigs. Such cleanups can be sent to and handled
by respective maintainers after this is merged.

Instead I have added some patches aimed to reap some immediate benefits
of the removal, mainly by not having to split some fastpath code between
slab_common.c and slub.c anymore. But that is also not an exhaustive
effort and I expect more cleanups and optimizations will follow later.

Patch 09 updates CREDITS for the removed mm/slab.c. Please point out if
I missed someone not yet credited.

Git version: https://git.kernel.org/vbabka/l/slab-remove-slab-v2r1

---
Vlastimil Babka (21):
      mm/slab, docs: switch mm-api docs generation from slab.c to slub.c
      mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
      KASAN: remove code paths guarded by CONFIG_SLAB
      KFENCE: cleanup kfence_guarded_alloc() after CONFIG_SLAB removal
      mm/memcontrol: remove CONFIG_SLAB #ifdef guards
      cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
      mm/slab: remove CONFIG_SLAB code from slab common code
      mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB ifdefs
      mm/slab: remove mm/slab.c and slab_def.h
      mm/slab: move struct kmem_cache_cpu declaration to slub.c
      mm/slab: move the rest of slub_def.h to mm/slab.h
      mm/slab: consolidate includes in the internal mm/slab.h
      mm/slab: move pre/post-alloc hooks from slab.h to slub.c
      mm/slab: move memcg related functions from slab.h to slub.c
      mm/slab: move struct kmem_cache_node from slab.h to slub.c
      mm/slab: move kfree() from slab_common.c to slub.c
      mm/slab: move kmalloc_slab() to mm/slab.h
      mm/slab: move kmalloc() functions from slab_common.c to slub.c
      mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
      mm/slub: optimize alloc fastpath code layout
      mm/slub: optimize free fast path code layout

 CREDITS                           |   12 +-
 Documentation/core-api/mm-api.rst |    2 +-
 arch/arm64/Kconfig                |    2 +-
 arch/s390/Kconfig                 |    2 +-
 arch/x86/Kconfig                  |    2 +-
 include/linux/cpuhotplug.h        |    1 -
 include/linux/slab.h              |   22 +-
 include/linux/slab_def.h          |  124 --
 include/linux/slub_def.h          |  204 --
 kernel/cpu.c                      |    5 -
 lib/Kconfig.debug                 |    1 -
 lib/Kconfig.kasan                 |   11 +-
 lib/Kconfig.kfence                |    2 +-
 lib/Kconfig.kmsan                 |    2 +-
 mm/Kconfig                        |   68 +-
 mm/Kconfig.debug                  |   16 +-
 mm/Makefile                       |    6 +-
 mm/dmapool.c                      |    2 +-
 mm/kasan/common.c                 |   13 +-
 mm/kasan/kasan.h                  |    3 +-
 mm/kasan/quarantine.c             |    7 -
 mm/kasan/report.c                 |    1 +
 mm/kfence/core.c                  |    4 -
 mm/memcontrol.c                   |    6 +-
 mm/mempool.c                      |    6 +-
 mm/slab.c                         | 4026 -------------------------------------
 mm/slab.h                         |  551 ++---
 mm/slab_common.c                  |  231 +--
 mm/slub.c                         |  617 +++++-
 29 files changed, 815 insertions(+), 5134 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231120-slab-remove-slab-a76ec668d8c6

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>



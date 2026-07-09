Return-Path: <cgroups+bounces-17594-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZIkaJ5Q7T2o2cgIAu9opvQ
	(envelope-from <cgroups+bounces-17594-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:11:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019872CFFB
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 08:11:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rKxOtsYv;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17594-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17594-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1843302E0E7
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436363AFB1B;
	Thu,  9 Jul 2026 06:11:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0573AD52F
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 06:11:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577486; cv=none; b=SXjYKZMaP3LJmwBiof7PYLdXMja3xuaXm/mx8fK0x5lhZjrPaqFVM/BZg86QBEOVjbs33JKWH/PBFVBCqRMkaNiZBsto34MAKlzhhn52W9D+XT2Hh+XY7Q2H1uatTR7ANbRHM4KEeRsSWQYDZnyvtrwYQGDbp+Dq8RGfGqkrMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577486; c=relaxed/simple;
	bh=EUgxUMI4K7JFDpVXkNKVUQFFCv3LFfWMvknmwoGt5yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJhJb4zshzkH7awZbZ+1pnEDqpoDuRNgBloVflPXUoyQyl1UBSHe9f9JAUyALAV4cmyj+8xogSIGDsGn3QrRnnh+hzKhw22hY9LgIclh6QkVgck8Huz5cOkz6y4MVjinmXUts15uAHEMBHFeS7xHRdocTHVXz7vgIeIM+xyGX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKxOtsYv; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so8063545ad.1
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783577484; x=1784182284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hd6GoWd0nNSvkzn4bZsOD9QjS5q1cvBf4vz24CQIaxI=;
        b=rKxOtsYv1lWdrEy4qahWaetYQlPfcjAwdcMrO6qs0htyGPA050gFAozjx/uOqokN4U
         h0XsY9vZ2CzBuMf3LAKxsTKK/ncyrKLceQjVDZ90mxWVn+o/PugBnxtP8KTGr095O4Xt
         8Z4rmxaJOj/ETGqMU0Fgxj7No9WaaOdyzkzjvxK6xbsYUXF30foMT4wLJPM84E2SWApJ
         6edOmneTAWrE8i0s8O29x3J+ouK5hWwwDNztBCP7kRBKDQLUzWuXafLAVKBtIW9s1KSi
         Z/mIGQozLUM2LbioRdN8Y2FMXw5pdX0+SV52IxGN77J3jO3lz9dh2CVzx6AXDSVRdl5s
         o0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577484; x=1784182284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hd6GoWd0nNSvkzn4bZsOD9QjS5q1cvBf4vz24CQIaxI=;
        b=s2zTD/Dv0Et8XPX1XVc3AnEKbkmDxN4kuEbQvimL/XmXlF04NXT7XDhUQzSYAFODnT
         JsGkJjYs25+3Fxqwi3QxRZFfWPMjiAsoXRLU2ViDlRG2PdMqkWORcVJtcZfy9ADFDprR
         eDQzheVIt4GbLhoHpTojQiQGjzvSaXoLQTCROkf+Yq3DEPYs+NAzvGVTJf/lxFwuYYi3
         jZ4tGmD6bWC8IQjjjw2Iopo46B+GTTF5dSIYnTDRjgBLbmGOgZCw1l2nViEoX2hgsbKV
         kluodiVIkamDhErAbr3mexyoMDqilK1NApdp7xDYe6zRCjTA8W1yxBOpX5wP+oQqOcMP
         hgDg==
X-Forwarded-Encrypted: i=1; AHgh+RriZgLwHO0Z/+RgkzH5fSz+n/YBymajgkjjqSy/LOch7Fp+eKrg6NcQjopy6l7fIc3nM4rt+m4y@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZFbOw0RmGdhspyftJdbf3sdwu+LIdjAWfKf4lFL0o4PnrEQg
	vw1dcZ4HwEX6AKOROJv633PVJmd+WtfkXAu1FWHUgassfsI5GjaTu3Wjb80hPcKrFDk=
X-Gm-Gg: AfdE7cnNktAzp7bkfYuxgr1is6nW0Ba89GizBOb8URfbmJnqL+YSaYGaPoSui3u0WE2
	EX0ijwjAcXG7ikGWzOYysBIt6gKDdTxCKjDHonbC9d7NeYNACfP1/Vn7UBT/nXLT0+8vfaWQ3tW
	K72olefu1hIcDo9sBl6Wp5iBj7vnnTbLvVgbg1t4oD08+SXD6K6tbjMN2yQA1vuQ0wtrZlsATwF
	esTsTz9QNYjck/z59SwkgEkPlAD3WnVJILtzuQllo7vQEIyNRAbUUu0ThrhhendXuVJk0pPUmgX
	LyQ3jCLrNVyguKXfEOtWzAi9dn9yGHL3E1T4YlEhGP9rDJRBJDdOAS029x6m8pJ41d1HD5koVLR
	tzIHnRvMWXDPYn0Wv0l320k3FdrScNFwQxH/t28elIAFEyocmwaAkq45U5FYsl6IHp0+BDFCctv
	EFVccCv9c=
X-Received: by 2002:a17:902:ce0d:b0:2c9:d27b:af11 with SMTP id d9443c01a7336-2cdd8a84479mr14704525ad.11.1783577484149;
        Wed, 08 Jul 2026 23:11:24 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d602fdsm37778845ad.81.2026.07.08.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:11:23 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: matthew.brost@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	matthew.auld@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	natalie.vock@gmx.de,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Jing Wu <realwujing@gmail.com>
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with proactive reclaim
Date: Thu,  9 Jul 2026 14:11:13 +0800
Message-ID: <20260709061114.1623774-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
References: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,amd.com,intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de,linux.dev,lists.freedesktop.org,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17594-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:natalie.vock@gmx.de,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:realwujing@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1019872CFFB

On Wed, Jul 09, 2026 at 12:44:37AM -0700, Matthew Brost wrote:
> This looks quite similar to work Thomas is doing here [1].

Thank you for the pointer, Matt.  We were not aware of Thomas's series
before your mail.  After reviewing Thomas's v7 [1], the two series turn
out to address different — and complementary — problems:

  - Thomas's series hooks a reclaim callback into the dmem.max write
    path: when an administrator lowers dmem.max below current usage, the
    kernel calls the driver's reclaim callback to bring device memory
    usage down to the new limit.  This is analogous to what happens in
    memcg when memory.max is written below current usage.

  - Our series adds dmem.high as a soft limit enforced in the charge
    path: when a successful allocation pushes a cgroup's usage above
    dmem.high, TTM proactively evicts one BO from that cgroup before
    returning.  This mirrors memory.high semantics in memcg, where
    reclaim is triggered per-allocation to keep usage below the soft
    threshold.

Both mechanisms coexist independently in memcg and serve distinct
purposes: the max write path handles capacity reconfiguration by
operators, while the high-limit path provides automatic backpressure
for workloads approaching their quota.  Having both in the dmem cgroup
controller seems correct.

> Are either of you two aware of this seemly overlapping work?

We were not, until your mail.  Now that we are, we would like to
coordinate with Thomas on a few interaction points:

  1. API intersection: Thomas's v5+ replaces the bare u64 size argument
     in dmem_cgroup_register_region() with struct dmem_cgroup_init (which
     bundles the region size, reclaim ops, and driver private data).  If
     Thomas's series lands first, we will adapt our patches to the new
     registration interface.

  2. File-level conflicts: both series modify ttm_resource.c and
     ttm_bo.c.  The changes are semantically independent and should
     compose cleanly after a rebase, whichever lands second.

Thomas, would you be open to coordinating on merge ordering?  We are
happy to rebase our dmem.high series on top of yours once it lands, or
to split out any shared infrastructure as a common prerequisite if that
helps.

Thanks,
Jing Wu


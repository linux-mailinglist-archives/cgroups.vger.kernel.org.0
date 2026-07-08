Return-Path: <cgroups+bounces-17584-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTpLLyt1TmqbNAIAu9opvQ
	(envelope-from <cgroups+bounces-17584-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 18:04:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC477286B5
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 18:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=dGlKrwou;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17584-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17584-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 238F430672C4
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597A4252C8;
	Wed,  8 Jul 2026 15:46:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F33F12F3
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 15:46:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525571; cv=none; b=fcSrh/NpYfy1z8j8/V00VkVD9Xr2X5eV8M8Kt1BGkqpqqCQdSumclUu41K/13u++zeAykZV6JTUgw9nYTLM3A3yLrVKW/VDwowcZTaWp+kOKztauRatjWHCHQeKnnUHXWvEmwy5RmQkTCBWptrF/UoCwGOFXQmJvhTfmDBS8Nyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525571; c=relaxed/simple;
	bh=SAIqWGqCMY1/8ulI70L31N+5Kd4n4O7YCH/B0hJQOK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxHt/OfkfyVQ7LkDh8IAavXpprS/KoNulNpLlp/ERPmsOn25YmHnkIHMDsmgG6I/yYW1CJAcHRGPlvqRZ7WtvYWvl1xrPzgsU2nYXjMt1BiSaQOVc9jzj/hp6C5ddq9XONyWZoJ8wSDsCknayj4K8XLKFYDZXT2lksBn87iUV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGlKrwou; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so4866125e9.1
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525564; x=1784130364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELc0xKTk0Kykl5od6ahABvgXKhkxN3989aWHpftFOnw=;
        b=dGlKrwouvOdhJZM/oZqkAZACyAtiBTd3yUK907bjVzsIdKUMmmgHeFZxRr5BTr/41d
         KEE6H74i2J83VcFeQ8LuWn38X0CL5ElGzwdvQFlwqQDkvF3ZoMd0+uVeS21K2N1S3QKb
         ixSp3iPMZIl8P0Z37MS7TvWRkrnuSLtdyBObuIMUxcFTjx2R9HLoa5riuAzjHSncv/nC
         X9ogAkUB6pCn8+7ykzROMJC//UBfcSJjI2eFraMsPqShoW19icEXtd99gJWwgrNvKRtS
         y3sSumtgyGUFgRyU0RkskMyp3bqjQ61k1x6p6MJ6V66CtqdUhf2LOORKIvpUBAPCIXs7
         A3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525564; x=1784130364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELc0xKTk0Kykl5od6ahABvgXKhkxN3989aWHpftFOnw=;
        b=j2d7u7U4Yt8aMPs6O2LFJV6B0HPaOZ0IfSfR/rGqpEzf2NmeM7/hE8OfSgtVTHBvn7
         eiJ6Pv/gwhfVX8yfuZmqmdF0ECLJ8Ew2WlE/fruXri1DpXb87ouhvDQhuZ39cVi1bWbi
         zJ6BRxLz3FMVdNvei59SLuqSUafUOUEP+DJP9TS4qlfX5H/14xG2FPz9lyXZt3CSz5Y0
         cPze77w596auk7QYz2MqXjzEKxep/VM5ZKeuG4rsreZyNEAeQ61emJo5NivlNkRH2WAi
         wQxq82MP+ud/eiQTVIciI4kF6vKwPD+FZMLqG29VEpNpW3thx/dtS8tKKx26fjOLRSfd
         l7PA==
X-Forwarded-Encrypted: i=1; AHgh+RoMMq1aLj9OWsrji80zm1MCTuRH0wSwMEhkqhytvZF2sNatAsAqoiiJwt/t5Luf9FS/ZkAoVvrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8vjAVScWzqNQ/YyFomuEIVirw62P86LeD0szL+FCkJeZgZVp
	XAABwc/+mHEpcE/Uj3+1i1VWI4dxR0yG62uT+f/ncRQYvP+6qRIn78vT6F9XAUhwaDE=
X-Gm-Gg: AfdE7cmoxJP4AFA09Ck4FFjb2YzAUYWXjy/IGZt6w/epJQJg8ggIWJ/N/eLdD0g9bUX
	kLCB4w2eAijn4RtJoBS/CmHG2XmqVEkgyMNN4x+4UXWWKSj2oFfwxYWXFZll93+Knr/LVGT9TR+
	N3k2MuS9C2q1+2yP888Xt12BF4mvKlVuo6bZsAkI2dRW4XT4nF0Go/e84WY5ialBOx46qZkzz7i
	TuXsKwRD6v6BJO2YeUlTnsIuxFUcgnNunD8e63DLgaTT4SxdrcLXfTh9Y2yx2QmVwbdjsdXT58y
	oRkYLUIZ6RSnlmzwQ1b6q6NfAmWmMVQYPzrultg2snFg0so4kJtlzQVgXHlCMCWsKFuiFCi/gXN
	LugzMOT4JclGxTJPStvWqg7zXx1IWmCG+JgOd/4ly4H9lob+/MFJsb+0G2DlglaHK74+quAHH7J
	nSdd5el9+MvaqY2doVevJBUMiJT+hBQg==
X-Received: by 2002:a05:6000:703:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-47df07f1aa7mr3243977f8f.36.1783525563754;
        Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where needed
Date: Wed,  8 Jul 2026 17:44:29 +0200
Message-ID: <20260708154510.6794-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tony.luck@intel.com,m:bp@alien8.de,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:philipp.reisner@linbit.com,m:lars.ellenberg@linbit.com,m:christoph.boehmwalder@linbit.com,m:axboe@kernel.dk,m:johan@kernel.org,m:elder@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:spock@gentoo.org,m:deller@gmx.de,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:trondmy@kernel.org,m:anna@kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:pavel@kernel.org,m:lenb@kernel.org,m:akpm@linux-foundation.org,m:dakr@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:e
 dumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dhowells@redhat.com,m:jarkko@kernel.org,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:takedakn@nttdata.co.jp,m:penguin-kernel@I-love.SAKURA.ne.jp,m:linux-edac@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:drbd-dev@lists.linux.dev,m:linux-block@vger.kernel.org,m:greybus-dev@lists.linaro.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-acpi@vger.kernel.org,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-pm@vger.kernel.org,m:driver-core@lists.linux.dev,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17584-lists,cgroups=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,alien8.de,kernel.org,redhat.com,linux.intel.com,zytor.com,linbit.com,kernel.dk,linuxfoundation.org,gentoo.org,gmx.de,zeniv.linux.org.uk,suse.cz,brown.name,oracle.com,talpey.com,fasheh.com,evilplan.org,linux.alibaba.com,cmpxchg.org,suse.com,google.com,atomlin.com,linux-foundation.org,blackwall.org,nvidia.com,davemloft.net,paul-moore.com,namei.org,hallyn.com,nttdata.co.jp,I-love.SAKURA.ne.jp];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,netapp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EC477286B5

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 drivers/block/drbd/drbd_nl.c         | 1 +
 drivers/greybus/svc_watchdog.c       | 1 +
 drivers/macintosh/windfarm_core.c    | 1 +
 drivers/pnp/pnpbios/core.c           | 2 +-
 drivers/video/fbdev/uvesafb.c        | 1 +
 fs/coredump.c                        | 2 +-
 fs/nfs/cache_lib.c                   | 2 +-
 fs/nfsd/nfs4layouts.c                | 2 +-
 fs/nfsd/nfs4recover.c                | 1 +
 fs/ocfs2/stackglue.c                 | 1 +
 kernel/cgroup/cgroup-v1.c            | 1 +
 kernel/module/kmod.c                 | 1 +
 kernel/power/process.c               | 2 +-
 kernel/reboot.c                      | 2 +-
 kernel/umh.c                         | 2 +-
 lib/kobject_uevent.c                 | 2 +-
 net/bridge/br_stp_if.c               | 2 +-
 security/keys/request_key.c          | 2 +-
 security/tomoyo/common.h             | 2 +-
 20 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 053555206d81..af4e76babe7a 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -11,7 +11,7 @@
 
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/poll.h>
 
 #include "internal.h"
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f9ffcd67607b..de90cf4a0789 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <linux/drbd.h>
 #include <linux/in.h>
 #include <linux/fs.h>
diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
index 16e6de5e9eff..b318eb34bcca 100644
--- a/drivers/greybus/svc_watchdog.c
+++ b/drivers/greybus/svc_watchdog.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/suspend.h>
+#include <linux/umh.h>
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
 
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 5307b1e34261..e66de11c69a3 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/freezer.h>
+#include <linux/umh.h>
 
 #include "windfarm.h"
 
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f7e86ae9f72f..46af1f549337 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -47,7 +47,7 @@
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/kthread.h>
 
 #include <asm/page.h>
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 9d82326c744f..6c503e6914d6 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/umh.h>
 #include <video/edid.h>
 #include <video/uvesafb.h>
 #ifdef CONFIG_X86
diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..4908b44f6fdc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -32,7 +32,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
 #include <linux/pipe_fs_i.h>
diff --git a/fs/nfs/cache_lib.c b/fs/nfs/cache_lib.c
index 9738a1ae92ca..ca4e81d4e315 100644
--- a/fs/nfs/cache_lib.c
+++ b/fs/nfs/cache_lib.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2009 Trond Myklebust <Trond.Myklebust@netapp.com>
  */
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index f34320e4c2f4..008f0f088c3a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2014 Christoph Hellwig.
  */
 #include <linux/exportfs_block.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/file.h>
 #include <linux/jhash.h>
 #include <linux/sched.h>
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6ea25a52d2f4..20b98e43f668 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -41,6 +41,7 @@
 #include <linux/fs.h>
 #include <linux/hex.h>
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <net/net_namespace.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/clnt.h>
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index 741d6191d871..0ccaab29426d 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/sysctl.h>
+#include <linux/umh.h>
 
 #include "ocfs2_fs.h"
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..60eb994c32ae 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -16,6 +16,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/umh.h>
 
 #include <trace/events/cgroup.h>
 
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index a25dccdf7aa7..dcaad5d65275 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 #include <trace/events/module.h>
 #include "internal.h"
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..295904ec9a82 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -16,7 +16,7 @@
 #include <linux/freezer.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <trace/events/power.h>
 #include <linux/cpuset.h>
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..3d4a262973e7 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -11,13 +11,13 @@
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
-#include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
diff --git a/kernel/umh.c b/kernel/umh.c
index 48117c569e1a..72b2d9a878aa 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -8,7 +8,7 @@
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/cred.h>
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..a67129e452a3 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -17,7 +17,7 @@
 #include <linux/string.h>
 #include <linux/kobject.h>
 #include <linux/export.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index a7e5422eb5d1..89bc161a4b47 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index fa2bb9f2f538..e6ba2d054399 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -9,7 +9,7 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/err.h>
 #include <linux/keyctl.h>
 #include <linux/slab.h>
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index d098cf8aae61..d26034000913 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -16,7 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/file.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
-- 
2.54.0



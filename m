Return-Path: <cgroups+bounces-16792-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ok+KZGoKGriHQMAu9opvQ
	(envelope-from <cgroups+bounces-16792-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 01:58:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AA664DD2
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 01:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=berkeley.edu header.s=google header.b=XkfutodT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16792-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16792-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=berkeley.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A013530177AC
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9543EFFCB;
	Tue,  9 Jun 2026 23:57:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829983E4C87
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 23:57:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049466; cv=pass; b=ZOw4vMVuA6yy3tuUWGL2zpkUcKuLxe1k0WicSMc1KUcts4IOgIhq5fIzZvHMmf2ypasrqumWlYwsDlvUKeJSC4LiQPLHBH0hlrcr84jlLuYAiLBdXtLVTVrTfhjFVTmoXapZAFj4IyBRxswc7P8SllMDIURa1yTf3Wg0NlnC8Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049466; c=relaxed/simple;
	bh=6o2xFZURyWP+tObe4cjpPDsfyvJKRP0tCizMlSF5sH8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxug8G3VaV/+CYRpWIg06ra08Hz+YAJrIMPYb3WWFMylxjQPdAEJLPIPCPzu2IbXCS25us+beU5a7Zr90F6JDQJl6juRTiXGw8SqytaRKANNtEm4e7UwCcr5SNEyXeuQiXVKxHShVwRSicDCcWKcAmy/uBe3KIXZsHrT150L/AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=XkfutodT; arc=pass smtp.client-ip=74.125.224.51
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660456349d9so5965432d50.3
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 16:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781049463; cv=none;
        d=google.com; s=arc-20240605;
        b=UFtlUvswRh3lL7KQeCPkSYxD3jfPlEvFKov1WIQq5rBORvuhgIqN64QJ7Q9z320Pb8
         DDipFBxNXpKycdHisSN7MJjAvn1q0P9Swz/TUZdVU1ThK62QcbhsbCmsT+Oi9R+CKa14
         Hv4ps4xlFwabjKwB5WVv0AgKi/6d2L4pLkafDnmr2HJ3HWWgaaGYhkgQIn5VS2PBCOmQ
         4fBJSqs1tvdSuCyv+MENkjgVQG0gXrI3zuemI0IyENFTuETVNrz9wpqPuIjh7j+HgPhQ
         xn0FUvfv7H9zFemc4g8Hg1gpPrupwoISI6vlGIyrbAN4sIwZ3kvIgfisrkx2iqfb8BZF
         deUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        fh=Eq3s3L/EU4MmDrq1L7ByeUSrATEswuf3B6LeiQmYiiM=;
        b=Ss0bFNhDPMKlnQdqtcwiZ1GpW9sizrjW3o4x/oCwKVTOORnzmiFe94ob63lCA6DAhs
         giMPW5v4HXTcTTzJ52mCJeiJmBcVRufZf+5dloHmAbYZ1CflLwJmijSsU0PiT8zAiehW
         FmG+kNrUCHFRHoZBAMtyLnISUiEELve7mkC4kdWHgOCQ4ybG/E+wX4Ulj0Y0rIAC949y
         CifHykW9oQI7X996Em+VWX0KOFWiiQ2HSoQgFjtQm17hZVjQ8TCRHLsBtyeTA+9/oZBM
         yLF5N+SjTTldRzgRpesFhVyDRl1qncT73SzWZCfEjRAgB+C3iPlNv4nWDFktj6ayecuw
         v7AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1781049463; x=1781654263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        b=XkfutodTdC3aWFewu//ZtfbOXEP8PT/+JXGIH2EK+v3USw+hg623JDXIagiWJjV9+z
         qIwFHvEWF4lszgEHh/eFJfxSHDoXHlXRX799qyjokf+BXr8jEraQuiRhdXJ3qsuhVyc8
         CZvV8faGpk2SHfvMUoDaSK5Vmkz4LFHipNl4CmacHz+/7Aj/D6ANtoztAnqCg0qysTqo
         ASQ8yC5CDwDbTcHcxkow2X+yAWm6d72oyuxgfezfMQhLdspPpc2kSpYp4PncrbuoXi9a
         4IITgy+W6/Sx+IN3uiptKMmn7CBq253mvGubffw1lX+GNHWQ5hy7v2QZy/2Cecqggifz
         +JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781049463; x=1781654263;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsLwA10csQX3mPa70cbCrNe5YAZmOcAQoD0WQz/1mlc=;
        b=hOEkO+KHIW3AblCfpP0hobA8/kI51lPJlUauY1nWyztRBNILkiWSyx6Xjvxvi9CaxE
         DzjQGRcnS2NI4H5H4waUw7BJwpFg5LhIrXBpn6aT0qfPIR+b3UQ7o29+MGZCn6i5t/Oh
         /iyH9ceW+G0kn4xA0U+JkI4AqPOskDstxl3h460KCKZVeqRNb+nAPXUTYtsrLwB6YROA
         sR+6WsgPFsd9JaO3rWfziDjH5v2FQGM6fALTxxLS1fTY+ZJDH8B0NuD344OPt5w27Ije
         Kt2pKKpX2pGvHpqdTWp9xvDad8Ti+59t3gFdTIXXOHf6hTpEIaqDevOj95t7+9sjvLyW
         rpCA==
X-Forwarded-Encrypted: i=1; AFNElJ9/fOM/UDSP/LXRXoVZwpjXEWAcW8isEojZPsGEzjCtVnqoANyc5G3ULSoz0vjk9+/ixNWQ0LMH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IrOF4LdbwDyZm9TsGn2RCPd29qFx1ARKf+LCcjVitw0Ym6qk
	JLUXxM48coC6OPnYCojuJcZ41fQtOusZ9MlnO7zIGK4j3HN5qG1AlUJmzx3G0oobR19YrzAcoMR
	MK9wsXPgDzeVJDtEeHSSSHUt25/ENd+LH5++kknzL
X-Gm-Gg: Acq92OHv0hP6Mtr8rt9+JNQJ2/R4D2CpDyIyC+JwnvIDSooGD01Y86eKHf/jmiPTqh5
	4hk6//b0iVrvGJiMV20yJdy4xEvWCTgxKF1CCNimfR44g5ZkA0QQxXBUw2KcJ4XvWmfBSDYXC16
	q/clw/xTwkMvg60aKHg+khUO2Yd+cDvqTAyYrvnMSHpZjknlsse41pYdVTJRR1mzhd87RJpLxgl
	Gi53ErztCu9GJ5mGn8FUnctA6FmlHfgaWHMSTtHQvm71ZNekoDWcikkUMDVJOm0Pfwt+Ej2zJ/e
	u9hljyDKY9vgiOSmaXVG
X-Received: by 2002:a05:690c:e3ca:b0:7bd:5c77:1aa9 with SMTP id
 00721157ae682-7ed09935207mr231089217b3.0.1781049462534; Tue, 09 Jun 2026
 16:57:42 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 19:57:41 -0400
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 19:57:41 -0400
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
References: <25c4bc47-b65d-4c04-8a8f-18eef2b5566a@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Jun 2026 19:57:41 -0400
X-Gm-Features: AVVi8CdwZwsROR8QvBcPRl0TTYKS3lybsjC7VZyFrbO3L3H_GqOslrHHbiWZhF0
Message-ID: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
Subject: [PATCH] cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>
Cc: Farhad Alemi <falemi@asu.edu>, Yury Norov <ynorov@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Waiman Long <longman@redhat.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[berkeley.edu,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[berkeley.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16792-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[farhad.alemi@berkeley.edu,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:gourry@gourry.net,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:longman@redhat.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,redhat.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[farhad.alemi@berkeley.edu,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[berkeley.edu:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,gourry.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 423AA664DD2

cpuset_update_tasks_nodemask() rebinds a task's own mempolicy to the
cpuset's effective, online mems (newmems, from guarantee_online_mems()),
but rebinds that task's VMA mempolicies to the *configured* mask instead:

	cpuset_change_task_nodemask(task, &newmems);
	...
	mpol_rebind_mm(mm, &cs->mems_allowed);

On the default (v2) hierarchy a cpuset that has never had cpuset.mems
written keeps mems_allowed empty while effective_mems is inherited
non-empty from the parent, and tasks may be attached to it (the
empty-mems attach check is v1-only).  A subsequent rebind -- e.g. from a
CPU hotplug event walking the cpuset -- then calls mpol_rebind_mm() with
an empty mask.  For a VMA policy created with MPOL_F_RELATIVE_NODES this
reaches mpol_relative_nodemask() ->
nodes_fold(..., nodes_weight(cs->mems_allowed) == 0) -> bitmap_fold(),
whose set_bit(oldbit % sz, dst) divides by zero:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:bitmap_fold+0x5e/0xb0
   mpol_rebind_nodemask
   mpol_rebind_mm
   cpuset_update_tasks_nodemask
   cpuset_handle_hotplug
   sched_cpu_deactivate
   cpuhp_thread_fun

cs->mems_allowed is the only nodemask in this function that is not the
effective set: the task-policy rebind, the page-migration target and
cs->old_mems_allowed all use newmems.  The sibling cpuset_attach() path
already rebinds VMA policies against the effective mems
(cpuset_attach_nodemask_to = cs->effective_mems) and explicitly notes
that mems_allowed can be empty under hotplug.  Rebind the VMA policies to
newmems too: it is guaranteed non-empty by guarantee_online_mems(), which
fixes the divide-by-zero, and it makes the VMA policies consistent with
the task policy and with the nodes the task is actually allowed to use.

Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: stable@vger.kernel.org
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)

 		migrate = is_memory_migrate(cs);

-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &newmems);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
-- 
2.43.0


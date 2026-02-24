Return-Path: <cgroups+bounces-14195-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKnPKLsInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14195-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B7180EBA
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A0233031354
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB574256C9E;
	Tue, 24 Feb 2026 02:11:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505115695
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899064; cv=none; b=pApDPMnsPzGmwjE83f6lZdqberH7JMGbsdOdvqSXTp/nWM/esNP8aIv9GGGZ2NvMyq2WnfjTuRuhdwz6/mcBzENSwkTnRF5JFeTywpjpKyitmBjebE9uG7HfsibrqCJb2XER4dj0x80XQ0sP1MArBOyn4devrK274cEhLfCWwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899064; c=relaxed/simple;
	bh=mLwkLCGK5m19WDAYI3PGrtOhTiRxU4T79yqCB33BSKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=gnC0aRnbAqYz406pUO9vjPf70ExVDVqKVIHyhPS16gRTGYFp0U4Eyx48XZclt6B10YsNG+OMC3KOGEeOB3rJcFN7VDhxNDI/6biSukdtA5dCfaJQSS4TnDMVnvJb/hlexQaDd7qDkW3gI8uxmsMQnGnW32GBulKSwRYx9iIU9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-2jacT_uKPOG0QRweED8zwQ-1; Mon,
 23 Feb 2026 21:09:08 -0500
X-MC-Unique: 2jacT_uKPOG0QRweED8zwQ-1
X-Mimecast-MFC-AGG-ID: 2jacT_uKPOG0QRweED8zwQ_1771898947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 752B51800465;
	Tue, 24 Feb 2026 02:09:06 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 874D530001BB;
	Tue, 24 Feb 2026 02:08:59 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: drm/ttm/memcg/lru: enable memcg tracking for ttm and amdgpu driver (complete series v5)
Date: Tue, 24 Feb 2026 12:06:17 +1000
Message-ID: <20260224020854.791201-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NINPoWkJzyuygexsgCZAXv6tVzF95E0U28ErmuCW9dE_1771898947
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14195-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 240B7180EBA
X-Rspamd-Action: no action

Hi all,

This time I really want to make forward progress on landing this. I'll like=
ly merge the first
half into drm-next soon, but I'd like to get it all landed.

The main changes since v4, is I did an AI review of the patchset and it fin=
d a bug=20
with the reclaim codepaths when no memcg was around, and a bug in the diff =
calcs
for accounted pages I introduced.

Christian, I think you said patch 4 got lost last time, hopefully you get i=
t this time.

Patches still needing ack/review:
ttm/pool: drop numa specific pools
ttm/pool: track allocated_pages per numa node.
ttm: add objcg pointer to bo and tt (v2)
ttm/pool: enable memcg tracking and shrinker. (v2)
amdgpu: add support for memory cgroups

Differences since v1 posting:
1. added ttm_bo_set_cgroup wrapper - the cgroup reference is passed to the =
ttm object.
2. put the cgroup reference in ttm object release
3. rebase onto 6.19-rc1
4. added xe support patch from Maarten.

Differences since v2 posting:
1. Squashed exports into where they are used (Shakeel)
2. Fixed bug in uncharge path memcg
3. Fixed config bug in the module option.

Differences since 1st posting:
1. Added patch 18: add a module option to allow pooled pages to not be stor=
ed in the lru per-memcg
   (Requested by Christian Konig)
2. Converged the naming and stats between vmstat and memcg (Suggested by Sh=
akeel Butt)
3. Cleaned up the charge/uncharge code and some other bits.

Dave.

Original cover letter:
tl;dr: start using list_lru/numa/memcg in GPU driver core and amdgpu driver=
 for now.

This is a complete series of patches, some of which have been sent before a=
nd reviewed,
but I want to get the complete picture for others, and try to figure out ho=
w best to land this.

There are 3 pieces to this:
01->02: add support for global gpu stat counters (previously posted, patch =
2 is newer)
03->06: port ttm pools to list_lru for numa awareness
07->13: add memcg stats + gpu apis, then port ttm pools to memcg aware list=
_lru and shrinker
14: enable amdgpu to use new functionality.
15: add a module option to turn it all off.

The biggest difference in the memcg code from previously is I discovered wh=
at
obj cgroups were designed for and I'm reusing the page/objcg intergration t=
hat=20
already exists, to avoid reinventing that wheel right now.

There are some igt-gpu-tools tests I've written at:
https://gitlab.freedesktop.org/airlied/igt-gpu-tools/-/tree/amdgpu-cgroups?=
ref_type=3Dheads

One problem is there are a lot of delayed action, that probably means the t=
esting
needs a bit more robustness, but the tests validate all the basic paths.

Regards,
Dave.



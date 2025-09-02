Return-Path: <cgroups+bounces-9587-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BABB3F371
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806701883BF7
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF252E0928;
	Tue,  2 Sep 2025 04:10:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (unknown [170.10.129.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C841804A
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786246; cv=none; b=sX917DxpmmgROqCHWNEry8TXjfZTp57P6a0zVPlpiJUPjjl3iD1TzTh0GoO6JNkN4yz2L9yA+vPT0tlik3JzlqtBTNz8wi4JOq3urTC9gF2t5JTpxID616+u4VhQS0slDdFMXt8jxC2B/17n7wbUTtK7RxV0angLX0qqp09NVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786246; c=relaxed/simple;
	bh=aY/iZzpha6c2yW0t8qb0apTLMjgHOrIVexdTtN8DXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=QaVM/z4+dzi/XeQbXmbYPJG2B5hUeeff19cqnOQGtMbXVUVS9YE9xY6golORpAvfbVjBiZYOBMYSzj2U39uRtIa2YIDaioTrUQxjo1ZAQN8ebRfgltGF5ZAPBdGPI98PR2p/d0AWoU32Ivlpyou1ojwrVCjia9/RsoHHGi4UWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=170.10.129.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-QPmzPKF-OGCM-lljXlI0oQ-1; Tue,
 02 Sep 2025 00:10:38 -0400
X-MC-Unique: QPmzPKF-OGCM-lljXlI0oQ-1
X-Mimecast-MFC-AGG-ID: QPmzPKF-OGCM-lljXlI0oQ_1756786237
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7878180034A;
	Tue,  2 Sep 2025 04:10:36 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AAD030001A2;
	Tue,  2 Sep 2025 04:10:28 +0000 (UTC)
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
Subject: drm/ttm/memcg/lru: enable memcg tracking for ttm and amdgpu driver (complete series v3)
Date: Tue,  2 Sep 2025 14:06:39 +1000
Message-ID: <20250902041024.2040450-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2EcR0cR6EB90dbsxB6FHZp2Is926AcZizxHQrGEEgYg_1756786237
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

Hi all,

This is a repost with some fixes and cleanups.

I'd really like to land this into drm-next, Maarten posted xe support for t=
his and some other work
and I think we need to start moving this forward in tree as I'm not sure wh=
at else I can really do
out of tree.

Differences since last posting:
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



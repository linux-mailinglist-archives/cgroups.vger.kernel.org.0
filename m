Return-Path: <cgroups+bounces-7983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0EAA697F
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 05:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0989C11CC
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594E1946BC;
	Fri,  2 May 2025 03:43:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707A4400
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157384; cv=none; b=sZfxrJ0T59eESYWkvI0F0gj/kpnACRNZDOXr9DAWhBnR5yB89aMbFjNS6MVjB3eqxvyPNsUWrAlW30wp1S5rJAn3zNS1/IxevDuRbLRFefWr6fy2wokRXdsuEvVH+8LwngFFwxX6NLaSvcewfgCyNVDmtcpLXjiNRYv5ZIkJLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157384; c=relaxed/simple;
	bh=usFCTLT5QNyQGaAI3w2aMYZohJ5JSHXXl3Dc9WJZSsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=FBOakYhx7TGuq+qWwfAbLdcxZGhq0NzGJlGtyKlGLtQJv10uzzJM0xlg1/tV2UutSkEXTHe6pOam1MOlo/GCbgJnBe1ZzUvS5R51oNjDKDVik5JeXb1ZKVt4OPy/+E6+aOwS3gWZZDc6fUGI99wBnhVqeVBCK3FXcdW/B/ZFm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-oNMIEx3FPpGL0YQNr-jFIg-1; Thu,
 01 May 2025 23:41:11 -0400
X-MC-Unique: oNMIEx3FPpGL0YQNr-jFIg-1
X-Mimecast-MFC-AGG-ID: oNMIEx3FPpGL0YQNr-jFIg_1746157265
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24B8D180036D;
	Fri,  2 May 2025 03:41:03 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB73F1800115;
	Fri,  2 May 2025 03:40:55 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Date: Fri,  2 May 2025 13:35:59 +1000
Message-ID: <20250502034046.1625896-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y8eJmL4-ZgzgcJQ9-VHdyFROPHpS3vd1aDlFQRYBgoo_1746157265
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

Hey all,

This is my second attempt at adding the initial simple memcg/ttm
integration.

This varies from the first attempt in two major ways:

1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
for pool memory, and directly hitting the GPU statistic, Waiman
suggested I just do what the network socket stuff did, which looks
simpler. So this adds two new memcg apis that wrap accounting.
The pages no longer get assigned the memcg, it's owned by the
larger BO object which makes more sense.

2. Christian suggested moving it up a layer to avoid the pool business,
this was a bit tricky, since I want the gfp flags, but I think it only
needs some of them and it should work. One other big difference is that
I aligned it with the dmem interaction, where it tries to get space in
the memcg before it has even allocated any pages, I'm not 100% sure
this is how things should be done, but it was easier, so please let=20
me know if it is wrong.

This still doesn't do anything with evictions except ignore them,
and I've some follows up on the old thread to discuss more on them.

Dave.


